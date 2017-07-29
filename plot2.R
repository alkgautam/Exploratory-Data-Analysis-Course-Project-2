NEI <- readRDS("summarySCC_PM25.rds"); SSC <- readRDS("Source_Classification_Code.rds")
library(dplyr)

#Separating and Adding the total Emission of the Baltimore per year
totalYrBal <- summarise(group_by(filter(NEI, fips == "24510"), year), Emissions = sum(Emissions))

#plotting on the GrDevice PNG
png(filename = "plot2.png")
clrs <- c("green", "blue", "cyan", "yellow")
x1<-barplot(height=totalYrBal$Emissions/1000, names.arg=totalYrBal$year,
            xlab="years", ylab=expression('total PM'[2.5]*' emission in kilotons'),
            main=expression('Total PM'[2.5]*' emissions at various years in kilotons'),col=clrs)

## Add text at top of bars
text(x = x1, y = round(totalYrBal$Emissions/1000,2), 
     label = round(totalYrBal$Emissions/1000,2), pos = 3, cex = 0.8, col = "black")
dev.off()