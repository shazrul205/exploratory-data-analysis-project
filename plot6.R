require(ggplot2)

##read the two files provided
NEI <- readRDS("summarySCC_PM25.rds")

##extract SCC values that are from Baltimore City and Los Angeles
baltimore <- NEI[(NEI$fips == "24510"),  ]
losangeles <- NEI[(NEI$fips == "06037"),  ]

##Add the variable County into both datasets
baltimore$County <- "Baltimore City, Maryland"
losangeles$County <- "Los Angeles, Calfornia"

## Combine both the data
baltimore.losangeles <- rbind(baltimore, losangeles)

##convert the year variable to factor
baltimore.losangeles$year <- as.factor(baltimore.losangeles$year)

##--------------------##
##Explore the data
##--------------------##

##Open PNG device; create 'plot4.png' in the working directory
png(file = "plot6.png", width = 480, height = 480) 

##Use log10 to scale down the data
##Plot boxplots to see how the emissions from motor vehicles change over the years
ggplot(data = baltimore.losangeles, aes(x = year, y = log10(Emissions))) +
  geom_boxplot(aes(fill = year)) + 
  stat_boxplot(geom ='errorbar') +
  facet_grid(County~.) +
  labs(title = expression('Compare PM'[2.5]*' Emissions in Baltimore City & Los Angeles'))+
  labs(x="Year", y=expression('log'[10]*' PM'[2.5]*' Emission'))

##Close the PNG file device
dev.off() 
