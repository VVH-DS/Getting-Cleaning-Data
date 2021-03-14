# Code Book


The run_analysis.R script runs through 6 extensive steps to help create the Final Extracted Tidy Data Set 

1. **Preparation**

   This phase is split into two
     
    a. File Download - Dataset downloaded and extracted under the folder called UCI HAR Dataset
     
    b. Creation/Assignment of the Data Frames based on the downloaded Testing & Training Data Set

    
    + features from features.txt file : Dimension - 561 rows, 2 columns <br/>
    *The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ.*
        
    + activities from activity_labels.txt file : Dimension - 6 rows, 2 columns <br/>
    *List of activities performed when the corresponding measurements were taken and its relevant codes*
        
    + subject_test from test/subject_test.txt file : Dimension - 2947 rows, 1 column <br/>
    *Contains test data subject codes of 9/30 volunteer test subjects being observed via Samsung Phone app*
        
    + x_test from test/X_test.txt file : Dimension - 2947 rows, 561 columns <br/>
    *contains recorded 561 features of the test data*
        
    + y_test from test/y_test.txt file : Dimension - 2947 rows, 1 columns <br/>
    *contains test data of activities'codes*
        
    + subject_train from test/subject_train.txt file : Dimension -  7352 rows, 1 column <br/>
    *contains train data subject codes of 21/30 volunteer train subjects being observed via samsung Phone app*
        
    + x_train from test/X_train.txt file : Dimension -  7352 rows, 561 columns <br/>
    *contains recorded 561 features of train data*
         
    + y_train from test/y_train.txt file : 7352 rows, 1 columns <br/>
    *contains train data of activities'codes <br/>
        
2. **Data Frames consolidtion linking Subject, Activity Codes and the featured data in the same order**
    + X Dimension (10299 rows, 561 columns) is created by merging x_train and x_test using **rbind()** function [Row-Wise] 
    
    + Y Dimension (10299 rows, 1 column) is created by merging y_train and y_test using **rbind()** function [Row-Wise] 
    
    + Subject Dimension (10299 rows, 1 column) is created by merging subject_train and subject_test using **rbind()** function [Row-Wise] 
    
    + Merged_Data Dimension (10299 rows, 563 column) is created by merging Subject, Y and X using **cbind()** function [Column-Wise] 
   
    
3. **Extraction of Mean and Standard Deviation per measurement**
    + Extracted_TidyData Dimension (10299 rows, 88 columns) is created by subsetting Merged_Data, selecting only columns: subject, code and the measurements on the **mean** and **standard deviation** (std) for each measurement

    <br/>
    
4. **Update Extrated_TidyData dataframe with descriptive activity names**
    + Entire numbers in code column of the Extracted TidyData is replaced with corresponding activity taken from second column of the activities data frame

    <br/>
    
5. **Rename the existing label names for the Extracted_Tidy_Data data frame, which will reflect descriptive names**
    +  All the column names case is changed to lowercase
    +  Remove all the dots (.) in the column names 
    +  code column in Extracted TidyData renamed into activities
    +  Replace all the acc in column's name to accelerometer
    +  Replace all the  gyro in column's name to gyroscope
    +  Replace all the bodybody in column's name to body
    +  Replace all the mag in column's name to magnitude
    +  All that start with character t in column's name is replaced to time
    +  Replace all the freq in the column's name to frequency
    +  All that start with character f in column's name is replaced to frequency
    +  Replace all the tbody in column's name to timebody
    +  Replace all the std in column's name to standarddeviation
    

    <br/>
6. **From the data set in step 5, creates a second, independent Exgtracted Tidy Data Set with the average of each variable for each activity and each subject**
    + Final Extracted Tidy Data Dimension  (180 rows, 88 columns) is created by summarizing Extracted Tidy Data taking the means of each variable for each activity and each subject, after groupped by subject and activity.
    + Export Final Extracted Tidy Data into Final_Extracted_Tidy_Data.txt file.

<br/>
