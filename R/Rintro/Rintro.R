#' ---
#' title: "Introduction to R workshop notes"
#' output: 
#'   html_document:
#'     highlight: tango
#'     toc: true
#'     toc_float:
#'       collapsed: true
#' ---
#' 
#' 
#' Materials and setup 
#' -------------------
#' 
#' **NOTE: skip this section if you are not running R locally** (e.g., if you are
#' running R in your browser using a remote Jupyter server)
#' 
#' You should have R installed --if not:
#' 
#' -   Open a web browser and go to <http://cran.r-project.org> and
#'     download and install it
#' -   Also helpful to install RStudio (download from <http://rstudio.com>)
#' 
#' Download workshop materials:
#' 
#' -   Download materials from
#'     <http://tutorials.iq.harvard.edu/R/Rintro.zip>
#' -   Extract the zip file containing the materials to your desktop
#' 
#' What is R?
#' ----------
#' 
#' R is a *programming language designed for statistical computing*.
#' Notable characteristics include:
#' 
#' -   Vast capabilities, wide range of statistical and graphical
#'     techniques
#' -   Very popular in academia, growing popularity in business:
#'     <http://r4stats.com/articles/popularity/>
#' -   Written primarily by statisticians
#' -   FREE (no cost, open source)
#' -   Excellent community support: mailing list, blogs, tutorials
#' -   Easy to extend by writing new functions
#' 
#' 
#' InspiRation
#' -----------
#' 
#' OK, it's free and popular, but what makes R worth learning? In a word,
#' "packages". If you have a data manipulation, analysis or visualization task,
#' chances are good that there is an R package for that. Lets install some packages
#' and look at some examples.

install.packages(c("ggmap", "plotly", "rgl", "forecast"))

#' 
#' ### Where are we? ###
#' 
## ------------------------------------------------------------------------
library(ggmap)
nwbuilding <- geocode("1737 Cambridge Street Cambridge, MA 02138", source = "google") 
ggmap(get_map("Cambridge, MA", zoom = 15)) +
  geom_point(data=nwbuilding, size = 7, shape = 13, color = "red")

#' 
#' ### What will world population be in 2020? ###
#' 

library(forecast)
library(plotly)

## from https://esa.un.org/unpd/wpp/Download/Standard/Population/
worldpop <- structure(c(2.525149312, 2.571867515, 2.617940399, 2.66402901,
2.710677773, 2.758314525, 2.807246148, 2.85766291, 2.909651396,
2.963216053, 3.018343828, 3.075073173, 3.133554362, 3.194075347,
3.256988501, 3.322495121, 3.390685523, 3.461343172, 3.533966901,
3.607865513, 3.682487691, 3.757734668, 3.833594894, 3.90972212,
3.985733775, 4.061399228, 4.13654207, 4.211322427, 4.286282447,
4.362189531, 4.439632465, 4.518602042, 4.599003374, 4.681210508,
4.765657562, 4.852540569, 4.942056118, 5.033804944, 5.126632694,
5.218978019, 5.309667699, 5.398328753, 5.485115276, 5.57004538,
5.653315893, 5.735123084, 5.815392305, 5.894155105, 5.971882825,
6.049205203, 6.126622121, 6.204310739, 6.282301767, 6.360764684,
6.439842408, 6.51963585, 6.600220247, 6.68160732, 6.763732879,
6.846479521, 6.92972504300001, 7.013427052, 7.097500453, 7.181715139,
7.265785946, 7.349472099), .Tsp = c(1950, 2015, 1), class = "ts")

## Projected numbers (in billions) of humans living on earth
fit <- auto.arima(worldpop)
ggplotly(autoplot(forecast(fit)))

#' 
#' -   Want to interactively explore the shape of the Churyumov–Gerasimenko
#'     comet?
#' 
comet <- rgl::readOBJ(url("http://sci.esa.int/science-e/www/object/doc.cfm?fobjectid=54726"))
plot_ly(x = comet$vb[1,],
        y = comet$vb[2,],
        z = comet$vb[3,],
        i = comet$it[1,]-1,
        j= comet$it[2,]-1,
        k = comet$it[3,]-1,
        type = "mesh3d")

