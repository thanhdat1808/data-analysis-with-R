ui <- dashboardPage(
  dashboardHeader(title = "Weather History"),
  dashboardSidebar(
    sidebarMenu(
      menuItem("Diagram", tabName = "diagram"),
      menuItem("View data", tabName = "Viewdata"),
      menuItem("Chart", tabName = "Chart"),
      menuItem("Linear Regression Model", tabName = "LinearRegressionModel"),
      menuItem("Logistic Regression Model", tabName = "LogisticRegressionModel")
    )
  ),
  dashboardBody(
    tabItems(
      tabItem(tabName = "diagram",
        selectInput(
          inputId = "var",
          label = "Choice variable",
          choices = nameDiagram,
          selected = nameDiagram[1]
        ),
        titlePanel("Histogram"),
        fluidRow(
          column(
          width = 12,
          box(
          width = "100%",
          plotOutput('plot1')
          )
          )
        ),
        fluidRow(
          tabsetPanel(
            tabPanel("Summary", verbatimTextOutput("mysummary")),
            tabPanel("Boxplot", plotOutput("myplot"))
          )
        )
      ),
      
      tabItem(tabName = "Viewdata",
        fluidRow(
          box(selectInput(
            inputId = "summary",
            label = "Select the Summary",
            choices = c("All",unique(d$Summary)),
            selected = "All"
          )),
          box(selectInput(
            inputId = "precip_type",
            label = "Select the Precip Type",
            choices = c("All",unique(d$Precip.Type)),
            selected = "All"
          ))
        ),
        fluidRow(
          box(sliderInput(
            inputId = "silder_temp",
            label = "Temperature",
            min = min(d$Temperature),
            max = max(d$Temperature),
            value = c(min(d$Temperature),max(d$Temperature))
          ))
        ),
        tableOutput("data")
      ),
      
      tabItem(tabName = "Chart",
        fluidRow(
          box(selectInput(inputId =  'xcol',
                          label = 'X variable',
                          choices =  tablename,
                          selected = tablename[[1]])),
          box(selectInput(inputId = 'ycol',
                          label =  'Y variable',
                          choices =  tablename,
                          selected = tablename[[3]]))
        ),
        plotOutput('chart')
              
      ),
      
      
      tabItem(tabName = "LinearRegressionModel",
        fluidRow(
          box(selectInput(inputId =  'response_variable',
                          label = 'Response Variable',
                          choices =  response_variable_list,
                          selected = response_variable_list[1])),
          box(selectInput(inputId = 'predictor_variable',
                          label =  'Predictor Variable',
                          choices =  predictor_variable_list,
                          selected = predictor_variable_list[[1]]))
        ),
        fluidRow(
          plotOutput('liner_regression')
        ),
        fluidRow(
          tabsetPanel(
            tabPanel("Summary", verbatimTextOutput("summary_linear_regression")),
            
          )
        )
      ),
      tabItem(tabName = "LogisticRegressionModel",
              fluidRow(
                box(
                  checkboxGroupInput(
                    inputId = "logistic",
                    label = "Input",
                    choices = c("A")
                  )
                )
              )
      )
      )
    
    )
  )
