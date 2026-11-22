# 21 Days of R: syllabus (draft for approval)

**Audience:** complete beginners with no programming background, analysts moving from Excel, and students.
**Pace:** one lesson a day, 1.5 to 3 hours each. "Expert" here means able to write tested, packaged, efficient R code. Reaching real fluency takes practice beyond 21 days, and the course says so.
**Every lesson** has at least 3 graded in-browser exercises and one "Your turn" challenge.
**Datasets:** built-in R data, `palmerpenguins`, `gapminder`, and small open CSVs in `data/` (all openly licensed).

---

## Level 1: Beginner (Days 1–5)

| Day | Title | You will be able to… | Needs | Time |
|---|---|---|---|---|
| 1 | Hello, R | Run code in the browser and in RStudio; use R as a calculator; read error messages; get help with `?` | none | 1.5 h |
| 2 | Objects and data types | Create objects with `<-`; tell numeric, character, logical and factor apart; convert between types; handle `NA` | Day 1 | 2 h |
| 3 | Vectors | Build vectors with `c()`, `:`, `seq()`, `rep()`; index by position, name and condition; use vectorised maths and summary functions | Day 2 | 2 h |
| 4 | Data frames and lists | Inspect a data frame (`str`, `head`, `summary`); select rows and columns with `[ ]` and `$`; build and index lists. *Excel bridge: sheets as data frames* | Day 3 | 2.5 h |
| 5 | Functions and reading data | Call functions with named arguments; install and load packages; read a CSV with `read.csv()` and `readr::read_csv()`; save results | Day 4 | 2 h |

## Level 2: Intermediate (Days 6–11)

| Day | Title | You will be able to… | Needs | Time |
|---|---|---|---|---|
| 6 | Data wrangling with dplyr | Use `filter`, `select`, `mutate`, `arrange`, `summarise`, `group_by` and the pipe `|>`. *Excel bridge: filters and pivot tables* | Day 5 | 3 h |
| 7 | Tidy data with tidyr | Reshape with `pivot_longer`/`pivot_wider`; split and combine columns; handle missing values; join tables (`left_join` and others). *Excel bridge: VLOOKUP* | Day 6 | 2.5 h |
| 8 | Visualisation with ggplot2 | Build charts layer by layer: aesthetics, geoms, facets, scales, labels and themes; choose the right chart | Day 6 | 3 h |
| 9 | Control flow | Write `if`/`else`, `ifelse()`, `case_when()`, `for` and `while` loops | Day 3 | 2 h |
| 10 | Writing your own functions | Write functions with arguments, defaults and return values; add checks with `stop()`; understand when to write a function | Day 9 | 2.5 h |
| 11 | Strings, dates and factors | Clean text with stringr; parse and calculate dates with lubridate; reorder and relabel factors with forcats | Day 7 | 2.5 h |

## Level 3: Advanced (Days 12–16)

| Day | Title | You will be able to… | Needs | Time |
|---|---|---|---|---|
| 12 | Iteration with purrr | Replace loops with `map()` and its typed variants; iterate over two inputs with `map2()`/`pmap()`; work with nested data | Days 9, 10 | 2.5 h |
| 13 | Regular expressions | Match, extract and replace patterns; use character classes, quantifiers, anchors and groups for real cleaning tasks | Day 11 | 2 h |
| 14 | Statistical modelling | Fit and interpret `lm()` and `glm()`; check residuals; tidy model output with broom; compare models | Days 6, 8 | 3 h |
| 15 | Reproducible reports with Quarto | Write a Quarto document that mixes text, code and charts; set chunk options; render to HTML. *(Rendering runs locally)* | Day 8 | 2 h |
| 16 | Debugging and defensive code | Read tracebacks; use `browser()`, `tryCatch()`, `warning()`, `message()`; write code that fails loudly and early | Day 10 | 2 h |

## Level 4: Expert (Days 17–21)

| Day | Title | You will be able to… | Needs | Time |
|---|---|---|---|---|
| 17 | Environments and scoping | Explain lexical scoping, environments and closures; write function factories; understand `<<-` and why to avoid it | Day 10 | 2.5 h |
| 18 | Object-oriented R: S3, S4, R6 | Write an S3 class with methods; recognise S4; build a stateful R6 class; know which to use when | Day 17 | 3 h |
| 19 | Performance | Measure with `bench`; vectorise loops; avoid growing objects; use data.table for large data | Days 12, 17 | 2.5 h |
| 20 | Writing an R package | Structure a package; document with roxygen2; write tests with testthat; run `devtools::check()`. *(Build steps run locally)* | Days 10, 16 | 3 h |
| 21 | Capstone project | Take an open dataset from import to a tested function set and a Quarto report, using every level of the course | All | 3+ h |

---

## Lesson template (used for every day)

1. **Objectives**: 3–5 things you will be able to do
2. **Concept**: short explanation, with an Excel comparison where useful
3. **Worked examples**: runnable code you can edit
4. **Exercises**: at least 3 graded webR exercises with hints and solutions
5. **Your turn**: an open challenge
6. **Common mistakes**
7. **Summary**
8. **Further reading**: free sources only (R for Data Science, Advanced R, R Packages)

---

## About the author

The author bio lives in [`about.qmd`](../about.qmd), so there is only one copy to keep up to date.
