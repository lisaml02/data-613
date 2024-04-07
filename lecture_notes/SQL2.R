

# what is SQL ?
# SQL (Structured Query Language) is a standard language used
# for database creation and manipulation.

# There are many SQL data base packages that can be used for
# Data Table processing and explorations We will use the sqldf
# Data Base Management system to deliver and modify SQL Data tables.

install.packages("sqldf")
library(sqldf)

# We will use the Data Orange to feature SQL coding.

data(Orange)
Orange

# in SQL, we don't say observational rows; we say records

# SQL coding to produce the data Table

sqldf("SELECT * FROM Orange") # generates the entire data source

# note that we have outputted the same Data table.


# We can produce the familiar "iris" data in a similar
# way.
sqldf("SELECT * FROM iris") # generates all of the iris data source
library(tidyverse)
sqldf("SELECT * FROM iris") -> xyz
xyz

as_tibble(xyz) # this is a way to generate a tibble more cleanly compared to just generating it in the console

View(xyz) # this still works even though we're working under the SQL umbrella

## SOME STANDARD SQL COMMANTS

# Let's output 15 data elements of the variable age
# from the Orange Data table.

sqldf('SELECT age FROM Orange Limit  15') # the Limit command controls the output

# The following code features the selection of 4 Orange variables.
# We filter on one and arrange another in ascending order.

