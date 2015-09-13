# Course: Exploratory Data Analysis with R
# The following code is part of the Course Project 1 
# Date: 12-09-2015
# Name of the source code: plot1.R
#
suppressMessages(library(dplyr))
library(dplyr)
class <- c("character","character","numeric","numeric","numeric","numeric","numeric","numeric","numeric")
##
## To read the file it must be in the working directory
## The method used to read the data needed was very simple. 
## First I find out the date of the first record in the file, then calculate (15 days of december plus 31 day of january)* 24 * 60 is equal to 66240.
## Two days are 48*60 = 2880. So to make sure I get all the data I skip 60000 and read 10000
## and then subset the two days.
## New column with the date.
## On purpose I did not change the col names because they are few and prefer short names if you have list of them and must use xlab and ylab
##
data <- read.csv("household_power_consumption.txt", sep = ";", skip = 60000, nrows = 10000, header=FALSE, na.strings = "?", colClasses = class)
datadaytime <- mutate(data, daytime = gsub(" ART", "", strptime(paste(data[,1],data[,2], sep=":"), "%d/%m/%Y:%H:%M:%S")))
subdata <- subset(datadaytime, format(as.Date(datadaytime[, 10]), "%Y-%m-%d") == "2007-02-01" | format(as.Date(datadaytime[, 10]), "%Y-%m-%d") == "2007-02-02")
subdata$posix <- as.POSIXlt(subdata$daytime)
##
## This is necessary to see the daynames in English 
##
Sys.setlocale("LC_TIME", "English")
png("plot4.png", width = 480, height = 480, units = "px")
par(mfrow = c(2,2))
with(subdata, {
  plot(subdata$posix, subdata$V3, type ="l", ylab = "Global Active Power", xlab = "")
  plot(subdata$posix, subdata$V5, type ="l", ylab = "Voltage", xlab = "datetime")
  with(subdata, plot(subdata$posix, subdata$V7, type ="n", ylab = "Energy sub metering", xlab = ""))
  points(subdata$posix, subdata$V8, type ="l", col ="red")
  points(subdata$posix, subdata$V9, type ="l", col ="blue")
  points(subdata$posix, subdata$V7, type ="l", col = "black")
  legend("topright", inset = 0.02, lty = 1, xjust = 1, box.lty = 0, cex = 0.8, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  plot(subdata$posix, subdata$V4, type ="l", ylab = "Global_reactive_power", xlab = "datetime")
})
dev.off()
Sys.setlocale("LC_TIME", "Spanish_Chile.1252")

