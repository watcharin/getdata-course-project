# Code Book

Script __run_analysis.R__ generates a tidy data set from the training and test data sets. Each data set is composed of three files: __subject__, __x__, and __y__. The script reads all files and renames the columns appropriately. The column from the subject file is called __Subject__. The column from __y__ is called __ActivityLabel__. The columns from __x__ are named according to the labels in __features.txt__.

The script extracts only the measurements on the mean and standard deviation for each measurement. This reduces the number of columns from the __x__ files to 79. Files __Subject__, __x__, and __y__ are joined with Function __cbind__. The training and test data sets are joined with Function __rbind__.

To create a tidy data set, the raw data frame is grouped by the activity and the subject. This results in 180 groups (30 subjects x 6 activities). The script finds the average of each variable in each group and creates a new data frame of 180 rows. This becomes the tidy output data set.
