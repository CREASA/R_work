###############################################################################
### Assignment 1: Protests ###
### Analysis of protest data from CountLove.org (https://countlove.org/)
### Below each prompt in the file, write the code necessary/indicated to calculate 
### the answer. Results should be calculate directly from the data. 
### Each result should be stored in a variable with a name indicated in `backtics` 
### (to help us with grading). 
### It's also a good idea to "print" the result so you can see the answers--don't 
### just look at RStudio's environmental variables.



###############################################################################
##### PART 1: Setup #####
### In this section you will load the data and necessary packages

# Load the `stringr` package for use later (all package loading goes at the top)
# Do not include any `install.package()` calls
library(stringr)


# Use the `read.csv()` function to store the data from
#   https://countlove.org/data/data.csv 
# in a data frame variable called `protests_df`
protests_df <- read.csv("https://countlove.org/data/data.csv",stringsAsFactors = FALSE)
 

# Define a variable `num_protests` that contains how many protests are in the 
# data set
num_protests <- nrow(protests_df)
print(num_protests)

# Define a variable `feature_names` that contains the names (a vector of strings)
# of the features in the data set
feature_names<-colnames(protests_df)





###############################################################################
##### PART 2: Attendees #####
### In this section you will explore the number of attendees at protests

# For clarity, extract the `Attendees` feature from the `protests_df` data frame
# into a variable called `attendee_counts`. Use dollar notation.
attendee_counts <- protests_df$Attendees
print(attendee_counts)

# What is the highest number of attendees? Save result in `max_attendee_count`
# (hint for this and other calculations: you'll need to _remove_ `NA` values)
max_attendee_count <- max(attendee_counts,na.rm=TRUE)
print(max_attendee_count)

# What is was the lowest number of attendees? Save result in `min_attendee_count`
min_attendee_count <- min(attendee_counts,na.rm=TRUE)
print(min_attendee_count)

# What is the average (mean) number of attendees? Save result in `mean_attendee_count`
mean_attendee_count <- mean(attendee_counts,na.rm=TRUE)
print(mean_attendee_count)

# What is the median number of attendees? Save result in `median_attendee_count`
median_attendee_count <- median(attendee_counts,na.rm=TRUE)
print(median_attendee_count)

# How far apart are the the mean and median number of attendees? Calculate the
# absolute value of the difference and store in a variable `mean_median_diff`
mean_median_diff <- abs(mean_attendee_count-median_attendee_count)
print(mean_median_diff)

# Reflection #1: What does the difference between the mean and the median counts
# tell you about the *distribution* of the data? You'll want to consider the
# individual numbers as well (which is higher)?
# Feel free to ask for clarification if you're unfamiliar with working with
# distributions.



# To help visualization this distribution, use the `boxplot()` function to plot
# the counts of attendees in a chart. Assign this plot to a variable named
# `attendee_count_boxplot` 
# (We'll use more refined plotting methods with more attention to detail later)
attendee_count_boxplot <- boxplot(attendee_counts)

# Create a second boxplot of the `log()` (natural logarithm) of the attendee counts.
# You will see a warning in the console, which is expected.
# Store this plot in a variable named `log_attendee_count_boxplot`
log_attendee_count_boxplot <- boxplot(log(attendee_counts))


###############################################################################
##### PART 3: Locations #####
### In this section you will explore where protests occurred

# How many *unique* locations are in the data set? Store the result in `locations_count`
# You will need to access the appropriate column from the `protests_df` data frame
locations_count <- length(unique(protests_df$Location))
print(locations_count)

# How many protests occurred in Washington state? Use a function from the `stringr` 
# package to *detect* locations with the letters "WA" Store the result in 
# `wa_protests_count`.
location_whole <- protests_df$Location
print(location_whole)
is.vector(location_whole)
location_wa <- str_detect(location_whole, "WA")
wa_protests_count <- sum(location_wa)
print(wa_protests_count)

# What percentage of all protests occurred in Washington State? Store the result
# in `wa_protest_percentage`
wa_protest_percentage <- (wa_protests_count/num_protests) * 100
print(wa_protest_percentage)

# Reflection #2: Does the number of protests in Washington surprise you? 
# Why or why not?




