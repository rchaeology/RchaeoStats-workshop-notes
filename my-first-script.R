library(tidyverse)
sheep_data <- read_csv("https://edu.nl/3hru6")

head(sheep_data)

ggplot(data = sheep_data, mapping = aes(x = GLl, y = Bd)) +
  geom_point(aes(col = Zone, shape = Period), size = 2) +
  geom_smooth(method = "lm", col = "black") +
  scale_colour_viridis_d(end = 0.8) +
  theme_minimal() +
  labs(x = "Greatest lateral length (mm)", y = "Breadth of the distal end (mm)")

# Data transformation

# transforming rows
filter(sheep_data, Site == "KSN") # filter all rows from the KSN site

filter(sheep_data, Site == "KSN" | Site == "ABM") # filter all rows from the KSN site or ABM site

filter(sheep_data, Site != "DOR")

sheep_data$Site != "DOR"

filtered_site <- filter(sheep_data, Site != "DOR")

arrange(filtered_site, GLl) # ascending order

arrange(filtered_site, desc(GLl)) # descending order

# transform columns

mutate(filtered_site, dataset = "Sheep Astragali")

dim_index <- mutate(filtered_site, Dl_GLl = Dl / GLl * 100)

mutate(filter(sheep_data, Site != "DOR"), DL_GLl = Dl / GLl * 100)

dim_index <- sheep_data |>
  filter(Site != "DOR") |>
  mutate(Dl_GLl = Dl / GLl * 100) |>
  select(specID, Site, GLl, Dl) # select specific columns to keep


