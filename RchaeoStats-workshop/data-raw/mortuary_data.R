library(tidyverse)
library(readxl)
library(here)
#download.file(
#  url = "https://edu.nl/x4bqv",
#  destfile = "data-raw/mortuary-data.xlsx",
#  mode = "wb"
#)

raw_data <- read_xlsx(here("data-raw/mortuary-data.xlsx"))

# produce scatter plot of Height and Width and colour by Phase

# data |>
# ggplot(aes(mappings)) +
# geom_point()

raw_data |>
  ggplot(aes(x = Width, y = Hight, col = Phase)) +
    geom_point()

names(raw_data) # check column names

str(raw_data)
raw_data$Width

renamed_data <- raw_data |>
  rename(
    Height = Hight,
    IndoPacific_bead = `Indo-Pacific_bead`
  )

renamed_data$Width # show the Width column as vector
renamed_data["Width"] # show the Width column as data frame
renamed_data[["Width"]] # show the Width column as vector
renamed_data[, 6] # show the sixth column as dataframe
renamed_data[1, 6] # # show the first row and sixth column as data frame

# Data types

num_char <- c(1, 2, 3, "a") # character
num_logical <- c(1, 2, 3, TRUE) # numeric; TRUE -> 1; FALSE -> 0
char_logical <- c("a", "b", "c", TRUE) # character
tricky <- c(1, 2, 3, "4") # character
c(1,2,3,-4)
as.numeric(tricky)

# logical > numeric > character
renamed_data$IndoPacific_bead
renamed_data$Glass_bead

renamed_data |>
  mutate(
    Glass_bead = if_else(condition = Glass_bead == "shatter", true = NA, false = Glass_bead)
  )

renamed_data$Glass_bead == "shatter"

renamed_data$IndoPacific_bead

renamed_data |>
  mutate(
    IndoPacific_bead = case_when(
      IndoPacific_bead == "cluster" ~ NA,
      IndoPacific_bead == "unsure number" ~ NA,
      .default = IndoPacific_bead
    )
  )

renamed_data$Width
renamed_data$Length

renamed_data |>
  mutate(
    Width = str_remove(Width, "\\+"), # same
    Length = str_remove(Length, fixed("+")) # same 
  )


data_clean <- raw_data |>
  rename(
    Height = Hight,
    IndoPacific_bead = `Indo-Pacific_bead`
  ) |>
  mutate(
    Glass_bead = if_else(Glass_bead == "shatter", NA, Glass_bead)
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
  mutate(across(c(Glass_bead, IndoPacific_bead, Width, Length), as.numeric))
view(data_clean)

data_clean |>
  ggplot(aes(x = Width, y = Height, col = Phase)) +
  geom_point()

write_csv(data_clean, here("data/mortuary_clean.csv"))

