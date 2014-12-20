###CodeBook
#Steps  
1.Download zipped data from address:  
  https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip  
2.Open test files:subject_test, X_test, Y_test  
3.Assign column names for subject_test and Y_test since they have only 1 column.Bind them afterwards with cbind command into merged_test dataframe.   
4.Open train files:subject_train, Y_train, X_train.  
5.Assign column names for subject_train and Y_train, bind them afterwards columnwise with cbind command into Pre_merged_train dataframe.  
6.Check if column names of X_test and X_train are identical with identical(names(X_train), names(X_test)) command. They are. They are also generic(V1, V2...)
7.Bind columnwise X_test to merged_test into merged_test2. Change name of merged_test2 to merged_test.  
8.Bind columnwise X_train to Pre_merged_train into merged_train with cbind command. 
9.Check if column names of merged_train and merged_test are identical
10.Bind together merged_train and merged_test rowwise with rbind command into one large dataframe named allData.
11.Open file features.txt that holds names for the columns. It is a dataframe with 1 column. Turn that column into character vector, append on the rear side of vector containg names for the first two columns('subject_id', 'activity') and assign the whole big vector called fullNames as column names for the allData dataframe.  
12.Summarize data to get a better understanding of it in addition to ReadMe.txt file that came with raw data. There are 30 participants in the experiment and variable 'subject_id' holds their id numbers in range from 1 to 30. So it is possible to split dataset of initially 10299 rows into 30 units that correspond to each person. Also summarizing variable 'activity' it can be seen that there are 6 levels that correspond to entries in activity_labels.txt file - open file, turn dataframe into character vector which will be assigned as levels of the 'activity' variable after it has been turned into factor variable. 'subject_id' variable is also being turned into factor variable with 30 levels, and labels for the levels are corresponding id numbers. Levels of activity variable are: "LAYING", "SITTING","STANDING", "WALKING", "WALKING_DOWNSTAIRS", "WALKING_UPSTAIRS" .    
13.The task is to extract variables that contain data for mean and standard deviation values and take their average. With grep command extract first variables with 'mean' in title, and then variables with 'std' that stands for standard deviation. Combine them, sort them, combine them with subjec_id and activity variables and extract variables into shrunkenData dataframe that has all 10299 rows and 88 variables.  
14.Using for loops  and apply command collapse shrunkenData dataset into a 'Cleaned' dataframe that has calculated mean values for each person's level of activity. 30 people * 6 levels of activity gives in the end dataframe with 180 rows and all 88 columns. Values in columns 3 to 88 are average values for one of the 6 activities.  
14.Checking structure of Cleaned dataframe, it reveals that all variables are factor, which suits only to first two variable, while all the others are numeric in their nature. Using for loop I turned them into character variables, and then into numeric to preserve their structure while making the switch. Check structure of the final Cleaned dataframe before saving as .txt file (because the data came in that form) with blank space as separator and TRUE for column names.
15.You can use ##tidyPhoneData <- read.table("~/tidyPhoneData.txt", header=TRUE, quote="\"") (remove hashsign) to read it(assumnig it is saved in your working directory)




#Names of the columns in tidyPhoneData
1.subject_id
	1...30 identifier for a participant in the experiment
	
activity
	Type of activity when measurement occurred
	"LAYING"             
	"SITTING"            
	"STANDING"           
	"WALKING"           
	"WALKING_DOWNSTAIRS" 
	"WALKING_UPSTAIRS"  

tBodyAcc.mean...X   
 
tBodyAcc.mean...Y  
	
tBodyAcc.mean...Z
	
tBodyAcc.std...X

tBodyAcc.std...Y
	
tBodyAcc.std...Z
	
tGravityAcc.mean...X
	
tGravityAcc.mean...Y
 
tGravityAcc.mean...Z

tGravityAcc.std...X  

tGravityAcc.std...Y

tGravityAcc.std...Z

tBodyAccJerk.mean...X

tBodyAccJerk.mean...Y   

tBodyAccJerk.mean...Z

tBodyAccJerk.std...X

tBodyAccJerk.std...Y

tBodyAccJerk.std...Z

tBodyGyro.mean...X

tBodyGyro.mean...Y    

tBodyGyro.mean...Z

tBodyGyro.std...X  

tBodyGyro.std...Y

tBodyGyro.std...Z  

tBodyGyroJerk.mean...X    

tBodyGyroJerk.mean...Y

tBodyGyroJerk.mean...Z 

tBodyGyroJerk.std...X  

tBodyGyroJerk.std...Y    

tBodyGyroJerk.std...Z 

tBodyAccMag.mean..  

tBodyAccMag.std..   

tGravityAccMag.mean..

tGravityAccMag.std..               
	
tBodyAccJerkMag.mean..

tBodyAccJerkMag.std..

tBodyGyroMag.mean..

tBodyGyroMag.std..
	
tBodyGyroJerkMag.mean..

tBodyGyroJerkMag.std..

fBodyAcc.mean...X

fBodyAcc.mean...Y       
    
fBodyAcc.mean...Z  

fBodyAcc.std...X 

fBodyAcc.std...Y  

fBodyAcc.std...Z

fBodyAcc.meanFreq...X    

fBodyAcc.meanFreq...Y 

fBodyAcc.meanFreq...Z 

fBodyAccJerk.mean...X   

fBodyAccJerk.mean...Y 

fBodyAccJerk.mean...Z

fBodyAccJerk.std...X   

fBodyAccJerk.std...Y 
	
fBodyAccJerk.std...Z 

fBodyAccJerk.meanFreq...X 

fBodyAccJerk.meanFreq...Y

fBodyAccJerk.meanFreq...Z  

fBodyGyro.mean...X 
	
fBodyGyro.mean...Y              

fBodyGyro.mean...Z   

fBodyGyro.std...X 

fBodyGyro.std...Y
	
fBodyGyro.std...Z    
	
fBodyGyro.meanFreq...X   
	
fBodyGyro.meanFreq...Y  
	
fBodyGyro.meanFreq...Z           
	
fBodyAccMag.mean..     
	
fBodyAccMag.std..   

fBodyAccMag.meanFreq..    

fBodyBodyAccJerkMag.mean..           

fBodyBodyAccJerkMag.std..          

fBodyBodyAccJerkMag.meanFreq..       

fBodyBodyGyroMag.mean..             

fBodyBodyGyroMag.std..              

fBodyBodyGyroMag.meanFreq..         

fBodyBodyGyroJerkMag.mean..         

fBodyBodyGyroJerkMag.std..          

fBodyBodyGyroJerkMag.meanFreq..      

angle.tBodyAccMean.gravity.        

angle.tBodyAccJerkMean..gravityMean.

angle.tBodyGyroMean.gravityMean.    

angle.tBodyGyroJerkMean.gravityMean.

angle.X.gravityMean.              

angle.Y.gravityMean.                 

angle.Z.gravityMean.   