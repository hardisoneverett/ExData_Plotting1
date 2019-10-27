library(dplyr)
library(lubridate)

# Reads in data
raw_data<-read.table("household_power_consumption.txt", header = TRUE, sep = ";", stringsAsFactors = FALSE)

# Dates of interest
start_date<-"2007/2/1"
end_date<-"2007/2/2"

# Filters and formats data.
data<- raw_data%>%
  mutate(Date = dmy(Date),Time = hms(Time), Date_Time = as.POSIXct(Date + Time), Global_active_power= as.numeric(Global_active_power),
         Voltage = as.numeric(Voltage, Global_reactive_power = as.numeric(Global_reactive_power)))%>%
  filter(Date >= start_date & Date <= end_date)

# Plot 3
png(filename = "plot3.png", width = 480, height = 480, units = "px")
par(mfrow = c(1,1))
plot(x = data$Date_Time, y = data$Sub_metering_1, type = "l", lty = 1, ylab = "Energy Sub Metering", xlab = "")
lines(x = data$Date_Time, y = data$Sub_metering_2, type = "l", col = "red")
lines(x = data$Date_Time, y = data$Sub_metering_3, type = "l", col = "blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black","red","blue"), lty = 1, cex = 0.8)
dev.off()
