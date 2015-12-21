##                    ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
##                     INTRODUCTION TO PROGRAMMING IN R
##                    ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━


## Table of Contents
## ─────────────────

## Workshop overview and materials
## Extracting elements from html
## Iterating and defining new functions
## Objects, attributes, and indexing
## Aggregating and combining data
## Writing smarter functions: Control flow and the S3 system
## Things that may surprise you
## What else?
## Additional resources


## Workshop overview and materials
## ═══════════════════════════════

## Workshop description
## ────────────────────

##   This is an intermediate/advanced R course appropriate for those with
##   basic knowledge of R. It is intended for those already comfortable
##   with using R for data analysis who wish to move on to writing their
##   own functions. To the extent possible this workshop uses real-world
##   examples. That is to say that concepts are introduced as they are
##   needed for a realistic analysis task. In the course of working through
##   a realistic project we will lean about interacting with web services,
##   regular expressions, iteration, functions, control flow and more.

##   Prerequisite: basic familiarity with R, such as acquired from an
##   introductory R workshop.


## Materials and setup
## ───────────────────

##   Everyone should have R installed – if not:

##   • Open a web browser and go to [http://cran.r-project.org] and
##     download and install it
##   • Also helpful to install RStudio (download from [http://rstudio.com])

##   Materials for this workshop include slides, example data sets, and
##   example code.

##   • Download materials from
##     [http://tutorials.iq.harvard.edu/R/RProgramming.zip]
##   • Extract the zip file containing the materials to your desktop


## Example project overview
## ────────────────────────

##   Throughout this workshop we will return to a running example that
##   involves acquiring, processing, and analyzing data from the [Displaced
##   Worker Survery] (DWS). In this context we will learn about finding and
##   using R packages, importing and manipulating data, writing functions,
##   and more. The web page has been mirrored at
##   [http://tutorials.iq.harvard.edu/cps-uniform-data-extracts-cps-displaced-worker-survey/cps-dws-data]
##   for convenience.


## Extracting elements from html
## ═════════════════════════════

##   It is common for data to be made available on a website somewhere, either
##   by a government agency, research group, or other organizations and
##   entities. Although we could open a web browser and download these files one
##   at a time, it will be faster and easier to instruct R to do that for us.
##   Doing it this way will also give us an excuse to talk about html parsing,
##   regular expressions, package management, and other useful techniques.

##   Our goal is to download all the Stata data sets from
##   [http://tutorials.iq.harvard.edu/cps-uniform-data-extracts/cps-displaced-worker-survey/cps-dws-data/].
##   In order to do that we need a list of the Uniform Resource Locators
##   (URLs) of those files. The URLs we need are right there as links in
##   the ceprdata.org webpage. All we have to do is read that data in a way
##   R can understand.


## Packages for parsing html
## ─────────────────────────

##   In order extract the data URls from the ceprdata.org website we need a
##   package for parsing XML and HTML. How do we find such a package?
##   Task views: [https://cran.r-project.org/web/views/WebTechnologies.html]
##   R package search: [http://www.r-pkg.org/search.html?q=html+xml]
##   Web search: [https://www.google.com/search?q=R+parse+html+xml&ie=utf-8&oe=utf-8]

##   For parsing html in R I recommend either the `xml2' package or the
##   `rvest' package, with the former being more flexible and the later
##   being more user friendly. Let's use the friendlier one.


## Extracting information from web pages with the `rvest' package
## ──────────────────────────────────────────────────────────────

##   Our first task is to read the web page into R. We can do that using
##   the `read_html' function. Next we want to find all the links (the
##   `<a>' tags) and extract their `href' attributes. To give a better
##   sense of this here is what the html for the 2010 data file link looks
##   like:
##   ┌────
##   │ <a onclick="_gaq.push(['_trackEvent', 'File','Download', 'cepr_dws_2010_dta']);"
##   │    href="/wp-content/cps/data/cepr_dws_2010_dta.zip">cepr_dws_2010_dta.zip</a>
##   └────
##   We want the `href' part, i.e.,
##   "/wp-content/cps/data/cepr_dws_2010_dta.zip".

##   We can get all the `<a>' elements using the `html_nodes' function, and
##   then extract the `href' attributes usig the `html_attr' function, like
##   this:


## Just the data please – regular expressions to the rescue
## ────────────────────────────────────────────────────────

##   Looking at the output from the previous example you might notice a
##   problem; we've matched _all_ the URLs on the web page. Some of those
##   (the ones that end in .zip) are the ones we want, others are menu
##   links that we don't want. How can we separate the data links from the
##   other links on the page?

