#library("styler")
#style_file()
# The data
# load the data
incarceration_df <- read.csv("https://raw.githubusercontent.com/vera-institute/incarceration-trends/master/incarceration_trends.csv",
  stringsAsFactors = F)
colnames(incarceration_df)
# View(incarceration_df) 


# Part 1:Data description
# The number of observations in the data set (how big is it?)
number_of_observations <- nrow(incarceration_df)
# print(number_of_observations)

# The range of years the data set covers (what is the smallest and largest year)?
range_of_years <- range(incarceration_df$year)
# print(range_of_years)

# For the most recent year with data, how many people are in jail,
# how many are in prison, and how many are in the total population as a whole?
jail_population_2018 <- sum(incarceration_df[incarceration_df$year == "2018", ]$total_jail_pop, na.rm = T)
jail_population_2018 <- as.integer(jail_population_2018 )

# print(jail_population_2018)
prison_population_2018 <- sum(incarceration_df[incarceration_df$year == "2018", ]$total_prison_pop, na.rm = T)

# print(prison_population_2018)
total_population_2018 <- sum(incarceration_df[incarceration_df$year == "2018", ]$total_pop, na.rm = T)

# print(total_population_2018)

# save the data into a vector for use in the report
data_description <- list(number_observation=number_of_observations, range_of_year=range_of_years, 
                               total_number_of_people_in_jail_2018=jail_population_2018, 
                               total_number_of_people_in_prison_2018=prison_population_2018, 
                               total_pop_2018=total_population_2018)
# print(data_description)


# Part 2:Incarceration Trends Over Time
library("ggplot2")
library(tidyverse)
library(dplyr)

# wrangled the data to get time series df
incarceration_time_series_df <- incarceration_df %>%
  replace_na(list(
    total_jail_pop = 0, total_jail_from_prison = 0,
    black_jail_pop = 0, black_prison_pop = 0,
    white_jail_pop = 0, white_prison_pop = 0,
    latinx_jail_pop = 0, latinx_prison_pop = 0,
    aapi_jail_pop = 0, aapi_prison_pop = 0,
    native_jail_pop = 0, native_prison_pop = 0
  )) %>%
  mutate(
    total_incarcerated_pop = replace_na(total_jail_pop,0) + replace_na(total_prison_pop,0),
    aapi_incarcerated_pop = aapi_jail_pop + aapi_prison_pop,
    white_incarcerated_pop = white_jail_pop + white_prison_pop,
    black_incarcerated_pop = black_jail_pop + black_prison_pop,
    latinx_incarcerated_pop = latinx_jail_pop + latinx_prison_pop,
    native_incarcerated_pop = native_jail_pop + native_prison_pop
  ) %>%
  replace_na(list(
    total_incarcerated_pop = 0, aapi_incarcerated_pop = 0,
    white_incarcerated_pop = 0, black_incarcerated_pop = 0,
    latinx_incarcerated_pop = 0, native_incarcerated_pop = 0
  )) %>%
  group_by(year) %>%
  summarise(across(total_incarcerated_pop:native_incarcerated_pop, sum)) %>%
  pivot_longer(!year, names_to = "Race", values_to = "population")
# View(incarceration_time_series_df)

# create the plot
incarceration_over_time_plot <- ggplot(
  data = incarceration_time_series_df,
  mapping = aes(x = year, y = population, group = Race, color = Race)
) +
  geom_point() +
  geom_line() +
  labs(title = "Incarceration Trends Over Time", x = "Year", y = "Incarcerated Population") +
  scale_color_brewer(palette = "Dark2", label = c(
    "total_incarcerated_pop" = "total", "aapi_incarcerated_pop" = "aapi",
    "white_incarcerated_pop" = "white", "black_incarcerated_pop" = "black",
    "latinx_incarcerated_pop" = "latinx", "native_incarcerated_pop" = "native"
  ))
incarceration_over_time_plot


# part 3:Highest Black Incarceration Rates
# wrangled the data to get the top ten black incarceration states
top_10_black_incarceration_states_df <- incarceration_df %>%
  filter(year == 2016) %>%
  replace_na(list(total_jail_pop = 0, total_prison_pop = 0, black_jail_pop = 0, black_prison_pop = 0)) %>%
  mutate(
    total_incarcerated_pop = total_jail_pop + total_prison_pop,
    black_incarcerated_pop = black_jail_pop + black_prison_pop
  ) %>%
  group_by(state) %>%
  summarise(across(c(
    total_incarcerated_pop, black_incarcerated_pop,
    total_pop_15to64, black_pop_15to64
  ), sum)) %>%
  replace_na(list(total_incarcerated_pop = 0, black_incarcerated_pop = 0)) %>%
  mutate(
    total_rate = total_incarcerated_pop / total_pop_15to64 * 100,
    black_rate = black_incarcerated_pop / black_pop_15to64 * 100
  ) %>%
  slice_max(order_by = black_rate, n = 10)
# View(top_10_black_incarceration_states_df)

