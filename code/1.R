# Required packages
library(shiny)
library(dplyr)
library(ggplot2)
library(readr)
library(sm)

# Read in data
introData <- read.csv("global-child-mortality-timeseries.csv", stringsAsFactors = FALSE)
data2 <- introData %>% mutate(Share.surviving.first.5.years.of.life.... = Share.surviving.first.5.years.of.life.... +
                               Share.dying.in.first.5.years....)
library(ggplot2)

# Assuming 'introData' is your dataset

# Filter the data
data <- introData

# Create the plot
ggplot(data, aes(x = Year, y = Share.surviving.first.5.years.of.life.... + Share.dying.in.first.5.years...., fill = "Share surviving")) +
  geom_area(alpha = 0.7) +
  geom_line(aes(y = Share.dying.in.first.5.years...., color = "Share dying")) +
  labs(title = "Global Child Mortality",
       x = "Year",
       y = "Percent",
       fill = "Legend",
       color = "Legend") +
  scale_fill_manual(values = "#F5FF8D") +
  scale_color_manual(values = "#50CB86")

######################################################


ggplot(data, aes(x = Year, y = Share.surviving.first.5.years.of.life....)) +
  geom_line() +
  labs(title = "Share Surviving First 5 Years of Life Over Time", 
       x = "Year", 
       y = "Share Surviving")

######################################################

ggplot(data, aes(x = Year, y = Share.surviving.first.5.years.of.life...., fill = "Share surviving")) +
  geom_area(alpha = 0.7) +
  labs(title = "Share Surviving First 5 Years of Life Over Time", 
       x = "Year", 
       y = "Share Surviving",
       fill = "Legend")



######################################################





























# Density Plot
ggplot(data, aes(x = Share.surviving.first.5.years.of.life....)) +
  geom_density() +
  labs(title = "Density Plot of Share Surviving First 5 Years of Life",
       x = "Share Surviving",
       y = "Density")

# Scatter Plot:

ggplot(data, aes(x = Year, y = Share.surviving.first.5.years.of.life....)) +
  geom_point() +
  labs(title = "Scatter Plot of Share Surviving First 5 Years of Life Over Time",
       x = "Year",
       y = "Share Surviving")


# Box plot
ggplot(data, aes(x = "", y = Share.surviving.first.5.years.of.life....)) +
  geom_boxplot() +
  labs(title = "Box Plot of Share Surviving First 5 Years of Life",
       x = "",
       y = "Share Surviving")

