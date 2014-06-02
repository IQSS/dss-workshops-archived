capture log close
log using workshop_demo_2011-02-11, replace text

// program: workshop_demo_2012-02-11
// task: Demo on Analysis Using Stata
// project: Stata Workshop Spring 2012
// author: Jin Chen

version 12
clear all
macro drop _all
set linesize 80
set more off

// #1
 // Loading Data
 sysuse auto, clear
 
// #2
// Summary Statistics
codebook, comp

// #3
// Oneway Table examples
	// Frequency tables with different options
	tabulate rep78             // missing values not shown
	tabulate rep78, m          // including missing values
	tabulate foreign           // with value labels
	tabulate foreign, nolab    // without value labels 
	
	//Oneway/twoway table of summary statistics (means, and standard deviations)
	tab foreign, summarize(price) 
 
	// create indicator variables for a categorical variable
	tab foreign, gen(foreign_d)

// #4 
// Twoway table examples 
	//bivariate analysis, i.e. association between two categorical variables
	tab foreign rep78, chi 
	
	//twoway frequency tables
	tab rep78 foreign, col row // with both column pct and row pct
 
// #5
// Table of Summary Statistics
tabstat price weight, stat(n mean sd) 
tabstat price weight, by(foreign) stat(n mean sd) // statistics break down by car type
tabstat price weight, by(foreign) stat(n mean sd) col(statistics) // present statistics in columns, vars in rows

// #6
// Covariance 
correlate price mpg	weight// correlation matrix
correlate price mpg weight, cov // covariance matrix			
pwcorr price mpg weight, star(.05)
*******************************************************************************

// #7
// T-test examples
	// one sample t-test: compare sample mean with a hypothesized mean
	ttest mpg==20  
	
	// two sample ttest: compare means of two samples
	webuse fuel, clear // load data from stata website
	ttest mpg1==mpg2
	
	// test group means: only two groups allowed
	webuse fuel3,clear
	ttest mpg, by(treated) 

// #8
// Linear Regression 
	//reload auto data
	sysuse auto,clear

	// run regressions
	reg price mpg foreign // main effects only
	estimates store m1    // save current model as m1
	reg price mpg foreign i.foreign#c.mpg /* adding interaction term. 
	                                        i.foreign here does not differ from foriegn, because only 2 categories */ 
	estimates store m2     // save current model as m2
	
	// postestimation: test coeficients 
	test mpg   // test individual coefficients
	test mpg foreign // test coefficients are equal to zeros simultan
	test foreign
	test mpg, accum
	test mpg=foreign  // test equality of coefficients
	test mpg-foreign=0
	
	// prediction 
	predict yhat, xb // predicted outcome
	predict stderr, stdp // standard errors of the prediction
	predict resid, residual // residuals

	// results already saved in previous steps, now export regression tables
	// because estout is a user-written command, we first download this program
	// the following two stepts are better be done before running the do file, hereby for demonstration purposes 
	
	// set location where packages from the net will be used
	net set ado "C:\Users\chen92\Desktop\Workshop\PLUS"  
	// reset stata's system directories
	sysdir set PLUS "C:\Users\chen92\Desktop\Workshop\PLUS"
	ssc install estout
	
	// Now, ready to generate/export pulication-style regression tables
	estout m1 m2
	estout m1 m2, cells(b(star fmt(%9.3f)) se(par))     ///
	stats(r2_a N, fmt(%9.3f %9.0g) labels(R-squared))      ///
	legend label collabels(none) varlabels(_cons Constant)
	
	esttab m1 m2, r2 ar2 label title("Model Results") mtitles("Model1" "Model2") 
    
	// try making a prettier table by creating interaction term manually
	gen foreign_mpg=mpg*foreign
	eststo m3: reg mpg foreign foreign_mpg
	esttab m1 m3, r2 ar2 label title("Model Results") mtitles("Model1" "Model3") 
    
	// exporting regression table into text file
	esttab m1 m3 using regtable.rtf,replace r2 ar2 label title("Model Results") /// 
	mtitles("Model 1" "Model 3") 

***********************************************************************

// #9
// Graphs for Univariate Distrituion
	// Histogram with normal curves, by group
	histogram weight, normal by(foreign)
	
	// Convenient dotplot 
	dotplot price
	
	// Boxplot by group
	graph box price, over(foreign)
	
// #10
// Twoway graphs
	// scatter plots
	scatter mpg weight
	scatter mpg weight || lfit mpg weight   // add fitted line
	
	// scatter plot matrix: more than 2 variables
	graph matrix price mpg weight
	
	// twoway line graph
	sysuse tsline2, clear
	twoway (line calories day, sort)

// #11
// Manage graphical results
	// combine graphs and save with a new name
	histogram price, normal name(graph1)
	gen logprice=log(price)
    histogram logprice, normal name(graph2)
    graph combine graph1 graph2, name(combined)

	// export graph from memory
	graph display combined  // to recall target graph as current
	graph export combined.png, replace  // other graph formats are also allowed
	
	
*******************************************************************

// #12
// local macros
local indvar "mpg weight foreign"
reg price `indvar' 

// loops
// example: generate a mean variable for each independent variable
foreach var in `indvar' {
egen mn_`var'=mean(`var')
}

// example: for each level of repair record, here 1 to 5, summarize car prices
forvalues i=1/5 {
sum price if rep78==`i'
}


log close
exit

****The End.
