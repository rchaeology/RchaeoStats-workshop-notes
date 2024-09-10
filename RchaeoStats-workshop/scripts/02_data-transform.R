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
