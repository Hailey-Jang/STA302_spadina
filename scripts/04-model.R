#### Preamble ####
# Purpose: Conduct statistical modeling
# Author: Hailey jang 
# Date: 11 March, 2024
# Contact: hailey.jang@mail.utoronto.ca
# License: MIT


#### Workspace setup ####
library(tidyverse)
library(rstanarm)

#### Read data ####
modeling_data <- read_csv("data/analysis_data/cleaned_data.csv")

### Model data ####
first_model <- stan_glm(
  formula = Count ~ Gender + Age_group,
  data = modeling_data,
  family = gaussian(),
  prior = normal(0, 23, autoscale = TRUE),
  prior_intercept = normal(0, 1, autoscale = TRUE),
  prior_aux = exponential(0.33, autoscale = TRUE),
  seed = 80
)


#### Save model ####
# Save the constructed model for future reference
saveRDS(
  first_model,
  file = "models/first_model.rds"
)

# Notification of script completion
message("first_model has been successfully created and saved.")

