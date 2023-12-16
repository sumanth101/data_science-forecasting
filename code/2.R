library(ggplot2)  # for creating boxplots


df <- read.csv("child-mortality.csv")


library(dplyr)

# Assuming 'data' is your dataset
# Filter the dataset to include specific entity names
filtered_dataa <- df %>%
  filter(Entity %in% c("India", "Australia", "USA", "Afghanistan", "Pakistan", "China", "Russia", "Bangladesh", "Sri Lanka"))

# View the filtered dataset
print(filtered_dataa)
summary(filtered_dataa)
# Assuming 'filtered_data' is the filtered dataset

# Write the filtered data to a new CSV file
write.csv(filtered_dataa, file = "filtered_data.csv", row.names = FALSE)

df2 <- read.csv("filtered_data.csv")
names(df2)
summary(df2)


ggplot(df2, aes(x = Year, y = cmr, color = Entity)) +
  geom_line() +
  labs(title = "Child Mortality Rate Over the Years for Selected Countries",
       x = "Year",
       y = "Child Mortality Rate (%)") +
  theme_minimal()

df3 <- read.csv("imrace.csv")
names(df3)
summary(df3)

##########################################################################

data1 <- read.csv("filtered_data.csv")
data2 <- read.csv("imrace.csv")
dataCommon <- read.csv("global-child-mortality-timeseries.csv")

# Merge the datasets based on the 'Year' column
combined_data1 <- merge(dataCommon, data1, by = "Year", all = FALSE)
combined_data2 <- merge(dataCommon, data2, by = "Year", all = FALSE)

# Write the combined data to a new CSV file
write.csv(combined_data1, file = "combined_data1.csv", row.names = FALSE)
write.csv(combined_data2, file = "combined_data2.csv", row.names = FALSE)

# Assuming 'combined_data' is your combined dataset
names(combined_data1)
summary(combined_data1)

names(combined_data2)
summary(combined_data2)


# Create a boxplot to identify outliers
ggplot(combined_data1, aes(y = cmr)) +
  geom_boxplot() +
  labs(title = "Boxplot of Infant Mortality Rate")

ggplot(combined_data1, aes(y = Share.dying.in.first.5.years....)) +
  geom_boxplot() +
  labs(title = "Boxplot of Infant Mortality Rate")



# Create a density plot
ggplot(combined_data, aes(x = Share.dying.in.first.5.years...., fill = Entity.x)) +
  geom_density(alpha = 0.5) +
  labs(title = "Density Plot of Child Mortality Rate (CMR) Comparison",
       x = "Child Mortality Rate (CMR)",
       y = "Density")


ggplot(combined_data1, aes(x = Share.dying.in.first.5.years...., fill = Entity.x)) +
  geom_density(alpha = 0.5) +
  labs(title = "Density Plot of Child Mortality Rate (CMR) Comparison",
       x = "Child Mortality Rate (CMR)",
       y = "Density")

ggplot(combined_data2, aes(x = Year, y = `Infant.Mortality.Rate`, fill = Materal.Race.or.Ethnicity)) +
  geom_bar(stat = "identity", position = "dodge") +
  labs(title = "Infant Mortality Rate Across Years and Races",
       x = "Year",
       y = "Infant Mortality Rate") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

