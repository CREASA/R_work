my_server<-function(input, output, session){

  #michelle
   output$plot4 <- renderPlot({
    
    ft_pct_position_plot
    if (input$Trendline) {
      return(ft_pct_position_plot_trend)
    }
    return(ft_pct_position_plot)
  })

  output$plotDescription<- renderText({
    with_trendline<-paste("This trendline shows the best fit between centers and power forwards.")
    without_trendline<- paste("This plot compares the free throw percentages of centers and power forwards.")
    
     if (input$Trendline){
       return(with_trendline)
    } else {
      return(without_trendline)
    }
    
  })
  
  
 #plot5 
  output$plot5 <- renderPlot({
    filtered_height_efg_ws <- efg_ws_height %>% 
      filter(height_in_cm >= input$height_choice[1], height_in_cm<= input$height_choice[2])
    
    height_plot <- ggplot(data = filtered_height_efg_ws, 
                          mapping = aes_string(x="height_in_cm", y=input$feature_choice)) +
      geom_point() +
      geom_smooth(formula = y ~ x, color= "Red", method= loess)+
      labs(x = "height")
    
    return(height_plot)
  })
  output$height1 <- renderText({
    paste("The height range of the result is from", input$height_choice[1], " to ", input$height_choice[2])
  })
  
  #hongliang
  output$message2 <- renderText({paste("This table shows the numbers of NBA players produced for all states."
  )})
  
  output$message1 <- renderText({paste("You can choose a chart to display:",
                                       input$feature
  )})
  
  output$table <- renderTable({
    states_data_bar_chart1<- states_data_bar_chart %>%
      arrange(-counts)
    show_table<- states_data_bar_chart[, c("region", "counts"), drop= F] 
  })
  
  x<- reactive({input$feature})
  
  output$plotA<- renderPlot({
    if (x()== "Map"){
      return(players_states_plot)
    } else {
      return(bar_chart)
    }
  }, height = 500, width = 600)
  
   #Mike 
  output$plot1 <- renderPlot({
    experience_player_stat_df <- Season_stat_careerRange_df %>%
      filter(Year>=input$years_played[1], Year<=input$years_played[2])%>%
      filter(career_range >= 5)
    mean_experience_player_PER <- mean(experience_player_stat_df$PER)
    rookie_player_stat_df <- Season_stat_careerRange_df %>%
      filter(Year>=input$years_played[1], Year<=input$years_played[2])%>%
      filter(career_range < 5)
    mean_rookie_player_PER <- mean(rookie_player_stat_df$PER)
    
    Season_yearRange_PER_plot <- ggplot(data = Season_stat_careerRange_df,
                                        aes(x = career_range, y = PER, color = Age)) +
      geom_jitter(mapping = aes(x = career_range, y = PER, color = Age)) +
      geom_smooth(formula = y ~ x, color= "Red", method= loess) +
      labs(
        title = "PER for different NBA players with different career range",
        x = "years played in NBA Union",
        y = "PER"
      )
    
    return(Season_yearRange_PER_plot)
    
    
  })
  
  output$plot2 <- renderPlot({
    experience_player_stat_df <- Season_stat_careerRange_df %>%
      filter(Year>=input$years_played[1], Year<=input$years_played[2])%>%
      filter(career_range >= 5)
    mean_experience_player_PER <- mean(experience_player_stat_df$PER)
    rookie_player_stat_df <- Season_stat_careerRange_df %>%
      filter(Year>=input$years_played[1], Year<=input$years_played[2])%>%
      filter(career_range < 5)
    mean_experience_player_WS <- mean(experience_player_stat_df$WS)
    mean_rookie_player_WS <- mean(rookie_player_stat_df$WS)
    
    Season_yearRange_WS_plot <- ggplot(data = Season_stat_careerRange_df,
                                       aes(x = career_range, y = WS, color = Age))  +
      geom_jitter(mapping = aes(x = career_range, y = WS, color = Age)) +
      geom_smooth(formula = y ~ x, color= "Red", method= loess) +
      labs(
        title = "WS for different NBA players with different career range",
        x = "years played in NBA Union",
        y = "WS"
      )
    return(Season_yearRange_WS_plot)
  }) 
  
  
  
  
  output$YearofPlot <- renderText({
    paste0("Year range of the data is from ",input$years_played[1], " to ", input$years_played[2])
  })
  
  
  
  
}