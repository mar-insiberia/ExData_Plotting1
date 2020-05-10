
library(data.table)
library(lubridate)
library(lattice)
library(ggplot2)

download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", "household_power_consumption.zip")
path <- getwd()
unzip (zipfile = "household_power_consumption.zip")
list.files()

# Rread the data 
hpc <- fread (input = "household_power_consumption.txt", 
              header = TRUE, sep = ";", 
              stringsAsFactors = FALSE,
              dec = ".")

# Select the two first days in February (2007) 
subset <- hpc [hpc$Date %in% c("1/2/2007","2/2/2007") ,]
Date_Time <- strptime (paste (subset$Date, subset$Time, sep = " "), "%d/%m/%Y %H:%M:%S") 

# Set column classes
subset [, Global_active_power := lapply (.SD, as.numeric), .SDcols = "Global_active_power"]

## Plot 1
png ("Plot1.png", width = 480, height = 480) 
hist (subset$Global_active_power, 
      col = "red", 
      xlab = "Global Active Power (kilowatts)",
      ylab = "Frequency",
      main = "Global Active Power")
dev.off()
