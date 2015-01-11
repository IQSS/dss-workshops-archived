##                           ━━━━━━━━━━━━━━━━━━━
##                            INTRODUCTION TO R

##                                Ista Zahn
##                           ━━━━━━━━━━━━━━━━━━━

## Table of Contents
## ─────────────────

## 1 Workshop Materials and Introduction
## 2 Graphical User Interfaces
## 3 Data and Functions
## 4 Help and package management
## 5 Getting data into R
## 6 Data Manipulation
## 7 Basic Statistics and Graphs
## 8 Wrap-up
## 9 Exercise solutions

## 1 Workshop Materials and Introduction
## ═════════════════════════════════════

## 1.1 Materials and setup
## ───────────────────────

## 1.1.1 Laptop users: You should have R installed –if not:
## ╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌

## ◊ 1.1.1.1 Open a web browser and go to [http://cran.r-project.org] and download and install it

## ◊ 1.1.1.2 Also helpful to install RStudio (download from [http://rstudio.com])

## 1.1.2 Everyone: Download workshop materials:
## ╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌

## ◊ 1.1.2.1 Download materials from [http://tutorials.iq.harvard.edu/R/Rintro.zip]

## ◊ 1.1.2.2 Extract the zip file containing the materials to your desktop

## 1.2 What is R?
## ──────────────

##   R is a programming language designed for statistical computing.
##   Notable characteristics include:

##   • Vast capabilities, wide range of statistical and graphical
##     techniques

##   • Very popular in academia, growing popularity in business:
##     [http://r4stats.com/articles/popularity/]

##   • Written primarily by statisticians

##   • FREE (no cost, open source)

##   • Excellent community support: mailing list, blogs, tutorials

##   • Easy to extend by writing new functions

## 1.3 InspiRation
## ───────────────

##   OK, it's free and popular, but what makes R worth learning? In a word,
##   "packages". If you have a data manipulation, analysis or visualization
##   task, chances are good that there is an R package for that. For
##   example:

##   • Want to interactively explore the shape of the Churyumov–Gerasimenko
##     comet?

library(rgl)
open3d()
comet <- readOBJ(url("http://sci.esa.int/science-e/www/object/doc.cfm?fobjectid=54726"))
shade3d(comet, col="gray")
writeWebGL(dir="images", filename = "images/comet.html")

##   • Want to find out where we are?

library(ggmap)
nwbuilding <- geocode("52 Oxford Street, Cambridge, MA") 
ggmap(get_map("Cambridge, MA", zoom = 15)) +
  geom_point(data=nwbuilding, size = 7, shape = 13, color = "red")

##   • Want to forecast the population of Australia?

library(forecast)
fit <- auto.arima(austres)
## Projected numbers (in thousands) of Australian residents
summary(forecast(fit))

##   These a just a few examples, but generally whatever you're trying to
##   do, you're probably not the first to try doing it R, and chances are
##   good that someone has already written a package for that.

## 1.4 Coming to R
## ───────────────

##   Comming from…
##   Stata: [http://www.princeton.edu/~otorres/RStata.pdf]
##   SAS/SPSS: [http://www.et.bs.ehu.es/~etptupaf/pub/R/RforSAS&SPSSusers.pdf]
##   matlab: [http://www.math.umaine.edu/~hiebeler/comp/matlabR.pdf]
##   Python: [http://mathesaurus.sourceforge.net/matlab-python-xref.pdf]

## 2 Graphical User Interfaces
## ═══════════════════════════

## 2.1 R GUI alternatives (no GUI)
## ───────────────────────────────

##   The old-school way is to run R directly in a terminal

##   But hardly anybody does it that way anymore!

## 2.2 R GUI alternatives (Windows default)
## ────────────────────────────────────────

##   The default windows GUI is not very good
##   • No parentheses matching or syntax highlighting
##   • No work-space browser

## 2.3 R GUI Alternatives (Rstudio on Mac)
## ───────────────────────────────────────

##   Rstudio has many useful features, including parentheses matching and
##   auto-completion

## 2.4 R GUI Alternatives (Emacs with ESS)
## ───────────────────────────────────────

##   Emacs + ESS is a very powerful combination, but can be difficult to
##   set up

## 2.5 Things to keep in mind
## ──────────────────────────

##   • Case sensitive, like Stata (unlike SAS)

##   • Comments can be put almost anywhere, starting with a hash mark
##     ('`#''); everything to the end of the line is a comment

##   • The command prompt "`>'" indicates that R is ready to receive
##     commands

##   • If a command is not complete at the end of a line, R will give a
##     different prompt, '`+'' by default

