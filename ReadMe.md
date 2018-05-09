ReadMe Guide:

The steps followed in run_analysis.R are as follows:

The test files for X & Y are initially read.
The train files for X & Y are read
The subjecttest and subjecttrain data is also read
The features text is also read.

The column names for the XTrain and XTest are updated from the features data

The activities and participants information is added to XTrain and Xtest from the YTrain / YTest and the SubjectTrain data

#1. Merges the training and the test sets to create one data set
The rows for XTrain and Xtest are then merged

#2. Extracts only the measurements on the mean and standard deviation for each measurement
A separate data is created that contains only the columns that have mean information. Similarly another dataset is created with only the columns that has the standard deviation information.

#3. Uses descriptive activity names to name the activities in the data set
All the activity names are described

#4. Appropriately labels the data set with descriptive variable names
All the variable names are described in detail

#5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
A summary is created for the mean data of every column grouped by participant. 