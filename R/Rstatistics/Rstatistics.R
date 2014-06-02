## 			━━━━━━━━━━━━━━━━━━━━━━━━
## 			 REGRESSION MODELS IN R
## 			━━━━━━━━━━━━━━━━━━━━━━━━

## Table of Contents
## ─────────────────

## 1 Introduction
## 2 Linear regression
## 3 Interactions and factors
## 4 Regression with binary outcomes
## 5 Multilevel Modeling
## 6 Multiple imputation
## 7 Wrap-up


## 1 Introduction
## ══════════════

## 1.1 Workshop description
## ────────────────────────

##   • This is an intermediate/advanced R course
##   • Appropriate for those with basic knowledge of R
##   • This is not a statistics course!
##   • Learning objectives:
##     • Learn the R formula interface
##     • Specify factor contrasts to test specific hypotheses
##     • Perform model comparisons
##     • Run and interpret variety of regression models in R
##     • Create and use imputed data sets in regression models

## 1.2 Materials and Setup                                          :setup:
## ───────────────────────

##   • Lab computer users:
##     USERNAME: dataclass
##     PASSWORD: dataclass
##   • Download materials from [http://j.mp/r-stats]
##   • Extract materials from RStatistics.zip (on lab machines /right-click
##     -> WinZip -> Extract to here/) and move to your desktop.

## 1.3 Launch RStudio                                            :labsetup:
## ──────────────────

##   • Open the RStudio program from the Windows start menu

##   • Open up today's R script
##     • In RStudio, Go to *File => Open Script*
##     • Locate and open the `Rstatistics.R' script in the Rstatistics
##       folder on your desktop

##   • Go to *Tools => Set working directory => To source file location*
##     (more on the working directory later)
##   • I encourage you to add your own notes to this file!

## 1.4 Set working directory
## ─────────────────────────

##   It is often helpful to start your R session by setting your working
##   directory so you don't have to type the full path names to your data
##   and other files

 # set the working directory
 # setwd("~/Desktop/Rstatistics")
 setwd("C:/Users/dataclass/Desktop/Rstatistics")

##   You might also start by listing the files in your working directory
 getwd() # where am I?
 list.files("dataSets") # files in the dataSets folder

## 1.5 Load the states data
## ────────────────────────

##   The /states.dta/ data comes from
##   [http://anawida.de/teach/SS14/anawida/4.linReg/data/states.dta.txt]
##   and appears to have originally appeared in /Statistics with Stata/ by
##   Lawrence C. Hamilton.
 # read the states data
 states.data <- readRDS("dataSets/states.rds") 
 #get labels
 states.info <- data.frame(attributes(states.data)[c("names", "var.labels")])
 #look at last few labels
 tail(states.info, 8)

## 2 Linear regression
## ═══════════════════

## 2.1 Examine the data before fitting models
## ──────────────────────────────────────────

##   Start by examining the data to check for problems.

 # summary of expense and csat columns, all rows
 summary(states.data[ , c("expense", "csat")]) 
 # correlation between expense and csat
 cor(states.data[ , c("expense", "csat")])[1, 2]

## 2.2 Plot the data before fitting models
## ───────────────────────────────────────

##   Plot the data to look for multivariate outliers, non-linear
##   relationships etc.

 # scatter plot of expense vs csat
 plot(states.data[ , c("expense", "csat")])

##   [file:images/statesCorr1.png]

##   [file:images/statesCorr1.png]

## 2.3 Linear regression example
## ─────────────────────────────

##   • Linear regression models can be fit with the `lm()' function
##   • For example, we can use `lm' to predict SAT scores based on
##     per-pupal expenditures:

 # Fit our regression model
 sat.mod <- lm(csat ~ expense, # regression formula
 	      data=states.data) # data set
 # Summarize and print the results
 summary(sat.mod) # show regression coefficients table

## 2.4 Why is the association between expense and SAT scores /negative/?
## ─────────────────────────────────────────────────────────────────────

##   Many people find it surprising that the per-capita expenditure on
##   students is negatively related to SAT scores. The beauty of multiple
##   regression is that we can try to pull these apart. What would the
##   association between expense and SAT scores be if there were no
##   difference among the states in the percentage of students taking the
##   SAT?

 summary(lm(csat ~ expense + percent, data = states.data))

