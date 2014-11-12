capture log close
cd "m:\MPAID_STATA"
log using stata1.log, replace
use maddison_gdp.dta, clear

/*this is a comment*/
count
describe
summarize gdppc, detail

count if gdppc == . 
summarize gdppc if country=="Chile", detail
log close

/*Exercise*/
/*Question 1*/
sum gdppc

/*Question 2*/
count if country == "Argentina" & gdppc == .
/*there are no black gdppc Argentina observations*/

/*Question 3*/
sum gdppc if country == "Burkina Faso"
