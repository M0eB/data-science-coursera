

## Get data for Baltimore
NEI <- readRDS( "summarySCC_PM25.rds" )
SCC <- readRDS( "Source_Classification_Code.rds" ) 

## Get coal data
coal_sources <- grepl( "coal" , SCC$EI.Sector, ignore.case = TRUE)
coal_SCC <- SCC[ coal_sources, ]
coal_rows <- NEI$SCC %in% coal_SCC$SCC
coal_data <- NEI[ coal_rows, ]

## Get yearly sums
library( plyr )
coal_emissions <- ddply( coal_data, .(year), numcolwise(sum) )

## Plot year vs. total emissions
library(ggplot2)
png( filename = "plot4.png", width = 480, height = 480)
plot <- qplot( year, Emissions, data = coal_emissions, 
               color = coal_emissions$type, 
               geom = c("point", "smooth") )
## Add labels
plot <- plot + labs(title = "Total Emissions for Coal Sources",
                    x = "Year",
                    y = "Total Emissions" )

## Change legend title
plot <- plot + theme( legend.title=element_blank() )

print( plot)
dev.off()