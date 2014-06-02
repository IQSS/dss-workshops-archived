/*STATA II SESSION COMMANDS*/
capture log close
log using stata_2.log, replace
cd "m:\MPAID_STATA"
clear
set mem 10M
insheet using tz_data.csv, comma clear

/*Saving Data*/
save stata_2.dta, replace
outsheet using stata_2.csv, comma replace

/*Gen commands*/
gen totalfees = schoolfees + uniform + schoolsupplies

gen schoolage = 0
replace schoolage = 1 if age > 6 & age < 15
replace schoolage = . if age == .

gen number = _n

/*Drop and Rename commands*/
drop if everschool == . 
drop village

rename totalfees totalschoolcost


/*Tab commands*/
tab gender
tab inschool if schoolage == 1
tab inschool gender if schoolage == 1
tab inschool gender if schoolage == 1, cell 
tab inschool gender if schoolage == 1, row
tab inschool gender if schoolage == 1, col
tab inschool gender if schoolage == 1, missing
tab gender if schoolage == 1, sum(inschool)

/*Tabstat commands*/
tabstat inschool everschool agestarted if schoolage == 1
tabstat inschool everschool agestarted if schoolage == 1, stat(mean count)
bys gender: tabstat inschool if schoolage == 1
bys gender: tabstat agestarted if schoolage == 1, stat(mean median max min)

/*Labeling Data*/
label data "educational data from WB TZ dataset"
label var schoolage "Between the ages of 6 and 15 yrs" 

capture label define yesno 1 "yes" 0 "no"
label values inschool yesno
label values everschool yesno


/*checking labels*/
tab inschool if age < 18 & age > 7
describe

/*Graphs*/
histogram age if inschool == 1, title(Age of Individuals in School)
graph save age_inschool.gph, replace

graph bar (median) agestarted, over(gender)title(Beginning school by gender)
graph save agestarted_gender.gph, replace



/*Exercise*/
/*Question 1*/
gen adult = 0 
replace adult = 1 if age >=18

label define adult 1 "eighteen or over" 0 "under eighteen"
label values adult adult
label var adult "an adult is over eighteen"

/*Question 2*/
tab canread gender, col

/*Question 3*/
bys gen: tabstat agestarted, stat(mean, med, max)

/*Question 4*/
tab region
