library(ggplot2)
# reading and exploring NEI data - National Emmissions Data
NEI_data <- readRDS("summarySCC_PM25.rds")
# reading and exploring SCC data - Source Classification Code Data
SCC_data <- readRDS("Source_Classification_Code.rds")

# forming Baltimore data which will be NEI_data subset
baltdata <- NEI_data[NEI_data$fips=="24510", ]

# Baltimore yearly emmisisons data
baltYrTypEmm <- aggregate(Emissions ~ year+ type, baltdata, sum)

# Comparing Baltimore, MD-24510 and Los Angeles, CA-06037
baltYrTypEmmFips <- summarise(group_by(filter(NEI_data, NEI_data$fips == "24510"& type == 'ON-ROAD'), year), Emissions=sum(Emissions))
laYrTypEmmFips <- summarise(group_by(filter(NEI_data, NEI_data$fips == "06037"& type == 'ON-ROAD'), year), Emissions=sum(Emissions))

baltYrTypEmmFips$County <- "Baltimore City, MD"
laYrTypEmmFips$County <- "Los Angeles County, CA"

baltLaEmissions <- rbind(baltYrTypEmmFips, laYrTypEmmFips)

# Type: ON-ROAD, Fips = 24510 for Baltimore, MD Motor Vehicle PM[2.5]* Emissions Against Los Angeles, CA Fips = 06037  from 1999 to 2008
png(filename = "plot6.png")
ggplot(baltLaEmissions, aes(x=factor(year), y=Emissions, fill=County,label = round(Emissions,2))) +
  geom_bar(stat="identity") + 
  facet_grid(County~., scales="free") +
  ylab(expression("total PM"[2.5]*" emissions in tons")) + 
  xlab("year") +
  ggtitle(expression("Baltimore City vs Los Angeles County Motor vehicle emission in tons"))+
  geom_label(aes(fill = County),colour = "yellow", fontface = "bold")
dev.off()