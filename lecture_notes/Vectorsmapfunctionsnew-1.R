---
editor_options: 
  markdown: 
    wrap: 72
---

# Vectors / Iteration with purr / map functions

```{r}
library(tidyverse) 

library(dplyr)
```

# Review and Recall

Write a function that will deliver the Volume, Surface Area,

and the length of a diagonal of a Cube. (multiple executions)

```{r}
Cube <- function(e) {
  Volume <- e^3
  SA <- 6*e^2
  DL <- e*sqrt(3)
  return(c(Volume = Volume, SA = SA, DL = DL))
} 

Cube(10)
Cube(12)
Cube(6)
```

### Alternate method

```{r}
Cube <- function(e) {
  Volume <- e^3
  SA <- 6*e^2
  DL <- e*sqrt(3)
  return(data.frame(Volume = Volume, SA = SA, DL = DL))
}

Cube(c(10,12,6))
```

# What is a Vector ?

In physics and mathematics a vector is a quantity or phenomenon that has
two independent properties; magnitude and direction. Our definition or
description however is considerably less technical.For the purposes of
this class, a vector is simply a collection of "things" or objects.
Those "things" can be numbers, words, letters, or other miscellaneous
items.

## Vectors are of two types:

## Atomic Vectors

There are six types of Atomic Vectors: logical, integer, double,
character, complex, and raw. Integer and double vectors are commonly
referred to as numeric vectors.

An Atomic Vector is homogeneous. (the items in the vector are of the
same type)

The following are examples of Atomic Vectors.

```{r}
X <- c("Raymond","Twenty", "Boston", "Eastern") # All items in the vector are character strings 

Y <- c(121, 128, 89, 11, 56 ) # All items in the vector are integers
```

### Examples of Atomic Vectors (the objects are of the same type)

```{r}
V1 <- c(12, 33, 2, 82, 33) # All objects are integers V1

V2 <- c(.002, 3.6, 7.32, 4.5, 6.0) # All objects are doubles V2

V3 <- c(FALSE,TRUE,TRUE,FALSE) # All objects are logical entries V3

V4 <- c("JANE", "BILL", "JUAN", "EILEEN", "ANN") # All objects are character strings
```

## Lists

A List is heterogeneous. A List therefore can contain items of different
types. (and other lists)

```{r}
A <- list( 36, "big" TRUE, list(2,"two", FALSE) ),
```

Finding the type and length of a Vector. use the function "typeof" to
identify the vector and use the function "length" to determine the
number of elements that the vector has.

### Examples of Lists (objects can be of different types)

```{r}
L1 <- list(6, 3.8, "every", TRUE)

L2 <- list(TRUE, 12, .0125, "cat", list(2:5)) # note that a list L2  can contain another list

typeof(c(11,15,20.5,37))

length(c(11,15,20.5,37))

AA <- (c("apple", "grape", "peach", "plum", "banana"))

typeof(AA)

length(AA)
```

### Finding the length of a List

```{r}
M <- list("ALICE", 2:12, TRUE, 95)

length(M) # What happens when typeof is applied to M ? Returns what kind of vector it is
typeof(M) 
```

# Naming , describing or listing the content of a vector.

## Use the code set_names from the purr package.

```{r}
set_names(c("Boston","Baltimore","Atlanta", "New York","Cleveland")) 
set_names(c(14,12,.003,6,20))

set_names(5:7, c("m", "n", "p")) # numeric system: 5,6,7 and character vector --> result is a mapping where m is mapped to 5, n is mapped to 6, and p is mapped to 7
```

## Subsetting Vectors

```{r}
X <- c("Boston","Baltimore","Atlanta", "New York","Cleveland")
X

#all character variables --> atomic vector
```

## Extract the first string of the vector (use brackets)

```{r}
X[1] # extracts the first element
```

## Extract the second and fourth strings of the vector

```{r}
X[c(2,4)]
```

## Extract the second string of the vector three times

```{r}
X[c(2,2,2)]
```

## Drop a string from the vector. (Let's drop the string New York)

```{r}
X[-4] # drops the fourth element
```

Another example:

```{r}
U <- c(10, 3, NA, 5, 8, 1, NA) 
U
```

## Extract all missing values from the vector

```{r}
U[is.na(U)]
```

## Extract all values from the vector that are not missing

```{r}
U[!is.na(U)]
```

## Extract all values from the vector that are even (Extract only 10 and 8)

```{r}
U <- c(10, 3, NA, 5, 8, 1, NA) 
U

U[U %%2 == 0 & !is.na(U)]
```

## Extract all values from the vector that are greater than 2 and the missing values

```{r}
U[U > 2] # no code controlling the missing values, so it also returns the missing values
```

### Practice:

```{r}
U <- c(10, 3, NA, 5, 8, 1, NA) 
U
```

#1 The following subsetting code will extract What elements ? U[!(U \>
5) & !is.na(U)]

```{r}
U[!(U > 5) & !is.na(U)] # exctracts everything NOT greater than five and NOT missing
```

