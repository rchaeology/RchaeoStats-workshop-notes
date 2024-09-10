library(tidyverse)
library(here)

mortuary_data <- read_csv(here("data/mortuary_clean.csv"))

## subsetting data

# subsetting columns
select(mortuary_data, Golden_bead)
select(mortuary_data, Golden_bead, Glass_bead)
# select by position
select(mortuary_data, c(22,23))
select(mortuary_data, c(22:30))
select(mortuary_data, Golden_bead:Bell)

## rows

filter(mortuary_data, Phase == "pre")
filter(mortuary_data, Height == 13) # numeric
filter(mortuary_data, Height >= 20 | Height < 10)
filter(mortuary_data, Height < 20 & Height > 10)

as.data.frame(mortuary_data)

select(filter(mortuary_data, Phase == "pre"), ID, Golden_bead, Small_Metal_ring)

# Groups

class(group_by(mortuary_data, Phase))

summarise(
  mortuary_data,
  n = n(),
  mean_golden = mean(Golden_bead, na.rm = T),
  median_golden = median(Golden_bead, na.rm = T),
  sd_golden = sd(Golden_bead, na.rm = T),
  .by = Phase
) # NaN = not a number

count(mortuary_data, Phase) # count each level of Phase

mortuary_data |>
  group_by(Phase) |>
  summarise(
    across(
      c(Golden_bead, Glass_bead, IndoPacific_bead),
      ~ mean(.x, na.rm = T)
    )
  )

mortuary_data |>
  group_by(Phase) |>
  summarise(
    across(
      Agate_bead:Metal_piece,
      ~ mean(.x, na.rm = T)
    )
  )

# selection helpers

mortuary_data |>
  group_by(Phase) |>
  summarise(
    across(
      contains("bead"),
      ~ mean(.x, na.rm = T)
    )
  )

mortuary_data |>
  group_by(Phase) |>
  summarise(
    across(
      ends_with("bead"),
      ~ mean(.x, na.rm = T)
    )
  )

mortuary_data |>
  select(ends_with("bead"))



