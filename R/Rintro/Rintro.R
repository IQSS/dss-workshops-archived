# ---
# title: "Introduction to R workshop notes"
# always_allow_html: yes
# output: 
#   html_document:
#     highlight: tango
#     toc: true
#     toc_float:
#       collapsed: true
# ---
# 
# 
# Welcome
# ========
# 
# Materials and setup 
# -------------------
# 
# **NOTE: skip this section if you are not running R locally** (e.g., if you are
# running R in your browser using a remote Jupyter server)
# 
# You should have R installed --if not:
# 
# -   Download and install R from http://cran.r-project.org
# -   Download and install RStudio from https://www.rstudio.com/products/rstudio/download/#download
# 
# Materials for this workshop consists of notes and example code.
# 
# -   Download materials from
#     <http://tutorials.iq.harvard.edu/R/Rintro.zip>
# -   Extract the zip file containing the materials to your desktop
# 
# Start RStudio and open a new R script:
# - On Windows click the start button and search for rstudio. On Mac
#   RStudio will be in your applications folder.
# - In Rstudio go to `File -> Open File` and open the Rintro.R file you
#   downloaded earlier.
# 
# What is R?
# ----------
# 
# R is a *programming language designed for statistical computing*.
# Notable characteristics include:
# 
# -   Vast capabilities, wide range of statistical and graphical
#     techniques
# -   Very popular in academia, growing popularity in business:
#     <http://r4stats.com/articles/popularity/>
# -   Written primarily by statisticians
# -   FREE (no monetary cost and open source)
# -   Excellent community support: mailing list, blogs, tutorials
# -   Easy to extend by writing new functions
# 
# Whatever you're trying to do, you're probably not the first to try doing
# it R. Chances are good that someone has already written a package for
# that.
# 
# 
# Graphical User Interfaces (GUIs)
# ================================
# 
# There are many different ways you can interact with R. See
# [](http://tutorials.iq.harvard.edu/DataScienceTools/DataScienceTools.html)
# for details. 
# 
# For this workshop I encourage you to use RStudio; it is a good
# R-specific IDE that mostly just works.
# 
# Launch RStudio (skip if not using Rstudio)
# ------------------------------------------
# **Note: skip this section if you are not using Rstudio (e.g., if you are running
# these examples in a Jupyter notebook).**
# 
# -   Start the RStudio program
# -   In RStudio, go to **File =&gt; New File =&gt R Script**
# 
# The window in the upper-left is your R script. This is where you will
# write instructions for R to carry out.
# 
# The window in the lower-left is the R console. This is where results
# will be displayed.
# 
# Exercise 0
# ----------
# 
# The purpose of this exercise is to give you an opportunity to explore
# the interface provided by RStudio (or whichever GUI you've decided to
# use). You may not know how to do these things; that's fine! This is an
# opportunity to figure it out.
# 
# Also keep in mind that we are living in a golden age of tab completion.
# If you don't know the name of an R function, try guessing the first two
# or three letters and pressing TAB. If you guessed correctly the function
# you are looking for should appear in a pop up!
# 
# -------------------------------------------
# 
# 1.  Try to get R to add 2 plus 2.
## ------------------------------------------------------------------------
## write your answer here


# 2.  Try to calculate the square root of 10.
## ------------------------------------------------------------------------
## write your answer here


# 3.  There is an R package named `car`. Try to install this package.
## ------------------------------------------------------------------------
## write your answer here


# 4.  R includes extensive documentation, including a file named "An
#     introduction to R". Try to find this help file.
# 5.  Open a new web browser or tab, go to <http://cran.r-project.org/web/views/> and
#     skim the topic closest to your field/interests.
# 
# 
# 
# R basics
# ========
# 
# 
# Function calls
# ---------
# 
# The general form for calling R functions is
# 
## ----eval=FALSE----------------------------------------------------------
## ## FunctionName(arg.1 = value.1, arg.2 = value.2, ..., arg.n - value.n)

# 
# Arguments can be matched by name; unnamed arguments will be matched by position.
# 
# 
# R packages
# ----------
# 
# R packages can be installed from the Comprehensive R Archive Network (CRAN)
# using the `install.packages` function. Installing a package puts a copy of the
# package on your local computer, but does not make it available for use. To use
# an installed package you must attach it using the `library` function.
# 
# For this workshop we will use a suite of packages called "the tidyverse". The
# tidyverse provides improved replacements for much of the basic data manipulation
# functionality in R. We can install and attach this package as follows:
# 
install.packages("tidyverse")
library("tidyverse")

