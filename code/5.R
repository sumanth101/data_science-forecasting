# Install and load necessary packages
install.packages(c("forecast", "dplyr"))
# Load necessary packages
library(dplyr)
library(DT)

# Assuming your dataset is stored in a data frame named your_data
# Filter the data for the 'World' entity
world_data <- your_data %>%
  filter(Entity == "World")

# Rename the variables
world_data <- world_data %>%
  rename(Dying = dying,
         IMR = imr)

# Calculate the difference or ratio between 'Dying' and 'IMR'
world_data <- world_data %>%
  mutate(Difference = Dying - IMR,
         Ratio = Dying / IMR,
         BetterOrWorse = ifelse(Difference > 0, "Worse", ifelse(Difference < 0, "Better", "Equal")))

# Display the results with colored background
datatable(world_data[, c("Year", "Materal_Ethnicity", "Difference", "Ratio", "BetterOrWorse")]) %>%
  formatStyle(
    'BetterOrWorse',
    backgroundColor = JS(
      "function(value) {",
      "  switch(value) {",
      "    case 'Better': return 'green';",
      "    case 'Worse': return 'red';",
      "    default: return 'white';",
      "  }",
      "}"
    )
  )

# Write the results to a CSV file
write.csv(world_data[, c("Year", "Materal_Ethnicity", "Difference", "Ratio", "BetterOrWorse")], "world_data_results.csv", row.names = FALSE)

