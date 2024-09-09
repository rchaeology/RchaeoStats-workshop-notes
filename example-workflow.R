library(tidyverse)

sheep_data <- read_csv("https://edu.nl/3hru6")

# show the first 6 rows of our data
head(sheep_data)

# show the first 10 rows of our data
head(sheep_data, n = 10)


# Data visualisation ------------------------------------------------------

ggplot(
  data = sheep_data, 
  mapping = aes(x = GLl, y = Bd, colour = Zone)
  ) + 
  geom_point() +
  geom_smooth(method = "lm", se = FALSE) # best-fit line without confidence bands


ggplot(
  data = sheep_data, 
  mapping = aes(x = GLl, y = Bd)
) + 
  geom_point(aes(colour = Zone, shape = Zone), size = 2) +
  geom_smooth(method = "lm") + # best-fit line with confidence bands
  scale_colour_viridis_d(end = 0.8) +
  theme_minimal() +
  labs(
    x = "Greatest lateral length (cm)",
    y = "Breadth of distal end (cm)"
  )


# Data transformation -----------------------------------------------------

filter(sheep_data, Zone == "Coastal")

filter(sheep_data, Zone == "Coastal" | Zone == "Inland")

filter(sheep_data, Zone != "Cyprus")

sheep_data$Zone != "Cyprus"

filtered_zone <- filter(sheep_data, Zone != "Cyprus")

arrange(filtered_zone, GLl) # increasing values
arrange(filtered_zone, desc(GLl)) # descending values

mutate(filtered_zone, dataset = "Sheep Astragali")

dim_index <- mutate(filtered_zone, Dl_GLl = Dl / GLl * 100)

# A bad way to do it
mutate(filter(sheep_data, Zone != "Cyprus"), Dl_GLl = Dl / GLl * 100)

sheep_data |> # and then
  filter(Zone != "Cyprus") |> # and then
  mutate(Dl_GLl = Dl / GLl * 100)

# select columns by name
select(sheep_data, specID, Zone, GLl, Dl)

# select columns by position
select(sheep_data, 1, 4, 7, 9)

select(sheep_data, !Taxon)

select(sheep_data, !c(Taxon, Site, Period))
select(sheep_data, !c(2, 3, 5))

sheep_data |>
  filter(Zone != "Cyprus") |> # Inland and Coastal zones
  select(specID, Zone, GLl, Bd, Dl) |> # select columns
  mutate(
    Dl_GLl = Dl / GLl * 100, # calculate indices
    Bd_Dl = Bd / Dl * 100
  ) |>
  filter(Dl_GLl > 56) # only observations over 56
  
dimension_data <- sheep_data |>
  filter(Zone != "Cyprus") |>
  select(specID, Zone, GLl, Bd, Dl) |>
  mutate(
    Dl_GLl = Dl / GLl * 100,
    Bd_Dl = Bd / Dl * 100
  )
  
dimension_data |>
  group_by(Zone) |>
  summarise(
    n = n(),
    mean_Dl_GLl = mean(Dl_GLl),
    sd_Dl_GLl = sd(Dl_GLl)
  )

dimension_data |>
  ggplot(aes(x = Zone, y = Dl_GLl, fill = Zone)) +
  geom_boxplot() +
  geom_jitter(
    height = 0.2, # reduce random noise on y-axis
    width = 0.2 # reduce random noise on x-axis
  ) +
  theme_bw() +
  theme(legend.position = "none") # remove redundant legend

ggsave("my-first-plot.png", dpi = 300, height = 6, width = 7, units = "in")



  
  
  
  
  


