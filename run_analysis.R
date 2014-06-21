# Read all data pieces
x_train <- read.table("UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("UCI HAR Dataset/train/y_train.txt")
x_test <- read.table("UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("UCI HAR Dataset/test/y_test.txt")
x_header <- read.table("UCI HAR Dataset/features.txt")
y_names <- read.table("UCI HAR Dataset/activity_labels.txt")
s_train <- read.table("UCI HAR Dataset/train/subject_train.txt")
s_test <- read.table("UCI HAR Dataset/test/subject_test.txt")
# Merge data
x_header <- c(as.character(x_header$V2),"Activity","Subject")
data <- cbind(rbind(x_train,x_test),rbind(y_train,y_test),rbind(s_train,s_test))
names(data) <- x_header
data[["Activity"]] <- y_names[ match(data$Activity, y_names$V1 ) , "V2"]
# Define required columns
req_columns <- c(
  1:6, # tBodyAcc
  41:46, # tGravityAcc
  81:86, # tBodyAccJerk
  121:126, # tBodyGyro
  161:166, # tBodyGyroJerk
  201:202, # tBodyAccMag
  214:215, # tGravityAccMag
  227:228, # tBodyAccJerkMag
  240:241, # tBodyGyroMag
  253:254, # tBodyGyroJerkMag
  266:271, # fBodyAcc
  345:350, # fBodyAccJerk
  424:429, # fBodyGyro
  503:504, # fBodyAccMag
  516:517, # fBodyBodyAccJerkMag
  529:530, # fBodyBodyGyroMag
  544:545, # fBodyBodyGyroJerkMag
  562,563 # Activity, Subject
)
dataset <- data[,req_columns]
# Save resulting dataset
write.table(dataset, file="dataset.txt", sep = "\t", row.names = FALSE)

## Preparing tidy dataset
# Flatten data frame
flat <- melt.data.frame(dataset, id.vars = c("Subject","Activity"), variable_name = "Variable")
# Group and find average
tidydata <- aggregate(flat$value,by=list(flat$Subject,flat$Activity,flat$Variable),mean)
names(tidydata) <- c("Subject","Activity","Variable","Average")
#Sort by Subject/Activity/Variable
tidydata <- tidydata[with(tidydata,order(Subject,Activity,Variable)),]
# Save tidy dataset
write.table(tidydata, file="tidy_dataset.txt", sep = "\t", row.names = FALSE)
