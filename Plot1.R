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

# Plot 1

png(filename = "plot1.png", width = 480, height = 480, units = "px")
par(mfrow = c(1,1))
hist(data$Global_active_power, 12, freq=TRUE, col = "red",main = "Global Active Power", xlab = "Global Active Power (kilowatts)", ylim = c(0,1200))
dev.off()
