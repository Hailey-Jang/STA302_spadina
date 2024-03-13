#### Preamble ####
# Purpose: Downloads and saves the data from opendatatoronto
# Author: Hailey Jang
# Date: 12 March 2024
# Contact: hailey.jang@mail.utoronto.ca
# License: MIT

#### Workspace setup ####
library(opendatatoronto)
library(tidyverse)

#### Download data ####
# Got the data from OpenDataToronto
# Code based on https://open.toronto.ca/dataset/deaths-of-people-experiencing-homelessness/

# Read CSV file 
homeless_death <-
  read_csv(
    file = "https://ckan0.cf.opendata.inter.prod-toronto.ca/dataset/a7ae08f3-c512-4a88-bb3c-ab40eca50c5e/resource/ceafdcdf-5f41-4ba5-9b69-f4c8e581ab6e/download/Homeless%20deaths%20by%20cause.csv", 
    show_col_types = FALSE
  )

#### Save data ####

write.csv(
  x = homeless_death, 
  file = "data/raw_data/Homeless_deaths_by_cause.csv"
)

