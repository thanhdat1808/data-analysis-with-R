library(ggplot2)
library(dplyr)
library(tidyr)
library(shiny)
library(shinydashboard)

server <- function(input, output){
  char = reactive({
    switch(
      input$var,
      "Temperature" = "Temperature..C.",
      "Apparent Temperature" = "Apparent.Temperature..C.",
      "Humidity" = "Humidity",
      "Wind Speed" = "Wind.Speed..km.h.",
      "Visibility" = "Visibility..km.",
      "Pressure millibars" = "Pressure..millibars."
    )
  })
  output$plot1 <- renderPlot({
    hist(
      d[, char()],
      xlab = input$var,
      main = paste("Histogram of", input$var)
    )
  })
  
  output$data = renderTable({
    d[d$Summary == input$specie, ]
  })
  
  output$mysummary = renderPrint({
    summary(d[, char()])
  })
  
  output$myplot  = renderPlot({
    boxplot(d[, char()], main = "Boxplot")
  })
}

shinyApp(ui, server)