# 
# Asking R for help
# ---------------------
# 
# You can ask R for help using the `help` function, or the `?` shortcut.
# 
## ------------------------------------------------------------------------
help(help)

# 
# The `help` function can be used to look up the documentation for a function, or
# to look up the documentation to a package. We can learn how to use the `stats`
# package by reading its documentation like this:
# 
help(package = "stats")

# 
# Assignment
# ----------
# 
# Values can be assigned names and used in subsequent operations
# 
# -   The `<-` operator (less than followed by a dash) is used to save
#     values
# -   The name on the left gets the value on the right.
# 
## ------------------------------------------------------------------------
sqrt(10) ## calculate square root of 10; result is not stored anywhere
x <- sqrt(10) # assign result to a variable named x

# 
# Example project: baby names!
# ===============
# 
# General goals
# --------------
# 
# I would like to know what the most popular baby names are. In the course of
# answering this question we will learn to call R functions, install and load
# packages, assign values to names, read and write data, and more.
# 
# Data sets
# ----------
# 
# The examples in this workshop use the baby names data provided by the
# governments of the United States and the United Kingdom. A cleaned and
# merged version of these data is in `dataSets/babyNames.csv`.
# 
# 
# Getting data into R
# ===================
# 
# The "working directory" and listing files
# -----------------------------------------
# 
# R knows the directory it was started in, and refers to this as the
# "working directory". Since our workshop examples are in the Rintro folder, we
# should all take a moment to set that as our working directory.
# 
# 
## ----eval=FALSE----------------------------------------------------------
## getwd() # what is my current working directory?
## # setwd("~/Desktop/Rintro") # change directory

# 
# Note that "`~`" means "my home directory" but that this can mean
# different things on different operating systems. You can also use the
# Files tab in Rstudio to navigate to a directory, then click "More -&gt;
# Set as working directory".
# 
# ---------------------------------------------------
# 
# It can be convenient to list files in a directory without leaving R
# 
## ------------------------------------------------------------------------
list.files("dataSets") # list files in the dataSets folder

# 
# Readers for common file types
# -----------------------------
# 
# In order to read data from a file, you have to know what kind of file it
# is. The table below lists the functions that can import data from common
# file formats.
# 
#   data type                 function         package 
#   ------------------------- ---------------  --------
#   comma separated (.csv)    `read_csv()`     readr
#   other delimited formats   `read_delim()`   readr
#   R (.Rds)                  `read_rds()`     readr
#   Stata (.dta)              `read_dta()`     haven   
#   SPSS (.sav)               `read_spss()`    haven   
#   SAS (.sas7bdat)           `read_sas()`     haven   
#   Excel (.xls, .xlsx)       `read_excel()`   readxl  
# 
# Exercise 2
# ----------
# 
# The purpose of this exercise is to practice reading data into R. The
# data in "`dataSets/babyNames.csv`" is moderately tricky to read, making
# it a good data set to practice on.
# 
# 0.  Install and attach the `tidyverse` package if you have not yet done so. 
# 
# 1.  Open the help page for the `read_csv` function. How can you limit
#     the number of rows to be read in?
## ------------------------------------------------------------------------
## write your answer here


# 2.  Read just the first 10 rows of "`dataSets/babyNames.csv`".
## ------------------------------------------------------------------------
## write your answer here


# 
# 3.  Once you have successfully read in the first 10 rows, read the whole
#     file, assigning the result to the name `baby.names`.
## ------------------------------------------------------------------------
## write your answer here


# 
# Checking imported data
# ----------------------
# 
# It is always a good idea to examine the imported data set--usually we
# want the results to be a `data.frame` or a `tibble`.
# 
## ------------------------------------------------------------------------
class(baby.names) # check to see that it os a data.frame

# 
# We can get more information about R objects using the `glimpse` function.
# 
## ------------------------------------------------------------------------
glimpse(baby.names) # details

# 
# Data Manipulation
# =================
# 
# data.frame objects
# ------------------
# 
# Usually data read into R will be stored as a **data.frame**
# 
# -   A data.frame is a list of vectors of equal length
#     -   Each vector in the list forms a column
#     -   Each column can be a differnt type of vector
#     -   Typically columns are variables and the rows are observations
# 
# A data.frame has two dimensions corresponding the number of rows and the
# number of columns (in that order)
# 
# Slice and Filter data.frames rows
# ---------------------------------
# 
# You can extract subsets of data.frames using `slice` to select rows by
# number and `filter` to select rows that match some condition. It works
# like this:
# 
## ------------------------------------------------------------------------
## make up some example data
(example.df <- data.frame(id  = rep(letters[1:4], each = 4),
                          t   = rep(1:4, times = 4),
                          var1 = runif(16),
                          var2 = sample(letters[1:3], 16, replace = TRUE)))

