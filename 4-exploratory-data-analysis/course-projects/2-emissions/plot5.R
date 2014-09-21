

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

baltimore <- NEI[ NEI$fips=="24510", ]  

## Get vehicle emissions data
vehicle_sources <- grepl( "vehicle" , SCC$EI.Sector, ignore.case = TRUE)
vehicle_SCC <- SCC[ vehicle_sources, ]
vehicle_rows <- baltimore$SCC %in% vehicle_SCC$SCC
vehicle_data <- baltimore[ vehicle_rows, ]

## Get yearly sums
library( plyr )
vehicle_emissions <- ddply( vehicle_data, .(year), numcolwise(sum) )

## Plot year vs. total emissions
library(ggplot2)
png( filename = "plot5.png", width = 480, height = 480)
plot <- qplot( year, Emissions, data = vehicle_emissions, 
               color = vehicle_emissions$type, 
               geom = c("point", "smooth") )
## Add labels
plot <- plot + labs(title = "Total Emissions for Motor Vehicles in Baltimore",
                    x = "Year",
                    y = "Total Emissions" )

## Change legend title
plot <- plot + theme( legend.title=element_blank() )

print( plot )
dev.off() 