## 2.5 The lm class and methods
## ────────────────────────────

##   OK, we fit our model. Now what?
##   • Examine the model object:

 class(sat.mod)
 names(sat.mod)
 methods(class = class(sat.mod))[1:9]

##   • Use function methods to get more information about the fit

 confint(sat.mod)
 # hist(residuals(sat.mod))

## 2.6 Linear Regression Assumptions
## ─────────────────────────────────

##   • Ordinary least squares regression relies on several assumptions,
##     including that the residuals are normally distributed and
##     homoscedastic, the errors are independent and the relationships are
##     linear.

##   • Investigate these assumptions visually by plotting your model:
 par(mar = c(4, 4, 2, 2), mfrow = c(1, 2)) #optional
 plot(sat.mod, which = c(1, 2)) # "which" argument optional

##   [file:images/regressionsAssumptions1.png]

## 2.7 Comparing models
## ────────────────────

##   Do congressional voting patterns predict SAT scores over and above
##   expense? Fit two models and compare them:
 # fit another model, adding house and senate as predictors
 sat.voting.mod <-  lm(csat ~ expense + house + senate,
 		      data = na.omit(states.data))
 sat.mod <- update(sat.mod, data=na.omit(states.data))
 # compare using the anova() function
 anova(sat.mod, sat.voting.mod)
 coef(summary(sat.voting.mod))

## 2.8 Exercise 0: least squares regression
## ────────────────────────────────────────

##   Use the /states.rds/ data set. Fit a model predicting energy consumed
##   per capita (energy) from the percentage of residents living in
##   metropolitan areas (metro). Be sure to
##   1. Examine/plot the data before fitting the model
##   2. Print and interpret the model `summary'
##   3. `plot' the model to look for deviations from modeling assumptions

##   Select one or more additional predictors to add to your model and
##   repeat steps 1-3. Is this model significantly better than the model
##   with /metro/ as the only predictor?

## 3 Interactions and factors
## ══════════════════════════

## 3.1 Modeling interactions
## ─────────────────────────

##   Interactions allow us assess the extent to which the association
##   between one predictor and the outcome depends on a second
##   predictor. For example: Does the association between expense and SAT
##   scores depend on the median income in the state?
   #Add the interaction to the model
 sat.expense.by.percent <- lm(csat ~ expense*income,
 			     data=states.data) 
 #Show the results
   coef(summary(sat.expense.by.percent)) # show regression coefficients table

## 3.2 Regression with categorical predictors
## ──────────────────────────────────────────

##   Let's try to predict SAT scores from region, a categorical
##   variable. Note that you must make sure R does not think your
##   categorical variable is numeric.
 # make sure R knows region is categorical
 str(states.data$region)
 states.data$region <- factor(states.data$region)
 #Add region to the model
 sat.region <- lm(csat ~ region,
 		 data=states.data) 
 #Show the results
 coef(summary(sat.region)) # show regression coefficients table
 anova(sat.region) # show ANOVA table

##   Again, *make sure to tell R which variables are categorical by
##   converting them to factors!*

## 3.3 Setting factor reference groups and contrasts
## ─────────────────────────────────────────────────

##   In the previous example we use the default contrasts for region. The
##   default in R is treatment contrasts, with the first level as the
##   reference. We can change the reference group or use another coding
##   scheme using the `C' function.

 # print default contrasts
 contrasts(states.data$region)
 # change the reference group
 coef(summary(lm(csat ~ C(region, base=4),
 		data=states.data)))
 # change the coding scheme
 coef(summary(lm(csat ~ C(region, contr.helmert),
 		data=states.data)))

##   See also `?contrasts', `?contr.treatment', and `?relevel'.

## 3.4 Exercise 1: interactions and factors
## ────────────────────────────────────────

##   Use the states data set.

##   1. Add on to the regression equation that you created in exercise 1 by
##      generating an interaction term and testing the interaction.
##   2. Try adding a categorical variable to your regression (remember, it
##      will need to be dummy coded).  You could use region or, or generate
##      a new categorical variable from one of the continuous variables in
##      the dataset.
##   3. Are there significant differences across the four regions?