# 
## ------------------------------------------------------------------------
## rows 2 and 4
slice(example.df, c(2, 4))

# 
## ------------------------------------------------------------------------
## rows where id == "a"
filter(example.df, id == "a")

# 
## ------------------------------------------------------------------------
## rows where id is either "a" or "b"
filter(example.df, id %in% c("a", "b"))

# 
# Select data.frame columns
# -------------------------
# 
# `slice` and `filter` are used to extract rows. `select` is used to
# extract columns
# 
## ------------------------------------------------------------------------
select(example.df, id, var1)

# 
## ------------------------------------------------------------------------
select(example.df, id, t, var1)

# 
# You can also conveniently select a single column using `$`, like this:
# 
## ------------------------------------------------------------------------
example.df$t

# 
# Data manipulation commands can be combined:
# 
## ------------------------------------------------------------------------
filter(select(example.df,
              id,
              var1),
       id == "a")

# 
# In the previous example we used == to filter rows where id was "a".
# Other relational and logical operators are listed below.
# 
#   Operator   Meaning
#   ---------- --------------------------
#   ==       equal to
#   !=       not equal to
#   >        greater than
#   >=       greater than or equal to
#   <        less than
#   <=       less than or equal to
#   %in%     contained in
#   &        and
#   |        or
# 
# Adding, removing, and modifying data.frame columns
# --------------------------------------------------
# 
# You can modify data.frames using the `mutate()` function. It works like
# this:
# 
## ------------------------------------------------------------------------
example.df

# 
## ------------------------------------------------------------------------
## modify example.df and assign the modified data.frame the name example.df
example.df <- mutate(example.df,
       var2 = var1/t, # replace the values in var2
       var3 = 1:length(t), # create a new column named var3
       var4 = factor(letters[t]),
       t = NULL # delete the column named t
       )

# 
## ------------------------------------------------------------------------
## examine our changes
example.df

# 
# Exporting Data
# --------------
# 
# Now that we have made some changes to our data set, we might want to
# save those changes to a file.
# 
## ------------------------------------------------------------------------
# write data to a .csv file
write_csv(example.df, path = "example.csv")

# write data to an R file
write_rds(example.df, path = "example.rds")

# write data to a Stata file
library(haven)
write_dta(example.df, path = "example.dta")

# 
# Saving and loading R workspaces
# -------------------------------
# 
# In addition to importing individual datasets, R can save and load entire
# workspaces
# 
## ------------------------------------------------------------------------
ls() # list objects in our workspace
save.image(file="myWorkspace.RData") # save workspace 
rm(list=ls()) # remove all objects from our workspace 
ls() # list stored objects to make sure they are deleted

# 
# Load the "myWorkspace.RData" file and check that it is restored
# 
## ------------------------------------------------------------------------
load("myWorkspace.RData") # load myWorkspace.RData
ls() # list objects

# 
# Exercise 3: Data manipulation
# -----------------------------
# 
# Read in the "babyNames.csv" file if you have not already done so,
# assigning the result to `baby.names`. The file is located at "http://tutorials.iq.harvard.edu/R/Rintro/dataSets/babyNames.csv"
# 
# 1.  Filter `baby.names` to show only names given to at least 5 percent
#     of boys.
## ------------------------------------------------------------------------
## write your answer here


# 2.  Create a column named "Proportion" equal to Percent divided by 100.
## ------------------------------------------------------------------------
## write your answer here


# 3.  Filter `baby.names` to include only names given to at least 3
#     percent of Girls. Save this to a Stata data set
#     named "popularGirlNames.dta")
## ------------------------------------------------------------------------
## write your answer here


# 
# Basic Statistics and Graphs
# ===========================
# 
# Basic statistics
# ----------------
# 
# Descriptive statistics of single variables are straightforward:
# 
## ------------------------------------------------------------------------
sum(example.df$var1) # calculate sum of var 1
mean(example.df$var1)
median(example.df$var1)

# 
## ------------------------------------------------------------------------
sd(example.df$var1) # calculate standard deviation of var1
var(example.df$var1)

# 
## ------------------------------------------------------------------------
## summaries of individual columns
summary(example.df$var1)

# 
## ------------------------------------------------------------------------
summary(example.df$var2)

