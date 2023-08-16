# Analysis for **NBA** Players

## INFO 201 Group H1

- Hongliang Gao
- Xucheng Zhang
- Michelle Guan
- Qitong Liang
- Xinyu Chang

## Section 1
## Problem Domain
The problem domain that our group wants to focus on is the NBA. NBA, The National Basketball Association is a professional basketball league in North America. Apparently basketball is one of the hottest sports in the world nowadays, which attracts Young middle aged old. Some may consider winning a basketball game only depends on the physical performance of players on the floor; however, data hidden under the floor is another essential key for the team to win not only a single game but the champion in the season. Based on data analysis, teams are likely to find the most powerful players on every different zone on the court inside the gym and the most suitable player for the team to assign contracts during free market outside the gym. This is the beauty of basketball combined with data analysis! Referring to the reason why our group project targets on such a domain, since most of the members in the groups are big fans of NBA games with different host teams and favorite players, we are looking forward to finding out the most dominant players in different areas and the most possible team for winning the championship in this season with the aid of data analysis in R studio. We are going to collect the data of players and matches, then we are able to rate on the performance of the players or the teams by analysing the data. Moreover, comparing the match data between two teams can help us to find out what the most important factors are to win a game. 

More Information about NBA: The league is composed of 30 teams, including 29 domestic teams in the United States and 1 team in Canada. The league was founded in New York City on June 6th, 1946, with the original name of BAA(Basketball Association of America). On August 3rd, 1949, BAA changed its name to NBA after merging with the competing National Basketball League (NBL). Nowadays, the NBA has become the most popular sports league in the United States, sharing the equal popularity with the NFL and the MLB. The NBA's regular season runs from October to April, with each team playing 82 games and the top 8 teams of northern and western parts will enroll in a playoff tournament to compete for the final championship. The playoff tournament extends into June. However, the 2019–20 NBA season was the special case. It began on October 22, 2019, and originally was supposed to end on April 15th, 2020. Due to the COVOID-19 pandemic, the season had to be  suspended on March 11th.

