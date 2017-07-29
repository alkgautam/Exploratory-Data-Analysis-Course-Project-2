NEI <- readRDS("summarySCC_PM25.rds"); SSC <- readRDS("Source_Classification_Code.rds")

library(ggplot2)
library(dplyr)

#Grouping and adding using the DPLYR package of the BLatiomre data per year per Type
totalYrBalTy <- summarise(group_by(filter(NEI, fips == "24510"), year, type), Emissions = sum(Emissions))

#Plotting on the GrDevice PNG
png(filename = "plot3.png",width = 960, height = 960)
ggplot(totalYrBalTy, aes(x = factor(year), y = Emissions, fill = type, label = round(Emissions, 2))) +
        geom_bar(stat = "identity") + 
        # Setting the Facet as per the Type of Emissions
        facet_grid(. ~ type) + 
        xlab("year") + ylab(expression("Total PM"[2.5]*"Emissions in Tons")) +
        ggtitle(expression("PM"[2.5]*paste(" emissions in Baltimore ",
                                           "City by various source types", sep="")))+
        geom_label(aes(fill = type), colour = "white", fontface = "bold")
dev.off()