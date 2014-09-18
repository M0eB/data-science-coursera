# =============================================================================
#          By : Mohamed T. Ismail
#      Course : Exploratory Data Analysis (Johns Hopkins University)
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



# The ggplot2 Plotting System -------------------------------------------------
#
# - An implementation of the Grammar of Graphics by Leland Wilkinson
# - Grammar of graphics represents an abstraction of graphics ideas/objects
# - Think "verb", "noun", "adjective" for graphics
#        " In brief, the grammar tells us that a statistical 
#          graphic is a mapping from data to aesthetic attributes
#          (color, shape, size) of geometric objects (points, lines, bars).
#          The plot may also contain statistical transformations
#          of the data and is drawn on a specific coordinate system "
#                     - from ggplot2 book
# - Powerful and flexible if you learn the grammar and various elements
# 
#       *** NOTE : The code does not cover all types of plots ****
#
# Components of a Plot : 
#     - Data Frame
#     - aesthetic mappings : how data are mapped to color, size
#     - geoms : geometric objects like points, lines, shapes
#     - facets : for conditional plots
#     - stats : statistical transformations like binning, quantiles, smoothing
#     - scales : what scale an aesthetic map uses (ie- male=red, female=blue)
#     - coordinate system
#
# Functions : 
#            qplot() :  
#           ggplot() :  
#       geom_point() :  
#        geom_line() : 
#      geom_smooth() :  
#       facet_grid() :  
#       facet_wrap() :  
#              aes() :  
#             labs() : 
#  coord_cartesian() :  
#
# -----------------------------------------------------------------------------

ggplot2_plotting_system <- function()
{
      # Basics : qplot() ------------------------------------------------------
      # 
      #     - Works like plot in base graphics system
      #     - Looks for data in a data frame or in parent environment
      #     - Plots are made up of aesthetics (size, shape, color)
      #       and geoms (points, lines)
      #     - Factors are important for indicating subsets of the data
      #     - hides what goes on underneath, which is ok for most operations

      install.packages( ggplot2 )
      library( ggplot2 )

      str(mpg)  # The dataset we will work with

      qplot( displ, hwy, data=mpg )              # x,y,dataframe
      qplot( displ, hwy, data=mpg, color=drv )   # add color aesthetic
      qplot( displ, hwy, data=mpg, geom = c("point", "smooth") )  # Add geom

      qplot( hwy, data=mpg, fill=drv )           # Histogram


      # Facets ----------------------------------------------------------------

      qplot( displ, hwy, data=mpg, facets=.~drv ) 
      qplot( hwy, data=mpg, facets=drv~., binwidth=2 )


      # Histograms ------------------------------------------------------------

      str( maacs )                                      # new dataset
      qplot( log(eno), data=maacs )                     # Histogram 
      qplot( log(eno), data=maacs, fill=mopos )         # color by group


      # Density plots ---------------------------------------------------------

      qplot( log(eno), data=maacs, geom="density" )               
      qplot( log(eno), data=maacs, geom="density", color=mopos)   # By group


      # Scatterplots ----------------------------------------------------------

      qplot( log(pm25), log(eno), data=maacs )                 
      qplot( log(pm25), log(eno), data=maacs, shape=mopos )    # group by shape
      qplot( log(pm25), log(eno), data=maacs, color=mopos )    # group by color

      # Group using color
      qplot( log(pm25), log(eno), data=maacs, color=mopos, 
                                              geom=c("point", "smooth"), 
                                              method="lm" )

      # Group using facets (separte plot for each group)
      qplot( log(pm25), log(eno), data=maacs, geom=c("point", "smooth"),
                                              method="lm",
                                              facets=.~mopos )


      ## HALFWAY...
      ## NOTES AFTER THIS BUILD PLOT IN LAYERS, CONSIDER SEPARATE FUNCTION
}









