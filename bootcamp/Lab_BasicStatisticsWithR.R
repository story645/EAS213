### Lab.R ###

# Basic mathematical operations
3 + 4
5 * 5
12 / 3
5^5

# R objects

# Vector 
## Most basic object in R 
## Contains elements of the same class
## Can be: character, numeric, integer, complex, logical(True/False))

# Create a vector
v=c(1,3,5,7) #using "c" command create a "numeric" vector, "c" stands for combine or concatenate
v

# Create a matrix
m=matrix(1:6,2,3) #integer 1 to 6, 2 rows and 3 columns
m
## Matrix creation is column-wise

# Create a matrix from a vector
m2=matrix(1:6)
# Then add dimensionality
dim(m2)=c(2,3)
m2

# Create a matrix by binding columns or rows
x=1:6
y=5:10
cbind(x,y) # by column
rbind(x,y) # by row

# Check the attributes
attributes(m) # its just a 2 by 3 matrix

# Call a particular cell in a matrix
m
m[1,2] #open bracket, row number, column number 

# Dataframes 
## Different than matrices => can store different classes of objects. I'll provide you the data with the dataframes.
## Usually called with read.table()

# Create a dataframe
d=data.frame(subjectID=1:5,gender=c("M","F","F","M","F"),score=c(8,3,6,5,5))
d

# Number of rows
nrow(d) #how many rows are there?

# Number of columns
ncol(d) #how many columns are there?

# Check the attributes
attributes(d) #this will give you the names and class

# Call a particular cell in a dataframe
d[2,1]
d[1,2]

# Display dataframe
View(d)
# Edit dataframe
edit(d)

# Getting help on a function
#?functionname

# Download and install packages
install.packages("psych") ## Need to specify CRAN the 1st time; Comprehensive R Archive Network; you may have to pick a location close to you

# Load package
library(psych)

#to make sure that the package is there
search()

# we install and load a lot of packages


################################

#   Read a datafile into R
#   Learn little bit more about object types
#   We'll print some summary statistics in R.
#   Examine distributions using histograms

# Example
#   Investigating the effects of sports-related concussion
#   Simulated data are based on an online assessment tool called IMPACT (http://www.impacttest.com)
#   IMPACT provides 6 main measures/variables, listed here:
#     Memory composite verbal
#     Memory composite visual
#     Visual motor speed composite
#     Reaction time composite
#     Impulse control composite
#     Total symptom score (how many symptoms are you experiencing related to a concussion). 
#     ****The way this research works typically is athletic directors or coaches administer this impact test to their
#     athletes both before and after a concussion, so they get a "baseline" measure and that's what we're calling some of our variables in today's lab.
#     and then, after a concussion, they measure them again. Having that "baseline" is very helpful because you can see if an athlete has 
#     changed from baseline to "post" injury. Without the baseline measures, it would be harder to detect.

# Check your working directory
getwd()
# If necessary, set your working directory
# setwd("~/Volumes/Pal/R")

# NOTE: Setting the working directory, is different depending on what kind of computer or the operating system you're using.
# But using the  function in R called "getwd" is universal and that will tell you what your working directory is.
# Download and install packages
install.packages("sm")

# Load packages
library(sm) #R may just tell you what version of these packages are.

installed.packages() #also shows ALL the packages you have installed in the history, no matter whether they are in your working directory [there's typically more than one way to do things in R]

#***So now we have the necessary packages loaded

# Read in the data into a dataframe called "impact"
# The data exists in a file called "data.Lab.txt". The data file is a text file. Read it using the read.table function, but there are other ways to do this too.
# You could save datafiles as .csv, for example, and there's a read.csv function.
# For this course, I'm just typically going to save things as .txt and use the read.table function.

impact <- read.table("data.Lab.txt", header = T) #argument header = TRUE. Top row contains the variable names and the subsequent rows contain the data

# Get the dimensions of the dataframe
dim(impact) #how many rows and columns? 40 athletes and 14 columns of data.
nrow(impact) #how many rows?
ncol(impact) #how many columns?

