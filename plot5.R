
# Exploratory Data Analysis - Project 2

# Unzipping files to working directory 

zip_Epc <- "D:/ISB Co 2018/Coursera/Data Science Specialization/Exploratory Data Analysis/Week 4 - Project 2/exdata%2Fdata%2FNEI_data.zip"
unzip(zip_Epc)

# reading .rds file in R into a dataframe

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# subsetting data for vehicle name in source & merging data frames

vehicle  <- grepl("vehicle", SCC$Short.Name, ignore.case=TRUE)
SCC_vehicle <- SCC[vehicle,]
NEI_SCC_v <- merge(NEI, SCC_vehicle, by="SCC")

# subsetting data for Baltimore City

balti_city_v <- subset(NEI_SCC_v,fips=="24510")
library(dplyr)
bcity_pm25_v <- summarize(group_by(balti_city_v,year),sum(Emissions))

# plotting total emissions year wise to identify trend in the same

library(ggplot2)
png("plot5.png", width=640, height=480)
qplot(year,`sum(Emissions)`, data = bcity_pm25_v,geom="line")+ggtitle("Total PM2.5 Emissions in Baltimore County by Vehicle") + xlab("Year") + ylab("PM2.5 Emissions") 
dev.off()
