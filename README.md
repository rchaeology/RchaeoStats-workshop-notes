# [Name of workshop]

R workshop at [Location], [Date].

The workshop materials are still under development and are not yet available.
The scripts, data, and Quarto document created during the workshop 
can be found below.


## Data

The datasets used in the workshop are slightly modified versions of published data (see [below](#license)).

Here are the shortened urls linking to the modified data:

- *sheep-data.csv*: <https://edu.nl/>
- *mortuary-data.xlsx*: <https://edu.nl/>


## Repository organisation

[mortuary-data.xlsx](/mortuary-data.xlsx)

[sheep-data.csv](/sheep-data.csv)

[example-workflow.R](./example-workflow.R)

[RchaeoStats-workshop]/

- :file_folder: data/
- :file_folder: data-raw/
  + [:page_facing_up: mortuary_data.R](/RchaeoStats-workshop/data-raw/mortuary_data.R)
  + [:page_facing_up: sheep_data.R]
- :file_folder: docs/
  + [:page_facing_up: manuscript.qmd](/RchaeoStats-workshop/docs/manuscript.qmd)
- :file_folder: figures/
- :file_folder: scripts/
  + [:page_facing_up: 01_data-clean.R](/RchaeoStats-workshop/scripts/01_data-cleaning.R)
  + [:page_facing_up: 02_data-viz.R](/RchaeoStats-workshop/scripts/02_data-viz.R)
  + [:page_facing_up: 03_data-transform.R](/RchaeoStats-workshop/scripts/03_data-transform.R)


## License

The data in *mortuary-data.xlsx* are from Li-Ying Wang and Ben Marwick (2021; https://doi.org/10.17605/OSF.IO/XGA6N)
and are licensed under [CC BY Attribution 4.0 International](https://creativecommons.org/licenses/by/4.0/).

The data in *sheep-data.csv* are from Harding et al. (2022; https://doi.org/10.1101/2022.12.24.521859; https://zenodo.org/doi/10.5281/zenodo.10276146)
and are licensed under [CC BY Attribution 4.0 International](https://creativecommons.org/licenses/by/4.0/).

The code is licensed under [The Unlicense](https://unlicense.org/) (public domain).


## Resources

Rchaeology community [website](https://rchaeology.github.io)

R for Data Science [book](https://r4ds.hadley.nz/)

Data Carpentry [workshop materials](https://datacarpentry.org/r-socialsci/)

Quarto [website](https://quarto.org/)
