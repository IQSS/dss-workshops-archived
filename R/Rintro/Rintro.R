##                           ━━━━━━━━━━━━━━━━━━━
##                            INTRODUCTION TO R

##                                Ista Zahn
##                           ━━━━━━━━━━━━━━━━━━━

## Table of Contents
## ─────────────────

## Workshop Materials and Introduction
## Graphical User Interfaces (GUIs)
## Data and Functions
## Asking R for help
## R packages
## Getting data into R
## Data Manipulation
## Basic Statistics and Graphs
## Wrap-up

## Workshop Materials and Introduction
## ═══════════════════════════════════

## Materials and setup
## ───────────────────

##   You should have R installed –if not:
##   • Open a web browser and go to [http://cran.r-project.org] and
##     download and install it
##   • Also helpful to install RStudio (download from [http://rstudio.com])

##   Download workshop materials:
##   • Download materials from
##     [http://tutorials.iq.harvard.edu/R/Rintro.zip]
##   • Extract the zip file containing the materials to your desktop

## What is R?
## ──────────

##   R is a /programming language designed for statistical computing/.
##   Notable characteristics include:
##   • Vast capabilities, wide range of statistical and graphical
##     techniques
##   • Very popular in academia, growing popularity in business:
##     [http://r4stats.com/articles/popularity/]
##   • Written primarily by statisticians
##   • FREE (no cost, open source)
##   • Excellent community support: mailing list, blogs, tutorials
##   • Easy to extend by writing new functions

## InspiRation
## ───────────

##   OK, it's free and popular, but what makes R worth learning? In a word,
##   "packages". If you have a data manipulation, analysis or visualization
##   task, chances are good that there is an R package for that. For
##   example:

##   • Want to find out where we are?
##   ┌────
##   │ library(ggmap)
##   │ nwbuilding <- geocode("1737 Cambridge Street Cambridge, MA 02138", source = "google") 
##   │ ggmap(get_map("Cambridge, MA", zoom = 15)) +
##   │   geom_point(data=nwbuilding, size = 7, shape = 13, color = "red")
##   └────

##   [file:images/hereweare.png]

##   • Want to forecast the population of Australia?
##   ┌────
##   │ library(forecast)
##   │ fit <- auto.arima(austres)
##   │ ## Projected numbers (in thousands) of Australian residents
##   │ plot(forecast(fit))
##   └────

##   • Want to interactively explore the shape of the Churyumov–Gerasimenko
##     comet?
##   ┌────
##   │ library(plotly)
##   │ comet <- rgl::readOBJ(url("http://sci.esa.int/science-e/www/object/doc.cfm?fobjectid=54726"))
##   │ 
##   │ comet.plot <- plot_ly(x = comet$vb[1,],
##   │                       y = comet$vb[2,],
##   │                       z = comet$vb[3,],
##   │                       i = comet$it[1,]-1,
##   │                       j= comet$it[2,]-1,
##   │                       k = comet$it[3,]-1,
##   │                       type = "mesh3d")
##   │ 
##   │ setwd("images")
##   │ htmlwidgets::saveWidget(comet.plot, file = "comet.html")
##   │ setwd("..")
##   │ 
##   │ comet.plot
##   └────

##   Whatever you're trying to do, you're probably not the first to try
##   doing it R. Chances are good that someone has already written a
##   package for that.

## Coming to R
## ───────────

##   Coming from…
##   Stata: [http://www.princeton.edu/~otorres/RStata.pdf]
##   SAS/SPSS: [http://www.et.bs.ehu.es/~etptupaf/pub/R/RforSAS&SPSSusers.pdf]
##   matlab: [http://www.math.umaine.edu/~hiebeler/comp/matlabR.pdf]
##   Python: [http://mathesaurus.sourceforge.net/matlab-python-xref.pdf]

## Graphical User Interfaces (GUIs)
## ════════════════════════════════

## R GUI alternatives
## ──────────────────

##   The old-school way is to run R directly in a terminal

##   [file:images/Rconsole.png]

##   But hardly anybody does it that way anymore! The Windows version of R
##   comes with a GUI that looks like this:

##   [file:images/Rgui.png]

##   The default windows GUI is not very good
##   • No parentheses matching or syntax highlighting
##   • No work-space browser

##   RStudio (an alternative GUI for R) is shown below.
##   [file:images/Rstudio.png]

