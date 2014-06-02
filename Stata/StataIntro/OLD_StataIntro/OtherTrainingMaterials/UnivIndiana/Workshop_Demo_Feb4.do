capture log close       
log using NAMEOFDOFILE, replace text

// program: NAMEOFDOFILE
// task:
// project:
// author:

version 12
clear all
macro drop _all
set linesize 80
set more off

// #1
// Exercise 1
  // ##1
  // Loading data
  sysuse auto, clear
  // ##2
  // Save a copy of the data to the working directory
  save auto2, replace 
  // Reload data from your working directory
  use auto2, clear
  // ##3
  // Check existing notes and add note "This is Fun" to the data
  note 
  note: This is Fun
  note 
 
// #2
// Exercise 2
  // ##1
  // Generate a codebook for all variables in auto2
  codebook, comp
  // ##2
  // Describe variables in auto2
  describe
  // ##3
  // Produce summary statistics for all (numeric) variables
  summarize 
  // ##4
  // Obtain summary statistics for price mpg rep78, with detailed info
  sum price mpg rep78, detail
  // ##5
  // List the repair recors in 1978 (rep78) for the 10th observation
  list rep78 in 10
  // list the first 10 observations 
  list rep78 in 1/10
  // list all observations that has fewer than 2 repair records
  list if rep78<2
  
// #3
// Exercise 3
  // ##1
  // Generate price2--car price in thousands
  gen price2=price/1000
  sum price price2
  // ##2
  // Generate pmean1--mean price across all observations
  egen pmean1=mean(price)
  // ##3
  // Generate pmean2--average price for foreign and domestic cars respectively
  egen pmean2=mean(price), by(foreign)
  sum price pmean1 pmean2
  // ##4
  // Recode rep78 into rep2, where .-->0 1/3-->1, 4+-->2
  recode rep78 (.=0) (1/3=1) (4/max=2), gen(rep2)
  tab rep78 rep2, m
  // ##5
  // Generate rep3=rep78, then replace rep3 with corresponding values in rep2
  gen rep3=rep78
  replace rep3=0 if rep78=.
  replace rep3=1 if rep78>=1 & rep78<=3
  replace rep3=2 if rep78>=4 & rep78<.
  // ##6
  // Rename price2 to be price1000
  rename price2 price1000
 
// #4
// Exercise 4
  // ##1
  // Label auto2 
  label data "Sample data for Stata Workshop"
  // ##2
  // Label rep2
  label var rep2 "Recoded repair record"
  // ##3
  // Add value label to rep2
  tab rep2, m
  label define repcat 0 "none" 1 "low freq" 2 "high freq"
  label values rep2 repcat
  // ##4
  // Check value label 
  label list repcat
  tab rep2, m

// #5
// Exercise 5 (you can add your own notes asscociated with each command line)
  order make rep78
  order make, last
  order make, before(rep78)
  sort rep78
  gsort foreign ¨Crep78
  drop rep3
  tab rep2, m
  keep if rep2>0 
  tab rep2, m

  
log close
exit