##   One answer is to use regular expressions to idenfify the links we
##   want. Regular expressions are useful in general (not just in R!) and
##   it is a good idea to be familiar with at least the basics. For our
##   present purpose it will be more than enough to use regular expression
##   that matches strings starting with `/wp' and ending with `.zip'.

##   In regulars expression `^', `.', `*', and `$' are special characters
##   with the following meanings:
##   ^: matches the beginning of the string
##   .: matches any character
##   *: repeates the last caracter zero or more times
##   $: matches the end of the string

##   The backslashes in `\\.' are used to escape the `.' so that it is
##   matched literally instead of matching any characters as it normallly
##   would in a regular expression.

##   If you have not been introduced to regular expressions yet a nice
##   interactive regex tester is available at [http://www.regexr.com/] and
##   an interactive tutorial is available at [http://www.regexone.com/].

##   R comes with a `grep' function that can be used to search for patterns
##   in strings, but for more sophisticated string manipulation I recommend
##   the `stringi' package. The function names are more verbose, but it
##   provides much more complete and robust string handling than is
##   available in base R. For our relatively simple needs `grep' will
##   suffice, but if you need to do extensive string manipulation in R the
##   `stringi' package is the way to go.



## Getting the list of data links the easy way
## ───────────────────────────────────────────

##   If you look at the result from the previous two methods you might
##   notice that the URLs are all the same save for the year number. This
##   suggests an even easier way to construct the list of URLs: 



##   Wow, that was a _lot_ easier. Why oh why didn't we just do that in the
##   first place? Well, it works for this specific case, but it is much less 
##   general than the html parsing methods we discussed previously. Those 
##   methods will work in the general case, while pasting the year number into
##   the URLs only works because the URLs we want have a very regular and
##   consistent form.


## Iterating and defining new functions
## ════════════════════════════════════

##   Now that we have a vector of URLs pointing to the data files we want
##   to download, we want to iterate over the elements and download each
##   file. We could do this verbosely by writing one line for each file
##   but that is too much typing. Much easier to let R do that for us. We
##   can iterate over the elements of a vector in R using a loop, or using
##   one of the `apply' family of functions.



## Writing functions
## ─────────────────

##   We can use the `download.file' function to download the data files.
##   The `download.file' function requires a URL as the first argument, and
##   a file name as the second argument. We can use the `basename' function
##   to strip of the location part of the URL, leaving only the file name:
##   It would be more convenient if the `download.file' function defaulted
##   to `destfile = basename(url)'. Fortunately it is very easy to write
##   your own functions in R. We can write a wrapper around the
##   `download.file' function like this:


## Iterating using for-loop
## ────────────────────────

##   One way to download the data files is to use a for-loop to iterate
##   over the contents of our vector of URLs. Some people will tell you to
##   avoid for-loops in R but this is nonsense. Loops are convenient and
##   useful, and while they are not the best tool for all situations
##   calling for iteration they are perfectly appropriate for downloading a
##   series of files. If you've used a for loop in any other language you
##   will probably find the R implementation to be very similar.

##   Finally we can write a for loop to iterate over the data links and
##   download the files. For loops in R have the following general
##   structure: `for(<placeholder> in <thing to iterate over>) {do stuff
##   with placeholder}'. In our case we want to iterate over `dataLinks'
##   and download each one, so this becomes:


## Iterating over vectors and lists with the `sapply' function
## ───────────────────────────────────────────────────────────

##   The `sapply' function iterates over a vector or list and applies a
##   function to each element. To start, let's use `sapply' do download all
##   the displaced worker survey data files: For this task (downloading
##   files) there is not much advantage to using `sapply' instead of `for'.
##   The main advantage is the simpler handling of return values. To see
##   this, let's calculate the size of each of the files we downloaded
##   earlier. We've already know how to do this with `sapply'; How can we
##   do that with a for loop? First we need to create a vector to store the
##   results, then as we loop through we need to assign the result to an
##   element of the vector. It's not terrible:


## Iterating over arrays with the `apply' function
## ───────────────────────────────────────────────

##   Now that we've downloaded some of the ceprdata.org data we might want
##   to get some more information about these files. We can do that using
##   the `file.info' function: ceprFileInfo is a _matrix_, with each row
##   containing information about one of the files we downloaded.

##   How can we can calculate the means for each column in this matrix? We
##   could do it using `sapply' or `for', something like but this a)
##   requires indexing which we haven't yet talked about, and b) there is
##   an easier way to do it: Now that we understand iteration in R we we
##   want to import and process the files we downloaded from ceprdata.org.
##   First we need to unzip them. Finally we can read our data into R, but
##   I leave that to you! Use a for loop or `sapply' (preferred) to read in
##   each DWS data file. You can use the `read.dta' function from the
##   foreign package to read these data files into R.


