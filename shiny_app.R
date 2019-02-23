#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)
library(plotly)
library(wesanderson)
final <- read.csv("federico_data.csv")

final$cluster_2 <- as.factor(final$cluster_2)
final$cluster_3 <- as.factor(final$cluster_3)
final$cluster_4 <- as.factor(final$cluster_4)

# Define UI for application that draws a histogram
ui <- fluidPage(
   
   # Application title
   titlePanel("Return and Volatility"),
   
      # Show a plot of the generated distribution
      mainPanel(
        tabsetPanel(type = "tabs",
                    tabPanel("2 Clusters", plotlyOutput("plot1")),
                    tabPanel("3 Clusters", plotlyOutput("plot2")),
                    tabPanel("4 Clusters", plotlyOutput("plot3"))
      )
   )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
   
   output$plot1 <- renderPlotly({
      # generate bins based on input$bins from ui.R
     
     ggplotly(ggplot(final, aes(volatility, avg_daily_return, colour = cluster_2, text = ticker)) +
       geom_point() +
       labs(title = 'Return and Volatility, 2 Clusters', y = 'Avg. Daily Return', x = 'Volatility') +
       scale_color_manual(values=wes_palette(n=2, name="Darjeeling1"))+
       theme(legend.position = "none"))
   })
   
   output$plot2 <- renderPlotly({
     # generate bins based on input$bins from ui.R
     
     ggplotly(ggplot(final, aes(volatility, avg_daily_return, colour = cluster_3, text = ticker)) +
       geom_point() +
       labs(title = 'Return and Volatility, 3 Clusters', y = 'Avg. Daily Return', x = 'Volatility') +
       scale_color_manual(values=wes_palette(n=3, name="Darjeeling1"))+
       theme(legend.position = "none"))
   })
   
   output$plot3 <- renderPlotly({
     # generate bins based on input$bins from ui.R
     
     ggplotly(ggplot(final, aes(volatility, avg_daily_return, colour = cluster_4, text = ticker)) +
       geom_point() +
       labs(title = 'Return and Volatility, 4 Clusters', y = 'Avg. Daily Return', x = 'Volatility') +
       scale_color_manual(values=wes_palette(n=4, name="Darjeeling1"))+
       theme(legend.position = "none"))
   })
}

# Run the application 
shinyApp(ui = ui, server = server)

