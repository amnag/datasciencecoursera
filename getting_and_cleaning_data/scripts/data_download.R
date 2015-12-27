# Downloading and extracting zip file
urlFile <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(urlFile,destfile="../data/20Dataset.zip")
unzip("../data/20Dataset.zip",exdir="../data")
