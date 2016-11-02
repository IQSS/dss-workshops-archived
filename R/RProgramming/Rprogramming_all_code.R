## install.packages("tidyverse")
library(tidyverse)
library(stringr)

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

base.url <- "http://tutorials.iq.harvard.edu"
baby.names.path <- "example_data/baby_names/EW" 
baby.names.url <- str_c(base.url, baby.names.path, sep = "/")

baby.names.page <- read_lines(baby.names.url)

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

methods(class = class(base.url))

cat(tail(baby.names.page), sep = "\n")

user.info <- c("Dexter Bacon dbacon@gmail.com 32",
               "Angelica Sampson not available 28",
               "Roberta Modela roberta.modela@harvard.edu 26"
               )
email.regex <- "([a-z0-9_\\.-]+@[a-z0-9\\.-]+\\.[a-z\\.]+)"
str_detect(user.info, email.regex)
str_subset(user.info, email.regex)
str_extract(user.info, email.regex)
str_replace(user.info, email.regex, "<a href='\\1'>\\1</a>")

## regular expression for girl csv files
girl.file.regex <- "girls_[0-9]*\\.csv"
## extract girl file names
girl.file.names <- baby.names.page %>%
  str_subset(pattern = girl.file.regex) %>%
  str_extract(pattern = girl.file.regex)

## same thing for boys
boy.file.regex <- "boys_[0-9]*\\.csv"
boy.file.names <- baby.names.page %>%
  str_subset(pattern = boy.file.regex) %>%
  str_extract(pattern = boy.file.regex)

## construct URLs
(girl.file.names <- str_c(baby.names.url, girl.file.names, sep = "/"))
(boy.file.names <- str_c(baby.names.url, boy.file.names, sep = "/"))

girl.names.1 <- read_csv(girl.file.names[1], na = "")
head(girl.names.1)

example.int.1 <- c(10, 11, 12, 13, 14, 15)
str(example.int.1)

names(example.int.1) # no names yet, lets add sum
names(example.int.1) <- c("a1", "a2", "b1", "b2", "c1", "c2")
names(example.int.1)
str(example.int.1)

## extract by position
example.int.1[1]
example.int.1[c(1, 3, 5)]

## extract by name
example.int.1[c("c2", "a1")]

## logical extraction 
(one.names <- str_detect(names(example.int.1), "1"))
example.int.1[one.names]
example.int.1[example.int.1 > 12]

## extract non-existent element
example.int.1[10]
example.int.1["z1"]

example.int.2 <- example.int.1

## replace by position
example.int.2[1] <- 100

## replace by name
example.int.2["a2"] <- 200
example.int.2

## logical replacement
(lt14 <- example.int.2 < 14)
example.int.2[lt14] <- 0
example.int.2
## "replace" non-existing element
example.int.2[c("z1", "z2")] <- -10 

## compare lists to see the changes we made
example.int.1
example.int.2

example.list.1 <- list(a1 = c(a = 1, b = 2, c = 3),
                     a2 = c(4, 5, 6),
                     b1 = c("a", "b", "c", "d"),
                     b2 = c("e", "f", "g", "h"))
str(example.list.1)

## extract by position
str(example.list.1[c(1, 3)])
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

## compare lists to see the changes we made
str(example.list.1)
str(example.list.2)

boys <- list()
girls <- list()

boys[[1]] <- read_csv(boy.file.names[1], na = "")
boys[[2]] <- read_csv(boy.file.names[2], na = "")
## ...
girls[[1]] <- read_csv(girl.file.names[1], na = "")
girls[[2]] <- read_csv(girl.file.names[2], na = "")
## ...

## create lists to store the data
boys <- list()
girls <- list()

## extract years and assign to names
boy.years <- str_extract(boy.file.names, "[0-9]+")
girl.years <- str_extract(girl.file.names, "[0-9]+")
names(girl.file.names) <- girl.years
names(boy.file.names) <- boy.years

## read first three years of girls names
girls[["2015"]] <- read_csv(girl.file.names["2015"], na = "")
girls[["2014"]] <- read_csv(girl.file.names["2014"], na = "")
girls[["2013"]] <- read_csv(girl.file.names["2013"], na = "")

## read first three years of boys names
boys[["2015"]] <- read_csv(boy.file.names["2015"], na = "")
boys[["2014"]] <- read_csv(boy.file.names["2014"], na = "")
boys[["2013"]] <- read_csv(boy.file.names["2013"], na = "")

## examine the result
str(boys, max.level = 2)
str(girls, max.level = 2)

