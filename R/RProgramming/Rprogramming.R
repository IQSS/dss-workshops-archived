#' ---
#' title: Introduction To Programming In R
#' output: 
#'   html_document:
#'     highlight: tango
#'     toc: true
#'     toc_float:
#'       collapsed: true
#' ---
#' 
#' Workshop overview and materials
#' ===============================
#' 
#' Workshop description
#' --------------------
#' 
#' This is an intermediate/advanced R course appropriate for those with basic
#' knowledge of R. It is intended for those already comfortable with using R for
#' data analysis who wish to move on to writing their own functions.
#' 
#' Prerequisite: basic familiarity with R, such as acquired from an introductory R
#' workshop.
#' 
#' To the extent possible this workshop uses real-world examples. That is to say
#' that concepts are introduced as they are needed for a realistic analysis task.
#' In the course of working through a realistic project we will lean about regular
#' expressions, iteration, functions, control flow and more.
#' 
#' This workshop uses
#' the [tidyverse](https://cran.r-project.org/web/packages/tidyverse/index.html)
#' package which provides more consistent file IO
#' ([readr](https://cran.r-project.org/web/packages/readr/index.html)), data
#' manipulation
#' ([dplyr](https://cran.r-project.org/web/packages/dplyr/index.html),
#' [tidyr](https://cran.r-project.org/web/packages/tidyr/index.html)) and
#' functional programming
#' ([purrr](https://cran.r-project.org/web/packages/purrr/index.html)) tools for R.
#' 
#' Materials and setup
#' -------------------
#' 
#' Everyone should have R installed -- if not:
#' 
#' -   Open a web browser and go to <http://cran.r-project.org> and download and
#'     install it
#' -   Also helpful to install RStudio (download from <http://rstudio.com>)
#' 
#' Materials for this workshop consists of notes and example code.
#' 
#' -   Download materials from
#'     <http://tutorials.iq.harvard.edu/R/RProgramming.zip>
#' -   Extract the zip file containing the materials to your desktop
#' 
#' Example project overview
#' ------------------------
#' 
#' It is common for data to be made available on a website somewhere, either by a
#' government agency, research group, or other organizations and entities. Often
#' the data you want is spread over many files, and retrieving it all one file at a
#' time is tedious and time consuming. Such is the case with the baby names data we
#' will be using today.
#' 
#' The UK [Office for National Statistics](https://www.ons.gov.uk) provides yearly
#' data on the most popular baby names going back to 1996. The data is provided
#' separately for boys and girls. These data have been cleaned up and copied
#' to <http://tutorials.iq.harvard.edu/example_data/baby_names/>. Although we could
#' open a web browser and download files one at a time, it will be faster and
#' easier to instruct R to do that for us. Doing it this way will also give us an
#' excuse to talk about iteration, text processing, and other useful techniques.
#' 
#' Extracting information from a text file (string manipulation)
#' =============================================================
#' 
#' Our first goal is to download all the .csv files from
#' <http://tutorials.iq.harvard.edu/example_data/baby_names/EW>.
#' 
#' In order to do that we need a list of the Uniform Resource Locators (URLs) of
#' those files. The URLs we need are right there as links in the web page. All we
#' need to do is extract them.
#' 
#' Introduction to the tidyverse
#' -----------------------------
#' 
#' In order extract the data URls from the website we will use functions for
#' manipulating strings[^1]. What functions or packages should we use? Here are
#' some tools to help us decide.
#' 
#' Task views
#' :   <https://cran.r-project.org/web/views/NaturalLanguageProcessing.html>
#' 
#' R package search
#' :   <http://www.r-pkg.org/search.html?q=string>
#' 
#' Web search
#' :   <https://www.google.com/search?q=R+string+manipulation&ie=utf-8&oe=utf-8>
#' 
#' Base R provides some string manipulation capabilities (see `?regex`, `?sub` and
#' `?grep`), but I recommend either
#' the [stringr](https://cran.r-project.org/web/packages/stringr/index.html)
#' or [stringi](https://cran.r-project.org/web/packages/stringi/index.html)
#' packages. The *stringr* package is more user-friendly, and the *stringi* package
#' is more powerful and complex. Let's use the friendlier one. While we're
#' attaching packages we'll also attach
#' the [tidyverse](https://cran.r-project.org/web/packages/tidyverse/index.html)
#' package which provides more modern versions of many basic functions in R.
#' 
## ------------------------------------------------------------------------
## install.packages("tidyverse")
library(tidyverse)
library(stringr)

#' 
#' Packages in the tidyverse are often more convenient to use with pipes rather
#' than nested function calls. The pipe operator looks like `%>%` and it inserts
#' the value on the left as the first argument to the function on the right. It
#' looks like this:
#' 
## ------------------------------------------------------------------------
(x <- rnorm(5)) # extra parens around expression is a shortcut to assign and print

## nested function calls to sort and round
round(sort(x), digits = 2)

## pipeline that does the same thing
x %>%
sort() %>%
round(digits = 2)

## nested function calls to sample letters, convert to uppercase and sort.
sort(
  str_to_upper(
    sample(letters,
           5,
           replace = TRUE)))

## pipeline that does the same thing:
letters %>%
  sample(5, replace = TRUE) %>%
  str_to_upper() %>%
  sort()

#' 
#' The examples in this workshop use the pipe when it makes examples easier to
#' follow.
#' 
#' Reading text over http
#' ----------------------
#' 
#' Our first task is to read the web page into R. Most of the file IO functions in
#' R can read either from a local path or from internet URLS. We can read text into
#' R line-by-line using the `read_lines` function.
#' 
## ------------------------------------------------------------------------
base.url <- "http://tutorials.iq.harvard.edu"
baby.names.path <- "example_data/baby_names/EW" 
baby.names.url <- str_c(base.url, baby.names.path, sep = "/")

baby.names.page <- read_lines(baby.names.url)

#' 
#' Now that we have some values to play with lets look closer. R has nice tools for
#' inspecting the object attributes such as the storage `type`, `length`, and
#' `class`.
#' 
## ------------------------------------------------------------------------
## whate is base.url?
c(type = typeof(base.url),
  length = length(base.url),
  class = class(base.url))

