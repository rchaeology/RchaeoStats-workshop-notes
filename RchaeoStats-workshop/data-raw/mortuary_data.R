library(tidyverse)
library(here)

xlsx_url <- "https://edu.nl/x4bqv"
#download.file(url = xlsx_url, destfile = "data-raw/mortuary-data.xlsx", mode = "wb")

raw_data <- readxl::read_xlsx(path = here("data-raw/mortuary-data.xlsx"))


raw_data |>
  ggplot(aes(x = Width, y = Hight, col = Phase)) +
    geom_point()

names(raw_data)

# Fix the variable names
renamed_data <- raw_data |>
  rename(
    Height = Hight,
    IndoPacific_bead = `Indo-Pacific_bead` # R does not like hyphens
  )

raw_data$Width
raw_data$Age
raw_data$`Indo-Pacific_bead`

raw_data["Length"]
raw_data[, 6]
raw_data[1, 6]
raw_data[1, ]

# Exercise
num_char <- c(1, 2, 3, "a")
num_logical <- c(1, 2, 3, TRUE)
char_logical <- c("a", "b", "c", TRUE)
tricky <- c(1, 2, 3, "4")
as.numeric(tricky)
# use class() or typeof() to see what the vector type is

# option 1 to modify the variable
renamed_data |>
  mutate(Glass_bead = if_else(
    condition = Glass_bead == "shatter",
    true = NA,
    false = Glass_bead
  )) |> _$Glass_bead

renamed_data$Glass_bead == "shatter"
# option 2 to modify the variable
renamed_data$Glass_bead[renamed_data$Glass_bead == "shatter"] <- NA

renamed_data |>
  mutate(IndoPacific_bead = case_when(
    IndoPacific_bead == "cluster" ~ NA,
    IndoPacific_bead == "unsure number" ~ NA,
    .default = IndoPacific_bead
  ))

renamed_data$Width
str_remove(renamed_data$Width, "\\+")
renamed_data |>
  mutate(
    Width = str_remove(Width, "\\+"),
    Length = str_remove(Length, "\\+")
  )
  
data_clean <- raw_data |>
  rename(
    Height = Hight,
    IndoPacific_bead = `Indo-Pacific_bead`
  ) |>
  mutate(
    Glass_bead = if_else(
      condition = Glass_bead == "shatter",
      true = NA,
      false = Glass_bead
    )
  ) |>
  mutate(
    IndoPacific_bead = case_when(
      IndoPacific_bead == "cluster" ~ NA,
      IndoPacific_bead == "unsure number" ~ NA,
      .default = IndoPacific_bead
    )
  ) |>
  mutate(
    Width = str_remove(Width, "\\+"),
    Length = str_remove(Length, "\\+")
  ) |>
  mutate(
    across(
      .cols = c(Glass_bead, IndoPacific_bead, Width, Length),
      .fns = as.numeric
    )
  )

data_clean |>
  ggplot(aes(x = Width, y = Height, col = Phase)) +
    geom_point()

# Export the cleaned data

write_csv(data_clean, here("data/mortuary_clean.csv"))






  










  