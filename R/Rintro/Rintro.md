---
title: "Introduction to R workshop notes"
always_allow_html: yes
output: 
  html_document:
    highlight: tango
    toc: true
    toc_float:
      collapsed: true
---



Welcome
========

Materials and setup 
-------------------

**NOTE: skip this section if you are not running R locally** (e.g., if you are
running R in your browser using a remote Jupyter server)

You should have R installed --if not:

-   Download and install R from http://cran.r-project.org
-   Download and install RStudio from https://www.rstudio.com/products/rstudio/download/#download

Notes and examples for this workshop are available at 
[](http://tutorials.iq.harvard.edu/R/Rintro/Rintro.html)

Start RStudio and open a new R script:
-   On Windows click the start button and search for rstudio. On Mac
    RStudio will be in your applications folder.
-   In Rstudio go to `File -> New File -> R Script`

Download workshop materials

Download the materials from http://tutorials.iq.harvard.edu/Python/PythonIntro.zip and extract the zipped directory (Right-click => Extract All on Windows, double-click on Mac).

Workshop goals and approach
---------------------------

In this workshop you will

-  learn R language basics and common idioms,
-  learn about the R package ecosystem,
-  practice reading files and manipulating data in R

A more general goal is to get you comfortable with R so that it seems less scary and mystifying than it perhaps does now. Note that this is by no means a complete or thorough introduction to R! It's just enough to get you started.

This workshop is relatively informal, example-oriented, and hands-on. We won't spend much time examining language features in detail. Instead we will work through an example, and learn some things about the R language and environment along the way.

As an example project we will analyze the popularity of baby names in the US and the UK. Among the questions we will use R to answer are:

-  How many children were named "Jack" or "Jill" in 1996?
-  In which year was the name "Ashley" the most popular?
-  What are the most popular names overall? For girls? For Boys?
-  How many children were born each year?



What is R?
----------

R is a *programming language designed for statistical computing*.
Notable characteristics include:

-   Vast capabilities, wide range of statistical and graphical
    techniques
-   Very popular in academia, growing popularity in business:
    <http://r4stats.com/articles/popularity/>
-   Written primarily by statisticians
-   FREE (no monetary cost and open source)
-   Excellent community support: mailing list, blogs, tutorials
-   Easy to extend by writing new functions

Whatever you're trying to do, you're probably not the first to try doing
it R. Chances are good that someone has already written a package for
that.

Graphical User Interfaces (GUIs)
================================

There are many different ways you can interact with R. See the
[Data Science Tools workshop notes](http://tutorials.iq.harvard.edu/DataScienceTools/DataScienceTools.html) 
for details.

For this workshop I encourage you to use RStudio; it is a good
R-specific IDE that mostly just works.

Launch RStudio (skip if not using Rstudio)
------------------------------------------
**Note: skip this section if you are not using Rstudio (e.g., if you are running
these examples in a Jupyter notebook).**

-   Start the RStudio program
-   In RStudio, go to **File =&gt; New File =&gt R Script**

The window in the upper-left is your R script. This is where you will
write instructions for R to carry out.

The window in the lower-left is the R console. This is where results
will be displayed.

Exercise 0
----------

The purpose of this exercise is to give you an opportunity to explore
the interface provided by RStudio (or whichever GUI you've decided to
use). You may not know how to do these things; that's fine! This is an
opportunity to figure it out.

Also keep in mind that we are living in a golden age of tab completion.
If you don't know the name of an R function, try guessing the first two
or three letters and pressing TAB. If you guessed correctly the function
you are looking for should appear in a pop up!

-------------------------------------------

1.  Try to get R to add 2 plus 2.

```r
##
```
2.  Try to calculate the square root of 10.

```r
##
```
3.  R includes extensive documentation, including a file named "An
    introduction to R". Try to find this help file.


Exercise 0 solution<span class="tag" data-tag-name="prototype"></span>
----------------------------------------------------------------------





R basics
========


Function calls
---------

The general form for calling R functions is


```r
## FunctionName(arg.1 = value.1, arg.2 = value.2, ..., arg.n - value.n)
```

Arguments can be matched by name; unnamed arguments will be matched by position.

Assignment
----------

Values can be assigned names and used in subsequent operations

-   The `<-` operator (less than followed by a dash) is used to save
    values
-   The name on the left gets the value on the right.


```r
sqrt(10) ## calculate square root of 10; result is not stored anywhere
x <- sqrt(10) # assign result to a variable named x
```

Asking R for help
---------------------

You can ask R for help using the `help` function, or the `?` shortcut.


```r
help(help)
```

The `help` function can be used to look up the documentation for a function, or
to look up the documentation to a package. We can learn how to use the `stats`
package by reading its documentation like this:


```r
help(package = "stats")
```


Getting data into R
===================

R has data reading functionality built-in -- see e.g.,
`help(read.table)`. However, faster and more robust tools are
available, and so to make things easier on ourselves we will use a
*contributed package* called `readr` instead. This requires that we
learn a little bit about packages in R.

Installing and using R packages
----------------------------------------------------

A large number of contributed packages are available. If you are
looking for a package for a specific task,
https://cran.r-project.org/web/views/ and https://r-pkg.org are good
places to start.

You can install a package in R using the `install.packages()`
function. Once a package is installed you may use the `library`
function to attach it so that it can be used.


```r
## install.packages("readr")
library(readr)
```

Readers for common file types
-----------------------------

In order to read data from a file, you have to know what kind of file
it is. The table below lists functions that can import data from
common plain-text formats.

| Data Type                 | Function        |
| ------------------------- | --------------- |
| comma separated           | `read_csv()`    |
| tab separated             | `read_delim()`  |
| other delimited formats   | `read_table()`  |
| fixed width               | `read_fwf()`    |

**Note** You may be confused by the existence of similar functions,
e.g., `read.csv` and `read.delim`. These are legacy functions that
tend to be slower and less robust than the `readr` functions. One way
to tell them apart is that the faster more robust versions use
underscores in their names (e.g., `read_csv`) while the older
functions us dots (e.g., `read.csv`). My advice is to use the more
robust newer versions, i.e., the ones with underscores.

Baby names data
---------------

The examples in this workshop use the baby names data provided by the
governments of the United States and the United Kingdom. A cleaned and
merged version of these data is available at
`http://tutorials.iq.harvard.edu/R/Rintro/dataSets/babyNames.csv`.


Exercise 2
----------

The purpose of this exercise is to practice reading data into R.

1.  Open the help page for the `read_csv` function. How can you limit
    the number of rows to be read in?

```r
##
```
2.  Read just the first 10 rows of
"`"http://tutorials.iq.harvard.edu/R/Rintro/dataSets/babyNames.csv`".

```r
##
```
3.  Once you have successfully read in the first 10 rows, read the whole
    file, assigning the result to the name `baby.names`.

```r
##
```

Exercise 2 solution<span class="tag" data-tag-name="prototype"></span>
----------------------------------------------------------------------



Data Manipulation
=================

data.frame objects
------------------

Usually data read into R will be stored as a **data.frame**

-   A data.frame is a list of vectors of equal length
    -   Each vector in the list forms a column
    -   Each column can be a differnt type of vector
    -   Typically columns are variables and the rows are observations

A data.frame has two dimensions corresponding to the number of rows and the
number of columns (in that order)

Tools for manipulating data.frame objects
----------------------------------------------------

R has decent data manipulation tools built-in -- see e.g.,
`help(Extract)`. However, these tools are powerful and complex and
often overwhelm beginners. To make things easier on ourselves we will
use a *contributed package* called `dplyr` instead.


```r
## install.packages("dplyr")
library(dplyr)
```

Checking imported data
----------------------

It is always a good idea to examine the imported data set--usually we
want the results to be a `data.frame`


```r
class(baby.names) # check to see that it os a data.frame
```

We can get more information about R objects using the `glimpse` function.


```r
glimpse(baby.names) # structure
```


```r
View(baby.names) # visually inspect
```

Filter data.frame rows
---------------------------------

You can extract subsets of data.frames using `filter` to select rows
meeting some condition.


```r
## rows where Name == "jill"
filter(baby.names, Name == "jill")
```

It is often useful to `arrange` the data to make it easier to see patterns. For example, we can see which years saw the most babies named "Jill":


```r
jill <- filter(baby.names, Name == "jill")
arrange(jill, Count)
```

We can combine conditons usine `&` (AND) and `|` (OR). For example, to find the number of babies named "Jill" or "Jack" born in 1996:

```r
## rows where Year is 1996 and Name is either "jill" or "jack"
filter(baby.names, Year == 1996 & (Name == "jill" | Name == "jack"))
```

In the previous example we used `==` to filter rows. Other relational
and logical operators are listed below.

 | Operator  | Meaning                   | 
 | ----------| --------------------------| 
 | `==`      | equal to                  | 
 | `!=`      | not equal to              | 
 | `>`       | greater than              | 
 | `>=`      | greater than or equal to  | 
 | `<`       | less than                 | 
 | `<=`      | less than or equal to     | 
 | `%in%`    | contained in              | 

These operators may be combined with `&` (and) or `|` (or).


Exercise 2: Data Extraction
-----------------------------

Read in the "babyNames.csv" file if you have not already done so,
assigning the result to `baby.names`. The file is located at "http://tutorials.iq.harvard.edu/R/Rintro/dataSets/babyNames.csv"

1.  Extract data for the name "ashley".  

```r
##
```

2.  Arrange the "ashley" data you produced above by `Count`. In which year was Ashley most popular?

3.  Restrict the previous extraction to include only years between 2000 and 2004.

```r
##
```


Exercise 2 solution<span class="tag" data-tag-name="prototype"></span>
----------------------------------------------------------------------



Adding, removing, and modifying data.frame columns
--------------------------------------------------

You can modify data.frames using `mutate` function. It works like this:


```r
baby.names <- mutate(baby.names, Thousands = Count/1000)
baby.names
```

Often one needs to replace values conditionally, as in the following example:


```r
baby.names <- mutate(baby.names,
                     Decade = case_when(Year < 2000 ~ "1990's",
                                        Year < 2010 ~ "2000's",
                                        Year < 2020 ~ "2010's"))

head(baby.names)
tail(baby.names)
```

Operating by group
---------------------
It is often useful to perform operations on each group defined by one or more grouping variables. For example, if we wish to compare name popularity over time we may wish to compute the proportion of boys and girls given each name in each year. Using proportions instead of counts as a measure of popularity has the advantage of being independent of the number of children born in a particular year.

The `dplyr` package makes it relatively easy to compute the proportion of boys and girls given each name in a particular year:


```r
baby.names <- mutate(group_by(baby.names, Year, Sex),
                     Proportion = Count/sum(Count))
```

Note that the data remains grouped until you change the groups by
running `group_by` again or remove grouping information with
`ungroup`.

Exercise 3: Data manipulation
-----------------------------

Read in the "babyNames.csv" file if you have not already done so,
assigning the result to `baby.names`. The file is located at "http://tutorials.iq.harvard.edu/R/Rintro/dataSets/babyNames.csv"

1.  If you look at `unique(baby.names$Sex)` you'll notice that some
    records indicate Male with `"M"`, while other records use
    `"Male"`. Correct this by replacing `"M"` with `"Male"`.

```r
##
```

2.  Use `mutate` and `group_by` to create a column named "Proportion". Note that this step is exactly the same as shown in the demonstration. You can copy/paste that code if you like.

```r
##
```

3.  Create a column named "Popular" containing `TRUE` in rows where "Proportion" is greater than 0.02 and a `FALSE` otherwise.


```r
##
```

4.  Filter the baby names data to display only the popular names.

```r
##
```


Exercise 3 solution<span class="tag" data-tag-name="prototype"></span>
----------------------------------------------------------------------



Grouping and Aggregation
--------------------------

So far we've seen that "Jacob" and "Michael" tend to be
popular names. That isn't very satisfying, because it leaves us
wanting to know which girls names are popular, and perhaps how
popularity has changed over time. To answer these questions we again
need to operate on groups within the data rather than on the whole data
structure at once. 

Grouping can be useful when modifying a data.frame with `mutate` or
extracting subsets with `filter`, but it really shines when combined
with `summarize`. For example, we can find the most popular names of
each decade using `group_by`, `summarize`, and `filter`:


```r
bn.by.decade <- summarize(group_by(baby.names, Decade, Sex, Name),
                          Count = sum(Count))

filter(group_by(bn.by.decade, Decade, Sex),
                     Count == max(Count))
```

In the previous example we used `sum` and `max`, two examples of basic statistics functions in R. Other basic statistics functions include:
-   `mean`
-   `median`
-   `sd`
-   `var`
-   `min`
-   `quantile`
-   `length`

Exporting Data
--------------

Now that we have made some changes to our data set, we might want to
save those changes to a file.


```r
# write data to a .csv file
write_csv(baby.names, "babyNames.csv")

# write data to an R file
write_rds(baby.names, "babyNames.rds")
```

Saving and loading R workspaces
-------------------------------

In addition to importing individual datasets, R can save and load entire
workspaces


```r
ls() # list objects in our workspace
save.image(file="myWorkspace.RData") # save workspace 
rm(list=ls()) # remove all objects from our workspace 
ls() # list stored objects to make sure they are deleted

## Load the "myWorkspace.RData" file and check that it is restored
load("myWorkspace.RData") # load myWorkspace.RData
ls() # list objects
```

Exercise 4
----------

1.  Calculate the total number of children born.


2.  Calculate the number of boys and girls born each year. Assign the result
    to the name `births.by.year`.

```r
##
```

3.  How many children were born in 2004?

```r
##
```
Exercise 4 solution<span class="tag" data-tag-name="prototype"></span>
----------------------------------------------------------------------



Basic graphs
============

R has decent plotting tools built-in -- see e.g., `help(plot)`.
However, To make things easier on ourselves we will use a *contributed
package* called `ggplot2` instead.



```r
## install.packages("ggplot2")
library(ggplot2)
```

First, we'll plot the number of boys and girls born each year.

```r
qplot(Year, Count, color = Sex,
     geom = "line",
     data = births.by.year)
```

Next, we'll filter out the most popular girls names and plot their
popularity over time.


```r
popular.girls <- filter(group_by(baby.names, Year, Sex),
                       Sex == "Female" & Proportion == max(Proportion))

qplot(Year, Proportion, color = Name,
     geom = "line",
     data = filter(baby.names,
                   Sex == "Female" & Name %in% popular.girls$Name))
```

Exercise 5: Popularity of the most popular names
----------

In this exercise we will plot trends in the proportion of boys and girls given the most popular name each year.

1.  Filter the baby.names data, retaining only the most popular girl
    and boy names for each year.


```r
##
```

2.  Plot proportion over time to see changes in the proportion of
    parents choosing the most popular name of the year.


```r
##
```

Exercise 5 solution<span class="tag" data-tag-name="prototype"></span>
----------------------------------------------------------------------



Wrap-up
=======

Help us make this workshop better!
----------------------------------

Please take a moment to fill out a very short feedback form. These
workshops exist for you -- tell us what you need!
<http://tinyurl.com/R-intro-feedback>

Additional resources
--------------------

-   IQSS workshops:
    <http://projects.iq.harvard.edu/rtc/filter_by/workshops>
-   IQSS statistical consulting: <http://dss.iq.harvard.edu>
-   Software (all free!):
    -   R and R package download: <http://cran.r-project.org>
    -   Rstudio download: <http://rstudio.org>
    -   ESS (emacs R package): <http://ess.r-project.org/>
-   Online tutorials
    -   <http://www.codeschool.com/courses/try-r>
    -   <http://www.datacamp.org>
    -   <http://swirlstats.com/>
    -   <http://r4ds.had.co.nz/>
-   Getting help:
    -   Documentation and tutorials:
        <http://cran.r-project.org/other-docs.html>
    -   Recommended R packages by topic:
        <http://cran.r-project.org/web/views/>
    -   Mailing list: <https://stat.ethz.ch/mailman/listinfo/r-help>
    -   StackOverflow: <http://stackoverflow.com/questions/tagged/r>
-   Coming from...
    Stata
    :   <http://www.princeton.edu/~otorres/RStata.pdf>
    SAS/SPSS
    :   <http://www.et.bs.ehu.es/~etptupaf/pub/R/RforSAS&SPSSusers.pdf>
   matlab
   :   <http://www.math.umaine.edu/~hiebeler/comp/matlabR.pdf>
    Python
    :   <http://mathesaurus.sourceforge.net/matlab-python-xref.pdf>