#' 
#' ```{R
#' c(type = typeof(baby.names.page),
#'   length = length(baby.names.page),
#'   class = class(baby.names.page))
#' ```
#' 
#'  The `str` (structure) and `glimpse` function
#' gives a nice overview.
#' 
## ------------------------------------------------------------------------
str(baby.names.page)

#' 
#' The *S3* class system in R allows functions to define methods for specific
#' classes. If we know the class of an object we can see what functions have
#' methods specific to that class.
#' 
## ------------------------------------------------------------------------
methods(class = class(base.url))

#' 
#' Note that these methods are not exhaustive -- we can do other things with these
#' objects as well. `methods(class = )` just tells you which functions have
#' specific methods for working with objects of that class.
#' 
#' The `typeof` function tells us how the object is stored in memory. "Character"
#' is one of the six *atomic* modes in R. The others are "logical", "integer",
#' "numeric (double)", "complex", and "raw". Objects reporting their `mode` as one
#' of these are *atomic vectors*; they are the building blocks of most data
#' structures in R.
#' 
#' Now that we know what we're working with we can proceed to find and extract all
#' the links in the page. Lets start by printing the last few lines of
#' `baby.names.page`.
#' 
## ------------------------------------------------------------------------
cat(tail(baby.names.page), sep = "\n")

#' 
#' We want to extract the "href" attributes, i.e., "`girls_2014.csv`" and
#' "`girls_2015.csv`" in the above snippet. We can do that using the `str_extract`
#' function, but in order to use it effectively we need to know something about
#' regular expressions.
#' 
#' String manipulation with the stringr package
#' --------------------------------------------
#' 
#' Regular expressions are useful in general (not just in R!) and it is a good idea
#' to be familiar with at least the basics.
#' 
#' In regulars expression `^`, `.`, `*`, `+`, `$` and `\` are special characters
#' with the following meanings:
#' 
#' \^
#' :   matches the beginning of the string
#' 
#' .
#' :   matches any character
#' 
#' \*
#' :   repeats the previous match zero or more times
#' 
#' +
#' :   repeats the previous match one or more times
#' 
#' \$
#' :   matches the end of the string
#' 
#' \[\]
#' :   specifies ranges of characters: \[a-z\] matches lower case letters
#' 
#' \
#' :   escapes special meaning: '.' means "anything", '.' means "."
#' 
#' Here's how it works in R using the stringr package. Note that to create
#' a backslash you must escape it with anouth backslash.
#' 
## ------------------------------------------------------------------------
## make up some example data
user.info <- c("Dexter Bacon dbacon@gmail.com 32",
               "Angelica Sampson not available 28",
               "Roberta Modela roberta.modela@harvard.edu 26"
               )
## regex that matches emails (simplified, not realistic)
##                                               
email.regex <- "([a-z0-9]+@[a-z0-9]+\\.[a-z]+)"

#' 
#' Which users have an email address?
## ------------------------------------------------------------------------
str_detect(user.info, email.regex)

#' 
#' Keep only users with an email address
## ------------------------------------------------------------------------
str_subset(user.info, email.regex)

#' 
#' Extract the email addresses
## ------------------------------------------------------------------------
str_extract(user.info, email.regex)

#' 
#' Replace email addresses with an `mailto` link
## ------------------------------------------------------------------------
str_replace(user.info, email.regex, "<a href='mailto:\\1'>\\1</a>")

#' 
#' If you have not been introduced to regular expressions yet a nice interactive
#' regex tester is available at <http://www.regexr.com/> and an interactive
#' tutorial is available at <http://www.regexone.com/>.
#' 
#' Exercise 1: string manipulation and regular expressions
#' -------------------------------------------------------
#' 
#' Our job now is to match the file names using regular expressions. To get
#' started lets copy an example string into the interactive regex tester at
#' <http://www.regexr.com/> and work with it until we find a regular
#' expression that works.
#' 
#' 1.  Open <http://www.regexr.com/> in your web browser and paste in this
#'     string into the "Text" box (in the lower right-hand section of the
#'     page):
#' 
## ----engine="example"----------------------------------------------------
<tr><td valign="top"><img src="/icons/unknown.gif" alt="[   ]"></td><td><a href="girls_2014.csv">girls_2014.csv</a></td><td align="right">06-Oct-2016 13:12  </td><td align="right">144K</td></tr>

#' 
#' 2.  Find a regular expression that matches '`girls_2014.csv`' and
#'     nothing else.
#' 3.  Assign the regular expression you found to the name
#'     'girl.file.regex' in R. *Replace any backslashes with a double
#'     backslash*.
#' 4.  Extract the girl file names from `baby.names.page` and assign
#'     the values to the name '`girl.file.names`'
#' 5.  Repeat steps 1:4 for boys.
#' 6.  Use the `str_c` function to prepend `baby.names.url` to
#'     `girl.file.names` and `boy.file.names`. Make sure to separate with a
#'     forward slash ("/").
#' ```
#' 
#' 
#' Exercise 1 prototype
#' --------------------
#' 
#' 
#' Reading all the files (iteration, functions)
#' ============================================
#' 
#' Reading .csv files
#' ------------------
#' 
#' As mentioned earlier, we can read files directly from the internet. For example,
#' we can read the first girls names file like this:
#' 
## ------------------------------------------------------------------------
girl.names.1 <- read_csv(girl.file.names[1], na = "")
head(girl.names.1)

#' 
#' Notice that we selected the first element of `girl.file.names` using `[`. This
#' is called *bracket extraction* and it is a very useful feature of the R
#' language.
#' 
#' Extracting and replacing vector elements
#' ----------------------------------------
#' 
#' Elements of R objects can be extracted and replaced using bracket
#' notation. Bracket extraction comes in a few different flavors. We can
#' index atomic vectors in several different ways. Let's start by making
#' some example data to work with.
#' 
## ------------------------------------------------------------------------
example.int.1 <- c(10, 11, 12, 13, 14, 15)
str(example.int.1)

