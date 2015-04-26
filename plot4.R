##  Coursera Exploratory Data Analysis Assignment 2
##
##  Plot 4
##  Across the United States, how have emissions from coal combustion-related sources 
##  changed from 1999–2008?
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
device_string <- paste(data_folder2, "plot4.png",sep="")
##                                                     
##  Read the plat data
##
NEI <- readRDS(summary_string)
SCC <- readRDS(class_string)
##

##  Subset to only keep only Coal Combustion Sources
data_coal <- SCC[grepl("Coal", SCC$Short.Name) &
                 grepl("Comb", SCC$Short.Name), ]

##  Merge the Emissions and Classiifcation Data
merged_data <- merge(NEI, data_coal, by.x="SCC", by.y="SCC")

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
      main=expression("Total emissions from Coal Combustion Sources in US"),
      xlab="Years",
      ylab = "Emissions",
      binwidth = 0.5)

## Turn off Device
dev.off()
