download.file("https://edu.nl/y8buk", "data-raw/pmcoc_dental_path.lst", mode = "wb")

install.packages("tidyverse") # if you didn't join this morning

library(tidyverse) # for everyone
pmcoc_dental_raw <- read_delim("data-raw/pmcoc_dental_path.lst", delim = "|")

pmcoc_dental_raw$VALUE
str_remove(pmcoc_dental_raw$VALUE, "\\|")

mutate(pmcoc_dental_raw, VALUE = str_remove(VALUE, "\\|"))
mutate(pmcoc_dental_raw, CONTEXT = as.character(CONTEXT))

mutate(pmcoc_dental_raw, region = str_extract(GROUP, "^\\w+"))
mutate(pmcoc_dental_raw, tooth = str_extract(GROUP, "T[0-9]{2}"))

pmcoc_dental <- pmcoc_dental_raw |>
  filter(
    SEX != "UNDETERMINABLE",
    AGE != "UNCLASSIFIED ADULT"
  ) |>
  mutate(
    CONTEXT = as.character(CONTEXT),
    VALUE = str_remove(VALUE, "\\|"),
    region = str_extract(GROUP, "^\\w+"),
    tooth = str_extract(GROUP, "T[0-9]{2}")
  ) |>
  select(!GROUP)

pmcoc_dental |>
  group_by(CONTEXT, EXPANSION) |>
  count()

pmcoc_dental |>
  group_by(SEX, EXPANSION) |>
  count()

pmcoc_dental |>
  group_by(AGE, EXPANSION) |>
  count()

pmcoc_dental |>
  group_by(AGE, SEX, EXPANSION) |>
  count()

# bar chart with counts of teeth per individual
pmcoc_dental |>
  group_by(CONTEXT) |>
  filter(EXPANSION == "Caries") |>
  summarise(n = n(), SEX = first(SEX)) |>
  mutate(SEX = factor(SEX, levels = c("MALE", "MALE?", "INTERMEDIATE", "FEMALE?", "FEMALE", "UNSEXED CHILD"))) |>
  ggplot(aes(x = forcats::fct_reorder(CONTEXT, SEX, .fun = sort), y = n, fill = SEX)) +
    geom_col() +
    geom_hline(yintercept = 32) # horizontal line at y = 32


pmcoc_adults <- pmcoc_dental |>
  filter(
    EXPANSION %in% c("Hypoplasia", "Caries", "Calculus"),
    !str_detect(AGE, "SUB")
    ) |>
  mutate(
    location = str_extract(VALUE, "^."),
    severity = str_extract(VALUE, ".$"),
    presence = case_when(
      VALUE == 0 ~ 0,
      VALUE == 9 ~ NA,
      .default = 1
    )
  ) |>
  select(!c(CEMETERY, PERIOD, LU_INT, E_DATE, L_DATE, TRAIT_TYPE))
  

pmcoc_adults |>
  group_by(EXPANSION, AGE, SEX) |>
  summarise(
    n_lesions = sum(presence, na.rm = TRUE),
    n_teeth = n(),
    lesion_ratio = n_lesions / n_teeth
  ) |>
  ggplot(aes(x = AGE, y = lesion_ratio, group = EXPANSION, col = EXPANSION)) +
    geom_line() +
    geom_point() +
    facet_wrap(~ SEX)

  
pmcoc_adults |>
  group_by(EXPANSION, AGE, SEX) |>
  summarise(
    n_lesions = sum(presence, na.rm = TRUE),
    n_teeth = n(),
    lesion_ratio = n_lesions / n_teeth
  ) |>
  ggplot(aes(x = EXPANSION, y = lesion_ratio, fill = SEX)) +
  geom_col(position = "dodge")


pmcoc_caries <- pmcoc_adults |>
  filter(EXPANSION == "Caries")

caries_summ <- pmcoc_caries |>
  group_by(CONTEXT) |>
  summarise(
    count = sum(presence, na.rm = TRUE),
    SEX = first(SEX),
    AGE = first(AGE)
  ) |>
  mutate(presence = count > 0)

mean(caries_summ$presence) * 100
scales::percent(mean(caries_summ$presence))

caries_summ |>
  group_by(AGE, SEX) |>
  summarise(prop = mean(presence)) |>
  mutate(percent = scales::percent(prop))
  
  




  
  
  

