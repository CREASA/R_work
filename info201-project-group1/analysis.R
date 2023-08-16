## load packages
library(dplyr)
library(ggplot2)
library(tidyverse)
library(maps)
library(mapproj)

#setup

## read csv
player_data_df = read.csv(file = "data/player_data.csv")

season_stats_df = read.csv(file = "data/Seasons_Stats.csv")

all_NBA_raw_data_df <- read.csv("data/ASA_All_NBA_Raw_Data.csv",)
#View(all_NBA_raw_data_df)
players_df <- read.csv("data/Players.csv")







# Section 2
sample_player_background_df <- player_data_df[1:10,] %>%
  select(name, year_start, year_end, college, birth_date)
#View(sample_player_background_df)

sample_player_physcial_stat_df <- player_data_df[1:10,] %>%
  select(name, height, weight, position)
#View(sample_player_physcial_stat_df)

sample_game_pace <- all_NBA_raw_data_df[1:10,] %>%
  select(game_id, Team_Abbrev, Team_pace, Team_Score, Opponent_Abbrev, Opponent_pace, Opponent_Score)
#View(sample_game_pace)

uw_graduate_NBA_player <- na.omit(player_data_df) %>%
  filter(college == "University of Washington")
uw_graduate_NBA_player <- uw_graduate_NBA_player[1:10,]





###subsection2.1
player_physcial_stat_2df <- player_data_df %>%
  select(name, height, weight)

#Find the average and maximum value of the players' weight

Player_weight_summary<- summary(player_physcial_stat_2df$ weight)
Player_weight_summary
#Convert height (feet) to centimeters
player_physcial_stat_2df$height<- player_physcial_stat_2df$height %>% 
  str_replace("-",".")

player_physcial_stat_2df <- player_physcial_stat_2df %>% 
  mutate(height_in_cm = as.numeric(height)* 30.48) %>% 
  drop_na()

#Find the average and maximum value of the players' height

Player_height_summary<-summary(player_physcial_stat_2df$ height_in_cm)
Player_height_summary


#plot the relationship between weight and height
height_weight_players_plot <- ggplot(data = player_physcial_stat_2df)+
  geom_point(mapping = aes(x = height_in_cm, y = weight), alpha = 0.5, shape=0.5) +
  scale_y_continuous(limits=c(0,400)) + 
  scale_x_continuous(limits=c(140,260))+
  labs(title="Relationship Between Height and Weight of Basketball Players", 
       x="Height (cm)",
       y= "Weight")
height_weight_players_plot


###subsection2.2
player_summary<- summary(player_data_df$weight)
player_data_df2 <- player_data_df %>% 
  drop_na() %>% 
  mutate(position2= factor(position, levels= c("G-F", "G", "F-G", "F-C", "F", "C-F", "C")))

weight_position_plot<- ggplot(data= player_data_df2)+
  geom_jitter(aes(x= weight, y= position2, color= position2))+
  scale_color_brewer(palette = "Set1")+
  labs(title = "Weights for NBA Players on Different Position(Sample)",
       color= "")

weight_position_plot

###subsection2.3
Score_summary<- summary(all_NBA_raw_data_df$Team_Score)
Pace_summary<-  summary(all_NBA_raw_data_df$Team_pace)

all_NBA_raw_data_df2<- all_NBA_raw_data_df %>%
  filter(game_date> "2021-1-1") %>% 
  select(game_id, Team_Abbrev, Team_pace, Team_Score, 
         Opponent_Abbrev, Opponent_pace, Opponent_Score) %>% 
  distinct()


score_pace_plot<- ggplot(data= all_NBA_raw_data_df2,
                         aes(x= Team_pace, y= Team_Score))+
  geom_point(color= "Orange", size= 1) + 
  geom_smooth(formula = y ~ x, color= "Red", method= loess)+
  labs(title = "Relationship between Match Pace and Match Score (2021)", 
       y= "Team Pace",
       x= "Team Score")

score_pace_plot

###Part3

###Question 1
count_state<- players_df %>% 
  count(birth_state, sort= T)

count_state<- count_state[-c(1), ]
colnames(count_state) <- c("region", "counts")
count_state$region<- tolower(count_state$region)

shape<- map_data("state")

combine_state<- left_join(shape, count_state, by= "region")
#combine_state$counts<- as.numeric(combine_state$counts)

###P3 summary
distinct_combine_state<- combine_state %>% 
  select(region, counts) %>% 
  distinct()
summary_players_states<- summary(distinct_combine_state$counts)

max_num_Players_states1<- distinct_combine_state %>% 
  filter(counts== max(counts, na.rm= T)) 
max_num_Players_states<- paste(max_num_Players_states1$region, max_num_Players_states1$counts)

top_5<- distinct_combine_state %>% 
  slice_max(order_by = counts, n = 5)

