# =============================================================================
#          By : Mohamed T. Ismail
#      Course : Getting and Cleaning Data (Johns Hopkins University)
#    Provider : Coursera.com
# Description : Week 3 - subsetting, sorting, summerizing, reshaping, merging
# =============================================================================




subsetting_and_sorting <- function()
{
      ## Subsetting
      
      set.seed( 13435 ) 
      
      data <- data.frame( "var1" = sample(1:5), 
                          "var2" = sample(6:10),
                          "var3" = sample(11:15) )
      
      data <- data[ sample(1:5), ]            
      data <- data$var2[ c(1,3) ] = NA
      print( data )
      
      data[ ,1 ]
      data[ ,"var1" ]
      data[ 1:2,"var2" ]
      
      ## Logicals ands ors
      
      data[ ( data$var1 <= 3 & data$var3 > 11 ), ]
      data[ ( data$var1 <= 3 | data$var3 > 15 ), ]
      
      ## Dealing with missing values
      
      X[which( data$var2 > 8 ),]
      
      ## Sorting 
      
      sort( data$var1 )
      sort( data$var1, decreasing=TRUE )
      sort( data$var2, na.last=TRUE )
      
      ## Ordering 
      
      data[ order( data$var1 ), ]
      data[ order( data$var1, data$var3 ), ]
      
      ## Ordering with plyr
      
      library(plyr)
      
      arrange( data, var1 )
      arrange( data, desc(var1) )
      data$var4 <- rnorm(5)
      printf( data ) 
      
      ## Adding rows and column
      
      Y <- cbind( data, rnorm(5) )
      print( Y )
         
}


summerizing_data <- function()    
{
      if( !file.exists("./data"))
      {
            dir.create("./data")
      }
      
      ## Get the data
      
      fileUrl <- "https://data.baltimorecity.gov/api/views/k5ry-ef3g/rows.csv?accessType=DOWNLOAD"
      filePath <- "./data/restaurants.csv"
      download.file( fileUrl,destfile=filePath, method="curl" )
      restData <- read.csv( filePath )
      
      ## Look at some of the data
      
      head(restData,n=3)
      tail(restData,n=3)
      
      ## Make a summary
      
      summary( restData )
      
      ## More in depth information
      
      str( restData )
      
      ## Quantiles of quantitative variables
      
      quantile( restData$councilDistrict,na.rm=TRUE )
      quantile( restData$councilDistrict,probs=c(0.5,0.75,0.9) )
      
      table( restData$zipCode,useNA="ifany" )
      table( restData$councilDistrict,restData$zipCode )
      
      ## Check for missing values
      
      sum( is.na(restData$councilDistrict) )  
      any( is.na(restData$councilDistrict) )
      all( restData$zipCode > 0 )
      
      ## Row and column sums
      
      colSums( is.na(restData) )
      all( colSums(is.na(restData)) == 0 )
      
      ## Values with specific characteristics
      
      table( restData$zipCode %in% c("21212") )
      table( restData$zipCode %in% c("21212","21213") )
      
      restData[restData$zipCode %in% c("21212","21213"),]
      
      ## Cross Tabs
      
      data( UCBAdmissions )
      DF = as.data.frame( UCBAdmissions )
      summary( DF )
      
      xt <- xtabs( Freq ~ Gender + Admit,data=DF )
      xt
      
      ## Flat Tables
      
      warpbreaks$replicate <- rep(1:9, len = 54)
      xt = xtabs( breaks ~.,data=warpbreaks )
      xt
      
      ftable( xt )
      
      ## Size of Data Set
      
      fakeData = rnorm( 1e5 )
      object.size( fakeData )
      
}


create_new_vars <- function()
{
      fileUrl <- "https://data.baltimorecity.gov/api/views/k5ry-ef3g/rows.csv?accessType=DOWNLOAD"
      filePath <- "./data/restaurants.csv"
      download.file( fileUrl,destfile=filePath, method="curl" )
      restData <- read.csv( filePath )
      
      ## Creating Sequences
      
      s1 <- seq( 1,10,by=2 ) ; s1
      s2 <- seq( 1,10,length=3 ); s2
      x <- c(1,3,8,25,100); seq( along = x )
      
      ## Subsetting variables
      
      restData$nearMe = restData$neighborhood %in% c("Roland Park", "Homeland")
      table( restData$nearMe )
      
      ## Creating binary variables
      
      restData$zipWrong = ifelse( restData$zipCode < 0, TRUE, FALSE )
      table( restData$zipWrong,restData$zipCode < 0 )
      
      ## Creating Categorical Variables
      
      restData$zipGroups = cut( restData$zipCode,breaks=quantile( restData$zipCode ) )
      table( restData$zipGroups )
      
      table( restData$zipGroups,restData$zipCode )
      
      ## Easier Cutting
      
      library( Hmisc )
      restData$zipGroups = cut2( restData$zipCode,g=4 )
      table( restData$zipGroups )
      
      ## Creating factor varibales
      
      restData$zcf <- factor( restData$zipCode )
      restData$zcf[1:10]
      
      class( restData$zcf )
      
      ## Levels of factor variables
      
      yesno <- sample( c("yes","no"), size=10, replace=TRUE )
      yesnofac = factor( yesno, levels=c("yes","no") )
      relevel( yesnofac, ref="yes" )
      
      as.numeric( yesnofac )
      
      ## Cutting produces factor variables
      
      library( Hmisc )
      restData$zipGroups = cut2( restData$zipCode, g=4 )
      table( restData$zipGroups )
      
      ## Using the mutate function
      
      library( Hmisc ) 
      library( plyr )
      restData2 = mutate( restData, zipGroups=cut2( zipCode,g=4 ) )
      table( restData2$zipGroups )
      
      
      # Common Transforms -----------------------------------------------------
      #
      #              abs(x) : absolute value
      #             sqrt(x) : square root
      #          ceiling(x) : ceiling(3.475) is 4
      #            floor(x) : floor(3.475) is 3
      #   round(x,digits=n) : roun(3.475,digits=2) is 3.48
      #  signif(x,digits=n) : signif(3.475,digits=2) is 3.5
      #     cos(x) / sin(x) : etc.
      #              log(x) : natural logarithm
      #                       log2(x), log10(x) other common logs
      #              exp(x) : exponentiating x
      #
      # -----------------------------------------------------------------------
      
      # Resources -------------------------------------------------------------
      #
      # A tutorial from the developer of plyr : 
      #     http://plyr.had.co.nz/09-user/
      # Andrew Jaffe's R notes 
      #     http://www.biostat.jhsph.edu/~ajaffe/lec_winterR/Lecture%202.pdf
      #
      # -----------------------------------------------------------------------
      
}


reshaping_data <- function()
{
      
      
}


merging_data <- function() 
{
      
      
      
}







