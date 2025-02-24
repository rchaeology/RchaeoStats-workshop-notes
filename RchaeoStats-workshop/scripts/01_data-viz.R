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
  
# reorder chronologically  
  
mortuary_data |>
  mutate(Phase = factor(Phase, levels = c("chi", "pre", "euro", "post", "disturbed"))) |>
  ggplot(aes(x = Phase, fill = Phase)) +
  geom_bar()  

# convert explicitly to factor: option 1
mortuary_data |>
  mutate(Condition = as_factor(Condition)) |>
  ggplot(aes(x = Phase, fill = Condition)) +
  geom_bar()
# option 2
mortuary_data |>
  ggplot(aes(x = Phase, fill = as_factor(Condition))) +
  geom_bar()

# side-by-side bar plot (separate column for each level of Condition)
mortuary_data |>
  ggplot(aes(x = Phase, fill = as_factor(Condition))) +
    geom_bar(position = "dodge")

# proportional bar plot
mortuary_data |>
  ggplot(aes(x = Phase, fill = as_factor(Condition))) +
  geom_bar(position = "fill")

# Pie chart
mortuary_data |>
  ggplot(aes(x = "", fill = Phase)) +
    geom_bar(width = 1) +
    coord_polar("y", start = 0) +
    theme_void()












