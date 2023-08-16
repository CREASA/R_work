data<-read.csv("owid-co2-data.csv", header = T,sep=",", stringsAsFactors=FALSE)
#View(data)
library(tidyverse)
library(dplyr)
library(ggplot2)

data_short<-data %>% select (country, year, co2, gdp, co2_per_gdp) %>%
  group_by(year) %>% filter(country=="United States")
data_short[is.na(data_short)] <- 0
#View(data_short)

year_range<-range(data_short$year)

my_server <- function(input_list, output_list) {
  output_list$text <- renderText({ 
    paste("The table shows the data from ", input_list$Year[1]," to ", input_list$Year[2])
  })
  
  output_list$text1 <- renderText({ 
    paste("The plot shows the selected feature over year from ", input_list$Year[1]," to ", input_list$Year[2])
  })

  output_list$table <- renderTable({
    data_clean<-data_short %>%
      rename("GDP" = gdp) %>%
      rename("CO2perGDP" = co2_per_gdp) %>%
      rename("CO2" = co2)
    data_clean[, c("year", input_list$feature), drop = FALSE] %>% filter(year>=input_list$Year[1],
                                                          year<=input_list$Year[2]) 
    }, rownames = TRUE)
  
  output_list$plot <- renderPlot({
    data_clean<-data_short %>%
      rename("GDP" = gdp) %>%
      rename("CO2perGDP" = co2_per_gdp) %>%
      rename("CO2" = co2)
    selected_data<-data_clean[, c("year", input_list$feature), drop = FALSE] %>% filter(year>=input_list$Year[1],
                                                                         year<=input_list$Year[2])
    splot<-ggplot(data=selected_data, mapping=aes_string(
      x="year",
      y=input_list$feature)) +
      geom_point(color = "steelblue")+geom_line(color = "#00AFBB")+labs(title="Plot of the Selected Feature Over Year", x="Year", y=input_list$feature)+scale_color_brewer("Dark2")
    return(splot)
  })
}