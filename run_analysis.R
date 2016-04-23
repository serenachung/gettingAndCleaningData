## R script for Getting and Cleanning Data Assignment

#######################################################################
## Preliminary: download and unzip the data if not done already
#######################################################################
dataDir <- "./UCI HAR Dataset"
if (!dir.exists(dataDir)) { 
    fileName <- "har.zip"
    if (!file.exists(fileName)){
        fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
        download.file(fileUrl, dest=fileName, method="curl")
    }  
    unzip(fileName) 
}

#######################################################################
## 1. Merge the training and the test sets to create one data set.
#######################################################################

## get feature names
fileName <- paste(dataDir,"features.txt",sep="/")
features.df <- read.table(fileName,col.names=c("idx","feature"),stringsAsFactors = FALSE)
features <- features.df$feature
## get activity names
fileName <- paste(dataDir,"activity_labels.txt",sep="/")
activities.df <- read.table(fileName,col.names=c("idx","activity"),stringsAsFactors = FALSE)

## a function to read in data
readHARData <- function(case) {
    ## read in identifier of the subject who carried out the experiment
    fileName <- paste0(dataDir,"/",case,"/","subject_",case,".txt")
    subject.df <- read.table(fileName)
    ## read in identifier for the activity
    fileName <- paste0(dataDir,"/",case,"/","y_",case,".txt")
    y.df <- read.table(fileName)
    ## read in the data
    fileName <- paste0(dataDir,"/",case,"/","X_",case,".txt")
    x.df <- read.table(fileName,col.names=features) # note that R automatically tidyied the column names slightly
    ## put the above data one dataframe
    data.df <- data.frame(subject=subject.df$V1,activity=y.df$V1,x.df)
    return(data.df)
}

## read in test and training data using the above function & combine them into one data frame
test.df <- readHARData("test")
train.df <- readHARData("train")
allData.df <- rbind(train.df,test.df)

#######################################################################
## 2. Extract only the measurements on the mean and standard deviation 
#     for each measurement.
#######################################################################
varnames <- names(allData.df) 
idxOfVars2Keep <- grep("[Mm]ean|[Ss]td*", varnames)
desiredData.df <- allData.df[,c(1,2,idxOfVars2Keep)] # 1,2 for subject and activity columns

#######################################################################
## 3. Use descriptive activity names to name the activities in the data 
##    set.
#######################################################################
desiredData.df$activity <- factor(desiredData.df$activity, levels = activities.df$idx, labels = activities.df$activity)

#######################################################################
## 4. Appropriately label the data set with descriptive variable names.
#######################################################################
oldNames <- names(desiredData.df)
betterNames <- gsub("mean","Mean",oldNames)
betterNames <- gsub("std","Std",betterNames)
betterNames <- gsub("\\.","",betterNames)
betterNames <- gsub("Gyro","Gyroscope",betterNames)
betterNames <- gsub("Acc","Accelerometer",betterNames)
betterNames <- gsub("^t","time",betterNames)
betterNames <- gsub("^f","fft",betterNames)
names(desiredData.df) <- betterNames

#######################################################################
## 5. From the data set in step 4, create a second, independent tidy 
##    data set with the average of each variable for each activity 
##    and each subject.
#######################################################################
library(dplyr)
averagedData.df <- desiredData.df %>%
    group_by(subject,activity) %>%
    summarize_each(funs(mean))
write.table(averagedData.df, "averagedData.txt", quote=FALSE,row.name=FALSE)