#### Preamble ####
# Purpose: Conduct statistical modeling
# Author: Hailey jang 
# Date: 11 March, 2024
# Contact: hailey.jang@mail.utoronto.ca
# License: MIT


#### Workspace setup ####
library(readr)
library(rstanarm)
library(here)

#### Read data ####
cleaned_data <- read_csv(here("data", "analysis_data", "cleaned_data.csv"))

# Ensure reproducibility
set.seed(2024)

#### Model data ####
bayesian_model <- stan_glm(
  Count ~ Age_group + Gender, 
  data = cleaned_data,
  family = poisson(link = "log"),
  seed = 2024 # Set the seed for reproducibility
)

# Summary of the model to check for immediate red flags
summary(bayesian_model)

#### Save model ####
# Save the Bayesian model as an .rds file to the 'models' folder
saveRDS(
  bayesian_model,
  file = here("models", "bayesian_risk_stratification_model.rds")
)

