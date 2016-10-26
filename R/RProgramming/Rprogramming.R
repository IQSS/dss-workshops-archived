##                    ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
##                     INTRODUCTION TO PROGRAMMING IN R
##                    ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━


## Table of Contents
## ─────────────────

## Workshop overview and materials
## Extracting information from a text file (string manipulation)
## Reading all the files (iteration, functions)
## Adding a Year column (data structures, indexing)
## Final data cleanup
## Manipulating data.frames
## Addressing obvious pitfalls in tracking name popularity
## What else?
## Go forth and code!


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

##   This workshop uses the [tidyverse] package which provides more
##   consistent file IO ([readr]), data manipulation ([dplyr], [tidyr]) and
##   functional programming ([purrr]) tools for R.

##   Prerequisite: basic familiarity with R, such as acquired from an
##   introductory R workshop.


## [tidyverse] https://cran.r-project.org/web/packages/tidyverse/index.html

## [readr] https://cran.r-project.org/web/packages/readr/index.html

## [dplyr] https://cran.r-project.org/web/packages/dplyr/index.html

## [tidyr] https://cran.r-project.org/web/packages/tidyr/index.html

## [purrr] https://cran.r-project.org/web/packages/purrr/index.html


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
##   involves acquiring, processing, and analyzing UK baby names
##   statistics. In this context we will learn about data types, iteration,
##   file IO, writing functions, and more.


## Extracting information from a text file (string manipulation)
## ═════════════════════════════════════════════════════════════

##   It is common for data to be made available on a website somewhere,
##   either by a government agency, research group, or other organizations
##   and entities. Often the data you want is spread over many files, and
##   retrieving it all one file at a time is tedious and time consuming.
##   Such is the case with the baby names data we will be using today.

##   The UK [Office for National Statistics] provides yearly data on the
##   most popular baby names going back to 1996. The data is provided
##   separately for boys and girls. These data have been cleaned up and
##   copied to [http://tutorials/iq/harvard.edu/exampel_data/baby_names].
##   Although we could open a web browser and download files one at a time,
##   it will be faster and easier to instruct R to do that for us. Doing it
##   this way will also give us an excuse to talk about iteration, text
##   processing, and other useful techniques.

##   Our first goal is to download all the .csv files from
##   [http://tutorials/iq/harvard.edu/exampel_data/baby_names].

##   In order to do that we need a list of the Uniform Resource Locators
##   (URLs) of those files. The URLs we need are right there as links in
##   the web page. All we need to do is extract them.


## [Office for National Statistics] https://www.ons.gov.uk

## Introduction to the tidyverse
## ─────────────────────────────

##   In order extract the data URls from the website we will use functions
##   for manipulating strings[1]. What functions or packages should we use?
##   Here are some tools to help us decide.
##   Task views: [https://cran.r-project.org/web/views/NaturalLanguageProcessing.html]
##   R package search: [http://www.r-pkg.org/search.html?q=string]
##   Web search: [https://www.google.com/search?q=R+string+manipulation&ie=utf-8&oe=utf-8]

##   Base R provides some string manipulation capabilities (see `?regex',
##   `?sub' and `?grep'), but I recommend either the [stringr] or [stringi]
##   packages. The stringr package is more user-friendly, and the stringi
##   package is more powerful and complex. Let's use the friendlier one.
##   While we're attaching packages we'll also attach the [tidyverse]
##   package which provides more modern versions of many basic functions in
##   R.

## install.packages("tidyverse")
library(tidyverse)
library(stringr)

##   Packages in the tidyverse are often more convenient to use with pipes
##   rather than nested function calls. The pipe operator looks like `%>%'
##   and it works like this:
## nested function calls to sample letters, convert to uppercase, sort, and append numbers
set.seed(10)
str_c(
  sort(
    str_to_upper(
      sample(letters[1:5],
             20,
             replace = TRUE))),
  1:20)

