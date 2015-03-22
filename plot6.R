NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

vData <- grepl("vehicle", SCC$SCC.Level.Two, ignore.case=TRUE)
vDataSCC <- SCC[vData,]$SCC
vDataNEI <- NEI[NEI$SCC %in% vDataSCC,]

vBaltimoreNEI <- vDataNEI[vDataNEI$fips=="24510",]
vBaltimoreNEI$city <- "Baltimore City"

vLANEI <- vDataNEI[vDataNEI$fips=="06037",]
vLANEI$city <- "Los Angeles County"

combinedNEI <- rbind(vBaltimoreNEI,vLANEI)

png("plot6.png",width=480,height=480,units="px",bg="transparent")

library(ggplot2)

ggp <- ggplot(combinedNEI, aes(x=factor(year), y=Emissions, fill=city)) +
    geom_bar(aes(fill=year),stat="identity") +
    facet_grid(scales="free", space="free", .~city) +
    guides(fill=FALSE) + theme_bw() +
    labs(x="year", y=expression("Total PM"[2.5]*" Emission (Kilo-Tons)")) + 
    labs(title=expression("PM"[2.5]*" Motor Vehicle Source Emissions: Baltimore & LA, 1999-2008"))

print(ggp)