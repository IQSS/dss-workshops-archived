*______________________________________________________________________
*intro to stata               /*this is a preamble. always have it!*/
*Adam Okulicz-Kozaryn, Summer 09
*Revised: too many times

* notes: 
clear         
set matsize 800               /* if you do not know what is matsize, type 'help matsize' of course*/
set memory 100m, perm         /*do not forget to set memory*/
version 11                    /* if you write code is Stata 11, specify version 11, then if you run it in */
                              /* Stata 15 it will run properly (as if in Stata 11)*/
set more off                  /*This will run everything without asking you to run more*/
*--------------------------------------------------------------------
*--------------------------------------------------------------------

/* Import/Export */
                              
***Read Stata .dta file
use "C:\files\gss.dta", clear /*note quotation marks (unnecessary if no spaces like here)*/ 
cd "C:\files"                 /*change directory*/ 
cd                            /*to see where you are*/  
dir                           /*to see what you have*/ 
use gss.dta, clear            /*no need for quotes if no spaces; always use clear if you import data*/  
save new_gss.dta, replace     /*always use replace if you export data*/
saveold old_gss.dta, replace  /*if people use Stata older than Stata10*/
 
***Delimited, ASCII (text file)
insheet using gss.csv, clear  /* don't forget about using when you insheet*/
outsheet using gss_new.csv, replace comma nolabel  /*comma specifies csv, nolabel says to save numbers, not labels*/
 
***Fixed Format, ASCII (text file)
*infix rate 1-4 speed 6-7 str country 9-11 using gss.dat, clear /*note str! you have to use it if you have string variable*/

/* Names/Labels */

cd "C:\files"
insheet using gss.csv, clear
rename v1 hh_inc
label var hh_inc "houshold income"
lookfor income                /*You can search labels, useful !*/
tab v4
tab v4, nola                 /* nola means no label*/

/* Variable Operations */

cd "C:\files"  
use gss.dta, clear

tab inc                       /*we get income value labels*/
tab inc, nola                 /*let's get income values*/


codebook inc, tab(100)        /* you can also use codebook with tab option, put there high number*/

  
                              /*let's generate a dummy variable: 1 if high income(>15), 0 otherwise */
gen hi_inc=.                  /*first, gen empty variable. "." means missing (empty) in Stata */
replace hi_inc=1 if inc>15 & inc<26
replace hi_inc=0 if inc>0 & inc<16
 
use gss.dta, clear
generate age2=age^2
/*Let's generate married dummy from marital variable*/
tab marital /*check var values*/ 
tab marital, nola /*without labels*/
generate married=. /*gen empty var*/
replace married=1 if marital==1
replace married=0 if marital>1 & marital<10

tab married marital           /*always check if recoding worked the way you think it worked*/


drop married                  /*let's try alternative way to generate a dummy: recode. First drop married*/
recode marital (1 =1) (2/5=0), gen(married)
tab married marital           /*always check if recoding worked the way you think it worked*/



drop married
recode marital (1 =1) (nonm=0), gen(married)/*'nonm': everything else except missing; beware of 'else'*/ 
tab married marital           /*always check if recoding worked the way you think it worked*/


/*Descriptive Statistics*/

use gss.dta, clear
des /*this will describe variables, see if you have string variables*/
sum 
tab marital /*we get value labels*/
tab marital, nola /*we get  codes*/
tab marital region
tab marital region, row col /*these give you row and column percoentages*/

hist inc, by(sex) 

tab inc
tab inc, nola
drop if inc==26
hist inc, by(sex) 



hist marital
hist marital,  discrete percent
scatter inc age
sum inc if sex==1
sum inc if sex==2

hist inc if sex==1, by(region) percent discrete
hist inc if sex==2, by(region) percent discrete


/* EXTRA: Missing Values */

use gss_missing.dta, clear
  
tab inc                       /*we get income value labels*/
tab inc, nola                 /*let's get income values*/
tab inc, nola mi              /*and see if we have any missings*/

gen hi_inc=0                  /*let's generate a dummy variable: 1 if high income(>15), 0 otherwise */
replace hi_inc=1 if inc>15   /*it would be 1 for >15 and for missing ! WRONG!*/
                              /*remember: Stata treats missing as a very big value*/
/* It should be: */
drop hi_inc                   /*We already generated (wrong) hi_inc, we need to drop it before */
                              /*generating a correct one*/
gen hi_inc=.
replace hi_inc=1 if inc>15 & inc<26
replace hi_inc=0 if inc>0 & inc<16



*_____________
/*exercises*/

/*1*/

cd "C:\files"  
insheet using gss.tab, clear
describe
summarize
browse
save "C:\Documents and Settings\akozaryn\Desktop\mygss.dta", replace

/*2*/

cd "C:\files"  
insheet using gss.csv, clear
ren v1 marital
ren v2 age
ren v3 educ
ren v4 sex
ren v5 inc
ren v6 happy
ren v7 region

la var marital" marital status"
la var age "age"
la var educ "education"
la var sex "respondent's sex"
la var inc "income"
la var happy "self-reported happiness"
la var region "region of interview"

des


/*3*/

cd "C:\files"  
use gss.dta, clear
gen age2=age^2
tab marital
tab marital, nola
gen divsep=.
replace divsep=1 if marital==3|marital==4
replace divsep=0 if marital<3 |marital==5

capture drop divsep
recode marital (1 2 5=0) (3 4=1), gen(divsep)


/*4*/

cd "C:\files"  
use gss.dta, clear
tab region, mi
tab region, nola mi
tab region sex, row
hist inc
