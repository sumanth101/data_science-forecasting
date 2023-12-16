# Install and load necessary packages
install.packages(c("forecast", "dplyr"))
library(forecast)
library(dplyr)

# Load your dataset from the CSV file
your_data <- read.csv("combined_data2 - Copy.csv")

# Load necessary packages
library(dplyr)

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
         Ratio = Dying / IMR)

# Display the results
print(world_data[, c("Year", "Difference", "Ratio")])