## pipeline that does the same thing:
set.seed(10)
letters[1:5] %>%
  sample(20, replace = TRUE) %>%
  str_to_upper() %>%
  sort() %>%
  str_c(1:20)

##   The examples in this workshop use the pipe when it makes examples
##   easier to follow.


## [stringr] https://cran.r-project.org/web/packages/stringr/index.html

## [stringi] https://cran.r-project.org/web/packages/stringi/index.html

## [tidyverse] https://cran.r-project.org/web/packages/tidyverse/index.html


## Reading text over http
## ──────────────────────

##   Our first task is to read the web page into R. Most of the file IO
##   functions in R can read either from a local path or from internet
##   URLS. We can read text into R line-by-line using the `read_lines'
##   function.

base.url <- "http://tutorials.iq.harvard.edu"
baby.names.path <- "example_data/baby_names" 
baby.names.url <- str_c(base.url, baby.names.path, sep = "/")

baby.names.page <- read_lines(baby.names.url)

##   What did we just do? We assigned character vectors of length 1 to
##   `base.url' and `baby.names.path', and we assigned whatever
##   `read_lines' returns. Lets look closer. What are these things?
## whate is base.url?
mode(base.url)
length(base.url)
class(base.url)
str(base.url)

## what is baby.names.url?
mode(baby.names.url)
length(baby.names.url)
class(baby.names.url)
str(baby.names.url)

## what is baby.names.page?
mode(baby.names.page)
length(baby.names.page)
class(baby.names.page)
str(baby.names.page)

##   What can we do with them?
methods(class = class(base.url))

##   Note that these methods are not exhaustive – we can do other things
##   with these objects as well. `methods(class = )' just tells you which
##   functions have specific methods for working with objects of that
##   class.

##   The `mode' function tells us how the object is stored in memory.
##   "Character" is one of the six /atomic/ modes in R. The others are
##   "logical", "integer", "numeric (double)", "complex", and "raw".
##   Objects reporting their `mode' as one of these are /atomic vectors/;
##   they are the building blocks of most data structures in R.

##   Now that we know what we're working with we can proceed to find and
##   extract all the links in the page. Lets start by printing the last few
##   lines of `baby.names.page'.

cat(tail(baby.names.page), sep = "\n")

##   We want to extract the "href" attributes, i.e., "girls_2014.csv" and
##   "girls_2015.csv" in the above snippet. We can do that using the
##   `str_extract' function, but in order to use it effectively we need to
##   know something about regular expressions.


## String manipulation with the stringr package
## ────────────────────────────────────────────

##   Regular expressions are useful in general (not just in R!) and it is a
##   good idea to be familiar with at least the basics.

##   In regulars expression `^', `.', `*', `$' and `\' are special
##   characters with the following meanings:
##   ^: matches the beginning of the string
##   .: matches any character
##   *: repeates the last caracter zero or more times
##   $: matches the end of the string
##   []: specifies ranges of characters: [a-z] matches lower case letters
##   \: escapes special meaning: '.' means "anything", '\.' means "."

##      Here's how it works in R using the stringr package.
user.info <- c("Dexter Bacon dbacon@gmail.com 32",
               "Angelica Sampson not available 28",
               "Roberta Modela roberta.modela@harvard.edu 26"
               )
email.regex <- "([a-z0-9_\\.-]+@[a-z0-9\\.-]+\\.[a-z\\.]+)"
str_detect(user.info, email.regex)
str_subset(user.info, email.regex)
str_extract(user.info, email.regex)
str_replace(user.info, email.regex, "<a href='\\1'>\\1</a>")


##   If you have not been introduced to regular expressions yet a nice
##   interactive regex tester is available at [http://www.regexr.com/] and
##   an interactive tutorial is available at [http://www.regexone.com/].


## Exercise 1: string manipulation and regular expressions
## ───────────────────────────────────────────────────────

