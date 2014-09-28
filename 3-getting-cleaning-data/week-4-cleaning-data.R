# =============================================================================
#          By : Mohamed T. Ismail
#      Course : Getting and Cleaning Data (Johns Hopkins University)
#    Provider : Coursera.com
# Description : Week 4 Notes - Editing Text Variables, Regex, Dates
# =============================================================================


# Text in Data Sets ===========================================================
#
# Names of variables should be :
# 		- All lower case when possible
#		- Descriptive (Diagnosis vs Dx )
#		- Not duplicated
#		- Not have underscores or dots or white spaces
#
# Variables with character values :
#		- Should usually be made into factor variables (depends on application)
#		- Should be descriptive (use TRUE/FALSE instead of 0/1) 
#
# =============================================================================


editing_text_variables <- function()
{

	cameraData <- read.csv( "./cameras.csv" )
	names( cameraData )


	# Fixing character vectors ------------------------------------------------
	
	# Changing Case
	tolower( names(cameraData) )
	toupper( names(cameraDAta) )


	# strsplit() --------------------------------------------------------------
	# 
	# Good for automatically splitting variable names
	# Parameters : 
	#         x - character vector, each element of which is to be split
	#     split - character vector containing regex to use for splitting
	#
	# -------------------------------------------------------------------------

	splitNames = strsplit( names(cameraData), "\\." )  # escaping "." char
	splitNames[[5]]  # "intersection"
	splitNames[[6]]  # "Location" "1" after splitting "Location.1"


	# sapply() ----------------------------------------------------------------
	#
	# Applies a function to each element in a vector or list
	# Parameters :
	#		X - 
	#	  FUN - Function to be applied
	#
	# -------------------------------------------------------------------------

	splitNames[[6]][1]  # "Location" , ignoring the "1"

	# Do this and get all names ignoring anything after the "." using sapply

	firstElement <- function(x) { x[1] }  # Function to return first item
	sapply( splitNames, firstElement )    # Apply function to all items in list

}


lists <- function()
{
	mylist <- list( letters = c("A", "b", "c"), 
		            numbers = 1:3, matrix(1:25, ncol = 5) )
	head( mylist )

	mylist[1]        # first list component (letters)
	mylist$letters   # subset by name  (values of letters)
	mylist[[1]]      # subset by index (values of letters)
}


replace_remove_characters <- function()
{
	testName <- "this_is_a_test"

	 sub( "_", "", testName )  # removes only first item - "thisis_a_test"
	gsub( "_", "", testName )  # removes all items - "thisisatest"
}


finding_values <- function()
{
	# grep  - returns rows where search item was found in vector
	# grepl - "logical", returns TRUE/FALSE vector indicating found or not

	# Search - get the row numbers
	grep( "Alameda", cameraData$intersection )            # 4, 5, 36
	
	# Search - get logical vector 
	table{ grepl( "Alameda", cameraData$intersection) )   # F, F, F, T, T, F..

	# Search - subset dataframe
	cameraData2 <- cameraData[ !grepl("Alameda", cameraData$intersection), ]

	# Search - Get values
	grep( "Alameda", cameraData$intersection, value=TRUE )  # intersections

	# Search - get number of instances
	length( grep( "Alameda", cameraData$intersection) )     # 3
}


string_functions <- function()
{
	library( stringr )
	nchar( "Mohamed Ismail" )          # Number of characters : 14
	substr("Mohamed Ismail", 1, 7 )    # Substring : Mohamed
	paste( "Mohamed", "Ismail" )       # Append : Mohamed Ismail
	paste0( "Mohamed", "Ismail" )      # Append without spaces : MohamedIsmail
	str_trim("Mohamed    " )           # Remove spaces : "Mohamed"

}


regular_expressions <- function()
{

	# Metacharacters ----------------------------------------------------------
	#
	#		   ^ = start of a line OR 
	#            = matching characters not in the indicated class
	#	       $ = end of a line
	#          . = used to refer to any character
	#			 = need to escape it if not used as a metacharacter "\."
	#		   | = OR to define alternatives
	#            = alternatives can be regular expressions 
	# 		  () = contain subexpressions
	#		   ? = indicates expression is optional
	#		   * = any number, including none
	#          + = any number, but at least 1
	#         {} = specifiy the min/max number of matches of an expression
	#        m,n = at least m but not more than n matches
	#          m = exactly m matches
	#         m, = at least m matches
	#         \1 = matched expression
    #
	#
    # Examples :
	#	         [0-9] = any digit
	#             [Bb] = lower or uppercase letter
	#            [a-z] = any lowercase letter
	#         [a-zA-Z] = any letter
	#           [^?.]$ = not ending with ? or .
	# [Bb][Uu][Ss][Hh] = any combination spelling bush
	#             9.11 = anything b/w 9 and 11, 9-11, 9/11, 9:11
	#
	# -------------------------------------------------------------------------

	#   ------ ADD EXAMPLES ------------

}


working_with_dates <- function()
{
	d1 = date()       # "Sun Sep 28 14:00:00 2014"
	class( d1 )       # "character"

	d2 = Sys.Date()   # "2013-09-28"
	class( d2 )       # "Date"


	# Formattubg Dates --------------------------------------------------------
	#
	#   %d = day as a number (0-31)
	#   %a = abbreviated weekday
	#   %A = unabbreviated weekday
	#   %m = month (01-12)
	#   %b = abbreivated month
	#   %B = unabbreviated month
	#   %y = 2 digit year
	#   %Y = 4 digit year
	#
	# -------------------------------------------------------------------------

	format( d2, "%a %b %d" )   # "Sun Sep 28"

	# Creating Dates

	x = c( "1jan1960", "2jan1960", "31mar1960" )
	z = as.Date( x, "%d%b%Y" )   # "1960-01-01" "1960-01-02" "1960-03-31"

	z[1] - z[2]                  # Time difference of -1 days
	as.numeric( z[1] - z[2] )    # -1


	weekdays( d2 )   # "Sunday"
	months( d2 )     # "January"
	julian( d2 )     # 16082  - days from 01-01-1970


	# Lubridate ---------------------------------------------------------------

	library( lubridate ) 

	ymd( "20140108" )       # "2014-01-08 UTC"
	mdy( "08/01-2013" )     # "2013-08-04 UTC"
	dmy( "03-04-2013" )     # "2013-04-03 UTC"

	ymd_hms( "2011-08-03 10:15:03" )        # "2011-08-03 10:15:03 UTC"
	ymd_hms( "2011-08-03 10:15:03", 
		     tz = "Pacific/Auckland" )      # "2011-08-03 10:15:03 NZST"


	x = dmy( c( "1jan2013", "2jan2013", "31mar2013", "30jul2013" ) )
	wday( x[1] )                 # 3
	wday( x[1], label=TRUE )     # Tues

}


