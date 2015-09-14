run_analysis <- function() {
	dataDir <- 'UCI HAR Dataset'
	colInInterest <- c(1:6, 41:46, 81:86, 121:126, 161:166, 201:202, 214:215, 227:228, 240:241, 253:254, 266:271, 294:296, 345:350, 373:375, 424:429, 452:454, 503:504, 513, 516:517, 526, 529:530, 539, 542:543, 552)
	
	subjectTrain <- read.table(paste(dataDir, '/train/subject_train.txt', sep = ''))
	xTrain <- read.table(paste(dataDir, '/train/X_train.txt', sep = ''))
	yTrain <- read.table(paste(dataDir, '/train/y_train.txt', sep = ''))
	subjectTest <- read.table(paste(dataDir, '/test/subject_test.txt', sep = ''))
	xTest <- read.table(paste(dataDir, '/test/X_test.txt', sep = ''))
	yTest <- read.table(paste(dataDir, '/test/y_test.txt', sep = ''))
	
	## Read the descriptive name of each feature.
	features <- read.table(paste(dataDir, '/features.txt', sep = ''))
	
	## Rename columns.
	names(subjectTrain) <- "Subject"
	names(subjectTest) <- "Subject"
	names(yTrain) <- "ActivityLabel"
	names(yTest) <- "ActivityLabel"
	names(xTrain) <- features[, 2]
	names(xTest) <- features[, 2]
	
	## Extract only the mean and standard deviation columns.
	xTrain <- xTrain[, colInInterest]
	xTest <- xTest[, colInInterest]
	
	## Merge three tables.
	train <- cbind(subjectTrain, xTrain, yTrain)
	test <- cbind(subjectTest, xTest, yTest)
	
	## Merge the training and test data sets.
	har <- rbind(train, test)
	
	## Read the list of activity labels
	activityLabels <- read.table(paste(dataDir, '/activity_labels.txt', sep = ''))
	
	## Descriptively name the activities.
	har$ActivityLabel <- sapply(har$ActivityLabel, function(x) { activityLabels[x, 2] })
	
	## Group the data by the activity and the subject.
	groups <- split(har, list(har$ActivityLabel, har$Subject))
	
	## Find the average value of each variables in each group.
	avgData <- lapply(groups, function(x) {
		## x is a data frame
		avg <- x[1, ]
		
		for (i in 2:80) {
			avg[1, i] <- mean(x[, i])
		}
		
		avg
	})
	
	## Bind every row from each group together.
	do.call(rbind, avgData)
}
