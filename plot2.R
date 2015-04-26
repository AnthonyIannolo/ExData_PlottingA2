##  Coursera Exploratory Data Analysis Assignment 2
##
##  Plot 2
##  Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510")
##  from 1999 to 2008?  
##  Use the base plotting system to make a plot answering this question.
##  
##  Variables that specify the path to the downloaded data from UCI and to save copy of plot
##
library(dplyr)

data_folder <- "/Users/anthonyiannolo/course4data/"
data_folder2 <- "/Users/anthonyiannolo/ExData_Plotting2/"
##
##  Create strings to subsequently read the data and copy the data
##
summary_string <- paste(data_folder,"summarySCC_PM25.rds", sep="")
class_string <- paste(data_folder,"Source_Classification_Code.rds", sep="")
device_string <- paste(data_folder2, "plot2.png",sep="")
##                                                     
##  Read the plat data
##
NEI <- readRDS(summary_string)

##
##  Subset to only keep Baltimore City
plot_data_subset <- subset(NEI, (NEI$fips == "24510"))

##  Rename variable fips to Baltimore City
plot_data_subset <- rename(plot_data_subset, Baltimore_City = fips)

##Summarize Pollutant Data by Year
years <- group_by(plot_data_subset, year)
yearly_total <- summarize(years, Emissions=sum(Emissions,na.rm=TRUE))

##  Set up for proper size for PNG File
##
png(filename = device_string, width = 480, height = 480)

##  Create Plot
##
with(yearly_total, plot( year, Emissions, type="h",
     ylab="Emissions", xlab="Year", lwd=20))
title(main="Total Emissions in Baltimore, Maryland")

##
## Turn off Device
dev.off()
