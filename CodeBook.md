# Introduction

The script `run_analysis.R` performs the five steps described in the guidelines of the course project:

* It merges the training and the test sets to create one data set. To do this, first the similar data is merged with the ‘rbind()’ function to assign a value for every observation. 
* Then, only those columns with the mean and standard deviation measures are taken from the whole dataset. After extracting these columns, they are given the correct names, taken from `features.txt`.
* The script then extracts only the measurements on the mean and standard deviation for each measurement. 
* Uses descriptive activity names to name the activities in the data set. As activity data is addressed with values 1:6, we take the activity names and IDs from `activity_labels.txt` and they are substituted in the dataset. The data set resulting has labels with appropriate descriptive names.
* Finally, it generates a new dataset with all the average measures for each subject and activity type (30 subjects * 6 activities = 180 rows). This is done with the help of the ‘plyr’ package. The output file is called `averages_data.txt`, and is uploaded to this repository.

# Variables

* `x_train`, `y_train`, `x_test`, `y_test`, `subject_train` and `subject_test` contain the data from the downloaded files.
* `x_data`, `y_data` and `subject_data` merge the previous datasets to further analysis.
* `features` contains the correct names for the `x_data` dataset, which are applied to the column names stored in `mean_and_std_features`, a numeric vector used to extract the desired data.
* A similar approach is taken with activity names through the `activities` variable.
* `all_data` merges `x_data`, `y_data` and `subject_data` in a big dataset.
* Finally, `averages_data` contains the relevant averages which will be later stored in a `.txt` file. `ddply()` from the plyr package is used to apply `colMeans()` and ease the development.