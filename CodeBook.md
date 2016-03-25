#CodeBook for the Getting and Cleaning Data Project

This is the code book for the Data Science Specialization class project for the Getting and Cleaning Data module.

##Overview
This project uses a data set from the "Human Activity Recognition Using Smartphones Data Set".  The data set contains measurements of the accelerometers from the Samsung Galaxy S smartphone. The measurements were captured from 30 volunteers on 6 different activities. Their smartphone captured various data about their movements.

A detailed description of the data and the method of collecting and processing is given on the website of the [research project](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones).


##Original files

The original data set contains two structurally equal subsets: a training and a test set (21 volunteers = 70% and 9 volunteers = 30%, respectively). The data of each subset is split into three files:

* X\_..: measurements from the accelerometer and gyroscope
* y\_..: activity's identifier
* subject\_..: subject's identifier

This project uses a subset of the original data. The following files of the orginal data set are used:

###Measurements:
* **X\_train.txt:** 7352 observations of the 561 features (for 21 volunteers)
* **X\_test.txt:** 2947 observations of the 561 features (for 9 volunteers)

###IDs:
* **subject\_train.txt:** An integer vector of lenght 7352 of the training volunteers' IDs, relating  volunteers to the observations in X\_train.txt
* **y\_train.txt:** An integer vector of length 7352 of the IDs of the activities observed in the training set, relating activities to the observations in X\_train.txt
* **subject\\_test.txt:** An integer vector of length 2947 of the test volunteers' IDs, relating volunteers to the observations in X\_test.txt
* **y\_test.txt:** A integer vector of length 2947 of the IDs of the activities observed in the test set, relating activities to the observations in X\_test.txt

###Lables:
* **features.txt:** Names of the 561 features
* **activity\_labels.txt:** Names and IDs of the 6 activities

A full description of the files is available in the README.txt and features\_info.txt on the website of the research project.

##Variables

The following feature variables are extracted from the original dataset and combined with the subjectID and activity variables:

tBodyAcc-mean()-Y | tBodyAcc-std()-Y | tGravityAcc-mean()-Y | tGravityAcc-std()-Y | tBodyAccJerk-mean()-Y | tBodyAccJerk-std()-Y | tBodyGyro-mean()-Y | tBodyGyro-std()-Y | tBodyGyroJerk-mean()-Y | tBodyGyroJerk-std()-Y | tBodyAccMag-std() | tBodyAccJerkMag-mean() | tBodyGyroMag-std() | fBodyAcc-mean()-X | fBodyAcc-std()-X | fBodyAccJerk-mean()-X | fBodyAccJerk-std()-X | fBodyGyro-mean()-X | fBodyGyro-std()-X | fBodyAccMag-mean() | fBodyBodyAccJerkMag-std() | fBodyBodyGyroJerkMag-mean() | tBodyAcc-mean()-Z | tBodyAcc-std()-Z | tGravityAcc-mean()-Z | tGravityAcc-std()-Z | tBodyAccJerk-mean()-Z | tBodyAccJerk-std()-Z | tBodyGyro-mean()-Z | tBodyGyro-std()-Z |tBodyGyroJerk-mean()-Z | tBodyGyroJerk-std()-Z | tGravityAccMag-mean() |tBodyAccJerkMag-std() | tBodyGyroJerkMag-mean() | fBodyAcc-mean()-Y | fBodyAcc-std()-Y | fBodyAccJerk-mean()-Y | fBodyAccJerk-std()-Y | fBodyGyro-mean()-Y | fBodyGyro-std()-Y | fBodyAccMag-std() | fBodyBodyGyroMag-mean() | fBodyBodyGyroJerkMag-std() | tBodyAcc-mean()-X | tBodyAcc-std()-X| tGravityAcc-mean()-X | tGravityAcc-std()-X | tBodyAccJerk-mean()-X | tBodyAccJerk-std()-X | tBodyGyro-mean()-X | tBodyGyro-std()-X | tBodyGyroJerk-mean()-X | tBodyGyroJerk-std()-X | tBodyAccMag-mean() | tGravityAccMag-std() | tBodyGyroMag-mean() | tBodyGyroJerkMag-std() | fBodyAcc-mean()-Z | fBodyAcc-std()-Z | fBodyAccJerk-mean()-Z | fBodyAccJerk-std()-Z | fBodyGyro-mean()-Z | fBodyGyro-std()-Z | fBodyBodyAccJerkMag-mean() | fBodyBodyGyroMag-std()

Note: In the final tidy data set all "-" are replaced by "." and all "()" are eliminated in these variable names. 

##Data Processing

The script _run\_analysis.R_ is used to processes the data. It ...

* merges the training and the test sets to create one data set,
* extracts only the measurements on the mean and standard deviation for each measurement, 
* uses descriptive activity names to name the activities in the data set,
* appropriately labels the data set with descriptive variable names, 
* creates a second, independent tidy data set with the average of each variable for each activity and each subject.

The following transformations are performed by the script:

0. Preparing the field: All of the relevant data files are read into data frames
1. Appropriate column headers are added, and the training and test sets are combined into a single data frame with 10299 rows containing the observations, and with 563 columns for the variables subjectID, activity and the 561 features
2. Only the 66 feature columns are kept that contain the exact string "mean()" or "std()". All other feature columnes are removed
3. The activity and subjectID columns are converted from integer to factor, assigning descriptive lables to the activites
4. The mean of each feature for each subject and each activity is calculated and the results stored in a tidy data frame, that contains the mean value for each of the 66 features for each of the subject/activity combinations. There are 6 activities for each of the 30 subjects giving a total of 180 rows
5. The tidy data frame is saved to a file, named "tidydata.txt".

_tidydata.txt_ has 180 rows containing the calculated mean values and 68 columns containing the variables. It meets the following principles:
* The column headings are explicit
* There is one column for each variable
* There are no duplicate columns