##   Rstudio has many useful features, including parentheses matching and
##   auto-completion. Rstudio is not the only advanced R interface; other
##   alteratives include Emacs with ESS (shown below).

##   [file:images/emacs.png]

##   Emacs + ESS is a very powerful combination, but can be difficult to
##   set up.

##   [file:images/Jupyter.png]

##   Jupyter is a notebook interface that runs in your web browser. A lot
##   of people like it. You can access these workshop notes as a Jupyter
##   notebook at
##   [http://tutorials-live.iq.harvard.edu:8000/notebooks/workshops/R/Rintro/Rintro.ipynb]

## Launch RStudio                                                :labsetup:
## ──────────────

##   • Open the RStudio program
##   • Open up today's R script
##     • In RStudio, Go to *File => Open Script*
##     • Locate and open the `Rintro.R' script in the Rintro folder on your
##       desktop
##   • Go to *Tools => Set working directory => To source file location*
##     (more on the working directory later)
##   • I encourage you to add your own notes to this file! Every line that
##     starts with `#' is a comment that will be ignored by R. My comments
##     all start with `##'; you can add your own, possibly using `#' or
##     `###' to distinguish your comments from mine.

## Exercise 0
## ──────────

##   The purpose of this exercise is mostly to give you an opportunity to
##   explore the interface provided by RStudio (or whichever GUI you've
##   decided to use). You may not know how to do these things; that's fine!
##   This is an opportunity to learn. If you don't know how to do something
##   you can can use internet search engines, search on [StackOverflow], or
##   ask the person next to you.

##   Also keep in mind that we are living in a golden age of tab
##   completion. If you don't know the name of an R function, try guessing
##   the first two or three letters and pressing TAB. If you guessed
##   correctly the function you are looking for should appear in a pop up!

##   1. Try to get R to add 2 plus 2.
##   2. Try to calculate the square root of 10.
##   3. There is an R package named `car' (Companion to Applied
##      Regression). Try to install this package.
##   4. R includes extensive documentation, including a file named "An
##      introduction to R". Try to find this help file.
##   5. Open a web browser, go to [http://cran.r-project.org/web/views/]
##      and skim the topic closest to your field/interests.

## [StackOverflow] http:stackoverflow.com

## Data and Functions
## ══════════════════

## Assignment
## ──────────

##   Values can be assigned names and used in subsequent operations
##   • The `<-' operator (less than followed by a dash) is used to save
##     values
##   • The name on the left gets the value on the right.

x <- 10 # Assign the value 10 to a variable named x
x + 1 # Add 1 to x
x # note that x is unchanged
y <- x + 1 # Assign y the value x + 1
y
x <- x + 100 # change the value of x
y ## note that y is unchanged.

##   Saved variables can be listed, overwritten and deleted
ls() # List variables in workspace
x # Print the value of x
x <- 100 # Overwrite x. Note that no warning is given!
x
rm(x) # Delete x
ls()

## Data types and conversion
## ─────────────────────────

##   The `x' and `y' data objects we created are numeric /vectors/ of
##   length one. Vectors are the simplest data structure in R, and are the
##   building blocks used to make more complex data structures. Here are
##   some more vector examples.

x <- c(10, 11, 12)
X <- c("10", "11", "12")
y <- c("h", "e", "l", "l", "o")
Y <- "hello"
z <- c(1, 0, 1, 1)
Z <- c(TRUE, FALSE, TRUE, TRUE)

##   Notice that the `c' function combines its arguments into a vector.

##   All R objects have a /mode/ and /length/. Since it is impossible for
##   an object not to have these attributes they are called /intrinsic
##   attributes/.
print(x)
mode(x)
length(x)

print(X)
mode(X)
length(X)

length(y)
length(Y)

mode(z)
mode(Z)

##   Data structures in R can be converted from one type to another using
##   one of the many functions beginning with `as.'. For example:
mode(x)
mode(as.character(x))
mode(X)
mode(as.numeric(X))

## Functions
## ─────────

##   Using R is mostly about applying *functions* to *variables*. Functions
##   • take *variable(s)* as input *argument(s)*
##   • perform operations
##   • *return* values which can be *assigned*
##   • optionally perform side-effects such as writing a file to disk or
##     opening a graphics window

##   The general form for calling R functions is
## FunctionName(arg.1, arg.2, ..., arg.n)

##   Arguments can be matched by position or name

##   Examples:
  #?sqrt
  a <- sqrt(z) # Call the sqrt function with argument x=z

