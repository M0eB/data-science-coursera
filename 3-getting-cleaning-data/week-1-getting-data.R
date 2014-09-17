# =============================================================================
#          By : Mohamed T. Ismail
#      Course : Getting and Cleaning Data (Johns Hopkins University)
#    Provider : Coursera.com
# Description : Week 1 notes and examples (from slides)
# =============================================================================


createSubDir <- function( subDir )
{
      mainDir <- getwd()
      dir.create(file.path(mainDir, subDir), showWarnings = FALSE)
}


get_and_read_csv <- function()
{
      
      if (!file.exists("data")) 
      {
            dir.create("data")
      }
      
      if( !file.exists("./data/cameras.csv") )
      {
            ## Download file
            fileUrl <- "https://data.baltimorecity.gov/api/views/dz54-2aru/rows.csv?accessType=DOWNLOAD"
            download.file( fileUrl, destfile = "./data/cameras.csv" )
      
            ## Save time file was downloaded
            dateDownloaded <- date()
      }
      
      ## Load file using read.table
      cameraData <- read.table( "./data/cameras.csv", sep = ",", header = TRUE )
      print ( head( cameraData ) )
      
      ## Load file using read.csv to simplify
      cameraData <- read.csv( "./data/cameras.csv" )
      print( head( cameraData ) )
      
}


get_and_read_xls <- function()
{
      
      if(!file.exists("data"))
      {
            dir.create("data")
      }
      
      if( !file.exists("./data/cameras.xlsx" ) )
      {
            ## Download file
            fileUrl <- "https://data.baltimorecity.gov/api/views/dz54-2aru/rows.xlsx?accessType=DOWNLOAD"
            download.file(fileUrl,destfile="./data/cameras.xlsx",method="curl")
            
            ## Save time file was downloaded
            dateDownloaded <- date()
      }
      
      ## Load xlsx file file
      library( xlsx )
      cameraData <- read.xlsx( "./data/cameras.xlsx", sheetIndex=1, header=TRUE )
      head( cameraData )
      
      ## Read specific rows/columns
      colIndex <- 2:3
      rowIndex <- 1:4
      cameraDataSubset <- read.xlsx( "./data/cameras.xlsx", sheetIndex=1, 
                                     colIndex=colIndex, rowIndex=rowIndex )
      cameraDataSubset
}


get_and_read_xml <- function()
{ 
      # Sample XML from http://www.w3schools.com/xml/simple.xml
      # <breakfast_menu>
      #     <food>
      #        <name>Belgian Waffles</name>
      #        <price>$5.95</price>
      #        <description>Belgian Waffles with maple syrup</description>
      #        <calories>650</calories>
      #     </food>
      #     ... more food nodes ...
      # </breakfast_menu>
      
      library( XML )
      
      ## Read xml directly from website
      fileUrl <- "http://www.w3schools.com/xml/simple.xml"
      doc <- xmlTreeParse( fileUrl, useInternal=TRUE )
      rootNode <- xmlRoot( doc )
         
      xmlName( rootNode )  # Get the name of the root node
      names( rootNode )    # Get the names of the child nodes
      
      ## Extract Nodes
      rootNode[[1]]        # <food> node
      rootNode[[1]][[1]]   # <name> node
      
      # Get all items recursively
      xmlSApply( rootNode, xmlValue )  
      
      ## Extract name values
      names <- xpathSApply( rootNode, "//name", xmlValue )
      print( names )
      
      ## Extract all price values
      prices <- xpathSApply( rootNode, "//price", xmlValue )
      print( prices )
}


get_and_read_xml_2 <- function()
{
      # Sample section form website
      # <li class="team-name">
      #     <a href="http://espn.go.com/nfl/team/_/name/wsh/washington-redskins">Washington</a>
      # </li>
      # <li class="score">
      #     <a href="/nfl/recap?gameId=400554688">23-17</a>
      # </li>
      
      ## Read xml directly from website
      fileUrl <- "http://espn.go.com/nfl/team/_/name/bal/baltimore-ravens"
      doc <- htmlTreeParse( fileUrl,useInternal=TRUE )
      
      ## Extract contents by attributes
      scores <- xpathSApply(doc,"//li[@class='score']",xmlValue)
      teams <- xpathSApply(doc,"//li[@class='team-name']",xmlValue)
      print( scores )
      print( teams )
}


