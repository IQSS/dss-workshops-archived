*______________________________________________________________________
*Data Management in Stata             
*Alicia Doyle Lynch Spring 2011
*Revised: 2/17/2011
--------------------------------------------------------------------
*--------------------------------------------------------------------

                   
cd "~/StataDatMan"	
 
***Read Stata .dta file
cd                            /*to see where you are*/  
dir                           /*to see what you have*/ 
use gss.dta, clear            /*no need for quotes if no spaces; always use clear if you import data*/  

/*Recode & Replace*/

gen computer=.
replace computer=1 if usecomp==1
replace computer=2 if usemail==1 & usenet==1
replace computer=3 if usemail==1 | usenet==1

recode computer (1=0)
recode computer (1=0), gen(computer2)

/*Egen*/

egen countmiss = rowmiss(age-wifeft)
codebook countmiss
egen compuse= anycount(usecomp usemail usenet), values(1)
codebook compuse
egen ftdiff=diff(wkftwife wkfthusb)
codebook ftdiff
*in 1169 cases, the husband and wife both worked same. In 250, they didn't match*
egen ftdiff2=diff(wkft*)
codebook ftdiff2
*This is the same thing but a different way of doing it: wkft* vs naming the variables*

/*The By Command*/
bysort sex: tab happy
hist happy, by(sex)


bysort degree: egen degreeincome=mean(income)
codebook degreeincome
tab degree degreeincome

codebook income
gen hi_inc=0
replace hi_inc=1 if income>15

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
*I did: gen age2=. , then replace age2=age^2*

*2.
tab hrs1, nola
recode hrs1 (99=.) (98=.) 
recode hrs1 (99=.) (98=.) , gen(hrs1z)
*I did: replace  hrs1=. if hrs1==99 | hrs1==98 *

*3.
codebook income
tab income, nola
recode income (99=.) (98=.)
gen highincome =0 if income != .
replace highincome=1 if income>19
sum highincome
*I did: replace income=. if income==99 | income==98 | income==24 , then: gen highincome=0 if income !=. , then: replace highincome=1 if income>19 & income!=.

*4.
tostring marital, gen(marstring)
destring marstring, gen(mardstring)

*5. 
egen newvar = anycount(life richwork hapmar), values(8)

*6.
egen newvar2 = rowmiss(age-wifeft)

*7.
bysort degree: egen hrsdegree = mean(hrs1)
tab hrsdegree
tab degreehours degree 
*tells which degree each value corresponds with*
*then, can generate labels for these*

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