## look at the arguments to the round function
  args(round) # use ?round if you need more information

  round(a, digits = 2) # Call round() with arguments x=x and digits=2

  ## since matching by name takes precedence these are all equivalent:
  round(a, 2)
  round(x = a, 2)
  round(digits = 2, x = a)

  ## the only way we can go wrong is by omiting the names and mixing up the order
  round(2, x)

  # Functions can be nested so an alternative is
  round(sqrt(z), digits = 2) # Take sqrt of a and round

## Asking R for help
## ═════════════════

##   R has extensive built-in documentation that can be accessed through R
##   commands or through the GUI.

## Start html help, search/browse using web browser
help.start() # or use the help menu from you GUI
## Look up the documentation for a function
help(plot) ## or use the shortcut: ?plot
## Look up documentation for a package
help(package="stats")
## Search documentation from R (not always the best way... google often works better)
help.search("classification")

## R packages
## ══════════

##   There are thousands of R packages that extend R's capabilities. Some
##   packages are distributed with R, and some of these are attached to the
##   search path by default. Many more are available in package
##   repositories.

##To see what packages are loaded: 
search()

## To view available packages: 
library()

## To load a package: 
library("MASS")

## Install new package: 
install.packages("stringdist")

##   In this workshop we will use the /tidyverse/ package. /tidyverse/ is a
##   meta package that loads the /dplyr/ package for easier data
##   manipulation the /readr/ package for easier data import/export, and
##   several other useful packages.

## Exercise 1
## ──────────

##   The purpose of this exercise is to practice using the package
##   management and help facilities.

##   1. Use the `search' function to inspect the current search path.
##      Assign the result to the name `orig.search.path'.
##   2. What are the `mode' and `length' of `orig.search.path'?
##   3. Install the /tidyverse/ package. Compare the output of `search()'
##      to the value you've saved in `orig.search.path'. Has it changed?
##   4. Use the `library' function to attach the /tidyverse/ package.
##      Compare the output of `search()' to the value you've saved in
##      `orig.search.path'. Has it changed?
##   5. Look up the help page for the /readr/ package. Which function would
##      you use to read a tab delimited file?

## Getting data into R
## ═══════════════════

## The baby names data set
## ───────────────────────

##   The examples in this workshop use the baby names data provided by the
##   governments of the United States and the United Kingdom. A cleaned and
##   merged version of these data is in `dataSets/babyNames.csv'.

## The "working directory" and listing files
## ─────────────────────────────────────────

##   R knows the directory it was started in, and refers to this as the
##   "working directory". Since our workshop examples are in the Rintro
##   folder in your Downloads folder, we should all take a moment to set
##   that as our working directory.

getwd() # what is my current working directory?
# setwd("~/Desktop/Rintro") # change directory

##   Note that "`~'" means "my home directory" but that this can mean
##   different things on different operating systems. You can also use the
##   Files tab in Rstudio to navigate to a directory, then click "More ->
##   Set as working directory".

##   We can a set the working directory using paths relative to the current
##   working directory. Once we are in the "Rintro" folder we can navigate
##   to the "dataSets" folder like this:

getwd() # get the current working directory
setwd("dataSets") # set wd to the dataSets folder
getwd()
setwd("..") # set wd to enclosing folder ("up")

##   It can be convenient to list files in a directory without leaving R
list.files("dataSets") # list files in the dataSets folder

## Readers for common file types
## ─────────────────────────────

##   In order to read data from a file, you have to know what kind of file
##   it is. The table below lists the functions that can import data from
##   common file formats.

##   ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
##    data type                function      package                                             
##   ────────────────────────────────────────────────────────────────────────────────────────────
##    comma separated (.csv)   read_csv()    readr (tidyverse)                                   
##    other delimited formats  read_delim()  readr (tidyverse)                                   
##    R (.Rds)                 read_rds()    readr (tidyverse)                                   
##    Stata (.dta)             read_stata()  haven (tidyverse, needs to be attached separately)  
##    SPSS (.sav)              read_spss()   haven (tidyverse, needs to be attached separately)  
##    SAS (.sas7bdat)          read_sas()    haven (tidyverse, needs to be attached separately)  
##    Excel (.xls, .xlsx)      read_excel    readxl (tidyverse, needs to be attached separately) 
##   ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

## Exercise 2
## ──────────

