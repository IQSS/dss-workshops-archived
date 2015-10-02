##                    ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
##                     INTRODUCTION TO PROGRAMMING IN R
##                    ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

##                                    ""

## Table of Contents
## ─────────────────

## Workshop overview and materials
## Regular expressions, html parsing
## Iterating and defining new functions
## Objects, attributes, and indexing
## Aggregating and combining data
## The S3 object class system
## Things that may surprise you
## What else?
## Additional resources
## OLD STUFF
## .. Vector types
## .. Vector attributes
## .. Factor vectors
## .. Lists and data.frames
## .. Data types summary
## .. Exercise 0


## Workshop overview and materials
## ═══════════════════════════════

## Workshop description
## ────────────────────

##   This is an intermediate/advanced R course appropriate for those with
##   basic knowledge of R. It is intended for those already comfortable
##   with using R for data analysis who wish to move on to writing their
##   own functions. To the extent possible this workshop uses real-world
##   examples. That is to say that concepts are introduced as they are
##   needed for a realistic analysis task.

##   Prerequisite: basic familiarity with R, such as acquired from an
##   introductory R workshop.

##   • Learning objectives:
##     • Index data objects by position, name or logical condition
##     • Understand looping and branching
##     • Write your own simple functions
##     • Debug functions
##     • Understand and use the S3 object system

##   This workshop is free for Harvard and MIT affiliates. [Click here to
##   sign up!]

##   • Instructor - [Ista Zahn]
##   • Location - Rm K018, 1737 Cambridge St (CGIS Knafel Building)

##   For further details and registration information, please contact us at
##   [dataclass@help.hmdc.harvard.edu]

##   [Click here to sign up!]
##   http://projects.iq.harvard.edu/rtc/workshop-registration

##   [Ista Zahn] http://projects.iq.harvard.edu/rtc/people/ista-zahn

##   [dataclass@help.hmdc.harvard.edu]
##   mailto:dataclass@help.hmdc.harvard.edu

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
##   involves acquiring, processing, and analyzing data from the [Current
##   Population Survey] (CPS). In this context we will learn about finding
##   and using R packages, importing and manipulating data, writing
##   functions, and more.

##   [Current Population Survey] http://www.census.gov/cps/

## Regular expressions, html parsing
## ═════════════════════════════════

##   It is common for data to be made available on a website somewhere,
##   either by a government agency, research group, or other organizations
##   and entities. Often the data you want is spread over many files, and
##   retrieving it all one file at a time is tedious and time consuming.
##   Such is the case with the CPS data we will be using today.

##   The Center for Economic and Policy Research has helpfully [compiled
##   CPS data going back to 1979][1], one file per year. Although we could
##   open a web browser and download these files one at a time, it will be
##   faster and easier to instruct R to do that for us. Doing it this way
##   will also give us an excuse to talk about regular expressions, package
##   management, and other useful techniques.

##   Our goal is to download all the Stata data sets from
##   [http://ceprdata.org/cps-uniform-data-extracts/cps-outgoing-rotation-group/cps-org-data/].
##   In order to do that we need a list of the Uniform Resource Locators
##   (URLs) of those files. The URLs we need are right there as links in
##   the ceprdata.org webpage. All we have to do is read that data in a way
##   R can understand.

##   [compiled CPS data going back to 1979]
##   http://ceprdata.org/cps-uniform-data-extracts/cps-outgoing-rotation-group/cps-org-data/

## Searching text with regular expressions
## ───────────────────────────────────────

##   Although some will say you should never ever attempt to extract
##   information from html using regular expressions[2], it does work OK
##   for simple tasks.  More generally regular expressions are useful in
##   general (not just in R!) and it is a good idea to be familiar with at
##   least the basics. If you have not been introduced to regular expressions
##   yet a nice interactive regex tester is available at [http://www.regexr.com/]
##   and an interactive tutorial is available at [[http://www.regexone.com/]]

The fist step is to read the html into R. We can do
##   that using the `readLines' function, like this:

## Read html page from ceprdata.org into R. Each line will be stored as 
## an element in a vector of lines.
ceprHtmlIndex <- readLines(
"http://ceprdata.org/cps-uniform-data-extracts/cps-outgoing-rotation-group/cps-org-data/"
)

##   OK, what are we working with?

## how many lines do we have?
length(ceprHtmlIndex)
## what do the first few lines look like?
head(ceprHtmlIndex, 10) ## look at the first few lines of html

