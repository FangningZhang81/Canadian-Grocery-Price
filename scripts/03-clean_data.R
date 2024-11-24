#### Preamble ####
# Purpose: Cleans the raw plane data recorded by two observers..... [...UPDATE THIS...]
# Author: Rohan Alexander [...UPDATE THIS...]
# Date: 6 April 2023 [...UPDATE THIS...]
# Contact: rohan.alexander@utoronto.ca [...UPDATE THIS...]
# License: MIT
# Pre-requisites: [...UPDATE THIS...]
# Any other information needed? [...UPDATE THIS...]

#### Workspace setup ####
library(tidyverse)
library(arrow)
library(janitor)
library(lubridate)

#### Clean data ####
raw_data <- read_csv("~/Desktop/hammer-4-raw.csv")
product_data <- read_csv("~/Desktop/hammer-4-product.csv")

joined_data <- raw_data %>%
  inner_join(product_data, by = c("product_id" = "id")) %>%
  select(
    nowtime,
    vendor,
    product_id,
    product_name,
    brand,
    current_price,
    old_price,
    units,
    price_per_unit
  )

cleaned_data <- joined_data %>%
  select(nowtime, vendor, current_price, old_price, product_name) %>%
  mutate(
    month = month(nowtime),
    current_price = parse_number(current_price),
    old_price = parse_number(old_price)
  ) %>%
  filter(str_detect(tolower(product_name), "yellow potato|white potato")) %>%
  select(-nowtime)%>%
  tidyr::drop_na()

#### Save data ####
write_csv(x = cleaned_data, file = "data/02-analysis_data/analysis_data.csv")