#' 
#' Whatever you're trying to do, you're probably not the first to try doing
#' it R. Chances are good that someone has already written a package for
#' that.
#' 
#' Coming to R
#' -----------
#' 
#' Coming from...
#' 
#' Stata
#' :   <http://www.princeton.edu/~otorres/RStata.pdf>
#' 
#' SAS/SPSS
#' :   <http://www.et.bs.ehu.es/~etptupaf/pub/R/RforSAS&SPSSusers.pdf>
#' 
#' matlab
#' :   <http://www.math.umaine.edu/~hiebeler/comp/matlabR.pdf>
#' 
#' Python
#' :   <http://mathesaurus.sourceforge.net/matlab-python-xref.pdf>
#' 
#' Graphical User Interfaces (GUIs)
#' ================================
#' 
#' R GUI alternatives
#' ------------------
#' 
#' The old-school way is to run R directly in a terminal
#' 
#' ![](images/Rconsole.png)
#' 
#' But hardly anybody does it that way anymore! The Windows version of R
#' comes with a GUI that looks like this:
#' 
#' ![](images/Rgui.png)
#' 
#' The default windows GUI is not very good
#' 
#' -   No parentheses matching or syntax highlighting
#' -   No work-space browser
#' 
#' RStudio (an alternative GUI for R) is shown below.
#' 
#' ![](images/Rstudio.png)
#' 
#' Rstudio has many useful features, including parentheses matching and
#' auto-completion. Rstudio is not the only advanced R interface; other
#' alteratives include Emacs with ESS (shown below).
#' 
#' ![](images/emacs.png)
#' 
#' Emacs + ESS is a very powerful combination, but can be difficult to set
#' up.
#' 
#' ![](images/Jupyter.png)
#' 
#' Jupyter is a notebook interface that runs in your web browser. A lot of
#' people like it. You can access these workshop notes as a Jupyter
#' notebook at
#' <http://tutorials-live.iq.harvard.edu:8000/notebooks/workshops/R/Rintro/Rintro.ipynb>
#' 
#' Launch RStudio (skip if not using Rstudio)
#' ----------------------------------------------------------------
#' **Note: skip this section if you are not using Rstudio (e.g., if you are running
#' these examples in a Jupyter notebook).**
#' 
#' 
#' -   Open the RStudio program
#' -   Open up today's R script
#'     -   In RStudio, Go to **File =&gt; Open Script**
#'     -   Locate and open the `Rintro.R` script in the Rintro folder on
#'         your desktop
#' -   Go to **Tools =&gt; Set working directory =&gt; To source file
#'     location** (more on the working directory later)
#' -   I encourage you to add your own notes to this file! Every line that
#'     starts with `#` is a comment that will be ignored by R. My comments
#'     all start with `##`; you can add your own, possibly using `#` or
#'     `###` to distinguish your comments from mine.
#' 
#' Now that we know what we're getting into and have our environment set up, let's
#' get to work.
#' 
#' 
#' Exercise 0
#' ----------
#' 
#' The purpose of this exercise is mostly to give you an opportunity to
#' explore the interface provided by RStudio (or whichever GUI you've
#' decided to use). You may not know how to do these things; that's fine!
#' This is an opportunity to learn. If you don't know how to do something
#' you can can use internet search engines, search on
#' [StackOverflow](http:stackoverflow.com), or ask the person next to you.
#' 
#' Also keep in mind that we are living in a golden age of tab completion.
#' If you don't know the name of an R function, try guessing the first two
#' or three letters and pressing TAB. If you guessed correctly the function
#' you are looking for should appear in a pop up!
#' 
#' 1.  Try to get R to add 2 plus 2.
#' 2.  Try to calculate the square root of 10.
#' 3.  There is an R package named `car`. Try to install this package.
#' 4.  R includes extensive documentation, including a file named "An
#'     introduction to R". Try to find this help file.
#' 5.  Open a new web browser or tab, go to <http://cran.r-project.org/web/views/> and
#'     skim the topic closest to your field/interests.
#' 
#' 
#' Example project overview: baby names!
#' ------------------------
#' 
#' I would like to know what the most popular baby names are. In the course of
#' answering this question we will learn to call R functions, install and load
#' packages, assign values to names, read and write data, and more. 
#' 
#' The examples in this workshop use the baby names data provided by the
#' governments of the United States and the United Kingdom. A cleaned and
#' merged version of these data is in `dataSets/babyNames.csv`.
#' 
#' Our first goal is to read these data into R. In order to do that we need to
#' learn how to *call functions*, *install packages*, set out *working directory*, *read* as `.csv`
#' file, and *assign* the result to a name. Lets get to it.
#' 
#' 
#' R installing and using packages
#' ==========
#' 
#' There are thousands of R packages that extend R's capabilities. Some
#' packages are distributed with R, and some of these are attached to the
#' search path by default. Many more are available in package repositories.
#' 
#' In order to make reading and analyzing our baby names data easier we will
#' install and use a collection of packages called `tidyverse`. *tidyverse* is a
#' meta package that loads the *dplyr* package for easier data manipulation the
#' *readr* package for easier data import/export, and several other useful
#' packages.
#' 
#' Packages can be installed using the `install.packages` function. 
#' 
#' Functions
#' ---------
#' 
#' The general form for calling R functions is
#' 

