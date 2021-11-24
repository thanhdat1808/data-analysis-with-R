library(ggplot2)
library(dplyr)
library(tidyr)
library(shiny)
library(shinydashboard)

server <- function(input, output){
  char = reactive({
    switch(
      input$var,
      "Temperature" = "Temperature",
      "Humidity" = "Humidity",
      "Wind Speed" = "Wind.speed",
      "Visibility" = "Visibility",
      "Pressure millibars" = "Pressure"
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
    req(input$silder_temp)
    if(input$summary!='All' && input$precip_type!='All' ){
      filter(d,d$Summary == input$summary & d$Precip.Type == input$precip_type & d$Temperature>= as.numeric(input$silder_temp[1]) & d$Temperature<= as.numeric(input$silder_temp[2]) )
    }
    else if(input$precip_type!='All'){
      d[d$Precip.Type == input$precip_type & d$Temperature>= as.numeric(input$silder_temp[1]) & d$Temperature<= as.numeric(input$silder_temp[2]),]
    }
    else if(input$summary!='All'){
      filter(d,d$Summary == input$summary & d$Temperature>= as.numeric(input$silder_temp[1]) & d$Temperature<= as.numeric(input$silder_temp[2]))
    }
    else{
      
      d[ d$Temperature>= as.numeric(input$silder_temp[1]) & d$Temperature<= as.numeric(input$silder_temp[2]),]
    }
  })
  
  output$mysummary = renderPrint({
    summary(d[, char()])
  })
  
  output$myplot  = renderPlot({
    boxplot(d[, char()], main = "Boxplot")
  })
  plotChart <- reactive({
    req(input$xcol)
    req(input$ycol)
    
    ggplot(d,
           mapping = aes(x = .data[[input$xcol]],y = .data[[input$ycol]])       
    ) +xlab(input$xcol)+ylab(input$ycol)+geom_point()
    
  })
  
  output$chart = renderPlot(plotChart())
  
  output$liner_regression = renderPlot({
    ggplot(d,
           mapping = aes(x = .data[[input$predictor_variable]],y = .data[[input$response_variable]])
    )+geom_point()+geom_smooth(formula = y~x, method = "lm")
    #ggplot(data, mapping = aes(x = input$predictor_variable,y = input$response_variable))+geom_point()+geom_smooth("lm")
    #+abline(lm(data = data , input$response_variable ~ input$predictor_variable))
  })
  model_lm <- reactive({
    req(input$response_variable)
    req(input$predictor_variable)
    
  })
  output$summary_linear_regression = renderPrint({
    print(input$predictor_variable)
    summary(lm(reformulate(input$response_variable, input$predictor_variable), data = d))
    })
  
}