list.1 <- list(a = sample(1:5, 20, replace = TRUE),
               b = c(NA, sample(1:10, 20, replace = TRUE)),
               c = sample(10:15, 20, replace = TRUE))

## calculate the mean of every entry
map.1 <- map(list.1, mean)
str(map.1)
## calculate the mean of every entry, passing na.rm argument
map.1 <- map(list.1, mean, na.rm = TRUE)
str(map.1)
## calculate the mean of every entry, returning a numberic vector instead of a list
map.2 <- map_dbl(list.1, mean)
str(map.2)
## calculate the mean of every entry, returning a character vector
map.3 <- map_chr(list.1, mean)
## calculate summaries (map returns a list)
map.4 <- map(list.1, summary)
str(map.4)

my.summary <- function(x) {
  n <- length(x)
  avg <- mean(x)
  std.dev <- sd(x)
  return(c(N = n, Mean = avg, Standard.Deviation = std.dev))
}
my.summary(list.1[[1]])
map(list.1, my.summary)

my.summary <- function(x, ...) {
  n <- length(x)
  avg <- mean(x, ...)
  std.dev <- sd(x, ...)
  return(c(N = n, Mean = avg, Standard.Deviation = std.dev))
}

## works fine for the first element of the list
my.summary(list.1[[1]])
## not so good for the second because it contains NA
my.summary(list.1[[2]]) 
## even though our function does not have an na.rm argument we
## can pass it to mean and sd via ...
my.summary(list.1[[2]], na.rm = TRUE)

my.summary <- function(x, ...) {
  if(any(is.na(x))) {
    x <- na.omit(x)
  }
  n <- length(x)
  avg <- mean(x, ...)
  std.dev <- sd(x, ...)
  return(c(N = n, Mean = avg, Standard.Deviation = std.dev))
}

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

map(list.1, my.summary)
map(list.1, my.summary, mean.only = TRUE)

girls.data <- map(girl.file.names, read_csv, na = "")
boys.data <- map(boy.file.names, read_csv, na = "")
length(boys.data)
length(girls.data)
class(girls.data)
class(boys.data)

list.info <- function(x) return(c(class = class(x), mode = mode(x), n = length(x)))
unique(map(girls.data, list.info))
unique(map(boys.data, list.info))

str(girls.data, max.level = 1)

girls.data.1 <- girls.data[[1]]
class(girls.data.1)
methods(class = "data.frame")
dim(girls.data.1)
nrow(girls.data.1)
ncol(girls.data.1)
names(girls.data.1)
summary(girls.data.1)

str(girls.data[[1]])
girls.data[[1]][["Year"]] <- names(girls.data[1])
##        ^                                  ^ 
## double brackets to extract data.frame   single brackets to extract a list containing a data.frame
str(girls.data[[1]])
girls.data[[1]][["Year"]] <- as.integer(names(girls.data[1]))
str(girls.data[[1]])

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

## write function to add year column
add.column <- function(data, value, col.name = "xxxxx") {
  data[[col.name]] <- value
  return(data)
}

## test out the function
str(add.column(girls.data[[1]], value = names(girls.data[1]), col.name = "Year"), max.level = 1)

## map the function to each element of our lists of data.frames
girls.data <- map2(girls.data, names(girls.data), add.column, col.name = "Year")
boys.data <- map2(boys.data, names(boys.data), add.column, col.name = "Year")

boys.data <- bind_rows(boys.data)
girls.data <- bind_rows(girls.data)
str(boys.data)
str(girls.data)

girls.data[["Sex"]] <- "F"
boys.data[["Sex"]] <- "M"
baby.names <- bind_rows(girls.data, boys.data)
baby.names$Year <- as.integer(baby.names$Year)
baby.names$Location <- "England and Wales"

base.url <- "http://tutorials.iq.harvard.edu"
baby.names.path <- "example_data/baby_names/US" 
baby.names.url <- str_c(base.url, baby.names.path, sep = "/")
baby.names.page <- read_lines(baby.names.url)

## extract file names
file.names <- na.omit(str_extract(baby.names.page, "[A-Z]+\\.csv"))
file.locations <- str_c(baby.names.url, file.names, sep = "/")

## read in the data
us.baby.names <- map(file.locations,
                     read_csv,
                     col_names = FALSE,
                     na = "",
                     col_types = "ccici")

## collapse list of data.frames into a single data.frame
us.baby.names <- bind_rows(us.baby.names)

## Add column names
names(us.baby.names) <- c("Location", "Sex", "Year", "Name", "Count")

## Wrap it in a function
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

