# Code Book for run_analysis.R
Serena Chung  
April 22, 2016  



This a code book for run_analysis.R, which tidies up activity data collected from accelerometers and gyroscopes in smartphones.

## Data Info

The dataset used in run_analysis.R is from the following link:

  - https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

A full description of the dateset is provided at the site where the data is obtained:

  - http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

## R Script  Outline

run_analysis.R performs the following steps:

1. Download the data if necessary.
2. Merges the training and test sets to create one dataset.
3. Extracts only the measurements on the mean and standard deviation for each measurement.
4. Uses descriptive activity names to name the activities in the dataset.
5. Appropriately labels the dataset with descriptive variable names.
6. From the dataset in step 5, creates a new file named averagedData.txt., which contents independent tidied dataset with the average of each variable for each activity and each subject.

## R Script Details

1. Download and unzip the data if necessary
    * The script first check of the data have already been downloaded, if not the R function `download.file` is used to download the zipped data file and the data file is unzipped.


2. Merge the training and the test sets to create one dataset.

    * 2.1\.  The features and activity information are read in:
        
        ```r
        dataDir <- "./UCI HAR Dataset"
        fileName <- paste(dataDir,"features.txt",sep="/")
        features.df <- read.table(fileName,col.names=c("idx","feature"),stringsAsFactors = FALSE)
        features <- features.df$feature
        fileName <- paste(dataDir,"activity_labels.txt",sep="/")
        activities.df <- read.table(fileName,col.names=c("idx","activity"),stringsAsFactors = FALSE)
        ```
    * 2.2\. New function `readHARData` is used to read in one set of data ("test"" or "train"") at a time and to store each set of of data in a dataframe. The result is two dataframes, `test.df` and `train.df`:
        
        ```r
        test.df <- readHARData("test")
        train.df <- readHARData("train")
        ```
    
        The first two columns in `test.df` and `train.df` are `subject` and `activity`, which indicate the person doing the activity and the index for the type of activity performed, respectively.  Columns 2 to 563 in `test.df` and `train.df` contains 561 features from the accelerometer and gyroscope.
        
    * 2.3\. The the dataframes for the test and train datasets are merged using `rbind` into one dataframe called `allData.df`.
    
3. Extract only the measurements on the mean and standard deviation for each measurement.

    The following code is used to create a new variable `desiredData.df` that contains only the mean and standard deviation for each measurements:
    
    ```r
    varnames <- names(allData.df) 
    idxOfVars2Keep <- grep("[Mm]ean|[Ss]td*", varnames)
    desiredData.df <- allData.df[,c(1,2,idxOfVars2Keep)] # 1,2 for subject and activity columns
    ```


4. Use descriptive activity names to name the activities in the dataset.

    The activity column is turned into a factor based on the data in activities.df, which is created in Step 2.1 and contains the description of the activity:
    
    ```r
    desiredData.df$activity <- factor(desiredData.df$activity, levels = activities.df$idx, labels = activities.df$activity)
    ```
    
    