# 
## ------------------------------------------------------------------------
## summary of whole data.frame
summary(example.df)

# 
# Some of these functions (e.g., summary) will also work with data.frames
# and other types of objects, others (such as `sd`) will not.
# 
# Statistics by grouping variable(s)
# ----------------------------------
# 
# The `summarize` function can be used to calculate statistics by grouping
# variable. Here is how it works.
# 
## ------------------------------------------------------------------------
summarize(group_by(example.df, id), mean(var1), sd(var1))

# 
# You can group by multiple variables:
# 
## ------------------------------------------------------------------------
summarize(group_by(example.df, id, var3), mean(var1), sd(var1))

# 
# Save R output to a file
# -----------------------
# 
# Earlier we learned how to write a data set to a file. But what if we
# want to write something that isn't in a nice rectangular format, like
# the output of `summary`? For that we can use the `sink()` function:
# 
## ------------------------------------------------------------------------
sink(file="output.txt", split=TRUE) # start logging
print("This is the summary of example.df \n")
print(summary(example.df))
sink() ## sink with no arguments turns logging off

# 
# Exercise 4
# ----------
# 
# 1.  Calculate the total number of children born.
## ------------------------------------------------------------------------
## write your answer here


# 2.  Filter the data to extract only Massachusetts (Location "MA"), and
#     calculate the total number of children born in Massachusetts.
## ------------------------------------------------------------------------
## write your answer here


# 3.  Group and summarize the data to calculate the number of children
#     born each year. Assign the result to the name `births.by.year`.
## ------------------------------------------------------------------------
## write your answer here


# 4.  Calculate the average number of characters in baby names (using the
#     "Name.length" column).
## ------------------------------------------------------------------------
## write your answer here


# 5.  Group and summarize to calculate the average number of characters in
#     baby names for each location. Assign the result to the name `name.length.by.location`.
# 
# 
# Basic graphics: Frequency bars
# ------------------------------
# 
# Thanks to classes and methods, you can `plot()` many kinds of objects:
# 
## ------------------------------------------------------------------------
plot(example.df$var4)

# 
# Basic graphics: Boxplots by group
# ---------------------------------
# 
# Thanks to classes and methods, you can `plot()` many kinds of objects:
# 
## ------------------------------------------------------------------------
plot(select(example.df, id, var1))

# 
# Basic graphics: Mosaic chart
# ----------------------------
# 
# Thanks to classes and methods, you can `plot()` many kinds of objects:
# 
## ------------------------------------------------------------------------
plot(select(example.df, id, var4))

# 
# Basic graphics: scatter plot
# ----------------------------
# 
## ------------------------------------------------------------------------
plot(select(example.df, var1, var2))

# 
# Exercise 5 TBD
# --------------
# 
# Wrap-up
# =======
# 
# Help us make this workshop better!
# ----------------------------------
# 
# -   Please take a moment to fill out a very short feedback form
# -   These workshops exist for you – tell us what you need!
# -   <http://tinyurl.com/R-intro-feedback>
# 
# Additional resources
# --------------------
# 
# -   IQSS workshops:
#     <http://projects.iq.harvard.edu/rtc/filter_by/workshops>
# -   IQSS statistical consulting: <http://dss.iq.harvard.edu>
# -   Software (all free!):
#     -   R and R package download: <http://cran.r-project.org>
#     -   Rstudio download: <http://rstudio.org>
#     -   ESS (emacs R package): <http://ess.r-project.org/>
# -   Online tutorials
#     -   <http://www.codeschool.com/courses/try-r>
#     -   <http://www.datacamp.org>
#     -   <http://swirlstats.com/>
#     -   <http://r4ds.had.co.nz/>
# -   Getting help:
#     -   Documentation and tutorials:
#         <http://cran.r-project.org/other-docs.html>
#     -   Recommended R packages by topic:
#         <http://cran.r-project.org/web/views/>
#     -   Mailing list: <https://stat.ethz.ch/mailman/listinfo/r-help>
#     -   StackOverflow: <http://stackoverflow.com/questions/tagged/r>
# -   Coming from...
#     Stata
#     :   <http://www.princeton.edu/~otorres/RStata.pdf>
#     SAS/SPSS
#     :   <http://www.et.bs.ehu.es/~etptupaf/pub/R/RforSAS&SPSSusers.pdf>
#    matlab
#    :   <http://www.math.umaine.edu/~hiebeler/comp/matlabR.pdf>
# 
#     Python
#     :   <http://mathesaurus.sourceforge.net/matlab-python-xref.pdf>
