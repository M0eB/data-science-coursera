# =============================================================================
#          By : Mohamed T. Ismail
#      Course : Getting and Cleaning Data (Johns Hopkins University)
#    Provider : Coursera.com
# Description : Week 4 Notes - Editing Text Variables, Regex, Dates
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


	# Aside - Lists -----------------------------------------------------------

	mylist <- list( letters = c("A", "b", "c"), 
		            numbers = 1:3, matrix(1:25, ncol = 5) )
	head( mylist )

	mylist[1]        # first list component (letters)
	mylist$letters   # subset by name  (values of letters)
	mylist[[1]]      # subset by index (values of letters)

}


replace_remove_characters <- function
{
	testName <- "this_is_a_test"

	 sub( "_", "", testName )  # removes only first item - "thisis_a_test"
	gsub( "_", "", testName )  # removes all items - "thisisatest"

}


finding_values <- function()
{
	# grep  - returns rows where search item was found in vector
	# grepl - "logical", returns TRUE/FALSE vector indicating found or not

	grep( "Alameda", cameraData$intersection )            # 4, 5, 36
	table{ grepl( "Alameda", cameraData$intersection) )   # F, F, F, T, T, F..
	cameraData2 <- cameraData[ !grepl("Alameda", cameraDAta$intersection), ]

}


regular_expressions <- function()
{





}