get_and_read_json <- function()
{
      ##install.packages("jsonlite")
      
      library( jsonlite )
      
      ## Read json data directly form the web
      jsonData <- fromJSON( "https://api.github.com/users/jtleek/repos" )
      
      names( jsonData )         #Extract names of main nodes
      names( jsonData$owner )   #Extract inner nodes
      jsonData$owner$login      #Go deeper...
}


from_and_to_json <- function()
{
      myjson <- toJSON( iris, pretty=TRUE )
      print( "The JSON Data : ")
      cat( myjson )

      iris2 <- fromJSON( myjson )
      print( "The Original Data : ")
      head( iris2 )
}


data_table_package <- function()
{
      # data.table ------------------------------------------------------------
      #     - Inherits from data.frame
      #     - Written in C so much faster
      #     - Much, much faster at subsetting, group, and updating
      # -----------------------------------------------------------------------

      library(data.table)

      ## Create data tables just like data frames
      
      DT = data.frame( x=rnorm(9), y=rep( c("a","b","c"), each=3), z=rnorm(9) )
      head( DF, 3 )

      DT = data.frame( x=rnorm(9), y=rep( c("a","b","c"), each=3), z=rnorm(9) )
      head( DF, 3 )

      ## See all the data tables in memory
      tables() 
      
      ## Subsetting Rows
      DT[ 2,0 ]               # Get a row
      DT[ DT$y=="a", ]        # Get rows where y='a'
      DT[ c(2,3) ]            # Using one elements subsets by row (rows 2,3)


      ## Subsetting Columns
      DT[,c(2,3)]


      # Column Subsetting in data.table ---------------------------------------
      #     - The subsetting function is modified for data.table
      #     - The argument you pass after the comma is called an "expression"
      #     - In R an expression is a collection of statements 
      #       enclosed in curly brackets { } 
      # -----------------------------------------------------------------------

      {
            x = 1
            y = 2
      }

      k = { print(10); 5 }
      print( k )


      ## Calculating values for variables with expresions
      DT[ , list(mean(x), sum(z)) ]
      DT[ , table(y) ]

      ## Adding new columns
      DT[ , W:=Z^2 ]
      DT2 <- DT
      DT[ , y:=2 ]

      ## Careful
      head( DT, n=3 )
      head( DT2, n=3 )

      ## Multiple Operations
      DT[ , m:={tmp <- (x+z); log(tmp+5)} ]


      ## plyr like operations
      DT[ , a:=x>0 ]
      DT[ , b:=mean(x+w), by=a ]


      ## Special Variables : .N An integer, length 1, containing the number r
      set.seed( 123 )
      DT <- data.table( x=sample( letters[1:3], 1E5, TRUE) )
      DT[ , .N, by=x ]


      ## Keys
      DT <- data.table( x=rep( c("a","b","c"), each=100), y=rnorm(300) )
      setkey( DT, x )
      DT['a']

      ## Joins
      DT1 <- data.table( x=c('a', 'a', 'b', 'dt1'), y=1:4 )
      DT2 <- data.table( x=c('a', 'b', 'dt2'), z=5:7 )
      setkey( DT1, x ) 
      setkey( DT2, x )
      merge( DT1, DT2 )


      ## Fast Reading
      big_df <- data.frame( x=rnorm(1E6), y=rnorm(1E6) )
      file <- tempfile()
      write.table( big_df, file=file, row.names=FALSE, col.names=TRUE, sep="\t", quote=FALSE )
      system.time( fread(file) )
      system.time( read.table(file, header=TRUE, sep="\t") )

}

