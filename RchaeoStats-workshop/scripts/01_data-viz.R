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


# continuous variables
# histogram
mortuary_data |>
  ggplot(aes(x = Length)) +
    geom_histogram()

mortuary_data |>
  ggplot(aes(x = Length)) +
  geom_histogram(bins = 10) # number of bins

mortuary_data |>
  ggplot(aes(x = Length)) +
  geom_histogram(bins = 40)

# density plot
mortuary_data |>
  ggplot(aes(x = Length)) +
    geom_density()

# show mean of Length
mortuary_data |>
  ggplot(aes(x = Length)) +
  geom_density() +
  geom_vline(xintercept = mean(mortuary_data$Length, na.rm = T), linetype = "dotted")

mean(mortuary_data$Length, na.rm = T)

# density within groups

mortuary_data |>
  ggplot(aes(x = Length, fill = as_factor(Condition))) +
    geom_density(alpha = 0.6)

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
  ggplot(aes(x = Length, fill = Phase)) +
    geom_density() +
    facet_wrap(~ Phase, ncol = 1)

# two continuous variables

mortuary_data |>
  ggplot(aes(x = Length, y = Width)) +
  geom_point(colour = "red", size = 4, shape = 2)

mortuary_data |>
  ggplot(aes(x = Length, y = Width)) +
  geom_point(aes(colour = as_factor(Condition), size = Width, shape = Phase))

# mixed continuous and categorical

phase_height_plot <- mortuary_data |>
  remove_missing(vars = "Phase") |>
  ggplot(aes(x = Phase, y = Height)) +
    geom_violin(aes(fill = Phase)) +
    geom_boxplot(width = 0.2) +
    geom_jitter(
      width = 0.2,
      height = 0.2,
      alpha = 0.6
    ) +
    theme_bw() +
    theme(
      legend.position = "none",
      panel.grid.major.x = element_blank(),
      axis.ticks = element_blank()
      ) #+ theme_void() # remove all plot aspects

ggsave(here("figures/phase-height-boxplot.png"), plot = phase_height_plot)

my_theme <- theme(axis.title = element_text(size = 32))

mortuary_data |>
  ggplot(aes(x = Length)) +
  geom_histogram() +
  my_theme



















  
  