##   • Parentheses must always match (first thing to check if you get an
##     error)

##   • R Does not care about spaces between commands or arguments

##   • Names should start with a letter and should not contain spaces

##   • Can use "." in object names (e.g., "my.data")

##   • Use forward slash ("/") instead of backslash in path names, even on
##     Windows

## 2.6 Exercise 0
## ──────────────

##   1. Try to get R to add 2 plus 2.
##   2. Try to figure out how evaluate lines directly from your R script.
##   3. R includes extensive documentation, including a file named "An
##      introduction to R". Try to find this help file.
##   4. Go to [http://cran.r-project.org/web/views/] and skim the topic
##      closest to your field/interests.

## 3 Data and Functions
## ════════════════════

## 3.1 Assignment
## ──────────────

##   Values can be assigned names and used in subsequent operations
##   • The `<-' operator (less than followed by a dash) is used to save
##     values
##   • The name on the left gets the value on the right.

x <- 11 # Assign the value 10 to a variable named x
x + 1 # Add 1 to x
y <- x + 1 # Assign y the value x + 1
y

##   Saved variables can be listed, overwritten and deleted

ls() # List variables in workspace
x # Print the value of x
x <- 100 # Overwrite x. Note that no warning is given!
x
rm(x) # Delete x
ls()

## 3.2 Functions
## ─────────────

##   Using R is mostly about applying *functions* to *variables*. Functions
##   • take *variable(s)* as input *argument(s)*
##   • perform operations
##   • *return* values which can be *assigned*
##   • optionally perform side-effects such as writing a file to disk or
##     opening a graphics window

##   The general form for calling R functions is

FunctionName(arg.1, arg.2, ... arg.n)

##   Arguments can be matched by position or name

##   Examples:

#?sqrt
a <- sqrt(y) # Call the sqrt function with argument x=y
round(a, digits = 2) # Call round() with arguments x=x and digits=2
# Functions can be nested so an alternative is
round(sqrt(y), digits = 5) # Take sqrt of a and round

## 4 Help and package management
## ═════════════════════════════

## 4.1 Asking R for help
## ─────────────────────

##   R has extensive built-in documentation that can be accessed through R
##   commands or through the GUI.
##   • Start html help, search/browse using web browser
##     • at the R console:
##       ┌────
##       │ help.start()
##       └────

##     • or use the help menu from you GUI

##   • Look up the documentation for a function
##     ┌────
##     │ help(plot)
##     └────

##     ┌────
##     │ ?kmeans
##     └────

##   • Look up documentation for a package
##     ┌────
##     │ help(package="stats")
##     └────

##   • Search documentation from R (not always the best way… google often
##     works better)
##     ┌────
##     │ help.search("classification")
##     └────

## 4.2 R packages and libraries
## ────────────────────────────

##   There are thousands of R packages that extend R's capabilities.

##   • To view available packages:
##     ┌────
##     │ library()
##     └────

##   • To see what packages are loaded:
##     ┌────
##     │ search()
##     └────

##   • To load a package:
##     ┌────
##     │ library("car")
##     └────

##   • Install new package:
##     ┌────
##     │ install.packages("stringdist")
##     └────

## 5 Getting data into R
## ═════════════════════

## 5.1 The gss dataset
## ───────────────────

##   The next few examples use a subset of the General Social Survey data
##   set. The variables in this subset include

head(read.csv("dataSets/gssInfo.csv")) 
#see gssInfo.csv for rest of the variable descriptions

## 5.2 The "working directory" and listing files
## ─────────────────────────────────────────────

##   R knows the directory it was started in, and refers to this as the
##   "working directory". Since our workshop examples are in the Rintro
##   folder on the desktop, we should all take a moment to set that as our
##   working directory:

setwd("~/Desktop/Rintro")

##   We can also set the working directory using paths relative to the
##   current working directory:

getwd() # get the current working directory
setwd("dataSets") # set wd to the dataSets folder
getwd()
setwd("..") # set wd to enclosing folder ("up")

##   It can be convenient to list files in a directory without leaving R

list.files("dataSets") # list files in the dataSets folder
# list.files("dataSets", pattern = ".csv") # restrict to .csv files

## 5.3 Importing data from files
## ─────────────────────────────

##   In order to read data from a file, you have to know what kind of file
##   it is. The table below lists the functions needed to import data from
##   common file formats.

