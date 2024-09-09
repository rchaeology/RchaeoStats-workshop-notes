library(tidyverse)

sheep_data <- read_csv("https://edu.nl/3hru6")

# show the first 6 rows of our data
head(sheep_data)

# show the first 10 rows of our data
head(sheep_data, n = 10)

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

