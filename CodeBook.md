# CodeBook for the Getting and cleaning data course project

The data used in this analysis is from  accelerometers from the Samsung Galaxy S smartphone. 
A full description is available at the site where the data was obtained:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

A link to the data used in the course project is here:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

In essence, the data is the accelerometer and gyroscope readings of 30 volunteers performing different activities.

### Data used in the analysis
The course project requires the 'train' and 'test' datasets to be merged into one for analysis, plus descriptive labels to be provided. 
This descriptive labelling requires additional files related to the features and activities. The following text files are used:
1. X_train
2. y_train
3. subject_train
4. X_test
5. y_test
6. subject_test
7. features
8. activity_labels

### Resulting data set
The outcome of the run_analysis.R script is a tidy data file in .txt format. This file contains a matrix of the mean of every column, 
grouped by activity and subject ID. This file meets the requirements of 'tidy data' (according to Hadley Wickham), specifically:
1. Each variable forms a column - in this case, the variable is the mean of each column - 1 variable per column
2. Each observation forms a row - in this case, each observation is grouped by activity and subject ID - 1 observation per row
3. Each type of observational unit forms a table - the data set is compiled into one table, with all observations relevant and included.

### Reference
Hadley Wickham *Tidy  Data* article from the *Journal of Statistical Software* published August 2014, http://jstatsoft.org
