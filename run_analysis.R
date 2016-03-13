   # run_analysis.R: This R script:
   # 1. Merges the training and the test sets to create one data set.
   # 2.Extracts only the measurements on the mean and standard deviation for each measurement. 
   # 3.Uses descriptive activity names to name the activities in the data set
   # 4.Appropriately labels the data set with descriptive variable names. 
   # 5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
   
   # Assumptions:
   # 1. All files were downloaded to a "UCI HAR Dataset" located under the working directory
   # 2. This R script is located in the working directory

#load libraries to use
   library(plyr)
   library(dplyr)
   
   
#Read features and Activity data
Features <- read.table("./UCI HAR Dataset/features.txt", col.names = c("FeatureID","Feature"))
ActivityLabels <- read.table("./UCI HAR Dataset/activity_labels.txt", col.names = c("ActivityID","ActivityName"))

#Read Test data
TestLabels <- read.table("./UCI HAR Dataset/test/y_test.txt")
TestSet <- read.table("./UCI HAR Dataset/test/X_test.txt")
TestSubject <- read.table("./UCI HAR Dataset/test/subject_test.txt")


#Validate number of features are correct
ColNbr <-  ncol(TestSet)
FeatureNbr <-  nrow(Features)
if(ColNbr != FeatureNbr){
   stop("TestSet file does not include the same number of features in the  features.txt file")
}

#Objecive 4.Appropriately labels the data set with descriptive variable names.
for (i in 1:NROW(Features)){
   names(TestSet)[i] <- as.character(Features[i,"Feature"])
}

#Validate that TestSet and TestLabels do include the same number of observations
DataNbr <- nrow(TestSet)
LabelNbr <- nrow(TestLabels)
if(DataNbr != LabelNbr){
   stop("TestSet and TestLabels do not include the same number of observations")
}
#Add Test Activity IDs as new column to the TestSet
TestSet$ActivityID <- TestLabels[[1]]

#Validate that TestSet and TestSubject  include the same number of observations
SubjectNbr <- nrow(TestSubject)
if(DataNbr != LabelNbr){
   stop("TestSet and TestSubject do not include the same number of observations")
}
#Add Test Activity IDs as new column to the TestSet
TestSet$Subject <- TestSubject[[1]]

#Read Training data
TrainingLabels <- read.table("./UCI HAR Dataset/train/y_train.txt")
TrainingSet <- read.table("./UCI HAR Dataset/train/X_train.txt")
TrainingSubject <- read.table("./UCI HAR Dataset/train/subject_train.txt")

#Validate number of features are correct
ColNbr <-  ncol(TrainingSet)
if(ColNbr != FeatureNbr){
     stop("TrainingSet file does not include the same number of features in the  features.txt file")
  }
 
#Objecive 4.Appropriately labels the data set with descriptive variable names.
for (i in 1:NROW(Features)){
   names(TrainingSet)[i] <- as.character(Features[i,"Feature"])
}
  
#Validate that TestSet and TestLabels does not include the same number of observations
DataNbr <- nrow(TrainingSet)
LabelNbr <- nrow(TrainingLabels)
if(DataNbr != LabelNbr){
   stop("TrainingSet and Traininglabels do not include the same number of observations")
}

#Add Test Activity IDs as new column to the TestSet
TrainingSet$ActivityID <- TrainingLabels[[1]]

#Validate that TrainingSet and TrainingSubject  include the same number of observations
SubjectNbr <- nrow(TrainingSubject)
if(DataNbr != LabelNbr){
   stop("TrainingSet and TrainingSubject do not include the same number of observations")
}
#Add Test Activity IDs as new column to the TestSet
TrainingSet$Subject <- TrainingSubject[[1]]

#Objecive 1.Merge the training and the test sets to create one data set.
TidySetTmp <- rbind(TestSet, TrainingSet)

#Objecive 2.Extract only the measurements on the mean and standard deviation for each measurement. 
TidySet <- cbind( TidySetTmp[nrow(Features)+2], TidySetTmp[nrow(Features)+1], 
            TidySetTmp[, grepl( "[:alnum:]*(mean|std)\\(\\)[:alnum:]*" , names( TidySetTmp ) )])

