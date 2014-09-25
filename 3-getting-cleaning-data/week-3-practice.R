# =============================================================================
#          By : Mohamed T. Ismail
#      Course : Getting and Cleaning Data (Johns Hopkins University)
#    Provider : Coursera.com
# Description : Week 3 - subsetting, sorting, summerizing, reshaping, merging
# =============================================================================


# Question 1 ------------------------------------------------------------------
#
# The American Community Survey distributes downloadable data about United 
# States communities. Download the 2006 microdata survey about housing for
# the state of Idaho using download.file() from here: 
#
#  https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv 
#
# and load the data into R. The codebook is here: 
#
#  https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FPUMSDataDict06.pdf 
#
# Create a logical vector that identifies the households on greater than 10 
# acres who sold more than $10,000 worth of agriculture products. Assign that
# logical vector to the variable agricultureLogical. Apply the which() 
# function like this to identify the rows of the data frame where the logical 
# vector is TRUE. which(agricultureLogical) 
# What are the first 3 values that result?
#
#   125, 238,262
#   59, 460, 474
#   403, 756, 798
#   153 ,236, 388
#
# -----------------------------------------------------------------------------


question1 <- function()
{
      housingDF <- read.csv( "./data/idaho_housing.csv" )
      agricultureLogical <- with( housingDF, housingDF$ACR == 3 & housingDF$AGS == 6 )
      housesNum <- which( agricultureLogical )
      head( housesNum )
}



# Question 2 ------------------------------------------------------------------
#
# Using the jpeg package read in the following picture into R : 
#
#           https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg 
#
# Use the parameter native=TRUE. What are the 30th and 80th quantiles of the 
# resulting data? (some Linux systems may produce an answer 638 different for 
# the 30th quantile)
#
#   -15259150 -10575416
#   -16776430 -15390165
#   10904118 -594524
#   -15259150 -594524
#
# -----------------------------------------------------------------------------


question2 <- function()
{
      library( "jpeg" )
      image <- readJPEG( "./data/getdata-jeff.jpg", native = TRUE )
      quantile( image, probs=c(0.3, 0.8) )
}



# Question 3 ------------------------------------------------------------------
#
# Load the Gross Domestic Product data for the 190 ranked countries here: 
# 
#   https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv 
#
# Load the educational data from this data set: 
#
#   https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv 
#
# Match the data based on the country shortcode. How many of the IDs match? 
# Sort the data frame in descending order by GDP rank (so United States is last). 
# What is the 13th country in the resulting data frame? 
# 
# Original data sources: 
# http://data.worldbank.org/data-catalog/GDP-ranking-table 
# http://data.worldbank.org/data-catalog/ed-stats
#
#   189, St. Kitts and Nevis
#   190, Spain
#   189, Spain
#   190, St. Kitts and Nevis
#   234, St. Kitts and Nevis
#   234, Spain
# 
# -----------------------------------------------------------------------------


question3 <- function()
{
      gdpFilePath     <- "./data/getdata-data-GDP.csv"
      edstatsFilePath <- "./data/getdata-data-EDSTATS_Country.csv"
      
      ## Read as data.tables
      gdp_data     <- read.csv( gdpFilePath )
      colnames(gdp_data) <- c("CountryCode", "Ranking") 
      edstats_data <- read.csv( edstatsFilePath )
      
      merged_data <- gdp_data[gdp_data$CountryCode %in% edstats_data$CountryCode,]
      #merged_data <- merge( gdp_data, edstats_data, by="CountryCode")
      
      brub <- merged_data[ order(merged_data$Ranking, decreasing=TRUE), ]
}



# Question 4 ------------------------------------------------------------------
#
# What is the average GDP ranking for the 
# "High income: OECD" and "High income: nonOECD" group?
# 
#   32.96667, 91.91304
#   23, 30
#   23.966667, 30.91304
#   30, 37
#   23, 45
#   133.72973, 32.96667
#
# -----------------------------------------------------------------------------


question4 <- function()
{





	
}





# Question 5 ------------------------------------------------------------------
#
# Cut the GDP ranking into 5 separate quantile groups. Make a table versus 
# Income.Group. How many countries are Lower middle income but among the 38 
# nations with highest GDP?
#
#   13
#   3
#   18
#   5
#
# -----------------------------------------------------------------------------


question5 <- function()
{





	
}


