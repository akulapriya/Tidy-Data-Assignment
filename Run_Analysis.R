download.file(
  'https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip',
  fileurl
)
}

# unzip the file
unzip(fileurl)
}

# Read in the data into the test and training sets
Features_test <- read.table("C:/Users/pakula/Downloads/course3project/UCI HAR Dataset/test/X_test.txt")
Activities_test <- read.table("C:/Users/pakula/Downloads/course3project/UCI HAR Dataset/test/y_test.txt")
Subjects_test <- read.table("C:/Users/pakula/Downloads/course3project/UCI HAR Dataset/test/subject_test.txt")

Features_train <- read.table("C:/Users/pakula/Downloads/course3project/UCI HAR Dataset/train/X_train.txt")
Activities_train <- read.table("C:/Users/pakula/Downloads/course3project/UCI HAR Dataset/train/y_train.txt")
Subjects_train <- read.table("C:/Users/pakula/Downloads/course3project/UCI HAR Dataset/train/subject_train.txt")

# Combine the rows for each of the data sets together
Features_Set<- rbind(Features_test, Features_train)
Activities_Set <- rbind(Activities_test, Activities_train)
Subjects_Set <- rbind(Subjects_test, Subjects_train)

# merge all of of the columns
Total_Date <- cbind(Subjects_Set, Activities_Set, Features_Set)

# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 


features_names <- read.table("C:/Users/pakula/Downloads/course3project/UCI HAR Dataset/features.txt")

# Filter the mean and std features
MeanStdFeatures <- features_names[grep('-(mean|std)\\(\\)', features_names[, 2 ]), 2]
Total_Date <- Total_Date[, c(1, 2, MeanStdFeatures)]

# 3. Uses descriptive activity names to name the activities in the data set

# Read in the activity labels
activities <- read.table("C:/Users/pakula/Downloads/course3project/UCI HAR Dataset/activity_labels.txt")

# Update the activity name
Total_Date[, 2] <- activities[Total_Date[,2], ]

# 4. Label the data set with descriptive variable names. 

colnames(Total_Date) <- c(
  'subject',
  'activity',
  # Remove the brackets from the features columns
  gsub('\\-|\\(|\\)', '', as.character(MeanStdFeatures))
)


Total_Date[, 2] <- as.character(Total_Date[, 2])

# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

library(reshape2)
Data_Melt <- melt(Total_Date, id = c('subject', 'activity'))



# Write the data out to a file
write.table(Data_Melt, file="C:/Users/pakula/Downloads/course3project/UCI HAR Dataset/tidy_dataset.txt", row.names = FALSE, quote = FALSE)




