##  Coursera Exploratory Data Analysis Assignment 2
##
##  Plot 5
##  How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?
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
device_string <- paste(data_folder2, "plot5.png",sep="")
##                                                     
##  Read the plat data
##
NEI <- readRDS(summary_string)
SCC <- readRDS(class_string)
##
##  Subset to only keep vehicle emissions
plot_data_subset <- subset(SCC, (Data.Category == "Onroad"))

##  Subset to only keep Baltimore City
plot_data_subset2 <- subset(NEI, (NEI$fips == "24510"))

##  Merge the Baltimore Vehicle Emissions and Classiifcation Data
merged_data <- merge(plot_data_subset, plot_data_subset2, by.x="SCC", by.y="SCC")

##  Group the data by Year
merged_data <- group_by(merged_data, year)

##  Summarize Data by Year
plot_sum <- summarize(merged_data, Emissions=sum(Emissions,na.rm=TRUE))

##  Set up for proper size for PNG File
##
png(filename = device_string, width = 480, height = 480)

##  Create plot
##

qplot(year, 
      data = plot_sum, 
      geom="bar", 
      weight=Emissions, 
      main=expression("Total emissions from motor vehicle sources in Baltimore"),
      xlab="Years",
      ylab = "Emissions",
      binwidth = 0.5)


## Turn off Device
dev.off()
