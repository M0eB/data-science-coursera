

## Get data for Baltimore
NEI <- readRDS( "summarySCC_PM25.rds" )
baltimore <- NEI[ NEI$fips=="24510", ]  

## Get yearly sums
library( plyr )
total_emissions <- ddply( baltimore, .(year,type), numcolwise(sum) )

## Plot year vs. total emissions
library(ggplot2)
png( filename = "plot3.png", width = 480, height = 480)
plot <- qplot( year, Emissions, data = total_emissions, 
               color = total_emissions$type, 
               geom = c("point", "smooth") )
## Add labels
plot <- plot + labs(title = "Total Emissions By Type",
                    x = "Year",
                    y = "Total Emissions" )

## Change legend title
plot <- plot + theme( legend.title=element_blank() )
print( plot )

dev.off() 