##   Our job now is to match the file names using regular expressions. To
##   get started lets copy an example string into the interactive regex
##   tester at [http://www.regexr.com/] and work with it until we find a
##   regular expression that works.

##   1. Open [http://www.regexr.com/] in your web browser and paste in this
##      string:
##   <tr><td valign="top"><img src="/icons/unknown.gif" alt="[
##   ]"></td><td><a href="girls_2014.csv">girls_2014.csv</a></td><td
##   align="right">06-Oct-2016 13:12 </td><td align="right">144K</td></tr>
##   2. Find a regular expression that matches 'girls_2014.csv' and nothing
##      else.
##   3. Assign the regular expression you found to the name
##      'girl.file.regex' in R. Replace any backslashes with a double
##      backslash.
##   4. Extract the girl file names from `baby.names.page' and assign the
##      values to the name 'girl.file.names'
##   5. Repeat steps 1:4 for boys.
##   6. Use the `str_c' function to prepend
##      "[http://tutorials.iq.harvard.edu/example_data/baby_names/]" to
##      `girl.file.names' and `boy.file.names'.


## Reading all the files (iteration, functions)
## ════════════════════════════════════════════

## Reading .csv files
## ──────────────────

##   As mentioned earlier, we can read files directly from the internet.
##   For example, we can read the first girls names file like this:

girl.names.1 <- read_csv(girl.file.names[1], na = "")
head(girl.names.1)


## Iterating using the map function
## ────────────────────────────────

##   To read all the files conveniently we want to iterate over the vector
##   of URLs and download each one. We can carry out this iteration in
##   several ways, including using one of the `map*' functions in the purrr
##   package. Here is how it works.

list.1 <- list(a = sample(1:5, 20, replace = TRUE),
               b = sample(1:10, 20, replace = TRUE),
               c = sample(10:15, 20, replace = TRUE))

## calculate the mean of every entry
map.1 <- map(list.1, mean)
str(map.1)
## calculate the mean of every entry, returning a numberic vector instead of a list
map.2 <- map_dbl(list.1, mean)
str(map.2)
## calculate the mean of every entry, returning a character vector
map.3 <- map_chr(list.1, mean)
## calculate summaries (map returns a list)
map.4 <- map(list.1, summary)
str(map.4)


## Writing your own functions
## ──────────────────────────

##   The `map*' functions are useful when you want to apply a function to a
##   list or vector of inputs and obtain the return values. This is very
##   convenient when a function already exists that does exactly what you
##   want. In the examples above we mapped `mean' and `summary' to the
##   elements of a list. But what if there is no existing function that
##   does exactly what we want? Suppose that rather than the set of
##   statistics reported by the `summary' function we want to summarize
##   each element in the list by calculating the /length/, /mean/, and
##   /standard deviation/? In that case we will need to write a function
##   that does what we want. Fortunately, writing functions in R is easy.
my.summary <- function(x) {
  n <- length(x)
  avg <- mean(x)
  std.dev <- sd(x)
  return(c(N = n, Mean = avg, Standard.Deviation = std.dev))
}
my.summary(list.1[[1]])
map(list.1, my.summary)

##   OK, back to the problem at hand. We want to read each file in the
##   `girl.file.names' and `boy.file.names' vectors. The files contain
##   columns "Rank", "Name", and "Count". The year each file contains data
##   for is not included as a column in the data, but it is encoded in the
##   file names.


## Exercise 2: Iteration, file IO, functions
## ─────────────────────────────────────────

##   We know how to read csv files using `read_csv'. We know how to iterate
##   using `map'. All we need to do now is put the two things together.

##   1. Use the `map' and `read_csv' functions to read all the girls data
##      into an object named `girls.data'.
##   2. Do the same thing for the boys data (name the object `boys.data').
##   3. Inspect the boys and girls data lists. How many elements do they
##      have? What class are they?
##   4. Write a function that returns the `class', `mode', and `length' of
##      its argument. `map' this function to `girls.data' and `boys.data'.



