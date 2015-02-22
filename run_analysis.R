####################################################################
# run_analysis
#   Desc: Will extract and merge the mean and standard deviation 
#         values from the training and testing data sets from select
#         cell phone sensors during a variet of activities.
#
#   Author: Kevin O'Neill
#   Date: 2015.02.22
#
#   Usage: 
#
#   run_analysis
#         This script assumes that all of the necessary files are in
#         the current working direcrtory. Please make sure the 
#         X_test, X_train, Y_test, Y_train, features, activity_labels,
#         subject_test, and subject_train .txt files are in the 
#         working directory.
#
####################################################################

## Load Libraries ##
library(data.table)
library(dplyr)

## Main Code ##

# File Names for needed files.
xTrainName = "X_train.txt" # Training Data
yTrainName = "Y_train.txt" # Activity Data
xTestName  = "X_test.txt"  # Training Data
yTestName  = "Y_test.txt"  # Activity Data

subjectTrainName = "subject_train.txt" # Training subjects
subjectTestName = "subject_test.txt"   # Test subjects

activityName = "activity_labels.txt"   # Activity Label Names
featureName = "features.txt"           # Feature Label Names

# Indicies for all mean and std values in dataset
featureColumns = as.numeric(c(1:6, 41:46, 81:86, 121:126, 161:166, 201:202, 214:215, 227:228, 240:241,
                   266:271, 345:350, 424:429, 503:504, 516:517, 529:530, 542:543))              
                  
# Load in feature labels, then alter the feature names to be easier to read
featureLabels = data.table(read.table(featureName, stringsAsFactors = FALSE))             
featureLabels = gsub("\\(\\)", "", gsub("-", ".", featureLabels[featureColumns,V2]))

# Load in training data, select mean/std columns, changes names to feature labels
trainX = data.table(read.table(xTrainName, stringsAsFactors = FALSE))
trainX = trainX[,featureColumns, with = FALSE] # Select columns
trainX = setnames(trainX, featureLabels) # Set names to feature names

# Load in test data, select mean/std columns, changes names to feature labels
testX  = data.table(read.table(xTestName, stringsAsFactors = FALSE))
testX  = testX[,featureColumns, with = FALSE] # Select columns
testX  = setnames(testX, featureLabels) # Set names to feature names

# Load in Activity data for both training and test
trainY = data.table(read.table(yTrainName, stringsAsFactors = FALSE))
testY  = data.table(read.table(yTestName,  stringsAsFactors = FALSE))

# Generate activity label names from the activity data
activityLabel = data.table(read.table(activityName, stringsAsFactors = FALSE))
activityFactor = factor(c(trainY[,V1], testY[,V1]), labels = activityLabel[,V2]) # Create an activity factor vector

# Load in subject data for training and test data
subjectTrainLabels = data.table(read.table(subjectTrainName, stringsAsFactors = FALSE))
subjectTestLabels  = data.table(read.table(subjectTestName,  stringsAsFactors = FALSE))

# Combine subject data, activity factor, and mean/std data to form a large data matrix
rawData = cbind(rbind(subjectTrainLabels,subjectTestLabels), activityFactor, rbind(trainX,testX))
rawData = setnames(rawData, c(1,2), c("Subject", "Activity")) # Set names of subject and activity columns

# Compute the mean of the data for each activity for each subject
tidyData = rawData[, lapply(.SD, mean), by = list(Subject, Activity)]
tidyData = tidyData[order(Subject, Activity)] # Order the data by subject then activity

# Output tidy data to txt file.
write.table(tidyData, file="TidyData.txt", row.name=FALSE)

# EOF