##   ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
##    data type                function                 package         
##   ───────────────────────────────────────────────────────────────────
##    comma separated (.csv)   read.csv()               utils (default) 
##    other delimited formats  read.table()             utils (default) 
##    Stata (.dta)             read.dta()               foreign         
##    SPSS (.sav)              read.spss()              foreign         
##    SAS (.sas7bdat)          read.sas7bdat()          sas7bdat        
##    Excel (.xls, .xlsx)      readWorksheetFromFile()  XLConnect       
##   ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

##   Examples:

# read gss data from the gss.rds R file
datGSS <- readRDS("dataSets/gss.rds")
# read gss data from the gss.csv comma separated file
gss.data <- read.csv("dataSets/gss.csv") # read gss data
# read a Stata dataset from gss.dta 
library(foreign) # load foreign data functions
datGSS <- read.dta(file="dataSets/gss.dta")

## 5.4 Checking imported data
## ──────────────────────────

##   Always a good idea to examine the imported data set–usually we want
##   the results to be a `data.frame'

class(datGSS) # check to see that test is what we expect it to be
dim(datGSS) # how many rows and columns?
names(datGSS)[1:10] # first 10 column names
str(datGSS[1:5]) # more details about the first 5 columns

## 5.5 Saving and loading R  workspaces
## ────────────────────────────────────

##   In addition to importing individual datasets, R can save and load
##   entire workspaces
##   • Save our entire workspace

ls() # list objects in our workspace
save.image(file="myWorkspace.RData") # save workspace 
rm(list=ls()) # remove all objects from our workspace 
ls() # list stored objects to make sure they are deleted

##   • Load the "myWorkspace.RData" file and check that it is restored

load("myWorkspace.RData") # load myWorkspace.RData
ls() # list objects

##   When you close R you will be asked if you want to save your workspace
##   – if you choose yes then your workspace will be restored next time you
##   start R

## 5.6 Exercise 1
## ──────────────

##   1. Load the foreign package if you haven't already done so

##   2. Look at the help page for the read.spss function

##   3. Read the SPSS data set in dataSets/gss.sav and assign the result to
##      an R data object named GSS.sav

##   4. Make sure that the data loaded in step 2 is a data.frame (hint:
##      check the arguments documented in the help page)

##   5. Display the dimensions of the GSS.sav.

##   6. BONUS: figure out how to read the Excel file "gss.xlsx" into R

## 6 Data Manipulation
## ═══════════════════

## 6.1 data.frame objects
## ──────────────────────

##   • Usually data read into R will be stored as a *data.frame*

##   • A data.frame is a list of vectors of equal length
##     • Each vector in the list forms a column
##     • Each column can be a differnt type of vector
##     • Often the columns are variables and the rows are observations

##   • A data.frame has two dimensions corresponding the number of rows and
##     the number of columns (in that order)

## 6.2 data.frame meta-data
## ────────────────────────

##   A number of functions are available for inspecting data.frame objects:

# row and column names
head(names(datGSS)) # variable names in datGSS
head(rownames(datGSS)) # first few rownames of datGSS
# dimensions
dim(datGSS)
# structure
#str(datGSS) # get structure

## 6.3 Logical operators
## ─────────────────────

##   It is often useful to select just those rows of your data where some
##   condition holds–for example select only rows where sex is 1 (male).
##   The following operators allow you to do this:

##   ==: equal to
##   !=: not equal to
##   >: greater than
##   <: less than
##   >=: greater than or equal to
##   <=: less than or equal to
##   &: and
##   |: or

##   Note the double equals signs for testing equality. The following
##   example show how to use some of these operators to extract and replace
##   elements matching specific conditions.

## 6.4 Extracting subsets of data.frames
## ─────────────────────────────────────

##   You can extract subsets of data.frames using the `subset()' function.

# extracting subsets
subset(datGSS,
       # rows 1 through 3
       subset = rownames(datGSS) %in% 1:3,
       # column 1 to 5
       select = 1:4)

subset(datGSS,
       # rows where age > 90
       subset = age > 90,
       ## sex and age columns
       select = c("sex", "age"))

## the $ operator can be used to extract a single column
str(datGSS$age)

##   Note that `subset()' is a convenience function; see `?Extract' for a
##   more powerful (and complicated) way to subset data.

## 6.5 Transforming data.frames
## ────────────────────────────

##   You can modify data.frames using the `transform()' function.

# creating new variable mean centered age
datGSS <- transform(datGSS,
                    ageC = age - mean(age))

 #education difference between wifes and husbands
datGSS <- transform(datGSS,
                    educ.diff = wifeduc - husbeduc)

## ifelse() is also useful; note that the $ operator can
## also be used to create new variables.
datGSS$young <- ifelse(datGSS$age < 30, "yes", "no")

