*______________________________________________________________________
*intro to graphics with stata               /*this is a preamble. always have it!*/
*Alicia Doyle Lynch Fall 2010

* notes: 
clear         
set matsize 800               /* if you do not know what is matsize, type 'help matsize' of course*/
set memory 100m, perm         /*do not forget to set memory*/
version 11                    /* if you write code is Stata 11, specify version 11, then if you run it in */
                              /* Stata 15 it will run properly (as if in Stata 11)*/
set more off                  /*This will run everything without asking you to run more*/
*--------------------------------------------------------------------
*--------------------------------------------------------------------

cd "N:\Graphing in Stata\Graphing Stata MIT"

cd "~/Graphing"

use TimePollPubSchools.dta, clear

*****Graphs of Single Variables*****

codebook F1
histogram F1
hist F1, bin(10) percent title(TITLE) subtitle(SUBTITLE) caption(CAPTION) note(NOTES) xtitle(Here's your x-axis title) ytitle(here's your y-axis title)

/*Suppress axis titles*/
hist F1, bin(10) percent title(TITLE) subtitle(SUBTITLE) caption(CAPTION) note(NOTES) xtitle("") ytitle("")

/*Histogram of discrete variable*/
codebook F4
hist F4, title(Racial breakdown of Time Poll Sample) xtitle(Race) ytitle(Percent) xlabel(1 "White" 2 "Black" 3 "Asian" 4 "Hispanic" 5 "Other") discrete percent addlabels

/*Tabplot - compares responses across categorical variables*/

findit  tabplot
codebook rvb Q8
tabplot rvb Q8
tabplot rvb Q8, showval
recode Q8 (9=3)
tabplot rvb Q8, percent(Q8) title("Do you think public schools are" ///
 "teaching students the skills they need?") subtitle ("") xtitle("") ytitle("") ///
 xlabel(1 "Yes" 2 "No" 3"No Answer")
 
tabplot rep78 mpg, xasis barw(1) bstyle(histogram)
egen mean = mean(mpg), by(rep78)
gen rep78_2 = 6 - rep78 - 0.05
bysort rep78 : gen byte tag = _n == 1
tabplot rep78 mpg, xasis barw(1) bstyle(histogram) plot(scatter rep78_2 mean if tag)


******Twoway graphs******

use NatNeighCrimeStudy.dta, clear

/*Basic twoway graphs*/

twoway scatter T_PERCAP T_VIOLNT, title("Comparison of Per Capita Income" "and Violent Crime Rate at Tract level") xtitle(Violent Crime Rate) ytitle(Per Capita Income)
twoway dropline T_PERCAP T_VIOLNT
twoway lfitci T_PERCAP T_VIOLNT

/*The By Statement*/

sum T_UNEMP, detail
gen DICEMP=0 if T_UNEMP <6.62
recode DICEMP (.=1) if T_UNEMP >= 6.62
la var DICEMP "Median split of unemployment"
la define dicemplbl 1 "Unemployment Rate in Upper 50%" 0 "Unemployment in Lower 50%"
la val DICEMP dicemplbl

twoway scatter T_PERCAP T_VIOLNT, by(DICEMP)

/*Adding title features to twoway graphs*/

twoway scatter T_PERCAP T_VIOLNT, title(Comparison of Per Capita Income and Violent Crime Rate at Tract level) ///
xtitle(Violent Crime Rate) ytitle(Per Capita Income) note(Source: National Neighborhood Crime Study 2000) 

*Correct title so it goes on two lines - I do this by separating each line into quotations

twoway scatter T_PERCAP T_VIOLNT, title("Comparison of Per Capita Income" "and Violent Crime Rate at Tract level") ///
xtitle(Violent Crime Rate) ytitle(Per Capita Income) note(Source: National Neighborhood Crime Study 2000) 

/*Playing around with Appearance*/

*Change symbol appearance with "msymbol()"

twoway scatter T_PERCAP T_VIOLNT, title("Comparison of Per Capita Income" "and Violent Crime Rate at Tract level") ///
xtitle(Violent Crime Rate) ytitle(Per Capita Income) note(Source: National Neighborhood Crime Study 2000) ///
msymbol(Sh) 

