# =============================================================================
#          By : Mohamed T. Ismail
#      Course : Getting and Cleaning Data (Johns Hopkins University)
#    Provider : Coursera.com
# Description : Course Project analyzing accelerometer data.
# =============================================================================


# The purpose of this project is to demonstrate your ability to collect, 
# work with, and clean a data set. The goal is to prepare tidy data that 
# can be used for later analysis. 
# 
# You will be graded by your peers on a series of yes/no questions related 
# to the project. You will be required to submit: 
#       
# 1) a tidy data set as described below, 
# 2) a link to a Github repo with your script for performing the analysis
# 3) a code book that describes the variables, data, and any transformations 
# or work that you performed to clean up the data called CodeBook.md. 
# 
# You should also include a README.md in the repo with your scripts. 
# This repo explains how all of the scripts work and how they are connected.  
# 
# 
# One of the most exciting areas in all of data science right now is wearable 
# computing - see for example this article . 
# Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most 
# advanced algorithms to attract new users. The data linked to from the course 
# website represent data collected from the accelerometers from the 
# Samsung Galaxy S smartphone. A full description is available at the site 
# where the data was obtained: 
# 
# 
# http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 
# 
# Here are the data for the project: 
#       
# https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
# 
# You should create an R script (run_analysis.R) that does the following. 
# Merges the training and the test sets to create one data set.
# Extracts only the measurements on the mean and standard deviation 
# for each measurement. 
# Uses descriptive activity names to name the activities in the data set
# Appropriately labels the data set with descriptive variable names. 
# From the data set in step 4, creates a second, independent tidy data set 
# with the average of each variable for each activity and each subject.


run_analysis <- function()
{
      
      ## Load Data 
      

      x_test_data_path  <- "./uci-har-dataset/test/"
      y_test_data_path  <- "./uci-har-dataset/test/"
      x_train_data_path <- "./uci-har-dataset/train/"
      y_train_data_path <- "./uci-har-dataset/train/"
      

      ## Get a dataframe for each of dataset
      test_data <- get_xy_data( x_test_data_path, y_test_data_path )
      train_data <- get_xy_data( x_train_data_path, y_train_data_path )

      ## Merge the two datasets




      
      
      
      ## Extract only the measurements on the mean and standard 
      ## deviation of each measurement
      
      
      
      
      ## Use descriptive activity names to name the activites in the dataset
      
      
      
      
      
      ## Appropriately label the data with descriptive variable names
      

      
      
      
      ## From the dataset in step 4, create a second, independent tiny
      ## data set with the average of each variable for each activity
      ## and each subject
      
      
      
}


get_data <- function( path )
{

	datapath <- "C:/git-repo/data-science-coursera/3-getting-cleaning-data/course-project/uci-har-dataset/test/Inertial Signals"
	setwd(datapath)

	files <- list.files()

	for( file in files )
	{
		data <- read.table( file, sep=" ", header=FALSE )  ## read next file
		var.means <- tapply( data[1,], data[1,], mean )   ## means of each row
		var.stdev <- tapply( data[1,], data[1,], sd )     ## std dev of each row
			

		## Add means and stdev as new columns to data frame

	}




}












































