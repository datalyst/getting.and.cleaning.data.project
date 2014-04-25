README
======

This project processes the Human Activity Recognition dataset from the UCI 
Machine Learning Repository into two resulting datasets for further
analysis.  

Raw Data
--------
The raw data was downloaded from

http://archive.ics.uci.edu/ml/machine-learning-databases/00240/

The description of its contents are available at

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Generated Data
--------------
The resulting data are stored in two files

* activity.txt - contains data for 30 subjects performing 6 activities.  
  Contents include the means and standard deviations of measurements 
  collected from the accelerometer and gyroscope of a smartphone. For 
  details of the measurements, consult the code book.

* means.txt - summarizes the first dataset, providing mean statistics of 
  all variables for each subject and each activity.

Instructions
------------
To process the dataset with a given working directory `DIR`

1. extract the raw data into the subdirectory `DIR/UCI HAR Dataset`
2. execute the R script `run_analysis.R`

The script contains functions that can be easily customized should your
directory structure be different.