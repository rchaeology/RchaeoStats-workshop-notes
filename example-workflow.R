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