#' 
#' The *names* attribute can be used for indexing if it exists. The names
#' attribute and be extracted and set using the `names` function, like
#' this:
#' 
## ------------------------------------------------------------------------
names(example.int.1) # no names yet, lets add some

#' 
## ------------------------------------------------------------------------
names(example.int.1) <- c("a1", "a2", "b1", "b2", "c1", "c2")
names(example.int.1)

#' 
#' Indexing can be done by position.
#' 
## ------------------------------------------------------------------------
## extract by position
example.int.1[1]
example.int.1[c(1, 3, 5)]

#' 
#' If an object has names you can index by name.
#' 
## ------------------------------------------------------------------------
## extract by name
example.int.1[c("c2", "a1")]

#' 
#' Finally, objects can be indexed with a logical vector, extracting only the TRUE
#' elements.
#' 
## ------------------------------------------------------------------------
## logical extraction 
(one.names <- str_detect(names(example.int.1), "1"))


#' 
## ------------------------------------------------------------------------
example.int.1[one.names]

#' 
## ------------------------------------------------------------------------
example.int.1[example.int.1 > 12]

#' 
#' Replacement works by assigning a value to an extraction.
#' 
## ------------------------------------------------------------------------
example.int.2 <- example.int.1

## replace by position
example.int.2[1] <- 100

## replace by name
example.int.2["a2"] <- 200
example.int.2

#' 
## ------------------------------------------------------------------------
## logical replacement
(lt14 <- example.int.2 < 14)

#' 
## ------------------------------------------------------------------------
example.int.2[lt14] <- 0
example.int.2

#' 
## ------------------------------------------------------------------------
## "replace" non-existing element
example.int.2[c("z1", "2")] <- -10 

## compare lists to see the changes we made
example.int.1
example.int.2

#' 
#' Extracting and replacing list elements
#' --------------------------------------
#' 
#' List elements can be extracted and replaced in the same way as elements of
#' atomic vectors. In addition, `[[` can be used to extract or replace the contents
#' of a list element. Here is how it works:
#' 
## ------------------------------------------------------------------------
## make up an example list
example.list.1 <- list(a1 = c(a = 1, b = 2, c = 3),
                     a2 = c(4, 5, 6),
                     b1 = c("a", "b", "c", "d"),
                     b2 = c("e", "f", "g", "h"))
str(example.list.1)

#' 
#' Extract by position.
## ------------------------------------------------------------------------
str(example.list.1[c(1, 3)])

#' 
## ------------------------------------------------------------------------
str(example.list.1[1])

#' 
#' ```{R
#' str(example.list.1[[1]]) # note the difference between [ and [[
#' ```
#' 
#' Extract by name.
#' 
#' ```{R
#' str(example.list.1[c("a1", "a2")])
#' ```
#' 
## ------------------------------------------------------------------------
(a.names <- str_detect(names(example.list.1), "a"))

#' 
## ------------------------------------------------------------------------
str(example.list.1[a.names])

#' 
#' Bracket extraction can be chained to extract a nested element.
#' 
## ------------------------------------------------------------------------
str(example.list.1[["a1"]][c("a", "c")])

#' 
#' Logical extraction.
#' 
## ------------------------------------------------------------------------
(el.length <- map_int(example.list.1, length))

#' 
## ------------------------------------------------------------------------
(el.length4 <- el.length == 4)

#' 
## ------------------------------------------------------------------------
str(example.list.1[el.length4])

#' 
#' As with vectors, replacement works by assigning a value to an
#' extraction.
#' 
## ------------------------------------------------------------------------
example.list.2 <- example.list.1

## replace by position
example.list.2[[1]] <- c(a = 11, b = 12, c = 13)

## replace by name
example.list.2[["a2"]] <- c(10, 20, 30)

## iterate and replace by name
example.list.2[c("a1", "a2")] <- map(example.list.2[c("a1", "a2")],
                                        function(x) x * 100)

## logical replacement with iteration
(el.length <- map(example.list.2, length))
(el.length4 <- el.length == 4)
example.list.2[el.length4] <- map(example.list.2[el.length4],
                                     function(x) str_c("letter", x, sep = "_"))

## "replace" non-existing element
example.list.2[["c"]] <- list(x = letters[1:5], y = 1:5)

#' 
## ------------------------------------------------------------------------
## compare lists to see the changes we made
str(example.list.1)
str(example.list.2)

#' 
#' Back to the problem at hand: reading data into a list
#' -----------------------------------------------------
#' 
#' Using our knowledge of bracket extraction we could start reading in the data
#' files like this:
#' 
## ------------------------------------------------------------------------
boys <- list()
girls <- list()

boys[[1]] <- read_csv(boy.file.names[1], na = "")
boys[[2]] <- read_csv(boy.file.names[2], na = "")
## ...
girls[[1]] <- read_csv(girl.file.names[1], na = "")
girls[[2]] <- read_csv(girl.file.names[2], na = "")
## ...

#' 
#' Exercise 2: String manipulation, extraction and replacement
#' -----------------------------------------------------------
#' 
#' We saw in the previous example one way to start reading the baby name
#' data, using positional bracket extraction and replacement. In this
#' exercise we will improve on this method by doing the same thing using
#' named extraction and replacement. The first step is to extract the years
#' from `boy.file.names` and `girl.file.names` and assign then to the
#' `names` attribute of our `boys` and `girls` lists.
#' 
#' 1.  Use the `list` function to create empty lists named `boys` and `girls`.
#' 2.  Write a regular expression that matches digits 0-9 repeated one or
#'     more times and use it to extract the years from `boy.file.names` and
#'     `girl.file.names` (use `str_extract`).
#' 3.  Use the assignment from of the `names` function to assign the years
#'     vectors from step one to the names of `boy.file.names` and
#'     `girl.file.names` respectively.
#' 4.  Extract the element named "2015" from `girl.file.names` and pass it
#'     as the argument to `read_csv`, assigning the result to a new element
#'     of the `girls` list named "2015". Repeat for elements "2014"
#'     and "2013".
#' 5.  Repeat step three using `boy.file.names` and the `boys` list.
#' 
#' 
#' Exercise 2 prototype
#' -------------------------
#' 
#' 
#' 
#' Iterating using the map function
#' --------------------------------
#' 
#' With a small number of files reading each one separately isn't too bad, but it
#' obviously doesn't scale well. To read all the files conveniently we instead want
#' to instruct R to iterate over the vector of URLs for us and download each one.
#' We can carry out this iteration in several ways, including using one of the
#' `map*` functions in the purrr package. Here is how it works.
#' 
## ------------------------------------------------------------------------
## make up some example data
list.1 <- list(a = sample(1:5, 20, replace = TRUE),
               b = c(NA, sample(1:10, 20, replace = TRUE)),
               c = sample(10:15, 20, replace = TRUE))

