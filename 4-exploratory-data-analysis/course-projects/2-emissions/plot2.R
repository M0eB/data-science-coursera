

## Get data for Baltimore
NEI <- readRDS( "summarySCC_PM25.rds" )
baltimore <- NEI[ NEI$fips=="24510", ]  

## Get yearly sums
library( plyr )
total_emissions <- ddply( baltimore, .(year), numcolwise(sum) )

## Plot year vs. total emissions
png( filename = "plot2.png", width = 480, height = 480)
with( total_emissions, 
      plot( x = year, y = Emissions,
            type = "l",
            col = "Red",
            main = "Total Emissions for Baltimore (1999-2008)",
            xlab = "Year",
            ylab = "Total Emissions (PM2.5)" ))

## Add a trendline
model <- lm( Emissions ~ year, total_emissions ) #linear model
abline( model, lwd = 2 )

## Add a Legend
legend("topright", 
       lty = c(1,1), 
       col = c("red", "black"), 
       legend = c("Total Emissions", "Trend Line"))

dev.off()