##   The purpose of this exercise is to practice reading data into R. The
##   data in "`dataSets/babyNames.csv'" is moderately tricky to read,
##   making it a good data set to practice on.

##   1. Open the help page for the `read_csv' function. How can you limit
##      the number of rows to be read in?
##   2. Read just the first 10 rows of "`dataSets/babyNames.csv'". Notice
##      that the "Sex" column has been read as a logical (TRUE/FALSE).
##   3. Read the `read_csv' help page to figure out how to make it read the
##      "Sex" column as a character. Make adjustments to your code until
##      you have read in the first 10 rows with the correct column types.
##      "Year" and "Name.length" should be integer (int), "Count" and
##      "Percent" should be double (dbl) and everything else should be
##      character (chr).
##   4. Once you have successfully read in the first 10 rows, read the
##      whole file, assigning the result to the name `baby.names'.

## Checking imported data
## ──────────────────────

##   It is always a good idea to examine the imported data set–usually we
##   want the results to be a `data.frame'
## we know that this object will have mode and length, because all R objects do.
mode(baby.names)
length(baby.names) # number of columns

## additional information about this data object
class(baby.names) # check to see that test is a data.frame
dim(baby.names) # how many rows and columns?
names(baby.names) # or colnames(baby.names)
str(baby.names) # more details
glimpse(baby.names) # details, more compactly

## Data Manipulation
## ═════════════════

## data.frame objects
## ──────────────────

##   Usually data read into R will be stored as a *data.frame*

##   • A data.frame is a list of vectors of equal length
##     • Each vector in the list forms a column
##     • Each column can be a differnt type of vector
##     • Typically columns are variables and the rows are observations

##   A data.frame has two dimensions corresponding the number of rows and
##   the number of columns (in that order)

## Slice and Filter data.frames rows
## ─────────────────────────────────

##   You can extract subsets of data.frames using `slice' to select rows by
##   number and `filter' to select rows that match some condition. It works
##   like this:

## make up some example data
(example.df <- data.frame(id  = rep(letters[1:4], each = 4),
                          t   = rep(1:4, times = 4),
                          var1 = runif(16),
                          var2 = sample(letters[1:3], 16, replace = TRUE)))

## rows 2 and 4
slice(example.df, c(2, 4))

## rows where id == "a"
filter(example.df, id == "a")

## rows where id is either "a" or "b"
filter(example.df, id %in% c("a", "b"))

## Select data.frame columns
## ─────────────────────────

##   `slice' and `filter' are used to extract rows. `select' is used to
##   extract columns
select(example.df, id, var1)
select(example.df, id, t, var1)

##   You can also conveniently select a single column using `$', like this:
example.df$t

##   Data manipulation commands can be combined:

filter(select(example.df,
              id,
              var1),
       id == "a")

##   In the previous example we used == to filter rows where id was "a".
##   Other relational and logical operators are listed below.

##   ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
##    Operator  Meaning                  
##   ────────────────────────────────────
##    ==        equal to                 
##    !=        not equal to             
##    >         greater than             
##    >=        greater than or equal to 
##    <         less than                
##    <=        less than or equal to    
##    %in%      contained in             
##    &         and                      
##    |         or                       
##   ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

## Adding, removing, and modifying data.frame columns
## ──────────────────────────────────────────────────

##   You can modify data.frames using the `mutate()' function. It works
##   like this:

example.df

## modify example.df and assign the modified data.frame the name example.df
example.df <- mutate(example.df,
       var2 = var1/t, # replace the values in var2
       var3 = 1:length(t), # create a new column named var3
       var4 = factor(letters[t]),
       t = NULL # delete the column named t
       )

## examine our changes
example.df

## Exporting Data
## ──────────────

##   Now that we have made some changes to our data set, we might want to
##   save those changes to a file.
# write data to a .csv file
write_csv(example.df, path = "example.csv")

# write data to an R file
write_rds(example.df, path = "example.rds")

# write data to a Stata file
library(haven)
write_dta(example.df, path = "example.dta")

## Saving and loading R  workspaces
## ────────────────────────────────

##   In addition to importing individual datasets, R can save and load
##   entire workspaces
ls() # list objects in our workspace
save.image(file="myWorkspace.RData") # save workspace 
rm(list=ls()) # remove all objects from our workspace 
ls() # list stored objects to make sure they are deleted

##   Load the "myWorkspace.RData" file and check that it is restored

load("myWorkspace.RData") # load myWorkspace.RData
ls() # list objects