#' 
#' Calculate the mean of every entry
## ------------------------------------------------------------------------
map.1 <- map(list.1, mean)
str(map.1)

#' 
#' Calculate the mean of every entry, passing `na.rm` argument.
## ------------------------------------------------------------------------
map.1 <- map(list.1, mean, na.rm = TRUE)
str(map.1)

#' 
#' Calculate the mean of every entry, returning a numberic vector instead of a
#' list.
## ------------------------------------------------------------------------
map.2 <- map_dbl(list.1, mean)
str(map.2)

#' 
#' Calculate the mean of every entry, returning a character vector.
## ------------------------------------------------------------------------
map.3 <- map_chr(list.1, mean)

#' 
#' Calculate summaries (map returns a list).
## ------------------------------------------------------------------------
map.4 <- map(list.1, summary)
str(map.4)

#' 
#' Writing your own functions
#' --------------------------
#' 
#' The `map*` functions are useful when you want to apply a function to a list or
#' vector of inputs and obtain the return values. This is very convenient when a
#' function already exists that does exactly what you want. In the examples above
#' we mapped `mean` and `summary` to the elements of a list. But what if there is
#' no existing function that does exactly what we want? Suppose that rather than
#' the set of statistics reported by the `summary` function we want to summarize
#' each element in the list by calculating the *length*, *mean*, and *standard
#' deviation*? In that case we will need to write a function that does what we
#' want. Fortunately, writing functions in R is easy.
#' 
## ------------------------------------------------------------------------
## define new function that returns the lenght, mean, and standard deviation
my.summary <- function(x) {
  n <- length(x)
  avg <- mean(x)
  std.dev <- sd(x)
  return(c(N = n, Mean = avg, Standard.Deviation = std.dev))
}

## test it out
my.summary(list.1[[1]])

#' 
#' Our new function can be used just like any other function in R. For example, we
#' can iterate over `list.1` and apply our new function to each element.
#' 
## ------------------------------------------------------------------------
map(list.1, my.summary)

#' 
#' Note that you can use the special `...` notation to pass named arguments
#' without needing to define them all. For example:
#' 
## ------------------------------------------------------------------------
## improve our function by allowing arbitrary arguments to be passed into the body
my.summary <- function(x, ...) {
  n <- length(x)
  avg <- mean(x, ...)
  std.dev <- sd(x, ...)
  return(c(N = n, Mean = avg, Standard.Deviation = std.dev))
}

#' 
#' Now we can try out the new version of our summary function. Calling it without
#' any additional arguments works fine for the first element of the list:
## ------------------------------------------------------------------------
my.summary(list.1[[1]])

#' 
#' However, it doesn't work so well on elements containing missing values:
## ------------------------------------------------------------------------
my.summary(list.1[[2]])

#' 
#' Even though our function does not have an na.rm argument we, can pass it to mean and sd via `...`
#' 
## ------------------------------------------------------------------------
my.summary(list.1[[2]], na.rm = TRUE) 

#' 
#' Often when writing functions you want to skip some part of the function body
#' under some conditions. For example, we might want omit missing values only if
#' they exist:
#' 
## ------------------------------------------------------------------------
## improve our function by removing missing values if they exist.
my.summary <- function(x, ...) {
  if(any(is.na(x))) {
    x <- na.omit(x)
  }
  n <- length(x)
  avg <- mean(x, ...)
  std.dev <- sd(x, ...)
  return(c(N = n, Mean = avg, Standard.Deviation = std.dev))
}

#' 
#' This is often useful for argument checking among other things.
#' 
## ------------------------------------------------------------------------
my.summary <- function(x, mean.only = FALSE, ...) {
  if(!is.numeric(x)) {
    stop("x is not numeric.")
  }
  if(any(is.na(x))) {
    x <- na.omit(x)
  }
  if(mean.only) {
    stats <- c(N = length(x), Mean = mean(x))
  } else {
    stats <- c(N = length(x), Mean = mean(x), Standard.Deviation = sd(x))
  }
  return(stats)
}

#' 
## ------------------------------------------------------------------------
map(list.1, my.summary)

#' 
## ------------------------------------------------------------------------
map(list.1, my.summary, mean.only = TRUE)

#' 
#' OK, now that we know how to write functions lets get back to the problem
#' at hand. We want to read each file in the `girl.file.names` and
#' `boy.file.names` vectors.
#' 
#' Exercise 3: Iteration, file IO, functions
#' -----------------------------------------
#' 
#' We know how to read csv files using `read_csv`. We know how to iterate
#' using `map`. All we need to do now is put the two things together.
#' 
#' 1.  Use the `map` and `read_csv` functions to read all the girls data
#'     into an object named `girls.data`.
#' 2.  Do the same thing for the boys data (name the object `boys.data`).
#' 3.  Inspect the boys and girls data lists. How many elements do they
#'     have? What class are they?
#' 4.  Write a function that returns the `class`, `typeof`, and `length` of
#'     its argument. `map` this function to `girls.data` and `boys.data`.
#' 
#' Exercise 3 prototype
#' -------------------------
#' 
#' 
#' 
#' Adding a Year column (data structures, indexing)
#' ================================================
#' 
#' OK, at this point we have read in all the data. That is a good start! Lets take
#' a closer look at what we are working with.
#' 
## ------------------------------------------------------------------------
str(girls.data, max.level = 1)

