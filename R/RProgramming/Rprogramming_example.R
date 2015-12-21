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

##   [Displaced Worker Survery]
##   http://ceprdata.org/cps-uniform-data-extracts/cps-displaced-worker-survey/cps-dws-data/



## Extracting elements from html
## ═════════════════════════════

##   It is common for data to be made available on a website somewhere,
##   either by a government agency, research group, or other organizations
##   and entities. Often the data you want is spread over many files, and
##   retrieving it all one file at a time is tedious and time consuming.
##   Such is the case with the CPS data we will be using today.

##   The Center for Economic and Policy Research has helpfully [compiled
##   DWS data going back to 1994][1]. Although we could open a web browser
##   and download these files one at a time, it will be faster and easier
##   to instruct R to do that for us. Doing it this way will also give us
##   an excuse to talk about html parsing, regular expressions, package
##   management, and other useful techniques.

##   Our goal is to download all the Stata data sets from
##   [http://tutorials.iq.harvard.edu/cps-uniform-data-extracts/cps-displaced-worker-survey/cps-dws-data/].
##   In order to do that we need a list of the Uniform Resource Locators
##   (URLs) of those files. The URLs we need are right there as links in
##   the ceprdata.org webpage. All we have to do is read that data in a way
##   R can understand.

##   [compiled DWS data going back to 1994]
##   http://ceprdata.org/cps-uniform-data-extracts/cps-displaced-worker-survey/cps-dws-data/

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
## install.packages("rvest")
library(rvest)

## read the web page into R
dataPage <- read_html("http://tutorials.iq.harvard.edu/cps-uniform-data-extracts/cps-displaced-worker-survey/cps-dws-data/")

## find the link ("a") elements.
allAnchors <- html_nodes(dataPage, "a")
head(allAnchors, 15)

## extract the link ("href") attributes
allLinks <- html_attr(allAnchors, "href")
head(allLinks, 15)

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

dataLinks <- grep("^/wp.*\\.zip$", allLinks, value = TRUE)
head(dataLinks)

##   Finally, the data links we've extracted are relative to the ceprdata
##   website. To make them valid we need to prepend
##   `http://tutorials.iq.harvard.edu/' to each one. We can do that using
##   the `paste' function.
dataLinks <- paste("http://tutorials.iq.harvard.edu", dataLinks, sep = "")
head(dataLinks)

## Getting the list of data links the easy way
## ───────────────────────────────────────────

##   If you look at the result from the previous two methods you might
##   notice that the URLs are all the same save for the year number. This
##   suggests an even easier way to construct the list of URLs:
head(dataLinks <- paste("http://tutorials.iq.harvard.edu/wp-content/cps/data/cepr_dws_",
                    seq(1994, 2010, by = 2),
                    "_dta.zip",
                    sep = ""))

##   Wow, that was a _lot_ easier. Why oh why didn't we just do that in the
##   first place? Well, it works for this specific case, but it is much
##   less general than the html parsing methods we discussed previously.
##   Those methods will work in the general case, while pasting the year
##   number into the URLs only works because the URLs we want have a very
##   regular and consistent form.



## Iterating and defining new functions
## ════════════════════════════════════

##   Now that we have a vector of URLs pointing to the data files we want
##   to download, we want to iterate over the elements and download each
##   file. We could do this verbosely by writing one line for each file:
## download.file(dataLinks[1], "cepr_dws_1979.zip")
## download.file(dataLinks[2], "cepr_dws_1980.zip")
## ...
## download.file(dataLinks[n], "dataSets/cepr_dws_n.zip")
##   but that is too much typing. Much easier to let R do that for us. We
##   can iterate over the elements of a vector in R using a loop, or using
##   one of the `apply' family of functions.

##   `for' and `while' loops in R work much the same as they do in other
##   programming languages. The `apply' family of functions apply a
##   function to each element of an object.

## Writing functions
## ─────────────────

