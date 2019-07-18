library(ggplot2)
# reading and exploring NEI data - National Emmissions Data
NEI_data <- readRDS("summarySCC_PM25.rds")
# reading and exploring SCC data - Source Classification Code Data
SCC_data <- readRDS("Source_Classification_Code.rds")

# forming Baltimore data which will be NEI_data subset
baltdata <- NEI_data[NEI_data$fips=="24510", ]

# Baltimore yearly emmisisons data
baltYrTypEmm <- aggregate(Emissions ~ year+ type, baltdata, sum)

# plot3.png
chart <- ggplot(baltYrTypEmm, aes(year, Emissions, color = type))
png(filename = "plot3.png")
chart + geom_line() +
  xlab("year") +
  ylab(expression('Total Emissions')) +
  ggtitle('Total Baltimore Emissions [2.5]* From 1999 to 2008')
dev.off()