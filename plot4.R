
# Exploratory Data Analysis - Project 2

# Unzipping files to working directory 

zip_Epc <- "D:/ISB Co 2018/Coursera/Data Science Specialization/Exploratory Data Analysis/Week 4 - Project 2/exdata%2Fdata%2FNEI_data.zip"
unzip(zip_Epc)

# reading .rds file in R into a dataframe

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# subsetting data for coal name in source & merging data frames

coal  <- grepl("coal", SCC$Short.Name, ignore.case=TRUE)
SCC_coal <- SCC[coal,]
NEI_SCC <- merge(NEI, SCC_coal, by="SCC")

# plotting total emissions year wise to identify trend in the same

NEI_SCC_em <- summarize(group_by(NEI_SCC,year),sum(Emissions))

library(ggplot2)
png("plot4.png", width=640, height=480)
qplot(year,`sum(Emissions)`, data = NEI_SCC_em,geom="line") + ggtitle("Total PM2.5 Emissions ") + xlab("Year") + ylab("PM2.5 Emissions")
dev.off()