# create the plot
top_10_black_rate <- top_10_black_incarceration_states_df$state
# print(top_10_black_rate)
rv <- rev(top_10_black_rate)
# print(rv)

pivoted <- top_10_black_incarceration_states_df %>%
  pivot_longer(cols = c(black_rate, total_rate), names_to = "rateType", values_to = "rate")
# View(pivoted)
pivoted$state <- factor(pivoted$state, levels = rv)
top_10_black_incarceration_plot <- ggplot(
  data = pivoted,
  mapping = aes(x = state, y = rate, group = rateType, fill = rateType)
) +
  geom_col(position = "dodge") +
  labs(title = "States with Highest Rate of Black Incarceration", x = "State", y = "Percent Incarcerated (%)") +
  coord_flip() +
  scale_fill_brewer(palette = "Set3", label = c("total_rate" = "total", "black_rate" = "black"))
#top_10_black_incarceration_plot

# part4:Racial Incarceration Discrepancy Map
# wrangled the data
library("maps")
black_white_rate_county_df <- incarceration_df %>%
  filter(year == "2016", state == "WA") %>%
  replace_na(list(
    black_jail_pop = 0, black_prison_pop = 0, white_jail_pop = 0,
    white_prison_pop = 0, black_pop_15to64 = 0, white_pop_15to64 = 0
  )) %>%
  mutate(
    black_incarcerated_pop = black_jail_pop + black_prison_pop,
    white_incarcerated_pop = white_jail_pop + white_prison_pop,
    black_pop_adult = black_pop_15to64,
    white_pop_adult = white_pop_15to64
  ) %>%
  group_by(county_name) %>%
  summarise(across(black_incarcerated_pop:white_pop_adult, sum)) %>%
  mutate(
    black_ratio = black_incarcerated_pop / black_pop_adult,
    white_ratio = white_incarcerated_pop / white_pop_adult
  ) %>%
  mutate(black_white_rate_county = black_ratio / white_ratio)
# View(black_white_rate_county_df)

# Add appropriate FIPS codes to each county
shape_data <- map_data("county") %>% mutate(polyname = paste(region, subregion, sep = ","))
# View(shape_data)
# View(county.fips)
WA_joined_shape <- left_join(shape_data, county.fips, by = "polyname") %>% filter(region == "washington")
# View(WA_joined_shape)
WA_joined_shape$fips[WA_joined_shape$subregion == "pierce"] <- "53053"
WA_joined_shape$fips[WA_joined_shape$subregion == "san juan"] <- "53055"
# View(WA_joined_shape)

# create the map
black_white_rate_county_df$county_name <- black_white_rate_county_df$county_name %>%
  tolower() %>%
  str_remove(" county")
black_white_rate_county_df <- black_white_rate_county_df %>%
  mutate(county_name = paste("washington", county_name, sep = ","))
# View(black_white_rate_county_df)
map_with_data <- left_join(WA_joined_shape, black_white_rate_county_df, by = c("polyname" = "county_name"))
# View(map_with_data)
WA_map <- ggplot(map_with_data) +
  geom_polygon(mapping = aes(x = long, y = lat, group = group, fill = black_white_rate_county)) +
  scale_fill_distiller(palette = "YlOrBr", direction = 1) +
  coord_quickmap() +
  theme_void() +
  labs(
    title = "Racial Incarceration Discrepancy Map",
    caption = "Displays the ratio of black incarceration rate to white incarceration rate. 
       A ratio of 2.0 means that black people are twice as likely to be incarcerated as white people.",
    fill = "ratio of black:white"
  )
WA_map

# Part 5: My Own Visualization
# Difference in Incarceration Trends Over Time For Male and Female
incarceration_gender_df <- incarceration_df %>%
  replace_na(list(
    total_jail_pop = 0, total_jail_from_prison = 0,
    male_jail_pop = 0, male_prison_pop = 0,
    female_jail_pop = 0, female_prison_pop = 0
  )) %>%
  mutate(
    total_incarcerated_pop = total_jail_pop + total_prison_pop,
    male_incarcerated_pop = male_jail_pop + male_prison_pop,
    female_incarcerated_pop = female_jail_pop + female_prison_pop
  ) %>%
  replace_na(list(total_incarcerated_pop = 0, male_incarcerated_pop = 0, female_incarcerated_pop = 0)) %>%
  group_by(year) %>%
  summarise(across(total_incarcerated_pop:female_incarcerated_pop, sum)) %>%
  pivot_longer(!year, names_to = "Gender", values_to = "population")
# View(incarceration_gender_df)
incarceration_gender_plot <- ggplot(
  data = incarceration_gender_df,
  mapping = aes(x = year, y = population, group = Gender, color = Gender)
) +
  geom_point() +
  geom_line() +
  labs(title = "Incarceration Trends Over Time For Male and Female", x = "Year", y = "Incarcerated Population") +
  scale_color_brewer(palette = "YlOrBr", label = c("total_incarcerated_pop" = "total", 
                                                   "male_incarcerated_pop" = "male", "female_incarcerated_pop" = "female"))
 incarceration_gender_plot

