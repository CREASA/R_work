# R_work
## A1
We are dedicated to understanding the distribution of attendees at protests：
- The highest, lowest, average, and median attendee counts are calculated.
- The difference between the mean and median is also analyzed, indicating the skewness of the data.
- Two boxplots are drawn to visualize the distribution of attendee counts and its logarithm.
- An exploration of where protests occurred is carried out.
- Unique locations and the number of protests in Washington state are determined.
- A function to count protests in any given location is defined and applied to various locations.
- The dataset's locations are analyzed to identify the unique states and count protests for each state.
- This section delves into when the protests occurred.
- The range of dates in the dataset is determined, and the number of protests in 2019 and 2020 is compared.
- A function to describe protests on a given date is defined. The increase in the number of protests from July 2019 to July 2020 is calculated. 
- The reasons for the protests are explored. The dataset reveals multiple unique purposes.
- A new variable is created to capture the high-level purpose by extracting the text before any parentheses in the purpose description.
- A frequency count table for these high-level purposes is generated.


## A2

We delved into a comprehensive exploration and analysis of the COVID-19 data from NYTimes: 
Initially, I loaded data at the national, state, and county levels and conducted preliminary inspections, such as determining the dimensions of the data and identifying feature names. Following that, I used dplyr functions for a detailed exploration, calculating metrics like the number of cases and deaths in the U.S. on the most recent date, the states with the highest and lowest case counts, and the counties with the most cases and deaths. Additionally, I combined the names of counties and states into a county_state column to more accurately identify geographical locations. Subsequently, I identified a key insight: the daily new cases and new deaths. I visualized these metrics with plots to observe the trend of the pandemic over time. Further, I employed the group_by() function for grouped analysis, summarizing the highest and lowest case counts for each state and calculating the proportion of counties with no deaths within each state. Towards the end of the code, I identified some discrepancies between state-level data and the data derived from summing county-level data, prompting further validation and comparison. Lastly, I posed my own inquiries about the data and made corresponding calculations, such as comparing the death toll from COVID-19 to U.S. deaths during World War II. 


## A3
In this analysis, we explored incarceration trends in the U.S. using data from the Vera Institute. After loading the dataset, we began by determining its size, the range of years it covers, and the incarcerated population for 2018. A series of data wrangling steps followed, focusing on calculating incarcerated populations by race and gender, and on identifying states with the highest black incarceration rates. The visualizations play a crucial role in this analysis:

- Incarceration Trends Over Time: This plot illustrates the changes in incarcerated populations over the years, broken down by race. It provides insights into how different racial groups have been affected by the criminal justice system over time.
- States with Highest Rate of Black Incarceration: By focusing on the states with the highest black incarceration rates, this bar chart paints a vivid picture of racial disparities in the justice system.
- Racial Incarceration Discrepancy Map: Using a geographical map of Washington State, I highlighted the ratio of black to white incarceration rates by county, which is instrumental in identifying regional disparities.
- Incarceration Trends Over Time For Male and Female: My custom visualization presents incarceration trends segmented by gender, offering a comparative view of how incarceration has impacted men and women differently over the years.


## A4
In the analysis, I explore CO2 emissions data using a dataset from OWID (Our World in Data). After loading the dataset, I curate a subset named 'data_short' that focuses specifically on the United States. This subset contains information on the country's year, CO2 emissions, GDP, and CO2 emissions per GDP.




## Final Work
- Does a taller player perform better? (Number of MVP's or Shoot's)  
When thinking about basketball, the first thing I think about is the relationship between the height of basketball players and their performance. After all, the taller people are more likely to dunk or to some extent prevent others from dunking, because they are more likely to hit the basket.  
- What is the average age range of NBA players？  
We rarely see older players in the NBA games because their physical fitness declines as they get older ,but we wonder what is the best age range for a player to play in NBA?  
- Which player is the best defender in the position of Center for preventing opponents getting points?  
Since Center is the position which affects the team's Defense most, it is pretty interesting to find out the best defender. Based on the data sets we found, we will first find all the Centers in the NBA and compare their rebounds, blocks, steals and the means of losing points when they are on the floor.  
- For teams who win the championship, is Defense more important or offense more important?  
Winning the championship is the goal for every player in the union, so the question that defense or offense is the more essential factor of victory has a lot of interest. We are likely to compare the ORTG and DRTG of every 2 teams in the Finals for nearly 10 seasons in order to answer the question above.  
- Do people who have longer career experiences play better than people with less experience.  
It is often assumed that more experienced people will play better than newer NBA players. Therefore, we want to use our data set to compare their starting years and their winning percentages to determine if this statement is correct.






