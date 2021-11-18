ui <- dashboardPage(
  dashboardHeader(title = "Weather History"),
  dashboardSidebar(
    sidebarMenu(
      menuItem("Diagram", tabName = "diagram"),
      menuItem("View data", tabName = "Viewdata")
    )
  ),
  dashboardBody(
    tabItems(
      tabItem(tabName = "diagram",
        selectInput(
          inputId = "var",
          label = "Choice variable",
          choices = c("Temperature", "Apparent Temperature", "Humidity", "Wind Speed", "Visibility", "Pressure millibars"),
          selected = "Temperature"
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
        sidebarLayout(sidebarPanel(
          selectInput(
            inputId = "specie",
            label = "Select the Summary",
            choices = unique(d$Summary),
            selected = "Rain"
          )
        ),
        tableOutput("data"))
      )
    )
  )
)