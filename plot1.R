## Coursera Exploratory Data Analysis Assignment 2
##
##  Plot 1
##  Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
##  Make a plot showing the total PM2.5 emission from all sources for each of the years 
##  1999, 2002, 2005, and 2008
##  Use the base plotting system to make a plot answering this question.

library(dplyr)

##  Variables that specify the path to the downloaded data from UCI and to save copy of plot

data_folder <- "/Users/anthonyiannolo/course4data/"
data_folder2 <- "/Users/anthonyiannolo/ExData_Plotting2/"
##
##  Create strings to subsequently read the data and copy the data
##
summary_string <- paste(data_folder,"summarySCC_PM25.rds", sep="")
class_string <- paste(data_folder,"Source_Classification_Code.rds", sep="")
device_string <- paste(data_folder2, "plot1.png",sep="")
##                                                     
##  Read the plat data
##
NEI <- readRDS(summary_string)

##   

##Summarize Pollutant Data by Year
years <- group_by(NEI, year)
yearly_total <- summarize(years, Emissions=sum(Emissions,na.rm=TRUE))

##  Set up for proper size for PNG File
##
png(filename = device_string, width = 480, height = 480)

##  Create Plot
##
with(yearly_total, plot( year, Emissions, type="h",
                         ylab="Emissions", xlab="Year", lwd=20))
title(main="Total Emissions in the United States")

##
## Turn off Device
dev.off()
