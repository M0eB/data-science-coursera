
# Plotting Systems ------------------------------------------------------------
#
#        Base : "Artist's palette" model
#     Lattice : Entire plot specified by one function; conditioning
#     ggplot2 : Mixes elements of base and Lattice

plotting_systems <- function()
{
      # 1. The Base PLotting System -------------------------------------------
      #
      #   - Start with a plot function and use annotation functions to modify
      #     (lines, points, labels, etc.)
      #   - Pros : convenient, mirrors how we think of building plots
      #   - Cons : Can't go back/undo, 
      
      library(datasets)
      data(cars)
      with(cars, plot(speed, dist))
      
      
      # 2. The Lattice Plotting System  ---------------------------------------
      #
      #   - Plots are created with a single function (xyplot, bwplot, et.)
      #   - You have to specify a lot of info in the call to build correctly
      #   - Pros : Useful for coo-plots / conditioning plots :
      #            (ex. - looking at how y changes with x across levels of z)
      #            Things like margins/spacing set automatically
      #            Good for putting many plots on a screen
      #   - Cons : Awkward to specify an entire plot in a single call
      #            Cannot "add" to the plot once it is created
      
      ## Plot life expectancy  vs. avg per captia income in a state
      ## Condition on the region
      library(lattice)
      state <- data.frame(state.x77, region = state.region) # 
      xyplot(Life.Exp ~ Income | region, data = state, layout = c(4, 1))
      
      
      # 3. ggplot2 System -----------------------------------------------------
      #
      #   - comes from the grammar of graphics which lays out a set of 
      #     principles for plotting and creates a kind of language or grammar
      #     for describing different aspects of a plot
      #   - Pros : Mixes ideas from base and lattice 
      #            Generally easier/more intuitive than lattice
      #            Has a lot of defaults but you can customize almost anything
      #   - Cons : 
      #            
      
      ## Plot engine size vs. milage on the highway 
      library(ggplot2)
      data(mpg)
      qplot(displ, hwy, data = mpg)
      
}


# Exploratory Graphs ----------------------------------------------------------
#
# Simple Summaries of Data :
#       One Dimension :
#          - Five-number summary
#          - Boxplots
#          - Histograms
#          - Density Plot
#          - Barplot
#       Two Dimensions :
#          - Multiple/Overlayed 1-D plots (Lattice/ggplot2)
#          - Scatterplots
#          - Smooth scatterplots
#       >2 Dimensions :
#          - Overlated/multiple 2-D plots; coplots
#          - Use color, size, shape to add dimensions
#          - Spinning plots
#          - Actual 3-D plot (not that useful)

exploratory_graphs <- function()
{
      # Air Pollution in the US  ----------------------------------------------
      #
      # US Environmental protection agency (EPA) sets national ambient air 
      # quality standards for outdoor air pollution
      # For fine particle pollution (PM2.5) the annual mean averaged over
      # 3 years cannot exceed 12 ug/m^3
      #
      # We will analyze Annual Average PM2.5 averaged over the period 
      # of 2008-2010 to answe the question :
      #
      # Are there any counties in the U.S that exceed the national stanadard ?
      
      ## Load the data
      filePath <- "C:/Users/Mohamed/Google Drive/@ Career - Data Science/Repo/data-science-coursera/4-exploratory-data-analysis/data/avgpm25.csv"
      pollution <- read.csv(filePath, 
                            colClasses = c("numeric", "character", "factor", "numeric", "numeric"))
      
      ## Five Number Summary
      summary(pollution$pm25)  

      ## Boxplot
      boxplot(pollution$pm25, col = "blue")  
      abline(h = 12)
      
      ## Multiple Boxplots
      boxplot(pm25 ~ region, data = pollution, col = "red")
      
      ## Historgram
      hist(pollution$pm25, col = "green")
      hist(pollution$pm25, col = "green", breaks = 100)
      rug(pollution$pm25)
      abline(v = 12, lwd = 2)
      abline(v = median(pollution$pm25), 
             col = "magenta", lwd = 4)
      
      ## Multiple Histograms
      par(mfrow = c(2, 1), mar = c(4, 4, 2, 1))
      hist(subset(pollution, region == "east")$pm25, 
           col = "green")
      hist(subset(pollution, region == "west")$pm25, 
           col = "green")
      
      ## Barplot
      barplot(table(pollution$region), 
              col = "wheat", 
              main = "Number of Counties in Each Region")
      
      ## Scatterplot
      with(pollution, plot(latitude, pm25))
      with(pollution, plot(latitude, pm25, col = region))      
      abline(h = 12, lwd = 2, lty = 2)
      
      ## Multiple Scatterplots
      par(mfrow = c(1, 2), mar = c(5, 4, 2, 1))
      with(subset(pollution, region == "west"), 
           plot(latitude, pm25, main = "West"))
      with(subset(pollution, region == "east"), 
           plot(latitude, pm25, main = "East"))
      
}



