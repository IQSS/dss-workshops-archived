
/* Commenting and formatting syntax */
/* - Start with comment describing your Do-file and use comments throughout */
/* - Single line and block comments */

// comment
 describe var
 /*
 comment block comment block comment block comment
 block comment block comment block 
*/

/* - Use /// to break varlists over multiple lines: */

// break commands over multible lines
describe var1 var2 var2 ///
var4 var5 var6

/* Let's get started */
/* - Launch the Stata program (MP or SE, does not matter unless doing computationally intensive work) */
/*   - Open up a new Do-file */
/*   - Run our first Stata code! */

// change directory
cd "C://Users/dataclass/Desktop/StataIntro"
// start a log file to record your stata session
log using myStataLog, replace
// Pause / resume logging with "log on" / "log off"

/* Data file commands */
/* - Next, we want to open our data file */
/* - Open/save data sets with "use" and "save": */

// open the gss.dta data set
use dataSets/gss.dta
// saving your data file:
save newgss.dta, replace
/* the "replace" option tells stata it's OK to 
   write over an existing file */

/* What if my data is not a Stata file? */
/* - Import delimited text files */

/* import data from a .csv file */
insheet using gss.csv, clear
/* save data to a .csv file */
outsheet using gss_new.csv, replace comma

/* - Import data from SAS and Excel */

/* import/export SAS xport files */
import sasxport gss.xpt
export sasxport newFileName

/* import/export data from Excel */
import excel using gss.xls, firstrow
export excel newFileName.xls

/* Frequently used commands */
/* - Commands for reviewing and inspecting data: */
/*   - describe // labels, storage type etc. */
/*   - sum // statistical summary (mean, sd, min/max etc.) */
/*   - codebook // storage type, unique values, labels */
/*   - list // print actuall values */
/*   - tab // (cross) tabulate variables */
/*   - browse // view the data in a spreadsheet-like window */

/* - Examples */

/* commands useful for inspecting data */
sum educ // statistical summary of education 
codebook region // information about how region is coded
tab sex // numbers of male and female participants

/* Basic graphing commands */
/* - Univariate distribution(s) using *hist* */

/* Histograms */
 hist educ
 /* Interested in normality of your data? You can tell
Stata to draw the normal curve over your histogram*/
 hist age, normal

/* - View bivariate distributions with scatterplots */

/* scatterplots */
twoway (scatter educ age)
graph matrix educ age inc

/* The "by" command */
/* - Sometimes, you'd like to generate  output based on different categories of a grouping variable */
/* - The "by" command does just this */

/* tabulate happy separately for men and women */
bysort sex: tab happy
/* not all commands can be used with the by prefix.
   some, (like hist) have a "by" option instead */
hist happy, by(sex)

/* Variable and value labels */
/* - Variable labels */

/* Label variable inc "household income" */
label var inc "household income"

/* Want to change the name of your variable? */
rename oldvarname newvarname

/* - Value labels are a two step process: define a value label, then assign defined label to variable(s)  */

/*define a value label for sex */
label define mySexLabel 1 "Male" 2 "Female"
/* assign our "example" label to var1 through var3 */
label val sex  mySexLabel
/* Label define particularly useful when you have
  multiple variables with the same value structure  */
/* If you have many variables, you can search labels 
   using lookfor */
lookfor income

/* Generating and replacing variables */
/* - Create new variables using "gen" */

/* create a new variable named mc_inc"
   equal to inc minus the mean of inc */
gen mc_inc = inc - 15.37

/* - Sometimes useful to start with blank values and fill them in based on values of existing variables */

/* generate a column of missings */ 
gen age_wealth = .
/* Next, start adding your qualifications */
replace age_wealth=1 if age<30 & inc < 10
replace age_wealth=2 if age<30 & inc > 10
replace age_wealth=3 if age>30 & inc < 10
replace age_wealth=4 if age>30 & inc > 10

/* conditions can also be combined with "or" */
gen young=0
replace young=1 if age_wealth==1 | age_wealth==2

/* Recoding, dropping variables */

/* - Recoding variables */

/* recode happy into sad */
recode happy (1=3) (3=1), gen(sad)

/* - Deleting variables */

drop region  // delete region 
keep age-inc // keep age, educ, sex, and inc