## Exersise 1
## ──────────

##   Read in all the DWS data we downloaded and unzipped earlier.

##   BONUS (optional): calculate the size of each of the data sets you read
##   in.


## Exercise 1 prototype                                         :prototype:
## ────────────────────


## Objects, attributes, and indexing
## ═════════════════════════════════

##   Now that we've read in the cepr.org data we want to get some more
##   information about it.


## Mode and length
## ───────────────

##   Information about objects in R are stored as /attributes/ of the
##   object. All R objects have a storage /mode/ and a /length/. Since all
##   objects in R have the attributes we refer to them as /intrinsic
##   attributes/. We can get the value of these intrinsic attributes using
##   the `mode' and `length' functions respecively. For example, what is
##   the mode and length of our `ceprData' object? Additional attributes
##   and be accessed vie the `attributes' function. Let's see what other
##   attributes our `ceprData' object has. OK, so far we know that ceprData
##   is a list of length 6 and that it has a names attribute. How can we
##   find out what is inside the list?


## Indexing
## ────────

##   We can extract or replace elements of R objects using bracket
##   indexing. Exactly how indexing works differs slightly depending on
##   what kind of object we are working with.


## Indexing lists
## ╌╌╌╌╌╌╌╌╌╌╌╌╌╌

##   For lists we can index using a single bracket to extract one or more
##   elements of the list, or we can index using double brackets to extract
##   a single element.

##   Right. So what have we learned? We've learned that indexing lists
##   works like this: [file:images/HadleyWickham_index_list.png][2]

##   We've also learned that `ceprData[[1]]' has mode `list' but /class/
##   `data.frame'. We can find out more about these data structures by
##   reading their help pages (`?list' and `?data.frame'), but briefly a
##   data.frame is a special kind of list that is constrained such that all
##   elements have the same length. A data.frame is a rectangular structure
##   that can be indexed by rows and columns (more on this in a moment).


## Indexing vectors
## ╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌

##   You may have noticed in the previous code example that I did _not_ ask
##   for `attributes(ceprData[[1]])'. The reason for that is that each
##   element of `ceprDATA' is a `data.frame' with a large number of
##   attributes. Let's look at those attributes in a bit more detail.

##   `ceprInfoLength' is an /atomic vector/, i.e., a vector with all
##   elements of the same mode. We can index a vector with `[' and `[[',
##   just as we do for lists.

##   We can also index by /name/ or using /logical indexing:

##   Finally, we can use negation and negative indices to reverse the usual 
##   meanings.


## Indexing matrices
## ╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌

##   Now that we know a little more about indexing, let's get back to
##   investigating the ceprData metadata.

##   A matrix in R is simply a vector with two dimensions. We can index a matrix
##   exactly as we do a vector:

##   More commonly we will index a matrix by referring to both dimensions, like 
##   this:


##   All the techniques we learned for indexing vectors apply. For example:


## Indexing data.frames
## ╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌

##   As we noted earlier data.frames are a special kind of list. Therefore
##   both `[' and `[[' indexing will work exactly as they do for lists.
##   Unlike other lists, data.frames have two dimensions (like a matrix),
##   so two-dimensional indexing works on data.frames just as it does for
##   matrices.


## Exercise 2
## ╌╌╌╌╌╌╌╌╌╌

##   Extract elements from `ceprDataInfo' that will help you understand
##   what each column in `deprData' contains. Include at least the variable
##   `names' and `var.labels' as well as any other information that you
##   think will be useful.


## Aggregating and combining data
## ══════════════════════════════

##   Now that we have all the data read in, and we know what is in each
##   column, I want to aggregate the data to down to a managable size.
##   Specifically I want to calculate the average income by
##   state/year/rural/gender. I can do that using the `aggregate' function
##   (the `data.table' and `dplyr' packages provide advanced aggregation
##   capabilities, but `aggregate' is available in base R and works well
##   for many things).

##   Right now we have a list of data.frames, and we simply want to stack
##   this one on top of the other. We can do that with the `rbind'
##   function. (Other ways you might want to combine data are described in
##   `?cbind' and `?merge').


##   Now we can take alook at the trends in wages over the last few years:


## Writing smarter functions: Control flow and the S3 system
## ═════════════════════════════════════════════════════════

##   Earlier we wrote a simple function to download a file from the
##   internet. Our simple function looked like this: This was fine for our
##   purpose at the time, but if we want to make this function more
##   generally useful there are a number of things that we might want to
##   do:
##   • make it download multiple files from a vector of URLs
##   • make it work with both strings and parsed html

