#Step 1: Preparation 

  # Leverage Dplyr library to initiate below set of work instructions
  
  library(dplyr)
  
  #Download the assignment Data set
  
  har_filename <- "getdata_projectfiles_UCI HAR Dataset.zip"
  
  # Check for the existence of the file in the working directory, if not, then below instructions will download the file 
  # into the working directory
  
  if (!file.exists(har_filename)){
    fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
    download.file(fileURL, har_filename)
  }
  
  # Check for the existence of the below folder, if not, then create and unzip the downloaded Data set
  
  if (!file.exists("UCI HAR Dataset")) { 
    unzip(har_filename) 
  }
  
  # Use Read.Table to read both the training and test files from the unzipped folder.
  # Assign them appropriate data frame names based on the file content
  
  
  features <- read.table("UCI HAR Dataset/features.txt", col.names = c("n","functions"))  #561 estimated features 
  
  activities <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("code", "activity")) # Types of activities performed
  
  subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject") # The participant code performed the experiment
                                                                                             # from the testing data
  
  x_test <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$functions) # Testing data for the estimated 561 features
  
  
  y_test <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "code") # Various activities or codes that will be 
                                                                              # linked to every testing data row 
  
  subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject") # The participant code performed the 
                                                                                                # experiment from the training data
  
  x_train <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$functions) # Testing data for the estimated 561 features
  
  y_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "code") # Various activities or codes that will be 
                                                                                 # linked to every testing data row 

#Step2: Data Frames consolidation linking Subject, Activity Codes and the featured data in the same order
        
  
  X <- rbind(x_train, x_test) # rbind function merges both the Testing & Training Data row-wise preserving 561 features per each row
  
  Y <- rbind(y_train, y_test) # rbind function merges both the Testing & Training Data row-wise for the actual activity codes
  
  Subject <- rbind(subject_train, subject_test) # cbind function merges both Training and Testing subjects [participants] row-wise 
  
  Merged_Data <- cbind(Subject, Y, X) # cbind function merges Subject[participants (Training & Testing)],
                                      # consolidated activity codes (Testing & Training) & consolidated 561 features (Training & Testing)
                                      # in the same order [Order is the key]
  

#Step3: Extraction of Mean and Standard Deviation per measurement
  
  Extracted_Tidy_Data <- Merged_Data %>% select(subject, code, contains("mean"), contains("std"))  # Dplyr functions are used to pull out 
                                                                                        # any fields that contains the word "mean"
                                                                                        # and "std" 
  
  
#Step4: Update Extrated_TidyData dataframe with descriptive activity names
  
  Extracted_Tidy_Data$code <- activities[Extracted_Tidy_Data$code, 2] # Replace the existing codes in the Extracted_Tidy_Data data frame with 
                                                                      # descriptive activity names by looking up activity data frame 
  


#step5: Rename the existing label names for the Extracted_Tidy_Data data frame, which will reflect descriptive names
  
  names(Extracted_Tidy_Data) <- tolower(names(Extracted_Tidy_Data))
  names(Extracted_Tidy_Data) <- gsub("\\.","",names(Extracted_Tidy_Data))
  names(Extracted_Tidy_Data)[2] = "activity"
  names(Extracted_Tidy_Data)<-gsub("acc", "accelerometer", names(Extracted_Tidy_Data))
  names(Extracted_Tidy_Data)<-gsub("gyro", "gyroscope", names(Extracted_Tidy_Data))
  names(Extracted_Tidy_Data)<-gsub("bodybody", "body", names(Extracted_Tidy_Data))
  names(Extracted_Tidy_Data)<-gsub("mag", "magnitude", names(Extracted_Tidy_Data))
  names(Extracted_Tidy_Data)<-gsub("^t", "time", names(Extracted_Tidy_Data))
  names(Extracted_Tidy_Data)<-gsub("freq", "frequency", names(Extracted_Tidy_Data))
  names(Extracted_Tidy_Data)<-gsub("^f", "frequency", names(Extracted_Tidy_Data))
  names(Extracted_Tidy_Data)<-gsub("tbody", "timebody", names(Extracted_Tidy_Data))
  names(Extracted_Tidy_Data)<-gsub("std", "standarddeviation", names(Extracted_Tidy_Data))  
    
#Step6: From the data set in step 5, creates a second, independent Final Extracted Tidy Data set with the average of each variable for each activity and each subject
  
  Final_Extracted_Tidy_Data <- Extracted_Tidy_Data %>%
    group_by(subject, activity) %>%
    summarise_all(funs(mean))
  write.table(Final_Extracted_Tidy_Data, "Final_Extracted_Tidy_Data.txt", row.name=FALSE)  