##   In html links are specified using the `<a>' (for /anchor/) tag. So now
##   we want to search through our html and find lines that include an `a'
##   tag. In R we can search for strings using the `grep' function.

## find lines with links (a tags)
(aLineNumbers <- grep("<a", ceprHtmlIndex)) # line numbers containing <a> tags
head(aLines <- grep("<a", ceprHtmlIndex, value = TRUE)) # lines containing <a> tags

##   So far we've successfully matched all lines containing the string
##   "<a". Our actual target is a bit more specific. If we inspect the
##   elements we want to match using our web browser we'll see something
##   like this:[file:images/inspectHtml.png]

<a onclick="_gaq.push(['_trackEvent', 'File','Download', 'cepr_org_2011']);" href="/wp-content/cps/data/cepr_org_2014.zip">cepr_org_2014.zip</a>

##   This tells us that we want to match lines containing an "<a" followed
##   (eventually) by ".zip". In order to perform this more sophisticated
##   search we need to use /regular expressions/. In regular expressions
##   the `.' matches any character (except new lines) and the `*' repeats
##   the previous character zero or more times. So `<a.*\\.zip' means "find
##   `<a' followed by any character repeated any number of times followed
##   by `.zip'". Note that in `\\.' the backslashes escape the dot so that
##   it is matched literally rather than matching any character. Let's try
##   it out!

## find lines with <a> tags refering to zip files
head(dataLines <- grep("<a.*\\.zip", ceprHtmlIndex, value = TRUE))

##   We're getting close! We have identified the lines containing the
##   information we need. Now we just need to extract the text following
##   the `href' argument. For that we need to use another feature of
##   regular expressions called /capture groups/ and /back references/.
##   Here's how it works:

head(dataURLs <- gsub("^.*href=\"(.*\\.zip)\".*$", "\\1", dataLines))

##   Great, we've matched all the data file links. The next step is to
##   iterate over these links and download the data. But before we get
##   there, let's look at a couple of alternative methods we could use to
##   get the list of data file links.

## Packages for parsing html
## ─────────────────────────

##   In the previous section we extracted data file links from an html page
##   using regular expressions. An alternative is to use a package
##   dedicated to parsing XML and HTML. How do we find such a package?
##   Task views: [https://cran.r-project.org/web/views/WebTechnologies.html]
##   R package search: [http://www.r-pkg.org/search.html?q=html+xml]
##   Web search: [https://www.google.com/search?q=R+parse+html+xml&ie=utf-8&oe=utf-8]

##   For parsing html in R I recommend either the `httr' package or the
##   `rvest' package, with the former being more flexible and the later
##   being more user friendly. Let's use the friendlier one.

  ## install.packages("rvest")
  library(rvest)
  dataPage <- html("http://ceprdata.org/cps-uniform-data-extracts/cps-outgoing-rotation-group/cps-org-data/")

  ## find the link ("a") elemets extract the link ("href") attributes
  allLinks <- html_attr(html_nodes(dataPage, "a"), "href")
  dataLinks <- paste("http://ceprdata.org",
                     grep("^/wp-content/cps/data/.*\\.zip$",
                          allLinks,
                          value = TRUE),
                     sep = "")
head(dataLinks)

##   Wow, that that was a lot easier. Why didn't we do that in the first
##   place?!? Well, if we had done it the easy way I wouldn't have had an
##   excuse to teach you about regular expressions! And trust me, you need
##   to know about regular expressions.

## Getting the list of data links the easy way
## ───────────────────────────────────────────

##   If you look at the result from the previous two methods you might
##   notice that the URLs are all the same save for the year number. This
##   suggests an even easier way to construct the list of URLs:

head(dataLinks <- paste("http://ceprdata.org/wp-content/cps/data/cepr_org_",
                    1979:2014,
                    ".zip",
                    sep = ""))

##   Wow, that was a _lot_ easier. Why oh why didn't we just do that in the
##   first place? Well, it works for this specific case, but it is much
##   less general than the regular expression method or the html parsing
##   method we discussed previously. Those methods will work in the general
##   case, while pasting the year number into the URLs only works because
##   the URLs we want have a very regular and consistent form.

## Iterating and defining new functions
## ════════════════════════════════════

##   Now that we have a vector of URLs pointing to the data files we want
##   to download, we want to iterate over the elements and download each
##   file. We could do this verbosely by writing one line for each file:

