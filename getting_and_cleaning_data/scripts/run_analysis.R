#Loading required R packages
library(plyr)
library(dplyr)
library(data.table)

# Preparing column names from features
features <- read.table("../data/UCI HAR Dataset/features.txt",header=FALSE,sep="")
column_labels <-as.vector(features[,2])
column_flabels <- as.vector(cbind("Subject","Activity"))
column_flabels <- append(column_flabels,column_labels)

# Preparation of test data
data_test <-read.table("../data/UCI HAR Dataset/test/X_test.txt", header = FALSE, sep = "")
subject_test <-read.table("../data/UCI HAR Dataset/test/subject_test.txt", header = FALSE, sep = "")
activity_test <- read.table("../data/UCI HAR Dataset/test/y_test.txt",header=FALSE, sep="")
fdata_test <- cbind(subject_test, activity_test, data_test)

# Preparation of training data
data_train <-read.table("../data/UCI HAR Dataset/train/X_train.txt", header = FALSE, sep = "")
subject_train <-read.table("../data/UCI HAR Dataset/train/subject_train.txt", header = FALSE, sep = "")
activity_train <- read.table("../data/UCI HAR Dataset/train/y_train.txt",header=FALSE, sep="")
fdata_train <- cbind(subject_train, activity_train, data_train)

# Adding meaningful variable names as column headers
colnames(fdata_test) <- column_flabels
colnames(fdata_train) <- column_flabels

# Merging of training and test data
fdata_comb <-rbind(fdata_train,fdata_test)

#Extracting only mean and standard deviation for each measurement along with subject ID and activity ID
fdata_sel <-fdata_comb[,grepl("-mean\\(\\)",colnames(fdata_comb))|grepl("-std\\(\\)",colnames(fdata_comb))|grepl("Subject",colnames(fdata_comb))|grepl("Activity",colnames(fdata_comb))]

# Replace activity IDs by descriptive names
activity_labels_map <- read.table("../data/UCI HAR Dataset/activity_labels.txt",header=FALSE,sep="")
colnames(activity_labels_map)<-c("id","name")
fdata_sel$Activity <- mapvalues(fdata_sel$Activity,from=activity_labels_map$id, to=as.vector(activity_labels_map$name))

# Calculate average of each variable for each activity  and each subject
dt <- as.data.table(fdata_sel)
setkey(dt, Activity, Subject)
dt2 <- dt[, lapply(.SD,mean), by=list(Subject,Activity)]

# Writing output to table
write.table(dt2,file="../output/output_table.txt",row.names = FALSE)
