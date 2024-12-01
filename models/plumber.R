library(plumber)
library(rstanarm)
library(tidyverse)

# Load the Bayesian regression model from an RDS file
model <- readRDS("first_model.rds")

# Define the model version number
version_number <- "1.0.0"

# Define the variables used in the model
variables <- list(
  old_price = "The previous price of the product, numeric value.",
  vendor = "The vendor identifier, categorical - Metro, Loblaw, NoFrills, SaveOnFoods, Walmart",
  month = "The month of the year, categorical value."
)

#* Define the parameters for the price prediction function
#* @param old_price The previous price of the product, numeric value.
#* @param vendor The vendor identifier, categorical value - Metro, Loblaw, NoFrills, SaveOnFoods, Walmart.
#* @param month The month of the year, categorical value from 1 to 12.
#* @get /predict_price
predict_price <- function(old_price = 2.00, vendor = "Metro", month = 7) {
  # Convert input parameters to appropriate types
  old_price <- as.numeric(old_price)
  vendor <- as.character(vendor)
  month <- as.character(month)
  
  # Prepare the input data as a data frame
  payload <- data.frame(
    old_price = old_price,
    vendor = vendor,
    month = month
  )
  
  # Extract posterior samples from the model
  posterior_samples <- as.matrix(model)
  
  # Define the coefficients for the prediction model
  beta_old_price <- posterior_samples[, "old_price"]
  beta_vendor_metro <- posterior_samples[, "vendorMetro"]
  beta_vendor_nofrills <- posterior_samples[, "vendorNoFrills"]
  beta_vendor_saveonfoods <- posterior_samples[, "vendorSaveOnFoods"]
  beta_vendor_walmart <- posterior_samples[, "vendorWalmart"]
  beta_month7 <- posterior_samples[, "month7"]
  beta_month8 <- posterior_samples[, "month8"]
  beta_month9 <- posterior_samples[, "month9"]
  beta_month10 <- posterior_samples[, "month10"]
  beta_month11 <- posterior_samples[, "month11"]
  alpha <- posterior_samples[, "(Intercept)"]
  
  # Calculate the predicted price based on the input values
  predicted_values <- alpha +
    beta_old_price * payload$old_price +
    ifelse(payload$vendor == "Metro", beta_vendor_metro, 0) +
    ifelse(payload$vendor == "NoFrills", beta_vendor_nofrills, 0) +
    ifelse(payload$vendor == "SaveOnFoods", beta_vendor_saveonfoods, 0) +
    ifelse(payload$vendor == "Walmart", beta_vendor_walmart, 0) +
    ifelse(payload$month == "7", beta_month7, 0) +
    ifelse(payload$month == "8", beta_month8, 0) +
    ifelse(payload$month == "9", beta_month9, 0) +
    ifelse(payload$month == "10", beta_month10, 0) +
    ifelse(payload$month == "11", beta_month11, 0)
  
  # Calculate the mean prediction value
  mean_prediction <- mean(predicted_values)
  
  # Store the predicted price in a result list
  result <- list(
    "estimated_price" = mean_prediction
  )
  
  return(result)
}
