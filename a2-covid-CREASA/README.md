# Assignment 2: COVID


## Analysis Reflections
- ## Reflection #1: What does each row in each of the data sets represent? Being able to "name" observations is important for understanding data! What does each feature in the data set represent? (It's not obvious; check the documentation!) Why do the data sets have different features? ##

- The raws of the dataset of different states stands for particular dates, state names, and fips.

  The raws of the dataset of different counties contains date, state names and fips, but differently it contains county names, which is more specific than the data sets of state.

  The raws of the dataset of different nations contain date, cases and deaths, which exclude fips ,county names and state names, because it counts the total number of US instead of the regional number.

- The features of the dataset of different states contains dates(from the date of the first coronavirus case to the most recent date),different state names and fips (fips is FIPS codes, a standard geographic identifier, are assigned alphabetically by geographic name for states, counties).

  The features of the dataset of different counties contains dates(from the date of the first coronavirus case to the most recent date),different county names.

  The features of the dataset of the nation include cases and deaths (counts the total number of the coronavirus).

- The main reason is that different datasets have different purposes. National dataset is convenient for people to visually see the daily growth in a holistic prospective, while county and state data dataset can help people to distinguish which area has the most serious growth and take corresponding response in time.

- ## Reflection #2: What did you learn about the data set when you calculated the state with the lowest number of cases (and what does that tell you about testing your assumptions of a dataset?) ##
As is shown by R document, the state with the lowest number of cases is Northern Mariana Islands.It proves my thought that state with fewer population tend to have lower number of covid cases.

- ## Reflection #3: Is the location with the highest number of cases the location with the most deaths? If not, why do you believe that is so? What does this imply about whether features can "substitute" for one another in analysis? ##
No.We calculate that California has the highest number of cases, but NewYork has the highest number of deaths.There is no absolute correlation between the "cases" and "deaths". We cannot substitute features for one another in analysis. Different regions have different average medical levels and populations, hence the medical resources availability (and potentially, affordability) per capita for different regions also varies, so the highest number of cases doesn't imply the highest number of deaths.

- ##  Reflection #4: What do the plots of new cases and deaths tell you about the"waves" of the pandemic? How do the plots look different, and why do you think that is? ##

- As is shown by the graph of cases ,there is three prominent growth, and there is a significant growth observed on the third wave.

- As is shown by the graph of deaths, there is also three prominent waves, but the significant growth observed on the first and third wave (particularly the  first wave, because people are caught off-hand, no plan yet)

- The differences of significant growth happens at different waves for the two plots.At first, people are struggle to find the therapeutic regimen, so the death rate is high.However, people gradually find the therapeutic regimen.Thus, comparing with the cases rate ,the death rate is lower.

- ## Reflection #5: What do you notice about the values in `lowest_case_locations_by_state`? Consider both the names of the counties as well as how many there are. ##

There are 14 "unknowns" states observed in the 55 states (lowest case locations by state).There is supposed to have different counties, so cases with unidentifiable counties are classified as "unknown".However, the number of cases with unidentifiable counties is small, which is very likely to be output as "lowest_case_locations_by_state".


- ## Reflection #6: What surprised you the most throughout your analysis? ##

What surprises me most is that the number of deaths of covid has even surpassed the number of World War II. In addition, while LA has the highest number of cases, New York has the highest number of deaths, so we have to wonder whether New York needs more medical resources.