sqldf('SELECT age, circumference FROM Orange WHERE Tree = 1
      ORDER BY circumference ASC') # order by is the SQL version of arrange; you can include an indicator (ASC or DESC), otherwise it will be ascending by default

# We will also select Tree so that the elements for that 
# that variable appear.
sqldf('SELECT age,Tree, circumference FROM Orange WHERE Tree = 1
      ORDER BY circumference ASC') -> xy
xy
View(xy)




# Let's now obtain a statistical summary value for one of
# the variables.
sqldf("SELECT AVG(circumference) FROM Orange") # circumference is numerical, so we can get the average circumference from the Orange dataset

# Let's now obtain a statistical summary value for one of
# the variables subject to categories (levels) of 
# another variable.

sqldf("SELECT tree, AVG(circumference) AS meancirc
      FROM Orange GROUP BY tree") # we are getting the average circumference for each category of tree; GROUP BY is the important SQL command here; AS creates a new column the way mutate() would

# examples from other data sources

data(BOD)
BOD

bod2 <- sqldf('SELECT * FROM BOD')
bod2

sqldf('SELECT demand FROM BOD')

sqldf('SELECT demand,Time FROM BOD WHERE Time < 3') # WHERE works like the filter() function; the SELECT command allows you to subset a variable from a data source

# when using SQL, be careful of syntax

iris1 <- sqldf('SELECT Petal.Width FROM iris') # will not work because the column name must be within double quotes ("Petal.Width")

iris2 <- sqldf('SELECT "Petal.Width" FROM iris') # will work because "Petal.Width" is in double quotes, not single quotes
iris2

sqldf('SELECT * FROM BOD WHERE Time IN (1,7)') # IN is another way to subset; selects observational rows/records 1 and 7

sqldf('SELECT * FROM BOD WHERE Time NOT IN (1,7)') # performs the opposite; selects every record but 1 and 7

# let's look at another data source

library(tidyverse)
data (rock)
rock -> rockdata
# Let's produce a tibble data table
as_tibble(rockdata)

#sqldf('SELECT * FROM rock WHERE (peri > 5000 AND
      #shape < .5') 

data ("chickwts")
chickwts
# The operator % (percent sign) can be used to extract
# elements that have particular begining or ending

sqldf('SELECT * FROM chickwts WHERE feed LIKE "%meal"
      LIMIT 5') # extracts elements that end in meal from the data table; only looking at 5 records

sqldf('SELECT * FROM chickwts WHERE feed LIKE "soy%"
      LIMIT 5')  # extract elements that begin with soy from the data table; only looking at 5 records

# Created for DATA 413/613
# Created on 03/29/2024
# Affiliation: American University
# Author: Johnson Odejide
# Supervised by: Prof. Dickens

# install the sqldf package if not already installed
if(!require(sqldf))
  install.packages("sqldf")

# Load the library
library(sqldf)

# if(!require(RSQLite))
#   install.packages("RSQLite")
#
# library(RSQLite)

# Using diamonds data

# read in the diamonds data from the ggplot package
diamonds <- ggplot2::diamonds
diamonds




# Get the first five (5) records in the data
# It is advisable to use the LIMIT clause when reading your data, especially when working with big data where you have millions of records for instance.

sqldf('SELECT * FROM diamonds LIMIT 5')
# The symbol * means "all columns" in SQL SELECT statement
# diamonds is the table as it being referred to in SQL.
# Hence, we can interpret the statement above like this - Select all the columns from the diamonds data and output just the first 5 rows
# unlike dplyr, in SQL you output all of the variables

# Let's change the 5 to 7 to observe the changes
sqldf('SELECT * FROM diamonds LIMIT 12')

# What did you notice?

# We now have twelve (12) records

# Now let's run it without the LIMIT clause
sqldf('SELECT * FROM diamonds')

# Did you notice that you now have more records shown?

# Now let's select specific columns and output the first 20 records
# In this case, we select the carat, cut, color, depth, and price columns
sqldf('SELECT carat, cut, color, depth, price
      FROM diamonds
      LIMIT 20')

# Let's get the total number of records in the data. We use COUNT to do this
sqldf('SELECT COUNT(*) FROM diamonds') # COUNT works like nrow()

# We have 53940 records. Notice the terminologies in SQL. It's called records, not observations.

# What categories of diamond colors do we have?
sqldf('SELECT DISTINCT color
      FROM diamonds') # colors is categorical, so we refer to the different categories as levels

# How many are they?
sqldf('SELECT COUNT(DISTINCT color)
      FROM diamonds')
# There are 7 categories of colors or 7 distinct count of colors

# Let's filter the records to show only diamonds that have a "Good" cut
sqldf('SELECT *
      FROM diamonds
      WHERE cut="Good"')

# How many are there?
sqldf('SELECT COUNT(*)
      FROM diamonds
      WHERE cut="Good"')
# There are 4906 diamonds that have a "Good" cut

# Suppose you want to select multiple cuts, you can use the IN operator
# Here we select diamonds that have either "Good" or "Very Good" cut

sqldf('SELECT *
      FROM diamonds
      WHERE cut IN ("Good", "Very Good")')

# there are multiple other methods for doing this

# How many are they?
sqldf('SELECT COUNT(*)
      FROM diamonds
      WHERE cut IN ("Good", "Very Good")')
# There are 16988 cuts that are either "Good" or "Very Good"


# Let's look at CONJUCTIVE OPERATORS in SQL
# There are two conjunctive operators in SQL they are AND and OR

# # To select multiple cuts as we did using the IN operator, we can use the conjunctive operators
# Select diamonds that have both "Good" and "Very Good" cut
sqldf('SELECT *
      FROM diamonds
      WHERE cut="Good" OR cut="Very Good"')

# Let's get the total numbers of diamonds that are either "Good" OR "Very Good"
sqldf('SELECT COUNT(*)
      FROM diamonds
      WHERE cut="Good" OR cut="Very Good"')

# Let's get the diamonds that have "Very Good" cut and a price less than $2750

sqldf('SELECT *
      FROM diamonds
      WHERE cut = "Very Good" AND price < 2750')


# Let's get the diamonds that have "Very Good" cut and a price is between 2500 and 2700

sqldf('SELECT *
      FROM diamonds
      WHERE cut = "Very Good"
      AND (price BETWEEN 2500 AND 2700)')


# ARRANGING records in SQL using ORDER BY
# Let's arrange the diamonds based on their cut
sqldf('SELECT *
      FROM diamonds
      ORDER BY cut')

# We can filter and arrange in SQL just the way we do in R.
# We filter using the WHERE clause and arrange using the ORDER BY clause

# Let's select the top 20 diamonds that have an "Ideal" cut and arrange them by their
# prices in DESCENDING order
sqldf('SELECT *
      FROM diamonds
      WHERE cut = "Ideal"
      ORDER BY price DESC
      LIMIT 20')

# By default the arrangement is done in ASCENDING order. However, we can
# explicitly arrange in an ascending order as below
sqldf('SELECT *
      FROM diamonds
      WHERE cut = "Ideal"
      ORDER BY price ASC
      LIMIT 20')



# CLASS PRACTICE EXERCISE

# Select the diamonds that have prices less than $2000
# How many are they?
sqldf('SELECT *
      FROM diamonds
      WHERE price < 2000')

sqldf('SELECT COUNT(*)
      FROM diamonds
      WHERE price < 2000')

# there are 24,203 records with a price less than $2000

# Get the diamonds that have either Premium or Ideal cut and have a clarity of SI2
# How many are they?

sqldf('SELECT *
      FROM diamonds
      WHERE (cut = "Ideal" OR cut = "Premium")
      AND (clarity = "SI2")')

sqldf('SELECT COUNT(*)
      FROM diamonds
      WHERE (cut = "Ideal" OR cut = "Premium")
      AND (clarity = "SI2")')

# there are 5547 records with a premium or ideal cut and a clarity of SI2

# What are the categories of clarity in the data?
# How many are they?

sqldf('SELECT DISTINCT clarity
      FROM diamonds')

sqldf('SELECT COUNT(DISTINCT clarity)
      FROM diamonds')

# there are 8 categories of clarity: SI2, SI1, VS1, VS2, VVS2, VVS1, I1, and IF

