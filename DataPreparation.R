#1. a case study: create the leadership data frame
manager <- c(1,2,3,4,5)
date <-c("10/24/08","10/28/08","10/1/08","5/1/09","5/1/09")
country <-c("US","US","UK","UK","UK")
gender <-c("M","F","F","M","F")
age <-c(32,45,25,39,99)
q1 <-c(5,3,3,3,2)
q2 <-c(4,5,5,3,2)
q3 <-c(5,2,5,4,1)
q4<-c(5,5,5,NA,2)
q5<-c(5,5,2,NA,1)
leadership <-data.frame(manager, date, country, gender, age, q1, q2, q3,q4,q5,stringsAsFactors = F)

#2. creating new variables: variable <- expression
# + addition
# - subtraction
# * multiplication
# / division
# ^ or ** exponentiation
# x%%y modolus (x mod y): for example, 5%%2 is 1
# x%/%y integer division" for example, 5%/%2 is 2

#3. incorporate new variables into the original dataframe
#method 1
mydata <-data.frame(x1 = c(2,2,6,4), x2 =c(3,4,2,8))
mydata$sumx <- mydata$x1 +mydata$x2
mydata$meanx <- (mydata$x1 + mydata$x2)/2
#method 2
attach(mydata)
mydata$sumx <- x1+x2
mydata$meanx <- (x1+x2)/2
detach(mydata)
#method 3
mydata <-transform(mydata, sumx = x1+x2, meanx=(x1+x2)/2)


#4. recoding variables
#change a continuous variable into a set of categories
#replace miscoded values with correct values
#create a pass/fail variable based on a set of cutoff scores

#logical operators to use
# <, <=, >, >=, !=, ==
# !x : not x
# x|y x or y
# x&y x and y
# isTRUE(x): test whether x is TRUE

#if we want to recode the ages of the managers in the leadership dataset from the continuous variable age to the categorical variable agecat(Young, Middle Aged, Elder)
#first, recode the value 99 for age to indicate that the value is missing 
manager <- c(1,2,3,4,5)
date <-c("10/24/08","10/28/08","10/1/08","5/1/09","5/1/09")
country <-c("US","US","UK","UK","UK")
gender <-c("M","F","F","M","F")
age <-c(32,45,25,39,99)
q1 <-c(5,3,3,3,2)
q2 <-c(4,5,5,3,2)
q3 <-c(5,2,5,4,1)
q4<-c(5,5,5,NA,2)
q5<-c(5,5,2,NA,1)
leadership <-data.frame(manager, date, country, gender, age, q1, q2, q3,q4,q5,stringsAsFactors = F)

leadership$age[leadership$age == 99] <-NA #variable[condition] <- expression, conly make the assignment when the condition is true
#second, create agecat variable
leadership$agecat[leadership$age >75] <-  "Elder"
leadership$agecat[leadership$age >=55 & leadership$age <=75] <- "Middle Aged"
leadership$agecat[leadership$age <55] <- "Young"

#we also can code it more compactly by within() function
#within() function is similar to the with() function but it allows to modify the data frame
leadership <- within(leadership, {
  agecat <-NA # create variable agecat and set to missing for each row of the data frame
  agecat[age >75] <-"Elder"
  agecat[age >= 55 & age <=75]<="Middle Aged"
  agecat[age<55]<="Young"})

# car package's recode() recodes numeric and character vectors and factors very simply
# doBy package offers recodeVar()
# cut() function can divide the range of a numeric variable into intervals, returning a factor 

#5. renaming variables
#method1 : invoke an interactive editor
fix(leadership)
#method2 : via the names() function
names(leadership)[2] <- "testDate"

#a similar fashion for more changes
names(leadership)[6:10] <-c("item1", "item2","item3", "item4", "item5") #renames q1 through 95 to item1 through item5

#plyr package has a rename() function that is useful for altering the names of variables.
rename(dataframe, c(oldname="newname", oldname="newname",...))

install.packages("plyr")
library(plyr)
leadership <-rename(leadership, c(managerID="managerID", testdate="testdate"))


#6. missing values
#missing value has the same symbod whatever for character or numeric data

#is.na() allows to test missing values
y<-c(1,2,3,NA)
is.na(y)

is.na(leadership[,6:10])

# for positive and negative infinity, symbols are Inf and -Inf, 5/0, for example, returns Inf
# for impossible values, for example, sin(Inf) are represented by the symbol NaN
# check them by is.infinite() or is.nan()

#7. recoding values to missing
leadership$age[leadership$age == 99] <- NA

#8. excluding missing values from analyses
x<- c(1,2,NA,3)
y <-x[1] +x[3] +x[4]
y
z <-sum(x)
#both y and z will be NA since the third element of x is missing
# remove missing values by na.rm=T
y <-sum(x, na.rm=T)

#remove any observation with missing data by using the na.omit(), suggest using it when there are not plenty of missing values or observations
newdata <- na.omit(leadership)
newdata

