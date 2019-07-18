# reading and exploring NEI data - National Emmissions Data
NEI_data <- readRDS("summarySCC_PM25.rds")
# reading and exploring SCC data - Source Classification Code Data
SCC_data <- readRDS("Source_Classification_Code.rds")

# forming Baltimore data which will be NEI_data subset
baltdata <- NEI_data[NEI_data$fips=="24510", ]

# Baltimore yearly emmisisons data
baltYrEmm <- aggregate(Emissions ~ year, baltdata, sum)

# plot2.png
cols1 <- c("maroon", "yellow", "orange", "Aquamarine")
png(filename = "plot2.png")
barplot(height=baltYrEmm$Emissions/1000, names.arg=baltYrEmm$year, 
        xlab="Year", ylab=expression('Aggregated Emission'),
        main=expression('Baltimore Aggregated PM'[2.5]*' Emmissions by Year'), col = cols1)
dev.off()