## 4 Regression with binary outcomes
## ═════════════════════════════════

## 4.1 Logistic regression
## ───────────────────────

##   This far we have used the `lm' function to fit our regression
##   models. `lm' is great, but limited–in particular it only fits models
##   for continuous dependent variables. For categorical dependent
##   variables we can use the `glm()' function.

##   For these models we will use a different dataset, drawn from the
##   National Health Interview Survey. From the [CDC website]:

##         The National Health Interview Survey (NHIS) has monitored
##         the health of the nation since 1957. NHIS data on a broad
##         range of health topics are collected through personal
##         household interviews. For over 50 years, the U.S. Census
##         Bureau has been the data collection agent for the National
##         Health Interview Survey. Survey results have been
##         instrumental in providing data to track health status,
##         health care access, and progress toward achieving national
##         health objectives.

##   Load the National Health Interview Survey data:

 NH11 <- readRDS("dataSets/NatHealth2011.rds")
 labs <- attributes(NH11)$labels

##   [CDC website] http://www.cdc.gov/nchs/nhis.htm

## 4.2 Logistic regression example
## ───────────────────────────────

##   Let's predict the probability of being diagnosed with hypertension
##   based on age, sex, sleep, and bmi

 str(NH11$hypev) # check stucture of hypev
 levels(NH11$hypev) # check levels of hypev
 # collapse all missing values to NA
 NH11$hypev <- factor(NH11$hypev, levels=c("2 No", "1 Yes"))
 # run our regression model
 hyp.out <- glm(hypev~age_p+sex+sleep+bmi,
 	      data=NH11, family="binomial")
 coef(summary(hyp.out))

## 4.3 Logistic regression coefficients
## ────────────────────────────────────

##   Generalized linear models use link functions, so raw coefficients are
##   difficult to interpret. For example, the age coefficient of .06 in the
##   previous model tells us that for every one unit increase in age, the
##   log odds of hypertension diagnosis increases by 0.06. Since most of us
##   are not used to thinking in log odds this is not too helpful!

##   One solution is to transform the coefficients to make them easier to
##   interpret

 hyp.out.tab <- coef(summary(hyp.out))
 hyp.out.tab[, "Estimate"] <- exp(coef(hyp.out))
 hyp.out.tab

## 4.4 Generating predicted values
## ───────────────────────────────

##   In addition to transforming the log-odds produced by `glm' to odds, we
##   can use the `predict()' function to make direct statements about the
##   predictors in our model. For example, we can ask "How much more likely
##   is a 63 year old female to have hypertension compared to a 33 year old
##   female?".

 # Create a dataset with predictors set at desired levels
 predDat <- with(NH11,
 		expand.grid(age_p = c(33, 63),
 			    sex = "2 Female",
 			    bmi = mean(bmi, na.rm = TRUE),
 			    sleep = mean(sleep, na.rm = TRUE)))
 # predict hypertension at those levels
 cbind(predDat, predict(hyp.out, type = "response",
 		       se.fit = TRUE, interval="confidence",
 		       newdata = predDat))

##   This tells us that a 33 year old female has a 13% probability of
##   having been diagnosed with hypertension, while and 63 year old female
##   has a 48% probability of having been diagnosed.

## 4.5 Packages for  computing and graphing predicted values
## ─────────────────────────────────────────────────────────

##   Instead of doing all this ourselves, we can use the effects package to
##   compute quantities of interest for us (cf. the Zelig package).

 library(effects)
 plot(allEffects(hyp.out))

##   [file:images/effects1.png]

## 4.6 Exercise 2: logistic regression
## ───────────────────────────────────

##   Use the NH11 data set.

##   1. Use glm to conduct a logistic regression to predict ever worked
##      (everwrk) using age (age_p) and marital status (r_maritl).
##   2. Predict the probability of working for each level of marital
##      status.

##   Note that the data is not perfectly clean and ready to be modeled. You
##   will need to clean up at leas some of the variables before fitting the
##   model.

## 5 Multilevel Modeling
## ═════════════════════

## 5.1 Multilevel modeling overview
## ────────────────────────────────

