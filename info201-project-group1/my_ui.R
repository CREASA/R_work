source("analysis.R")



my_ui<-navbarPage("NBA Research",
                   
             tabPanel("Home",
                      includeHTML("index docu.html"),
                      tags$head(
                      tags$link(rel = "stylesheet",type = "text/css", href = "style.css"),
                      )
                      ),
            
                  
                  tabPanel("Players & Birth Locations",
                           tags$p("NBA Players from Different States", 
                                  style = "font-family: 'Helvetica';font-style: italic;
                color: GhostWhite; font-weight: bold; font-size: 32px"),
                           sidebarLayout(
                             sidebarPanel(
                               radioButtons(inputId ="feature",
                                            label = "Choose a Graph:",
                                            choices = c("Map", "Bar Chart"))),
                             mainPanel(tabPanel("PlotQ1", textOutput("message1"), plotOutput("plotA")))
                           )),
                  
                  tabPanel("Height & Behavior",
                           tags$p("Correlation of Players' Behavoir and Their Heights",
                                  style = "font-family: 'Helvetica';font-style: italic;
                color: GhostWhite; font-weight: bold; font-size: 32px"),
                           sidebarLayout(sidebarPanel(height_input,
                                                      feature_input),
                                         mainPanel(plotOutput("plot5"), textOutput("height1"))
                           )),
                  
                  tabPanel("Experienced vs Rookie",
                           tags$p("NBA Experienced Players vs NBA Rookie Players",
                                  style = "font-family: 'Helvetica';font-style: italic;
                color: GhostWhite; font-weight: bold; font-size: 32px"),
                           sidebarLayout(
                             sidebarPanel(
                               sliderInput(
                                 inputId = "years_played",
                                 label = "Which year do you wanna observe?",
                                 min = year_range[1],
                                 max = year_range[2],
                                 value = year_range
                               )
                             ),
                             
                             mainPanel(
                               tabsetPanel(
                                 type = "tabs",
                                 tabPanel("Plot", 
                                 textOutput("YearofPlot"),
                                 plotOutput("plot1"), 
                                 plotOutput("plot2"))
                               
                               
                             )))),
             

             tabPanel("Centers vs Power Forwards",
                      tags$p("Free Throw Percentage Between Centers and Power Forwards",
                             style = "font-family: 'Helvetica';font-style: italic;
                color: GhostWhite; font-weight: bold; font-size: 32px"),
                      
                      mainPanel(
                        
                                    checkboxInput(inputId = "Trendline",
                                                  label = strong("Show Trendline"),
                                                  value = FALSE),
                       textOutput("plotDescription"),
                                 plotOutput(outputId = "plot4", height = "250px")
                                 )
                        
                      )
             

                  
)