##   We can use the `download.file' function to download the data files.
##   The `download.file' function requires a URL as the first argument, and
##   a file name as the second argument. We can use the `basename' function
##   to strip of the location part of the URL, leaving only the file name:
options(width = 110)
cbind(link = dataLinks, base = basename(dataLinks))

##   It would be more convenient if the `download.file' function defaulted
##   to `destfile = basename(url)'. Fortunately it is very easy to write
##   your own functions in R. We can write a wrapper around the
##   `download.file' function like this:
downloadFile <- function(url, # url to download
                         destfile = basename(url), # default name to save to
                         outdir = "./", # directory to save in
                         ... # other arguments passed to download.file
                         ){
  download.file(url = url, destfile = paste(outdir, destfile, sep = ""), ...)
}

## test it out
downloadFile("http://google.com", quiet = TRUE)
list.files(pattern = "google")
##   > downloadFile <- function(url, destfile = basename(url), …) {
##   ⁃ download.file(url = url, destfile = destfile, …)
##   ⁃ }
##   > ## test it out downloadFile("[http://google.com]", quiet = TRUE)
##   > list.files(pattern = "google")

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
##   and download each one, so this becomes
## make a directory to store the data
dir.create("dataSets")

for(link in dataLinks) {
    downloadFile(link, outdir = "dataSets/")
}

## Iterating over vectors and lists with the `sapply' function
## ───────────────────────────────────────────────────────────

##   The `sapply' function iterates over a vector or list and applies a
##   function to each element. To start, let's use `sapply' do download all
##   the displaced worker survey data files:
## download all the dws data
sapply(dataLinks,
       downloadFile,
       outdir = "dataSets/")

##   For this task (downloading files) there is not much advantage to using
##   `sapply' instead of `for'. The main advantage is the simpler handling
##   of return values. To see this, let's calculate the size of each of the
##   files we downloaded earlier. We've already know how to do this with
##   `sapply';
## get list of files
dataFiles <- list.files("dataSets", pattern = "\\.zip$", full.names = TRUE)
## get file size for each one
fsizes <- sapply(dataFiles,
                 file.size)
fsizes / 1024^2 # in Mb.

##   How can we do that with a for loop? First we need to create a vector
##   to store the results, then as we loop through we need to assign the
##   result to an element of the vector. It's not terrible:
## create vector to store the results
fsizes <- vector(mode = "integer", length = length(dataFiles))
## names for keeping track
names(fsizes) <- dataFiles
## loop over and calculate file.size
for (file in dataFiles) {
  fsizes[[file]] <- file.size(file)
}
fsizes / 1024^2

##   As I said, not terrible, but definitely more complicated than the
##   sapply version.

##   Finally, note also that the previous `for' and `sapply' examples are
##   contrived; `file.size' is vectorized, and the recommended way to get
##   this size of all the files in a directory is simply
file.size(dataFiles)

## Iterating over arrays with the `apply' function
## ───────────────────────────────────────────────

##   Now that we've downloaded some of the ceprdata.org data we might want
##   to get some more information about these files. We can do that using
##   the `file.info' function:
## get file size, mode, and modification time.
## note that "cbind" binds the vectors into a matrix, by column
ceprFileInfo <- cbind(size = file.size(dataFiles),
                      mode = file.mode(dataFiles),
                      mtime = file.mtime(dataFiles))
## add rownames
rownames(ceprFileInfo) <- dataFiles
ceprFileInfo

##   ceprFileInfo is a _matrix_, with each row containing information about
##   one of the files we downloaded.

##   How can we can calculate the means for each column in this matrix? We
##   could do it using `sapply' or `for', something like
sapply(colnames(ceprFileInfo), function(x) mean(ceprFileInfo[ , x]))
##   but this a) requires indexing which we haven't yet talked about, and
##   b) there is an easier way to do it:
## average file size and permissions
(fileInfoAverage <- apply(ceprFileInfo, MARGIN = 2, mean))
## standard deviation of file size and permissions
apply(ceprFileInfo, MARGIN = 2, sd)
## deviation from the average
apply(ceprFileInfo, MARGIN = 1, function(x) x - fileInfoAverage) #

