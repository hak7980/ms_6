library(shiny)
library(tidyverse)
library(ggplot2)

ui <- fluidPage(
    titlePanel(strong("ms_6"), "ms_6"),
    sidebarLayout(
        sidebarPanel(
            selectInput("countryInput", "Country",         
                        choices = c("Choose one" = "", "Australia", "England","India", "Pakistan"))),
        mainPanel(plotOutput("plot"))))

server <- function(input, output) {
    load("./Data/data.RData")
    output$plot <-renderPlot({   
        filtered <-  subsetpk %>% filter(team==input$countryInput) %>% na.omit()
        filtered %>% ggplot() + geom_point(aes(x = factor(year), 
                                               group = factor(bracket),                                
                                               color = factor(bracket), y = prop_won), 
                                           size=2) +            
            labs(title = "Proportion of Matches won Sorted by Runs Scored in the \n First Five Overs", subtitle = "Sorted According to Run Bracket - Period: 2010-2017",   x = "Year", y = "Proportion Won", col = "Runs Scored Bracket") +  labs(caption = "Source: cricsheet.org") + theme_classic()+  theme(legend.position = "right", axis.text.x = element_text(angle = 45, hjust = 1))})
    
    
}

shinyApp(ui = ui, server = server)
