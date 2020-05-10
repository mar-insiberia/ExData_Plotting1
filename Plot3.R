library(data.table)
library(lubridate)
library(lattice)
library(ggplot2)

download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", "household_power_consumption.zip")
path <- getwd()
unzip (zipfile = "household_power_consumption.zip")
list.files()

#Read data
hpc <- fread (input = "household_power_consumption.txt", 
              header = TRUE, sep = ";", 
              stringsAsFactors = FALSE,
              dec = ".")
# Format date and time
hpc [, Date_Time := as.POSIXct (paste (Date, Time), 
                                format = "%d/%m/%Y %H:%M:%S")]

# Select 2 first days from February (2007) and create another column with the selected date
subset <- hpc [(Date_Time >= "2007-02-01") & (Date_Time < "2007-02-03")]

# Plot 3
png ("Plot3.png", width = 480, height = 480)
plot (subset [, Date_Time], subset [, Sub_metering_1], 
      type = "l", 
      xlab = " ",
      ylab = "Energy sub metering")
lines (subset [, Date_Time], subset [, Sub_metering_2], col = "red")
lines (subset [, Date_Time], subset [, Sub_metering_3], col = "blue")
legend("topright",
       col = c ("black", "red", "blue"), 
       c ("Sub_metering_1", 
          "Sub_metering_2", 
          "Sub_metering_3"),
       lty = c(1,1), 
       lwd = c(1,1))

dev.off()
