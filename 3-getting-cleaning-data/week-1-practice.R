# =============================================================================
#          By : Mohamed T. Ismail
#      Course : Getting and Cleaning Data (Johns Hopkins University)
#    Provider : Coursera.com
# Description : Week 1 practice questions - getting csv/xml/json/etc. data
# =============================================================================


question1 <- function()
{
      # The American Community Survey distributes downloadable data about
      # United States communities.Download the 2006 microdata survey about
      # housing for the state of Idaho using download.file() from here:       
      # https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv 
      
      # The code book, describing the variable names is here:      
      # https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FPUMSDataDict06.pdf 
      
      # How many properties are worth $1,000,000 or more?
      # a) 47    b) 31      c) 2076      d) 53
      

      if( !file.exists("./data/idaho_housing.csv") )
      {
            ## Download data
            fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv" 
            download.file( fileURL, destfile = "./data/idaho_housing.csv" )
      }
      
      
      if ( !file.exists("./data/idaho_housing_codebook.pdf") )
      {
            ## Download codebook
            codebookURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FPUMSDataDict06.pdf"
            download.file( codebookURL, destfile = "./data/idaho_housing_codebook.pdf")
      }
      
      ## Load data 
      housingData <- read.csv("./data/idaho_housing.csv")
      
      ## Get the property value (called VAL according to codebook )
      propertyValue <- housingData$VAL
      propertyValue <- na.omit( propertyValue )     
      
      ## Count properties worth $1M or more
      length( propertyValue[propertyValue >= 24] )  # 24 = $1M+ in codebook
      
}


question3 <- function()
{
      # Download the Excel spreadsheet on Natural Gas Aquisition Program here:     
      # https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx 
      
      # Read rows 18-23 and columns 7-15 into R and assign the result to a variable called:  dat 
      # What is the value of:  sum(dat$Zip*dat$Ext,na.rm=T) ?
      # a) 36534720     b) 0     c) 154339     d) 338924 
           
      if( !file.exists("./data/natural_gas_data.xlsx") )
      {
            ## Download data
            fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx" 
            download.file( fileURL, destfile = "./data/natural_gas.xlsx" )
      }
      
      library( xlsx )
      gasData <- read.xlsx( "./data/natural_gas_data.xlsx", sheetIndex=1, header=FALSE )
      head( gasData )
      
      ## Read specific rows/columns
      colIndex <- 7:15
      rowIndex <- 18:23
      dat <- read.xlsx( "./data/natural_gas_data.xlsx", sheetIndex=1, 
                        colIndex=colIndex, rowIndex=rowIndex )
      
      sum( dat$Zip * dat$Ext, na.rm = TRUE ) # Multiply the two columns and sum the results...
      
}


question4 <- function()
{
      # Read the XML data on Baltimore restaurants from here:      
      # https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml 
      # How many restaurants have zipcode 21231?

      library( XML )
      
      ## Read xml directly from website
      dataURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml"
      download.file( dataURL, destfile="./data/restaurants.xml")
      
      if( !file.exists("./data/restaurants.xml") )
      {
            ## Download data
            fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml"
            download.file( fileURL, destfile = "./data/restaurants.xml" )
      }
      
      doc <- xmlInternalTreeParse( "./data/restaurants.xml" )
      rootNode <- xmlRoot( doc )
      
      ## Get all zipcode values that match
      names <- xpathSApply( rootNode, "//row/zipcode", xmlValue )
      length( names[ names == "21231" ] )
}


question5 <- function()
{
      # The American Community Survey distributes downloadable data about 
      # United States communities. Download the 2006 microdata survey about 
      # housing for the state of Idaho using download.file() from here:      
      #      https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv 
      
      # Using the fread() command load the data into an R object DT 
      # Which of the following is the fastest way to calculate the average value 
      # of the variable pwgtp15 broken down by sex using the data.table package?
      
      # a) tapply(DT$pwgtp15,DT$SEX,mean)  
      # b) DT[,mean(pwgtp15),by=SEX]
      # c) mean(DT$pwgtp15,by=DT$SEX)  
      # d) mean(DT[DT$SEX==1,]$pwgtp15); mean(DT[DT$SEX==2,]$pwgtp15)
      # e) rowMeans(DT)[DT$SEX==1]; rowMeans(DT)[DT$SEX==2]
      # f) sapply(split(DT$pwgtp15,DT$SEX),mean)   
      
      
      
}


