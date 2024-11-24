#### Preamble ####
# Purpose: Models... [...UPDATE THIS...]
# Author: Rohan Alexander [...UPDATE THIS...]
# Date: 11 February 2023 [...UPDATE THIS...]
# Contact: rohan.alexander@utoronto.ca [...UPDATE THIS...]
# License: MIT
# Pre-requisites: [...UPDATE THIS...]
# Any other information needed? [...UPDATE THIS...]


#### Workspace setup ####
library(tidyverse)
library(rstanarm)
library(readr)  # For reading CSV files
library(broom)  # For summarizing and tidying models

#### Read data ####
# Load data from your CSV file
analysis_data <- read_csv("data/02-analysis_data/analysis_data.csv")

#### Convert month and vendor to factor ####
analysis_data <- analysis_data %>%
  mutate(
    month = as.factor(month),  # Convert month to factor
    vendor = as.factor(vendor) # Convert vendor to factor
  )

# Check if the conversion was successful
str(analysis_data)  # Display the structure of the dataset

#### Model data ####
# Define the Bayesian regression model
first_model <- stan_glm(
  formula = current_price ~ month + old_price + vendor,
  data = analysis_data,
  family = gaussian(),  # Normal distribution for the response variable
  prior = normal(location = 0, scale = 2.5, autoscale = TRUE),
  prior_intercept = normal(location = 0, scale = 2.5, autoscale = TRUE),
  prior_aux = exponential(rate = 1, autoscale = TRUE),
  seed = 304  # Set seed for reproducibility
)

#### Save model ####
# Save the fitted model as an RDS file
saveRDS(
  first_model,
  file = "models/first_model.rds"
)

#### Summarize and evaluate the model ####
# Summary of the model
summary(first_model)

# Plot posterior distributions
plot(first_model)

#### Linear regression model ####
linear_model <- lm(
  formula = current_price ~ month + old_price + vendor,
  data = analysis_data
)

#### Summarize the model ####
summary(linear_model)  # Display the summary of the linear regression model

#### Extract coefficients ####
tidy(linear_model) 

#### Save the model ####
saveRDS(
  linear_model,
  file = "models/linear_model.rds"
)