##   Now that we understand iteration in R we we want to import and process
##   the files we downloaded from ceprdata.org. First we need to unzip
##   them.
sapply(dataFiles, unzip)
ceprDataFiles <- list.files(pattern = "\\.dta$")

##   Finally we can read our data into R, but I leave that to you! Use a
##   for loop or `sapply' (preferred) to read in each DWS data file. You
##   can use the `read.dta' function from the foreign package to read these
##   data files into R.

## Exersise 1
## ──────────

##   Read in all the DWS data we downloaded and unzipped earlier.

##   BONUS (optional): calculate the size of each of the data sets you read
##   in.



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
##   the mode and length of our `ceprData' object?
mode(ceprData)
length(ceprData)

##   Additional attributes and be accessed vie the `attributes' function.
##   Let's see what other attributes our `ceprData' object has.
attributes(ceprData)

##   OK, so far we know that ceprData is a list of length 6 and that it has
##   a names attribute. How can we find out what is inside the list?

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

## what do we get when we extract one element with single brackets?
length(ceprData[1]); mode(ceprData[1]); class(ceprData[1]); attributes(ceprData[1])
## what do we get when we extract the middle two elements with single brackets?
length(ceprData[2:3]); mode(ceprData[2:3]); class(ceprData[2:3]); attributes(ceprData[2:3])
## what do we get when we extract the first element with a double bracket
length(ceprData[[1]]); mode(ceprData[[1]]); class(ceprData[[1]])#

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

ceprDataInfo <- attributes(ceprData[[1]])
mode(ceprDataInfo)
class(ceprDataInfo)
length(ceprDataInfo)
names(ceprDataInfo)
(ceprInfoLength <- sapply(ceprDataInfo, length))

##   `ceprInfoLength' is an /atomic vector/, i.e., a vector with all
##   elements of the same mode. We can index a vector with `[' and `[[',
##   just as we do for lists.

mode(ceprInfoLength); class(ceprInfoLength); length(ceprInfoLength)
ceprInfoLength[1]
ceprInfoLength[[1]]
ceprInfoLength[1:10]

##   The code above is an example of /indexing by position/. We can also
##   index by /name/ or using /logical indexing/ as shown below.
ceprInfoLength[c("names", "formats", "types")]
ceprInfoLength[grepl("lab", names(ceprInfoLength))]
ceprInfoLength[ceprInfoLength == 1]
names(ceprInfoLength)[ceprInfoLength == 1]

##   Finally, we can use negation and negative indices to reverse the usual
##   meanings.
ceprInfoLength[- c(3, 7, 9)]
ceprInfoLength[setdiff(names(ceprInfoLength), c("names", "formats", "types"))]
ceprInfoLength[!grepl("lab", names(ceprInfoLength))]

## Indexing matrices
## ╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌

##   Now that we know a little more about indexing, let's get back to
##   investigating the ceprData metadata.

(infoInfo <- sapply(ceprDataInfo, function(x) {
  return(c(mode = mode(x), class = class(x), length = length(x)))
  }))

##   `infoInfo' contains information about the contents of `ceprDataInfo'.
##   `infoInfo' is a /matrix/. A matrix in R is simply a vector with two
##   dimensions. We can index a matrix exactly as we do a vector:
infoInfo
infoInfo[c(1, 3, 9)]

##   but more commonly we will index a matrix by referring to both
##   dimensions, like this:
infoInfo[1:2, c(7, 3, 1)]
infoInfo[ , 1:2]
infoInfo[3:2, ]

##   All the techniques we learned for indexing vectors apply. For example:
attributes(infoInfo)
infoInfo[c("length", "mode"), grepl("name", colnames(infoInfo))]

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

ceprData <- sapply(ceprData, function(x) {
  aggregate(x["wkswo"],
            by = x[c("year", "state", "rural", "female")],
            FUN = median, na.rm = TRUE)},
  simplify = FALSE)