##   • Multi-level (AKA hierarchical) models are a type of mixed-effects
##     models
##   • Used to model variation due to group membership where the goal is to
##     generalize to a population of groups
##   • Can model different intercepts and/or slopes for each group
##   • Mixed-effecs models include two types of predictors: fixed-effects
##     and random effects
##     Fixed-effects: observed levels are of direct interest (.e.g, sex,
##                    political party…)
##     Random-effects: observed levels not of direct interest: goal is to
##                     make inferences to a population represented by
##                     observed levels
##   • In R the lme4 package is the most popular for mixed effects models
##     • Use the `lmer' function for liner mixed models, `glmer' for
##       generalized mixed models

 library(lme4)

## 5.2 The Exam data
## ─────────────────

##   The Exam data set contans exam scores of 4,059 students from 65
##   schools in Inner London. The variable names are as follows:

##   school: School ID - a factor.
##   normexam: Normalized exam score.
##   schgend: School gender - a factor.  Levels are 'mixed', 'boys', and
##            'girls'.
##   schavg: School average of intake score.
##   vr: Student level Verbal Reasoning (VR) score band at intake - a factor.
##       Levels are 'bottom 25%', 'mid 50%', and 'top 25%'.
##   intake: Band of student's intake score - a factor.  Levels are 'bottom
##           25%', 'mid 50%' and 'top 25%'./
##   standLRT: Standardised LR test score.
##   sex: Sex of the student - levels are 'F' and 'M'.
##   type: School type - levels are 'Mxd' and 'Sngl'.
##   student: Student id (within school) - a factor

 Exam <- readRDS("dataSets/Exam.rds")

## 5.3 The null model and ICC
## ──────────────────────────

##   As a preliminary step it is often useful to partition the variance in
##   the dependent variable into the various levels. This can be
##   accomplished by running a null model (i.e., a model with a random
##   effects grouping structure, but no fixed-effects predictors).

 # null model, grouping by school but not fixed effects.
 Norm1 <-lmer(normexam ~ 1 + (1|school),
 	      data=Exam, REML = FALSE)
 summary(Norm1)

## 5.4 Adding fixed-effects predictors
## ───────────────────────────────────

##   Predict exam scores from student's standardized tests scores

 Norm2 <-lmer(normexam~standLRT + (1|school),
 	     data=Exam,
 	     REML = FALSE) 
 summary(Norm2)

## 5.5 Multiple degree of freedom comparisons
## ──────────────────────────────────────────

##   As with `lm' and `glm' models, you can compare the two `lmer' models
##   using the `anova' function.

 anova(Norm1, Norm2)

## 5.6 Random slopes
## ─────────────────

##   Add a random effect of students' standardized test scores as well. Now
##   in addition to estimating the distribution of intercepts across
##   schools, we also estimate the distribution of the slope of exam on
##   standardized test.

 Norm3 <- lmer(normexam~standLRT + (standLRT|school), data=Exam,
 	       REML = FALSE) 
 summary(Norm3)

## 5.7 Test the significance of the random slope
## ─────────────────────────────────────────────

##   To test the significance of a random slope just compare models with
##   and without the random slope term

 anova(Norm2, Norm3)

## 5.8 Exercise 3: multilevel modeling
## ───────────────────────────────────

##   Use the dataset, bh1996:
 data(bh1996, package="multilevel")

##   From the data documentation:
##         Variables are Cohesion (COHES), Leadership Climate (LEAD),
##         Well-Being (WBEING) and Work Hours (HRS).  Each of these
##         variables has two variants - a group mean version that
##         replicates each group mean for every individual, and a
##         within-group version where the group mean is subtracted
##         from each individual response.  The group mean version is
##         designated with a G. (e.g., G.HRS), and the within-group
##         version is designated with a W. (e.g., W.HRS).

##   1. Create a null model predicting wellbeing ("WBEING")
##   2. Calculate the ICC for your null model
##   3. Run a second multi-level model that adds two individual-level
##      predictors, average number of hours worked ("HRS") and leadership
##      skills ("LEAD") to the model and interpret your output.
##   4. Now, add a random effect of average number of hours worked ("HRS")
##      to the model and interpret your output.  Test the significance of
##      this random term.
##   5. Finally, add a group-level term, workplace cohesion ("G.COHES") to
##      the model and interpret your output.

