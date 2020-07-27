# getting and tidying Smartphone-Based data Recognition of Human Activities

# load libraries
library(reshape2)

# load data
zipDir <- "./zipdata"
zipUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
zipFile <- "phonedata.zip"
phoneData <- paste(zipDir, "/", "phonedata.zip", sep = "")
data <- "./phonedata"

if (!file.exists(zipDir)) {
  dir.create(zipDir)
  download.file(url = zipUrl, destfile = phoneData)
}
if (!file.exists(zipDir)) {
  dir.create(data)
  unzip(zipfile = phoneData, exdir = data)
}


# merge data: train and test 

# train 
x_train <- read.table(paste(sep = "", data, "/UCI HAR Dataset/train/X_train.txt"))
y_train <- read.table(paste(sep = "", data, "/UCI HAR Dataset/train/Y_train.txt"))
s_train <- read.table(paste(sep = "", data, "/UCI HAR Dataset/train/subject_train.txt"))

# test 
x_test <- read.table(paste(sep = "", data, "/UCI HAR Dataset/test/X_test.txt"))
y_test <- read.table(paste(sep = "", data, "/UCI HAR Dataset/test/Y_test.txt"))
s_test <- read.table(paste(sep = "", data, "/UCI HAR Dataset/test/subject_test.txt"))

# merge data
x_data <- rbind(x_train, x_test)
y_data <- rbind(y_train, y_test)
s_data <- rbind(s_train, s_test)


#  load data for features and activities

feature <- read.table(paste(sep = "", data, "/UCI HAR Dataset/features.txt"))

# activities
a_label <- read.table(paste(sep = "", data, "/UCI HAR Dataset/activity_labels.txt"))
a_label[,2] <- as.character(a_label[,2])

# gather feature cols & names containing 'mean' and 'std'
fetchCols <- grep("-(mean|std).*", as.character(feature[,2]))
fetchNames <- feature[fetchCols, 2]
fetchNames <- gsub("-mean", "Mean", fetchNames)
fetchNames <- gsub("-std", "Std", fetchNames)
fetchNames <- gsub("[-()]", "", fetchNames)


# fetch data columns and apply descriptive names
x_data <- x_data[fetchCols]
bindData <- cbind(s_data, y_data, x_data)
colnames(bindData) <- c("Subject", "Activity", fetchNames)

bindData$Activity <- factor(bindData$Activity, levels = a_label[,1], labels = a_label[,2])
bindData$Subject <- as.factor(bindData$Subject)


# tidy data 
arrData <- melt(bindData, id = c("Subject", "Activity"))
tidyData <- dcast(arrData, Subject + Activity ~ variable, mean)

write.table(tidyData, "./tidydata.txt", row.names = FALSE, quote = FALSE)