## Adding a Year column (data structures, indexing)
## ════════════════════════════════════════════════

##   OK, at this point we have read in all the data. That is a good start!
##   Lets take a closer look at what we are working with.

str(girls.data, max.level = 1)

##   OK, so we have a /list/ with 20 elements. A list in R is a very
##   flexible data structure that can hold just about anything (including
##   other lists). Our `girls.data' is a list that happens to contain
##   /data.frames/.

##   A data.frame in R is a special type of list in which each element is
##   the same length. Elements of data.frames are often /atomic vectors/
##   ("logical", "integer", "numeric (double)" etc. as discussed above),
##   though elements of a data.frame can be anything you can store in other
##   lists, provided only that each element is the same length.

##   There are many useful things we can do with data.frames: (But remember
##   that this list of methods is not all you can do with data.frames.)

girls.data.1 <- girls.data[[1]]
class(girls.data.1)
methods(class = "data.frame")
dim(girls.data.1)
nrow(girls.data.1)
ncol(girls.data.1)
names(girls.data.1)
summary(girls.data.1)


##   The data.frames in `girls.data' all have three elements (columns):
##   Rank (a number), Name (a character), and Count (a number). That is a
##   problem, because we don't have the year each name and count
##   corresponds to! Year was stored in the file names rather than in the
##   contents of the files.

##   Lets take a closer look at the first data.frame in the list. The year
##   corresponding to `girls.data[1]' is in `girl.file.names[1]'.
(girls.file.name.1 <- girl.file.names[1]) ## enclosing parens is a shortcut for assigning and printing
(girls.year.1 <- str_extract(girls.file.name.1, "[0-9]+"))
girls.data.1 <- girls.data[[1]]
str(girls.data.1)

##   How can we insert the year information into each corresponding
##   data.frame? To do that it will be helpful to know a few more things
##   about how extraction and replacement work in R.


## Extracting and replacing elements
## ─────────────────────────────────

##   Elements of R objects can be extracted and replaced using bracket
##   notation. Bracket extraction comes in a few different flavors.

example.list.1 <- list(a1 = c(a = 1, b = 2, c = 3),
                     a2 = c(4, 5, 6),
                     b1 = c("a", "b", "c", "d"),
                     b2 = c("e", "f", "g", "h"))
str(example.list.1)
## extract by position
str(example.list.1[1])
str(example.list.1[[1]]) # note the difference between [ and [[
## extract by name
str(example.list.1[c("a1", "a2")])
(a.names <- str_detect(names(example.list.1), "a"))
str(example.list.1[a.names])
## chained bracket extraction
str(example.list.1[["a1"]][c("a", "c")])
## logical extraction
(el.length <- map_int(example.list.1, length))
(el.length4 <- el.length == 4)
str(example.list.1[el.length4])
## more logical extraction
(a1.lt.3 <- example.list.1[["a1"]] < 3)
str(example.list.1[["a1"]][a1.lt.3])
## extract non-existent element
example.list.1[["z"]]

##   Replacement works by assigning a value to an extraction.

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
example.list.2[["c"]] <- data.frame(x = letters[1:5], y = 1:5)

## compare lists to see the changes we made
str(example.list.1)
str(example.list.2)


## Using extraction and replacement to add a Year column
## ─────────────────────────────────────────────────────

##   Now that we know to extract and replace data.frame columns we can use
##   that technique to add a Year column to our baby names data. Recall
##   that we earlier extracted the first element of `girls.data' into
##   `girls.data.1' and the first element of `girls.file.names' into
##   `girls.file.name.1'. Lets use those to practice.
girls.data.1[["Year"]] <- girls.file.name.1 %>%
  str_extract(pattern = "[0-9]+") %>%
  as.integer()
str(girls.data.1)

##   Now we want to repeat that for each element in the list. We know how
##   to do it for one data.frame, and we know how to map a function to each
##   element of a list. We just need to put these techniques together.


