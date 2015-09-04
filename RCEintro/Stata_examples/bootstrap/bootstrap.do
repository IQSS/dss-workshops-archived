set more off

// collect the arguments passed by submit file
args process

// load the dataset
use "mydata", clear

// set seed (shouldn't have to do this, but stata's
// random bsample defaults to the same seed each time).
// we nee to find a better way to do this.
set seed `process'

// sample with replacement
bsample, cluster(id) idcluster(newid)

// calculate the mean and standard deviation
collapse (mean) mean_myvar = myvar (sd) sd_myvar = myvar

// save the result, appending the process number to the file name
save "output/output_`process'.dta", replace
