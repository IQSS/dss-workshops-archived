
// change directory
cd "C:/Users/dataclass/Desktop/StataStatistics"
// use dir to see what is in the directory:
dir
// tell Stata to use the states data set
use states.dta

// generate summary statistics for csat and expense
sum csat expense
// look at codebok
codebook csat expense

// graph expense by csat
twoway scatter expense csat

// correlate csat and expense
pwcorr csat expense, star(.05)

// run the regression
regress csat expense

// graph the residual values of csat
predict resid, residual
histogram resid, normal

rvfplot

// descriptive statistics
sum income percent high

// generate correlation matrix
pwcorr csat expense income percent high

// regress csat on exense, income, percent, and high\
regress csat expense income percent high

// use the # sign to represent interactions 
regress csat percent high c.percent#c.high
// same as . regress csat c.percent##high

// use the # sign to represent interactions 
regress csat percent high c.percent#c.high
// same as . regress csat c.percent##high

// create region dummy codes using tab 
tab region, gen(region) // could also use gen / replace

//regress csat on region
regress csat region1 region2 region3

// regress csat on region using fvvarlist syntax
// see help fvvarlist for details
regress csat i.region

// regress csat on region using fvvarlist syntax
// see help fvvarlist for details
regress csat ib4.region

* install outreg2 package
findit outreg2

// fit two regression models and store the results
regress csat expense income percent high
estimates store Model1
regress csat expense income percent high i.region
estimates store Model2

// Display Model1
estimates replay Model1

// Compare Model1 and Model2 coefficients
estimates table Model1 Model2

outreg2 [Model1 Model2] using csatprediction.xls, replace
