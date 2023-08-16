data<-read.csv("owid-co2-data.csv", header = T, sep=",", stringsAsFactors=FALSE)
#View(data)
library(tidyverse)
library(dplyr)

year_range<-range(data$year)

my_ui <- fluidPage(
  titlePanel(strong("Climate Change - trends in CO2 emissions US")),
  sidebarLayout(
    sidebarPanel(
      radioButtons("feature", "Features:",
                   c("CO2" = "CO2",
                     "GDP" = "GDP",
                     "CO2perGDP" = "CO2perGDP")),
      sliderInput("Year",
                  "Range of Year:",
                  min = year_range[1],
                  max = year_range[2],
                  value = year_range)
    ),
    mainPanel(
      tabsetPanel(
        tabPanel("Table", textOutput("text"), tableOutput("table")),
        tabPanel("Plot", textOutput("text1"), plotOutput("plot"))
      )
    )
  )
)
