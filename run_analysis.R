rm(list = ls())

library("dplyr")
library("reshape2")


currentDirectory   <- getwd();

# allocating variables for directory names of Test and train Data
TrainDataDirectory  <- paste(currentDirectory,"/train/", sep="")
TestDataDirectory   <- paste(currentDirectory,"/test/", sep ="")


# extracting Variable Data from Test and Train folders
train_variable_data <- read.table(paste(TrainDataDirectory,"X_train.txt",sep=""))
test_variable_data  <- read.table(paste(TestDataDirectory,"X_test.txt",sep=""))

###### Combining Train and Test Data sets for variables
Total_variable_data <- rbind(train_variable_data,test_variable_data)


# extracting Activity Data from Test and Train folders
train_activity_data <- read.table(paste(TrainDataDirectory,"y_train.txt",sep=""))
test_activity_data  <- read.table(paste(TestDataDirectory,"y_test.txt",sep=""))

# Combining Train and Test Data sets for variables
Total_activity_data <- rbind(train_activity_data,test_activity_data)



# extracting Subject Data from Test and Train folders
train_subject_data <- read.table(paste(TrainDataDirectory,"subject_train.txt",sep=""))
test_subject_data  <- read.table(paste(TestDataDirectory,"subject_test.txt",sep=""))

# Combining Train and Test Data sets for variables
Total_subject_data <- rbind(train_subject_data,test_subject_data)



# Reading features.txt file for Variable description
feature_text_file <- paste(currentDirectory,"/features.txt",sep="")
feature_text_data <- read.table(file = feature_text_file)



##identifying measurements with varaible name containg mean or standard deviation
#dentifying index values for each section catagory (mean or std) seprately
index_string_mean = grep(feature_text_data$V2,pattern = "mean",ignore.case = T)
index_string_std  = grep(feature_text_data$V2,pattern = "std",ignore.case = T)

######concatinating and sorting the identified indexes with mean or std
Total_idx_2_consider <- c(index_string_mean,index_string_std)
Total_idx_2_consider <- sort(Total_idx_2_consider)



#Extracting only the measurements on the mean and standard deviation for each measurement
Total_variable_data <- Total_variable_data[,Total_idx_2_consider]
names_data        <- feature_text_data[Total_idx_2_consider,2]
names_data = as.character(names_data)
names(filtered_data_set) <- names_data

#####Using descriptive activity names to name the activities in the data se
Activity_data <- read.table(paste(currentDirectory,"/activity_labels.txt",sep=""))
Activity_data$V2 <- as.character(Activity_data$V2)
for (idx in 1:length(Activity_data$V1))
{
  Total_activity_data[Total_activity_data == idx] = Activity_data$V2[idx]
}





#####Appropriately labels the data set with descriptive variable names. 
#Identify indexes of Variable names that computes mean or standard deviation(std) of variables
# note: variales such as angle(tBodyAccJerkMean,gravityMean) are not mean values but uses mean values
mean_idx  <- grep(names_data,pattern = "mean")
stnd_idx  <- grep(names_data,pattern = "std",ignore.case = T)

#### Variable name formatting for
new_labels <- gsub("\\)","",gsub("-","",gsub("mean","",gsub("std", "", names_data))))
new_labels <- gsub("Y,","YaxisAnd",gsub("Z,","ZaxisAnd",gsub("X,","XaxisAnd",gsub("e(","eBetween",new_labels,fixed=TRUE),fixed=TRUE),fixed=TRUE),fixed=TRUE)
new_labels <- gsub("\\,","and",gsub("\\(","",new_labels))
new_labels[mean_idx] <- paste("MeanOf",new_labels[mean_idx],sep="")
new_labels[stnd_idx] <- paste("StandardDeviationof",new_labels[stnd_idx],sep="")
names(Total_variable_data) <- new_labels



#####Tidy Data for Analysis
# merging variable data, activity data and subject data
TidyData <- cbind(Total_variable_data,Activity = Total_activity_data$V1 ,Subject = Total_subject_data$V1)
New_dataset <- melt(TidyData, id.vars=c("Activity", "Subject"))
New_dataset_grouped <- group_by(New_dataset, Subject, Activity)
OutputData = summarise(New_dataset_grouped, mean=mean(value))


##### Write Outputs to text file Output_of_Analysis.txt
write.table(OutputData,"Output_of_Analysis",row.names=F)





