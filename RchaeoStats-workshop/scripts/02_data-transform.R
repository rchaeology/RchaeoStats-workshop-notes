library(tidyverse)
library(here)

mortuary_data <- read_csv(here("data/mortuary_clean.csv"))


# Subsetting data ---------------------------------------------------------

# select and filter

select(mortuary_data, Golden_bead) # select by column name
select(mortuary_data, Golden_bead, Glass_bead) # multiple colunms
select(mortuary_data, 22, 23) # position

filter(mortuary_data, Phase == "pre") # filter the rows where Phase is 'pre'
filter(mortuary_data, start_layer == 5)
filter(mortuary_data, start_layer != 5)
filter(mortuary_data, start_layer > 5) 
filter(mortuary_data, start_layer > 5 & start_layer <= 12)
filter(mortuary_data, start_layer > 5 & Layer == 1)
filter(mortuary_data, start_layer > 5 | start_layer < 12)
filter(mortuary_data, is.na(start_layer)) # filter the rows where Phase is missing (NA)
filter(mortuary_data, !is.na(start_layer)) # filter the rows where Phase is missing (NA)

select(filter(mortuary_data, Phase == "pre"), Phase)
# nested functions
select(filter(mortuary_data, Phase == "pre"), ID, Golden_bead, Glass_bead)
# or create intermediate objects
pre_euro <-filter(mortuary_data, Phase == "pre")
select(pre_euro, Golden_bead, Glass_bead)  

pre_condition <- filter(mortuary_data, Phase == "pre", Condition == 2)
mean(pre_condition$Golden_bead, na.rm = TRUE)
  
  

# Groups ------------------------------------------------------------------


group_by(.data = mortuary_data, Phase)
class(group_by(.data = mortuary_data, Phase))

summarise(
  mortuary_data,
  mean_golden = mean(Golden_bead, na.rm = TRUE),
  median_golden = median(Golden_bead, na.rm = TRUE),
  sd_golden = sd(Golden_bead, na.rm = TRUE)
)

mortuary_data |>
  group_by(Phase) |>
  summarise(
    mean_golden = mean(Golden_bead, na.rm = TRUE),
    median_golden = median(Golden_bead, na.rm = TRUE),
    sd_golden = sd(Golden_bead, na.rm = TRUE)
  )
  
summarise(
  mortuary_data,
  mean_golden = mean(Golden_bead, na.rm = TRUE),
  median_golden = median(Golden_bead, na.rm = TRUE),
  sd_golden = sd(Golden_bead, na.rm = TRUE),
  .by = Phase
) 

# sample/group size
mortuary_data |>
  group_by(Phase) |>
  summarise(n = n())

mortuary_data |>
  count(Phase)


# Across ------------------------------------------------------------------

mortuary_data |>
  group_by(Phase) |>
  summarise(
    across(c(Golden_bead, Glass_bead, IndoPacific_bead), ~ mean(.x, na.rm = T))
  )
  
  
