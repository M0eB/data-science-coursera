# =============================================================================
#          By : Mohamed T. Ismail
#      Course : Getting and Cleaning Data (Johns Hopkins University)
#    Provider : Coursera.com
# Description : Week 2 notes and examples (from slides)
# =============================================================================

# The Lattice Plotting System -------------------------------------------------
#
# - All plotting/annotation is done at once with a single function call
# - Ideal for creating conditioning plots where you examine the same kind of
#   plot under many different conditions
# - Generally take a formula for their first argument of the form :
#
#           xyplot( y ~ x | f * g, data )   
#
#           y/x = x and y-axis variable
#           f/g = Conditioning variables (optional)
#             * = The interaction between f/g
#                data = If no data passed, the parent frame is used
#                If no other arguemnts passed, defaults can be used
#                        
# - Implemented using the following packages:
#      
#      lattice : Contains code for producing Trellis graphics, 
#                which are independent of the "base" graphics system 
#                Includes functions like xyplot, bwplot, levelplot
#
#         grid : Implements a different graphing system independent 
#                of the "base" system; 
#                The lattice package builds on top of grid
#                We seldom call functions from the grid package directly
#
# -----------------------------------------------------------------------------

lattice_plotting_system <- function()
{
      # Lattice Functions -----------------------------------------------------
      #
      #      xyplot : Main function for creating scatterplots
      #      bwplot : Box-and-whiskers plots ("boxplots")
      #   histogram : Histograms
      #   stripplot : Like a boxplot but with actual points
      #     dotplot : Plot dots on "violin strings"
      #       splom : Scatterplot matrix; like pairs in base plotting system
      #   levelplot : For plotting "image" data
      # contourplot : For plotting "image" data
      #
      # -----------------------------------------------------------------------
      
      library(lattice)
      library(datasets)
      
      ## Simple Lattice Plots -------------------------------------------------
      
      ## Plot 1 - Simple Scatterplot
      xyplot( Ozone ~ Wind, data = airquality )
      
      ## Plot 2 - User 'Month' as a factor variable
      airquality <- transform( airquality, Month = factor(Month) )
      xyplot( Ozone ~ Wind | Month, data = airquality, layout = c(5, 1) )
      
      
      # Lattice Behaviour -----------------------------------------------------
      #
      # - Base graphics functions plot data directly to the graphics device
      # - Lattice graphics functions return an object of class "trellis"
      # - The 'print' methods plot the data on graphics device
      # - Lattice functions return "plot objects" that can be stored
      #   but it is better to just save the code and tata
      # - On the command-line, trellis objects are auto-printed so that it 
      #   appears the function is plotting the data
      
      p <- xyplot( Ozone ~ Wind, data = airquality )  # Nothing happens!
      print( p )                                      # Plot appears
      xyplot(Ozone ~ Wind, data = airquality)         # Auto-printing
      
      
      # Lattice Panel Functions ----------------------------------------------
      #
      # - Lattice functions have a panel function which controls what happens
      #   inside each panel of the plot
      # - The lattice packages comes with default panel functions, but you can
      #   supply your own if ytou want to customize what happens in each panel
      # - Panel functions receive the X/y coordinates of the data points
      #   in their panel (along with any optional arguments)
      
      ## Plot with 2 Panels
      set.seed(10)
      x <- rnorm(100)
      f <- rep( 0:1, each = 50 )
      y <- x + f - f * x + rnorm( 100, sd = 0.5 )
      f <- factor( f, labels = c("Group 1", "Group 2") )
      xyplot( y ~ x | f, layout = c(2, 1) )  
      
      ## Custom panel function 1
      xyplot( y ~ x | f, panel = function( x, y, ... ) 
      {
            panel.xyplot(x, y, ...)                # Call default panel func.
            panel.abline(h = median(y), lty = 2)   # Add line at median
      })
      
      ## Custom panel function 2
      xyplot( y ~ x | f, panel = function( x, y, ... ) 
      {
            panel.xyplot(x, y, ...)       # Call default panel func.
            panel.lmline(x, y, col = 2)   # Overlay linear regression line
      })
}



ggplot2_plotting_system <- function()
{
      
      
      
      
      
      
}









