## plot3.R: Plot showing total PM2.5 emission in Baltimore City in
##          the years 1999, 2002, 2005, and 2008 by various types of sources

require(dplyr)
require(ggplot2)

##read the two files provided
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

##select only data for Baltimore City, Maryland group by year and type
##then summarize the data frame by adding all emissions according to year
total<-NEI %>% 
  filter(fips == "24510") %>%
  group_by(type,year) %>%
  summarize(Total.Emissions = sum(Emissions,na.rm = TRUE))

##Open PNG device; create 'plot3.png' in the working directory
png(file = "plot3.png", width = 480, height = 480) 

##create a scatterplot using ggplot to see the trend in PM2.5 emissions
##from 1999 to 2008 by the different types of sources. And add a smoother
##with linear method to see if the emissions increases or decreases throughout
##the years
ggplot(total,aes(x=year,y = Total.Emissions))+
  geom_point()+
  geom_smooth(method="lm")+
  facet_grid(.~type)+
  labs(title = expression('PM'[2.5]*' Emissions in Baltimore City by Source Type'))+
  labs(x="Year", y=expression('PM'[2.5]*' Emission (tons)'))

##Close the PNG file device
dev.off() 
