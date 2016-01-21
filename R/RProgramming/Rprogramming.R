
##   Throughout this workshop we will return to a running example that involves
##   acquiring, processing, and analyzing data from the Displaced Worker
##   Survery (DWS; see http://ceprdata.org). In this context we will learn about
##   finding and using R packages, importing and manipulating data, writing
##   functions, and more. The web page has been mirrored at
##   http://tutorials.iq.harvard.edu/cps-uniform-data-extracts/cps-displaced-worker-survey/cps-dws-data
##   for convenience.

##   The Center for Economic and Policy Research has helpfully compiled
##   DWS data going back to 1994. Our goal is to download all the Stata data sets from
##   http://tutorials.iq.harvard.edu/cps-uniform-data-extracts/cps-displaced-worker-survey/cps-dws-data.

##   Our first task is to read the web page into R. We can do that using the
##   `read_html' function in the rvest package.
## >>>
dataPage <-

## Next we want to find all the links (the `<a>' tags) and extract their `href'
## attributes.

##   Here is what the html for the 2010 data file link looks like:
##   ┌────
##   │ <a onclick="_gaq.push(['_trackEvent', 'File','Download', 'cepr_dws_2010_dta']);"
##   │    href="/wp-content/cps/data/cepr_dws_2010_dta.zip">cepr_dws_2010_dta.zip</a>
##   └────
##   We want the `href' part, i.e.,
##   "/wp-content/cps/data/cepr_dws_2010_dta.zip".

##   We can get all the `<a>' elements using the `html_nodes' function, and
##   then extract the `href' attributes usig the `html_attr' function, like
##   this:
# >>>
allAnchors <- 

allLinks <- 

##   Use regular expressions to extract just the data links.
## >>>
dataLinks <- 

##   Prepend 'http://tutorials.iq.harvard.edu/' to each URL using
##   the `paste' function.
## >>>
dataLinks <-

## Exercise 0: html parsing
## ════════════════════════

##   The [http://ceprdata.org/] website provides code books for the DWS
##   data in `.pdf' format. Links to these code books are available on the
##   documentation page at
##   http://ceprdata.org/cps-uniform-data-extracts/cps-displaced-worker-survey/cps-dws-documentation.
##   Parse this page and extract the links to the code books.


## ════════════════════════



##   The `download.file' function requires a URL as the first argument, and a
##   file name as the second argument. We can write a wrapper around the
##   `download.file' function to make it more convenient for our purposes.
## >>>
downloadFile <-


##   To download all the files conveniently we want to iterate over the
##   vector of URLs and download each one. We can carry out this iteration
##   in several ways, including using a `for' loop, or using one of the
##   `apply' family of functions.

##   For loops in R have the following general structure:
##   `for(<placeholder> in <thing to iterate over>) {do stuff with
##   placeholder}'.
## >>>


##   Alternatively, use the `sapply' function to download all the displaced
##   worker survey data files:
## >>>


## Exercise 1: Iterate and extract
## ═══════════════════════════════

##   Use a `for' loop or `*apply' function to unzip each of the `.zip'
##   files in the `dataSets' directory.

##   BONUS (optional): calculate the size of each extracted file and
##   calculate the difference in size between each `.dta' file and the
##   `.zip' file it was extracted from.

## >>>
zipFiles <- 
dataFiles <- 
## ═══════════════════════════════



## Read in just the first data set.
## >>>

ceprData1 <-

##  What is the mode and length of our `ceprData1' object?
## >>>


##  Ask R what the `class' of the object is.
## >>>


##   Let's take a quick look at the attributes system in R before using it to
##   access the ceprData1 meta-data.
## >>>

##   What other attributes does our data have?
## >>>
cdprDataInfo <- 

##   Iterate over the attributes of =ceprData1- and get
##   some more information about the available meta-data
## >>>


##   We can extract elements from lists in a few different ways:
## >>>


## Exercise 2
## ═══════════════════════════════

##   Extract elements from `ceprDataInfo' that will help you understand
##   what each column in `deprData' contains. Include at least the variable
##   `names' and `var.labels' as well as any other information that you
##   think will be useful.

##   Bonus (optional): supplement the `ceprDataInfo' you extracted in step
##   one with the mode, class, etc. of each column in `ceprData1'


## ═══════════════════════════════



##   Now that we have the data read in, and we know what is in each column,
##   I want to calculate the proportion displaced by year/rural/gender. We
##   can do that using the `aggregate' function (the `data.table' and
##   `dplyr' packages provide advanced aggregation capabilities, but
##   `aggregate' is available in base R and works well for many things).
## >>>


## Exercise 3
## ══════════

##   Now that we have a process for importing and aggregating the data we
##   can apply it to all the data files we downloaded earlier. We can do
##   that by wrapping the `read.dta' and `aggregate' code in a function and
##   applying that function to each element of `ceprDataFiles' using the
##   `sapply' function, or using a `for' loop. Go ahead and give it a try!
##   Note that this exercise is intentionally challenging; read the
##   documentation, search stackoverflow.com, and use any other resources
##   at your disposal as you attempt it.

## >>>
ceprData <-

## ══════════



##  Stack each yearly data set to from a single data.frame 
## >>>
ceprData <- 

##   Format the values for `rural' and `female'.
## >>>


##   Plottrends in worker displacement over time.
## >>>


## What else?
## ══════════

##   If there is anything else you want to learn how to do, now is the time
##   to ask!


## Go forth and code!
## ══════════════════

##   You now know everything you could possibly want to know about R. OK
##   maybe not! But you do know how to manipulate character strings with
##   regular expressions, write your own functions, execute code
##   conditionally, iterate using `for' or `sapply', inspect and modify
##   attributes, and extract and replace object elements. There's a lot
##   more to learn, but that's a pretty good start. As you go forth and
##   write your own R code here are some resources that may be helpful.


## Additional reading and resources
## ────────────────────────────────

##   • Learn from the best: [http://adv-r.had.co.nz/]
##   • S3 system overview: [https://github.com/hadley/devtools/wiki/S3]
##   • S4 system overview: [https://github.com/hadley/devtools/wiki/S4]
##   • R documentation: [http://cran.r-project.org/manuals.html]
##   • Collection of R tutorials:
##     [http://cran.r-project.org/other-docs.html]

##   • R for Programmers (by Norman Matloff, UC–Davis)
##   [http://heather.cs.ucdavis.edu/~matloff/R/RProg.pdf]
##   • Calling C and Fortran from R (by Charles Geyer, UMinn)
##   [http://www.stat.umn.edu/~charlie/rc/]
##   • State of the Art in Parallel Computing with R (Schmidberger et al.)
##   [http://www.jstatso|.org/v31/i01/paper]

##   • Institute for Quantitative Social Science: [http://iq.harvard.edu]
##   • Research technology consulting: [http://projects.iq.harvard.edu/rtc]


## Things that may surprise you
## ────────────────────────────

##   There are an unfortunately large number of surprises in R programming.
##   Some of these "gotcha's" are common problems in other languages, many
##   are unique to R. We will only cover a few – for a more comprehensive
##   discussion please see
##   [http://www.burns-stat.com/pages/Tutor/R_inferno.pdf]

## Feedback
## ────────

##   • Help Us Make This Workshop Better!
##   • Please take a moment to fill out a very short feedback form
##   • These workshops exist for you – tell us what you need!
##   • [http://tinyurl.com/RprogrammingFeedback]