## examine our newly created variables
head(subset(datGSS,
            select = c("age", "ageC", "young", "wifeduc",
                       "husbeduc", "educ.diff")),
     n = 8)

##   Note that `transform' is a convenience function; see `?Extract' for a
##   more powerful way to modify data.frames.

## 6.6 Exporting Data
## ──────────────────

##   Now that we have made some changes to our GSS data set, we might want
##   to save those changes to a file. Everything we have done so far has
##   only modified the data in R; the files have remained unchanged.

# write data to a .csv file
write.csv(datGSS, file = "gss.csv")
# write data to a Stata file
write.dta(datGSS, file = "gss.dta")
# write data to an R file
saveRDS(datGSS, file = "gss.rds")

## 6.7 Exercise 2: Data manipulation
## ─────────────────────────────────

##   Use the gss.rds data set

##   1. Generate the following variables:
##      • "rich" equal to 0 if rincdol is less than 100000, and 1 otherwise
##      • "sinc" equal to incomdol - rincdol
##   2. Create a subset of the data containing only rows where "usecomp" =
##      "Yes"
##   3. Examine the data.frame created in step 2, and answer the following
##      questions:
##      • How many rows does it have?
##      • How many columns does it have?
##      • What is the class of the "satjob" variable?
##   4. BONUS (hard): Generate a variable named "dual.earn" equal to 1 if
##      both wkftwife = 1 and wkfthusb = 1, and zero otherwise

## 7 Basic Statistics and Graphs
## ═════════════════════════════

## 7.1 Basic statistics
## ────────────────────

##   Descriptive statistics of single variables are straightforward:

mean(datGSS$educ) # calculate mean value of education
sd(datGSS$educ) # calculate standard deviation of x
# calculate min, max, quantiles, mean of educ, age, and ageC
summary(subset(datGSS, select = c("educ", "age", "ageC")))

##   Some of these functions (e.g., summary) will also work with
##   data.frames and other types of objects, others (such as `sd') will
##   not.

## 7.2 Counts and proportions
## ──────────────────────────

##   Start by using the `table()' function to tabulate counts, then perform
##   additional computations if needed

sex.counts <- table(datGSS$sex) # tabulate sex categories
sex.counts
prop.table(sex.counts) # convert to proportions

##   Add variables for crosstabs

table(subset(datGSS, select = c("sex", "happy"))) # crosstab marital X happy

## 7.3 Statistics by classification factors
## ────────────────────────────────────────

##   The `by()' function can be used to perform a calculation separately
##   for each level of a classifying variable

by(subset(datGSS, select = c("income", "educ")),
   INDICES=datGSS["sex"],
   FUN=summary)

## 7.4 Correlations
## ────────────────

##   Let's look at correlations among between age, income, and education

cor(subset(datGSS, select =  c("age", "incomdol", "educ")))

##   For significance tests, use cor.test()

with(datGSS,
     cor.test(age, educ))

## 7.5 Multiple regression
## ───────────────────────

##   Modeling functions generally use the /formula/ interface whith DV on
##   left followed by "~" followed by predictors–for details see

help("formula")

##   • Predict the number of hours individuals spend on email (emailhrs)

m1 <- lm(educ ~ sex + age, data = datGSS)
summary(m1)

## 7.6 Save R output to a file
## ───────────────────────────

##   Earlier we learned how to write a data set to a file. But what if we
##   want to write something that isn't in a nice rectangular format, like
##   the results of our regression model? For that we can use the `sink()'
##   function:

sink(file="output.txt", split=TRUE) # start logging
print("This is the result from model 1\n")
print(summary(m1))
sink() ## sink with no arguments turns logging off

## 7.7 Basic graphics: Frequency bars
## ──────────────────────────────────

##   Thanks to classes and methods, you can `plot()' many kinds of objects:

plot(datGSS$marital) # Plot a factor

## 7.8 Basic graphics: Boxplots by group
## ─────────────────────────────────────

##   Thanks to classes and methods, you can `plot()' many kinds of objects:

with(datGSS,
     plot(marital, educ)) # Plot ordinal by numeric

## 7.9 Basic graphics: Mosaic chart
## ────────────────────────────────

##   Thanks to classes and methods, you can `plot()' many kinds of objects:

with(datGSS, # Plot factor X factor
     plot(marital, happy))

## 7.10 Exercise 3
## ───────────────

##   Using the datGSS data.frame

##   1. Cross-tabulate sex and emailhrs
##   2. Calculate the mean and standard deviation of incomdol by sex
##   3. Save the results of the previous two calculations to a file
##   4. Create a scatter plot with educ on the x-axis and incomdol on the
##      y-axis

