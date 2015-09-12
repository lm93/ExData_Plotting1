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

png(filename = "plot2.png", width = 480, height = 480)

plot(data$Time, data$Global_active_power, type="l", xlab = "", ylab = "Global Active Power (kilowatts)")

dev.off()