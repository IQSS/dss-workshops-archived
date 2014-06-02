*______________________________________________________________________
*Data Management in Stata              
*Alicia Doyle Lynch Spring 2011
*Revised: 2/17/2011
--------------------------------------------------------------------
*--------------------------------------------------------------------

***Read Stata .dta file
cd  "~/DataManagement"             /*to change directory*/  
dir                           /*to see what you have*/ 
use gssDM.dta, clear            /*no need for quotes if no spaces; always use clear if you import data*/  
 
***Read Stata .dta file
cd                            /*to see where you are*/  
dir                           /*to see what you have*/ 
use gss.dta, clear            /*no need for quotes if no spaces; always use clear if you import data*/  

egen countmiss = rowmiss(age-wifeft)
codebook countmiss
egen compuse= anycount(usecomp usemail usenet), values(1)
codebook compuse
egen ftdiff=diff(wkft*)
codebook ftdiff
bysort degree: egen degreeincome=mean(income)
codebook degreeincome
tab degree degreeincome
gen today = "Feb 18, 2011"
*Alternative is to put it right into date format: gen today = td(18feb2011)
gen date1 = date(today, "MDY")
gen tomorrow = "Feb 19, 2011"
gen date2 = date(tomorrow, "MDY")
codebook date1 date2
gen datedif = date2-date1
codebook datedif

/*Exercise 1*/

*1.
gen age2 = age^2

*2.
tab hrs1, nola
recode hrs1 (99=.) (98=.) 
recode hrs1 (99=.) (98=.) , gen(hrs1z)

*3.
codebook income
tab income, nola
recode income (99=.) (98=.)
gen highincome =0 if income != .
replace highincome=1 if income>19
sum highincome

*4.
tostring marital, gen(marstring)
destring marstring, gen(mardstring)

*5. 
egen newvar = anycount(usecomp usemail usenet), values(1)

*6.
egen newvar2 = rowmiss(age-wifeft)

*7.
bysort degree: egen hrsdegree = mean(hrs1)
tab hrsdegree

*8.
search egen

/*Exercise 2*/

*1.
use gss2.dta, clear
merge 1:1 id using gss1.dta
save gss3.dta, replace

*2.
uss gss.dta, clear
merge m:1 marital using marital.dta, nogenerate replace update
save gss4.dta, replace

*3.
use gssAppend.dta, clear
append using gssAddObserve, generate(observe) 

*4.
codebook degree
use gss.dta
save collapse1.dta
use collapse1.dta
codebook degree
recode degree (8=.) (9=.)
collapse (mean) hrs1, by(degree)

*5.
use gss.dta, clear
save collapse2.dta, replace
use collapse2.dta, clear
collapse (mean) meaninc=income age2=age (median) medinc=income (sd) sdinc=income, by(marital)

/*Exercise 3*/

*1.
use gss1.dta, clear
cf _all using gss.dta, all

*2.
use marital, clear
cf marital using gssAddObserve.dta

*3.
use gsscompare1.dta, clear
cf _all using gss.dta

*4.
cf _all using gss.dta, verbose


