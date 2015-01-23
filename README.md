# CourseProject
Coursera-DataScience -DataGathering Course Project
This repository contains the data files and R scripts for the course project for the Coursera class on Getting and Cleaning Data.

The UCI HAR Dataset folder has all of the data files. The README.txt file within the UCI HAR folder describes the data files in detail.  In general:
** The files are split between two data sets - text and train.  
** Each data set has an X and Y file.  
	** The X file contains the data values.
	** The Y file contains the activity identifiers for each record in X labels
** Common to both data sets are:
	** The activity_labels file, defining the activities labels for each column
	** The features file, containing column headers.

These files are combined into the combinedDataset with the following steps:
1. All of the data files are read into R.
2. Since only the std and mean columns are required, these are extracted from the features data into two subsets - stddev_features, stddev_names, and mean_features and mean_names. 
3. The subsets of names and features are combined into single vectors - cols_to_get and colNames.
4. The cols_to_get vector is used to subset the X data frames for both the test and the training data.
5. The colNames vector is then set as the column names for the X data subset.
5. The activity labels are joined with the Y vectors to make the activities in the tidy dataset readable.
6. The activity names are then added as a new column with the X data.
7. The subject_ vectors are then added to the X_test/train_subset data frames to identify the subject ids.
8. An additional column differentiating the training from the test data was added, but later removed, since it was not explicitly required in the problem statement.
9. The process above was run on the training and the test data separately.  It is then combined into the combinedDataset.
10. All of the data sets used in creating the combinedDataset were removed to cleanup the workspace.
11. Finally - the plyr library is added to enable the ddply function.
12. ddply is then used with the "numcolwise" feature calling the mean function on all of the data in the combinedDataset, grouping on the subjectId and activity vectors.  This generates the results dataframe.
13. The results dataframe contains the average of each of the stddev and mean variables for each subject-activity combination.


The final answer is in the results.txt file in the same folder and consists of a matrix with the first and second columns as factors for the subjectId and activity respectively.  The following 79 columns represent all of the different measurements that contained std or mean in the name.  The data then represents the average value for each test subject and activity along all of the std and mean measurements.
