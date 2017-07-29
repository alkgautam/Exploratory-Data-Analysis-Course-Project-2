NEI <- readRDS("summarySCC_PM25.rds"); SSC <- readRDS("Source_Classification_Code.rds")
 library(dplyr)

#Adding the total emission as per year
totalYr <- summarise(group_by(NEI, year), Emissions = sum(Emissions))

#Plotting on the GrDevice PNG
png(filename = "plot1.png")
clrs <- c("green", "blue", "cyan", "yellow")
x1<-barplot(height=totalYr$Emissions/1000, names.arg=totalYr$year,
            xlab="years", ylab=expression('total PM'[2.5]*' emission in kilotons'),ylim=c(0,8000),
            main=expression('Total PM'[2.5]*' emissions at various years in kilotons'),col=clrs)

## Add text at top of bars
text(x = x1, y = round(totalYr$Emissions/1000,2), 
     label = round(totalYr$Emissions/1000,2), pos = 3, cex = 0.8, col = "black")
dev.off()

