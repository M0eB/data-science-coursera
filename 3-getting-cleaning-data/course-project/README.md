

# Description of run_analysis.R

This document describes the script run_analysis.R located here :

https://github.com/M0eB/data-science-coursera/blob/master/3-getting-cleaning-data/course-project/run_analysis.R

## Data

This script runs on data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description of the data is available at the site where it is obtained : 

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

The data can be downloaded from here :

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip


## Procedure

The following are the actions performed by the script to generate Tidy_Data.txt :

1. The following data files are loaded as data frames :
	
	- "activity_labels.txt"
	- "features.txt"
	- "/train/subject_train.txt"
	- "/train/x_train.txt"
	- "/train/y_train.txt"
	- "/test/subject_test.txt"   
	- "/test/x_test.txt"
	- "/test/y_test.txt"

2. The corresponding data sets are then merged to form a single set of each type :
	- X data from train and test sets are merged.
	- Y data from train and test sets are merged.
	- Subject data from train and test sets are merged.
		- These items are merged in teh same order to insure that rows in one set align with the correct rows from the other sets for the next step (ie- row 1 in each sets match the correct subject to the correct activity and measurements from X and Y datasets )

3. The measurements containing mean and standard deviation are extracted from the X dataset and columns for all other measurement types are discarded.

4. The values within the Y dataset are changed from activity id to the corresponding activity name. (ie - rows containing "1" are replaced with the corresponding activity "WALKING" ).

5. A new dataset is created (clean_data) by merging all of the datasets above to form a table containing subjects, activities, and all corresponding measurements of mean and standard deviation.

6. A new dataset is created (tidy_data) by reducing the data to only the mean values for each measurement, for each user and activity. Thus, only one measurement value is retained for each user and activity. 

7. The final tidy dataset is saved to a file called "Tidy_Data.txt"

For information about the data contained within Tidy_Data.txt, refer to the codebook here :

https://github.com/M0eB/data-science-coursera/blob/master/3-getting-cleaning-data/course-project/Codebook.md