top_5_states<- paste(top_5[[1,1]], "," ,top_5[[1,2]], "; ", 
                     top_5[[2,1]], "," ,top_5[[2,2]], "; ",
                     top_5[[3,1]], "," ,top_5[[3,2]], "; ",
                     top_5[[4,1]], "," ,top_5[[4,2]], "; ",
                     top_5[[5,1]], "," ,top_5[[5,2]], sep= "")

min_num_Players_states1<- distinct_combine_state %>% 
  filter(counts== min(counts, na.rm= T))
min_num_Players_state<-paste(min_num_Players_states1$region, min_num_Players_states1$counts)

NA_value_state1<- distinct_combine_state %>% 
  replace_na(list(counts= 0)) %>% 
  filter(counts== "0")
NA_value_state<- (NA_value_state1$region)

###P3Mapping
players_states_plot<- ggplot(combine_state) +
  geom_polygon(
    mapping = aes(x = long, y = lat, group = group, fill = counts),
    color= "white",
    size = .1
  )+
  coord_map() +
  scale_fill_continuous(name= "Number NBA Players", low= "#ffffd4", high= "#d13604")+
  labs(title= "NBA Players Born Per State",
       caption = "Data for Vermont is missing(Grey area)."
  )+
  theme_void()+
  theme(plot.title = element_text(hjust = 0.5),
        plot.caption = element_text(size = 10, hjust = 1),
        legend.justification=c(0.5, 1))

states_data_bar_chart<- combine_state %>% 
  select(region, counts) %>% 
  distinct() %>%
  replace_na(list(counts=0)) %>%
  arrange(counts)
order_list1<- states_data_bar_chart$region

states_data_bar_chart<-states_data_bar_chart %>% 
  mutate(region= factor(region, levels= order_list1))

bar_chart<- ggplot(states_data_bar_chart) +
  geom_col(aes(x = region, y = counts),
           fill= "Orange")+
  coord_flip()+
  theme_classic()+
  labs(title= "NBA Players Born Per State",
       caption = "Data for Vermont is missing.")


###Question 2

#calculate player's age
birth_year = str_sub(player_data_df$birth_date, start= -4, end = -1) %>% 
  as.numeric()
player_data_age <- player_data_df %>% 
  select(name, year_start, year_end, height) %>% 
  mutate(birth_year=birth_year) %>% 
  na.omit() %>% 
  mutate(end_year = 2018) %>% 
  mutate(age=end_year-birth_year) %>% 
  select(name, height, age, year_start, year_end)



#filter age is less or equal to 30, career is during 2008 to 2018
player_fit_requirement<- player_data_age %>% 
  filter(age<=30) %>% 
  filter(age>=20) %>% 
  filter(year_start>=2008) %>% 
  filter(year_end<=2018) %>% 
  select(name, height)

#convert the format of height
height_in_cm = player_fit_requirement$height %>% 
  str_replace_all("-", "'") %>% 
  strsplit("'",fixed = T) %>% 
  sapply(function(x) sum(as.numeric(x)*c(30.48,2.54)))

player_height_cm <- player_fit_requirement %>% 
  mutate(height_in_cm = height_in_cm) %>% 
  select(name, height_in_cm) %>% 
  rename(
    Player = name
  ) 

#filter the efg% fit the requirement
season_stats_0818 <-season_stats_df %>% 
  filter(Year>=2008) %>% 
  filter(Year<=2018) %>% 
  select(Player, eFG.)

#calculate the average efg of player
efg_rte <- season_stats_0818 %>% 
  group_by(Player) %>% 
  summarise(efg = mean(sum(eFG.))) %>% 
  na.omit()


#combine two data frame
efg_height <- left_join(player_height_cm, efg_rte, by = "Player") %>% 
  na.omit() %>% 
  select(Player,height_in_cm, efg)


#make plot
#question2plot <- ggplot(data = efg_height, mapping= aes_string(x="height_in_cm", y=input$feature_choice))+
 # geom_point() +
  #geom_smooth(formula = y ~ x, color= "Red", method= loess) +
  #labs(title = "the relationships between players' height & efg rate", 
   #    x= "height in cm",
    #   y= "avg efg"
#  )


###Question 3
## Compare experienced players and rookie players in 2017 season
## NBA player average age: 26 yrs old   NBA player average seasons: 4.6 seasons
player_data_df_2 <- player_data_df %>%
  mutate(career_range = year_end + 1 - year_start)

Season_stats_df <- season_stats_df %>%
  select(Year, Player, Age, PER, WS)

year_range <-range(Season_stats_df$Year, na.rm = T)

#View(Season_stats_2017_df)
Season_stats_df <- Season_stats_df %>%
  rename(name = Player)
