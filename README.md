# GettingAndCleaningDataProject
This contains files necessary for the assignment

==================================================================
Project, getting and cleaning data
==================================================================
W Steenekamp
==================================================================

- The assignment has been done with the assumption that only the test and training datasets are applicable and the Inertial Signals files have not been used

The repository includes the following files:
=========================================
-  CodeBook
-  run_analysis.R
-  summaryset.txt 

==========================================
'run_analysis.R: The R script for the assignment.
=================================================
- NOTE: library(dplyr) must be invoked before running the script 
- The comments in the script explained the process followed to produce the final output, there is explaination on how to produce the 
   complete data set.
- To call the function, you need to be in the pass the directory as the where the raw files were downloaded, for example if you have exctracted 
the files to : C:\datascience\data2\getdata-projectfiles-UCI HAR Dataset\UCI HAR Dataset, then simmply call  the function as 
summarytable("C:/datascience/data2/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset"), the script will then set your working directory to this directory and
produce a file called 'summaryset.txt' in that directory.
- The script consists of 3 distinct functions:
- 'summarytable' - input parameter: the rootpath to the UCI HAR dataset. 
	It merges the training and test datasets to create one tidy dataset. 
	It uses the result of headdf (which contains only measurements on the mean and standard deviation) when combining the 2 datasets
	It creates a second tidy data set with the average of each variable for each activity and each subject.  
- 'headdf' - extracts only the measurements on the mean and standard deviation for each measurement and assign names to the columns,
   returns a 2 column data frame, one row numeric values with the  column indexes to be exctracted, the other with column header names.
- 'testdata' - merges subject and header rows to produce full data sets for the #respective Test and Train observations.
 
 
