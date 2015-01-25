# GettingandClearingDataCourseraProject
##Contains Variable names and usage of variables used in run_analysis.r file in this folder


###Variable Name               Variable Usage                   
currentDirectory   :   	Stores the current Data path 
TrainDataDirectory : 	  Stores the path for train data
TestDataDirectory  : 	  Stores the path for test data
feature_text_file  :    Stores the path for features.txt file



train_variable_data	:   Stores the variable measurement data from X_train.txt file
test_variable_data  :   Stores the variable measurement data from X_test.txt file
train_activity_data :   Stores the Activity data from y_train.txt file
test_activity_data  :   Stores the Activity data from y_test.txt file
train_subject_data 	:   Stores the Subject data from subject_train.txt file
test_subject_data   :   Stores the Subject measurement data from subject_test.txt file
feature_text_data   :   Stores the features.txt data that contains variable names of X_test and X_train data sets
Activity_data 		  :   Stores the data for features_info.txt that specifies activity


Total_variable_data : Contains both X_test and X_train and used as data frame for tidy data generation trough out the scope of the code
Total_activity_data : Contains total activity data from test and train datasets
Total_subject_data  : Contains total Subject data from test and train datasets


index_string_mean  	  : Indexing variable to identify Variable names containing "mean"(case insensitive) in them 
index_string_std  	  : Indexing variable to identify Variable names containing "std"(case insensitive) in them 
Total_idx_2_consider  : Indexing variable to identify Variable names containing "std"(case insensitive) and "mean"(case insensitive) in them
mean_idx			        : Indexing variable to identify Variable names containing "mean"(case sensitive) in them
stnd_idx			        : Indexing variable to identify Variable names containing "std"(case insensitive) in them
new_labels

TidyData  			    : Dataframe created by combining total variable,activity and subject data 
New_dataset			    : Dataframe created by melting TidyData for Activity and Subject
New_dataset_grouped : Dataframe created by grouping New_dataset by Activity and Subject
OutputData 			    : Summary Dataframe created by summarising New_dataset_grouped dataframe for averages
