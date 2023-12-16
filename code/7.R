# Load necessary packages
library(dplyr)
library(tree)
library(ggplot2)

# Load your dataset from the CSV file
your_data <- read.csv("combined_data1 - Copy.csv")

# Group by country
grouped_data <- your_data %>%
  group_by(country)

# Perform linear regression for each country
linear_models <- grouped_data %>%
  do(model = lm(cmr ~ Share.surviving.first.5.years.of.life.... + dying, data = .))

# Display the linear regression summaries for each country
print(lapply(linear_models$model, summary))

# Decision Tree Regression (you can adapt this for each country if needed)
tree_model <- tree(cmr ~ Share.surviving.first.5.years.of.life.... + dying, data = your_data)

# Display the decision tree plot
plot(tree_model)
text(tree_model)

# Predict with the decision tree model
prediction_tree <- predict(tree_model, your_data)

# Display the predicted values
print(prediction_tree)

# Save the results to a CSV file
results <- data.frame(
  Linear_Prediction = predict(linear_models$model[[1]], your_data),
  Decision_Tree_Prediction = prediction_tree
)

write.csv(results, "regression_results.csv", row.names = FALSE)

# Plot linear regression models for each country
plot_list <- lapply(linear_models$model, function(model) {
  ggplot(your_data, aes(x = Share.surviving.first.5.years.of.life...., y = cmr, color = country)) +
    geom_point() +
    geom_smooth(method = "lm", se = FALSE) +
    labs(title = paste("Linear Regression Model for", unique(your_data$country)), x = "Share of Surviving First 5 Years of Life", y = "Crude Mortality Rate")
})

# Save the plots
for (i in seq_along(plot_list)) {
  ggsave(paste0("linear_regression_plot_", i, ".png"), plot_list[[i]])
}


########################################################################################################

# Calculate R-squared for decision tree model
r2_tree <- 1 - sum((your_data$cmr - prediction_tree)^2) / sum((your_data$cmr - mean(your_data$cmr))^2)

# Calculate Root Mean Squared Error (RMSE) for decision tree model
rmse_tree <- sqrt(mean((your_data$cmr - prediction_tree)^2))

# Display the results
cat("R-squared for Decision Tree Model:", r2_tree, "\n")
cat("RMSE for Decision Tree Model:", rmse_tree, "\n")

##########################################################################################################

# Initialize empty vectors to store results
r2_linear <- numeric(length(linear_models$model))
rmse_linear <- numeric(length(linear_models$model))

# Loop through each linear regression model
for (i in seq_along(linear_models$model)) {
  # Predict with the linear regression model
  prediction_linear <- predict(linear_models$model[[i]], your_data)
  
  # Calculate R-squared
  r2_linear[i] <- summary(linear_models$model[[i]])$r.squared
  
  # Calculate Root Mean Squared Error (RMSE)
  rmse_linear[i] <- sqrt(mean((your_data$cmr - prediction_linear)^2))
}

# Display the results for each linear regression model
for (i in seq_along(linear_models$model)) {
  cat("Linear Regression Model for", unique(your_data$country)[i], "\n")
  cat("R-squared:", r2_linear[i], "\n")
  cat("RMSE:", rmse_linear[i], "\n")
  cat("\n")
}