#2 What does the following code produce ? U[]

```{r}
U[] # doesn't extract anything
```

# Lists

Recall that lists can contain different object types.

```{r}
Y <- list("ball", 25, 12.25, FALSE, b = 1:5, c = list(-1, "west")) 
Y
```

Use the command str to categorize each object

```{r}
str(Y)
```

## Subsetting on a List

### using [[ ]] to subset a single object

```{r}
Y <- list("ball", 25, 12.25, FALSE, b = 1:5, c = list(-1, "west")) 
Y

str(Y[[1]]) # lists use double brackets; profiles the first element (in this case, "ball")
str(Y[[4]]) # profiles the fourth element (in this case FALSE)
str(Y[[6]]) # profiles the sixth element (in this case, the list)
str(Y[['c']]) # another way to extract the sixth element
```

### Using \$ to subset a single object

```{r}
Y$c

Y$b
```

Lets extract the object "ball" using the \$ sign

```{r}
Y <- list("ball", 25, 12.25, FALSE, b = 1:5, c = list(-1, "west")) 
Y
```

note that Y\$1 does not work !!

```{r}
Y$1
```

note that Y\$"ball" does not work !!

```{r}
Y$"ball"
```

Solution: assign the character string to a variable, and then apply \$
to the variable

```{r}
Y <- list(k = "ball", 25, 12.25, FALSE, b = 1:5, c = list(-1, "west")) 
Y 
Y$k

```

### Subsetting to get a list from a list (Use str([ ]))

```{r}
Y <- list("ball", 25, 12.25, FALSE, b = 1:5, c = list(-1, "west")) 

Y

str(Y[1:3]) # extract and profiles the first three elements

str(Y[5:6]) # extract and profiles elements 5 and 6

str(Y[ ]) # extract and profiles the whole list
```

# Using the purr package map functions.

## Example 1: Lets consider the previously learned code and method for finding the median of every column of mtcars

```{r}
mtcars
```

using brute force:

```{r}
median(mtcars$mpg) 
median(mtcars$cyl) 
median(mtcars$disp) 
median(mtcars$hp) 
median(mtcars$drat) 
median(mtcars$wt) 
median(mtcars$qsec) 
median(mtcars$vs) 
mean(mtcars$am)# two more
```

Lets use the special for loop:

```{r}
output2 <- vector("double", ncol(mtcars))
for (i in seq_along(mtcars)){
  output2[[i]] <- median(mtcars[[i]])
}
output2
```

Now lets use one of the map functions to get the same results:

```{r}
map_dbl(mtcars, median) # this is better because there is less coding; more efficient and it returns the statistical summary with each of the column labels
```

Suppose we wanted to use a map function to get the standard deviation
for each variable of the mtcars data table.

```{r}
map_dbl(mtcars, sd)

mtcars
```

Lets round each result to the nearest tenth method 1

```{r}
map_dbl(mtcars, sd) -> X 
X

round(X, digits = 1)
```

## method 2

```{r}
round(map_dbl(mtcars, sd), digits = 1) # does the same thing where round is the wrapping function and all the math is nested inside of the round function
```

What will the following code produce from the mtcars data table?

```{r}
map_dbl(mtcars, max) # maximum from each column, labeled
```

Lets use the piping procedure to apply map functions. Find the mean of
each column

```{r}
mtcars %>% 
  map_dbl(mean)
```

Find the minimum of each column

```{r}
mtcars %>% 
  map_dbl(min)
```

Lets modify the value of each column (Add 3 to each column )

```{r}
mtcars

mtcars %>% 
  map(~. + 3) # add three to every element 
```

## Textbook example

Lets find a linear model for each type of cylinder categories for \#
vehicles in the mtcars data set. (We will use weight to predict \# miles
per gallon) How many cylinder types are there ?

```{r}
mtcars

factor(mtcars$cyl)
```

So we want R coding that will produce a linear model for 4 cylinder
vehicles, 6 cylinder vehicles, and 8 cylinder vehicles.

```{r}
models <- mtcars %>% 
  split(.$cyl) %>% # extracts the cyl column from mtcars
  map(~lm(mpg ~ wt, data = .)) # wt used to predict mpg; model built for each level of cyl
models
```

Now lets get more detailed information for each model.

```{r}
models %>% 
  map(summary) # calculates model summary for each model
```

## Lets find a particular value of the summary: We will find Rsquared

## method 1

```{r}
models %>% 
  map(summary) %>%
  map_dbl(~.$r.squared) # extracts the r squared from the summary for each each level of cyl
```

## method 2

```{r}
models %>% 
  map(summary) %>% 
  map_dbl("r.squared") # does the same thing as above
```

## How can we find r (the correlation coefficient) for each model?

```{r}
models %>% 
  map(summary) %>% 
  map_dbl(~.$r.squared) -> models1  # saved to models1
models1
```

## method 1

```{r}
models1 -> xx
xx^0.5 # same as taking a square root
```

## method 2

```{r}
sqrt(models1)
```

q() y
