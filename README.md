
# Getting and Cleaning Data Course Project

## Overview

The purpose of the project is to tidy up activity data collected from accelerometers and gyroscopes in smartphones.

The dataset for the project is

  - https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

A full description of the dateset is provided at the site where the data is obtained:

  - http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
  

**References**

Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. *Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine*. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra, Jorge L. Reyes-Ortiz. *Energy Efficient Smartphone-Based Activity Recognition using Fixed-Point Arithmetic*. Journal of Universal Computer Science. Special Issue in Ambient Assisted Living: Home Care. Volume 19, Issue 9. May 2013

Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. *Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine*. 4th International Workshop of Ambient Assited Living, IWAAL 2012, Vitoria-Gasteiz, Spain, December 3-5, 2012. Proceedings. Lecture Notes in Computer Science 2012, pp 216-223.

Jorge Luis Reyes-Ortiz, Alessandro Ghio, Xavier Parra-Llanas, Davide Anguita, Joan Cabestany, Andreu Català. *Human Activity and Motion Disorder Recognition: Towards Smarter Interactive Cognitive Environments*. 21th European Symposium on Artificial Neural Networks, Computational Intelligence and Machine Learning, ESANN 2013. Bruges, Belgium 24-26 April 2013.

## R Script

run_analysis.R performs the following steps:

1. Download the data if necessary.
2. Merges the training and test sets to create one dataset.
3. Extracts only the measurements on the mean and standard deviation for each measurement.
4. Uses descriptive activity names to name the activities in the dataset.
5. Appropriately labels the dataset with descriptive variable names.
6. From the dataset in step 5, creates a new file named averagedData.txt., which contents independent tidied dataset with the average of each variable for each activity and each subject.

CodeBook.md explains the structure of the script in more detail.

## Output
The results are provided in the file averagedData.txt.