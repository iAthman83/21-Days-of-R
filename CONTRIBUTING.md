# Contributing to 21 Days of R

Thank you for helping. Corrections, clearer explanations and new exercises are all welcome.

## Reporting a problem

[Open an issue](https://github.com/iAthman83/21-Days-of-R/issues) and include the day, the section and what went wrong. If an exercise marks a correct answer as wrong, paste the code you ran.

## Making a change

1. Fork the repository and create a branch.
2. Edit the lesson in `lessons/`. Each lesson is a Quarto file (`.qmd`).
3. Run the checks and preview the site (see below).
4. Open a pull request that explains what you changed and why.

## Lesson rules

- Follow the lesson template: Objectives, concept sections, worked examples, Exercises, Your turn, Common mistakes, Summary, Further reading.
- Every lesson has at least 3 graded exercises. Each exercise needs a hint, a solution (in an `r` code block) and a check block.
- Use only concepts from earlier lessons, or name the prerequisite at the top.
- Write in British English, in short, plain sentences.
- Use only openly licensed data. Add new files to `data/` and describe them in `data/README.md`.
- List every package a lesson loads under `webr: packages:` in its YAML header, so it installs in the browser.
- If an example is meant to fail, include the comment `# Error expected` in the code block.

## Checking your work

You need [R](https://cran.r-project.org) and [Quarto](https://quarto.org/docs/get-started/).

```sh
Rscript -e 'install.packages(c("knitr", "rmarkdown", "tidyverse", "palmerpenguins", "gapminder"))'
Rscript tests/check-lessons.R   # runs every example and checks every solution
quarto preview                  # opens the site in your browser
```

Then open the lesson you changed in the preview and run the exercises in the browser.
