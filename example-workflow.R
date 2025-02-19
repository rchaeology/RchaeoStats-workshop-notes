library(tidyverse)

sheep_data <- read_csv("https://edu.nl/3hru6")

head(sheep_data) # show the first 6 rows in the data

# show the last 6 rows
tail(sheep_data)

# Create a plot
  # map the Zone variable to the colour of the points
ggplot(data = sheep_data, mapping = aes(x = GLl, y = Bd, colour = Zone)) + 
  geom_point() +
  geom_smooth(method = "lm", se = FALSE) # se = FALSE to remove confidence interval

ggplot(data = sheep_data, mapping = aes(x = GLl, y = Bd)) + 
  geom_point(aes(colour = Zone, shape = Zone), size = 3) +
  geom_smooth(method = "lm", se = FALSE) + # se = FALSE to remove confidence interval
  scale_colour_viridis_d(end = 0.8) +
  theme_minimal() +
  labs(x = "Greatest lateral length (mm?)", y = "Breadth of distal end (cm?)")

# Data transformation

filter(sheep_data, Site == "KSN") # filter rows where Site is KSN
filter(sheep_data, Site == "KSN" | Site == "ABM") # filter rows where Site is KSN OR ABM
filter(sheep_data, Site != "DOR")
sheep_data$Site == "KSN"

filtered_site <- filter(sheep_data, Site != "DOR")

arrange(sheep_data, GLl)  # order GLl from lowest to highest
arrange(sheep_data, desc(GLl))

# Transforming columns

# create a new variable
mutate(sheep_data, dataset = "Sheep Astragali")
# create a new variable based on existing variables
mutate(filtered_site, Dl_GLl = Dl / GLl * 100)

dim_index <- mutate(filtered_site, Dl_GLl = Dl / GLl * 100)

dim_index <- arrange(mutate(filter(sheep_data, Site != "DOR"), Dl_GLl = Dl / GLl * 100), Dl_GLl)

sheep_data |>
  filter(Site != "DOR") |>
  mutate(Dl_GLl = Dl / GLl * 100) |>
  arrange(Dl_GLl)

select(sheep_data, specID, Site, GLl, Dl) # select specific columns
select(sheep_data, 1, 3, 7, 9)
select(sheep_data, !c(Taxon, Zone, Period, group, Bd)) # NOT select specific columns
select(sheep_data, !Taxon, !Zone, !Period, !group, !Bd) # DOES NOT work as you would expect

dimension_data <- sheep_data |>
  filter(Site != "DOR") |>
  mutate(Dl_GLl = Dl / GLl * 100) |>
  select(specID, Site, GLl, Dl, Dl_GLl)

# Grouping and summarising

dimension_data |>
  group_by(Site) |>
  summarise(
    n = n(),
    mean_Dl_GLl = mean(Dl_GLl),
    sd_Dl_GLl = sd(Dl_GLl)
  )

# Visualise this with a box plot
dimension_data |>
  ggplot(aes(x = Site, y = Dl_GLl)) +
  geom_violin(aes(fill = Site)) +
  geom_boxplot(width = 0.2) +
  theme_bw() +
  theme(legend.position = "none")

ggsave("my-first-plot.png")  




  
