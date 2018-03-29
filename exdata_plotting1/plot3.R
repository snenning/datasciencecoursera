# Coursera Exploratory Data Analysis: Week 1 project
#Plot3

## get data from url and unzip

url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(url, "exdata_data_household_power_consumption.zip")
unzip("exdata_data_household_power_consumption.zip", "household_power_consumption.txt")

## load file to R
hhpowercons <- read.table("household_power_consumption.txt", sep = ";", header = TRUE, stringsAsFactors = FALSE, na.strings=c("?"))

## adding columns with date to allow subsetting
hhpowercons$Datec <- as.Date(hhpowercons$Date, format = "%d/%m/%Y")

## subsetting data to "2007-02-01" and "2007-02-02"
hhpowercons <- subset(hhpowercons, (Datec == "2007-02-01" | Datec =="2007-02-02"))

## adding columns with datetime
hhpowercons$DateTime <- strptime(paste(hhpowercons$Date,hhpowercons$Time, sep = " "), format = "%d/%m/%Y %H:%M:%S")

## remove incomplete records
hhpowercons <- hhpowercons[complete.cases(hhpowercons$Global_active_power), ]


## create plot 3 as png with size 480x480 pixels

png(filename="plot3.png", width = 480, height = 480, units = "px")

with(hhpowercons, 
     plot(DateTime, Sub_metering_1, type = "l"
          , xlab = "", ylab = "Energy sub metering", col = "black", main = "")
)
with(hhpowercons, lines(DateTime, Sub_metering_2, col = "red"))
with(hhpowercons, lines(DateTime, Sub_metering_3, col = "blue"))
legend("topright",  pch = "_", col = c( "black", "red",  "blue"), legend= c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

dev.off()