## ## FunctionName(arg.1 = value.1, arg.2 = value.2, ..., arg.n - value.n)

#' 
#' Arguments can be matched by position or name. Lets see how that works, using the
#' `install.packages` function.
#' 
#' Installing and using R packages
#' ---------------------------------------
#' 
#' Since this is the first time we are using the `install.packages` function we
#' will start by looking up its help page. This is almost always the first thing
#' you should do when using a function for the first time. You can look up the help
#' page for a function like this:
#' 

?install.packages

#' 
#' As we can see from the documentation, the first (and only required) argument is
#' named `pkgs`. Additional arguments specify where this package should be
#' installed from (`repos`) and to (`lib`) among other things.
#' 
#' OK, lets install the "car" package from the repo at
#' "https://cran.rstudio.com". 
#' 

install.packages("car", repos = "https://cran.rstudio.com")

#' 
#' **Installing a package** puts a copy of the package on your local computer, but
#' **does not make it available for use**. To use an installed package you must
#' attach it using the `library` function.
#' 
#' 
library("car")

#' 
#' Asking R for help
#' ---------------------
#' 
#' Now that we've installed the `car` package, how do we use it? We've already seen
#' that we can look up the help page using `?`. This is actually a shortcut to the
#' `help` function:
#' 

help(help)

#' 
#' The `help` function can be used to look up the documentation for a function, or
#' to look up the documentation to a package. We can learn how to use the `car`
#' package by reading its documentation like this:
#' 
## ---- eval=FALSE---------------------------------------------------------
## help(package = "car")

#' 
#' Exercise 1
#' ----------
#' 
#' The purpose of this exercise is to practice using the package management
#' and help facilities.
#' 
#' 1.  Install the `tidyverse` package.
#' 2.  Use the `library` function to attach the `tidyverse` package.
#' 3.  Look up the help page for the *readr* package (*readr* is attached by the
#'     *tidyverse* package). Which function would you use to read a comma separated
#'     values (`.csv`) file? 
#' 
#' Now that we have installed and attached the `tidyverse` (and `readr`) packages,
#' and know which function to use to read our data (`read_csv`) we are almost ready
#' to read in the baby names data. Before we do that lets take a small excision to
#' learn about assignment and basic data types in R.
#' 
#' Data types and assignment
#' ==================
#' 
#' Assignment
#' ----------
#' 
#' Values can be assigned names and used in subsequent operations
#' 
#' -   The `<-` operator (less than followed by a dash) is used to save
#'     values
#' -   The name on the left gets the value on the right.
#' 

x <- 10 # Assign the value 10 to a variable named x
x + 1 # Add 1 to x

#' 

x # note that x is unchanged

#' 

y <- x + 1 # Assign y the value x + 1
y

#' 

x <- x + 100 # change the value of x
y ## note that y is unchanged.

#' 
#' Data types and conversion
#' -------------------------
#' 
#' The `x` and `y` data objects we created are numeric *vectors* of length
#' one. Vectors are the simplest data structure in R, and are the building
#' blocks used to make more complex data structures. Here are some more
#' vector examples.
#' 

x <- c(10, 11, 12)
y <- c("10", "11", "12")
z <- c(TRUE, FALSE, TRUE, TRUE)

