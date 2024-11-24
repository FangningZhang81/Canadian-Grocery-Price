#### Preamble ####
# Purpose: Models... [...UPDATE THIS...]
# Author: Rohan Alexander [...UPDATE THIS...]
# Date: 11 February 2023 [...UPDATE THIS...]
# Contact: rohan.alexander@utoronto.ca [...UPDATE THIS...]
# License: MIT
# Pre-requisites: [...UPDATE THIS...]
# Any other information needed? [...UPDATE THIS...]


#### Workspace setup ####
library(ggplot2)
library(dplyr)

# Load analysis data
analysis_data <- read_csv("data/02-analysis_data/analysis_data.csv")

# Distribution of current_price by vendor
ggplot(analysis_data, aes(x = vendor, y = current_price)) +
  geom_boxplot() +
  labs(
    title = "Distribution of Current Price of Potatoes by Vendor",
    x = "Vendor",
    y = "Current Price"
  ) +
  theme_minimal()

# Distribution of current_price by month
ggplot(analysis_data, aes(x = as.factor(month), y = current_price)) +
  geom_boxplot() +
  labs(
    title = "Distribution of Current Price of Potatoes by Month",
    x = "Month",
    y = "Current Price"
  ) +
  theme_minimal()

# Distribution of old_price by vendor
ggplot(analysis_data, aes(x = vendor, y = old_price)) +
  geom_boxplot() +
  labs(
    title = "Distribution of Old Price of Potatoes by Vendor",
    x = "Vendor",
    y = "Old Price"
  ) +
  theme_minimal()

# Distribution of old_price by month
ggplot(analysis_data, aes(x = as.factor(month), y = old_price)) +
  geom_boxplot() +
  labs(
    title = "Distribution of Old Price of Potatoes by Month",
    x = "Month",
    y = "Old Price"
  ) +
  theme_minimal()

# Total number of products by month
ggplot(analysis_data, aes(x = as.factor(month))) +
  geom_bar(fill = "steelblue") +
  labs(
    title = "Total Number of Products by Month",
    x = "Month",
    y = "Total Products"
  ) +
  theme_minimal()

# Total number of products by vendor
ggplot(analysis_data, aes(x = vendor)) +
  geom_bar(fill = "grey") +
  labs(
    title = "Total Number of Products by Vendor",
    x = "Vendor",
    y = "Total Products"
  ) +
  theme_minimal()

# Scatterplot of current_price vs. old_price
analysis_data %>%
  group_by(old_price, current_price) %>%
  summarize(count = n()) %>%
  ggplot(aes(x = old_price, y = current_price, size = count)) +
  geom_point(alpha = 0.7) +
  labs(
    title = "Distribution of Current vs. Old Price of Potatoes (Point Size by Frequency)",
    x = "Old Price",
    y = "Current Price",
    size = "Frequency"
  ) +
  theme_minimal()
