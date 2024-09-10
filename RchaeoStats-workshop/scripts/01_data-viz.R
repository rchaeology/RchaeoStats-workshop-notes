library(tidyverse)
library(here)

mortuary_data <- read_csv(here("data/mortuary_clean.csv"))

mortuary_data |>
  ggplot(aes(x = Length, y = Width, col = Width > 40)) +
  geom_point()

# Categorical variables
mortuary_data$Phase

mortuary_data |>
  ggplot(aes(x = Phase)) +
  geom_bar(fill = "red")

# factors

levels(mortuary_data$Phase)
as_factor(mortuary_data$Phase)
levels(as_factor(mortuary_data$Phase))
nlevels(as_factor(mortuary_data$Phase))
length(levels(as_factor(mortuary_data$Phase)))

factor(
  mortuary_data$Phase,
  levels = c("chi", "pre", "euro", "post", "disturbed"),
  ordered = TRUE
)

## two cats

# bar chart
mortuary_data |>
  ggplot(aes(x = Phase, fill = Condition)) +
    geom_bar()

mortuary_data$Condition

mortuary_data |>
  mutate(Condition = as_factor(Condition)) |>
  ggplot(aes(x = Phase, fill = Condition)) +
    geom_bar()

# alternative
mortuary_data |>
  ggplot(aes(x = Phase, fill = as_factor(Condition))) +
  geom_bar()
  
mortuary_data |>
  mutate(Condition = as_factor(Condition)) |>
  ggplot(aes(x = Phase, fill = Condition)) +
  geom_bar(position = "dodge")

mortuary_data |>
  mutate(Condition = as_factor(Condition)) |>
  ggplot(aes(x = Phase, fill = Condition)) +
  geom_bar(position = "fill")

mortuary_data |>
  filter(Condition != "disturbed") |>
  remove_missing(vars = "Phase") |>
  mutate(
    Phase = factor(
      Phase,
      levels = c("chi", "pre", "euro", "post", "disturbed"), # order chronologically
      ordered = TRUE
    ),
    Condition = as_factor(Condition)
  ) |>
  ggplot(aes(x = Phase, fill = Condition)) +
  geom_bar(position = "fill")





  
  
  



