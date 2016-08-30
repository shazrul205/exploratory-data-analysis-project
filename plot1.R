## plot1.R: Plot showing the total PM2.5 emission from all sources for each of 
##          the years 1999, 2002, 2005, and 2008.

require(dplyr)

##read the two files provided
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

##check if there is any negative values in the monitor readings
##any(NEI$Emissions < 0) ## FALSE (no sensor error)

##group by year and summarize the data frame by adding all emissions
##according to year
total<-NEI %>% 
        group_by(year) %>% 
        summarize(Total.Emissions = sum(Emissions,na.rm = TRUE))

##Open PNG device; create 'plot1.png' in the working directory
png(file = "plot1.png", width = 480, height = 480) 

##create a barplot to plot the trend in PM2.5 emissions from 1999 to 2008
barplot(height = total$Total.Emissions, names.arg = total$year,
        main=expression('Total Emission of PM'[2.5]*' 1999-2008'),
        xlab="Year", ylab=expression('PM'[2.5]*' emission (tons)'))

##Close the PNG file device
dev.off() 