#' 
#' OK, so we have a *list* with 20 elements. A list in R is a very flexible data
#' structure that can hold just about anything (including other lists). Our
#' `girls.data` is a list that happens to contain *data.frames*.
#' 
#' A data.frame in R is a special type of list in which each element is the same
#' length. Elements of data.frames are often *atomic vectors* ("logical",
#' "integer", "numeric (double)" etc. as discussed above), though elements of a
#' data.frame can be anything you can store in other lists, provided only that each
#' element is the same length.
#' 
#' There are many useful things we can do with data.frames: (But remember that this
#' list of methods is not all you can do with data.frames.)
#' 
## ------------------------------------------------------------------------
girls.data.1 <- girls.data[[1]]
class(girls.data.1)

#' 
## ------------------------------------------------------------------------
methods(class = "data.frame")

#' 
## ------------------------------------------------------------------------
list(dim = dim(girls.data.1),
     rows = nrow(girls.data.1),
     cols = ncol(girls.data.1),
     names = names(girls.data.1),
     summary = summary(girls.data.1))

#' 
#' Adding a year column using bracket extraction/replacement
#' ---------------------------------------------------------
#' 
#' The data.frames in `girls.data` all have three elements (columns): Rank (a
#' number), Name (a character), and Count (a number). That is a problem, because we
#' need to have a column that records the year! Year was stored in the file names
#' rather than in the contents of the files, and so it appears as the names of the
#' list elements rather than as a column in each data.frame.
#' 
#' How can we insert the year information into each corresponding data.frame?
#' Recall that a data.frame **is** a list, so we can use bracket extraction just as
#' we would for other kinds of lists. That is, we can add a year column to the
#' data.frame in position 1 of `girls.data` like this:
#' 
## ------------------------------------------------------------------------
str(girls.data[[1]])

#' 
## ------------------------------------------------------------------------
girls.data[[1]][["Year"]] <- names(girls.data[1])
##        ^                                  ^ 
## double brackets to extract data.frame   single brackets to extract a list containing a data.frame
str(girls.data[[1]])

#' 
## ------------------------------------------------------------------------
girls.data[[1]][["Year"]] <- as.integer(names(girls.data[1]))
str(girls.data[[1]])

#' 
#' Now we want to repeat that for each element in the list. We previously learned
#' how to iterate using the `map` function, but that won't work here because we
#' need a function with two arguments: the list element to modify, and the year
#' value to insert. For that we can use the `map2` function, which works just like
#' `map` except that we iterate over two things with a function that takes two
#' arguments. It works like this:
#' 
## ------------------------------------------------------------------------
example.list.3 <- list(a = 1:3,
                       b = 4:6,
                       c = 7:9)
upper.name <- function(x, y) {
  y.upper <- str_to_upper(y)
  return(str_c(y.upper, x, sep = ": "))
}

example.list.4 <- map2(example.list.3, names(example.list.3), upper.name)
str(example.list.3)
str(example.list.4)

#' 
#' Exercise 4: Iteration, data.frame manipulation
#' ----------------------------------------------
#' 
#' We know how to add a Year column. We know how to iterate using `map2`. All we
#' need to do now is put the two things together.
#' 
#' 1.  Write a function named `add.year` that takes a data.frame and a vector as
#'     arguments and returns a data.frame with the vector included as a column.
#' 2.  Test your function on the first elements of `girls.data` and
#'     `names(girls.data)` from step 1.
#' 3.  Use the `map2` function to iterate over `girls.data` and insert the
#'     corresponding year from `names(girls.data)` using the function you
#'     wrote in step 1. Do the same for `boys.data`.
#' 
#' 
#' 
#' Exercise 4 prototype 
#' -------------------------
#' 
#' 
#' Final England and Wales data cleanup
#' ====================================
#' 
#' Our next step to is to collapse each list of data.frames into a single
#' list. We can do that using the `bind_rows` function.
#' 
## ------------------------------------------------------------------------
boys.data <- bind_rows(boys.data)
girls.data <- bind_rows(girls.data)

#' 
#' Finally, we want to insert columns indicating location and sex, combine
#' the boys and girls baby names, and convert the "Year" column to integer.
#' 
## ------------------------------------------------------------------------
girls.data[["Sex"]] <- "F"
boys.data[["Sex"]] <- "M"
baby.names <- bind_rows(girls.data, boys.data)
baby.names$Year <- as.integer(baby.names$Year)
baby.names$Location <- "England and Wales"

#' 
#' Now that our data is cleaned up and formatted, lets take a final look to make
#' sure everything looks correct.
#' 
## ------------------------------------------------------------------------
str(baby.names)

#' 
#' Get US data (strings, iteration, function recap)
#' ================================================
#' 
#' So far we've read in and cleaned up baby name data from England and Wales. The
#' next task is to do the same for US baby name data. The US baby name data is
#' stored in a slightly different way: there are separate files for each Stata, and
#' each file contains columns indicating the state, sex, year, name, and count.
#' Note that these files do **not** have names in the first row.
#' 
#' Your mission, should you choose to accept it, is to read in all the US baby name
#' data and combine them with the England and Wales data we read in earlier. To
#' succeed you will need to use all your wits and avail yourself of any resources
#' at your disposal (such as the R help system, <http://stackoverflow.com/>,
#' discussing with your colleagues, or asking the instructor).
#' 
#' Here is the index page to get you started.
#' 
## ------------------------------------------------------------------------
base.url <- "http://tutorials.iq.harvard.edu"
baby.names.path <- "example_data/baby_names/US" 
baby.names.url <- str_c(base.url, baby.names.path, sep = "/")
baby.names.page <- read_lines(baby.names.url)

