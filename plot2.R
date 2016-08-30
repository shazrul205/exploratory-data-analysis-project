## plot2.R: Plot showing total PM2.5 emission in Baltimore City in
##          the years 1999, 2002, 2005, and 2008.

require(dplyr)

##read the two files provided
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

##select only data for Baltimore City, Maryland group by year then summarize 
##the data frame by adding all emissions according to year
total<-NEI %>% 
        filter(fips == "24510") %>%
        group_by(year) %>%
        summarize(Total.Emissions = sum(Emissions,na.rm = TRUE))

##Open PNG device; create 'plot2.png' in the working directory
png(file = "plot2.png", width = 480, height = 480) 

##create a barplot to plotthe trend in PM2.5 emissions from 1999 to 2008
barplot(height = total$Total.Emissions, names.arg = total$year,
        main=expression('Total Emission of PM'[2.5]*' in Baltimore City, Maryland'),
        xlab="Year", ylab=expression('PM'[2.5]*' emission (tons)'))

##Close the PNG file device
dev.off() 
