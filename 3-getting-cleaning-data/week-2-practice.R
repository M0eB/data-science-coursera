# =============================================================================
#          By : Mohamed T. Ismail
#      Course : Getting and Cleaning Data (Johns Hopkins University)
#    Provider : Coursera.com
# Description : Week 2 practice questions - getting web/api/db/etc. data.
# =============================================================================


question1 <- function()
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


question2 <- function()
{
      # The sqldf package allows for execution of SQL commands on R data frames. 
      # We will use the sqldf package to practice the queries we might send with 
      # the dbSendQuery command in RMySQL. 
      
      # Download the American Community Survey data and load it into an R object 
      # called "acs"
      
      # https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv 
      
      # Which of the following commands will select only the data for the 
      # probability weights pwgtp1 with ages less than 50?
      
      # a) sqldf("select * from acs where AGEP < 50 and pwgtp1")
      # b) sqldf("select pwgtp1 from acs where AGEP < 50")
      # c) sqldf("select * from acs")
      # d) sqldf("select pwgtp1 from acs")
      
}


question3 <- function()
{
      # Using the same data frame you created in the previous problem, 
      # what is the equivalent function to unique(acs$AGEP)
      
      # a) sqldf("select unique * from acs")
      # b) sqldf("select AGEP where unique from acs")
      # c) sqldf("select distinct pwgtp1 from acs")
      # d) sqldf("select distinct AGEP from acs")
      
      
}


question4 <- function()    
{
      # How many characters are in the 10th, 20th, 30th and 100th 
      # lines of HTML from this page:      
      # http://biostat.jhsph.edu/~jleek/contact.html 
      # (Hint: the nchar() function in R may be helpful)

      ## Read webpage content
      con = url( "http://biostat.jhsph.edu/~jleek/contact.html" )
      htmlCode = readLines( con )
      close( con )
      
      ## Count characters
      print( nchar( htmlCode[10] ) )
      print( nchar( htmlCode[20] ) )
      print( nchar( htmlCode[30] ) )
      print( nchar( htmlCode[100] ) )
      
}


question5 <- function()
{
      # Read this data set into R and report the sum of the 
      # numbers in the fourth column. 
      
      # https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for 
      
      # Original source of the data: 
      # http://www.cpc.ncep.noaa.gov/data/indices/wksst8110.for 
      
      # (Hint this is a fixed width file format)

      fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for "
      
      data <- read.fwf( file = url( fileURL ),
                        skip = 4,
                        widths = c(12, 7,4, 9,4, 9,4, 9,4) )  ##TODO: Fix these
      
}

