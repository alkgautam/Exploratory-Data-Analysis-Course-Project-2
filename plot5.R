NEI <- readRDS("summarySCC_PM25.rds"); SSC <- readRDS("Source_Classification_Code.rds")

library(ggplot2)
library(dplyr)

#Finding the Motor Vehicle Sources
baltMotor <- NEI[(NEI$fips == "24510") & (NEI$type == "ON-ROAD"), ]

#Adding the Emissions Per Year
baltMotorYr <- summarise(group_by(baltMotor, year), Emissions = sum(Emissions))

#Plotting on the GrDevice PNG
png(filename = "plot5.png")
ggplot(baltMotorYr, aes(x=factor(year), y=Emissions,fill=year, label = round(Emissions,2))) +
        geom_bar(stat="identity") +
        xlab("year") +
        ylab(expression("total PM"[2.5]*" emissions in tons")) +
        ggtitle("Emissions from motor vehicle sources in Baltimore City")+
        geom_label(aes(fill = year),colour = "white", fontface = "bold")
dev.off()