## Exercise 3: Data manipulation
## ─────────────────────────────

##   Read in the "babyNames.csv" file if you have not already done so,
##   assigning the result to `baby.names'.

##   1. Filter `baby.names' to show only names given to at least 3 percent
##      of boys.
##   2. Create a column named "Proportion" equal to Percent divided by 100.
##   3. Filter `baby.names' to include only names given to at least 3
##      percent of Girls. Save this to a Stata data set named
##      "popularGirlNames.dta")

## Basic Statistics and Graphs
## ═══════════════════════════

## Basic statistics
## ────────────────

##   Descriptive statistics of single variables are straightforward:
sum(example.df$var1) # calculate sum of var 1
mean(example.df$var1)
median(example.df$var1)
sd(example.df$var1) # calculate standard deviation of var1
var(example.df$var1)

## summaries of individual columns
summary(example.df$var1)
summary(example.df$var2)

## summary of whole data.frame
summary(example.df)

##   Some of these functions (e.g., summary) will also work with
##   data.frames and other types of objects, others (such as `sd') will
##   not.

## Statistics by grouping variable(s)
## ──────────────────────────────────

##   The `summarize' function can be used to calculate statistics by
##   grouping variable. Here is how it works.

summarize(group_by(example.df, id), mean(var1), sd(var1))

##   You can group by multiple variables:

summarize(group_by(example.df, id, var3), mean(var1), sd(var1))

##   #+END_SRC

## Save R output to a file
## ───────────────────────

##   Earlier we learned how to write a data set to a file. But what if we
##   want to write something that isn't in a nice rectangular format, like
##   the output of `summary'? For that we can use the `sink()' function:

sink(file="output.txt", split=TRUE) # start logging
print("This is the summary of example.df \n")
print(summary(example.df))
sink() ## sink with no arguments turns logging off

## Exercise 4
## ──────────

##   1. Calculate the total number of children born.
##   2. Filter the data to extract only Massachusetts (Location "MA"), and
##      calculate the total number of children born in Massachusetts.
##   3. Group and summarize the data to calculate the number of children
##      born each year.
##   4. Calculate the average number of characters in baby names (using the
##      "Name.length" column).
##   5. Group and summarize to calculate the average number of characters
##      in baby names for each location.

## Basic graphics: Frequency bars
## ──────────────────────────────

##   Thanks to classes and methods, you can `plot()' many kinds of objects:

plot(example.df$var4)

##   [file:images/examplePlot1.png]

## Basic graphics: Boxplots by group
## ─────────────────────────────────

##   Thanks to classes and methods, you can `plot()' many kinds of objects:
plot(select(example.df, id, var1))

##   [file:images/examplePlot2.png]

## Basic graphics: Mosaic chart
## ────────────────────────────

##   Thanks to classes and methods, you can `plot()' many kinds of objects:
plot(select(example.df, id, var4))

##   [file:images/examplePlot3.png]

## Basic graphics: scatter plot
## ────────────────────────────

plot(select(example.df, var1, var2))

##   [file:images/examplePlot4.png]

## Exercise 5 TBD
## ──────────────

## Wrap-up
## ═══════

## Help us make this workshop better!
## ──────────────────────────────────

##   • Please take a moment to fill out a very short feedback form
##   • These workshops exist for you – tell us what you need!
##   • [http://tinyurl.com/R-intro-feedback]

## Additional resources
## ────────────────────

##   • IQSS workshops:
##     [http://projects.iq.harvard.edu/rtc/filter_by/workshops]
##   • IQSS statistical consulting: [http://dss.iq.harvard.edu]
##   • Software (all free!):
##     • R and R package download: [http://cran.r-project.org]
##     • Rstudio download: [http://rstudio.org]
##     • ESS (emacs R package): [http://ess.r-project.org/]
##   • Online tutorials
##     • [http://www.codeschool.com/courses/try-r]
##     • [http://www.datacamp.org]
##     • [http://swirlstats.com/]
##     • [http://r4ds.had.co.nz/]
##   • Getting help:
##     • Documentation and tutorials:
##       [http://cran.r-project.org/other-docs.html]
##     • Recommended R packages by topic:
##       [http://cran.r-project.org/web/views/]
##     • Mailing list: [https://stat.ethz.ch/mailman/listinfo/r-help]
##     • StackOverflow: [http://stackoverflow.com/questions/tagged/r]
