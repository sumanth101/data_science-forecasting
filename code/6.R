# Load necessary packages
library(dplyr)
library(ggplot2)

# Assuming your dataset is stored in a CSV file named 'your_data.csv'
your_data <- read.csv("combined_data1 - Copy.csv")

# Plot linear regression models for each country
plots <- your_data %>%
  group_by(country) %>%
  do(plot_data = ggplot(., aes(x = Year, y = cmr)) +
       geom_point() +
       geom_smooth(method = "lm", se = FALSE) +
       labs(title = paste("Linear Regression Model for", unique(.$country)),
            x = "Year", y = "Crude Mortality Rate"))

# Save the plots
for (i in seq_along(plots$plot_data)) {
  ggsave(paste0("linear_regression_plot_", i, ".png"), plots$plot_data[[i]])
}

# Function to calculate performance metrics
calculate_metrics <- function(model, data) {
  predictions <- predict(model, data)
  metrics <- data.frame(
    RMSE = sqrt(mean((data$cmr - predictions)^2)),
    R2 = cor(predictions, data$cmr)^2
  )
  return(metrics)
}

# Calculate metrics for each country
metrics_list <- your_data %>%
  group_by(country) %>%
  do(metrics = calculate_metrics(lm(cmr ~ Year + dying, data = .), .))

# Print metrics
print(metrics_list$metrics)

# Save the metrics to a CSV file
write.csv(metrics_list$metrics, "performance_metrics.csv", row.names = FALSE)