*Change symbol color with "mcolor()"

twoway scatter T_PERCAP T_VIOLNT, title("Comparison of Per Capita Income" "and Violent Crime Rate at Tract level") ///
xtitle(Violent Crime Rate) ytitle(Per Capita Income) note(Source: National Neighborhood Crime Study 2000) ///
msymbol(S) mcolor(red)

/*Overlaying two graphs*/

twoway (scatter T_PERCAP T_VIOLNT) (lfit T_PERCAP T_VIOLNT), title("Comparison of Per Capita Income" "and Violent Crime Rate at Tract level") ///
xtitle(Violent Crime Rate) ytitle(Per Capita Income) note(Source: National Neighborhood Crime Study 2000) 

tab T_VIOLNT
twoway (scatter T_PERCAP T_VIOLNT if T_VIOLNT==1976, mlabel(CITY)) (scatter T_PERCAP T_VIOLNT), ///
title("Comparison of Per Capita Income" "and Violent Crime Rate at Tract level") xlabel(0(200)2400) ///
note(Source: National Neighborhood Crime Study 2000) legend(off)

******Line Graphs*****

/*Call up one of Stata's datasets from the web*/
webuse uslifeexp, clear

line le_male le_female year

line le_wfemale le_wmale le_bf le_bm year

*Change the pattern for your lines

line le_wfemale le_wmale le_bf le_bm year, lpattern(dot solid dot solid)

*Change line color, width

line le_wfemale le_wmale le_bf le_bm year, lpattern(dot solid dot solid) ///
lcolor(red blue red blue) lwidth(thick thin thick thin) 

*****Profile Plots*****

use NatNeighCrimeStudy.dta

findit profileplot

sum T_UNEMP, detail
gen unempquart=1 if T_UNEMP < 3.27
replace unempquart=2 if T_UNEMP >=3.27 & T_UNEMP < 6.62
replace unempquart=3 if T_UNEMP >=6.62 & T_UNEMP < 11.23
replace unempquart=4 if T_UNEMP > 11.23 & T_UNEMP != .
la define unempquartlbl 1 "Lowest 25th" 2 "25-50th" 3 "50-75th" 4 "Highest 25th"
la val unempquart unempquartlbl

profileplot T_MURDRT T_AGASRT T_VIOLRT T_PROPRT, by(unempquart)

profileplot T_MURDRT T_AGASRT T_VIOLRT T_PROPRT, by(unempquart) xlabel(1 "Murder" 2 "Assault" 3 "Violent" 4 "Property") ///
ytitle(Average Crime Rate) title("Average Tract Crime Rates by Unemployment Level") xtitle("")  

/*Saving your graph for use in word processing documents*/

*Let's first make sure we send the graph to the correct directory
cd "N:\Graphing in Stata\Graphing Stata MIT"

*The graph you want to export must be open in Stata to run the following syntax
graph export profileplot.eps, replace

*****Answers to Exercises*****

/*Exercise 1*/

*1.
hist T_POVRTY
*2.
hist T_POVRTY, normal
*3.
hist T_POVRTY, normal percent
*4.
*A variety of options are available here such as: title() xtitle() ytitle()

use TimePollPubSchools.dta, clear
*5.
codebook Q11
hist Q11, discrete
*6.
*Again, there are several options available here and are up to the users' discression
*7.
codebook Q33 Q17
tabplot Q33 Q17

/*Exercise 2*/

use NatNeighCrimeStudy.dta

*1.
twoway scatter C_UNEMP C_SSLOW
*2. 
twoway scatter C_UNEMP C_SSLOW, by(C_SOUTH)
*3. 
*Use mcolor() option
*4. 
*Use msymbol() option
*5.
codebook C_UNEMP
twoway (scatter C_UNEMP C_SSLOW if C_UNEMP >= 15, mlabel(CITY)) (scatter C_UNEMP C_SSLOW), ///
by(C_SOUTH)
*6.
help twoway_options

/*Exercise 3*/

webuse sp500.dta

*1.
line volume date

*2.
line high low date

*3.
line high low date, lpattern(dot solid) lcolor(orange blue)

