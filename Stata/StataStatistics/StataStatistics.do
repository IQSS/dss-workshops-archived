                         _____________________
* 
*                           REGRESSION IN STATA
*                          _____________________
* 
* 
* Table of Contents
* _________________
* 
* 1 Introduction
* 2 Univariate regression
* 3 Multiple regression
* 4 Interactions
* 5 Exporting and saving results
* 6 Wrap-up
* 
* 
* 
* 
* 
* 1 Introduction
* ==============
* 
* 1.1 Download workshop materials                                  :setup:
* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
* 
*   - Lab computer log in:
*     - USERNAME: dataclass
*     - PASSWORD: on the board to your left
*   - Download materials from
*     [http://tutorials.iq.harvard.edu/Stata/StataStatistics.zip]
*   - Extract materials from the `StataStatistics.zip' file
*   - Launch Stata and open the `StataStatistics.do' file
* 
* 
* 1.2 Organization
* ~~~~~~~~~~~~~~~~
* 
*   - Please feel free to ask questions at any point if they are relevant
*     to the current topic (or if you are lost!)
*   - There will be a Q&A after class for more specific, personalized
*     questions
*   - Collaboration with your neighbors is encouraged
*   - If you are using a laptop, you will need to adjust paths accordingly
*   - Make comments in your Do-file rather than on hand-outs
*   - Save on flash drive or email to yourself
* 
* 
* 1.3 Today's Dataset
* ~~~~~~~~~~~~~~~~~~~
* 
*   - We have data on a variety of variables for all 50 states
*   - Population, density, energy use, voting tendencies, graduation
*     rates, income, etc.
*   - We're going to be predicting SAT scores
*   - Univariate Regression: SAT scores and Education Expenditures
*   - Does the amount of money spent on education affect the mean SAT
*     score in a state?
*   - Dependent variable: csat
*   - Independent variable: expense
* 
* 
* 1.4 Opening Files in Stata
* ~~~~~~~~~~~~~~~~~~~~~~~~~~
* 
*   - Look at bottom left hand corner of Stata screen
*     - This is the directory Stata is currently reading from
*   - Files are located in the StataStatistics folder on the Desktop
*   - Start by telling Stata where to look for these

* change directory
cd "~/StataStatistics"

* 
*   - Use dir to see what is in the directory:

dir

* 
*   - Load the data

* use the states data set
use states.dta

* 
* 
* 1.5 Steps for Running Regression
* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
* 
*   1. Examine descriptive statistics
*   2. Look at relationship graphically and test correlation(s)
*   3. Run and interpret regression
*   4. Test regression assumptions
* 
* 
* 2 Univariate regression
* =======================
* 
* 2.1 Univariate Regression: Preliminaries
* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
* 
*   - We want to predict csat scores from expense
*   - First, let's look at some descriptives

* generate summary statistics for csat and expense
sum csat expense

* 
* 
* 2.2 Univariate Regression Preliminaries
* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
* 
*   - We want to predict csat scores from expense
*   - First, let's look at some descriptives

* look at codebok
codebook csat expense

* 
* 
* 2.3 Univariate Regression Preliminaries
* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
* 
*   - Next, view relationship graphically
*   - Scatterplots work well for univariate relationships

* graph expense by csat
twoway scatter expense csat

* 
*   [file:images/scatter1.png]
* 
* 
* 2.4 Univariate Regression Preliminaries
* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
* 
*   - Next look at the correlation matrix

* correlate csat and expense
pwcorr csat expense, star(.05)

* 
*   - Not very interesting with only one predictor
* 
* 
* 2.5 Univariate Regression: SAT scores and Education Expenditures
* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

regress csat expense

* 
* 
* 2.6 Linear Regression Assumptions
* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
* 
*   - Assumption 1: Normal Distribution
*   - The errors of regression equation are normally distributed
*   - Assumption 2: Homoscedasticity (The variance around the regression
*     line is the same for all values of the predictor variable)
*   - Assumption 3: Errors are independent
*   - Assumption 4: Relationships are linear
* 
* 
* 2.7 Homoscedasticity
* ~~~~~~~~~~~~~~~~~~~~
* 
*   [file:images/heteroscedasticity.png]
* 
*   [file:images/homscedasticity.png]
* 
* 
* 2.8 Testing Assumptions: Normality
* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
* 
*   - A simple histogram of the residuals can be informative

* graph the residual values of csat
predict resid, residual
histogram resid, normal

* 
*   [file:images/normalHist1.png]
* 
* 
* 2.9 Testing Assumptions: Homoscedasticity
* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

rvfplot

* 
*   [file:images/fittedResidual1.png]
* 
* 
* 3 Multiple regression
* =====================
* 
* 3.1 Multiple Regression
* ~~~~~~~~~~~~~~~~~~~~~~~
* 
*   - Just keep adding predictors
*   - Let's try adding some predictors to the model of SAT scores
*   - % students taking SATs
*   - % adults with HS diploma (high)
* 
* 
* 3.2 Multiple Regression Preliminaries
* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
* 
*   - As before, start with descriptive statistics and correlations

* descriptive statistics and correlations
sum income percent high
pwcorr csat expense income percent high

* 
* 
* 3.3 Multiple Regression
* ~~~~~~~~~~~~~~~~~~~~~~~
* 
*   - regress csat on exense, income, percent, and high

regress csat expense income percent high

* 
* 
* 3.4 Exercise 1: Multiple Regression
* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
* 
*   Open the datafile, states.dta.
*   1. Select a few variables to use in a multiple regression of your own.
*      Before running the regression, examine descriptive of the variables
*      and generate a few scatterplots.
*   2. Run your regression
*   3. Examine the plausibility of the assumptions of normality and
*      homogeneity
* 
* 
* 4 Interactions
* ==============
* 
* 4.1 Interactions
* ~~~~~~~~~~~~~~~~
* 
*   - What if we wanted to test an interaction between percent & high?
*   - Option 1: generate product terms by hand

* generate product of percent and high
gen percenthigh = percent*high 
regress csat expense income percent high percenthigh

* 
* 
* 4.2 Interactions
* ~~~~~~~~~~~~~~~~
* 
*   - What if we wanted to test an interaction between percent & high?
*   - Option 2: Let Stata do your dirty work

* use the # sign to represent interactions 
regress csat percent high c.percent#c.high
* same as . regress csat c.percent##high

* 
* 
* 4.3 Categorical Predictors
* ~~~~~~~~~~~~~~~~~~~~~~~~~~
* 
*   - For categorical variables, we first need to dummy code
*   - Use region as example
*     - Option 1: create dummy codes before fitting regression model

* create region dummy codes using tab 
tab region, gen(region) // could also use gen / replace

*regress csat on region
regress csat region1 region2 region3

* 
* 
* 4.4 Categorical Predictors
* ~~~~~~~~~~~~~~~~~~~~~~~~~~
* 
*   - For categorical variables, we first need to dummy code
*   - Use region as example
*     - Option 2: Let Stata do it for you

* regress csat on region using fvvarlist syntax
* see help fvvarlist for details
regress csat i.region

* 
* 
* 4.5 Exercise 2: Regression, Categorical Predictors, & Interactions
* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
* 
*   Open the datafile, states.dta.
*   1. Add on to the regression equation that you created in exercise 1 by
*      generating an interaction term and testing the interaction.
*   2. Try adding a categorical variable to your regression (remember, it
*      will need to be dummy coded). You could use region or generate a
*      new categorical variable from one of the continuous variables in
*      the dataset.
* 
* 
* 5 Exporting and saving results
* ==============================
* 
* 5.1 Saving and exporting regression tables
* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
* 
*   - Usually when we're running regression, we'll be testing multiple
*     models at a time
*   - Can be difficult to compare results
*   - Stata offers several user-friendly options for storing and viewing
*     regression output from multiple models
*   - First, download the necessary packages:

* install outreg2 package
findit outreg2

* 
* 
* 5.2 Saving and replaying
* ~~~~~~~~~~~~~~~~~~~~~~~~
* 
*   - You can store regression model results in Stata

* fit two regression models and store the results
regress csat expense income percent high
estimates store Model1
regress csat expense income percent high i.region
estimates store Model2

* 
* 
* 5.3 Saving and replaying
* ~~~~~~~~~~~~~~~~~~~~~~~~
* 
*   - Stored models can be recalled

* Display Model1
estimates replay Model1

* 
* 
* 5.4 Saving and replaying
* ~~~~~~~~~~~~~~~~~~~~~~~~
* 
*   - Stored models can be compared

* Compare Model1 and Model2 coefficients
estimates table Model1 Model2

* 
* 
* 5.5 Exporting into Excel
* ~~~~~~~~~~~~~~~~~~~~~~~~
* 
*   - Avoid human error when transferring coefficients into tables
*   - Excel can be used to format publication-ready tables

outreg2 [Model1 Model2] using csatprediction.xls, replace

* 
* 
* 6 Wrap-up
* =========
* 
* 6.1 Help Us Make This Workshop Better
* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
* 
*   - Please take a moment to fill out a very short feedback form
*   - These workshops exist for you--tell us what you need!
*   - 
* 
* 
* 6.2 Additional resources
* ~~~~~~~~~~~~~~~~~~~~~~~~
* 
*   - training and consulting
*     - IQSS workshops:
*       [http://projects.iq.harvard.edu/rtc/filter_by/workshops]
*     - IQSS statistical consulting: [http://rtc.iq.harvard.edu]
* 
*   - Stata resources
*     - UCLA website: [http://www.ats.ucla.edu/stat/Stata/]
*     - Great for self-study
*     - Links to resources
*   - Stata website: [http://www.stata.com/help.cgi?contents]
*   - Email list: [http://www.stata.com/statalist/]
* 
