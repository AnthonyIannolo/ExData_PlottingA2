##  Coursera Exploratory Data Analysis Assignment 2
##
##  Plot 3
##  Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, 
##  which of these four have seen decreases in emissions from 1999–2008 for Baltimore City? 
##  Which have seen increases in emissions from 1999–2008?
##  Use the ggplot2 plotting system to make a plot answer this question.
##  
##  Variables that specify the path to the downloaded data from UCI and to save copy of plot
##
library(dplyr)
library(ggplot2)

data_folder <- "/Users/anthonyiannolo/course4data/"
data_folder2 <- "/Users/anthonyiannolo/ExData_Plotting2/"
##
##  Create strings to subsequently read the data and copy the data
##
summary_string <- paste(data_folder,"summarySCC_PM25.rds", sep="")
class_string <- paste(data_folder,"Source_Classification_Code.rds", sep="")
device_string <- paste(data_folder2, "plot3.png",sep="")
##                                                     
##  Read the plat data
##
NEI <- readRDS(summary_string)
##
##  Subset to only keep Baltimore City
plot_data_subset <- subset(NEI, (NEI$fips == "24510"))

##Summarize Pollutant Data by type (point, nonpoint, onroad, nonroad)
years <- group_by(plot_data_subset, type, year)

yearly_total <- summarize(years, Emissions=sum(Emissions,na.rm=TRUE))

##  Set up for proper size for PNG File
##
png(filename = device_string, width = 480, height = 480)

##  Create plot
##
qplot(year, 
      data = yearly_total, 
      facets = . ~ type, 
      geom="bar", 
      weight=Emissions, 
      main=expression("Total emissions in Baltimore by Source"),
      xlab="Years",
      ylab = "Emissions",
      binwidth = 0.5)

##
## Turn off Device
dev.off()
