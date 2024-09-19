#Cheking you work directory
getwd()

# Load necessary libraries
library(ggplot2)
library(dplyr)

# Load data 
soil_data <- read.csv("Soil_moisture_Data.csv")

# Assuming your data is already loaded into soil_data and filtered for 2016-2019
soil_data_filtered <- soil_data %>%
  filter(Year >= 2016 & Year <= 2019)

# Create the line chart
ggplot(soil_data_filtered, aes(x=Year, y=Volumetric_water_content)) +
  stat_summary(geom = "line", fun = "mean", color = "blue") +  # Line based on average Volumetric_water_content per year
  stat_summary(geom = "point", fun = "mean", color = "red", size = 2) + # Points for each year
  ggtitle("Average Volumetric Water Content (VWC) from 2016 to 2019") +
  xlab("Year") +
  ylab("Average Volumetric Water Content") +
  theme_minimal()
#
#
# Monthly line chart
#
# Assuming your data is already loaded into soil_data and filtered for 2016-2019
soil_data_filtered <- soil_data %>%
  filter(Year >= 2016 & Year <= 2019)

# Convert the Date column to Date format if it's not already
soil_data_filtered$Date <- as.Date(soil_data_filtered$Date, format = "%m/%d/%Y")

# Create a Month-Year column for grouping by both Month and Year
soil_data_filtered <- soil_data_filtered %>%
  mutate(Month_Year = format(Date, "%Y-%m"))  # Extract Year-Month in YYYY-MM format

# Group by Month_Year and calculate the average Volumetric Water Content
monthly_avg_vwc <- soil_data_filtered %>%
  group_by(Month_Year) %>%
  summarize(Avg_VWC = mean(Volumetric_water_content, na.rm = TRUE))

# Create the line chart
ggplot(monthly_avg_vwc, aes(x=Month_Year, y=Avg_VWC, group=1)) +
  geom_line(color="blue") +
  geom_point(color="red") +
  ggtitle("Average Volumetric Water Content by Month (2016-2019)") +
  xlab("Month-Year") +
  ylab("Average Volumetric Water Content") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))  # Rotate x-axis labels for readability