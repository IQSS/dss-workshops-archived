clear
cd "m:\MPAID_STATA_Session3"
capture log close
log using stata_session3.log, replace
set mem 100M
use expchina.dta, clear

/*egen: egen v. gen*/
gen tot_exp1 = sum(value)
egen tot_exp2 = sum(value)
browse

bys importer: gen tot_exp1_byimp = sum(value)
bys importer: egen tot_exp2_byimp = sum(value)
browse

/*egen: other examples*/
egen avg_value = mean(value)
bys importer year: egen max_value = max(value)
browse


/*collapse commands*/
collapse (sum) value, by(year importer)
/*I recommend browsing your data now to see how it looks*/

use expchina.dta, clear
collapse (sum) value, by (year sitc4)
/*I recommend browsing your data now to see how it looks*/
use expchina.dta, clear

/*merge command*/
clear
use sitc2.dta
sort sitc4
save sitc_sorted.dta, replace
use expchina.dta, clear
sort sitc4
merge sitc4 using sitc_sorted.dta

tab _merge 
browse if _merge == 1 /*if you want to look at just observations
										that were in the master dataset*/





/*Exercise: working with TZ data*/
/*Question 1*/
clear
use education.dta, clear
sort hhid2 
save education_sorted.dta, replace
use household.dta, clear
sort hhid2
merge hhid2 using education_sorted.dta

/*question 2*/
gen num = 1
bys hhid2: egen fam_size = sum(num)

/*Question 3 -- note that I have not weighted the data, although I should have. If you don't 
know what that means, don't worry, you will understand by the end of the year*/
bys fam_size: tabstat meals, s(mean)
bys fam_size: egen avg_meals_day = mean(meals)
collapse (mean) meals, by(fam_size)

