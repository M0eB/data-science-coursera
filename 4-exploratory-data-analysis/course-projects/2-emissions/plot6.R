

## For this question, it was assumed that motor vehicles referred to 
## On-road vehicles only and not including aircrafts.
## Thus the following items are included int the plots : 
##    "Mobile - On-Road Gasoline Light Duty Vehicles" 
##    "Mobile - On-Road Gasoline Heavy Duty Vehicles"
##    "Mobile - On-Road Diesel Light Duty Vehicles"   
##    "Mobile - On-Road Diesel Heavy Duty Vehicles"

## Get data for Baltimore
NEI <- readRDS( "summarySCC_PM25.rds" )
SCC <- readRDS( "Source_Classification_Code.rds" ) 

baltimore  <- NEI[ NEI$fips=="24510", ]  
losangeles <- NEI[ NEI$fips=="06037", ]  

## Get vehicle data
vehicle_sources <- grepl( "vehicle" , SCC$EI.Sector, ignore.case = TRUE)
vehicle_SCC <- SCC[ vehicle_sources, ]

## Get baltimore vehicle emissions data
balt_veh_rows <- baltimore$SCC %in% vehicle_SCC$SCC
balt_veh_data <- baltimore[ balt_veh_rows, ]

## Get LA vehicle emissions data
la_veh_rows <- losangeles$SCC %in% vehicle_SCC$SCC
la_veh_data <- losangeles[ la_veh_rows, ]

## Get yearly sums
library( plyr )
balt_veh_emissions <- ddply( balt_veh_data, .(year), numcolwise(sum) )
la_veh_emissions   <- ddply( la_veh_data, .(year), numcolwise(sum) )

## Merge Values
vehicle_emissions <- data.frame( year = balt_veh_emissions$year, 
                                 baltimore = balt_veh_emissions$Emissions, 
                                 los.angeles = la_veh_emissions$Emissions )

library(reshape2)
melted = melt( vehicle_emissions, id.vars="year" )

## Plot year vs. total emissions
library(ggplot2)
png( filename = "plot6.png", width = 480, height = 480)
plot <- qplot( year, value, data = melted, 
               color = variable, 
               geom = c("point", "smooth") )

## Add labels
plot <- plot + labs(title = "Total Emissions for Baltimore and Los Angeles",
                    x = "Year",
                    y = "Total Emissions" )

## Change legend title
plot <- plot + theme( legend.title=element_blank() )

print( plot )
dev.off()