#' 
#' Exercise 5: strings, iteration, functions recap
#' -----------------------------------------------
#' 
#' You are now a trained R programmer. Put your skills to use as follows
#' 
#' 1.  Extract the file names from baby.names.page and combine them with
#'     `baby.names.url` to create a vector of file locations.
#' 2.  Iterate over the vector of file names from step one and read each
#'     file, assigning the result to a list named `us.baby.names`. Note
#'     that column names are not present in these data files.
#' 3.  Use `bind_rows` to combine your list of 51 data.frames into a
#'     single data.frame.
#' 4.  Use the assignment form of the `names` function to name the columns
#'     in your US baby names data set "Location", "Sex", "Year",
#'     and "Count".
#' 5.  Write a function named `read.linked.files` that wraps steps 1-3.
#'     Your function should take 3 arguments:
#' 
#'     url
#'     :   the location of the web page containing data links
#' 
#'     pattern
#'     :   a regular expression used to extract data links from the page
#' 
#'     reader.fun
#'     :   a function used to read the files
#' 
## ------------------------------------------------------------------------
## 1. extract file names
file.names <- na.omit(str_extract(baby.names.page, "[A-Z]+\\.csv"))
file.locations <- str_c(baby.names.url, file.names, sep = "/")

## 2. read in the data
us.baby.names <- map(file.locations,
                     read_csv,
                     col_names = FALSE,
                     na = "",
                     col_types = "ccici")

## 3. collapse list of data.frames into a single data.frame
us.baby.names <- bind_rows(us.baby.names)

## 4. add column names
names(us.baby.names) <- c("Location", "Sex", "Year", "Name", "Count")

## 5. wrap it in a function
read.linked.files <- function(url,
                              pattern = "[A-z0-9]+\\.csv",
                              reader.fun = read_csv) {
  ## extract file names
  file.names <- na.omit(str_extract(read_lines(url), pattern))
  file.locations <- str_c(url, file.names, sep = "/")
  
  ## read in the data
  the.data <- map(file.locations,
                  reader.fun)
  
  ## collapse list of data.frames into a single data.frame
  return(bind_rows(the.data))
}

## test it out.
test <- read.linked.files("http://tutorials.iq.harvard.edu/example_data/baby_names/US",
                          pattern = "[A-Z]+\\.csv",
                          reader.fun = function(x) {
                            read_csv(x, col_names = FALSE, na = "", col_types = "ccici")
                          })


#' 
#' Final Data cleanup
#' ------------------
#' 
#' Now that we've downloaded the baby name data from England and Wales and from the
#' US are ready to do some final data cleanup. First I'm going to drop the "Rank"
#' variable since it only exists in the England and Wales data, and I don't really
#' care about it anyway. We can drop elements by assigning `NULL` to them.
#' 
## ------------------------------------------------------------------------
baby.names[["Rank"]] <- NULL

#' 
#' Next we want to combine the two sets of baby names into a single data.frame.
#' I'll also remove `us.baby.names` since it is quite large and we don't need it
#' anymore.
#' 
## ------------------------------------------------------------------------
baby.names <- bind_rows(baby.names, us.baby.names)
rm(us.baby.names)

#' 
#' Finally, since the England names are all uppercase and the US names are title
#' case we need to make them the same.
#' 
## ------------------------------------------------------------------------
baby.names[["Name"]] <- str_to_lower(baby.names[["Name"]])

#' 
#' What can we learn about baby names? (data frame manipulation, graphing)
#' =======================================================================
#' 
#' Now that we have the data loaded and cleaned up we can use it to answer
#' interesting questions. For example:
#' 
#' -   How many children were born each year?
#' -   What are the most popular names overall?
#' -   How has the popularity of the most popular names changed over time?
#' -   Has the number of names changed over time?
#' -   How has the distribution of names changed over time?
#' -   Has the average length of names changed over time?
#' -   What are the most popular first letters in baby names? Has this
#'     changed over time?
#' -   What were the most popular names in 2015 (the last year for which we
#'     have data)?
#' -   How has the popularity of the most popular names in 2015 changed
#'     over time?
#' 
#' Earlier I mentioned that data.frames are a special kind of list in which each
#' element must be of the same length. What I perhaps did not emphasize enough is
#' how important the data.frame concept is in R programming. Because of the
#' centrality of the data.frame in many R workflows there are many functions
#' available specifically for manipulating data.frames. In particular, the
#' *data.table*, *dplyr* and *tidyr* packages provides many useful functions for
#' working with data.frames. In this section we will use the *dplyr* package answer
#' some of our questions about baby names.
#' 
#' Number of children born each year
#' ---------------------------------
#' 
#' Now that we have the data read in and we know what is in each column, I want to
#' know how many children were born each year. To one way to do that is to use the
#' `group_by` and `summarize` functions from the *dplyr* package.
#' 
## ------------------------------------------------------------------------
## make up some example data
(example.df <- data.frame(id  = rep(letters[1:4], each = 4),
                          t   = rep(1:4, times = 4),
                          var1 = runif(16),
                          var2 = sample(letters[1:3], 16, replace = TRUE)))

#' 
#' Calculate the total sum of the `var1` column.
## ------------------------------------------------------------------------
## summarize
summarize(example.df,
          var1 = sum(var1))

#' 
#' Calculate the sum of `var1` by `id`.
## ------------------------------------------------------------------------
## summarize by id
example.df %>%
  group_by(id) %>%
  summarize(var1 = sum(var1))

#' 
#' Calculate the sum of `var1` by `id` and `var2`.
## ------------------------------------------------------------------------
## summarize by id and var2
example.df %>%
  group_by(id, var2) %>%
  summarize(var1 = sum(var1))

#' 
#' Now that we know how to group by and summarize we can calculate the
#' number of babies born each year
#' 
## ------------------------------------------------------------------------
group_by(baby.names, Year) %>%
  summarize(Total = sum(Count))

#' 
#' We can also easily generalize this to other groupings, e.g., to
#' calculate the number of boys and girls born each year:
#' 
## ------------------------------------------------------------------------
group_by(baby.names, Year, Sex) %>%
  summarize(Total = sum(Count))

