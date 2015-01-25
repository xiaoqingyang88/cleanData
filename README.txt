==================================================================
Analysis of 
Human Activity Recognition Using Smartphones Dataset
==================================================================

This analysis is calculated the aveargae of mean value and standard deviation of features of a dataset from a experiements of Human Activity Recognition Using Smartphones Dataset


Data Source of the Analysis
============================
The input source data of this analysis is based on the dataset from the experiments carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details. 


The analysis includes the following files:
=========================================

- 'README.txt'

- 'codeBook.txt': Shows information about the variables used on the feature vector.

- 'tidydata.txt': The mean values grouped by subjects and activities of the mean value and standard deviation of measured features from the experiments.

- 'run_analysis.R': The R function to run the analysis


Use run_analysis R function
============================

This R function is used to generate the activity and subject based mean values of 
the 66 measurements on the mean and standard deviation of each measures from the 
dataset of the experiements on human recognition using smartphones.

Here are the steps to use this function:
1. Create folder c:\course\Data Cleaning\Data Science\Project
2. Download the zipped dataset from the link:
    http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 
3. Unzip the downloaded data into the following folder:
   C:/Course/Data Cleaning/Data Science/Project/UCI HAR Dataset
4. call this function

The function will return a list with two data frames
1. final1: this is a extraction of the measurements on the mean and standard deviation of each    
   measures from the experiement dataset. The variable names are the descriptive labels of the
   measurements
2. final2: this contains the subject and activity based mean values of the measurements on
   the mean and standard deviation of each measures

The function will also write final2 to tidydata.txt file under the working directory, i.e., C:/Course/Data Cleaning/Data Science/Project

Notes: 
======

For how to run the analysis, please refer to the comments in the run_analysis.R code.

