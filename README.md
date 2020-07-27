# Geting-and-Cleaning-Data-Project Coursera

This is the course project for the Getting and Cleaning Data Coursera course.
The attached R script, 'clean and tidy data.R', conducts the following:
Download the dataset contained in: 'https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'.
Merge both the train and test datasets by x(measurements), y(activity) and subject.
Load the data(x's) feature, activity info and extract columns named 'mean'(-mean) and 'standard'(-std). 
Alter column names to descriptive. (-mean to Mean, -std to Std, and remove symbols like -, (, ))
Extract data by selected columns(line 7), and merge x, y(activity) and subject data. 
Replace y(activity) column to it's name by refering activity label (line 7).
Generate the 'tidy dataset' that consists of the average (mean) of each variable for each subject and each activity. The result is shown in the file 'tidydata.txt'.
