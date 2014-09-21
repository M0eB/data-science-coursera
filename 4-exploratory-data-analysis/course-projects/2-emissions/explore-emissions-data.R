# =============================================================================
#          By : Mohamed T. Ismail
#      Course : Exploratory Data Analysis (Johns Hopkins University)
#    Provider : Coursera.com
# Description : Course Project analyzing emissions data.
# =============================================================================


# Question 1 ------------------------------------------------------------------
# Have total emissions from PM2.5 decreased in the U.S from 1999-2008? 
# Using the base plotting system, make a plot showing the total PM2.5 emission 
# from all sources for each of the years 1999, 2002, 2005, and 2008.
# -----------------------------------------------------------------------------

plot1 <- function()
{ 
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
}



# Question 2 --------------------------------------------------------------------
# Have total emissions from PM2.5 decreased in the Baltimore City, Maryland 
# (fips == "24510") from 1999 to 2008? Use the base plotting system to make a 
# plot answering this question.
# -------------------------------------------------------------------------------


plot2 <- function()
{
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
}


# Question 3 --------------------------------------------------------------------
# Of the four types of sources indicated by the type (point, nonpoint, onroad, 
# nonroad) variable, which of these four sources have seen decreases in emissions 
# from 1999-€“2008 for Baltimore City? Which have seen increases in emissions from 
# 1999-€“2008? Use the ggplot2 plotting system to make a plot answer this question.
# -------------------------------------------------------------------------------
      

plot3 <- function()
{
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
      
      dev.off()
}




# Question 4 --------------------------------------------------------------------
# Across the United States, how have emissions from coal combustion-related 
# sources changed from 1999-2008 ? 
# -------------------------------------------------------------------------------


plot4 <- function()
{
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
      
      dev.off()
}



# Question 5 --------------------------------------------------------------------
# How have emissions from motor vehicle sources changed from 1999-2008 in 
# Baltimore City?
# -------------------------------------------------------------------------------


plot5 <- function()
{
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
      
      dev.off()      
}



# Question 6 --------------------------------------------------------------------
# Compare emissions from motor vehicle sources in Baltimore City with emissions 
# from motor vehicle sources in Los Angeles County, California (fips == "06037"). 
# Which city has seen greater changes over time in motor vehicle emissions?
# -------------------------------------------------------------------------------


plot6 <- function()
{
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
      
      dev.off()
      
}


