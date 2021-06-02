# Exploratory Data Analysis Course Project 1
# Plot 4

## Loads necessary packages
library(dplyr)
library(lubridate)

## Reads the data file into "data"
data <- read.table("household_power_consumption.txt", header = TRUE, sep = ";")

## Converts the Data, Time and the Sub_metering columns into appropriate 
## classes, and selecting the rows needed.
plotdata <- data %>% 
        mutate(Date = dmy(Date), Time = hms(Time),
               Global_active_power = as.numeric(Global_active_power),
               Voltage = as.numeric(Voltage),
               Global_reactive_power = as.numeric(Global_reactive_power),
               Sub_metering_1 = as.numeric(Sub_metering_1), 
               Sub_metering_2 = as.numeric(Sub_metering_2), 
               Sub_metering_3 = as.numeric(Sub_metering_3)) %>% 
        filter(Date == "2007-02-01" | Date == "2007-02-02") %>%
        filter(!is.na(Global_active_power), !is.na(Voltage), 
               !is.na(Global_reactive_power), !is.na(Sub_metering_1), 
               !is.na(Sub_metering_2), !is.na(Sub_metering_3)) %>%
        
## Creates a new column with the full date (date + time) of each measurement
        mutate(datetime = Date + Time)

## Determines the plot grid and opens the graphics device
png(file = "plot4.png")
par(mfrow = c(2,2))

## Plots a line scatter plot of the full date column vs the Global Active Power 
# column
plot(plotdata$datetime, plotdata$Global_active_power, type = "l",
                    xlab = "", ylab = "Global Active Power (kilowatts)")

## Plots a line scatter plot of the full date column vs the Voltage 
# column
plot(plotdata$datetime, plotdata$Voltage, type = "l",
                    xlab = "datetime", ylab = "Voltage")

## Plots a line scatter plot of the full date column vs the Sub_metering 
# columns with the appropriate legend into a .png file 
x <- plotdata$datetime
y1 <- plotdata$Sub_metering_1
y2 <- plotdata$Sub_metering_2
y3 <- plotdata$Sub_metering_3
plot(x, y1, type = "n", xlab = "", ylab = "Energy sub meeting")
points(x, y1, type = "l", col = "black")
points(x, y2, type = "l", col = "red")
points(x, y3, type = "l", col = "blue")
legend("topright", 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       col = c("black", "red", "blue"), lty = 1)

## Plots a line scatter plot of the full date column vs the Global Reactive 
# Power column
plot(plotdata$datetime, plotdata$Global_reactive_power, type = "l",
                    xlab = "datetime", ylab = "Global_reactive_power")

dev.off()

rm(data, plotdata, x, y1, y2, y3)