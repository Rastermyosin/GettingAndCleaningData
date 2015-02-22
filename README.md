# GettingAndCleaningData
Programming Assignment for Coursera's Getting and Cleaning Data class from Johns Hopkins

### run_analysis

When sourced into R, this script will extract and manipulate data from a Samsung phone study. This code will output a text file entitled "TidyData.txt" which will contain the mean and standard deviation for each activity for each subject.

In order to use this data you must:
* Have the Samsung Phone data in your working directory (not within sub folders)
* Have the data.table and dpyr packages installed
* When you source("run_analysis.R") the script will auto-run

#### Variables

##### Files Names
Each of the following variables contains the file name of a particular piece of the overall dataset.

```
xTrainName # File name of the training data (X_train.txt)
yTrainName # File name of the training activity data (Y_train.txt)

xTestName # File name of the test data (X_test.txt)
yTestName # File name of the test activity data (Y_test.txt)

subjectTrainName # File name of the training subject IDs (subject_train.txt)
subjectTestName  # File name of the test subject IDs (subject_test.txt)

activityName # File name of the activity list (activity_labels.txt)
featureName  # File name of the feature list (features.txt)
```

##### Indices
Each of the following contains important indices in the dataset

```
featureColumns # Contains the column index for each mean and std measurement
```

##### Data Containers
Each of the following holds on to data gathered from the data files
```R
featureLabels # Contains the strings for each feature name (tBodyAcc.mean.X,...)

trainX # Contains all of the training data for each mean and std measurement
trainY # Contains all of the training activity index data

testX # Contains all of the test data for each mean and std measurement
testY # Contains all of the test activity index data

activityLabel  # Contains the index to string factor pair
activityFactor # Contains the activity factor for each observation in trainX and testX

subjectTrainLabels # Contains the subject IDs for the training data
subjectTestLabels  # Contains the subject IDs for the test data

rawData  # Contains the 'raw' data. This matrix is a combination of subject, activity, and trainX/testX data and labels
tidyData # Contains the average 'mean and std' for each activity for each subject. This variable is also outputted to a file entitled "TidyData.txt".
```