base_plotting_system <- function()
{
      library(datasets)
      
      ## Simple Base Graphics -------------------------------------------------
      
      ## Histogram
      hist( airquality$Ozone ) 
      
      ## Scatterplot
      with( airquality, plot(Wind, Ozone) )
      
      ## Boxplot
      airquality <- transform( airquality, Month = factor(Month) )
      boxplot( Ozone ~ Month, airquality, xlab = "Month", ylab = "Ozone (ppb)" )
      
      
      # Some important Base Graphics Parameters  -----------------------------
      #
      #    pch : plotting symbol (run "example(points)" to see list)
      #    lty : line type
      #    lwd : line width
      #    col : plotting color
      #   xlab : x-axis label
      #   ylab : y-axis label
      #    
      #  Global Graphics Parameters (use par() function) : 
      #  The par() function is used to specify gobal graphics parameters that 
      #  affect all plots in an R session.These parameters can be overriden 
      #  when specified as arguments to specific plotting functions.
      #
      #    las : orientation of axis labels
      #     bg : background color
      #    mar : margin size
      #    oma : outer margin size (default is 0)
      #  mfriw : # of plots per row, column (filled row-wise)
      #  mfcol : # of plots per row, column (filled column-wise)
      
      ## See default values for global graphics parameters --------------------
      
      print( par("lty") )      # solid line
      print( par("col") )      # black
      print( par("pch") )      # 1 - open circle
      print( par("bg") )       # transparentr
      print( par("mar") )      # 5.1 4.1 4.1 2.1 (bottom then CW direction)
      print( par("mfrow") )    # 1 1 (1 row, 1 col - Single plot)
  
      
      # Base Plotting Functions ----------------------------------------------
      #
      #    plot : make a scatterplot, or other type of plot depending on
      #         : the class of the object being plotted
      #   lines : add lines to a plot, given a vector x values and a 
      #           corresponding vector of y values (or a 2-column matrix)
      #           this function just connects the dots
      #  points : add points to a plot
      #    text : add text labels to a plot using specified x,y coordinates
      #   title : add annotations to x,y labels, title, subtitle, outer margin
      #   mtext : add arbitrary text to the margins (inner or outer) of the plot
      #    axis : add axis ticks/labels
      
      
      ## Base Plot with Annotation --------------------------------------------
      #library(datasets)
      with(airquality, plot(Wind, Ozone))
      title(main = "Ozone & Wind in New York City")  ## Add a title
      
      with(airquality, 
           plot(Wind, Ozone, main = "Ozone & Wind in New York City"))
      
      with(subset(airquality, Month == 5), 
           points(Wind, Ozone, col = "blue"))
      
      with(airquality, 
           plot(Wind, Ozone, main = "Ozone & Wind in New York City", type = "n"))
      
      with(subset(airquality, Month == 5), 
           points(Wind, Ozone, col = "blue"))
      
      with(subset(airquality, Month != 5), 
           points(Wind, Ozone, col = "red"))
      
      legend("topright", 
             pch = 1, 
             col = c("blue", "red"), 
             legend = c("May", "Other Months"))
      
      
      ## Base Plot with Regression Line ---------------------------------------
      with(airquality, 
           plot(Wind, Ozone, main = "Ozone & Wind in New York City", pch = 20))
      model <- lm(Ozone ~ Wind, airquality) #linear model
      abline(model, lwd = 2)
      
      
      ## Multiple Base Plots --------------------------------------------------
      par(mfrow = c(1, 2))
      with(airquality, 
           { plot(Wind, Ozone, main = "Ozone & Wind")
             plot(Solar.R, Ozone, main = "Ozone & Solar Radiation")
           })
      
      # Change margins to give extra space for main title
      par(mfrow = c(1, 3), mar = c(4, 4, 2, 1), oma = c(0, 0, 2, 0))
      
      # Add three plots and the main title
      with(airquality, 
           { plot(Wind, Ozone, main = "Ozone & Wind")
             plot(Solar.R, Ozone, main = "Ozone & Solar Radiation")
             plot(Temp, Ozone, main = "Ozone & Temperature")
             mtext("Ozone & Weather in New York City", outer = TRUE)
           })

}


graphics_devices <- function()
{
      
      
      
}