##   In particular combine all the data together into a single data.frame.
##   Right now we have a list of data.frames, and we simply want to stack
##   this one on top of the other. We can do that with the `rbind'
##   function. (Other ways you might want to combine data are described in
##   `?cbind' and `?merge').

##   A straightforward way to combine the data looks like this
#ceprData <- rbind(ceprData[[1]], ceprData[[2]], ceprData[[3]], ceprData[[4]])
##   and that's not too bad for four elements. But what if we had 100 or
##   1000000? You certainly don't want to type that many elements out
##   yourself. Instead you can use `Reduce' to flatten the list, like this:
ceprData <- Reduce("rbind", ceprData)

##   Now we can take a look at the trends in wages over the last few years.
library(ggplot2)
ggplot(ceprData, aes(x = year, y = wkswo, color = factor(female), linetype = factor(rural))) +
  geom_line() +
  facet_wrap(~state, ncol = 9) +
  coord_cartesian(ylim = c(0, 50)) +
  theme_minimal()



## Writing smarter functions: Control flow and the S3 system
## ═════════════════════════════════════════════════════════

##   Earlier we wrote a simple function to download a file from the
##   internet. Our simple function looked like this:
downloadFile <- function(url, # url to download
                         destfile = basename(url), # default name to save to
                         outdir = "./", # directory to save in
                         ... # other arguments passed to download.file
                         ){
  download.file(url = url, destfile = paste(outdir, destfile, sep = ""), ...)
}
##   This was fine for our purpose at the time, but if we want to make this
##   function more generally useful there are a number of things that we
##   might want to do:
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
##   optional). The arglist of our function so far is
args(downloadFile)

##   As we've seen, values can be functions of other keys. We've used that
##   to set a reasonable default for the names of the files we are
##   downloading, while still offering the user of our function the
##   flexibility to specify alternative names.

## Iteration and control flow
## ──────────────────────────

##   Next we want to modify our function so that it will download files
##   from a vector of URLs. Note that `download.file' already handles this
##   when using the libcurl method, but libcurl is not available on every
##   system.
downloadFiles <- function(urls, # url(s) to download
                          destfile = basename(urls), # default name to save to
                          outdir = "./", # directory to save in
                          ... # other arguments passed to download.file
                          ){
  if(length(urls) == 1) {# if there is only one url, download it.
    download.file(url = urls, destfile = paste(outdir, destfile, sep = ""), ...)
  } else {# if there is more than one url, use downloadFiles (recursion!) to download them
    mapply(downloadFiles, urls = urls, destfile = destfile, outdir = outdir, MoreArgs = list(...))
  }
}

##   By wrapping a section of our code in an `if' statement we ensure that
##   it is only evaluated when the condition is satisfied.

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

x <- 1:10
class(x)
class(x) <- "foo"
class(x)

##   Objects are not limited to a single class, and can have many classes:

class(x) <- c("A", "B")
class(x)

## Function methods
## ╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌

##   • Functions can have many methods, allowing us to have (e.g.) one
##     plot() function that does different things depending on what is
##     being plotted()
##   • Methods can only be defined for generic functions: plot, print,
##     summary, mean, and several others are already generic

# see what methods have been defined for the mean function
methods(mean)
# which functions have methods for data.frames?
methods(class="data.frame")[1:9]

## Creating new function methods
## ╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌

##   To create a new method for a function that is already generic all you
##   have to do is name your function `function.class'

# create a mean() method for objects of class "foo":
mean.foo <- function(x) { # mean method for "foo" class
  if(is.numeric(x)) {
    cat("The average is", mean.default(x))
    return(invisible(mean.default(x))) #use mean.default for numeric
  } else
    cat("x is not numeric \n")} # otherwise say x not numeric

x <- 1:10
mean(x)
class(x) <- "foo"
mean(x)

x <- as.character(x)
class(x) <- "foo"
mean(x)

## Creating generic functions
## ╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌

##   S3 generics are most often used for print, summary, and plot methods,
##   but sometimes you may want to create a new generic function. Such is
##   the case with our `downloadFiles' function. To make this function
##   generic we need to set the body of the function to
##   `UseMethod("downloadFiles")', like this:
downloadFiles <- function(urls, ...) {
  UseMethod("downloadFiles")
}
##   Note that the `...' allows us to pass additional arguments to the
##   methods used for specific classes.

