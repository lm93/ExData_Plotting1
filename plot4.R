## Load just the needed dates (1440 observations per day)
data <- read.table(file = "household_power_consumption.txt", sep=";", header=FALSE, na.strings="?", 
                   skip=grep("1/2/2007", readLines("household_power_consumption.txt")) - 1, nrows=2880)

## Set the names for columns in data frame
names(data) <- strsplit(readLines("household_power_consumption.txt", n=1), split=";")[[1]]


## Convert times to native format
Date_Time <- paste(data$Date, data$Time)
data$Time <- strptime(Date_Time, format = "%d/%m/%Y %H:%M:%S")
rm(Date_Time)

## Convert dates to native format
data$Date <- as.Date(data$Date, format="%d/%m/%Y")

## Specific plotting code

png(filename = "plot4.png", width = 480, height = 480)
par(mfcol = c(2,2))

## Plot 1
plot(data$Time, data$Global_active_power, type="l", xlab = "", ylab = "Global Active Power")

## Plot 2
plot(data$Time, data$Sub_metering_1, type="l", col = "black", xlab = "", ylab = "", ylim = c(0,40))

par(new = TRUE)
plot(data$Time, data$Sub_metering_2, type="l", col = "red", xlab = "", ylab = "", ylim = c(0,40))

par(new = TRUE)
plot(data$Time, data$Sub_metering_3, type="l", col = "blue", xlab = "", ylab = "", ylim = c(0,40))

title(ylab = "Energy sub metering")

legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = c(1,1,1), col = c("black", "red", "blue"), bty = "n")

## Plot 3
plot(data$Time, data$Voltage, type="l", xlab = "datetime", ylab = "Voltage")

## Plot 4
plot(data$Time, data$Global_reactive_power, type="l", xlab = "datetime", ylab = "Global_reactive_power")

dev.off()