#' 
#' Notice that the `c` function combines its arguments into a vector.
#' 
#' All R objects have a *type* (aka *mode*) and *length*. Since it is impossible
#' for an object not to have these attributes they are called *intrinsic
#' attributes*. They can be retrieved using the `typeof` and `length` functions.
#' 

c(x = x, type = typeof(x), length = length(x))

c(y = y, type = typeof(y), length = length(y))

c(z = z, type = typeof(z), length = length(z))

#' 
#' Data structures in R can be converted from one type to another using one
#' of the many functions beginning with `as.`. For example:
#' 

typeof(x)
typeof(as.character(x))

#' 

typeof(y)
typeof(as.numeric(y))

#' 
#' These vectors (*double*, *character*, *logical*) are called *atomic vectors*
#' because each element must be of the same type. Given inputs with conflicting
#' types R will convert them for you.
#' 

typeof(c(1, 2))
typeof(c(1, "2"))

#' 
#' 
#' Now that we know how to do assignment using `<-` and how to understand basic
#' data types in R we are finally ready to read in the baby names data.
#' 
#' Getting data into R
#' ===================
#' 
#' The "working directory" and listing files
#' -----------------------------------------
#' 
#' R knows the directory it was started in, and refers to this as the
#' "working directory". Since our workshop examples are in the Rintro folder, we
#' should all take a moment to set that as our working directory.
#' 
#' 
## ----eval=FALSE----------------------------------------------------------
## getwd() # what is my current working directory?
## # setwd("~/Desktop/Rintro") # change directory

#' 
#' Note that "`~`" means "my home directory" but that this can mean
#' different things on different operating systems. You can also use the
#' Files tab in Rstudio to navigate to a directory, then click "More -&gt;
#' Set as working directory".
#' 
#' We can a set the working directory using paths relative to the current
#' working directory. Once we are in the "Rintro" folder we can navigate to
#' the "dataSets" folder like this:
#' 

getwd() # get the current working directory

#' 

setwd("dataSets") # set wd to the dataSets folder
getwd()

setwd("..") # set wd to enclosing folder ("up")
getwd()

#' 
#' It can be convenient to list files in a directory without leaving R
#' 

list.files("dataSets") # list files in the dataSets folder

#' 
#' Readers for common file types
#' -----------------------------
#' 
#' In order to read data from a file, you have to know what kind of file it
#' is. The table below lists the functions that can import data from common
#' file formats.
#' 
#'   data type                 function         package
#'   ------------------------- ---------------  -----------------------------------------------------
#'   comma separated (.csv)    `read_csv()`     readr (tidyverse)
#'   other delimited formats   `read_delim()`   readr (tidyverse)
#'   R (.Rds)                  `read_rds()`     readr (tidyverse)
#'   Stata (.dta)              `read_stata()`   haven (tidyverse, needs to be attached separately)
#'   SPSS (.sav)               `read_spss()`    haven (tidyverse, needs to be attached separately)
#'   SAS (.sas7bdat)           `read_sas()`     haven (tidyverse, needs to be attached separately)
#'   Excel (.xls, .xlsx)       `read_excel()`   readxl (tidyverse, needs to be attached separately)
#' 
#' Exercise 2
#' ----------
#' 
#' The purpose of this exercise is to practice reading data into R. The
#' data in "`dataSets/babyNames.csv`" is moderately tricky to read, making
#' it a good data set to practice on.
#' 
#' 1.  Open the help page for the `read_csv` function. How can you limit
#'     the number of rows to be read in?
#' 2.  Read just the first 10 rows of "`dataSets/babyNames.csv`". Notice
#'     that the "Sex" column has been read as a logical (TRUE/FALSE).
#' 3.  Read the `read_csv` help page to figure out how to make it read the
#'     "Sex" column as a character. Make adjustments to your code until you
#'     have read in the first 10 rows with the correct column types. "Year"
#'     and "Name.length" should be integer (int), "Count" and "Percent"
#'     should be double (dbl) and everything else should be
#'     character (chr).
#' 4.  Once you have successfully read in the first 10 rows, read the whole
#'     file, assigning the result to the name `baby.names`.
#' 
#' 
#' Checking imported data
#' ----------------------
#' 
#' It is always a good idea to examine the imported data set--usually we
#' want the results to be a `data.frame`
#' 

## we know that this object will have type and length, because all R objects do.
typeof(baby.names)
length(baby.names) # number of columns

