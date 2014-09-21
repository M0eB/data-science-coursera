

NEI <- readRDS( "summarySCC_PM25.rds" )

# We want to plot the sum of all emissions data for each year
# We can use the plyr library to do this :

library( plyr )
total_emissions <- ddply( NEI, .(year), numcolwise(sum) )

# Now let's plot year vs. total emissions
png( filename = "plot1.png", width = 480, height = 480)
with( total_emissions, 
      plot( x = year, y = Emissions,
            type = "l",
            col = "Blue",
            main = "Total Emissions (1999-2008)",
            xlab = "Year",
            ylab = "Total Emissions (PM2.5)" ))

dev.off()
