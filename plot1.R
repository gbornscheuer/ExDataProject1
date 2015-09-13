# Course: Exploratory Data Analysis with R
# The following code is part of the Course Project 1 
# Date: 12-09-2015
# Name of the source code: plot1.R
#
suppressMessages(library(dplyr))
library(dplyr)
class <- c("character","character","numeric","numeric","numeric","numeric","numeric","numeric","numeric")
##
## The method used to read the data needed was very simple. 
## First I find out the date of the first record in the file, then calculate (15 days of december plus 31 day of january)* 24 * 60 is equal to 66240.
## Two days are 48*60 = 2880. So to make sure I get all the data I skip 60000 and read 10000
## and then subset the two days.
## New column with the date.
##
data <- read.csv("household_power_consumption.txt", sep = ";", skip = 60000, nrows = 10000, header=FALSE, na.strings = "?", colClasses = class)
datadaytime <- mutate(data, daytime = gsub(" ART", "", strptime(paste(data[,1],data[,2], sep=":"), "%d/%m/%Y:%H:%M:%S")))
subdata <- subset(datadaytime, format(as.Date(datadaytime[, 10]), "%Y-%m-%d") == "2007-02-01" | format(as.Date(datadaytime[, 10]), "%Y-%m-%d") == "2007-02-02")
png("plot1.png", width = 480, height = 480, units = "px")
hist(subdata$V3, col = "red", main ="Global Active Power", xlab = "Global Active Power (kilowatts)")
dev.off()
