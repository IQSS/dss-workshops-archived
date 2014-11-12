/*this is a preamble. always have it!*/
*______________________________________________________________________
*intro to stata               
*Ista Zahn Fall 2011
*Revised: 10/21/11
*--------------------------------------------------------------------
*--------------------------------------------------------------------

use gss.dta

lookfor income

label define sexlabel 1 "Male" 2 "Female"
codebook sex
label value sex "sexlabel"

sum age
label variable region "Area of the United States"
rename region region4
codebook marital

**Start your Stata session
cd "~/StataIntro"                 /*change directory*/ 
cd                            		/*to see where you are*/  
dir                           		/*to see what you have*/ 
use gss.dta, clear            		/*no need for quotes if no spaces; always use clear if you import data*/  
save new_gss.dta, replace     		/*use replace to update an existing file*/

sum age inc, detail

/*Exercise 1: Importing Data*/

cd "~/StataIntro"
log using IntroStataADL
use gss.dta, clear
save gssNEW.dta, replace
 
***ACSII: Comma separated values file
insheet using gss.csv, clear  
outsheet using gss_new.csv, replace comma nolabel  /*comma specifies csv, nolabel says to save numbers, not labels*/
 
***SAS Transport file
fdause gss.xpt

***Excel File
xmluse gss.xlsx, doctype(excel) firstrow /*firstrow means treat first row of data as variable names*/

/*Exercise 2: Variable names and labels */

clear
cd "~/StataIntro"
insheet using gss.csv, clear 
rename v1 marital
rename v2 age
rename v3 educ
rename v4 sex
rename v5 inc
rename v6 happy
rename v7 region
la var marital "marital status" 
la var age "age of respondent"
la var educ "education"
la var sex "respondent's sex"
la var inc "household income"
la var happy "general happiness"
la var region "region of interview"
lookfor income                /*You can search labels, useful !*/

/*Add value label to marital*/
label var marital "marital status"
la define label1 1 "married" 2 "widowed" 3 "divorced" 4 "separated" 5 "never married"
la value marital label1

/* Review variables to ensure they were correctly imported*/

tab marital
tab marital, nola                 /* nola means no label*/
codebook
describe
sum

/*Exercise 3: Manipulating Variables*/                       
generate age2=age^2

/*let's generate a dummy variable: 1 if high income(>15), 0 otherwise */
codebook income        
gen hi_inc=.                  /*first, gen empty variable. "." means missing (empty) in Stata */
replace hi_inc=1 if income>15 & income<26
replace hi_inc=0 if income>0 & income<16

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
recode marital (1=1) (nonm=0), gen(married)/*'nonm': everything else except missing; beware of 'else'*/ 
tab married marital           /*always check if recoding worked the way you think it worked*/

/*Exercise 4: Descriptive Statistics*/

use gss.dta, clear
des /*this will describe variables, see if you have string variables*/
sum 
tab marital /*we get value labels*/
tab marital, nola /*we get codes*/
tab marital region
tab marital region, row col /*these give you row and column percoentages*/

bysort marital: sum inc

sum happy if marital==1

hist inc

hist inc, by(sex) normal

hist inc if sex==1, by(region) 
hist inc if sex==2, by(region) 



