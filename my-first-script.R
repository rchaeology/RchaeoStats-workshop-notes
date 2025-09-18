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

select(sheep_data, 1, 3, 7, 9)

select(sheep_data, !c(Taxon, Zone, group))

# grouping and summarising

dimensions <- sheep_data |>
  filter(Site != "DOR") |>
  select(specID, Site, GLl, Bd, Dl) |>
  mutate(
    Dl_GLl = Dl / GLl * 100,
    Bd_Dl = Bd / Dl * 100
  )

dimensions |>
  group_by(Site) |>
  summarise(
    n = n(),
    mean_Dl_GLl = mean(Dl_GLl),
    sd_Dl_GLl = sd(Dl_GLl)
  )

dimensions |>
  ggplot(aes(x = Site, y = Dl_GLl)) +
  geom_violin(aes(fill = Site)) + # violin will be displayed behind the boxplots
  geom_boxplot(width = 0.2) +
  theme_bw() +
  theme(legend.position = "none")

ggsave("my-first-plot.png")
  
  