#if missing values are spread throughout the data or there is a great deal of missing data in a small number of variables, we need more sophisticated methods of dealing

#9 translating to date variables
as.Date(x, "input_format")

mydates <-c("01/05/1965","08/16/1975")
dates <- as.Date(mydates, "%m/%d/%Y") #read the data using a mm/dd/yyyy format

#other useful time-stamping functions
Sys.Date() #today's Date
date() #current date and time

#using format(x, format="output_format") to output dates in a specified format and to extract portions of dates
today <- Sys.Date()
format(today, format = "%B %d %Y")
format(today, format="%A")

#time difference 
startdate <- as.Date("2004-02-13")
enddate <- as.Date("2011-01-22")
days <-enddate - startdate
days
#difftime() function also can be used to compute time difference
difftime(startdate, enddate, units="weeks")

#10. convert date variables to character variables
#the conversion allows to apply a range of character functions to the data values(subsetting, replacement, concatenation and so on)
strDates <- as.character(dates)
strDates

#help(as.Date)
#help(ISOdatetime)
#lubridate package contains a number of functions that simplify working with dates, including functions to identify and parse date-time data, extract date-time components and perform arithmetic calculations on date-times
#more complex time date computing, timeDate package also helps

#11. Type conversions: test and convert
# test
is.numeric()
is.character()
is.vector()
is.matrix()
is.data.frame()
is.factor()
is.logical()
#as.numeric()
#as.character()
#as.vector()
#as.matrix()
#as.data.frame()
#as.factor()
#as.logical()
#functions of the form is.datatype() return TRUE OR FALSE, whereas as.datatype() converts the argument to that type

#12. sorting data by oreder() function, default the sorting order is ascending, prepend the sorting variable with a mnus sign to descend order
newdata <- leadership[order(leadership$age),]

attach(leadership)
newdata <-leadership[order(gender, -age),] #sorts by gender and then from oldest to youngest manager within each gender
detach(leadership)

#13.merging datasets
#adding columns to a data frame
total <-merge(dataframeA, dataframeB, by=c("ID","Country") #merge dataframe A and B by ID
#when joining two matrices or data frames horizontally and dont need to specify a common key, we can use the cbind() function
total <-cbind(A,B) #each object must have the same number of rows and be sorted in the same order

#adding rows to a data frame
#using the rbind() function
total <-rbind(dataframeA, dataframeB) #two data frames must have the same variables but dont have to be in the same order
# if dataframeA has variables that dataframeB doesnt, before joining them, do one of the following:
#a. delete the extra variables in dataframeA b. create the additional variables in dataframeB and set them  to NA(misssing values)
#vertical concatenation is typically used to add observations to a data frame

#14. subsetting dataset
#selecting(keeping) variables
newdata <- leadership[,6:10]
myvars <-c("item1","item2")
newdata <-leadership[myvars]
#we also can use paste() function to create the same
myvars <- paste("item", 1:5, sep="") #item1, item2, item3, item4, item5
newdata <-leadership[myvars]

#excluding(dropping) variables
#method 1:
myvars <-names(leadership) %in% c("q3","q4") #returns a logical vector with TRUE for each element in names(leadership) that matches q3 or q4 and and FALSE otherwise
newdata <-leadership[!myvars] #selects colums with TRUE logical values, so q3 and q4 are excluded
#method 2:
#knowing that q3 and q4 are 8th and 9th, we can exclud them by
newdata <- leadership[c(-8,-9)]
#method 3:
leadership$q2 <- leadership$q2 <- NULL #null is not same to NA missing, it is deleted

#15. selecting observations(rows)
newdata <- leadership[1:3,]
newdata <-leadership[leadership$gender=="M"& leadership$age >30,]
attach(leadership)
newdata <-leadership[gender=="M" &age>30,]
detach(leadership)

#date
leadership$testdate <- as.Date(leadership$testdate, "%m/%d/%y")
startdate <-as.Date("2009-01-01")
enddate <-as.Date("2009-10-31")
newdate <- leadership[leadership$testdate >= startdate & leadership$testdate <=enddate,]
newdate1 <- leadership[which(leadership$testdate >= startdate & leadership$testdate <=enddate),]

#16. subset() function: easiest way to select variables and observations
newdata <-subset(leadership, age >=35|age<24, select=c(q1,q2,q3,q4))
newdata <-subset(leadership, gender=="M"&age >25, select=gender:item4)

#17. using SQL statements to manipulate data frames
# using the sqldf package
#http://code.google.com/p/sqldf/
install.packages("sqldf")
library(sqldf)
newdf <- sqldf("select * from mtcars where carb=1 order by mpg", row.names=T)
newdf
sqldf("select avg(mpg) as avg_mpg, avg(disp) as avg_disp, gear from mtcars where cyl in (4,6) group by gear")


