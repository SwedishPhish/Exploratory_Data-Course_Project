NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

vData <- grepl("vehicle", SCC$SCC.Level.Two, ignore.case=TRUE)
vDataSCC <- SCC[vData,]$SCC
vDataNEI <- NEI[NEI$SCC %in% vDataSCC,]

baltimorevDataNEI <- vDataNEI[vDataNEI$fips=="24510",]

png("plot5.png",width=480,height=480,units="px",bg="transparent")

library(ggplot2)

ggp <- ggplot(baltimorevDataNEI,aes(factor(year),Emissions)) +
    geom_bar(stat="identity",fill="grey",width=0.75) +
    theme_bw() +  guides(fill=FALSE) +
    labs(x="year", y=expression("Total PM"[2.5]*" Emission (10^5 Tons)")) + 
    labs(title=expression("PM"[2.5]*" Motor Vehicle Source Emissions in Baltimore from 1999-2008"))

print(ggp)