## 6 Multiple imputation
## ═════════════════════

## 6.1 Multiple imputation
## ───────────────────────

##   • Majority of datasets contain missing data
##   • Produces a variety of problems and limitations to data analysis
##   • Multiple imputation (MI) generates multiple, complete datasets that
##     contain estimations of missing data points

## 6.2 Multiple imputation
## ───────────────────────

##   Earlier we wanted to compare a model predicting bmi from demographic
##   variables to a model including demographics and substantive
##   predictors. We omitted missing data so that we could fit both models
##   to the same data. That is a common practice, but it has many problems
##   (which we unfortunately don't have time to discuss in detail). A
##   popular solution is to use multiple imputation to fill in the missing
##   values with reasonable placeholders.

##   MI is typically thought of as involving three steps:
##   • Selection of imputation model
##   • Generation of imputed datasets
##   • Combining results across imputed datasets

##   There are a number of packages for doing this in R: we will use the
##   Amelia package because it is powerful, fast, and easy to use. You can
##   refer to the Amelia documentation for more information about its
##   imputation procedures:
##   [http://r.iq.harvard.edu/docs/amelia/amelia.pdf]

## 6.3 Creating imputed data sets
## ──────────────────────────────

##   We're going to create several datasets to look at a model predicting
##   the number of days of work missed/year (wkdayr)

 # load the Amelia package
 library(Amelia)
 # help(package="Amelia")
 # load a smaller version of NH
 NH08.mi <- readRDS("dataSets/NatHealth2008MI")
 # generate five imputed data sets
 amelia.log <- capture.output( # suppress amelia's chattiness
   NatHealth.MI <- amelia(NH08.mi,
 			 m=5,
 			 idvars=c("id")))

## 6.4 Checking imputed values
## ───────────────────────────

##   Compare imputed values to observed values

 plot(NatHealth.MI, which.vars=9:12)

##   [file:images/imputed1.png]

##   [file:images/imputed1.png]

## 6.5 Checking imputed values: overimputation
## ───────────────────────────────────────────

##   Overimputation strategy:
##   • Treat every observed value as if it was missing
##   • Impute many values for that observed value
##   • Examine the correspondence between imputed and observed values

 overimpute(NatHealth.MI, var="sleep")

##   [file:images/overImputed.png]

##   [file:images/overImputed.png]

## 6.6 Using imputed data sets in regression models
## ────────────────────────────────────────────────

##   Zelig makes it very easy to use imputed data sets – just point to the
##   list of imputed data sets in the `data' argument

 library(Zelig)
 nhImp.out <- zelig(wkdayr ~ cigsday + modmin + sleep, model = "ls",
 		   data = NatHealth.MI$imputations, cite = FALSE)
 
 coef(summary(nhImp.out))

##   For separate results, use print(summary(x), subset = i:j).

## 6.7 Exercise 2: multiple imputation
## ───────────────────────────────────

##   1. Using Amelia, generate 5 imputed versions of the Exam dataset. Make
##      sure you tell Amelia which variables are nominal, and that school
##      is the id variable.
##   2. Create plots that compare imputed values to observed values
##   3. Overimpute the variable "schavg"

## 7 Wrap-up
## ═════════

## 7.1 Help us make this workshop better!
## ──────────────────────────────────────

##   • Please take a moment to fill out a very short
##   feedback form
##   • These workshops exist for you – tell us what you need!
##   • [http://tinyurl.com/RstatisticsFeedback]

## 7.2 Additional resources
## ────────────────────────

##   • IQSS workshops:
##     [http://projects.iq.harvard.edu/rtc/filter_by/workshops]
##   • IQSS statistical consulting: [http://rtc.iq.harvard.edu]

##   • Zelig
##     • Website: [http://gking.harvard.edu/zelig]
##     • Documentation: [http://r.iq.harvard.edu/docs/zelig.pdf]
##   • Ameila
##     • Website: [http://gking.harvard.edu/Amelia/]
##     • Documetation: [http://r.iq.harvard.edu/docs/amelia/amelia.pdf]