*Questions 4&5 are based on user preferences

*6.
cd “~/Graphing”
graph export mynewgraph.esp, replace



*****BONUS MATERIAL*****

/*Review of Various Graphing Options*/

sysuse auto, clear
/*help twoway_options*/ ///
/* help marker_options*/ ///
tw (scatter mpg price, mcolor(blue) msymbol(smcircle_hollow)) /// /*blue small circle*  */
(scatter mpg price if weigh>4000, ///                       /*separate scatter for heavy cars*/
msize(zero) msymbol(point) mlabel(make)) ///               /* make it small and labe with make*/   
/* help lines*/ ///
(lfit mpg price, lcolor(red) lwidth(thick) lpattern(dot)) /// /* red thick dotted line*/
if mpg<45, ///                                           /* have all the graphs only if mpg<45*/  
ytitle(y title)  ylabel(, labsize(small)) ///            /* have small Y title*/
yline(30, lwidth(thick) lpattern(dash) lcolor(gold)) /// /* put horizontal line at 30*/
xtitle(x title) xlabel(, labsize(small)) ///             /*also small X title*/
title(title, size(medium)) ///                           /*medium main title*/
/* help legend_option*/ ///  
legend(order(1 "points" 3 "regression line") ///        /* I will  lable only 1st and 3rd graph*/
cols(1) size(small) position(1) ring(0)) ///            /*legend in 1 column at 1pm , no distance (within plot)*/
scheme(s2mono) graphregion(margin(tiny)) plotregion(margin(tiny)) /*black and white, compact*/


*****Additional Descriptive Graphs with Continuous Variables*****
  
/*several variables on a similar scale against another variable*/
webuse auto, clear
scatter mpg headroom turn weight 

/*display labels on scatterplot*/
webuse auto, clear
scatter mpg weight in 1/15, mlabel(make)

/*display a third variable on scatterplot*/
webuse census, clear
scatter death medage [w=pop65p], msymbol(circle_hollow)

/*many scatterplots */
sysuse lifeexp, clear
generate lgnppc = ln(gnppc)
graph matrix popgr lgnp safe lexp, half /*have DV as last; use half option*/

/*time series*/
webuse uslifeexp, clear
line le_wm le_bm year, legend(size(small))
  
/*minimum maximum*/
webuse sp500, clear
twoway rcap high low date in 1/15

/*growth and decline*/
webuse gnp96, clear
twoway area d.gnp96 date 

webuse sp500, clear
twoway area high close low date in 1/15

tsset  date, daily
graph twoway tsline  high low , tline(01apr2001 01jul2001 01oct2001)
graph twoway tsline  high low if tin(01jan2001, 30jun2001)


/*box plots*/
webuse bplong, clear
graph box bp, over(agegrp)  

webuse bpwide, clear
graph box bp_before bp_after
graph box bp_before bp_after, over(agegrp)

/*Additional options for describing data*/
  
/*sum stats by variable*/  
webuse citytemp, clear
graph bar tempjan, over(region)
graph hbar tempjan tempjuly, over(region) /*hbar makes it horizontal*/
gr bar ttl_exp tenure, over(married) over(race) by(union, missing total)


/*WHERE YOU CAN GO FROM HERE: ADVANCED GRAPHING*/

sysuse uslifeexp, clear
gen diff = le_wm - le_bm 
label var diff "Difference"

#delimit ;
line le_wm year, yaxis(1 2) xaxis(1 2) 
  || line le_bm year 
  || line diff  year 
  || lfit diff  year 
  ||, 
  ylabel(0(5)20, axis(2) gmin angle(horizontal)) 
  ylabel(0 20(10)80,     gmax angle(horizontal)) 
  ytitle("", axis(2)) 
  xlabel(1918, axis(2)) xtitle("", axis(2)) 
  ytitle("Life expectancy at birth (years)")
  title("White and black life expectancy")
  subtitle("USA, 1900-1999")
  note("Source: National Vital Statistics, Vol 50, No. 6" 
       "(1918 dip caused by 1918 Influenza Pandemic)")
  legend(label(1 "White males") label(2 "Black males"))
  legend(col(1) pos(3))
  ;
#delimit cr