## Exercise 3: Iteration, data.frame manipulation
## ──────────────────────────────────────────────

##   We know how to read add a Year column. We know how to iterate using
##   `map'. All we need to do now is put the two things together.

##   1. Extract the year data from `girl.file.names' and `boy.file.names'
##      using the `str_extract' function. Assign the results to the names
##      `girl.years' and `boy.years' respectively.
##   2. Write a function named `add.column' that takes a data.frame and a
##      vector as arguments and returns a data.frame with the vector
##      included as a column.
##   3. Test your function on the first elements of `girls.data' and
##      `girl.years' from step 1.
##   4. Use the `map2' function to iterate over `girls.data' and insert the
##      corresponding year from `girl.years' using the function you wrote
##      in step 1. Do the same for `boys.data' and `boys.years'.


## Final data cleanup
## ══════════════════

##   Our next step to is to collapse each list of data.frames into a single
##   list. We can do that using the `bind_rows' function.

boys.data <- bind_rows(boys.data)
girls.data <- bind_rows(girls.data)
str(boys.data)
str(girls.data)

##   Finally, we want to insert columns indicating sex and combine the boys
##   and girls baby names.

girls.data[["Sex"]] <- "girl"
boys.data[["Sex"]] <- "boy"
baby.names <- bind_rows(girls.data, boys.data)


## Manipulating data.frames
## ════════════════════════

##   Earlier we mentioned that data.frames are a special kind of list in
##   which each element must be of the same length. What we perhaps did not
##   emphasize enough is how important the data.frame concept is in R
##   programming. Because of the centrality of the data.frame in many R
##   workflows there are many functions available specifically for
##   manipulating data.frames. In particular, the /dplyr/ and /tidyr/
##   packages provides many useful functions for working with data.frames.


## Most popular names overall
## ──────────────────────────

##   Now that we have the data read in and we know what is in each column,
##   I want to find the five most popular girl and boy names overall. This
##   requires learning several new functions, but they all have intuitive
##   names and syntax.

##   The first step is to collapse across years to get the sum for each
##   baby name across time. We will do this separately for boys and girls
##   using the `group_by' function.
baby.names.totals <- baby.names %>%
  group_by(Sex, Name) %>%
  summarize(Count = sum(Count))

##   Next we need to arrange the data with the highest counts first, and
##   select the top 10.

(top.names.overall <- baby.names.totals %>%
   group_by(Sex) %>%
   arrange(desc(Count)) %>%
   slice(1:5))


## Changes in most frequent names over time
## ────────────────────────────────────────

##   Next I want to see how these most popular names have changed over
##   time. In other words, I want to filter `baby.names' to include only
##   those names in `top.names.overall'. An easy way to do it is to join
##   the two data.frames:

str(baby.names)

top.names.over.time <- top.names.overall %>%
  select(Sex, Name) %>%
  inner_join(baby.names) %>%
  ungroup()

str(top.names.over.time)

ggplot(top.names.over.time,
       aes(x = Year, y = Count)) +
  geom_line() +
  geom_point() +
  facet_wrap(Sex ~ Name, ncol = 5)


## Exercise 4
## ──────────

##   1. Use the `filter', `arrange', and `slice' functions to identify the
##      5 most popular boy and girl names in 2015.
##   2. Filter `baby.names' to include only the 5 most popular boy and girl
##      names in 2015
##   3. Create a plot showing how the most popular names in 2015 have
##      changed over time


## Addressing obvious pitfalls in tracking name popularity
## ═══════════════════════════════════════════════════════

## Changes in name popularity or population growth?
## ────────────────────────────────────────────────

##   The graphs that we have constructed thus far show the number of
##   children with a particular name in particular years. All else equal,
##   these counts would be expected to increase with increasing number of
##   children being born each year. If our goals is to examine changes in
##   name popularity we should be more careful about it! Fortunately we
##   already have all the tools we need to calculate the percentage of boys
##   and girls with particular names each year.


