library(tidyverse)
library(here)

mortuary_data <- read_csv(here("data/mortuary_clean.csv"))

mortuary_data |>
  ggplot(aes(x = Length, y = Width)) +
    geom_point()

mortuary_data |>
  ggplot(aes(x = Phase)) +
    geom_bar()

# Factors
levels(mortuary_data$Phase)
phase_factor <- as_factor(mortuary_data$Phase)
levels(phase_factor) # level names
nlevels(phase_factor) # number of levels
length(levels(phase_factor)) # same as nlevels()

factor(
  phase_factor,
  levels = c("chi", "pre", "euro", "post", "disturbed"),
  ordered = TRUE
)

mortuary_data |>
  ggplot(aes(x = Phase, colour = Condition)) +
    geom_bar()
  
mortuary_data |>
  mutate(Condition = as_factor(Condition)) |>
  ggplot(aes(x = Phase, colour = Condition)) +
    geom_bar()
  
  
  