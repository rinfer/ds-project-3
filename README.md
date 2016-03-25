#README for the Class Project Getting and Cleaning Data


This is the README for the Data Science Specialization class project for the Getting and Cleaning Data module.

The goal of the class project is to read in a data set from the internet, reshape the data, perform an analysis on the subsetted data set, and produce a tidy data set.

##Characteristics of the data set

The original date come from the [Human Activity Recognition Using Smartphones Data Set Project](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

The data used for this class project can be classified into three "types":

1. Measurement data: values of 561 features
2. Label data: activity lables and feature lables 
3. ID data: IDs for the 30 volunteers participating in the research project and for the 6 activities controlled

The different data "types" are stored in different files. As the whole data set is split into a smaler test and a larger training set, there are two files for the measurement data (X\_test.txt, X\_train.txt) and four files for the ID data (subject\_test.txt, subject\_train.txt, y\_test.txt, y\_train.txt). 

The labels are the same for both the test and the training data. So there are only two label files (features.txt, activity\_labels.txt)

##Characteristics of the script to process the data

To perform the required tasks the script "run\_analysis.R" is used. To prepare the field, it creates a sub directory "ds-project-3-data" in the current working directory and downloads the data into it. The sub directory can, of course, be deleted afterwards.

Next, the different files have to be combined into a single data frame. Step by step, this merged data frame is then tidied. Proper names are assigned to the variables (columns). The activity labels are assigned to the activity variable turning its values from integer to factor. Also the subjectIDs are turned into factors. Most importantly, the features are reduced to 66 by selecting only those representing mean and standard deviation measurements. Eventually, a tidy summary data frame is produced by calculating the average of each feature for each activity and each subject. 

The script requires the _reshape2_ and the _plyr_ packages, which should be installed from CRAN before running the script.

The script does not make use of functions. So you will have to click manually through each step. This is somewhat archaic, but should provide for better transparency. The individual steps are properly commented in the scipt.

The script's output is a tidy data file named "tidydata.txt", which meets the requirements of the class project.

See for more information on the data and the their processing the _CodeBook.md_ file.

References:

* [David Hood's tutorial](https://thoughtfulbloke.wordpress.com/2015/09/09/getting-and-cleaning-the-assignment/)
* [Hadley Wickham: Tidy Data](http://vita.had.co.nz/papers/tidy-data.pdf)


