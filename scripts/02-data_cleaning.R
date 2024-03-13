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

# Rename year of death column
names(dataset)[names(dataset) == 'Year of death'] <- 'Year_of_death'

# Clean data to remove unknown values and isolate causes of deaths relating to suicide
cleaned_data <-
  dataset |>
  filter(Cause_of_death != "Suicide", Age_group != "Unknown", Gender != "Unknown") |>
  # Pipe this to include only year of death, age group, gender, and count.
  select(Year_of_death, Age_group, Gender, Count)

head(cleaned_data, n=10)

#### Save data ####
write_csv(cleaned_data, "data/analysis_data/cleaned_data.csv")
