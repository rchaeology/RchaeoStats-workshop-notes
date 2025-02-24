library(tidyverse)
library(here)

mortuary_data <- read_csv(here("data/mortuary_clean.csv"))

mortuary_data |>
  ggplot(aes(x = Length, y = Width)) +
    geom_point()

mortuary_data |>
  ggplot(aes(x = Phase)) +
    geom_bar()