5. Appropriately label the dataset with descriptive variable names.

    `gsub` is used to replaced old variable names with more descriptive ones:

    
    ```r
    oldNames <- names(desiredData.df)
    betterNames <- gsub("mean","Mean",oldNames)
    betterNames <- gsub("std","Std",betterNames)
    betterNames <- gsub("\\.","",betterNames)
    betterNames <- gsub("Gyro","Gyroscope",betterNames)
    betterNames <- gsub("Acc","Accelerometer",betterNames)
    betterNames <- gsub("^t","time",betterNames)
    betterNames <- gsub("^f","fft",betterNames)
    names(desiredData.df) <- betterNames
    ```

    `desiredData.df` contains 10299 rows of data with the following 88 columns:

    
    ```
    ## subject 
    ## activity 
    ## timeBodyAccelerometerMeanX 
    ## timeBodyAccelerometerMeanY 
    ## timeBodyAccelerometerMeanZ 
    ## timeBodyAccelerometerStdX 
    ## timeBodyAccelerometerStdY 
    ## timeBodyAccelerometerStdZ 
    ## timeGravityAccelerometerMeanX 
    ## timeGravityAccelerometerMeanY 
    ## timeGravityAccelerometerMeanZ 
    ## timeGravityAccelerometerStdX 
    ## timeGravityAccelerometerStdY 
    ## timeGravityAccelerometerStdZ 
    ## timeBodyAccelerometerJerkMeanX 
    ## timeBodyAccelerometerJerkMeanY 
    ## timeBodyAccelerometerJerkMeanZ 
    ## timeBodyAccelerometerJerkStdX 
    ## timeBodyAccelerometerJerkStdY 
    ## timeBodyAccelerometerJerkStdZ 
    ## timeBodyGyroscopeMeanX 
    ## timeBodyGyroscopeMeanY 
    ## timeBodyGyroscopeMeanZ 
    ## timeBodyGyroscopeStdX 
    ## timeBodyGyroscopeStdY 
    ## timeBodyGyroscopeStdZ 
    ## timeBodyGyroscopeJerkMeanX 
    ## timeBodyGyroscopeJerkMeanY 
    ## timeBodyGyroscopeJerkMeanZ 
    ## timeBodyGyroscopeJerkStdX 
    ## timeBodyGyroscopeJerkStdY 
    ## timeBodyGyroscopeJerkStdZ 
    ## timeBodyAccelerometerMagMean 
    ## timeBodyAccelerometerMagStd 
    ## timeGravityAccelerometerMagMean 
    ## timeGravityAccelerometerMagStd 
    ## timeBodyAccelerometerJerkMagMean 
    ## timeBodyAccelerometerJerkMagStd 
    ## timeBodyGyroscopeMagMean 
    ## timeBodyGyroscopeMagStd 
    ## timeBodyGyroscopeJerkMagMean 
    ## timeBodyGyroscopeJerkMagStd 
    ## fftBodyAccelerometerMeanX 
    ## fftBodyAccelerometerMeanY 
    ## fftBodyAccelerometerMeanZ 
    ## fftBodyAccelerometerStdX 
    ## fftBodyAccelerometerStdY 
    ## fftBodyAccelerometerStdZ 
    ## fftBodyAccelerometerMeanFreqX 
    ## fftBodyAccelerometerMeanFreqY 
    ## fftBodyAccelerometerMeanFreqZ 
    ## fftBodyAccelerometerJerkMeanX 
    ## fftBodyAccelerometerJerkMeanY 
    ## fftBodyAccelerometerJerkMeanZ 
    ## fftBodyAccelerometerJerkStdX 
    ## fftBodyAccelerometerJerkStdY 
    ## fftBodyAccelerometerJerkStdZ 
    ## fftBodyAccelerometerJerkMeanFreqX 
    ## fftBodyAccelerometerJerkMeanFreqY 
    ## fftBodyAccelerometerJerkMeanFreqZ 
    ## fftBodyGyroscopeMeanX 
    ## fftBodyGyroscopeMeanY 
    ## fftBodyGyroscopeMeanZ 
    ## fftBodyGyroscopeStdX 
    ## fftBodyGyroscopeStdY 
    ## fftBodyGyroscopeStdZ 
    ## fftBodyGyroscopeMeanFreqX 
    ## fftBodyGyroscopeMeanFreqY 
    ## fftBodyGyroscopeMeanFreqZ 
    ## fftBodyAccelerometerMagMean 
    ## fftBodyAccelerometerMagStd 
    ## fftBodyAccelerometerMagMeanFreq 
    ## fftBodyBodyAccelerometerJerkMagMean 
    ## fftBodyBodyAccelerometerJerkMagStd 
    ## fftBodyBodyAccelerometerJerkMagMeanFreq 
    ## fftBodyBodyGyroscopeMagMean 
    ## fftBodyBodyGyroscopeMagStd 
    ## fftBodyBodyGyroscopeMagMeanFreq 
    ## fftBodyBodyGyroscopeJerkMagMean 
    ## fftBodyBodyGyroscopeJerkMagStd 
    ## fftBodyBodyGyroscopeJerkMagMeanFreq 
    ## angletBodyAccelerometerMeangravity 
    ## angletBodyAccelerometerJerkMeangravityMean 
    ## angletBodyGyroscopeMeangravityMean 
    ## angletBodyGyroscopeJerkMeangravityMean 
    ## angleXgravityMean 
    ## angleYgravityMean 
    ## angleZgravityMean
    ```


6. From the dataset in step 5, create a new file called `averagedData.txt.`, which contents independent tidied dataset with the average of each variable for each activity and each subject.

    The `dplyr` package is used to calcuate the averages for each activity and each subject:
    
    ```r
    library(dplyr)
    averagedData.df <- desiredData.df %>%
    group_by(subject,activity) %>%
    summarize_each(funs(mean))
    ```

    `averagedData.df` contains 180 rows and 88 columns
    
    The tidied data framed `averagedData.df` is written to file averagedData.txt:
    
    
    ```r
    write.table(averagedData.df, "averagedData.txt", quote=FALSE,row.name=FALSE)
    ```
