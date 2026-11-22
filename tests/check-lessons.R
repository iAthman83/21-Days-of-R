# Check every lesson in lessons/ outside the browser.
#
# For each lesson this script:
#   1. runs every plain {webr} example block, in order, in one environment
#      (a block may only fail if it contains the comment "# Error expected");
#   2. for every exercise, runs its setup blocks and its first solution,
#      then runs the exercise's check block and requires correct = TRUE;
#   3. confirms each exercise has a hint, a solution and a check;
#   4. confirms every package loaded with library() is listed under
#      `webr: packages:` in the lesson's YAML header (so webR installs it).
#
# Run from the repository root:  Rscript tests/check-lessons.R

parse_lesson <- function(path) {
  lines <- readLines(path, warn = FALSE)
  blocks <- list()
  solutions <- list()
  hints <- character()
  i <- 1
  while (i <= length(lines)) {
    line <- lines[i]
    if (grepl("^```\\{webr\\}", line)) {
      j <- i + 1
      while (!grepl("^```\\s*$", lines[j])) j <- j + 1
      body <- lines[seq_len(j - i - 1) + i]
      opt_lines <- body[grepl("^#\\|", body)]
      code <- body[!grepl("^#\\|", body)]
      opts <- list()
      k <- 1
      while (k <= length(opt_lines)) {
        m <- regmatches(opt_lines[k], regexec("^#\\|\\s*([a-z-]+):\\s*(.*)$", opt_lines[k]))[[1]]
        if (length(m) == 3) {
          val <- trimws(m[3])
          if (val == "") {
            vals <- character()
            while (k + 1 <= length(opt_lines) && grepl("^#\\|\\s+-", opt_lines[k + 1])) {
              k <- k + 1
              vals <- c(vals, trimws(sub("^#\\|\\s+-", "", opt_lines[k])))
            }
            val <- vals
          }
          opts[[m[2]]] <- val
        }
        k <- k + 1
      }
      blocks[[length(blocks) + 1]] <- list(opts = opts, code = code, line = i)
      i <- j
    } else if (grepl('^:::\\s*\\{\\s*\\.solution\\s+exercise="([^"]+)"', line)) {
      ex <- sub('.*exercise="([^"]+)".*', "\\1", line)
      j <- i + 1
      while (!grepl("^```r\\s*$", lines[j])) j <- j + 1
      k <- j + 1
      while (!grepl("^```\\s*$", lines[k])) k <- k + 1
      if (is.null(solutions[[ex]])) solutions[[ex]] <- lines[seq_len(k - j - 1) + j]
      i <- k
    } else if (grepl('^:::\\s*\\{\\s*\\.hint\\s+exercise="([^"]+)"', line)) {
      hints <- c(hints, sub('.*exercise="([^"]+)".*', "\\1", line))
    }
    i <- i + 1
  }
  list(lines = lines, blocks = blocks, solutions = solutions, hints = unique(hints))
}

yaml_packages <- function(lines) {
  end <- which(lines == "---")[2]
  head <- lines[seq_len(end)]
  start <- grep("^\\s+packages:", head)
  if (!length(start)) return(character())
  pkgs <- character()
  k <- start + 1
  while (k <= length(head) && grepl("^\\s+-\\s", head[k])) {
    pkgs <- c(pkgs, trimws(sub("^\\s+-\\s", "", head[k])))
    k <- k + 1
  }
  pkgs
}

# Evaluate code and return the value of the last top-level expression,
# which is what Quarto Live passes to a check block as `.result`.
eval_last <- function(code, envir) {
  exprs <- parse(text = code)
  value <- NULL
  for (e in exprs) value <- withVisible(eval(e, envir))$value
  value
}

