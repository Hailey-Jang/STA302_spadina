#### Preamble ####
# Purpose: Generate simulated data for annual deaths, categorized by age and sex
# Author: Hailey Jang
# Date: 12 March 2024
# Contact: hailey.jang@mail.utoronto.ca
# License: MIT
# Pre-requisites: NA


#### Workspace setup ####
library(tidyverse)

#### Simulate data ####
# Set the seed for reproducibility
set.seed(93)

# Simulate data
years <- rep(seq(2017, 2023, 1), each = 5)
age <- sample(c("40-59", "20-39", "60+", "<20"), size = 35, replace = TRUE, prob = c(0.2, 0.2, 0.1, 0.5))
sex <- sample(c("Female", "Male"), size = 35, replace = TRUE, prob = c(0.35, 0.65))
death_counts <- round(rpois(length(years), lambda = 9.5))

simulated_data <- data.frame(
  Year_of_death = years,
  Age_group = age,
  Gender = sex,
  Count = death_counts
)

### Save simulated data ###
write_csv(simulated_data, "data/raw_data/Homeless_deaths_by_demographics.csv")