Season_stat_careerRange_df <- left_join(Season_stats_df, player_data_df_2, by = "name") %>%
  select(Year, name, Age, Year, PER, WS, career_range) %>% 
  drop_na()





###Question 4

all_NBA_raw_data_2df <- all_NBA_raw_data_df %>% 
  select(player, ft, fta)


player_data_2_df <- player_data_df

player_data_2_df$position <- str_replace_all(player_data_2_df$position, "C-F", "C")


player_data_2_df $position <- str_replace_all(player_data_2_df$position, "F-C", "pf")


player_position_2_df <- player_data_2_df %>%
  filter(position == "pf"| position == "C") %>% 
  select(name, position)


Player_ft_pct_position_df <- left_join(all_NBA_raw_data_2df, player_position_2_df, by = c("player"="name")) %>% 
  drop_na(position) %>% 
  group_by(player) %>% 
  select(player,ft,fta, position)
#View(Player_ft_pct_position_df)


ft_pct_position_plot <- ggplot(data = Player_ft_pct_position_df)+
  geom_jitter(mapping = aes(x = fta, y = ft, color = position))+
  labs(title= "Centers vs Power Forwards free throw percentages", 
       fill="Position",
       x="Free Throws Attempts",
       y= "Free Throws")+
  scale_color_brewer(palette = "Set2",labels= c( "C" = "Centers", "pf" = "Power Forwards")) 
ft_pct_position_plot

#add trendline
ft_pct_position_plot_trend <- ggplot(data = Player_ft_pct_position_df,mapping = aes(x = fta, y = ft, color = position))+
  geom_jitter()+
  geom_smooth(method = 'gam', formula = y ~ s(x, bs = "cs", k = 4), col="red")+
  labs(title= "Centers vs Power Forwards free throw percentages", 
       fill="Position",
       x="Free Throws Attempts",
       y= "Free Throws")+
  scale_color_brewer(palette = "Set2",labels= c( "C" = "Centers", "pf" = "Power Forwards"))
ft_pct_position_plot_trend


###Question 5
ftfg3_df<-all_NBA_raw_data_df %>% select(c("ft_pct","fg3_pct"))
scatterplot_ftfg3<-ggplot(ftfg3_df,aes(x=ft_pct, y=fg3_pct, color=1))+geom_point()+
  labs(title="Relationship between the 3-point Field GoalsPercentage and Free Throw Rate", 
       x="Free Throw Rate", y="3-point Field Goals Percentage")
scatterplot_ftfg3

#Lucas
#calculate player's age
player_data_age <- player_data_df %>% 
  select(name, year_start, year_end, height) %>% 
  mutate(birth_year=birth_year) %>% 
  na.omit() %>% 
  mutate(end_year = 2018) %>% 
  mutate(age=end_year-birth_year) %>% 
  select(name, height, age, year_start, year_end)

birth_year = str_sub(player_data_df$birth_date, start= -4, end = -1) %>% 
  as.numeric()

#filter age is less or equal to 30, career is during 2008 to 2018
player_fit_requirement<- player_data_age %>% 
  filter(age<=30) %>% 
  filter(age>=20) %>% 
  filter(year_start>=2008) %>% 
  filter(year_end<=2018) %>% 
  select(name, height)

#convert the format of height
height_in_cm = player_fit_requirement$height %>% 
  str_replace_all("-", "'") %>% 
  strsplit("'",fixed = T) %>% 
  sapply(function(x) sum(as.numeric(x)*c(30.48,2.54)))

player_height_cm <- player_fit_requirement %>% 
  mutate(height_in_cm = height_in_cm) %>% 
  select(name, height_in_cm) %>% 
  rename(
    Player = name
  ) 

#filter the efg% & WSfit the requirement
season_stats_0818 <-season_stats_df %>% 
  filter(Year>=2008) %>% 
  filter(Year<=2018) %>% 
  select(Player, eFG., WS)

#calculate the average efg and WS of player
efg_ws_rte <- season_stats_0818 %>% 
  group_by(Player) %>% 
  rename(ws = WS) %>% 
  summarise(ws=mean(sum(ws)), efg=mean(sum(eFG.))) %>% 
  na.omit()


#combine two data frame
efg_ws_height <- left_join(player_height_cm, efg_ws_rte, by = "Player") %>% 
  select(height_in_cm, ws, efg) %>% 
  na.omit()




#make inputs
height_range <- range(efg_ws_height$height_in_cm)
height_range
feature_vector <- colnames(efg_ws_height) 
feature_vector <- feature_vector[-1]

height_input <- sliderInput(inputId = "height_choice", label = "height",
                            min = height_range[1], max = height_range[2], 
                            value = height_range)
feature_input <- selectInput(inputId = "feature_choice", label = "feature", 
                             choices = feature_vector,
                             selected = "efg")
