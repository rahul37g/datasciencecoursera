# reading and exploring NEI data - National Emmissions Data
NEI_data <- readRDS("summarySCC_PM25.rds")

head(NEI_data)
str(NEI_data)
dim(NEI_data)

# reading and exploring SCC data - Source Classification Code Data
SCC_data <- readRDS("Source_Classification_Code.rds")

# head data
head(SCC_data)
str(SCC_data)
dim(SCC_data)

# aggregating NEI emmissions by year
yearly_emmissions <- aggregate(Emissions ~ year, NEI_data, sum)

# plot1.ng
cols <- c("maroon", "orange", "yellow", "Aquamarine")
png(filename = "plot1.png")
barplot(height=yearly_emmissions$Emissions/1000, names.arg=yearly_emmissions$year, 
        xlab="Year", ylab=expression('Aggregated Emission'),
        main=expression('Aggregated PM'[2.5]*' Emmissions by Year'), col = cols)
dev.off()
