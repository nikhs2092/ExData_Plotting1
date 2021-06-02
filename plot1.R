# Exploratory Data Analysis Course Project 1
# Plot 1

## Loads necessary packages
library(dplyr)
library(lubridate)

## Reads the data file into "data"
data <- read.table("household_power_consumption.txt", header = TRUE, sep = ";")

## Converts the Data, Time and Global_active _power columns into appropriate 
## classes, and selecting the rows needed.
plotdata <- data %>% 
        mutate(Date = dmy(Date), Time = hms(Time), Global_active_power = 
                       as.numeric(Global_active_power)) %>% 
        filter(Date == "2007-02-01" | Date == "2007-02-02") %>%
        filter(!is.na(Global_active_power))

## Plots a histogram of the Global Active Power column into a .png file
png(file = "plot1.png")
hist(plotdata$Global_active_power, main = "Global Active Power", col = "red", 
     xlab = "Global Active Power (kilowatts)")
dev.off()

rm(data, plotdata)