## Exercise 5
## ──────────

##   Now that we've combined names with different spellings lets re-do the
##   "most popular overall" graph using combined names.

##   1. Calculate the percent of boys and girls with each name in each year
##   2. Re-do the graph from the previous exercise using Percent instead of
##      Count


## Combining similar names
## ───────────────────────

##   Similar names with different spellings have been intentionally left
##   alone in these data. If our goals is to examine changes in name
##   popularity (rather than changing spelling preferences) it might be
##   useful to combine them. There are several different algorithms for
##   detecting words that sound alike; many of them (including the /nysiis/
##   and /metaphone/ algorithms) are provided in R by the /phonics/
##   package. Here is how it works:

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

##   Once we have identified which words are the same (but spelled
##   differently) we can combine those words.
(spelling.data <- mutate(group_by(spelling.data, Sounds.like),
                         Alternative.spellings = str_c(sort(original),
                                                       collapse = "/")))

##   We can use this technique to identify and group names with alternative
##   spellings. Since any one algorithm tends to group two aggressively
##   we'll require multiple algorithms to agree.

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


## Exercise 6
## ──────────

##   Now that we've combined names with different spellings lets re-do the
##   "most popular overall" graph using combined names.

##   1. Sum the Count column by Sex, Alternative.spellings, and Year
##   2. Take the result from step 1 and
##      1. `group_by' Sex and alternative spellings
##      2. `summarize' by taking the `sum' of the Count variable
##      3. `group_by' Sex
##      4. `arrange' by count
##      5. `select' Sex and Alternative.spellings
##      6. `slice' rows 1:5
##      7. `inner_join' with the result from step 1.
##   3. Graph the prevalence of the most popular combined names over time.


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


## Floating point comparison
## ╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌

##   Floating point arithmetic is not exact:
.1 == .3/3

##   Solution: `use all.equal()':
all.equal(.1, .3/3)


## Missing values
## ╌╌╌╌╌╌╌╌╌╌╌╌╌╌

##   R does not exclude missing values by default – a single missing value
##   in a vector means that many thing are unknown:
x <- c(1:10, NA, 12:20)
c(mean(x), sd(x), median(x), min(x), sd(x))

##   NA is not equal to anything, not even NA
NA == NA

##   Solutions: use `na.rm = TRUE' option when calculating, and is.na to
##   test for missing


## Automatic type conversion
## ╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌

##   Automatic type conversion happens a lot which is often useful, but
##   makes it easy to miss mistakes

# combining values coereces them to the most general type
(x <- c(TRUE, FALSE, 1, 2, "a", "b"))
str(x)

# comparisons convert arguments to most general type
1 > "a"

##   Maybe this is what you expect… I would like to at least get a warning!


## Optional argument inconsistencies
## ╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌

##   Functions you might expect to work similarly don't always:

mean(1, 2, 3, 4, 5)*5
sum(1, 2, 3, 4, 5)

##   Why are these different?!?
args(mean)
args(sum)

##   Ouch. That is not nice at all!


## Trouble with Factors
## ╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌

##   Factors sometimes behave as numbers, and sometimes as characters,
##   which can be confusing!

(x <- factor(c(5, 5, 6, 6), levels = c(6, 5)))

str(x)

as.character(x)
# here is where people sometimes get lost...
as.numeric(x)
# you probably want
as.numeric(as.character(x))


## Feedback
## ────────

##   • Help Us Make This Workshop Better!
##   • Please take a moment to fill out a very short feedback form
##   • These workshops exist for you – tell us what you need!
##   • [http://tinyurl.com/RprogrammingFeedback]



## Footnotes
## ─────────

## [1] In general you [should not use string manipulation tools to parse
## html]
## (http://stackoverflow.com/questions/1732348/regex-match-open-tags-except-xhtml-self-contained-tags/1732454#1732454),
## but in this case the html is simple enough that a regular expression
## based approach is fine.
