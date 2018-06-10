# This script downloads a set of data on activity tracking and does the following:
# 1. Merges the relevant data sets together to create one data set on which to perform analysis
# 2. Extracts only the measurements on the mean and standard deviation
# 3. Applies descriptive labels to the measurements
# 4. Applies descriptive names to the activities
# 5. Create a second, tidy data set with the average of each variable

#--------------------------------------------------------------------------------------------------
# A. Load the required package
#--------------------------------------------------------------------------------------------------
library(dplyr)

#--------------------------------------------------------------------------------------------------
# B. Download and unzip the data files to the current working directory
#--------------------------------------------------------------------------------------------------

#Download and unzip the data files
zip.files<- download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", "project_data.zip")
unzip("project_data.zip")

#Read in the required files
train.x<- read.table("./UCI HAR Dataset/train/X_train.txt", header = FALSE)
        train.y<- read.table("./UCI HAR Dataset/train/y_train.txt", header = FALSE)
        subject.train<- read.table("./UCI HAR Dataset/train/subject_train.txt", header = FALSE)

test.x<- read.table("./UCI HAR Dataset/test/X_test.txt", header = FALSE)
        test.y<- read.table("./UCI HAR Dataset/test/y_test.txt", header = FALSE)
        subject.test<- read.table("./UCI HAR Dataset/test/subject_test.txt", header = FALSE)

measures<- read.table("./UCI HAR Dataset/features.txt", header = FALSE)

activity<- read.table("./UCI HAR Dataset/activity_labels.txt", header = FALSE)

#--------------------------------------------------------------------------------------------------
# 1. Merge the relevant data sets together to create one data set
#--------------------------------------------------------------------------------------------------
# Combine the training data sets to create one training data set. 
train.data<- cbind(train.x, train.y, subject.train)

# Combine the test data sets to create one test data set
test.data<- cbind(test.x, test.y, subject.test)

# Combine the training and test data sets to create one full set of data
full.data<- rbind(train.data, test.data)

#--------------------------------------------------------------------------------------------------
# 2. Extract only the measurements on the mean and standard deviation 
#--------------------------------------------------------------------------------------------------

#From the measures data, identify those columns which relate to mean() or std()
cols<- "mean()|std()"
col.nums<- grep(cols, measures$V2)
var.names<- grep(cols, measures$V2, value = TRUE)


# Subset the data that relates to the mean() or std(), based on the column numbers above
mean_std.data<- full.data[,c(col.nums, 562:563)]

#--------------------------------------------------------------------------------------------------
# 3. Apply descriptive labels to the measurements
#-------------------------------------------------------------------------------------------------- 
#Assign the variable names to the mean_std.data columns
names(mean_std.data)<- c(var.names, "activity", "subject.id")

#Re-name the variables to be neater and more descriptive

mean_std.data.names <- names(mean_std.data)
proper.names <- cbind(c("Body", "Gravity", "Acc", "Gyro", "Mag", "mean\\(\\)", "std\\(\\)", "X$", "Y$", "Z$", "^t", "^f", "bodybody"), 
                      c("body", "gravity", "acceleration", "gyroscope", "magnitude", "mean", "stddev", "x-axis", "y-axis", "z-axis", "time", "frequency", "body"))

for(i in seq_along(proper.names[, 1])) 
        mean_std.data.names <- gsub(proper.names[i, 1], proper.names[i, 2], 
                                   mean_std.data.names)

#Apply the new variable names to the data set
names(mean_std.data)<- mean_std.data.names        

        
#--------------------------------------------------------------------------------------------------
# 4. Apply descriptive names to the activities
#--------------------------------------------------------------------------------------------------
#Use the activity names as they are stored in the second column of the activity data set
mean_std.data$activity<- factor(mean_std.data$activity,
                                levels = activity[,1],
                                labels = activity[,2])
        
#--------------------------------------------------------------------------------------------------
# 5. Create a second, tidy data set with the average of each measure
#--------------------------------------------------------------------------------------------------       
#Use dplyr chaining to group the data and then get the mean of all columns
avg.measures<- mean_std.data %>%
                group_by(activity, subject.id) %>%
                summarise_all(mean)
        
#Write the data to a file
write.table(avg.measures, file = "tidy_dataset_avg_measures.txt", row.names = FALSE)
