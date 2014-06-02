____________________________________________________________________
*Regression in Stata
*Alicia Doyle Lynch
*Spring 2011

cd "~/StataStatistics"   /*first, always get to the dir with data*/
dir                           /* you may check what files you have in the current directory*/
use states.dta, clear	      

sum csat expense           
codebook csat expense

tab state csat, col row

/*Univariate Regression*/
/*dependent = SAT score, independent = per pupil expenditure*/

codebook csat expense

twoway scatter expense csat

pwcorr csat expense, star(.05)

regress csat expense 

predict resid, residual
label var resid "Residuals of pp expend and SAT"
histogram resid, normal 

swilk resid

rvfplot

estat hettest

*Generate predicted values

predict yhat

/*Multiple Regression*/
/*dependent = SAT scores, independent = various*/

sum income percent high

pwcorr csat expense income percent high, star(.05) sig
pcorr csat expense income percent high

regress csat expense income percent high

predict yhat	/*Generate new variable with predicted values*/

predict resid, residual		/*Generate new variable with residual values*/
label var resid "Residuals of pp expend and SAT"
histogram resid, normal 

swilk resid

rvfplot

estat hettest

/*Adding interaction term to multiple regression*/

gen percenthigh = percent*high
regress csat expense income percent high c.percent#c.high

/*Multiple Regression with categorical predictor*/
/*dependent = SAT scores, independent = various*/

codebook region

tab region, gen(reg)

gen region1=1 if region==1
gen region2=2 if region==2
gen region3=3 if region==3
gen region4=4 if region==4

recode region1-region4 (.=0)

tab region, gen(region)

xi: regress csat expense income percent high i.region

/*Multiple Regression with Categorical Predictor and Interaction*/

xi: regress csat expense income high i.region*percent

/*Regression and Clustered Data*/
/*Stata offers many options for handling clustered data, this is
one simple, straightforward way to produce robust standard errors*/

regress csat expense income percent high, cluster(region)

/*Storing Regression Estimates and Generating Tables*/

*first you need to download two programs - esttab and outreg2
findit esttab

findit outreg2

regress csat expense income percent high 
estimates store m1

tab region, gen(region)
codebook region
la var region1 "West"
la var region2 "Northeast"
la var region3 "South"
la var region4 "Midwest"

gen percenthigh = percent*high
la var percenthigh "Percent*High"

regress csat expense income percent high
estimates store Model1
regress csat expense income percent high region2 region3 region4
estimates store Model2
regress csat expense income percent high region2 region3 region4 percenthigh
estimates store Model3

esttab Model1 Model2 Model3 
esttab Model1 Model2 Model3, label nostar 

regress csat expense income percent high
outreg2 using regression.xls, bdec(3) ctitle(Model 1) ///
se title("Prediction of Average SAT scores") replace
regress csat expense income percent high region2 region3 region4
outreg2 using regression.xls, bdec(3) ctitle(Model 2) ///
se title("Prediction of Average SAT scores") append
regress csat expense income percent high region2 region3 region4 percenthigh
outreg2 using regression.xls, bdec(3) ctitle(Model 3) ///
se title("Prediction of Average SAT scores") append

/*EXAMPLE: Creating categorical variable from continuous*/

sum high, detail
drop high25
gen high25=1 if high <= 73.1
replace high25=2 if high > 73.1 & high <=76.7
replace high25=3 if high > 76.7 & high <= 80.1 
replace high25=4 if high > 80.1
label variable high25 "Quartiles of % adults with HS diploma"
label define high25 1 "Lowest 25th" 2 "25-50th percentile" 3 "50th-75th percentile" 4 "Top 25th"
la val high25 high25




