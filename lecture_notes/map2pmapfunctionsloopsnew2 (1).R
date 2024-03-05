library(tidyverse)

# A continuation of the usage of map functions 
# map2() ,  pmap()

# The map functions map2() and  pmap() make it possible to iterate over
# multiple arguments simultaneously.

# map2(.x, .y, .f, ...)  a function is applied or iterated over two arguments
# simultaneously.  .x and .y are vectors of the same length

# Example 1

x <- list(12, 14, 15, 18, 19)
x
y <- list(8, 14, 20, 22, 30)
y

# Finding iterative sums
map2(x,y, ~ .x + .y) 

map2_dbl(x,y, ~ .x + .y) 
# or
map2_dbl(x,y,  `+`)

# Performing a miscellaneous iterative calculations

x <- list(12, 14, 15, 18, 19)
y <- list(8, 14, 20, 22, 30)


map2(x,y,  ~ 2*.x - .y)        

map2_dbl(x,y,  ~ 2*.x - .y)   

map2_dbl(x,y, ~log(.x) + log(.y))



x <- list(12, 14, 15, 18, 19)
x
y <- list(8, 14, 20, 22, 30)
y

# Obtaining summary values
map2_dbl(x,y, min)

map2_dbl(x,y, max)

map2_dbl(x,y, sum)

map2_dbl(x,y, diff) ? # does not work !!

# methods to find differences
  
map2_dbl(x,y,  ~.x - .y)

map2_dbl(x,y, ~.y - .x )


x <- list(12, 14, 15, 18, 19)
y <- list(8, 14, 20, 22, 30)


#iterate to find means

map2_dbl(x,y, mean)  # Is this working ?

# alternate coding

map2_dbl(x,y, ~ ((.x+.y)/2))


# prerequisite work investigation of the function rnorm.
rnorm(n, mu, sd)

rnorm(400,2,.5)->X
X


# Let's double check

mean(X)
sd(X)

# If the mean and the standard deviation are not indicated, they are understood
# to be 0 and 1 respectively

rnorm(400) -> k
k

mean(k)
sd(k)

# Another map2 application

mu <-list(5, 10, -3)
sigma <-list(1, 5, 10)

# Let's execute three sets 5 randomly selected values (normally distributed)
# , having the means and standard deviations indicated above

map2(mu, sigma, rnorm, n = 5)%>%
  str()

# pmap is a function that is applied or iterated over multiple 
# arguments (more than two) simultaneously. Again, the vectors are of the same
# length.

# pmap(.l, .f, ...)

# Example 2

x <- list(12, 14, 15, 18, 19)
x
y <- list(8, 14, 20, 22, 30)
y
z <- list(10, 18, 28, 34, 40)
z

# Find iterative sums

pmap_dbl(list(x,y,z), sum)

# Iteratively find minimum values
pmap_dbl(list(x,y,z), min)

# Alternative coding

# Find the means
pmap_dbl(list(x,y,z), function(first, second, third) (first + second + third)/3)

# Calculate output for a specialized function
pmap_dbl(list(x,y,z), function(first, second, third) 2*first + second + third)


# Another application for pmap
# Using iterative code to write descriptions for observations of a data
# frame.

tribble( ~Student,  ~Gender, ~Age,
         "John",   "Male",    20,
         "Alice",  "Female",  24,
         "Juan",   "Male",    21,
         "Beth",   "Female",  19,
         "Denise", "Female",  22
         ) -> A
A

A %>% 
  pmap_chr(~ str_glue("The student {..1} is a {..2} who is {..3} years old."))

A %>% 
  pmap_chr(~ str_glue("{..1} is a {..2} whose age is {..3}"))

# using pmap on tribbles

tribble( ~mean, ~sd,  ~n,
        5,       1,   15,
        10,      5,   10,
        -3,      10,  20
        ) -> parameters
parameters


pmap(parameters, rnorm)



# While loops / nested loops


i <- 1
while (i < 6) {
  print(i)
  i = i+1
}


i <- 1
while (i^2 < 100) {
  print(i)
  i = i+1
}


# Write a for loop that uses the break command to 
# end outputs values after 6 values
x <- 1:11
for (val in x) {
  if (val == 7){
    break
  }
  print(val)
}


# Write a for loop that uses the next command to skip over the output value
# of 7 and then continues the output sequence.

x <- 1:11
for (val in x) {
  if (val == 7){
    next
  }
  print(val)
}

# Lets write a for loop to process on a data frame

# Lets first create a data frame.

data <- data.frame(x1 = 10:15,    # Create example data
                   x2 = 66:71,
                   x3 = 14:19)
data                            # Print example data




data2 <- data                   # Replicate example data
data2

# Now, we can use the for-loop statement to loop through our data frame
# columns using the ncol function as shown below:
  
  for(i in 1:ncol(data2)) {       # for-loop over columns
    data2[ , i] <- data2[ , i] + 5 
}

data2


# Nested Loops

# A nested loop is a loop within a loop. Sounds simple, but there are a 
# variety of ways you can create nested loops. Let's check some out and
# remember that proper indentation is key.

# Here is the general format of a nested loop:

# loop (condition) {
#   block of instructions
#   loop (condition) {
#     block of instructions
#   }
# }

# Nested Loop 1

for (k in 1:3) {
  for (l in 1:2) {
    print(paste("k =", k, "l = ", l))
  }
}

# Interpretation:
# k->l   k->l   k->l   k->l   k->l   k->l
# 1->1,  1->2,  2->1,  2->2,  3->1,  3->2


# Nested Loop 2

for(i in 1:4)
{
  for(j in 1:4)  # Interpretation: 1*1, 1*2, 1*3, 1*4, 2*1, 2*2, 2*3,
                 #...4*1,4*2,4*3,4*4
  {
    print(i*j)
  }
}

# Nested Loop 3

num_vector<-c(1,2,3)
num_vector

alpha_vector<-c("a", "b", "c")
alpha_vector

for(num in num_vector) { # outer loop 
  print(num) 
  for(letter in alpha_vector) # inner loop
    print(letter)
}



# Nested loops to create a matrix
# Let's create a 4 by 4 matrix whose row and column entries are products.

#  What is a matrix ?

#  A matrix is a rectangular array of values, characterized by rows and
#  columns

# Below is a 3 by 4 matrix (3 rows and 4 columns)


#     2   4   -3   6
#     1   3    5  -1
#     6   0    3   8

#1

matrix1 = matrix(nrow=4, ncol=4) # create a 4 x 4 matrix(4 rows and 4 columns)
for(i in 1:nrow(matrix1))        #// Assigned a variable 'i' for each row
{
  for(j in 1:ncol(matrix1))      #// Assigned a variable 'j' for each column
  {
    matrix1[i,j] = i*j           #// calculating product of two indeces
  }
}
print(matrix1)

#2

# What are the characteristics of the matrix produced by the 
# coding below?

z <- matrix( nrow = 3, ncol = 3)
for (m in 1:3) {
  for (n in 1:3) {
    z[m, n] <- -1*(m + n)
  }
}
print(z)


q()
y
