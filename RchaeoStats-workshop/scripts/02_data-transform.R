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

mortuary_data |>
  group_by(Phase) |>
  summarise(
    across(
      ends_with("bead"),
      list(
        mean = ~ mean(.x, na.rm = T),
        sd = ~ sd(.x, na.rm = T)
      )
    )
  )

# lists

my_list <- list(
  "a_vector" = mortuary_data$Width,
  "a_data_frame" = mortuary_data,
  "a_function" = mean,
  "etc" = "etc"
)

# access list elements

my_list$a_data_frame$ID

my_list$a_function(mortuary_data$Width, na.rm = T)

## Exercise
# select all columns with a "Metal" artefact,
# calculate mean and sd
# grouped by Phase

mortuary_data |>
  rename(Big_metal_ring = Big_Metal_ring) |>
  group_by(Phase) |>
  summarise(
    across(
      contains("Metal", ignore.case = F),
      list(
        "mean" = ~ mean(.x, na.rm = T),
        "sd" = ~ mean(.x, na.rm = T)
      )
    )
  )

view(mortuary_data)

## Pivotting

golden_long <- mortuary_data |>
  pivot_longer(Golden_bead)

golden_long$Golden_bead # no longer exists

golden_long$name
golden_long$value

artefact_long <- mortuary_data |>
  pivot_longer(
    Agate_bead:Kendi_mouth
  )

#view(artefact_long)


artefact_long <- mortuary_data |>
  pivot_longer(
    Agate_bead:Kendi_mouth,
    names_to = "artefact",
    values_to = "count"
  )

artefact_long$artefact

artefact_long |>
  ggplot(aes(x = artefact, y = count)) +
    geom_col()

artefact_long |>
  filter(artefact != "IndoPacific_bead",
         count > 1, count < 10) |>
  ggplot(aes(x = artefact, y = count)) +
    geom_col()

artefact_long |>
  filter(artefact != "IndoPacific_bead") |>
  ggplot(aes(x = artefact, y = count, fill = Phase)) +
    geom_col()

bead_long <- mortuary_data |>
  pivot_longer(
    Agate_bead:Kendi_mouth,
    names_to = "artefact",
    values_to = "count"
  ) |>
  mutate(
    bead = if_else(str_detect(artefact, "bead"), "bead", "other")
  )

artefact_long |>
  ggplot(aes(x = bead, y = count, fill = Phase)) +
  geom_col(position = "dodge")

#str_detect(artefact_long$artefact, "bead")

artefact_long |>
  ggplot(aes(x = artefact, y = count, fill = Phase)) +
    geom_col()

percent_artefacts <- artefact_long |>
  group_by(Phase, artefact) |>
  summarise(
    n = sum(count, na.rm = T)
  ) |>
  group_by(Phase) |>
  mutate(percent = (n / sum(n)) * 100)

percent_artefacts |>
  ggplot(aes(x = Phase, y = percent, fill = artefact)) +
  geom_col()

artefact_long |>
  ggplot(aes(x = Phase, y = count, fill = Phase)) +
  geom_col() +
  facet_wrap(~ artefact, scales = "free_y")

# the longer format makes it easier to summarise artefacts
artefact_long |>
  summarise(
    count = sum(count, na.rm = T),
    .by = c(artefact, Phase)
  )

artefact_long |>
  group_by(artefact, Gender) |>
  summarise(
    mean = mean(count, na.rm = T),
    median = median(count, na.rm = T),
    sd = sd(count, na.rm = T)
  )

artefact_long |>
  group_by(ID, Phase, Age, Gender) |>
summarise(
  count = sum(count, na.rm = T)
)  

# back to wide

artefact_wide <- artefact_long |>
  pivot_wider(
    names_from = artefact,
    values_from = count
  )

dim(artefact_wide)
dim(artefact_wide) == dim(mortuary_data)


  






  
