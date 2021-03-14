### README


#### Getting and Cleaning Data Course Project

This repository is a **VVH-DS** submission for Getting and Cleaning Data course project. It has the instructions on how to prepare and clean the data on the Human Activity recognition dataset collected via Samsung Smartphones.

#### Dataset

[Human Activity Recognition Using Samsung Smartphones](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

#### Key Files:

* **CodeBook.md** a code book that describes the variables, the data, and any transformations or work that I performed to clean up the data

* **run_analysis.R** performs the data preparation and then followed by the 6 extensive steps required as described in the assignment guidelines:
    + Preparation
    + Data Frames consolidtion linking Subject, Activity Codes and the featured data in the same order
    + Extraction of Mean and Standard Deviation per measurement
    + Update Extrated_TidyData dataframe with descriptive activity names
    + Rename the existing label names for the Extracted_Tidy_Data data frame, which will reflect descriptive names
    + From the data set in step 5, creates a second, independent Exgtracted Tidy Data Set with the average of each variable for each activity and each subject
    
* **Final_Extracted_Tidy_Data.txt** is the exported data set after going through all the extensive steps outlined above


<br/>