dir.create("dataSets")
download.file(dataLinks[1], "dataSets/cepr_org_1979.zip")
download.file(dataLinks[2], "dataSets/cepr_org_1980.zip")
## ...
## download.file(dataLinks[n], "dataSets/cepr_org_n.zip")

##   but that is too much typing. Much easier to let R do that for us. We
##   can iterate over the elements of a vector in R using a loop, or using
##   one of the `apply' family of functions.

##   `for' and `while' loops in R work much the same as they do in other
##   programming languages. The `apply' family of functions apply a
##   function to each element of an object.

## Iterating using for-loop
## ────────────────────────

##   One way to download the data files is to use a for-loop to iterate
##   over the contents of our vector of URLs. Some people will tell you to
##   avoid for-loops in R but this is nonsense. Loops are convenient and
##   useful, and while they are not the best tool for all situations
##   calling for iteration they are perfectly appropriate for downloading a
##   series of files. If you've used a for loop in any other language you
##   will probably find the R implementation to be very similar.

##   For now, lets start by downloading just the data files for years since
##   2010.

for(link in grep("org_201", dataLinks, value = TRUE)) {
    download.file(link, 
                  destfile = basename(link))
}

## Writing functions
## ─────────────────

##   Our for loop works well for downloading the data files form
##   ceprdata.org. But what if we need to download data from other URLs as
##   well? It might be nice to have a re-usable function that takes a url
##   and downloads it, saving the result as the `basename' of the url. We
##   can define such a function using the `function' function (say that
##   three times fast!).

downloadFiles <- function(urls) {
  for(link in urls) {
      download.file(link, 
                    destfile = basename(link))
  }
}

##   Now we can download files more simply with

downloadFiles(grep("org_201", dataLinks, value = TRUE))

##   and in fact we can use this function to download files from any urls
##   we might have. As a silly example, let's download all the profile
##   pictures from the [Research Technology Consulting] team at [The
##   Institute for Quantitative Social Science]:

library(readbitmap)
## parse the webpage and extract image URLs
profilePicLinks <- html_attr(html_nodes(html("http://projects.iq.harvard.edu/rtc/people"),
                                        ".image-style-profile-thumbnail"),
                             "src")
## clean up the links
profilePicLinks <- gsub("\\.png\\?.*$", ".png", profilePicLinks)
## download
downloadFiles(paste("http:", profilePicLinks, sep=""))
## list downloaded image files
list.files(pattern = "\\.png$")

##   The code above downloaded all the profile pics from
##   [http://projects.iq.harvard.edu/rtc/people]. Although this doesn't
##   have anything to do with our main goal of downloading and analyzing
##   the data from ceprdata.org, we'll go ahead and plot these images, just
##   for fun.

## install.packages("readbitmap")
library(readbitmap); library(grid); library(gridExtra)

imgs <- sapply(list.files(pattern = "\\.png$"),
               read.bitmap,
               simplify = FALSE)
do.call(grid.arrange, sapply(imgs, rasterGrob, simplify = FALSE))

##   [Research Technology Consulting] http://projects.iq.harvard.edu/rtc

##   [The Institute for Quantitative Social Science] http://iq.harvard.edu

## The apply family of functions
## ─────────────────────────────

##   The apply family of functions in R  are useful for iteration. The apply
##   family of functions includes:
##   apply: apply a function to each dimension (e.g., row or column), of a
##          matrix or array
##   lapply: apply a function to each element of a vector or list
##   sapply: like lapply, but simplifies the result
##   mapply: apply a function to each element of multiple vectors or lists

##   Confused yet? The bad news is, there are more of these; see `?lapply',
##   `?Map' and [this StackOverflow answer] for details. The good news is
##   you can do quite a lot with just `apply' and `sapply'.

##   [this StackOverflow answer]
##   http://stackoverflow.com/questions/3505701/r-grouping-functions-sapply-vs-lapply-vs-apply-vs-tapply-vs-by-vs-aggrega

## Iterating over vectors and lists with the `sapply' function
## ╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌

##   The `sapply' function iterates over a vector or list and applys a
##   function to each element. To start, let's use `sapply' do download all
##   the data files for years since 2010:

sapply(grep("org_201", dataLinks, value = TRUE),
       function(x) download.file(x, destfile = basename(x))
       )

