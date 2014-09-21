
# CodeBook

This document describes the data contained within Tidy_Data.txt .

## Generation

* The data within Tidy_Data.txt was generated using the Run_Analysis.R script. 
* For information on how the data is generated please refer to the README.md fil which accompanies the script HERE. 
* Note that Tidy_data.txt only includes a subset of the original data on which the script runs. The original data and it's description can be found here : http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones


## Variables

Tidy_Data.txt contains the following three types of variables :

* subject : The subject who peformed the activity (30 different subjects)
* activity : The activity performed by the subject (ie - Walking, Sitting, etc.)
* measurements : Different measurements captured while the subject was performing the activity.

Each row within the data identifies the subject, the activity performed, and the mean of all of the measurements captured for that user performing that activity for each of the different measurement types.


## Measurements

Below are descriptions of each of teh measurements captured :

"subject" - The individual for each the measurements were captured..
"activity" - The activity performed by the subject (ie- "WALKING", "SITTING", etc.).

"tBodyAcc-mean()-X" - Mean of the body acceleration time domain signal on the X axis.
"tBodyAcc-mean()-Y" - Mean of the body acceleration time domain signal on the Y axis.
"tBodyAcc-mean()-Z" - Mean of the body acceleration time domain signal on the Z axis.
"tBodyAcc-std()-X" - Standard Deviation of the body acceleration time domain signal on the X axis.
"tBodyAcc-std()-Y" - Standard Deviation of the body acceleration time domain signal on the Y axis.
"tBodyAcc-std()-Z" - Standard Deviation of the body acceleration time domain signal on the Z axis.
"tGravityAcc-mean()-X" - Mean of the gravity acceleration time domain signal on the X axis.
"tGravityAcc-mean()-Y" - Mean of the gravity acceleration time domain signal on the Y axis.
"tGravityAcc-mean()-Z" - Mean of the gravity acceleration time domain signal on the Z axis.
"tGravityAcc-std()-X" - Standard Deviation of the gravity acceleration time domain signal on the X axis.
"tGravityAcc-std()-Y" - Standard Deviation of the gravity acceleration time domain signal on the Y axis.
"tGravityAcc-std()-Z" - Standard Deviation of the gravity acceleration time domain signal on the Z axis.
"tBodyAccJerk-mean()-X" - Mean of the body acceleration jerk time domain signal on the X axis.
"tBodyAccJerk-mean()-Y" - Mean of the body acceleration jerk time domain signal on the Y axis.
"tBodyAccJerk-mean()-Z" - Mean of the body acceleration jerk time domain signal on the Z axis.
"tBodyAccJerk-std()-X" - Standard Deviation of the body acceleration jerk time domain signal on the X axis.
"tBodyAccJerk-std()-Y" - Standard Deviation of the body acceleration jerk time domain signal on the Y axis.
"tBodyAccJerk-std()-Z" - Standard Deviation of the body acceleration jerk time domain signal on the Z axis.
"tBodyGyro-mean()-X" - Mean of the body gyroscope time domain signal on the X axis.
"tBodyGyro-mean()-Y" - Mean of the body gyroscope time domain signal on the Y axis.
"tBodyGyro-mean()-Z" - Mean of the body gyroscope time domain signal on the Z axis.
"tBodyGyro-std()-X" - Standard Deviation of the body gyroscope time domain signal on the X axis.
"tBodyGyro-std()-Y" - Standard Deviation of the body gyroscope time domain signal on the Y axis.
"tBodyGyro-std()-Z" - Standard Deviation of the body gyroscope time domain signal on the Z axis.
"tBodyGyroJerk-mean()-X" - Mean of the body gyroscope jerk time domain signal on the X axis.
"tBodyGyroJerk-mean()-Y" - Mean of the body gyroscope jerk time domain signal on the Y axis.
"tBodyGyroJerk-mean()-Z" - Mean of the body gyroscope jerk time domain signal on the Z axis.
"tBodyGyroJerk-std()-X" - Standard Deviation of the body gyroscope jerk time domain signal on the X axis.
"tBodyGyroJerk-std()-Y" - Standard Deviation of the body gyroscope jerk time domain signal on the Y axis.
"tBodyGyroJerk-std()-Z" - Standard Deviation of the body gyroscope jerk time domain signal on the Z axis.
"tBodyAccMag-mean()" - Mean of the body acceleration magnitude time domain signal.
"tBodyAccMag-std()" - Standard Deviation of the body acceleration magnitude time domain signal.
"tGravityAccMag-mean()" - Mean of the gravity acceleration magnitude time domain signal.
"tGravityAccMag-std()" - Standard Deviation of the gravity acceleration magnitude time domain signal.
"tBodyAccJerkMag-mean()" - Mean of the body acceleration jerk magnitude time domain signal.
"tBodyAccJerkMag-std()" -  Standard Deviation of the body acceleration jerk magnitude time domain signal.
"tBodyGyroMag-mean()" - Mean of the body gyroscope magnitude time domain signal.
"tBodyGyroMag-std()" - Standard Deviation of the body gyroscope magnitude time domain signal.
"tBodyGyroJerkMag-mean()" - Mean of the body gyroscope jerk magnitude time domain signal.
"tBodyGyroJerkMag-std()" - Standard Deviation of the body gyroscope jerk magnitude time domain signal.
"fBodyAcc-mean()-X" -  Mean of the Fast Fourier Transform of the body acceleration on the X axis.
"fBodyAcc-mean()-Y" -  Mean of the Fast Fourier Transform of the body acceleration on the Y axis.
"fBodyAcc-mean()-Z" -  Mean of the Fast Fourier Transform of the body acceleration on the Z axis.
"fBodyAcc-std()-X" - Standard Deviation of the Fast Fourier Transform of the body acceleration on the X axis.
"fBodyAcc-std()-Y" - Standard Deviation of the Fast Fourier Transform of the body acceleration on the Y axis.
"fBodyAcc-std()-Z" - Standard Deviation of the Fast Fourier Transform of the body acceleration on the Z axis.
"fBodyAcc-meanFreq()-X" - Weighted average of the frequency components to obtain a mean frequency on the X axis.
"fBodyAcc-meanFreq()-Y" - Weighted average of the frequency components to obtain a mean frequency on the Y axis.
"fBodyAcc-meanFreq()-Z" - Weighted average of the frequency components to obtain a mean frequency on the Z axis.
"fBodyAccJerk-mean()-X" - Mean of the Fast Fourier Transform of the body acceleration jerk on the X axis.
"fBodyAccJerk-mean()-Y" - Mean of the Fast Fourier Transform of the body acceleration jerk on the Y axis.
"fBodyAccJerk-mean()-Z" - Mean of the Fast Fourier Transform of the body acceleration jerk on the z axis.
"fBodyAccJerk-std()-X" - Standard Deviation of the Fast Fourier Transform of the body acceleration jerk on the X axis.
"fBodyAccJerk-std()-Y" - Standard Deviation of the Fast Fourier Transform of the body acceleration jerk on the Y axis.
"fBodyAccJerk-std()-Z" - Standard Deviation of the Fast Fourier Transform of the body acceleration jerk on the Z axis.
"fBodyAccJerk-meanFreq()-X" - Weighted average of the frequency components to obtain a mean frequency on the X axis.
"fBodyAccJerk-meanFreq()-Y" - Weighted average of the frequency components to obtain a mean frequency on the Y axis.
"fBodyAccJerk-meanFreq()-Z" - Weighted average of the frequency components to obtain a mean frequency on the Z axis.
"fBodyGyro-mean()-X" - Mean of the Fast Fourier Transform of the body gryoscope on the X axis.
"fBodyGyro-mean()-Y" - Mean of the Fast Fourier Transform of the body gryoscope on the Y axis.
"fBodyGyro-mean()-Z" - Mean of the Fast Fourier Transform of the body gryoscope on the Z axis.
"fBodyGyro-std()-X" - Standard Deviation of the Fast Fourier Transform of the body gryoscope on the X axis.
"fBodyGyro-std()-Y" - Standard Deviation of the Fast Fourier Transform of the body gryoscope on the Y axis.
"fBodyGyro-std()-Z" - Standard Deviation of the Fast Fourier Transform of the body gryoscope on the Z axis.
"fBodyGyro-meanFreq()-X" - Weighted average of the frequency components to obtain a mean frequency on the X axis.
"fBodyGyro-meanFreq()-Y" - Weighted average of the frequency components to obtain a mean frequency on the Y axis.
"fBodyGyro-meanFreq()-Z" - Weighted average of the frequency components to obtain a mean frequency on the Z axis.
"fBodyAccMag-mean()" - Mean of the Fast Fourier Transform of the body acceleration magnitude.
"fBodyAccMag-std()" - Standard Deviation of the Fast Fourier Transform of the body acceleration magnitude.
"fBodyAccMag-meanFreq()" - Weighted average of the frequency components to obtain a mean frequency
"fBodyBodyAccJerkMag-mean()" - Mean of the Fast Fourier Transform of the body gryoscope magnitude.
"fBodyBodyAccJerkMag-std()" - Standard Deviation of the Fast Fourier Transform of the body acceleration jerk magnitude.
"fBodyBodyAccJerkMag-meanFreq()" - Weighted average of the frequency components to obtain a mean frequency.
"fBodyBodyGyroMag-mean()" - Mean of the Fast Fourier Transform of the body gryoscope magnitude.
"fBodyBodyGyroMag-std()" - Standard Deviation of the Fast Fourier Transform of the body gryoscope magnitude.
"fBodyBodyGyroMag-meanFreq()" - Weighted average of the frequency components to obtain a mean frequency.
"fBodyBodyGyroJerkMag-mean()" - Mean of the Fast Fourier Transform of the body gryoscope jerk magnitude.
"fBodyBodyGyroJerkMag-std()" - Standard Deviation of the Fast Fourier Transform of the body gryoscope jerk magnitude.
"fBodyBodyGyroJerkMag-meanFreq()" - Weighted average of the frequency components to obtain a mean frequency.

