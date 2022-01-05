##### LANGUAGE BASICS -----

# R can run simple calculations
1 + 1 
4^2

# Calculations aren't useful unless we put the results somewhere 
# The assignment operator stores the result into a variable

two <- 1 + 1
two

# Once assigned, variables can be modified by re-assigning a new value to them

two <- 1 + 3
two

# Variables can be removed from the workspace with rm
# After removing two, calling it again would lead to an error 
rm(two)
two

# Variables can be reused in expressions to calculate new variables/outputs
var1 <- 5
var2 <- 10
var3 <- var1 + var2

# When assigning variables, nothing prints to the console 
# Let's use the function print
print(var3)

##### CALLING FUNCTIONS AND PACKAGES ----- 

# Print and rm are functions that we use in R 
# We call functions by writing their name followed   
# by a list of arguments in parentheses

abs(-1)
mean(var1, var2)
sum(var1, var2, var3)

# c is a function that combines values together
my_vars <- c(var1, var2, var3)
my_vars

# RStudio has built-in help for every function
?c

# Functions can also be used to import data
ds <- read.csv('data_raw/vocab16.csv')
print(ds)

# read.csv is part of base R, the default fx set
# When we want to use functions to expand R, we
# need to use library fx to load packages

library(readr) #for read_csv
ds <- read_csv('data_raw/vocab16.csv')

##### READING DATA WITH READR ----- 
library(dplyr) #Needed for bind_rows

# Each file contains data for 2-week intervals
dir('data_raw') #function for listing a directory

# This is slow and tedious!
ds12 <- read_csv('data_raw/vocab12.csv')
ds12.5 <- read_csv('data_raw/vocab12.5.csv')
ds13.5 <- read_csv('data_raw/vocab13.5.csv')
ds_all <- bind_rows(ds12, ds12.5, ds13.5)
print(ds_all)

# read_csv can read a list of files!
full_file_names <- dir('data_raw', full.names = TRUE)
ds_all <- read_csv(full_file_names)
print(ds_all)

##### ACCESSING/ADDING VARIABLES AND WRITING DATA ----- 
# Find the minimum and maximum ages
min(ds_all$age)
max(ds_all$age)

# Create a new column in a dataset
ds_all$ppt_name <- "Jonah"
print(ds_all)

# Create a calculated column
ds_all$age_round <- round(ds_all$age)
print(ds_all)

# Let's write the combined data to disk
write_csv(ds_all, file = "data_cleaned/vocab_combined.csv")

##### USING READ_CSV OPTIONS ----- 

# Set up some variables to use in the read_csv options
fname <- "data_cleaned/vocab_combined.csv"
colname <- c("AGE", "WORD", "NAME", "MONTH")
coltypes <- "cccc"

# Read the file using different options
# Use the RStudio data viewer to see the changes each time
ds <- read_csv(file = fname) 
ds <- read_csv(file = fname, col_names = FALSE)
ds <- read_csv(file = fname, col_names = colname) 
ds <- read_csv(file = fname, col_names = colname, skip = 1) 
ds <- read_csv(file = fname, col_names = colname, col_types = coltypes, skip = 1) 

