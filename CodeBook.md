The run_analysis.R script performs the data download & preparation to execute the 5 tasks required as described in the Peer-graded Assignment [Getting and Cleaning Data Course Project].

1. Download the dataset:
Dataset downloaded as "HumanActivityDataset.zip" and extracted into the data folder.

2. Load the required libraries:
The script is using some functions from the "dplyr" package.

3. Create and Initialize Data variables:
The below variables have been created and assigned:
x_train: contains recorded features train data (7352 rows, 561 columns)
y_train: contains train data of [Activities Code] labels (2947 rows, 1 column)
subject_train: List of 30 volunteers within an age bracket of 19-48 years (70%) (7352 rows, 1 column)
x_test: contains recorded features test data (2947 rows, 561 columns)
y_test: contains test data of [Activities Code] labels (2947 rows, 1 column)
subject_test: List of 30 volunteers within an age bracket of 19-48 years (30%) (2947 rows, 1 column)
features: List of all features (561 rows, 2 columns)
[activityLabels]: List of All activities (6 rows, 2 columns)

4. Merges the training and the test datasets to create one data set:
Merge the Training and Test datasets together, also merge them with the Subjects and the Activities datasets. the result dataset will be stored in [TargetDataSet] with 10299 rows and 563 columns.

5. Extracts only the measurements on the mean and standard deviation for each measurement
Using the "Contains" function to get all columns having "mean()" and "std()" in thier names. and then use the Select (frpm dplyr package) to return the dataset and save it into [MeanAndStdDataSet] variable.

6. Uses descriptive activity names to name the activities in the data set
Merge the dataset from point #4 above to the Activity dataset and store the new dataset into [setWithActivityNames] variable (10299 rows, 69 columns).

7. Appropriately labels the data set with descriptive variable names
During the assignment of the variables, I did add descriptive names. And also I did replace all columns start with t & f with Time & Frequency respectively.

8. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject:
FinalData (180 rows, 69 columns) is created by summarizing TidyData taking the means of each variable for each activity and each subject after being grouped by subject and activity.

