### Sequential steps to produce output
The following steps are used to produce the output table. These steps are used to
document both the download and analysis scripts in 
datasciencecoursera/getting_and_cleaning_data/scripts
-Downloading and extracting zip file
-Loading required R packages
-Preparing column names from features
-Preparation of test data
-Preparation of training data
-Adding meaningful variable names as column headers
-Merging of training and test data
-Extracting only mean and standard deviation for each measurement along with subject ID and activity ID
-Replace activity IDs by descriptive names
-Calculate average of each variable for each activity  and each subject
-Writing output to table

### Note: 
In the output table, each column, except Subject and Activity, contains the average of the variable in the 
column name, for each subject and each activity. 
