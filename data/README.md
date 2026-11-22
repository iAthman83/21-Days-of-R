# Course data

| File | Description | Source and licence |
|---|---|---|
| `district-info.csv` | 4 rows: district, region and distance to the nearest market. Kasese has no households in the survey, and Hoima is missing from this file, so joins show unmatched rows. Used from Day 7. | Regions are real. **Distances are synthetic**, made up for this course. CC0 1.0 (public domain). |
| `household-survey.csv` | 40 rows of household survey data: district, interview date, household size, monthly income (3 values missing), water access and main crop. Used from Day 5. | **Synthetic.** Generated for this course with a fixed random seed. It does not describe real people or real conditions in these districts. CC0 1.0 (public domain). |

Other lessons use datasets that ship with R packages:

| Dataset | Package | Licence |
|---|---|---|
| `penguins` | [palmerpenguins](https://allisonhorst.github.io/palmerpenguins/) | CC0 1.0 |
| `gapminder` | [gapminder](https://github.com/jennybc/gapminder) | CC BY 3.0 (Gapminder Foundation) |
| `mtcars`, `airquality` and others | base R `datasets` | Part of R (GPL-2 or later) |
