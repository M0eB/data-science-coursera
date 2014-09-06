# =============================================================================
#          By : Mohamed T. Ismail
#      Course : Getting and Cleaning Data (Johns Hopkins University)
#    Provider : Coursera.com
# Description : Week 2 practice questions - getting web/api/db/etc. data.
# =============================================================================


question1 <- function()
{
      # Register an application with the Github API here 
      # https://github.com/settings/applications. 
      # Access the API to get information on your instructors repositories 
      # (hint: this is the url you want "https://api.github.com/users/jtleek/repos"). 
      # Use this data to find the time that the datasharing repo was created. 
      # What time was it created? 
      
      # This tutorial may be useful 
      # (https://github.com/hadley/httr/blob/master/demo/oauth2-github.r). 
      # You may also need to run the code in the base R package and not R studio.
      
      
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
      
      
      
}


question5 <- function()
{
      # Read this data set into R and report the sum of the 
      # numbers in the fourth column. 
      
      # https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for 
      
      # Original source of the data: 
      # http://www.cpc.ncep.noaa.gov/data/indices/wksst8110.for 
      
      # (Hint this is a fixed width file format)

      
      
}