check_lesson <- function(path) {
  cat("\n==", basename(path), "\n")
  p <- parse_lesson(path)
  failures <- character()
  fail <- function(msg) failures <<- c(failures, msg)

  # 4. packages
  used <- unique(unlist(regmatches(p$lines, gregexpr("(?<=library\\()[A-Za-z0-9.]+", p$lines, perl = TRUE))))
  missing_pkgs <- setdiff(used, yaml_packages(p$lines))
  if (length(missing_pkgs)) fail(paste("library() not listed in webr packages:", paste(missing_pkgs, collapse = ", ")))

  # 1. plain examples
  global <- new.env(parent = globalenv())
  n_examples <- 0
  for (b in p$blocks) {
    if (!is.null(b$opts$exercise)) next
    n_examples <- n_examples + 1
    expect_error <- any(grepl("# Error expected", b$code, fixed = TRUE))
    code <- b$code[!grepl("^\\s*\\?", b$code)] # skip help lookups
    res <- tryCatch({
      utils::capture.output(eval_last(code, global))
      "ok"
    }, error = function(e) conditionMessage(e))
    if (res != "ok" && !expect_error) fail(sprintf("example at line %d failed: %s", b$line, res))
    if (res == "ok" && expect_error) fail(sprintf("example at line %d was expected to fail but ran", b$line))
  }

  # 2-3. exercises
  ex_blocks <- Filter(function(b) !is.null(b$opts$exercise), p$blocks)
  labels <- unique(unlist(lapply(ex_blocks, function(b) {
    if (is.null(b$opts$setup) && is.null(b$opts$check)) b$opts$exercise
  })))
  shared <- list()
  for (ex in labels) {
    setup <- Filter(function(b) identical(b$opts$setup, "true") && ex %in% b$opts$exercise, ex_blocks)
    check <- Filter(function(b) identical(b$opts$check, "true") && ex %in% b$opts$exercise, ex_blocks)
    main  <- Filter(function(b) is.null(b$opts$setup) && is.null(b$opts$check) && identical(b$opts$exercise, ex), ex_blocks)[[1]]
    if (!length(check)) { fail(paste(ex, "has no check block")); next }
    if (!ex %in% p$hints) fail(paste(ex, "has no hint"))
    sol <- p$solutions[[ex]]
    if (is.null(sol)) { fail(paste(ex, "has no solution")); next }

    envir_label <- main$opts$envir
    env <- if (!is.null(envir_label)) {
      if (is.null(shared[[envir_label]])) shared[[envir_label]] <- new.env(parent = global)
      shared[[envir_label]]
    } else new.env(parent = global)

    res <- tryCatch({
      for (s in setup) eval_last(s$code, env)
      utils::capture.output(result <- eval_last(sol, env))
      check_env <- new.env(parent = env)
      check_env$.result <- result
      out <- eval_last(check[[1]]$code, check_env)
      if (isTRUE(out$correct)) "ok" else paste("check returned correct = FALSE:", out$message)
    }, error = function(e) paste("error:", conditionMessage(e)))
    if (res != "ok") fail(sprintf("%s: %s", ex, res))
  }

  cat(sprintf("   %d examples, %d exercises\n", n_examples, length(labels)))
  if (length(labels) < 3) fail(sprintf("only %d exercises (minimum is 3)", length(labels)))
  if (length(failures)) cat(paste0("   FAIL ", failures, "\n"), sep = "") else cat("   all checks passed\n")
  length(failures) == 0
}

files <- normalizePath(sort(Sys.glob("lessons/day-*.qmd")))

# Run lessons in a temporary folder with a copy of data/, matching the
# browser, where data files sit in data/ below the working directory.
# Files that examples write (for example write_csv()) then stay out of the repo.
work <- tempfile("lessons-")
dir.create(work)
file.copy("data", work, recursive = TRUE)
old_wd <- setwd(work)
results <- vapply(files, check_lesson, logical(1))
setwd(old_wd)
cat(sprintf("\n%d of %d lessons passed\n", sum(results), length(results)))
if (!all(results)) quit(status = 1)
