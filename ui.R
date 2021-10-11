ui<- fluidPage(
  #Assign Dashboard title 
  titlePanel("COVID19 and its affect on America"),
  
  # Start:  the First Block
  # Sliderinput: select from the date between 01.20.2020 
  # and 01.04.2020
  sliderInput(inputId = "date", "Date:", min = 
                as.Date("2020-01-20"), max = as.Date("2020-05-01"), 
              value = as.Date("2020-03-01"), width = "600px"),
  
  # plot leaflet object (map) 
  leafletOutput(outputId = "distPlot", width = "700px", 
                height = "300px"),
  #End:  the First Block
  
  #Start: the second Block
  sidebarLayout(
    
    #Sidebar Panel: the selected county, history and 
    #whether to plot daily new confirmed cases.
    sidebarPanel(
      selectizeInput('selectedcounty', h4("County"), choices = data$county, options = list(maxOptions = 5, placeholder = 'select a county name')),
      selectInput("selectedhistoricwindow", h4("History"), 
                  choices = list("the past 10 days", "the past 20 
      days"), selected = "the past 10 days"),
      checkboxInput("dailynew", "Daily new infected", 
                    value = TRUE),
      width = 3  
    ),
    
    #Main Panel: plot the selected values
    mainPanel (
      plotOutput(outputId = "Plotcounty", width = "500px", 
                 height = "300px")
    )
  ),
  #End: the second Block 
)