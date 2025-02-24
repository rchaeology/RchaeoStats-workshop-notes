library(tidyverse)
library(here)

mortuary_data <- read_csv(here("data/mortuary_clean.csv"))

mortuary_data |>
  ggplot(aes(x = Length, y = Width)) +
    geom_point()


# Categorical variables ---------------------------------------------------

mortuary_data |>
  ggplot(aes(x = Phase)) +
    geom_bar()

mortuary_data |>
  ggplot(aes(x = fct_rev(fct_infreq(Phase)))) +
  geom_bar() +
  coord_flip() +
  labs(x = "Phase")

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


# Continuous variables ----------------------------------------------------

# histogram
mortuary_data |>
  ggplot(aes(x = Length)) +
    geom_histogram()

# picking different bin sizes

mortuary_data |>
  ggplot(aes(x = Length)) +
  geom_histogram(bins = 20)

# density plot
mortuary_data |>
  ggplot(aes(x = Length)) +
  geom_density() +
  geom_vline( # add a line at the mean
    xintercept = mean(mortuary_data$Length, na.rm = TRUE),
    linetype = "dashed"
  )

# plot the levels of Layer
mortuary_data |>
  ggplot(aes(x = Length, fill = as_factor(Layer))) +
    geom_density(alpha = 0.6)

mortuary_data |>
  ggplot(aes(x = Length, fill = Phase)) +
  geom_density() +
  facet_wrap(~ Phase, ncol = 1)

# scatterplots

mortuary_data |>
  ggplot(aes(x = Length, y = Width)) +
    geom_point()

# make it more fun

mortuary_data |>
  ggplot(aes(x = Length, y = Width)) +
  geom_point(col = "#26c3c9")

# size and shape as single values
mortuary_data |>
  ggplot(aes(x = Length, y = Width)) +
  geom_point(aes(col = Phase), size = 3, shape = 2)

# size and shape mapped to variables
mortuary_data |>
  ggplot(aes(x = Length, y = Width)) +
  geom_point(aes(col = Phase, size = Height, shape = as_factor(Layer)))

# Mixed variables

mortuary_data |>
  ggplot(aes(y = Length, x = Phase)) +
    geom_violin(aes(fill = Phase)) +
    geom_boxplot(
      outlier.shape = NA,
      width = 0.2
    ) +
    geom_jitter(
      width = 0.2,
      height = 0.2,
      alpha = 0.4
    ) +
  theme_minimal() +
  theme(legend.position = "none",
        axis.title = element_text(size = 40, colour = "tomato"))

ggsave(here("figures/violin-box-jitter.png"), dpi = 600, width = 5, height = 6, units = "in")
















