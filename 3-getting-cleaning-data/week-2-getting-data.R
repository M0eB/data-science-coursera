# =============================================================================
#          By : Mohamed T. Ismail
#      Course : Getting and Cleaning Data (Johns Hopkins University)
#    Provider : Coursera.com
# Description : Week 2 notes and examples (from slides)
# =============================================================================


get_mysql_data <- function()
{
      # Get a connection handle
      ucscDb <- dbConnect( MySQL(), 
                           user="genome", 
                           host="genome-mysql.cse.ucsc.edu" )
      
      ## Run a mysql command on the db
      ## Gets the list of all available databases
      result <- dbGetQuery( ucsc, "show databases;" ); 
      
      ## Always make sure you disconnect (returns TRUE)
      dbDisconnect( ucscDb );
      
      ## Contains the reuslt of all 
      print( result )
      
      ## -------------------------------------------------------
      
      ## The server used above has many databases
      ## You can connect to a specific database :
      
      ## Access a specific database within the mysql server
      hg19 <- dbConnect( MySQL(), 
                         user="genome",
                         db="hg19",
                         host="genome-mysql.cse.ucsc.edu")
      
      ## See what tables are availables in that database
      allTables <- dbListTables( hg19 )
      
      ## Large databse with over 10949 tables...
      length( allTables )
      allTables[1:5]  
      
      ## Get fields (columns) of a specific table
      dbListFields( hg19, "affyU133Plus2" )
      
      ## Get number of rows in the dataset using query
      dbGetQuery( hg19, "select count(*) from affyU133PLus2" )
      
      ## REad from the table
      affyData <- dbREadTable( hg19, "affyU133Plus2" )
      head( affyData )
      
      ## The table may be too large to read into R
      ## In that case, read only a subset of the table :
      
      ## Query what you want - result not yet in your pc
      query <- dbSendQuery( hg19, "select * from affyU133PLus2 where misMatches between 1 and 3" )
      
      ## Fetch the full query result
      affyMis <- fetch( query )
      quantile( affyMis$misMatches )
      
      ## Fetch only some of the query result
      affyMisSmall <- fetch( query, n=10 )
      dim( affyMisSmall )
      
      ## Clear the query from the server
      dbClearResult( query )
      
      ## Remember to close connection (returns TRUE)
      dbDisconnect( hg19 ) 

}


get_hdf5_data <- function()
{
      source( "http://bioconductor.org/biocLite.R" )
      biocLite( "rhdf5" )
      
      library( rhdf5 )
      
      created = h5createFile( "example.h5" )
      created
      
      ## This will install packages from Bioconductor http:///bioconductor.org/
      ## primarily used for genomics but also has good "big data" packages
      ## Can be used to interface with hdf5 data sets
      ## This lecture is modeled very closely on the rhdf5 tutorial here :
      ## http://www.bioconductor.org/packages/release/bioc/vignettes/rhdf5/inst/doc/rhdf5.pdf
      
      ## Create groups
      created = h5createGroup( "example.h5", "foo" )
      created = h5createGroup( "example.h5", "baa" )
      created = h5createGroup( "example.h5", "foo/foobaa" )
      h5ls( "example.h5" )
      
      ## Write to groups
      A = matrix( 1:10, nr=5, nc=2 )
      h5write( A, "example.h5", "foo/A" )
      
      B = array( seq( 0.1, 2.0, by=0.1 ), dim=c( 5, 2, 2) )
      attr( B, "scale" ) <- "liter"
      h5write( B, "example.h5", "foo/foobaa/B" )
      h5ls( "example.h5" )
      
      ## Write a data set
      df = data.frame( 1L:5L, seq( 0, 1, length.out=5 ),
                       c( "ab", "cde", "fghi", "a", "s"), stringsAsFactors=FALSE )
      h5write( df, "example.h5", "df" )
      h5ls( "example.h5" )
      
      ## Reading Data
      readA = h5read( "example.h5", "foo/A" )
      readB = h5read( "example.h5", "foo/foobaa/B" )
      readdf= h5read( "example.h5", "df" )
      readA
      
      ## Writing and Reading Chunks
      h5write( c( 12, 13, 14), "example.h5", "foo/A", index=list( 1:3, 1) )
      h5read( "example.h5", "foo/A" )
}


get_web_data <- function()
{
      # httr allows GET, POST, PUT, DELETE requests if you are authorized
      # You can authenticate with a user name or password
      # Most modern APIs use something like oauth
      # httr works well with Facebook, Google, Twitter, Github, etc.
      
      ## Getting Data off Webpages 
      con = url( "http://scholar.google.com/citations?user=HI-I6C0AAAAJ&hl=en" )
      htmlCode = readLines( con )
      close( con )
      htmlCode
      
      ## Parsing with XML
      library( XML )
      url <- "http://scholar.google.com/citations?user=HI-I6C0AAAAJ&hl=en"
      html <- htmlTreeParse( url, useInternalNodes=TRUE )
      xpathSApply( html, "//title", xmlValue )  
      
      xpathSApply( html, "//td[@id='col-citedby']", xmlValue )

      ## GET from httr Package
      library( httr )
      html2 = GET( url )
      parseHtml = htmlParse( content2, asText=TRUE )
      xpathSApply( parseHtml, "//title", xmlValue )
      
      ## Accessing Websites with Passwords
      pg1 = GET( "http://httpbin.org/basic-auth/user/passwd" )
      pg1
      
      pg2 = GET("http://httpbin.org/basic-auth/user/passwd",
                authenticate("user","passwd"))
      pg2
      
      names(pg2)
      
      ## Using Handles
      google = handle("http://google.com")
      pg1 = GET( handle=google, path="/" )
      pg2 = GET( handle=google, path="search" )
}


get_twitter_api_data <- function()
{
      ## Accessing Twitter from R      
      myapp = oauth_app( "twitter", key="yourConsumerKeyHere", secret="yourConsumerSecretHere" )
      sig = sign_oauth1.0( myapp, token="yourTokenHere", token_secret="yourTokenSecretHere" )
      homeTL = GET( "https://api.twitter.com/1.1/statuses/home_timeline.json", sig )
      
      ## Converting the JSON Object
      json1 = content(homeTL)
      json2 = jsonlite::fromJSON(toJSON(json1))
      json2[1, 1:4]
}