#' 
#' Most popular names overall
#' --------------------------
#' 
#' Next I want to find the five most popular girl and boy names overall.
#' 
#' Specifically I want to:
#' 
#' 1.  Compute "Percent" column by "Location", "Sex" and "Year".
#' 2.  Average the "Percent" column for each name by "Sex".
#' 3.  Sort names by the averaged Percent.
#' 4.  Select the top 5 in each group.
#' 
#' In order to identify the most popular names it will be useful to learn a
#' few new tools. You already know how `group_by` and `summarize` work. The
#' following example shows how `mutate`, `arrange` and `slice` work.
#' 
## ------------------------------------------------------------------------
## add new columns using mutate
(example.df <- example.df %>%
   mutate(n1 = n(),
          n2 = length(var1),
          var3 = var1/n1))

#' 
## ------------------------------------------------------------------------
## combine with group_by
(example.df <- example.df %>%
   group_by(id) %>%
   mutate(n3 = n(),
          var4 = var1/n3))

#' 
## ------------------------------------------------------------------------
## summarize by id and var2
(example.df.2 <- example.df %>%
   group_by(id, var2) %>%
   summarize(var1 = sum(var1)))

#' 
## ------------------------------------------------------------------------
## sort by var1
example.df.2 %>%
  arrange(var1)

#' 
## ------------------------------------------------------------------------
example.df.2 %>%
  arrange(desc(var1))

#' 
## ------------------------------------------------------------------------
## sort by var1 within id
(example.df.2 <- example.df.2 %>%
   arrange(id, desc(var1)))

#' 
## ------------------------------------------------------------------------
## select the top 2 var1's within each id group
example.df.2 %>%
  group_by(id) %>%
  slice(1:2)

#' 
#' Now that we know how to group, mutate, summarize, arrange, and slice we
#' can use these tools to identify the most popular boy and girl names.
#' 
## ------------------------------------------------------------------------
## create a percent column
baby.names <- baby.names %>%
  group_by(Location, Year, Sex) %>%
  mutate(Percent = (Count/sum(Count)) * 100)

## collapse across year and location to get the average percent for each each name by sex
baby.names.percent.overall <- baby.names %>%
  group_by(Sex, Name) %>%
  summarize(Percent = mean(Percent))

## arrange the data with the highest average percent first, and select the top 5
(top.names.overall <- baby.names.percent.overall %>%
   arrange(Sex, desc(Percent)) %>%
   group_by(Sex) %>%
   slice(1:5))

#' 
#' How has the distribution of names changed over time?
#' ----------------------------------------------------
#' 
#' Finally, I want to examine how the distribution of names has changed
#' over time. This doesn't require learning any new tools, we just need to
#' combine the tools we already know to produce the desired result.
#' 
## ------------------------------------------------------------------------
baby.names.sex.decade <- baby.names %>%
  ## aggregate Year to Decade
  mutate(Decade = str_c(floor(Year/10)*10, "'s")) %>%
  ## calculate Percent by Location, Sex, and Year
  group_by(Location, Sex, Year) %>%
  mutate(Percent = (Count/sum(Count)) * 100) %>%
  ## summarize to the Sex/Decade/Name level
  group_by(Sex, Decade, Name) %>%
  summarize(Count = sum(Count),
            Percent = mean(Percent)) %>%
  ## order the names by overall popularity.
  group_by(Sex) %>%
  mutate(Name = reorder(Name, -1*Percent))

## plot
ggplot(baby.names.sex.decade, aes(x = Name, y = Percent, fill = Sex, color = Sex)) +
  geom_bar(stat = "identity") +
  facet_grid(Decade ~ Sex, scales = "free_x") +
  theme(axis.text.x = element_blank())

#' 
#' Exercise 5: Final project
#' -------------------------
#' 
#' Choose one of these questions
#' 
#' -   ~~How many children were born each year?~~
#' -   ~~What are the most popular names overall?~~
#' -   How has the popularity of the most popular names changed over time?
#' -   Has the number of names changed over time?
#' -   ~~How has the distribution of names changed over time?~~
#' -   Has the average length of names changed over time?
#' -   What are the most popular first letters in baby names? Has this
#'     changed over time?
#' -   What were the most popular names in 2015 (the last year for which we
#'     have data)?
#' -   How has the popularity of the most popular names in 2015 changed
#'     over time?
#' 
#' and use the `baby.names` data together with your mastery of R to answer
#' it.
#' 
#' Other stuff
#' ===========
#' 
#' Combining similar names
#' -----------------------
#' 
#' Similar names with different spellings have been intentionally left
#' alone in these data. If our goals is to examine changes in name
#' popularity (rather than changing spelling preferences) it might be
#' useful to combine them. There are several different algorithms for
#' detecting words that sound alike; many of them (including the *nysiis*
#' and *metaphone* algorithms) are provided in R by the *phonics* package.
#' Here is how it works:
#' 
## ------------------------------------------------------------------------
##install.packages("phonics")
library(phonics)
spelling <- c(
"colour",   "color",       
"flavour",   "flavor",   
"behaviour", "behavior", 
"harbour",   "harbor",   
"honour",    "honor",    
"humour",    "humor",    
"labour",    "labor",    
"neighbour", "neighbor", 
"rumour",    "rumor")

(spelling.data <- data.frame(original = spelling, Sounds.like = nysiis(spelling, maxCodeLen = 15)))

#' 
#' Once we have identified which words are the same (but spelled
#' differently) we can combine those words.
#' 
## ------------------------------------------------------------------------
(spelling.data <- spelling.data %>%
   group_by(Sounds.like) %>%
   mutate(Alternative.spellings = str_c(sort(original), collapse = "/")))

#' 
#' We can use this technique to identify and group names with alternative
#' spellings. Since any one algorithm tends to group two aggressively we'll
#' require multiple algorithms to agree.
#' 
## ------------------------------------------------------------------------
library(phonics)
baby.names <- baby.names %>%
  group_by(Sex) %>%
  mutate(Sounds.like = str_c(nysiis(Name, maxCodeLen = 10),
                             metaphone(Name, maxCodeLen = 10),
                             sep = "/")) %>%
  group_by(Sex, Sounds.like) %>%
  mutate(Alternative.spellings = str_c(sort(unique(Name)), collapse = "/")) %>%
  ungroup()
