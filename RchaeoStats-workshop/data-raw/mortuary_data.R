library(tidyverse)
library(readxl)

#download.file(
#  url = "https://edu.nl/x4bqv",
#  destfile = "data-raw/mortuary-data.xlsx",
#  mode = "wb"
#)

raw_data <- read_xlsx("data-raw/mortuary-data.xlsx")

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