#Objecive 3.Use descriptive activity names to name the activities in the data set
TidySet <- merge.data.frame(ActivityLabels, TidySet, by.x = "ActivityID", by.y = "ActivityID", all = TRUE)
TidySet <- select(TidySet, -ActivityID)

#Objecive 5. From the data set in step 4, creates a second, independent tidy data set
# with the average of each variable for each activity and each subject.

TidySetAvr <- group_by(TidySet, Subject, ActivityName) 

# This code was used to create the script to get the TidySetAvr df beleow
# ColNameTmp <- ""
#    for (i in 1:ncol(TidySetAvr))
#       ColNameTmp <- paste0(ColNameTmp, "`",
#                            names(TidySetAvr)[[i]],"_Avrg`"," = mean(`", 
#                            names(TidySetAvr)[[i]], "`),")
# print(ColNameTmp)

TidySetAvr <- summarize(TidySetAvr,  
   `tBodyAcc-mean()-X_Avrg` = mean(`tBodyAcc-mean()-X`),
   `tBodyAcc-mean()-Y_Avrg` = mean(`tBodyAcc-mean()-Y`),
   `tBodyAcc-mean()-Z_Avrg` = mean(`tBodyAcc-mean()-Z`),
   `tBodyAcc-std()-X_Avrg` = mean(`tBodyAcc-std()-X`),
   `tBodyAcc-std()-Y_Avrg` = mean(`tBodyAcc-std()-Y`),
   `tBodyAcc-std()-Z_Avrg` = mean(`tBodyAcc-std()-Z`),
   `tGravityAcc-mean()-X_Avrg` = mean(`tGravityAcc-mean()-X`),
   `tGravityAcc-mean()-Y_Avrg` = mean(`tGravityAcc-mean()-Y`),
   `tGravityAcc-mean()-Z_Avrg` = mean(`tGravityAcc-mean()-Z`),
   `tGravityAcc-std()-X_Avrg` = mean(`tGravityAcc-std()-X`),
   `tGravityAcc-std()-Y_Avrg` = mean(`tGravityAcc-std()-Y`),
   `tGravityAcc-std()-Z_Avrg` = mean(`tGravityAcc-std()-Z`),
   `tBodyAccJerk-mean()-X_Avrg` = mean(`tBodyAccJerk-mean()-X`),
   `tBodyAccJerk-mean()-Y_Avrg` = mean(`tBodyAccJerk-mean()-Y`),
   `tBodyAccJerk-mean()-Z_Avrg` = mean(`tBodyAccJerk-mean()-Z`),
   `tBodyAccJerk-std()-X_Avrg` = mean(`tBodyAccJerk-std()-X`),
   `tBodyAccJerk-std()-Y_Avrg` = mean(`tBodyAccJerk-std()-Y`),
   `tBodyAccJerk-std()-Z_Avrg` = mean(`tBodyAccJerk-std()-Z`),
   `tBodyGyro-mean()-X_Avrg` = mean(`tBodyGyro-mean()-X`),
   `tBodyGyro-mean()-Y_Avrg` = mean(`tBodyGyro-mean()-Y`),
   `tBodyGyro-mean()-Z_Avrg` = mean(`tBodyGyro-mean()-Z`),
   `tBodyGyro-std()-X_Avrg` = mean(`tBodyGyro-std()-X`),
   `tBodyGyro-std()-Y_Avrg` = mean(`tBodyGyro-std()-Y`),
   `tBodyGyro-std()-Z_Avrg` = mean(`tBodyGyro-std()-Z`),
   `tBodyGyroJerk-mean()-X_Avrg` = mean(`tBodyGyroJerk-mean()-X`),
   `tBodyGyroJerk-mean()-Y_Avrg` = mean(`tBodyGyroJerk-mean()-Y`),
   `tBodyGyroJerk-mean()-Z_Avrg` = mean(`tBodyGyroJerk-mean()-Z`),
   `tBodyGyroJerk-std()-X_Avrg` = mean(`tBodyGyroJerk-std()-X`),
   `tBodyGyroJerk-std()-Y_Avrg` = mean(`tBodyGyroJerk-std()-Y`),
   `tBodyGyroJerk-std()-Z_Avrg` = mean(`tBodyGyroJerk-std()-Z`),
   `tBodyAccMag-mean()_Avrg` = mean(`tBodyAccMag-mean()`),
   `tBodyAccMag-std()_Avrg` = mean(`tBodyAccMag-std()`),
   `tGravityAccMag-mean()_Avrg` = mean(`tGravityAccMag-mean()`),
   `tGravityAccMag-std()_Avrg` = mean(`tGravityAccMag-std()`),
   `tBodyAccJerkMag-mean()_Avrg` = mean(`tBodyAccJerkMag-mean()`),
   `tBodyAccJerkMag-std()_Avrg` = mean(`tBodyAccJerkMag-std()`),
   `tBodyGyroMag-mean()_Avrg` = mean(`tBodyGyroMag-mean()`),
   `tBodyGyroMag-std()_Avrg` = mean(`tBodyGyroMag-std()`),
   `tBodyGyroJerkMag-mean()_Avrg` = mean(`tBodyGyroJerkMag-mean()`),
   `tBodyGyroJerkMag-std()_Avrg` = mean(`tBodyGyroJerkMag-std()`),
   `fBodyAcc-mean()-X_Avrg` = mean(`fBodyAcc-mean()-X`),
   `fBodyAcc-mean()-Y_Avrg` = mean(`fBodyAcc-mean()-Y`),
   `fBodyAcc-mean()-Z_Avrg` = mean(`fBodyAcc-mean()-Z`),
   `fBodyAcc-std()-X_Avrg` = mean(`fBodyAcc-std()-X`),
   `fBodyAcc-std()-Y_Avrg` = mean(`fBodyAcc-std()-Y`),
   `fBodyAcc-std()-Z_Avrg` = mean(`fBodyAcc-std()-Z`),
   `fBodyAccJerk-mean()-X_Avrg` = mean(`fBodyAccJerk-mean()-X`),
   `fBodyAccJerk-mean()-Y_Avrg` = mean(`fBodyAccJerk-mean()-Y`),
   `fBodyAccJerk-mean()-Z_Avrg` = mean(`fBodyAccJerk-mean()-Z`),
   `fBodyAccJerk-std()-X_Avrg` = mean(`fBodyAccJerk-std()-X`),
   `fBodyAccJerk-std()-Y_Avrg` = mean(`fBodyAccJerk-std()-Y`),
   `fBodyAccJerk-std()-Z_Avrg` = mean(`fBodyAccJerk-std()-Z`),
   `fBodyGyro-mean()-X_Avrg` = mean(`fBodyGyro-mean()-X`),
   `fBodyGyro-mean()-Y_Avrg` = mean(`fBodyGyro-mean()-Y`),
   `fBodyGyro-mean()-Z_Avrg` = mean(`fBodyGyro-mean()-Z`),
   `fBodyGyro-std()-X_Avrg` = mean(`fBodyGyro-std()-X`),
   `fBodyGyro-std()-Y_Avrg` = mean(`fBodyGyro-std()-Y`),
   `fBodyGyro-std()-Z_Avrg` = mean(`fBodyGyro-std()-Z`),
   `fBodyAccMag-mean()_Avrg` = mean(`fBodyAccMag-mean()`),
   `fBodyAccMag-std()_Avrg` = mean(`fBodyAccMag-std()`),
   `fBodyBodyAccJerkMag-mean()_Avrg` = mean(`fBodyBodyAccJerkMag-mean()`),
   `fBodyBodyAccJerkMag-std()_Avrg` = mean(`fBodyBodyAccJerkMag-std()`),
   `fBodyBodyGyroMag-mean()_Avrg` = mean(`fBodyBodyGyroMag-mean()`),
   `fBodyBodyGyroMag-std()_Avrg` = mean(`fBodyBodyGyroMag-std()`),
   `fBodyBodyGyroJerkMag-mean()_Avrg` = mean(`fBodyBodyGyroJerkMag-mean()`),
   `fBodyBodyGyroJerkMag-std()_Avrg` = mean(`fBodyBodyGyroJerkMag-std()`)
)

print(TidySet)