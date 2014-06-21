
Getting and Cleaning Data
===

This readme file describes processing steps of "run_analysis.R" script for Programming assignment

1. Reading data pieces
--- 

All data is assumed to be in "/UCI HAR Dataset" subdirectory of the script folder, and be of the same structure as it is presented in course archive file
Files are loaded using "read.table" function with default parameters:

* measures from train and test sets and labels for columns
* activity codes from train and test sets and labels for them
* subject codes from train and test sets


2. Merging data to single data frame
---

Composition of resulting data frame is described by the table below:

|Labels from features.txt | "Activity" | "Subject" |
|-------------------------|---------------------|-------------------|
|X_train.txt              | y_train.txt         | subject_train.txt |
|X_test.txt               | y_test.txt  | subject_test.txt  |

Activity codes in "Activity" column are then replaced by labels from activity_labels.txt file

3. Getting mean and standard deviation columns
---

req_columns variable explicitly defines columns that contain mean and std measures to simplify script readability.
"dataset" variable is created with only required columns and saved to "dataset.txt" file in current project directory

4. Preparing tidy data set
---

dataset frame is flattened using "melt.data.frame" function from "reshape" library. New data frame contains all measures from original variable but in a more flattened style:

 Subject | Activity | Variable | value |
---------|----------|----------|-------|
Code of the experiment subject | Performing activity | Measure name (from features.txt) | Measure |

After that, tidy dataset is obtained by aggregating "values" with mean function and ordering by Subject/Activity/Variable columns.
Result is saved in "tidy_dataset.txt" file
  