#edit(impact) #to see your data on editor but be careful when you open the editor. 
View(impact) #to view the data on editor or click the data on "Global Environment"

# Object types
class(impact) 
names(impact) #to see the name of all the variables in your dataframe

class(impact$verbal_memory_baseline) #to access ONE variable in your dataframe, name of dataframe then dollar sign and then variable name
class(impact$reaction_time_baseline) #numeric (fraction)
class(impact$subject)
#but "subject" is a nominal variable. e.g. subject 2 is not > subject 1! They are really names.

impact$subject <- factor(impact$subject) #to change the "class" of the variable, use "factor" function
class(impact$subject)

# Summary statistics
mean(impact$verbal_memory_baseline) 
sd(impact$verbal_memory_baseline)

describe(impact) #to see overall summary statistics (descriptive statistics) for all the variables in the dataframe

describeBy(impact, impact$condition) #split summary statistics "by categorical conditions" or "by independent/quasi-independent  variables" (conditions come in the alphabatical order)

# Subsetting [many ways to do it but will show one way]
control <- subset(impact, impact[, 2]=="control") #if column 2 = "control", subset the data
control 

# use "<-" for ASSIGNING a dataframe; "==" want R to return boolean expression/TRUE-FALSE
# do it again for "concussed"

concussed <- subset(impact, impact[, 2]=="concussed")
concussed

# Histograms of control group at baseline
par(mfrow = c(2,3)) # par stands for - set a parameter; To view 6 histograms on one page; set up 2 rows and 3 columns; matrix formation by rows 
hist(control[, 3], xlab = "Verbal memory", main = "") #"main=""" makes no title for that histogram
hist(control[, 4], xlab = "Visual memory")
hist(control[, 5], xlab = "Visual motor speed")
hist(control[, 6], xlab = "Reaction time")
hist(control[, 7], xlab = "Impulse control")
hist(control[, 8], xlab = "Total symptom score")

# To demonstrate that there is more than one way to access a variable
par(mfrow = c(1,2)) # To view 2 same histograms on one page 
hist(control[, 3], xlab = "Verbal memory", main = "") 
hist(control$verbal_memory_baseline, xlab = "Verbal memory", main = "") 

# Histograms of concussed group at baseline
par(mfrow = c(2,3))
hist(concussed[, 3], xlab = "Verbal memory", main = "")
hist(concussed[, 4], xlab = "Visual memory", main = "")
hist(concussed[, 5], xlab = "Visual motor speed", main = "")
hist(concussed[, 6], xlab = "Reaction time", main = "")
hist(concussed[, 7], xlab = "Impulse control", main = "")
hist(concussed[, 8], xlab = "Total symptom score", main = "")

# Histograms of control group at retest
par(mfrow = c(2,3))
hist(control[, 9], xlab = "Verbal memory", main = "") 
hist(control[, 10], xlab = "Visual memory", main = "")
hist(control[, 11], xlab = "Visual motor speed", main = "")
hist(control[, 12], xlab = "Reaction time", main = "")
hist(control[, 13], xlab = "Impulse control", main = "")
hist(control[, 14], xlab = "Total symptom score", main = "")

# Histograms of concussed group at retest
par(mfrow = c(2,3))
hist(concussed[, 9], xlab = "Verbal memory", main = "")
hist(concussed[, 10], xlab = "Visual memory", main = "")
hist(concussed[, 11], xlab = "Visual motor speed", main = "")
hist(concussed[, 12], xlab = "Reaction time", main = "")
hist(concussed[, 13], xlab = "Impulse control", main = "")
hist(concussed[, 14], xlab = "Total symptom score", main = "")

# Density plots (here we need the 'sm' package)
par(mfrow = c(1,2))
hist(concussed[, 14], xlab = "Total symptom score", main = "")
plot(density(concussed[, 14]), xlab = "Total sympton score", main = "") #best fit to histogram/smoothing
