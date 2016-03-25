#This R script uses a data set of human activity measures recorded by smartphones
#The original is available at: 
#http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphonesdata
#The script does some basic cleaning and reshaping to the data set and creates
#a tidy table giving the average values of a subset of measurments by subjects and
#activities. 


#POINT 0: Reading in data

#Creating a data sub-directory to read in the data

if (!file.exists("ds-project-3-data")) {
    dir.create("ds-project-3-data")
}

#Reading in and unziping the data

getfile <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
dataset_zip <- "ds-project-3-data/UCI_HAR_data.zip"
download.file(getfile, destfile = dataset_zip)
unzip(dataset_zip, exdir = "ds-project-3-data")

#Passing file paths to variables

pathtrain <- "./ds-project-3-data/UCI HAR Dataset/train"
pathtest <- "./ds-project-3-data/UCI HAR Dataset/test"
pathdatset <- "./ds-project-3-data/UCI HAR Dataset"


#Reading data into variables and transforming them into tables

X_train <- read.table(file.path(pathtrain, "X_train.txt"))
y_train <- read.table(file.path(pathtrain, "y_train.txt"))
subject_train <- read.table(file.path(pathtrain, "subject_train.txt"))
X_test <- read.table(file.path(pathtest, "X_test.txt"))
y_test <- read.table(file.path(pathtest, "y_test.txt"))
subject_test <- read.table(file.path(pathtest, "subject_test.txt"))
features <- read.table(file.path(pathdatset, "features.txt"))
activity_labels <- read.table(file.path(pathdatset, "activity_labels.txt"))


#POINTS 1 AND 4: CREATING ONE DATASET, USING DESCRIPTIVE VARIABLE NAMES

#Naming columns of subject files (subject_test, subject_train)
names(subject_test) <- "subjectID"
names(subject_train) <- "subjectID"


#Naming columns of activity files ( y_test, y_train)
names(y_test) <- "activity"
names(y_train) <- "activity"

#Naming columns of measurment files (X_test, X_train) by features
names(features) <- c("nr", "feature")
names(X_test) <- features$feature
names(X_train) <- features$feature

#Creating two tables (one for test and one for training) including each subject 
#and activity data. This gives tables with the following variables (columns): 
#subject_id, activity, featuers(1:561)
test_merged <- cbind(subject_test, y_test, X_test)
train_merged <- cbind(subject_train, y_train, X_train)

#Merging test and training data into one table (with all variable names descriptive
df_complete <- rbind(test_merged, train_merged)

#POINT 2: EXTRACTING MEASUREMENTS ON MEAN AND STANDARD DEVIATION 

#Extracting the relevant column numbers
col_meanstd <- grep("(mean|std)\\(\\)", names(df_complete))

#Adding columns subject_id and activity
col_meanstd <- c(1, 2, col_meanstd)

#Creating the data table for mean and standard deviation values
df_meanstd <- df_complete[, col_meanstd]


#POINT 3: USING DESCRIPTIVE ACTIVITY NAMES

#Sorting the data set by subject_id then by activity (just for aesthetic reasons)
library(dplyr)
df_meanstd <- arrange(df_meanstd, subjectID, activity)

#Reading levels of subject variable from data set
subjectlevels <- unique(df_meanstd$subjectID)

#Turning activity and subject_id variables into factor variables
df_meanstd$activity <- factor(df_meanstd$activity, labels = activity_labels$V2)
df_meanstd$subjectID <- factor(df_meanstd$subjectID, labels = subjectlevels)


#POINT 5: CREATING A SECCOND, INDEPENDENT DATA SET 
#(with the average of each variable for each activity and each subject)

library(reshape2)

#Creating (1) long data set and (2) recasting it for mean values per subject and activity
tidylong <- melt(df_meanstd, id = colnames(df_meanstd[1:2]))
tidywide <- dcast(tidylong, subjectID+activity ~ variable, mean)

#Eliminating "-" and "()" in variable names 
#("-" and "()" are not interpretd correctly when reading csv-file back into R)
names(tidywide) <- gsub("\\-", ".", names(tidywide))
names(tidywide) <- gsub("\\(\\)", "", names(tidywide))


#Writing the tidy data set to a file
write.table(tidywide, "./ds-project-3-data/tidydata.txt", row.names = FALSE)

#Reading tidydata.txt back into R for control
tidyfile <- read.table("./ds-project-3-data/tidydata.txt", header = TRUE)
