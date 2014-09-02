

## RESOURCES ===================================================
##
## RMySQL vignette :
## http://cran.r-project.org/web/packages/RMySQL/RMySQL.pdf
##
## List of Commands :
## http://www.pantz.org/software/mysql/mysqlcommands.html
##
## Summary of Commands :
## http://www.r-bloggers.com/mysql-and-r/
##
## =============================================================



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

get_HDF5_data <- function()
{
      
      
}

get_web_data <- function()
{
      
      
}

get_API_data <- function()
{
      
      
}