test <- read.linked.files("http://tutorials.iq.harvard.edu/example_data/baby_names/US",
                          pattern = "[A-Z]+\\.csv",
                          reader.fun = function(x) {
                            read_csv(x, col_names = FALSE, na = "", col_types = "ccici")
                          })

str(test)
rm(test)

## Add argument checking and collapse argument
read.linked.files <- function(url,
                              pattern = "[A-z0-9]+\\.csv",
                              reader.fun = read_csv,
                              collapse = TRUE) {
  ## check arguments
  if(!is.character(url) | length(url) != 1) {
    stop("'url' is not a length-one character vector.")
  }
  if(!is.function(pattern) | length(pattern) != 1) {
    stop("'pattern' is not a length-one character vector.")
  }
  if(!is.function(reader.fun)) {
    stop("'reader.fun' is not a function.")
  }
    if(!is.function(reader.fun)) {
    stop("'reader.fun' is not a function.")
  }
  ## extract file names
  file.names <- na.omit(str_extract(read_lines(url), pattern))
  file.locations <- str_c(url, file.names, sep = "/")

  ## read in the data
  the.data <- map(file.locations,
                  reader.fun)
  ## bind rows only if requested
  if(collapse) {
    the.data <- bind_rows(the.data)
  }
  return(the.data)
}

baby.names[["Rank"]] <- NULL

baby.names <- bind_rows(baby.names, us.baby.names)
rm(us.baby.names)

baby.names[["Name"]] <- str_to_lower(baby.names[["Name"]])

## make up some example data
(example.df <- data.frame(id  = rep(letters[1:4], each = 4),
                          t   = rep(1:4, times = 4),
                          var1 = runif(16),
                          var2 = sample(letters[1:3], 16, replace = TRUE)))

## summarize
summarize(example.df,
          var1 = sum(var1))

## summarize by id
example.df %>%
  group_by(id) %>%
  summarize(var1 = sum(var1))

## summarize by id and var2
example.df %>%
  group_by(id, var2) %>%
  summarize(var1 = sum(var1))

group_by(baby.names, Year) %>%
  summarize(Total = sum(Count))

group_by(baby.names, Year, Sex) %>%
  summarize(Total = sum(Count))

## add new columns using mutate
(example.df <- example.df %>%
   mutate(n1 = n(),
          n2 = length(var1),
          var3 = var1/n1))

## combine with group_by
(example.df <- example.df %>%
   group_by(id) %>%
   mutate(n3 = n(),
          var4 = var1/n3))

## summarize by id and var2
(example.df.2 <- example.df %>%
   group_by(id, var2) %>%
   summarize(var1 = sum(var1)))

## sort by var1
example.df.2 %>%
  arrange(var1)

example.df.2 %>%
  arrange(desc(var1))

## sort by var1 within id
(example.df.2 <- example.df.2 %>%
   arrange(id, desc(var1)))

## select the top 2 var1's within each id group
example.df.2 %>%
  group_by(id) %>%
  slice(1:2)

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

(spelling.data <- spelling.data %>%
   group_by(Sounds.like) %>%
   mutate(Alternative.spellings = str_c(sort(original), collapse = "/")))

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

month.name
str_sub(month.name, 1, 1)
str_sub(month.name, 1, 3)
str_sub(month.name, -1, -1)
str_sub(month.name, -3, -1)

baby.names[["First.1"]] <- str_sub(baby.names[["Name"]], 1, 1)
baby.names[["First.2"]] <- str_sub(baby.names[["Name"]], 1, 2)
baby.names[["First.3"]] <- str_sub(baby.names[["Name"]], 1, 3)
baby.names[["Last.1"]] <- str_sub(baby.names[["Name"]], -1, -1)
baby.names[["Last.2"]] <- str_sub(baby.names[["Name"]], -2, -1)
baby.names[["Last.3"]] <- str_sub(baby.names[["Name"]], -3, -1)

baby.names$Name.length <- str_length(baby.names$Name)

.1 == .3/3

all.equal(.1, .3/3)

x <- c(1:10, NA, 12:20)
c(mean(x), sd(x), median(x), min(x), sd(x))

NA == NA

# combining values coereces them to the most general type
(x <- c(TRUE, FALSE, 1, 2, "a", "b"))
str(x)

# comparisons convert arguments to most general type
1 > "a"

mean(1, 2, 3, 4, 5)*5
sum(1, 2, 3, 4, 5)

args(mean)
args(sum)

(x <- factor(c(5, 5, 6, 6), levels = c(6, 5)))

str(x)

as.character(x)
# here is where people sometimes get lost...
as.numeric(x)
# you probably want
as.numeric(as.character(x))
