NEI <- readRDS("summarySCC_PM25.rds"); SSC <- readRDS("Source_Classification_Code.rds")

library(ggplot2)
library(dplyr)

# Finding the Coal only Sources
Coal <- SSC[grepl("Fuel Comb.*Coal", SSC$EI.Sector), ]

# Separating out the Coal Emissions by matching with the Source "Coal" in the SCC data
CoalEmissOnly <- NEI[NEI$SCC %in% Coal$SCC, ] 

# Adding all the Emissions Year Wise
CoalEmissionTotal <- summarise(group_by(CoalEmissOnly, year), Emissions = sum(Emissions))

# Plotting on the Graphics Device PNG
png(filename = "plot4.png")
ggplot(CoalEmissionTotal, aes(x=factor(year), y=Emissions/1000,fill=year, label = round(Emissions/1000,2))) +
        geom_bar(stat="identity") +
        xlab("year") +
        ylab(expression("total PM"[2.5]*" emissions in kilotons")) +
        ggtitle("Emissions from coal combustion sources in kilotons")+
        geom_label(aes(fill = year),colour = "white", fontface = "bold")
dev.off()
