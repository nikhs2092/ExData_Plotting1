# Exploratory Data Analysis Course Project 1
# Plot 2

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
        filter(!is.na(Global_active_power)) %>%

## Creates a new column with the full date (date + time) of each measurement
        mutate(datetime = Date + Time)

## Plots a line scatter plot of the full date column vs the Global Active Power 
# column into a .png file 
png(file = "plot2.png")
with(plotdata, plot(datetime, Global_active_power, type = "l",
                    xlab = "", ylab = "Global Active Power (kilowatts)"))
dev.off()

rm(data, plotdata)