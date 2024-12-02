#### Preamble ####
# Purpose: Simulates a dataset of Canadian Grocery Price Data
# Author: Fangning Zhang
# Date: 23 November 2024
# Contact: fangning.zhang@mail.utoronto.ca
# License: MIT
# Pre-requisites: The `tidyverse` package must be installed
# Any other information needed? Make sure you are in the `starter_folder` rproj


#### Simulate data ####
# Workspace setup
library(tidyverse)
set.seed(304)

# Simulate cleaned_data
simulated_data <- tibble(
  vendor = sample(c("NoFrills", "Voila", "Loblaws", "SaveOnFoods", "Metro", "TandT", "Galleria", "Walmart"), 500, replace = TRUE),  # Randomly assign vendors
  current_price = round(runif(500, 1, 8), 2),                # Random current price between 0.9 and 8
  old_price = round(current_price + runif(500, 0.5, 2), 2),    # Old price slightly higher than current price
  product_name = sample(
    c(
      "White Potatoes", 
      "Yellow Potato"
    ), 500, replace = TRUE),                                   # Random product names
  month = sample(1:12, 500, replace = TRUE)                   # Random months
)

# Display simulated dataset
print(simulated_data)

# Save the dataset to CSV
write_csv(simulated_data, "data/00-simulated_data/simulated_cleaned_data.csv")

