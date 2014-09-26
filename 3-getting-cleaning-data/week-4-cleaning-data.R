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
	# Important parameters : 
	#         x - 
	#     split - 

	splitNames = strsplit( names(cameraData), "\\." )
	splitNames[[5]]
	splitNames[[6]]


	# Aside - Lists -----------------------------------------------------------

	mylist <- list( letters = c("A", "b", "c"), 
		            numbers = 1:3, matrix(1:25, ncol = 5) )
	head( mylist )

	mylist[1]
	mylist$letters
	mylist[[1]]


	# sapply() ----------------------------------------------------------------
	#
	# Applies a function to each element in a vector or list
	# Important parameters :
	#		X - 
	#	  FUN - Function to be applied
	#


	splitNames[[6]][1]

	firstElement <- function(x){ x[1] }
	sapply( splitNames, firstElement )





}



regular_expressions <- function()
{





}