##   Next we need to define methods for character strings and for parsed
##   xml documents crated by the `rvest' package.

##   First we define a default method to be used when `urls' is a character
##   vector.
downloadFiles.default <- function(urls, # url(s) to download
                                  destfile = basename(urls), # default name to save to
                                  outdir = "./" # directory to save in
                                  ){
  ## create output directory if it doesn't exist
  if(!dir.exists(outdir)) dir.create(outdir)
  if(length(urls) == 1) {# if there is only one url, download it.
    download.file(url = urls, destfile = paste(outdir, destfile, sep = ""))
  } else {# if there is more than one url, use downloadFiles (recursion!) to download them
    mapply(downloadFiles, urls = urls, destfile = destfile, MoreArgs = list(outdir = outdir))
  }
}

##   Next we define a method to be used when "urls" is a xml document.
downloadFiles.xml_document <- function(url,  outdir = "./", base_url, pattern=NULL) {
  anodes <- html_nodes(url, css = "a")
  urls <- html_attr(anodes, name = "href")
  if(!is.null(pattern)) urls <- grep(pattern, urls, value = TRUE)
  urls[!grepl("^http", urls)] <- paste(base_url, urls[!grepl("^http", urls)], sep = "/")
  downloadFiles.default(urls = urls, outdir=outdir)
  }

##   Now we can call a single function that will do the right thing when we
##   give it a vector of urls and when we give it a parsed html page
##   containing links. Lets try it out!

file.remove(list.files("tmp"))
downloadFiles("http://tutorials.iq.harvard.edu", outdir = "tmp/")
list.files("tmp")
downloadFiles(read_html("http://tutorials.iq.harvard.edu"),
              outdir = "tmp/",
              base_url = "http://tutorials.iq.harvard.edu",
              pattern = "R/")
list.files("tmp")



## Things that may surprise you
## ════════════════════════════

##   There are an unfortunately large number of surprises in R programming.
##   Some of these "gotcha's" are common problems in other languages, many
##   are unique to R. We will only cover a few – for a more comprehensive
##   discussion please see
##   [http://www.burns-stat.com/pages/Tutor/R_inferno.pdf]

## Floating point comparison
## ─────────────────────────

##   Floating point arithmetic is not exact:
.1 == .3/3

##   Solution: `use all.equal()':
all.equal(.1, .3/3)

## Missing values
## ──────────────

##   R does not exclude missing values by default – a single missing value
##   in a vector means that many thing are unknown:
x <- c(1:10, NA, 12:20)
c(mean(x), sd(x), median(x), min(x), sd(x))

##   NA is not equal to anything, not even NA
NA == NA

##   Solutions: use `na.rm = TRUE' option when calculating, and is.na to
##   test for missing

## Automatic type conversion
## ─────────────────────────

##   Automatic type conversion happens a lot which is often useful, but
##   makes it easy to miss mistakes

# combining values coereces them to the most general type
(x <- c(TRUE, FALSE, 1, 2, "a", "b"))
str(x)

# comparisons convert arguments to most general type
1 > "a"

##   Maybe this is what you expect… I would like to at least get a warning!

## Optional argument inconsistencies
## ─────────────────────────────────

##   Functions you might expect to work similarly don't always:

mean(1, 2, 3, 4, 5)*5
sum(1, 2, 3, 4, 5)

##   Why are these different?!?
args(mean)
args(sum)

##   Ouch. That is not nice at all!

## Trouble with Factors
## ────────────────────

##   Factors sometimes behave as numbers, and sometimes as characters,
##   which can be confusing!

(x <- factor(c(5, 5, 6, 6), levels = c(6, 5)))

str(x)

as.character(x)
# here is where people sometimes get lost...
as.numeric(x)
# you probably want
as.numeric(as.character(x))



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



## OLD STUFF
## ═════════

