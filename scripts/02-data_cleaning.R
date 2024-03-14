#### Preamble ####
# Purpose: To filter the dataset, focusing on non-suicide related mortality records
# Author: Hailey jang 
# Date: 11 March, 2024
# Contact: hailey.jang@mail.utoronto.ca
# License: MIT

#### Workspace setup ####
library(tidyverse)

#### Clean data ####
dataset <- read_csv("data/raw_data/Homeless_deaths_by_cause.csv")

# Rename the year of death column
names(dataset)[names(dataset) == 'Year of death'] <- 'Year_of_death'

# Clean data to remove unknown values and isolate causes of deaths relating to suicide
cleaned_data <-
  dataset |>
  filter(Cause_of_death != "Suicide", Age_group != "Unknown", Gender != "Unknown") |>
  # Pipe this to include only the year of death, age group, gender, and count.
  select(Year_of_death, Age_group, Gender, Count)

head(cleaned_data, n=10)

#### Save data ####
write_csv(cleaned_data, "data/analysis_data/cleaned_data.csv")

### Data for sex###

# Initialize a list to store the sum of deaths of Male
Male_deaths_summary <- list()

for (year in c(2017,2018,2019,2020,2021, 2022, 2023)) {
  # Filter data for Male
  year_data <- cleaned_data %>%
    filter(Year_of_death == year, Gender == 'Male') %>%
    select(Year_of_death, Gender, Count)
  
  print(head(year_data, n = 10))
  
  # Calculate the sum of deaths
  Male_deaths_summary[[as.character(year)]] <- sum(year_data$Count)
}

# Initialize a list to store the sum of deaths of Female
Female_deaths_summary <- list()

for (year in c(2017,2018,2019,2020,2021, 2022, 2023)) {
  # Filter data for Female
  year_data <- cleaned_data %>%
    filter(Year_of_death == year, Gender == 'Male') %>%
    select(Year_of_death, Gender, Count)
  
  print(head(year_data, n = 10))
  
  # Calculate the sum of deaths
  Female_deaths_summary[[as.character(year)]] <- sum(year_data$Count)
}

# Load the tibble package for creating tibbles
library(tibble)

# Create a tibble to organize the death data by year and gender
gender_deaths_data <- tibble(
  Year = rep(c('2017', '2018', '2019', '2020', '2021', '2022', '2023'), each = 2),
  Gender = rep(c('Male', 'Female'), times = 7),
  Deaths = c(Male_deaths_summary, Female_deaths_summary)
)

#### Save data ####
write_csv(gender_deaths_data, "data/analysis_data/gender_deaths_data.csv")

### Data for age###

library(dplyr)
library(tibble)
library(readr)

# Define a function to summarize deaths by year and age group
summarize_deaths_by_age <- function(age_group, data) {
  deaths_summary <- numeric(length = length(2017:2023))
  years <- 2017:2023
  
  for (i in seq_along(years)) {
    year <- years[i]
    year_data <- data %>%
      filter(Year_of_death == year, Age_group == age_group) %>%
      select(Year_of_death, Age_group, Count)
    
    print(head(year_data, n = 10))
    
    deaths_summary[i] <- sum(year_data$Count)
  }
  
  return(deaths_summary)
}

# Apply the function for each age group
youth_deaths <- summarize_deaths_by_age('<20', cleaned_data)
adults_deaths <- summarize_deaths_by_age('20-39', cleaned_data)
elderly_deaths <- summarize_deaths_by_age('40-59', cleaned_data)
senior_deaths <- summarize_deaths_by_age('60+', cleaned_data)

# Create a tibble to organize the death data by year and age
age_group_deaths_data <- tibble(
  Year = rep(2017:2023, times = 4),
  Age_group = rep(c('<20', '20-39', '40-59', '60+'), each = 7),
  Deaths = c(youth_deaths, adults_deaths, elderly_deaths, senior_deaths)
)

# Save the data
write_csv(age_group_deaths_data, "data/analysis_data/age_group_deaths_data.csv")
