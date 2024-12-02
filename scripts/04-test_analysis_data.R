#### Preamble ####
# Purpose: Tests on the analysis data
# Author: Fangning Zhang
# Date: 23 November 2024
# Contact: fangning.zhang@mail.utoronto.ca
# License: MIT
# Pre-requisites: 02-analysis_data saved and loaded
# Any other information needed? None


#### Workspace setup ####
library(tidyverse)
library(testthat)
library(here)
library(arrow)


# Load cleaned_data (replace the path as needed)
cleaned_data <- read_parquet(here::here("data/02-analysis_data/analysis_data.parquet"))

# Test that the dataset has 685 rows
test_that("dataset has 685 rows", {
  expect_equal(nrow(cleaned_data), 685, info = "Row count mismatch")
})

# Test that the dataset has 5 columns
test_that("dataset has 5 columns", {
  expect_equal(ncol(cleaned_data), 5, info = "Column count mismatch")
})

# Test that the 'vendor' column is character type
test_that("'vendor' is character", {
  expect_true(is.character(cleaned_data$vendor), info = "'vendor' is not character type")
})

# Test that the 'product_name' column is character type
test_that("'product_name' is character", {
  expect_true(is.character(cleaned_data$product_name), info = "'product_name' is not character type")
})

# Test that the 'current_price' column is numeric
test_that("'current_price' is numeric", {
  expect_true(is.numeric(cleaned_data$current_price), info = "'current_price' is not numeric")
})

# Test that the 'old_price' column is numeric
test_that("'old_price' is numeric", {
  expect_true(is.numeric(cleaned_data$old_price), info = "'old_price' is not numeric")
})

# Test that the 'month' column is numeric
test_that("'month' is numeric", {
  expect_true(is.numeric(cleaned_data$month), info = "'month' is not numeric")
})

# Test that the 'month' column contains only valid month values (1 to 12)
test_that("'month' contains valid month values", {
  invalid_months <- cleaned_data$month[!cleaned_data$month %in% 1:12]
  expect_true(length(invalid_months) == 0, info = paste("Invalid months found:", paste(invalid_months, collapse = ", ")))
})

# Test that 'old_price' is always greater than or equal to 'current_price'
test_that("'old_price' is greater than or equal to 'current_price'", {
  invalid_prices <- cleaned_data$old_price < cleaned_data$current_price
  expect_true(all(!invalid_prices), info = "Some 'old_price' values are less than 'current_price'")
})

# Test that there are no missing values in the dataset
test_that("no missing values in dataset", {
  missing_values <- sum(is.na(cleaned_data))
  expect_true(missing_values == 0, info = paste("Dataset contains", missing_values, "missing values"))
})

# Test that the 'vendor' column contains only valid vendor names
valid_vendors <- c("NoFrills", "Voila", "Loblaws", "SaveOnFoods", "Metro", "TandT", "Galleria", "Walmart")
test_that("'vendor' contains valid vendor names", {
  invalid_vendors <- unique(cleaned_data$vendor[!cleaned_data$vendor %in% valid_vendors])
  expect_true(length(invalid_vendors) == 0, info = paste("Invalid vendors found:", paste(invalid_vendors, collapse = ", ")))
})

# Test that the 'product_name' column contains only valid product names
test_that("'product_name' matches valid patterns", {
  invalid_products <- cleaned_data$product_name[!str_detect(tolower(cleaned_data$product_name), "yellow potato|white potato")]
  expect_true(length(invalid_products) == 0, info = paste("Invalid product names found:", paste(unique(invalid_products), collapse = ", ")))
})

# Test that the 'vendor' column contains at least 2 unique vendors
test_that("'vendor' column contains at least 2 unique vendors", {
  expect_true(length(unique(cleaned_data$vendor)) >= 2, info = "Less than 2 unique vendors found")
})

# Test that the 'product_name' column contains at least 2 unique products
test_that("'product_name' column contains at least 2 unique patterns", {
  product_patterns <- c("yellow potato", "white potato")
  matched_products <- unique(cleaned_data$product_name[str_detect(tolower(cleaned_data$product_name), paste(product_patterns, collapse = "|"))])
  expect_true(length(matched_products) >= 2, info = "Less than 2 unique product patterns found")
})
