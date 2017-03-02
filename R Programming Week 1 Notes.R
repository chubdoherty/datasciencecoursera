#### Week 1 Nuts & Bolts

##DATATYPES

#VECTORS

#creating vectors
x <- c(0.5,0.6)

#create empty vector
y <- vector("numeric", length = 10)

#If you mix objects
#Number and character becomes character
#logical and number becomes number (T = 1)
#character and logical becomes character


#Explicit Coercion
#Changing one class to another

a <-  0:6
class(a)
as.numeric(a)
as.logical(a)
as.character(a)
#nonsensical coercion results in NA



#MATRICES

m <- matrix(nrow = 2, ncol=3)
m
#Find dimentions of Matrix
dim(m)
#or
attributes(m)

#to make non NA matrix
m <- matrix(1:6, nrow = 2, ncol = 3)
m
#Fills the matrix column wise

#We can also bind

x <- 1:3
y <- 10:12

cbind(x,y)

rbind(x,y)


#FACTORS - Special type of vector
#M/F or ranked cold, warm, hot

x <- factor(c("yes", "yes", "no", "yes", "no"))
x
#call table to show tally of each
table(x)

#use unclass to integers into 2's and 1's
unclass(x)

#Can set level order by using the levels argument.  yes as first level, no as second

x <- factor(c("yes", "yes", "no", "yes", "no"), levels = c("yes", "no"))
x

#MISSING VALUES

b <- c(1, 2, NA, 10, 3)
is.na(b)
is.nan(b) # Nan for mathematical operations 1/0  NaN is NA, but not the converse


#DATAFRAMES
#Special type of list where every element of the list has to have the same length, can store different classes

d <- data.frame(foo = 1:4, bar = c(T, T, F, F))
d
colnames(d)
nrow(d)
ncol(d)


#NAMES

e <- 1:3
names(e)

names(e) <- c("foo", "bar", "norf")
e

f <- list(a = 1, b = 2,  c = 3)
f

g <- matrix(1:4, nrow = 2, ncol = 2)
dimnames(g) <- list(c("a", "b"), c("c", "d"))
g




##READING TABULAR DATA

# read.table() most common
# can use it without any other arguments if it is just a small:moderate data set
# read.csv is the same, header is true and sep = ","



#Reading large datasets how to optimise

#read help page for read.table, lots of useful information MEMORISE
#set comment.char = "" if there are no comment lines

#colClasses takes time if large dataset.  If you can specify this, it saves time
#if all the same colClasses = "numeric"

#we can use a shortcut and find the classes of each col, take subset, first n rows:
# initial <- read.table("datatable.txt", nrows = 100)
# classes <- sapply(initial, class)
# tabAll <- read.tabl("datatable.txt", colClasses = classes)


#nrows doesn't make it run faster, but uses less memory mild overestimate is ok



#IF large dataset, know the system, how much memory etc
#how to calculate memory requirements:

#1,500,000 rows 120 colums

#1.5E6 * 120 * 8 bytes = 144E9
#=144E9/ 2^20 bytes/MB
#= 1,373.29 MB
#=1.37 GB  but we will actually need about twice this to read it in.


#Textual Formats

#to write, dump or deput dataframe preserves the metadata (sacrificing some reliability)
#functions are source or deget

h <- data.frame(a = 1, b = "a")
dput(h)
dput(h, "h.R")
new.h <- dget("h.R") #read it preserving metadata
new.h

#dump similar, but unlike dget can be used on multiple objects

j <- "foo"
k <- data.frame(a = 1, b = "a")
dump(c("j", "k"), file = "data.R")
rm(j,k)
source("data.R")
k


#Interfaces with outside world

#from a file, gzfile (compressed with gzip), bzfile(compressed with bzip2), url (opens a connection to a webpage)

# when opening filem open code is r -read only, w - writing/initialising new file, a - appending, 
#rb/wb/ab same but to a binary



#Connections
#Connections are powerful tools:

#NOt useful here, but example:

#con <- file("foo.txt","r")
# data <- read.csv(con)
# close(con)

#Read 10 lines:

# con <- gzfile("words.gz)
# x <- readLines(con, 10) reading 10 lines

#read from website

# con <- url("http://jhsph.edu", "r")
#x <- readLines(con)





##SUBSETTING

# [] returns object of same class as the original; can be used to select more than one element

# [[ ]] returns elements of list or a dataframe; it can only be used to extract a single element 
# and the class returned will not necessarily be that of a list or dataframe

# $ is used to extract elements of a list or data frame by namel semantics are similar to [[ ]]

l <- c("a", "b", "c", "c", "d", "a")

l[1]
l[2]
l[1:4]

#using a logical index
l[l > "a"]

#find which elements are greater
u <- l > "a"
u
#Use l and u to give the same as above 
l[u]




#Subsetting list

n <- list(foo = 1:4, bar = 0.6)
n[1] # n is a list, therefore n[1] is a list (same class)

n[[1]] # just the sequence

n$bar
n[["bar"]] #same as above
n["bar"] # gives list




#multiple elements

o <- list(foo = 1:4, bar = 0.6, baz = "hello")
 #Must use single bracket for multiple elements, can't use double bracket or dollar sign
o[c(1,3)]

#You can use [[ ]] with computed indices $ can only be used with literal names
name <- "foo"
o[[name]] # same as o$foo o$name wouldn't work




#subsetting nested elements

p <- list(a = list(10, 12, 14), b = c(3.14, 2.81))

#if we want element 3 of list 1
p[[c(1,3)]]
#or
p[[1]][[3]]




#Subset Matrices

q <- matrix(1:6, 2, 3)

#if you want 1st row second column
q[1,2]
# or indices can be missing to get entire row/column
q[1,]
q[,2]

#By default, when a single element of a matrix is retrieved, it is returned as a vector of length 1 rather than
# a 1 by 1 matrix.  This can be turned off by setting drop = false

q[1,2, drop = F]

#can also get a range and keep as a matrix
q[1,2:3, drop = F]




#Partial Matching

r <- list(aardvark = 1:5)

#Dollar looks for name in list that matches a.  
r$a


r[["a"]]

#need to set exact to false, as it expects an exact match
r[["a", exact = F]]




#Removing NA Values

s <- c(1, 2, NA, 4, NA, 5)

bad <- is.na(s)
s[!bad] #bang operator


#Removing NA from multiple things

t <- c("a", "b", NA, "d", NA, "f")

#which positions do both have "non missing" values
good <- complete.cases(s,t)
good

s[good]
t[good]


#Can also carry this out on a dataframe
good <- complete.cases(airquality[1:6,])

#we want where all rows are complete
airquality[good, ][1:6, ]




##VECTORISED OPERATIONS

u <- 1:4; v <- 6:9

#add first element u to first element u,....don't need to loop
u+v

#Logical output, which values are greater than 2
u>2
#greater than or equal to
u >= 2
#test equality
v == 8
#Multiplication/Division also vectorised
u*v
u/v


#VECTORISED MATRIX OPERATION

w <- matrix(1:4, 2, 2); z <- matrix(rep(10, 4), 2, 2)

#element wise multiplcation
w*z
w/z

#true matrix multiplication
w%*%z
