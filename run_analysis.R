#Author Walter Steenekamp

#this funcion returns the summarized table, after merging Test and  Train data sets
summarytable <- function(rootpath)
{
  setwd(rootpath)
  
  headerd <- headdf(rootpath)

  testdf <- testdata(rootpath, "TEST", headerd)
  traindf <- testdata(rootpath, "TRAIN", headerd)
  
  ftable <- bind_rows(testdf, traindf) #detailed data set,  containing all  measurements for std dev and mean, for both Test and Train
  
  #slightly better names, take out () and  -
  names(ftable) <- gsub("\\(\\)", "",  names(ftable))
  names(ftable) <- gsub("-mean-", "MeanFor", names(ftable))
  names(ftable) <- gsub("-std-", "StdDevFor", names(ftable))
  names(ftable) <- gsub("-", "",   names(ftable))
  summary <- ftable %>% group_by(Subject, Activity) %>% summarize_each(funs(mean)) # summary, task 5
  write.table(summary, file = "summaryset.txt", row.name=FALSE)
}  

#gets the "header" column names for only  the  std deviation and mean measurements, 
#returns a data frame with 2 columns one with column numbers and one with column header names
#to be extracted from X_test and X_train

headdf <-  function(rootpath)
{
  
  features <- read.csv("features.txt", colClasses = "character", header=FALSE)
  rawcolumns <- grep("((-mean)\\(\\))|((-std)\\(\\))",  features[,1],  value=TRUE)
  headerdf  <- data.frame(do.call(rbind, strsplit(rawcolumns, " ")))
  headerdf[,1] <- as.numeric(as.character(headerdf[,1]))
  headerdf
}

#function to be called for  the raw data, merges subject and header rows to produce full data sets for the 
#respective Test and Train observations,  to be merged.
testdata <- function(rootpath, type, headf)
{
  if(type == "TEST")
  {
    rawx <- read.table("./test/X_test.txt", header = FALSE)
    subjecttest<-read.csv("./test/subject_test.txt",  header = FALSE)
    activitytest<-read.csv("./test/y_test.txt",  header = FALSE)
  }
  else if(type == "TRAIN")
  {
    rawx  <- read.table("./train/X_train.txt", header = FALSE)
    subjecttest<-read.csv("./train/subject_train.txt",  header = FALSE)
    activitytest<-read.csv("./train/y_train.txt",  header = FALSE)
  }
  tidytable <- rawx[,headf[,1]]
  colnames(tidytable) <- headf[,2]
  
  subjecttest<-tbl_df(subjecttest)
  activitytest<-tbl_df(activitytest)
  subandactivity<-bind_cols(subjecttest,activitytest)
  names(subandactivity)=c("Subject","Activity")
  subandactivity<-subandactivity %>% mutate(Activity=replace(Activity, Activity == 1, "WALKING"))
  subandactivity<-subandactivity %>% mutate(Activity=replace(Activity, Activity == 2, "WALKING_UPSTAIRS"))
  subandactivity<-subandactivity %>% mutate(Activity=replace(Activity, Activity == 3, "WALKING_DOWNSTAIRS"))
  subandactivity<-subandactivity %>% mutate(Activity=replace(Activity, Activity == 4, "SITTING"))
  subandactivity<-subandactivity %>% mutate(Activity=replace(Activity, Activity == 5, "STANDING"))
  subandactivity<-subandactivity %>% mutate(Activity=replace(Activity, Activity == 6, "LAYING"))

  bindfull <- bind_cols(subandactivity, tidytable)
  bindfull
}