##   In order to accomplish these things we need to lean a little more
##   about function arguments, control flow, and classes and methods. Lets
##   start with function arguments.


## Function arguments
## ──────────────────

##   Functions in R have three componants: an /arglist/, a /body/ and an
##   /environment/. For the moment we are only concerned with the first
##   two.

##   An /arglist/ consists of key-value pairs (with the value being
##   optional). The arglist of our function so far is As we've seen, values
##   can be functions of other keys. We've used that to set a reasonable
##   default for the names of the files we are downloading, while still
##   offering the user of our function the flexibility to specify
##   alternative names.


## Iteration and control flow
## ──────────────────────────

##   Next we want to modify our function so that it will download files
##   from a vector of URLs. Note that `download.file' already handles this
##   when using the libcurl method, but libcurl is not available on every
##   system. By wrapping a section of our code in an `if' statement we
##   ensure that it is only evaluated when the condition is satisfied.


## The S3 object class system
## ──────────────────────────

##   Our next goal is to make our function work with both text strings and
##   with parsed html objects created by the `rvest' package. To do that we
##   need to undersdand S3 classes and methods in R.

##   R has three major object systems:
##   • Relatively informal "S3" classes
##   • Stricter, more formal "S4" classes
##   • New and improved "Reference class" system
##   We will cover only the S3 system, not the S4 system. Basic idea:
##   functions have different methods for different types of objects.


## Object class
## ╌╌╌╌╌╌╌╌╌╌╌╌

##   The class of an object can be retrieved and modified using the
##   `class()' function:

##   Objects are not limited to a single class, and can have many classes:


## Function methods
## ╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌

##   • Functions can have many methods, allowing us to have (e.g.) one
##     plot() function that does different things depending on what is
##     being plotted()
##   • Methods can only be defined for generic functions: plot, print,
##     summary, mean, and several others are already generic


## Creating new function methods
## ╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌

##   To create a new method for a function that is already generic all you
##   have to do is name your function `function.class'


## Creating generic functions
## ╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌

##   S3 generics are most often used for print, summary, and plot methods,
##   but sometimes you may want to create a new generic function. Such is
##   the case with our `downloadFiles' function. To make this function
##   generic we need to set the body of the function to
##   `UseMethod("downloadFiles")', like this: Note that the `...' allows us
##   to pass additional arguments to the methods used for specific classes.

##   Next we need to define methods for character strings and for parsed
##   xml documents crated by the `rvest' package.

##   First we define a default method to be used when `urls' is a character
##   vector. Next we define a method to be used when "urls" is a xml
##   document. Now we can call a single function that will do the right
##   thing when we give it a vector of urls and when we give it a parsed
##   html page containing links. Lets try it out!


## Things that may surprise you
## ════════════════════════════

##   There are an unfortunately large number of surprises in R programming.
##   Some of these "gotcha's" are common problems in other languages, many
##   are unique to R. We will only cover a few – for a more comprehensive
##   discussion please see
##   [http://www.burns-stat.com/pages/Tutor/R_inferno.pdf]


## Floating point comparison
## ─────────────────────────

##   Floating point arithmetic is not exact: Solution: `use all.equal()':


## Missing values
## ──────────────

##   R does not exclude missing values by default – a single missing value
##   in a vector means that many thing are unknown: NA is not equal to
##   anything, not even NA Solutions: use `na.rm = TRUE' option when
##   calculating, and is.na to test for missing


## Automatic type conversion
## ─────────────────────────

##   Automatic type conversion happens a lot which is often useful, but
##   makes it easy to miss mistakes

##   Maybe this is what you expect… I would like to at least get a warning!


## Optional argument inconsistencies
## ─────────────────────────────────

##   Functions you might expect to work similarly don't always:

##   Why are these different?!? Ouch. That is not nice at all!


## Trouble with Factors
## ────────────────────

##   Factors sometimes behave as numbers, and sometimes as characters,
##   which can be confusing!


## What else?
## ══════════

##   If there is anything else you want to learn how to do, now is the time
##   to ask!


## Additional resources
## ════════════════════

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


## Feedback
## ────────

##   • Help Us Make This Workshop Better!
##   • Please take a moment to fill out a very short feedback form
##   • These workshops exist for you – tell us what you need!
##   • [http://tinyurl.com/RprogrammingFeedback]



## Footnotes
## ─────────

## [1] Center for Economic and Policy Research. 2012. CPS Displaced Worker
## Uniform Extracts, Version 1.02. Washington, DC.

## [2] Photo by Hadley Wickham via
## [https://twitter.com/hadleywickham/status/643381054758363136/photo/1].
## Used by permission.
