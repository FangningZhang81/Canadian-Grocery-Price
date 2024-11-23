#### Preamble ####
# Purpose: Tests the structure and validity of the simulated Australian 
  #electoral divisions dataset.
# Author: Rohan Alexander
# Date: 26 September 2024
# Contact: rohan.alexander@utoronto.ca
# License: MIT
# Pre-requisites: 
  # - The `tidyverse` package must be installed and loaded
  # - 00-simulate_data.R must have been run
# Any other information needed? Make sure you are in the `starter_folder` rproj


#### Workspace setup ####
library(tidyverse)

# Load the simulated dataset
simulated_data <- read_csv("data/00-simulated_data/simulated_cleaned_data.csv")

# Test if the data was successfully loaded
if (exists("simulated_data")) {
  message("Test Passed: The dataset was successfully loaded.")
} else {
  stop("Test Failed: The dataset could not be loaded.")
}


#### Test data ####

# Check if the dataset has 500 rows
if (nrow(simulated_data) == 500) {
  message("Test Passed: The dataset has 500 rows.")
} else {
  stop("Test Failed: The dataset does not have 500 rows.")
}

# Check if the dataset has 5 columns
if (ncol(simulated_data) == 5) {
  message("Test Passed: The dataset has 5 columns.")
} else {
  stop("Test Failed: The dataset does not have 5 columns.")
}

# Check if all values in the 'vendor' column are valid vendors
valid_vendors <- c("NoFrills", "Voila", "Loblaws", "SaveOnFoods", "Metro", "TandT", "Galleria", "Walmart")

if (all(simulated_data$vendor %in% valid_vendors)) {
  message("Test Passed: The 'vendor' column contains only valid vendors.")
} else {
  stop("Test Failed: The 'vendor' column contains invalid vendors.")
}

# Check if there are any missing values in the dataset
if (all(!is.na(simulated_data))) {
  message("Test Passed: The dataset contains no missing values.")
} else {
  stop("Test Failed: The dataset contains missing values.")
}

# Check if there are no negative values in 'current_price' or 'old_price'
if (all(simulated_data$current_price >= 0 & simulated_data$old_price >= 0)) {
  message("Test Passed: The 'current_price' and 'old_price' columns contain no negative values.")
} else {
  stop("Test Failed: One or more values in 'current_price' or 'old_price' are negative.")
}

# Check if all 'old_price' values are greater than or equal to 'current_price'
if (all(simulated_data$old_price >= simulated_data$current_price)) {
  message("Test Passed: All 'old_price' values are greater than or equal to 'current_price'.")
} else {
  stop("Test Failed: Some 'old_price' values are less than 'current_price'.")
}

# Check if the 'month' column contains only valid months (1 to 12)
if (all(simulated_data$month %in% 1:12)) {
  message("Test Passed: The 'month' column contains only valid month values.")
} else {
  stop("Test Failed: The 'month' column contains invalid month values.")
}

# Check if the 'vendor' column contains at least two unique vendors
if (n_distinct(simulated_data$vendor) >= 2) {
  message("Test Passed: The 'vendor' column contains at least two unique vendors.")
} else {
  stop("Test Failed: The 'vendor' column contains less than two unique vendors.")
}