#' 

## additional information about this data object
class(baby.names) # check to see that test is a data.frame

#' 

dim(baby.names) # how many rows and columns?

#' 

names(baby.names) # or colnames(baby.names)

#' 

str(baby.names) # more details

#' 

glimpse(baby.names) # details, more compactly

#' 
#' Data Manipulation
#' =================
#' 
#' data.frame objects
#' ------------------
#' 
#' Usually data read into R will be stored as a **data.frame**
#' 
#' -   A data.frame is a list of vectors of equal length
#'     -   Each vector in the list forms a column
#'     -   Each column can be a differnt type of vector
#'     -   Typically columns are variables and the rows are observations
#' 
#' A data.frame has two dimensions corresponding the number of rows and the
#' number of columns (in that order)
#' 
#' Slice and Filter data.frames rows
#' ---------------------------------
#' 
#' You can extract subsets of data.frames using `slice` to select rows by
#' number and `filter` to select rows that match some condition. It works
#' like this:
#' 

## make up some example data
(example.df <- data.frame(id  = rep(letters[1:4], each = 4),
                          t   = rep(1:4, times = 4),
                          var1 = runif(16),
                          var2 = sample(letters[1:3], 16, replace = TRUE)))

#' 

## rows 2 and 4
slice(example.df, c(2, 4))

#' 

## rows where id == "a"
filter(example.df, id == "a")

#' 

## rows where id is either "a" or "b"
filter(example.df, id %in% c("a", "b"))

#' 
#' Select data.frame columns
#' -------------------------
#' 
#' `slice` and `filter` are used to extract rows. `select` is used to
#' extract columns
#' 

select(example.df, id, var1)

#' 

select(example.df, id, t, var1)

#' 
#' You can also conveniently select a single column using `$`, like this:
#' 

example.df$t

#' 
#' Data manipulation commands can be combined:
#' 

filter(select(example.df,
              id,
              var1),
       id == "a")

#' 
#' In the previous example we used == to filter rows where id was "a".
#' Other relational and logical operators are listed below.
#' 
#'   Operator   Meaning
#'   ---------- --------------------------
#'   ==         equal to
#'   !=         not equal to
#'   &gt;       greater than
#'   &gt;=      greater than or equal to
#'   &lt;       less than
#'   &lt;=      less than or equal to
#'   %in%       contained in
#'   &          and
#'   |          or
#' 
#' Adding, removing, and modifying data.frame columns
#' --------------------------------------------------
#' 
#' You can modify data.frames using the `mutate()` function. It works like
#' this:
#' 

example.df

#' 

## modify example.df and assign the modified data.frame the name example.df
example.df <- mutate(example.df,
       var2 = var1/t, # replace the values in var2
       var3 = 1:length(t), # create a new column named var3
       var4 = factor(letters[t]),
       t = NULL # delete the column named t
       )

#' 

## examine our changes
example.df

#' 
#' Exporting Data
#' --------------
#' 
#' Now that we have made some changes to our data set, we might want to
#' save those changes to a file.
#' 

# write data to a .csv file
write_csv(example.df, path = "example.csv")

# write data to an R file
write_rds(example.df, path = "example.rds")

# write data to a Stata file
library(haven)
write_dta(example.df, path = "example.dta")

#' 
#' Saving and loading R workspaces
#' -------------------------------
#' 
#' In addition to importing individual datasets, R can save and load entire
#' workspaces
#' 

ls() # list objects in our workspace
save.image(file="myWorkspace.RData") # save workspace 
rm(list=ls()) # remove all objects from our workspace 
ls() # list stored objects to make sure they are deleted

#' 
#' Load the "myWorkspace.RData" file and check that it is restored
#' 

load("myWorkspace.RData") # load myWorkspace.RData
ls() # list objects

#' 
#' Exercise 3: Data manipulation
#' -----------------------------
#' 
#' Read in the "babyNames.csv" file if you have not already done so,
#' assigning the result to `baby.names`.
#' 
#' 1.  Filter `baby.names` to show only names given to at least 5 percent
#'     of boys.
#' 2.  Create a column named "Proportion" equal to Percent divided by 100.
#' 3.  Filter `baby.names` to include only names given to at least 3
#'     percent of Girls. Save this to a Stata data set
#'     named "popularGirlNames.dta")
#' 
#' 
#' Basic Statistics and Graphs
#' ===========================
#' 
#' Basic statistics
#' ----------------
#' 
#' Descriptive statistics of single variables are straightforward:
#' 

