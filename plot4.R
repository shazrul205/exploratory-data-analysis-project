require(ggplot2)

##read the two files provided
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

##checks which variable contains the keyword "coal" and "combustion" or "comb"
##head(SCC$EI.Sector)
#head(SCC$Option.Group)
##head(SCC$SCC.Level.One)

##extract SCC values that are related to "Coal"
coalSCC <- SCC[grep("[Cc][Oo][Aa][Ll]",SCC$EI.Sector),1]

##subset NEI with SCC values similar to coalSCC
coalNEI <- NEI[NEI$SCC %in% coalSCC, ]

##convert the year variable to factor
coalNEI$year <- as.factor(coalNEI$year)

##--------------------##
##Explore the data
##--------------------##

##Open PNG device; create 'plot4.png' in the working directory
png(file = "plot4.png", width = 480, height = 480) 

##outliers are squishing the boxplots
##ggplot(data=coalNEI, aes(x=year, y=Emissions))+ guides(fill=FALSE) +
##  geom_boxplot() + stat_boxplot(geom ='errorbar')

##Use log10 to scale down the data
##Plot boxplots to see how the emissions change over the years
ggplot(data=coalNEI, aes(x=year, y=log10(Emissions))) +
  geom_boxplot(aes(fill=year)) + 
  stat_boxplot(geom ='errorbar') +
  labs(title = expression('PM'[2.5]*' Emissions from Coal Combustion sources'))+
  labs(x="Year", y=expression('log'[10]*' PM'[2.5]*' Emission'))

##Close the PNG file device
dev.off() 
