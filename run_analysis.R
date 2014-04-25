### Smartphone Motion Data of Different Human Activities
# script processes the training and test data to create two tidy datasets:
#
# 1) a merged dataset of both training and test datasets of all fields
#    containing the means or standard deviations or raw measurements.
#
# 2) a summary dataset containing the average values of the fields in the first
#    dataset for each subject and each activity type
#
# The execution of this script extracts and stores these datasets within
# the files "activity.txt" and "means.txt", respectively.


# extract indinces of features describing the means or standard deviations
# of measured quantities.

extract_features <- function(filename) {
  features <- read.table(filename, col.names=c("id", "feature"))
  features[,2] <- as.character(features[,2])
  
  mean_features <- features[grep("mean()", features$feature, fixed=TRUE),]
  std_features <- features[grep("std()", features$feature, fixed=TRUE),]
  selected_features <- rbind(mean_features, std_features)
  
  # helper function to edit field names
  f <- function(target, replacement, fixed = FALSE) {
    function(x) {
      sub(target, replacement, x, fixed = fixed)
    }
  }
  
  y <- selected_features[,2]
  y <- sapply(y, f("BodyBody", "Body"))       # fix fields mislabeled as BodyBody
  y <- sapply(y, f("^t", "time"))             # expand t to time
  y <- sapply(y, f("^f", "frequency"))        # expand f to frequency
  y <- sapply(y, f("BodyGyro", ".gyroscope")) # body in gyro has no meaning
  y <- sapply(y, f("Body", ".body"))          # remove caps; separate entities  
                                              #   by periods
  y <- sapply(y, f("Gravity", ".gravity"))
  y <- sapply(y, f("Acc", ".acceleration"))
  y <- sapply(y, f("Jerk", ".jerk"))
  y <- sapply(y, f("Mag", ".magnitude"))
  y <- sapply(y, f("()", "", TRUE))
  y <- gsub("-", ".", y, fixed=TRUE)
  
  selected_features[,2] <- y
  selected_features[order(selected_features$feature),]
}

# helper function that generates a unified dataset given a file containing 
# predictors (x), responses (y), subject data(s), and indices of the desired
# predictores (features)

unify_dataset <- function(x, y, subject, features) {
  xdata <- read.table(x)
  xdata <- xdata[,features[,1]]
  names(xdata) <- features[,2]
  
  ydata <- read.table(y, col.names=c("activity"))  
  ydata$activity <- factor(ydata$activity, labels=c("walking", 
                                                    "walking_upstairs",
                                                    "walking_downstairs", 
                                                    "sitting",
                                                    "standing", 
                                                    "laying"))
  sdata <- read.table(subject, col.names=c("subject"))
  
  cbind(sdata, ydata, xdata)
}

# STEP 1: create a tidy dataset from both the test and training data
#         containing measurements involving means or standard deviations
#         of raw data

# construct unified dataset
features <- extract_features("./UCI HAR Dataset/features.txt")
training_data <- unify_dataset("./UCI HAR Dataset/train/X_train.txt",
                               "./UCI HAR Dataset/train/y_train.txt",
                               "./UCI HAR Dataset/train/subject_train.txt",
                               features)
test_data <- unify_dataset("./UCI HAR Dataset/test/X_test.txt",
                           "./UCI HAR Dataset/test/y_test.txt",
                           "./UCI HAR Dataset/test/subject_test.txt",
                           features)
all_data <- rbind(training_data, test_data)

# export activity data
write.csv(all_data, "activity.txt", row.names=FALSE)


# STEP 2: create a tidy dataset containing the average of each variable
#         for each activity and each subject.

options(gsubfn.engine = "R") 
library("sqldf")
library("reshape")

melted <- melt(all_data, id=c("activity", "subject"))
melted <- sqldf("select activity, subject, variable, avg(value) 
                from melted group by activity, subject, variable")
mean_data <- cast(melted, subject + activity ~ variable)

# export summary data
write.csv(mean_data, "means.txt", row.names=FALSE)