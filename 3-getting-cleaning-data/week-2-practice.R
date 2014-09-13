# =============================================================================
#          By : Mohamed T. Ismail
#      Course : Getting and Cleaning Data (Johns Hopkins University)
#    Provider : Coursera.com
# Description : Week 2 practice - getting web/api/db/etc. data.
# =============================================================================


web_scraping <- function()    
{
      # Reading contents of a webpage -----------------------------------------
      #
      #        url : Get a connection
      #       open : Open connection and set mode. Ex- open(con, open="rt")
      #      close : Close connection
      #  readLines : If not open, opens connection in "rt" (read text) mode
      #              If open, it reads from the current position
      #   MODES
      #  "r"|"rt"  : Open for reading in text mode
      #  "w"|"wt"  : Open for writing in text mode
      #  "a"|"at"  : Open for appendiong in text mode
      # "r+"|"r+b" : Open for reading and writing
      #              ...and some other combinations
      #
      # -----------------------------------------------------------------------
      
      
      URL <- "http://biostat.jhsph.edu/~jleek/contact.html"
      
      ## Read webpage content
      conn = url( URL )                # Create connection object
      htmlCode = readLines( conn )     # Read text from page
      close( conn )                    # Close connection
      
      ## Parse content
      print( htmlCode[10] )             # View contents of the 10th line
      print( nchar( htmlCode[20] ) )    # Count characters on 20th line
      
}


using_sqldf_package <- function()
{
      # SQLDF Package ---------------------------------------------------------
      #
      # The sqldf package allows for execution of SQL commands on R dataframes. 
      # Use the sqldf package to practice the queries we might send with the 
      # the dbSendQuery command in RMySQL. 
      #
      # -----------------------------------------------------------------------
      
      install.packages( sqldf )   ## Tool for using SQL Select on dataframes
      library( sqldf )
      
      ## Get data
      filePath <- "./data/survey_data.csv"
      if( !file.exists( filePath ) )
      {
            fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
            download.file( fileURL, filePath )
      }
      
      ## Load data
      surveyData <- read.csv( filePath )
      head( surveyData )
      
      ## Run SQL Queries On dataframe 
      print( sqldf("SELECT pwgtp1 FROM surveyData WHERE AGEP < 50") )
      print( sqldf("SELECT * FROM surveyData WHERE AGEP < 5 AND pwgtp1 < 10"))
      print( sqldf("SELECT DISTINCT pwgtp1 FROM surveyData") )
      print( sqldf("SELECT DISTINCT AGEP FROM surveyData") )
      
}


using_github_api <- function()
{
      # Github API ------------------------------------------------------------
      # Register an application with the Github API here 
      # https://github.com/settings/applications. 
      # Access the API to get information on your instructors repositories 
      # (hint: URL to use is "https://api.github.com/users/jtleek/repos"). 
      # Use this data to find the time that the datasharing repo was created. 
      # What time was it created? 
      # 
      # This tutorial may be useful 
      # (https://github.com/hadley/httr/blob/master/demo/oauth2-github.r). 
      # You may also need to run the code in the base R package and not R studio.
      # -----------------------------------------------------------------------
      
      
      # Process ---------------------------------------------------------------
      #
      # 1. Install and loaded httr and httpuv packages
      # 2. Find the OAuth Settings for Github
      # 3. Register an application on github and get its ID and secret values
      # 4. Use the application ID and secret to create an OAuth application
      # 5. Get a token for the application
      # 6. Set the token value using config() to do an HTTP GET request
      # 7. Send a GET request to the github url you want info about
      # 8. View the contents of the response from github using content()
      #
      # -----------------------------------------------------------------------
      
      install.packages(httr)      ## Tools for working with URLs and HTTP
      install.packages(httpuv)    ## HTTP and WebSocket server library

      library(httr)
      library(httpuv)
      
      # REQUEST  : Get github endpoints ---------------------------------------
      # RESPONSE :
      #     <oauth_endpoint>
      #       authorize: https://github.com/login/oauth/authorize
      #       access:    https://github.com/login/oauth/access_token      
      
      oauth_endpoints("github")

      
      # Register an application at https://github.com/settings/applications;
      #     Homepage URL : Use any URL you want (http://github.com is fine)
      #     Callback URL : http://localhost:1410
      # When registered you will get the application page with this info :
      #     Client ID : 395302338dee4a26e78f
      #     Client Secret : a8b16f3c03adc18233a27482c982ef0bd192d0b1
      # Use the ID and secret to create the OAuth Application :

      ## Create the OAuth Application
      myapp <- oauth_app( "github",                      
                         "395302338dee4a26e78f", 
                         "a8b16f3c03adc18233a27482c982ef0bd192d0b1" )
      
      ## Get OAuth credentials
      github_token <- oauth2.0_token( oauth_endpoints("github"), myapp )
      
      
      # A new browser page should open allowing you to authenticate the app :
      #    Console : "Waiting for authentication in browser..."
      #    Browser : <Click to Authenticate app>
      #    Browser : "Authentication complete. Please close this page and return to R."
      #    Console : "Authentication complete."
      
      
      ## Send get request and view response
      gtoken <- config( token = github_token )                  
      req <- GET( "https://api.github.com/users/jtleek/repos", gtoken )   
      stop_for_status(req)
      content( req )                                             
      
      # Alternate method...
      req <- with_config( gtoken, GET("https://api.github.com/users/jtleek/repos") )
      stop_for_status(req)
      content(req)
                 
}


using_fixed_width_files <- function()
{
      # Reading Fixed Width Files ---------------------------------------------
      #
      # - Use read.fwf to read the file, you can read directly from web
      # - Specify the number of lines to skip with 'skip='
      # - Specify the exact widths expected for the data with 'widths='
      #          +ve widths : Expected data that will loaded in a column
      #          -ve widths : ignored, use for whitespace
      
      # Example File Contents -------------------------------------------------
      # Weekly SST data starts week centered on 3Jan1990
      #
      #                Nino1+2      Nino3        Nino34        Nino4
      # Week          SST SSTA     SST SSTA     SST SSTA     SST SSTA
      # 03JAN1990     23.4-0.4     25.1-0.3     26.6 0.0     28.6 0.3
      # 10JAN1990     23.4-0.8     25.2-0.3     26.6 0.1     28.6 0.3
      # 17JAN1990     24.2-0.3     25.3-0.3     26.5-0.1     28.6 0.3
      #
      # -----------------------------------------------------------------------
      # ___10____  5  _4_  _3_  5  _4_  _3_  5  _4_  _3_  5  _4_  _3_  [WIDTHS]

      
      fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for"
      
      ## Determine the widths for your data
      fileWidths <- c(10,-5, 4,-1, 3,-5, 4,-1, 3,-5, 4,-1, 3,-5, 4,-1, 3 )
      
      ## Read fixed width file
      data <- read.fwf( file = url( fileURL ),
                        skip = 4,
                        widths = fileWidths )  
      
      head( data )
}

