library(data.table)
library(lubridate)
library(lattice)
library(ggplot2)

#Read data
hpc <- fread (input = "household_power_consumption.txt", 
              header = TRUE, sep = ";", 
              stringsAsFactors = FALSE,
              dec = ".")

# Format date and time
hpc [, Date_Time := as.POSIXct (paste (Date, Time),
                                format = "%d/%m/%Y %H:%M:%S")]

# Select the 2 first days of February (2007)
hpc <- hpc [(Date_Time >= "2007-02-01") & (Date_Time < "2007-02-03")]


# Plot 4 graphs in a pannel (2,2)  
png ("Plot4.png", width = 480, height = 480)
par (mfrow = c(2,2))
plot (hpc [, Date_Time], hpc [, Global_active_power], 
      type = "l", 
      xlab = "", 
      ylab = "Global active power")
plot (hpc [, Date_Time], hpc [, Voltage], 
      type = "l", 
      xlab = "datetime", 
      ylab = "Voltage")
plot (hpc [, Date_Time], hpc [, Sub_metering_1], 
      type = "l",
      xlab = "", 
      ylab = "Energy sub metering")
lines (hpc [, Date_Time], hpc [, Sub_metering_2], col = "red")
lines (hpc [, Date_Time], hpc [, Sub_metering_3], col = "blue")
legend ("topright", 
        col = c("black", "red", "blue"),
        c ("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
        lty = c(1,1),
        bty = "n", 
        cex = .5) 
plot (hpc [, Date_Time], hpc [,Global_reactive_power], 
      type = "l", 
      xlab = "datetime",
      ylab = "Global reactive power")

dev.off()