## Vector types
## ────────────

##   Vectors are the building blocks of data objects in R. There are a few
##   basic types, including `logical', `integer' , `double', `complex', and
##   `character'. Values can be combined into vectors using the `c()'
##   function.
num.var <- c(1, 2, 3, 4) # numeric vector
char.var <- c("1", "2", "3", "4") # character vector
log.var <- c(TRUE, TRUE, FALSE, TRUE) # logical vector
char.var2 <- c(num.var, char.var) # numbers coverted to character

##   Vectors can be converted from one class to another using one of the
##   many functions beginning with `as.', e.g., `as.numeric' and
##   `as.character'.
class(char.var2)
num.var2 <- as.numeric(char.var2) # convert to numeric
class(num.var2)
mean(as.numeric(char.var2)) # now we can calculate the mean
as.numeric(c("a", "b", "c")) # cannot convert letters to numeric

## Vector attributes
## ─────────────────

##   Vectors (and other R objects for that matter) will always have `mode'
##   and `length' attributes. They may optionally have other attributes
##   such as names or comments.
ls() # list objects in our workspace
length(char.var) # how many elements in char.var?
str(num.var2) # what is the structure of num.var2?
names(num.var2) <- paste("element", seq_along(num.var2))
str(num.var2)

> ls() # list objects in our workspace
[1] "char.var"  "char.var2" "log.var"   "num.var"   "num.var2"
[6] "tmp"
> length(char.var) # how many elements in char.var?
[1] 4
> str(num.var2) # what is the structure of num.var2?
 num [1:8] 1 2 3 4 1 2 3 4
>

## Factor vectors
## ──────────────

##   Factors are stored as numbers, but have character labels. Factors are
##   useful for
##   • Modeling (automatically contrast coded)
##   • Sorting/presenting values in arbitrary order

##   Most of the time we can treat factors as though they were character
##   vectors

## Lists and data.frames
## ─────────────────────

##   • A /data.frame/ is a list of vectors, each of the same length
##   • A /list/ is a collection of objects each of which can be almost
##     anything

DF <- data.frame(x=1:5, y=letters[1:5])
DF # data.frame with two columns and 5 rows
DF$x # select just the x column.

# DF <- data.frame(x=1:10, y=1:7) # illegal becase lengths differ
L <- list(x=1:5, y=1:3, z = DF)
L # lists are much more flexible!

## Data types summary
## ──────────────────

##   Key points:
##   • vector classes include numeric, logical, character, and factors
##   • vectors can be combined into lists or data.frames
##   • a data.frame can almost always be thought of as a list of vectors of
##     equal length
##   • a list is a collection of objects, each of which can by of almost
##     any type
##   Functions introduced in this section:
##   c: combine elements
##   as.numeric: convert an object (e.g., a character verctor) to numeric
##   data.frame: combine oject into a data.frame
##   ls: list the objects in the workspace
##   class: get the class of an object
##   str: get the structure of an object
##   length: get the number of elements in an object
##   mean: calculate the mean of a vector
##   $: extraction operator, selects a single element from a list or
##      data.frame

## Exercise 0
## ──────────

##   Use the built-in /iris/ data set (comes with R, will be available in
##   your workspace automatically).
##   1. Determine the `class' and `str' ucture of the /iris/ data set.
##   2. Determine the class of each column in the iris data set
##   3. BONUS (OPTIONAL): Create a new variable by `c' ombining the
##      Petal.Length and Petal.Width columns
##   4. BONUS (OPTIONAL): Create a new data.frame with two columns; the
##      first should be named /value/, and should be equal to the variable
##      you created in step 3. The second should be named /variable/ and
##      should be either /Petal.Length/ or /Petal.Width/ as appropriate.



## Footnotes
## ─────────

## [1] Center for Economic and Policy Research. 2012. CPS Displaced Worker
## Uniform Extracts, Version 1.02. Washington, DC.

## [2] Photo by Hadley Wickham via
## [https://twitter.com/hadleywickham/status/643381054758363136/photo/1].
## Used by permission.
