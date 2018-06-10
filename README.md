# Getting and cleaning data - course project

This README.md file explains how the script performs the required analysis. For information about the background of this data, variable information, etc refer to the CodeBook.md. Additional information on the functions used in the script can be found in the run_analysis.R file.

The run_analysis.R script downloads a set of data on activity tracking and does the following:
1. Merges the relevant data sets together to create one data set on which to perform analysis
2. Extracts only the measurements on the mean and standard deviation
3. Applies descriptive labels to the measurements
4. Applies descriptive names to the activities
5. Create a second, tidy data set with the average of each variable

### Initial requirements

The dplyr package is required for this script. The first step is to load the package.
Secondly, the data is downloaded and unzipped. The required files are then loaded into memory.

### 1. Merge the data sets

There are 3 files that each form the 'train' and 'test' data sets. These files are combined together first into a 'train' and 'test' complete dataset.

These 2 resulting files are then appended together into one file that then contains the complete 'train' and 'test' data.

### 2. Extract measurements for mean and standard deviation

Any columns with 'mean()' or 'std()' are identified. Based on this match, only those columns are subsetted from the full dataset, plus the 2 columns from the other original files.

### 3. Apply descriptive labels to the measurements

Create a new matrix with the current short version of labels and the new descriptive label names. Use a for loop to replace the short version labels with the descriptive names.

### 4. Apply descriptive labels to the activities

Using the activity names given in the activity_labels source file, replace the activity ID in the 'activity' column with the activity name.

### 5. Create a tidy dataset with the mean of activity and subject ID

Using dplyr functions, group the dataset by activity and subject ID, then get the mean of all columns.
Write this resulting dataset to a text file.