sum(example.df$var1) # calculate sum of var 1
mean(example.df$var1)
median(example.df$var1)

#' 

sd(example.df$var1) # calculate standard deviation of var1
var(example.df$var1)

#' 

## summaries of individual columns
summary(example.df$var1)

#' 

summary(example.df$var2)

#' 

## summary of whole data.frame
summary(example.df)

#' 
#' Some of these functions (e.g., summary) will also work with data.frames
#' and other types of objects, others (such as `sd`) will not.
#' 
#' Statistics by grouping variable(s)
#' ----------------------------------
#' 
#' The `summarize` function can be used to calculate statistics by grouping
#' variable. Here is how it works.
#' 

summarize(group_by(example.df, id), mean(var1), sd(var1))

#' 
#' You can group by multiple variables:
#' 

summarize(group_by(example.df, id, var3), mean(var1), sd(var1))

#' 
#' Save R output to a file
#' -----------------------
#' 
#' Earlier we learned how to write a data set to a file. But what if we
#' want to write something that isn't in a nice rectangular format, like
#' the output of `summary`? For that we can use the `sink()` function:
#' 

sink(file="output.txt", split=TRUE) # start logging
print("This is the summary of example.df \n")
print(summary(example.df))
sink() ## sink with no arguments turns logging off

#' 
#' Exercise 4
#' ----------
#' 
#' 1.  Calculate the total number of children born.
#' 2.  Filter the data to extract only Massachusetts (Location "MA"), and
#'     calculate the total number of children born in Massachusetts.
#' 3.  Group and summarize the data to calculate the number of children
#'     born each year. Assign the result to the name `births.by.year`.
#' 4.  Calculate the average number of characters in baby names (using the
#'     "Name.length" column).
#' 5.  Group and summarize to calculate the average number of characters in
#'     baby names for each location. Assign the result to the name `name.length.by.location`.
#' 
#' 
#' 
#' Basic graphics: Frequency bars
#' ------------------------------
#' 
#' Thanks to classes and methods, you can `plot()` many kinds of objects:
#' 

plot(example.df$var4)

#' 
#' Basic graphics: Boxplots by group
#' ---------------------------------
#' 
#' Thanks to classes and methods, you can `plot()` many kinds of objects:
#' 

plot(select(example.df, id, var1))

#' 
#' Basic graphics: Mosaic chart
#' ----------------------------
#' 
#' Thanks to classes and methods, you can `plot()` many kinds of objects:
#' 

plot(select(example.df, id, var4))

#' 
#' Basic graphics: scatter plot
#' ----------------------------
#' 

plot(select(example.df, var1, var2))

#' 
#' Exercise 5 TBD
#' --------------
#' 
#' Wrap-up
#' =======
#' 
#' Help us make this workshop better!
#' ----------------------------------
#' 
#' -   Please take a moment to fill out a very short feedback form
#' -   These workshops exist for you – tell us what you need!
#' -   <http://tinyurl.com/R-intro-feedback>
#' 
#' Additional resources
#' --------------------
#' 
#' -   IQSS workshops:
#'     <http://projects.iq.harvard.edu/rtc/filter_by/workshops>
#' -   IQSS statistical consulting: <http://dss.iq.harvard.edu>
#' -   Software (all free!):
#'     -   R and R package download: <http://cran.r-project.org>
#'     -   Rstudio download: <http://rstudio.org>
#'     -   ESS (emacs R package): <http://ess.r-project.org/>
#' -   Online tutorials
#'     -   <http://www.codeschool.com/courses/try-r>
#'     -   <http://www.datacamp.org>
#'     -   <http://swirlstats.com/>
#'     -   <http://r4ds.had.co.nz/>
#' -   Getting help:
#'     -   Documentation and tutorials:
#'         <http://cran.r-project.org/other-docs.html>
#'     -   Recommended R packages by topic:
#'         <http://cran.r-project.org/web/views/>
#'     -   Mailing list: <https://stat.ethz.ch/mailman/listinfo/r-help>
#'     -   StackOverflow: <http://stackoverflow.com/questions/tagged/r>