##   For this task (downloading files) there is not much advantage to using
##   `sapply' instead of `for'. The main advantage is the simpler handling
##   of return values. To see this, let's revisit the profile picture
##   example. Our goal is to read all the .png files in our working
##   directory. We've already seen how to do this with `sapply';

imgs <- sapply(list.files(pattern = "\\.png$"),
               read.bitmap)

##   How can we do that with a for loop? First we need to create a list to
##   store the restults, then as we loop through we need to assign the
##   image data to an element of the list. It's not terrible:

imgs <- list()
for (file in list.files(pattern = "\\.png$")) {
  imgs[[file]] <- read.bitmap(file)
}

##   As I said, not terrible, but definitely more complicated than the
##   sapply version.

## ◊ Iterating over arrays with the `apply' function

##   Now that we've downloaded some of the ceprdata.org data we might want
##   to get some information about these files. We can do that using the
##   `file.info' function:

ceprFiles <- list.files(pattern = "\\.zip")
ceprFileInfo <- cbind(size = file.size(ceprFiles), mode = file.mode(ceprFiles))
rownames(ceprFileInfo) <- ceprFiles
ceprFileInfo

##   ceprFileInfo is a _matrix_, with each row containing information about
##   one of the files we downloaded. We can calculate the means for each
##   column in this mattrix using the `apply' fuction:

## average file size and permissions
(fileInfoAverage <- apply(ceprFileInfo, MARGIN = 2, mean))
## standard deviation of file size and permissions
apply(ceprFileInfo, MARGIN = 2, sd)
## deviation from the average
apply(ceprFileInfo, MARGIN = 1, function(x) x - fileInfoAverage) #

## ◊ Back to the business at hand

##   OK OK, we got sidetracked with profile pics and apply functions. Eyes
##   on the prize; we want to import and process the files we downloaded
##   from ceprdata.org. First we need to unzip them and check the size of
##   each file

sapply(ceprFiles, unzip)
ceprDataFiles <- list.files(pattern = "\\.dta$")
file.size(ceprDataFiles)/1024^2 #give size in Mb

##   Finally we can read our data into R, but I leave that to you!

## Exersise 1
## ──────────

##   Read in the cepr data for years 2010 and greater.

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

##   OK, so far we know that ceprData is a list of length 4 and that it has
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
##   works like this: [file:images/HadleyWickham_index_list.png][3]

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
##   what each column contains. Include at least the variable `names' and
##   `var.labels' as well as any other information that you think will be
##   useful.

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
  aggregate(x["rw"],
            by = x[c("year", "state", "rural", "female")],
            FUN = mean, na.rm = TRUE)},
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
ggplot(ceprData, aes(x = year, y = rw, color = factor(female), linetype = factor(rural))) +
  geom_line() +
  facet_wrap(~state, ncol = 9)

## The S3 object class system
## ══════════════════════════

## The S3 object class system
## ──────────────────────────

##   R has two major object systems:
##   • Relatively informal "S3" classes
##   • Stricter, more formal "S4" classes
##   • We will cover only the S3 system, not the S4 system
##   • Basic idea: functions have different methods for different types of
##     objects

## Object class
## ────────────

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
## ────────────────

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
## ─────────────────────────────

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
## ──────────────────────────

##   S3 generics are most often used for print, summary, and plot methods,
##   but sometimes you may want to create a new generic function

# create a generic disp() function
disp <- function(x, ...) {
  UseMethod("disp")
}

# create a disp method for class "matrix"
disp.matrix <- function(x) {
  print(round(x, digits=2))
}

# test it out
disp(matrix(runif(10), ncol=2))

## Things that may surprise you
## ════════════════════════════

## Gotcha's
## ────────

##   • There are an unfortunately large number of surprises in R
##     programming
##   • Some of these "gotcha's" are common problems in other languages,
##     many are unique to R
##   • We will only cover a few – for a more comprehensive discussion
##     please see [http://www.burns-stat.com/pages/Tutor/R_inferno.pdf]

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

## [1] Center for Economic and Policy Research. 2015. CPS ORG Uniform
## Extracts, Version 2.0.1. Washington, DC.

## [2]
## [http://stackoverflow.com/questions/1732348/regex-match-open-tags-except-xhtml-self-contained-tags]

## [3] Photo by Hadley Wickham via
## [https://twitter.com/hadleywickham/status/643381054758363136/photo/1].
## Used by permission.
