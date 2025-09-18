library(tidyverse)
sheep_data <- read_csv("https://edu.nl/3hru6")

head(sheep_data)

ggplot(data = sheep_data, mapping = aes(x = GLl, y = Bd)) +
  geom_point(aes(col = Zone, shape = Period), size = 2) +
  geom_smooth(method = "lm", col = "black") +
  scale_colour_viridis_d(end = 0.8) +
  theme_minimal() +
  labs(x = "Greatest lateral length (mm)", y = "Breadth of the distal end (mm)")
