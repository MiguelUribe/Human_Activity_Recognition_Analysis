# Human_Activity_Recognition_Analysis
Creation of tidy data sets to enable further analysis on the Human Activity Recognization research study done by www.smartlab.ws

=========================================
##Author
Miguel Uribe
Getting and Cleaning Data Class
Data Specialization @ https://www.coursera.org/
March 13, 2016
=========================================
## Project Content

This project includes the following files
- 'README.md' This file
- run_analysis.R R script produces two tidy data sets after cleaning the data from Human Activity Recognization research study. This script:
   1. Merges the training and the test sets to create one data set.
   2.Extracts only the measurements on the mean and standard deviation for each measurement. 
   3.Uses descriptive activity names to name the activities in the data set
   4.Appropriately labels the data set with descriptive variable names. 
   5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for     each activity and each subject.
   
=========================================
##   Assumptions:
   1. All files were downloaded to a "UCI HAR Dataset" located under the working directory. To get this data, download and unzip to your working directory the following file
	 https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
 
  2. This R script is located in the working directory 
   
   
=========================================
##   Tidy data sets and Outputs
    TidySet - tidy data set that includes:
		Subject - ID of the subject (1-30)
		ActivityName - Activity done by subject
		Means of 33 experiment varibles [these variables include "mean()" in their name]
		Standard Deviation of 33 experiment varibles[these variables include "std()" in their name]
    TidySetAvr2 - tidy data set that includes the the average of each variable for each activity and each subject.
		Subject - ID of the subject (1-30)
		ActivityName - Activity done by subject
		Average of the 66 variables in TidySet by Subject and Activity
    Output:
	run_analysis.R prints the TidySet at the end of the execution and save TidySet as local file in the working directory