# =============================================================================
#          By : Mohamed T. Ismail
#      Course : Getting and Cleaning Data (Johns Hopkins University)
#    Provider : Coursera.com
# Description : Course Project analyzing accelerometer data.
# =============================================================================

# -----------------------------------------------------------------------------
#
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
#
# -----------------------------------------------------------------------------

run_analysis <- function()
{
      
      # Prepare Paths ---------------------------------------------------------

      labels_file     <- "./activity_labels.txt"
      features_file   <- "./features.txt"
      train_subj_file <- "./train/subject_train.txt"
      train_x_file    <- "./train/x_train.txt"
      train_y_file    <- "./train/y_train.txt"
      test_subj_file  <- "./test/subject_test.txt"     
      test_x_file     <- "./test/x_test.txt"
      test_y_file     <- "./test/y_test.txt"


      ## Load Data Files  -----------------------------------------------------
      
      activities <- read.table( labels_file, header=FALSE, sep=" ", col.names=c("id", "activity") )            
      features <- read.table( features_file, header=FALSE, sep=" ", col.names=c("id","feature") )

      subject_train <- read.table( train_subj_file, header=FALSE, col.names="subject" )
      subject_test  <- read.table( test_subj_file, header=FALSE, col.names="subject" )

      x_train <- read.table( train_x_file, header = FALSE, col.names = features$feature )
      y_train <- read.table( train_y_file, header = FALSE, col.names = "activity" )
      
      x_test  <- read.table( test_x_file, header = FALSE, col.names = features$feature )
      y_test  <- read.table( test_y_file, header = FALSE, col.names = "activity" )


      ## Merge the two datasets -----------------------------------------------
      
      subject_data <- rbind( subject_train, subject_test)
      x_data <- rbind( x_train, x_test ); 
      y_data <- rbind( y_train, y_test ); 
      
      
      ## Remove unwanted data and change column names -------------------------
      
      ## Cleanup X data
      mean_std_columns <- grep( "mean|std", features$feature )
      x_data <- x_data[ ,mean_std_columns]
      colnames( x_data ) = features$feature[ mean_std_columns ]
      
      ## Cleanup Y data 
      ## TODO: Find a better way to do this, vectorized
      ##       Trying to read it from the activities table failed
      y_data$activity[ y_data$activity == "1" ] = "WALKING"
      y_data$activity[ y_data$activity == "2" ] = "WALKING_UPSTAIRS"
      y_data$activity[ y_data$activity == "3" ] = "WALKING_DOWNSTAIRS"
      y_data$activity[ y_data$activity == "4" ] = "SITTING"
      y_data$activity[ y_data$activity == "5" ] = "STANDING"
      y_data$activity[ y_data$activity == "6" ] = "LAYING"
      
      
      ## Merge data and sort ----------------------------------------------
      
      clean_data <- cbind( subject_data, y_data, x_data )
      clean_data[ with(clean_data, order(subject, activity)), ]  
      

      ## Create dataset with the average of each variable for each 
      ## activity and each subject
      
      library(plyr)
      tiny_dataset <- ddply( clean_data, .(subject, activity), numcolwise(mean) )
      
      
      ## Save new datasets ----------------------------------------------------
      
      write.table( tiny_dataset, file="Tidy_Data.txt", row.name=FALSE )
           
}


