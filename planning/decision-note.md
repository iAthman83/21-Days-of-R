# Tool decision note

*Checked 22 November 2026.*

## Decision

The course will be a **Quarto website**. Its exercises will run in the browser through **Quarto Live (webR)** and be published to GitHub Pages by a GitHub Actions workflow. A swirl track will **not** be part of the first release.

## Options compared

| Tool | Runs on GitHub Pages? | Current status | Verdict |
|---|---|---|---|
| **Quarto Live** (`r-wasm/quarto-live`) | Yes: static files, R runs in the learner's browser | v0.2.0 (May 2026), actively maintained by Posit | **Primary track** |
| **webR** (engine behind Quarto Live) | Yes | v0.6.1 (10 Nov 2026), R 4.6 package repo has about 24,600 packages | Used through Quarto Live |
| **learnr** | No: needs a running Shiny server (shinyapps.io, Posit Connect) | Maintained (last push Nov 2025) | Rejected: hosting cost, and it cannot live on Pages |
| **swirl** | No: runs only in a local R console | Last code change Oct 2023 | Optional, later |
| **quarto-webr** (community) | Yes | Last release v0.4.2 (June 2024); its own README points to Quarto Live | Rejected in favour of the official extension |

## Why Quarto Live

- **No installation for learners.** Day 1 works in a browser tab, which matters for complete beginners and for Excel users who cannot install software on a work laptop.
- **Graded exercises.** Quarto Live supports exercise blocks with hints, solutions and custom checks, so learners get feedback as they work.
- **Every package the syllabus needs is available in webR**, including dplyr, tidyr, ggplot2, readr, purrr, stringr, lubridate, forcats, palmerpenguins, gapminder, data.table, R6, testthat, bench and broom. I checked each one against the R 4.6 webR repository.
- **Free hosting** on GitHub Pages. The same `.qmd` source files can be read on GitHub.

## Limits, and how the course handles them

- **The first page load is slow** (webR downloads about 30 MB, and packages load on demand). Each lesson loads only the packages it uses, and a loading message tells the learner to wait.
- **No real file system or RStudio.** Day 1 (setup), Day 15 (Quarto reports) and Day 20 (packages) contain steps that must run locally. Those sections are marked clearly as "Run this on your own computer", with expected output shown as static code.
- **Package building** (`devtools::check()`) does not run in webR. Day 20 teaches the structure in the browser and the build locally.

## Why not swirl now

swirl has not changed since 2023, and a second course format would double the work of writing and maintaining every lesson. Once the web course is stable, the same exercises could be exported to a swirl course if learners ask for an offline console version.

## Local tooling needed to build the site

R 4.6.1 is installed. **Quarto is not installed**, and the tidyverse, rmarkdown and the lesson packages are missing. Both are needed to render and test the site locally.
