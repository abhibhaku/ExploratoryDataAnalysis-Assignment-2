
# Exploratory Data Analysis - Project 2

# Unzipping files to working directory 

zip_Epc <- "D:/ISB Co 2018/Coursera/Data Science Specialization/Exploratory Data Analysis/Week 4 - Project 2/exdata%2Fdata%2FNEI_data.zip"
unzip(zip_Epc)

# reading .rds file in R into a dataframe

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# subsetting data for Baltimore City, Maryland & summing emissions by each year 

balti_city <- subset(NEI,fips=="24510")
library(dplyr)
bcity_pm25 <- summarize(group_by(balti_city,year,type),sum(Emissions))

# plotting total emissions year wise to identify trend in the same

library(ggplot2)
png("plot3.png", width=640, height=480)
qplot(year,`sum(Emissions)`, data = bcity_pm25,color=type,geom="line")+ggtitle("Total PM2.5 Emissions in Baltimore County by Source Type") + xlab("Year") + ylab("PM2.5 Emissions") 
dev.off()