## 8 Wrap-up
## ═════════

## 8.1 Help us make this workshop better!
## ──────────────────────────────────────

##   • Please take a moment to fill out a very short feedback form

##   • These workshops exist for you – tell us what you need!

##   • [http://tinyurl.com/R-intro-feedback]

## 8.2 Additional resources
## ────────────────────────

##   • IQSS workshops:
##     [http://projects.iq.harvard.edu/rtc/filter_by/workshops]

##   • IQSS statistical consulting: [http://rtc.iq.harvard.edu]

##   • Software (all free!):
##     • R and R package download: [http://cran.r-project.org]
##     • Rstudio download: [http://rstudio.org]
##     • ESS (emacs R package): [http://ess.r-project.org/]

##   • Online tutorials
##     • [http://www.codeschool.com/courses/try-r]
##     • [http://www.datamind.org]

##   • Getting help:
##     • Documentation and tutorials:
##       [http://cran.r-project.org/other-docs.html]
##     • Recommended R packages by topic:
##       [http://cran.r-project.org/web/views/]
##     • Mailing list: [https://stat.ethz.ch/mailman/listinfo/r-help]
##     • StackOverflow: [http://stackoverflow.com/questions/tagged/r]

## 9 Exercise solutions
## ════════════════════

## 9.1 Exercise 0 solution                                      :prototype:
## ───────────────────────

##   1) ] Try to get R to add 2 plus 2.

2 + 2

##   2) Try to figure out how evaluate lines directly from your R script.
##   `In Rstudo this is 'Control-Enter'; may be different in another GUI'
##   3) R includes extensive documentation, including a file named "An
##      introduction to R". Try to find this help file.
##   `Go to the main help page by running 'help.start() or using the GUI
##   menu, find and click on the link to "An Introduction to R".'
##   4) Go to [http://cran.r-project.org/web/views/] and skim the topic
##      closest to your field/interests.
##   `I like the machine learning topic!'

## 9.2 Exercise 1 solution                                      :prototype:
## ───────────────────────

##   1) Load the foreign package if you haven't already done so

library(foreign)

##   2) Look at the help page for the read.spss function

help("read.spss")

##   3) Read the SPSS data set in dataSets/gss.sav and assign the result to
##      an R data object named GSS.sav

gss.data <- read.spss("dataSets/gss.sav", to.data.frame=TRUE)

##   4) Make sure that the data loaded in step 2 is a data.frame (hint:
##      check the arguments documented in the help page)

class(gss.data)

##   5) Display the dimensions of the GSS.sav.

dim(gss.data)
nrow(gss.data)
ncol(gss.data)

##   6) BONUS: figure out how to read the Excel file "gss.xlsx" into R

library(XLConnect)
dat <- readWorksheetFromFile("dataSets/gss.xlsx", sheet = 1)
class(dat); dim(dat)

## 9.3 Exercise 2 solution                                      :prototype:
## ───────────────────────

##   Use the gss.rds data set

gss <- readRDS("dataSets/gss.rds")

##   1) Create a subset of the data containing only rows where "usecomp" =
##      "Yes". How many computer users are there?

gss.usecomp <- subset(gss, usecomp == "Yes")
nrow(gss.usecomp)

##   2) Generate the following variables:
##      • "rich" equal to 0 if rincdol is less than 100000, and 1 otherwise
##      • "sinc" equal to incomdol - rincdol

gss <- transform(gss,
                 rich = ifelse(rincdol < 100000, 0, 1),
                 sinc = incomdol - rincdol)
head(subset(gss, select = c("rincdol", "incomdol", "rich", "sinc")))

##   3) Generate a variable named "dual.earn" equal to 1 if both wkftwife =
##      1 and wkfthusb = 1, and zero otherwise. How many dual earners are
##      there?

gss$dual.earn <- ifelse(gss$wkftwife == 1 & gss$wkfthusb == 1, 1, 0)
nrow(subset(gss, dual.earn == 1))

## 9.4 Exercise 3 solution                                      :prototype:
## ───────────────────────

##   Using the datGSS data.frame

##   1) Cross-tabulate sex and emailhrs

with(datGSS, table(sex, emailhrs))

##   2) Calculate the mean and standard deviation of incomdol by sex

by(datGSS$incomdol, datGSS$sex, mean)
by(datGSS$incomdol, datGSS$sex, sd)

##   3) Create a scatter plot with educ on the x-axis and incomdol on the
##      y-axis

plot(subset(datGSS, select = c("educ", "incomdol")))