# Define a function called `count_in_location()`. This function will expect 2 arguments:
#   1) a `location_name` string (e.g., "Seattle, Washington"), and 
#   2) a `locations_vector` of location names (like the `protests_df` column)
# The function will *return* the number of times the `location_name` occurs in the
# `locations_vector`. Note that you should count partial matches, so "Seattle" 
# will be a match for "Seattle, WA". Hint: use the same technique as you did above!
# Your function must NOT reference `protests_df` directly; only use the argument
# (functions should be "stand alone" and not reference non-argument variables)
count_in_location <- function(location_name, locations_vector) { 
  ret <- sum(str_count(locations_vector, location_name))
  return (ret)
 }

# Use your function to count the number of protests in "Washington, DC". Store the
# result in `dc_count`
# See how clean having a separate function is?
dc_count <- count_in_location("Washington, DC", protests_df$Location)
print(dc_count)


# Use your function to describe the number of protests in "Minneapolis", with format:
#    "There were N protests in Minneapolis." 
# (where N is the number of protests) Note spacing and punctuation!
# Save the result as `minneapolis_summary`
minneapolis_summary <- paste("There were ",count_in_location("Minneapolis, MN", protests_df$Location
)," protests in Minneapolis.",sep = "")
print(minneapolis_summary)

# Define a variable `all_states` that is a vector of strings, which are the 
# last two characters of the values in the `Location` column.
# Hint: look for another helpful function in the `stringr` package.
all_states <- str_sub(protests_df$Location, start=-2)
print(all_states)


# Define a variable `unique_states` that are the unique state abbreviations in
# the dataset.
unique_states <- unique(all_states)
print(unique_states)


# Define a variable `state_counts` that is a tagged (named) vector of counts for
# each state. Do this by using the `sapply()` function, passing your `unique_states`
# variable, your `count_in_location` function, and the `Location` vector as arguments
#
# Note how amazing this is! sapply() let you call your function on entire vector at once!
# Optional: use the View() function to more easily read the vector
state_counts<-sapply(unique_states, count_in_location, protests_df$Location)
View(state_counts)

# You can create a tabular representation of this data by using the `table()`
# function, passing in the `all_states` variable. Save the result in `state_table`
# Optional: use the View() function to more easily read the table
state_table<-table(all_states)
View(state_table)

# Reflection #3: Looking at your state counts, what data quality issues do you 
# notice? What would you have to do to "fix" these issues (you do not need to
# actually make any changes!)


# What was the maximum number of protests in a single state? Save your result
# in `max_state_count`
max_state_count<-max(state_table)
print(max_state_count)

###############################################################################
##### PART 4: Dates #####
### In this section you will explore *when* protests occurred

# Define a variable `protest_dates` that is the values of the `Date` column of 
# the `protests_df` data frame, but as `Date`-types (not strings!). You can convert
# the strings into `Date` values using the `as.Date()` function (luckily, the strings
# are formatted for easy conversion).
# - Note that you can check the "type" of a variable by using the `class()` function. 
#   For example `class(protest_dates)` should produce `"Date"`.
class(protests_df$Date)
protest_dates<-as.Date(protests_df$Date)
class(protest_dates)

# What is the most recent date in the dataset? Save this value as `most_recent_date`
# Hint: the `max()` function works just fine with Date types!
most_recent_date<-max(protest_dates)
print(most_recent_date)


# What is the earliest date in the dataset? Save this value as `earliest_date`
earliest_date<-min(protest_dates)
print(earliest_date)

# What is the length of the time span of the dataset? That is, how much time
# is there between the earliest and latest protest? Save this value as `time_span`
# Hint: If you subtract `Date` types, you'll get a `difftime` ("time difference") type;
# this value will appear blank in RStudio's Environment variables list, but you can
# print it out to see it's value.
time_span<-most_recent_date-earliest_date
print(time_span)


# Define a vector `dates_in_2020` containing protest dates that are in 2020.
# Use vector filtering. Hint: filter for dates that are after Jan 1
dates_in_2020<-protest_dates[protest_dates>="2020-01-01"]
print(dates_in_2020)

# Define a vector `dates_in_2019` containing protest dates that are in 2019.
# Use vector filtering. Hint: you can use the & operator to have multiple 
# filter conditions!
dates_in_2019<-protest_dates[protest_dates>="2019-01-01"&protest_dates<="2019-12-31"]
print(dates_in_2019)


