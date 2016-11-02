library(ggmap)
nwbuilding <- geocode("1737 Cambridge Street Cambridge, MA 02138", source = "google") 
ggmap(get_map("Cambridge, MA", zoom = 15)) +
  geom_point(data=nwbuilding, size = 7, shape = 13, color = "red")

library(forecast)
fit <- auto.arima(austres)
## Projected numbers (in thousands) of Australian residents
plot(forecast(fit))

library(plotly)
comet <- rgl::readOBJ(url("http://sci.esa.int/science-e/www/object/doc.cfm?fobjectid=54726"))

comet.plot <- plot_ly(x = comet$vb[1,],
                      y = comet$vb[2,],
                      z = comet$vb[3,],
                      i = comet$it[1,]-1,
                      j= comet$it[2,]-1,
                      k = comet$it[3,]-1,
                      type = "mesh3d")

setwd("images")
htmlwidgets::saveWidget(comet.plot, file = "comet.html")
setwd("..")

comet.plot

2 + 2
sum(2, 2)

sqrt(10)
10^(1/2)

x <- 10 # Assign the value 10 to a variable named x
x + 1 # Add 1 to x
x # note that x is unchanged
y <- x + 1 # Assign y the value x + 1
y
x <- x + 100 # change the value of x
y ## note that y is unchanged.

ls() # List variables in workspace
x # Print the value of x
x <- 100 # Overwrite x. Note that no warning is given!
x
rm(x) # Delete x
ls()

x <- c(10, 11, 12)
X <- c("10", "11", "12")
y <- c("h", "e", "l", "l", "o")
Y <- "hello"
z <- c(1, 0, 1, 1)
Z <- c(TRUE, FALSE, TRUE, TRUE)

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

mode(x)
mode(as.character(x))
mode(X)
mode(as.numeric(X))

## FunctionName(arg.1, arg.2, ..., arg.n)

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

## Start html help, search/browse using web browser
help.start() # or use the help menu from you GUI
## Look up the documentation for a function
help(plot) ## or use the shortcut: ?plot
## Look up documentation for a package
help(package="stats")
## Search documentation from R (not always the best way... google often works better)
help.search("classification")

##To see what packages are loaded: 
search()

## To view available packages: 
library()

## To load a package: 
library("MASS")

## Install new package: 
install.packages("stringdist")

## inspect search path
search()
orig.search.path <- search()

## install the tidyverse package and check search path
# install.pacakges("tidyverse")
search() ## unchanged

## attach the tidyverse pacakge
library("tidyverse")
print(orig.search.path)
search() ## different now that we have attached the package using the library function

## look up the readr package documentation
help(package = "readr")
## I would use read_tsv to read a tab delimited file.

getwd() # what is my current working directory?
# setwd("~/Desktop/Rintro") # change directory

getwd() # get the current working directory
setwd("dataSets") # set wd to the dataSets folder
getwd()
setwd("..") # set wd to enclosing folder ("up")

list.files("dataSets") # list files in the dataSets folder

## read ?read_csv
## limit rows with n_max argument
read_csv("dataSets/babyNames.csv", n_max = 10)

## specify column types in the col_types argument
read_csv("dataSets/babyNames.csv", n_max = 10, col_types = "??c????????????")

## read all the data
baby.names <- read_csv("dataSets/babyNames.csv", col_types = "??c????????????")

## we know that this object will have mode and length, because all R objects do.
mode(baby.names)
length(baby.names) # number of columns

## additional information about this data object
class(baby.names) # check to see that test is a data.frame
dim(baby.names) # how many rows and columns?
names(baby.names) # or colnames(baby.names)
str(baby.names) # more details
glimpse(baby.names) # details, more compactly

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

select(example.df, id, var1)
select(example.df, id, t, var1)

example.df$t

filter(select(example.df,
              id,
              var1),
       id == "a")

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

# write data to a .csv file
write_csv(example.df, path = "example.csv")

# write data to an R file
write_rds(example.df, path = "example.rds")

# write data to a Stata file
library(haven)
write_dta(example.df, path = "example.dta")

ls() # list objects in our workspace
save.image(file="myWorkspace.RData") # save workspace 
rm(list=ls()) # remove all objects from our workspace 
ls() # list stored objects to make sure they are deleted

load("myWorkspace.RData") # load myWorkspace.RData
ls() # list objects

filter(baby.names, Sex == "M" & Percent >= 3)

baby.names <- mutate(baby.names, Proportion = Percent/100)

popular.girl.names <- filter(baby.names, Sex == "F" & Percent >= 3)

write_csv(popular.girl.names, path = "popularGirlNames.dta")

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

summarize(group_by(example.df, id), mean(var1), sd(var1))

summarize(group_by(example.df, id, var3), mean(var1), sd(var1))

sink(file="output.txt", split=TRUE) # start logging
print("This is the summary of example.df \n")
print(summary(example.df))
sink() ## sink with no arguments turns logging off

sum(baby.names$Count)

sum(filter(baby.names, Location == "MA")$Count)

summarize(group_by(baby.names, "Year"), sum(Count))

mean(baby.names$Name.length)

summarize(group_by(baby.names, Location), mean(Name.length))

plot(example.df$var4)

plot(select(example.df, id, var1))

plot(select(example.df, id, var4))

plot(select(example.df, var1, var2))

system("rm dataSets/myWorkspace.RData")
system("rm example*")
