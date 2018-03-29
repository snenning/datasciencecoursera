# Coursera Exploratory Data Analysis: Week 1 project
#Plot1

## get data from url and unzip

url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

download.file(url, "exdata_data_household_power_consumption.zip")
unzip("exdata_data_household_power_consumption.zip", "household_power_consumption.txt")

## load file to R

hhpowercons <- read.table("household_power_consumption.txt", sep = ";", header = TRUE, stringsAsFactors = FALSE, na.strings=c("?"))

## adding columns with date
hhpowercons$Datec <- as.Date(hhpowercons$Date, format = "%d/%m/%Y")

## subsetting data to "2007-02-01" and "2007-02-02"
hhpowercons <- subset(hhpowercons, (Datec == "2007-02-01" | Datec =="2007-02-02"))

## adding columns with datetime
hhpowercons$DateTime <- strptime(paste(hhpowercons$Date,hhpowercons$Time, sep = " "), format = "%d/%m/%Y %H:%M:%S")

## remove incomplete records
hhpowercons <- hhpowercons[complete.cases(hhpowercons$Global_active_power), ]


## create plot 1 as png with size 480x480 pixels

png(filename="plot1.png", width = 480, height = 480, units = "px")

with(hhpowercons, hist(Global_active_power, col = "red", xlab = "Global Active Power (kilowatts)", main = "Global Active Power"))

dev.off()