# By what ratio did the number of protests in 2020 change from the number in 2019?
# Save the result in `ratio_dates_2020_to_2019`
ratio_dates_2020_to_2019<-(length(dates_in_2020)/length(dates_in_2019))
print(ratio_dates_2020_to_2019)


# Reflection #4: Does the change in the number of protests from 2019 to 2020
# surprise you? Why or why not?




# Define a function called `describe_protests_on_date()`. This function will
# expect 2 arguments:
#   1) a date in time (as a `Date` type), and
#   2) a vector of Date values (like your `protest_dates` vector)
# The function will return a string with the format:
#   "There were N protests on DATE."
# where N is the number of protests, and DATE is the date provided.
# Your function must NOT reference your `protest_dates` variarble directly
describe_protests_on_date <- function(date_in_time, date_vector){
  result <- sum(str_detect(date_vector,date_in_time) )
  result_in_string <- paste ("There are ", result, " protests in ", date_in_time, ".",sep="")
  print(result_in_string)
}


# Using your function, how many protests were there on May 24th, 2020? Save 
# your result as `num_protests_may_24`
num_protests_may_24<-describe_protests_on_date("2020-05-24", protest_dates)

# Using your function, how many protests were there on May 31th, 2020 (1 week 
# later)? Save your result as `num_protests_may_31`
# For more on this timeline, see: 
# https://www.nytimes.com/article/george-floyd-protests-timeline.html
num_protests_may_31<-describe_protests_on_date("2020-05-31", protest_dates)

# How many protests occurred during each month of 2020? Save your result as
# `protest_counts_by_month`
# Hint: You can use the `months()` function to extract the "month" from each
# date in your `protests_dates`. Then you can use the `table()` function to
# count those occurrences.
protest_months<-months(dates_in_2020)
protest_counts_by_month<-table(protest_months)
View(protest_counts_by_month)



# As an example, calculate the *difference* in the number of protests between
# July 2020 and July 2019. Store your result in `change_july_count`
# You will probably want to do this in multiple steps (making intermediate
# variables as necessary).
protest_months_2019<-months(dates_in_2019)
protest_counts_by_month_2019<-table(protest_months_2019)
jul2019<-protest_counts_by_month_2019[protest_months_2019="July"]
jul2020<-protest_counts_by_month[protest_months="July"]
change_july_count<-jul2020-jul2019
print(change_july_count)


# Reflection #5: For this reflection, do some outside research. Find at least 
# *two (2) specific policies* that have been changed as a result of protests 
# in 2020. These may be at the city, state, or University level. Provide a basic
# summary of the policy change, as well as a link to your source.



###############################################################################
##### PART 5: Protest Purposes #####
### In this section you will explore *why* protests occurred

# For convenience, extract the `Event..legacy..see.tags.` column from your
# `protests_df` data frame into a variable called `purposes`
purposes<-protests_df$Event..legacy..see.tags.
View(purposes)


# How many different (unique) purposes are included in the dataset? Save your
# result as `purposes_count`
purposes_count<-length(unique(purposes))
print(purposes_count)

# That's quite a few.
# If you `View()` the `purposes` vector, you can notice that many purposes are
# listed with a common format:
#    SOME_PURPOSE (ADDITIONAL_DETAIL)
# Create a variable `high_level_purposes` that is a vector of all of the purpose
# text *before the first parenthesis* (not including spaces). For example, from 
#    "Civil Rights (Black Women's March)"
# You would extract
#    "Civil Rights"
# There are lots of approaches to doing this; try looking at the course text,
# exercises, and `stringr` library for some potentially useful functions.
# One suggestion: try removing (replacing) everything within the parentheses
# This may take a bit of trial and error and searching. Be patient with yourself!
temp<-gsub("\\s*\\([^\\)]+\\)","",as.character(purposes))
high_level_purposes<-gsub("\\s\\(\\)","",temp)
print(high_level_purposes)

# How many unique "high level" purposes did you identified? Store your result
# in a variable `high_level_purpose_count`
high_level_purpose_count<-length(unique(high_level_purposes))
print(high_level_purpose_count)


# Create a frequency count table that counts number of protests for each high 
# level purpose. Save this table as `high_level_purpose_table`
high_level_purpose_table<-table(high_level_purposes)
View(high_level_purpose_table)


# Reflection #6: Inspect (e.g., `View()`) the `high_level_purpose_table` What 
# does this tell you about the current climate in the U.S.?

