library(tidyverse)
library(broom)
library(here)

mortuary_data <- readr::read_csv(here("data/mortuary_clean.csv"))
total_artefacts <- readr::read_csv(here("data/total-artefact-counts.csv"))

# Formulas

class(Length ~ Width)


# Linear regression -------------------------------------------------------

lreg <- lm(Length ~ Width, mortuary_data)

typeof(lreg)
class(lreg)

# it's a list, so we can index it as such
lreg$coefficients
lreg[1]
lreg[[1]]
lreg$model

summary(lreg)
tidy(lreg)
augment(lreg)


# Model evaluation

# Assess whether our residuals are normally distributed (assumption of linear regression)
lreg |>
  augment() |>
  ggplot(aes(x = .resid)) +
    geom_density()

lreg |>
  augment() |>
  ggplot(aes(sample = .resid)) +
  stat_qq() +
  stat_qq_line(col = "blue")

# do the residuals have constant variance (heteroscedasticity)

lreg |>
  augment() |>
  ggplot(aes(x = .fitted, y = .resid)) +
    geom_point() +
    geom_hline(yintercept = 0) +
    geom_smooth(se = FALSE)

mortuary_data |>
  ggplot(aes(x = Width, y = Length)) +
    geom_point() +
    geom_smooth(method = "lm") +
    theme_minimal()


mortuary_data$Gender

mortuary_sex <- mortuary_data |>
  mutate(
    Sex = case_match(
      Gender,
      1 ~ "Male",
      2 ~ "Probable Male",
      3 ~ "Female",
      4 ~ "Probable Female"
    ),
    Sex_bin = if_else(
      Gender > 2, "Female", "Male"
    )
  )

# alternative option

mortuary_sex <- mortuary_data |>
  mutate(
    Sex = case_match(
      Gender,
      1 ~ "Male",
      2 ~ "Probable Male",
      3 ~ "Female",
      4 ~ "Probable Female"
    ),
    Sex_bin = if_else(
      str_detect(Sex, "Female"), "Female", "Male"
    ),
    Sex_dummy = if_else(Sex == "Female", 1, 0)
  )

# association between Length of graves of male and female skeletons

mortuary_sex |>
  remove_missing(vars = "Sex_bin") |>
  ggplot(aes(x = Sex_dummy, y = Length)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE)

lreg_sex <- lm(Length ~ Sex_bin, mortuary_sex)
summary(lreg_sex)

# table of means

mortuary_sex |>
  filter(!is.na(Sex_bin)) |>
  group_by(Sex_bin) |>
  summarise(mean = mean(Length, na.rm = T))

# T test

t.test(formula = Length ~ Sex_bin, data = mortuary_sex, var.equal = TRUE)

male <- filter(mortuary_sex, Sex_bin == "Male")
female <- filter(mortuary_sex, Sex_bin == "Female")
t.test(male$Length, female$Length, var.equal = TRUE)