Cited from:
- [NBA History](https://nbahoopsonline.com/History/#:~:text=The%20NBA%20began%20life%20as,start%20of%20the%20next%20season)

- [National Basketball Association](https://en.wikipedia.org/wiki/National_Basketball_Association)

## Domain Knowledge
- OT : Overtime		
- H_A: Home team or away team	(team or opponent)		
- Pace: Pace Factor, the number of possessions a team uses per game
- Efg_pct: Effective Field Goal Percentage		
- Tov_pct: Turnover Percentage 		
- Pts: Points
- Rebound: awarded to a player who retrieves the ball after a missed field goal or free throw. 	
- Orb_pct: Offensive Rebounds percentage
- Drb: Defensive Rebounds
- Trb: Total Rebounds
- Ast: Assists (A pass to a teammate who scores a basket immediately or after one dribble.)	Ft: Free Throws (An unopposed attempt to score a basket, worth one point, from the free-throw line. )		
- Fta: Free Throw Attempts
- Stl: Steals (To gain possession of the ball from the opposing team by intercepting a pass, knocking the ball off a dribble, or slapping it legally out of an opponent’s hands)		
- Blk: blocks (To tip or deflect a shooter's shot, altering its flight so that the shot misses.)
- Pf: Personal Fouls
- Foul: A violation of the rules other than a floor violation, generally one which attempts to gain advantage by physical contact. Such violations are penalized by a change in possession or the awarding of free-throw opportunities.			
- Ft_rate: Free throw percentage			
- Def_Rtg: Defensive Rating, for players and teams it is points allowed per 100 possessions.
- Off_Rtg: Offensive Rating, points scored per 100 possessions.			
- inactives: inactive players. each team is required to carry 12 players on its active list and at least one player on its inactive list. 		
- Fg: Field Goals(includes both 2-point field goals and 3-point field goals)				
- Fg3: 3-point field goals			
- Fga: Field Goal Attempts
- Plus_Minus: the plus/minus statistic is a measure of the point differential when players are in and out of a game.
- BPM : basketball box score-based metric, estimates a basketball player’s contribution to the team when that player is on the court.		
- Tsp_pct: True shooting percentage,  is a measure of shooting efficiency that takes into account field goals, 3-point field goals, and free throws.					
- Usg_pct: Usage Percentage, an estimate of the percentage of team plays used by a player while he was on the floor.
Double_double: a single-game performance in which a player accumulates ten or more in two of the following five statistical categories: points, rebounds, assists, steals, and blocked shots.
- Trible_double: a single-game performance by a player who accumulates a double-digit number total in three of five statistical categories
- PG: point guard
- SG: shooting guard
- C: center
- SF: Small forward.

Cited From:
- [Basketball Reference](https://www.basketball-reference.com/about/glossary.html)
- [Glossary of basketball terms](https://en.wikipedia.org/wiki/Glossary_of_basketball_terms)


## Existing Projects
- [Extracting and Analyzing 1000 Basketball Games using Pandas and Chartify](https://www.analyticsvidhya.com/blog/2019/05/scraping-nba-data-analyze-1000-basketball-games-python/)

- [How to Get Data on Every NBA Player Using R](https://towardsdatascience.com/how-to-get-data-on-every-nba-player-using-r-62abcacd65e1)


## Section 2. Analysis Questions
## Analysis Questions
1. Does a taller player perform better? (Number of MVP's or Shoot's)
  - When thinking about basketball, the first thing I think about is the relationship between the height of basketball players and their performance. After all, the taller people are more likely to dunk or to some extent prevent others from dunking, because they are more likely to hit the basket.
2. What is the average age range of NBA players？
  - We rarely see older players in the NBA games because their physical fitness declines as they get older ,but we wonder what is the best age range for a player to play  in NBA?
3. Which player is the best defender in the position of Center for preventing opponents getting points?
  - Since Center is the position which affects the team's Defense most, it is pretty interesting to find out the best defender. Based on the data sets we found, we will first find all the Centers in the NBA and compare their rebounds, blocks, steals and the means of losing points when they are on the floor.
4. For teams who win the championship, is Defense more important or offense more important?
  - Winning the championship is the goal for every player in the union, so the question that defense or offense is the more essential factor of victory  has a lot of interest. We are likely to compare the ORTG and DRTG of every 2 teams in the Finals for nearly 10 seasons in order to answer the question above.
5. Do people who have longer career experiences play better than people with less experience.
  - It is often assumed that more experienced people will play better than newer NBA players. Therefore, we want to use our data set to compare their starting years and their winning percentages to determine if this statement is correct.

## Section 3. The Data Sets
- ASA All NBA Raw Data
<br>This data set includes all the NBA games in Regular seasons and Playoff seasons: scores of each 2 teams, detailed data statistics of every player in the game. We download the data from the official NBA websites of Data Analysis, and the link is [NBA RAW DATA](https://www.advancedsportsanalytics.com/nba-raw-data). Data comes from the official staff of NBA union who records the data of every game and stores them into this data set, and the computer also makes the data more logical and reliable with specific analysis. Actually most of the questions we post are likely to be answered by this data set since it includes tons of valuable data for us to analyze.

- NBA Players stats since 1950
<br>The data-set contains aggregate individual statistics for 67 NBA seasons, from basic box-score attributes such as points, assists, rebounds etc., to more advanced money-ball like features such as Value Over Replacement. We downloaded from Kaggle, and the url is [NBA Players stats since 1950](https://www.kaggle.com/drgilermo/nba-players-stats?select=Players.csv)
The data is collected by Omri Goldstein, who is a Data Scientist at Walkme. He scraped the raw data from Basketball-reference and banded them together by himself.The data includes all of the basic information of players, including the physical data and their educational background, such as their graduated university. With these data, we are able to analysis tasks such as the relationships between players’ quality and their universities and relationships between players’ physical data and their scoring efficiency.
