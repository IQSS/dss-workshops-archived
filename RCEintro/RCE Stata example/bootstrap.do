set more off

* collect the arguments passed by submit file
args cluster process

* load the dataset
use "`path'//mydata", clear

* sample with replacement
bsample, cluster(id) idcluster(newid)

* calculate the mean and standard deviation
collapse (mean) mean_myvar = myvar (sd) sd_myvar = myvar

* save the result, appending the process number to the file name
save "`path'//output/output_`process'.dta", replace
 
