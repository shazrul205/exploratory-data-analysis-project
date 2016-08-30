require(ggplot2)

##read the two files provided
NEI <- readRDS("summarySCC_PM25.rds")

##extract SCC values that are from Baltimore City and with "ON-ROAD" source type
onRoad <- NEI[(NEI$fips == "24510") & (NEI$type == "ON-ROAD"),  ]

##convert the year variable to factor
onRoad$year <- as.factor(onRoad$year)

##--------------------##
##Explore the data
##--------------------##

##Open PNG device; create 'plot4.png' in the working directory
png(file = "plot5.png", width = 480, height = 480) 

##Use log10 to scale down the data
##Plot boxplots to see how the emissions from motor vehicles change over the years
ggplot(data=onRoad, aes(x=year, y=log10(Emissions))) +
  geom_boxplot(aes(fill=year)) + 
  stat_boxplot(geom ='errorbar') +
  labs(title = expression('PM'[2.5]*' Emissions from Motor Vehicles in Baltimore City'))+
  labs(x="Year", y=expression('log'[10]*' PM'[2.5]*' Emission'))
  
##Close the PNG file device
dev.off() 
