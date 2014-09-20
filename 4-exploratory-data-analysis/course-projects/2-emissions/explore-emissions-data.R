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

		with( total_emissions, 
                  plot( x = year, y = Emissions,
                        type = "l",
                        col = "Blue",
                        main = "Total Emissions (1999-2008)",
                        xlab = "Year",
                        ylab = "Total Emissions (PM2.5)" ))
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
      plot <- qplot( year, Emissions, data = total_emissions, 
                                     color = total_emissions$type, 
                                      geom = c("point", "smooth") )
      ## Add labels
      plot <- plot + labs(title = "Total Emissions By Type",
                              x = "Year",
                              y = "Total Emissions" )

      ## Change legend title
      plot <- plot + theme( legend.title=element_blank() )
      
      plot
}




# Question 4 --------------------------------------------------------------------
# Across the United States, how have emissions from coal combustion-related 
# sources changed from 1999-€“2008 ? 
# -------------------------------------------------------------------------------


plot4 <- function()
{


	
}



# Question 5 --------------------------------------------------------------------
# How have emissions from motor vehicle sources changed from 1999-€“2008 in 
# Baltimore City?
# -------------------------------------------------------------------------------


plot5 <- function()
{


	
}



# Question 6 --------------------------------------------------------------------
# Compare emissions from motor vehicle sources in Baltimore City with emissions 
# from motor vehicle sources in Los Angeles County, California (fips == "06037"). 
# Which city has seen greater changes over time in motor vehicle emissions?
# -------------------------------------------------------------------------------


plot6 <- function()
{


	
}


