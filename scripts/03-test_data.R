#### Preamble ####
# Purpose: Validate simulation outputs and data cleaning 
# Author: Hailey jang
# Date: 11 March, 2024
# Contact: hailey.jang@mail.utoronto.ca
# License: MIT


#### Workspace setup ####
library(tidyverse)
analyzed_data <- read_csv("data/analysis_data/cleaned_data.csv")

#### Test data ####
# Verify the integrity of four distinct variables
analyzed_data %>% 
  unique() %>% 
  length() == 4

# Validate data types of each variable
is.numeric(analyzed_data$Year_of_death)
is.character(analyzed_data$Age_group)
is.character(analyzed_data$Gender)
is.numeric(analyzed_data$Count)

# Confirm that the highest recorded deaths in any category are within expected bounds
max(analyzed_data$Count) <= 75

# Ensure that the lowest count of deaths is not less than zero
min(analyzed_data$Count) >= 0 

# Validate the presence of all specified age groups
unique(analyzed_data$Age_group) == c("40-59", "20-39", "60+", "<20")

# Check for the inclusion of all expected years in the data
unique(analyzed_data$Year_of_death) == c('2017', '2018', '2019', '2020', '2021', '2022', '2023')

# Ensure gender data contains only the specified categories
unique(analyzed_data$Gender) == c('Female', 'Male')

