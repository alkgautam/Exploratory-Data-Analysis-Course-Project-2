NEI <- readRDS("summarySCC_PM25.rds"); SSC <- readRDS("Source_Classification_Code.rds")

library(ggplot2)
library(dplyr)

# Gathering Baltimore City and LA total Motor Vehicle Emission per Year
BaltEmiss<-summarise(group_by(filter(NEI, fips == "24510"& type == 'ON-ROAD'), year), Emissions=sum(Emissions))
LAEmiss<-summarise(group_by(filter(NEI, fips == "06037"& type == 'ON-ROAD'), year), Emissions=sum(Emissions))

#Adding County Character 
BaltEmiss$County <- "Baltimore City, MD"
LAEmiss$County <- "Los Angeles County, CA"

#Combining Both the BAltimore and LA Data
bothEmiss <- rbind(BaltEmiss, LAEmiss)

#Plotting on the GrDevice PNG
png(filename = "plot6.png",width = 960, height = 960)
ggplot(bothEmiss, aes(x=factor(year), y=Emissions, fill=County,label = round(Emissions,2))) +
        geom_bar(stat="identity") + 
        facet_grid(County~., scales="free") +
        ylab(expression("total PM"[2.5]*" emissions in tons")) + 
        xlab("year") +
        ggtitle(expression("Motor vehicle emission variation in Baltimore and Los Angeles in tons"))+
        geom_label(aes(fill = County),colour = "white", fontface = "bold")
dev.off()