str(baby.names)

#' 
#' "starts with" and "ends with"
#' -----------------------------
#' 
#' Not only do the most popular names change over time, but the most
#' popular first and last letters also display temporal trends. We can
#' extract the first/last n letters using `str_sub`, like this:
#' 
## ------------------------------------------------------------------------
month.name
str_sub(month.name, 1, 1)
str_sub(month.name, 1, 3)
str_sub(month.name, -1, -1)
str_sub(month.name, -3, -1)

#' 
#' We can use this to create new columns with just the first/last **n**
#' letters of each name
#' 
## ------------------------------------------------------------------------

baby.names[["First.1"]] <- str_sub(baby.names[["Name"]], 1, 1)
baby.names[["First.2"]] <- str_sub(baby.names[["Name"]], 1, 2)
baby.names[["First.3"]] <- str_sub(baby.names[["Name"]], 1, 3)
baby.names[["Last.1"]] <- str_sub(baby.names[["Name"]], -1, -1)
baby.names[["Last.2"]] <- str_sub(baby.names[["Name"]], -2, -1)
baby.names[["Last.3"]] <- str_sub(baby.names[["Name"]], -3, -1)

#' 
#' Length of names
#' ---------------
#' 
#' The `str_length` function can be used to count the number of letters in
#' each name
#' 
## ------------------------------------------------------------------------
baby.names$Name.length <- str_length(baby.names$Name)

#' 
#' What else?
#' ==========
#' 
#' If there is anything else you want to learn how to do, now is the time
#' to ask!
#' 
#' Go forth and code!
#' ==================
#' 
#' You now know everything you could possibly want to know about R. OK
#' maybe not! But you do know how to manipulate character strings with
#' regular expressions, write your own functions, iterate, inspect and
#' modify attributes, and extract and replace object elements. There's a
#' lot more to learn, but that's a pretty good start. As you go forth and
#' write your own R code here are some resources that may be helpful.
#' 
#' Additional reading and resources
#' ================================
#' 
#' -   Learn from the best: <http://adv-r.had.co.nz/>;
#'     <http://r4ds.had.co.nz/>
#' -   R documentation: <http://cran.r-project.org/manuals.html>
#' -   Collection of R tutorials:
#'     <http://cran.r-project.org/other-docs.html>
#' 
#' -   R for Programmers (by Norman Matloff, UC--Davis)
#' 
#' <http://heather.cs.ucdavis.edu/~matloff/R/RProg.pdf>
#' 
#' -   Calling C and Fortran from R (by Charles Geyer, UMinn)
#' 
#' <http://www.stat.umn.edu/~charlie/rc/>
#' 
#' -   State of the Art in Parallel Computing with R (Schmidberger et al.)
#' 
#' <http://www.jstatso>|.org/v31/i01/paper
#' 
#' -   Institute for Quantitative Social Science: <http://iq.harvard.edu>
#' -   Research technology consulting: <http://projects.iq.harvard.edu/rtc>
#' 
#' Epilogue: Things that may surprise you
#' ======================================
#' 
#' There are an unfortunately large number of surprises in R programming.
#' Some of these "gotcha's" are common problems in other languages, many
#' are unique to R. We will only cover a few -- for a more comprehensive
#' discussion please see
#' <http://www.burns-stat.com/pages/Tutor/R_inferno.pdf>
#' 
#' ### Floating point comparison
#' 
#' Floating point arithmetic is not exact:
#' 
## ------------------------------------------------------------------------
.1 == .3/3

#' 
#' Solution: `use all.equal()`:
#' 
## ------------------------------------------------------------------------
all.equal(.1, .3/3)

#' 
#' ### Missing values
#' 
#' R does not exclude missing values by default -- a single missing value
#' in a vector means that many thing are unknown:
#' 
## ------------------------------------------------------------------------
x <- c(1:10, NA, 12:20)
c(mean(x), sd(x), median(x), min(x), sd(x))

#' 
#' NA is not equal to anything, not even NA
#' 
#' ```{#NAcomp .r}
#' NA == NA
#' ```
#' 
#' Solutions: use `na.rm = TRUE` option when calculating, and is.na to test
#' for missing
#' 
#' ### Automatic type conversion
#' 
#' Automatic type conversion happens a lot which is often useful, but makes
#' it easy to miss mistakes
#' 
## ------------------------------------------------------------------------
# combining values coereces them to the most general type
(x <- c(TRUE, FALSE, 1, 2, "a", "b"))
str(x)

# comparisons convert arguments to most general type
1 > "a"

#' 
#' Maybe this is what you expect... I would like to at least get a warning!
#' 
#' ### Optional argument inconsistencies
#' 
#' Functions you might expect to work similarly don't always:
#' 
## ------------------------------------------------------------------------
mean(1, 2, 3, 4, 5)*5
sum(1, 2, 3, 4, 5)

#' 
#' Why are these different?!?
#' 
## ------------------------------------------------------------------------
args(mean)
args(sum)

#' 
#' Ouch. That is not nice at all!
#' 
#' ### Trouble with Factors
#' 
#' Factors sometimes behave as numbers, and sometimes as characters, which
#' can be confusing!
#' 
## ------------------------------------------------------------------------
(x <- factor(c(5, 5, 6, 6), levels = c(6, 5)))

str(x)

as.character(x)
# here is where people sometimes get lost...
as.numeric(x)
# you probably want
as.numeric(as.character(x))

#' 
#' Feedback
#' --------
#' 
#' -   Help Us Make This Workshop Better!
#' -   Please take a moment to fill out a very short feedback form
#' -   These workshops exist for you -- tell us what you need!
#' -   <http://tinyurl.com/RprogrammingFeedback>
#' 
#' [^1]: In general you [should not use string manipulation tools to parse
#'     html](http://stackoverflow.com/questions/1732348/regex-match-open-tags-except-xhtml-self-contained-tags/1732454#1732454),
#'     but in this case the html is simple enough that a regular expression
#'     based approach is fine.
