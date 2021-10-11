server <- function(input, output){
  
  #Assign output$distPlot with renderLeaflet object
  output$distPlot <- renderLeaflet({
    
    # row index of the selected date (from input$date)
    rowindex = which(as.Date(as.character(data$date), 
                             "%d.%m.%Y") ==input$date)
    
    # initialise the leaflet object
    basemap= leaflet()  %>%
      addProviderTiles(providers$Stamen.TonerLite,
                       options = providerTileOptions(noWrap = TRUE)) 
    
    # assign the chart colors for each county, where those 
    # counties with more than 5,000 cases are marked 
    # as red, otherwise black
    chartcolors = rep("black",7)
    stresscounties 
    = which(as.numeric(data[rowindex,c(2:8)])>500)
    chartcolors[stresscounties] 
    = rep("red", length(stresscounties))
    
    # add chart for each county according to the number of 
    # confirmed cases to selected date 
    # and the above assigned colors
    basemap %>%
      addMinicharts(
        data2$longitude, data2$latitude,
        chartdata = as.numeric(data[rowindex,c(2:8)]),
        showLabels = TRUE,
        fillColor = chartcolors,
        labelMinSize = 5,
        width = 45,
        transitionTime = 1
      ) 
  })
  
  #Assign output$Plotcounty with renderPlot object
  output$Plotcounty <- renderPlot({
    
    #the selected county 
    chosencounty = input$selectedcounty
    
    #assign actual date
    today = as.Date("2020/04/02")
    
    #size of the selected historic window
    chosenwindow = input$selectedhistoricwindow
    if (chosenwindow == "the past 10 days")
    {pastdays = 10}
    if (chosenwindow  == "the past 20 days")
    {pastdays = 20}
    
    #assign the dates of the selected historic window
    startday = today-pastdays-1
    data$date=as.Date(as.character(data$date),"%d.%m.%Y")
    selecteddata 
    = data[(data$date>startday)&(data$date<(today+1)), 
           c("Date",chosencounty)]
    
    #assign the upperbound of the y-aches (maximum+100)
    upperboundylim = max(selecteddata[,2])+100
    
    #the case if the daily new confirmed cases are also
    #plotted
    if (input$dailynew == TRUE){
      
      plot(selecteddata$date, selecteddata[,2], type = "b", 
           col = "blue", xlab = "Date", 
           ylab = "number of infected people", lwd = 3, 
           ylim = c(0, upperboundylim))
      par(new = TRUE)
      plot(selecteddata$date, c(0, diff(selecteddata[,2])), 
           type = "b", col = "red", xlab = "", ylab = 
             "", lwd = 3,ylim = c(0,upperboundylim))
      
      #add legend
      legend(selecteddata$date[1], upperboundylim*0.95, 
             legend=c("Daily new", "Total number"), 
             col=c("red", "blue"), lty = c(1,1), cex=1)
    }
    
    #the case if the daily new confirmed cases are 
    #not plotted
    if (input$dailynew == FALSE){
      
      plot(selecteddata$date, selecteddata[,2], type = "b", 
           col = "blue", xlab = "Date", 
           ylab = "number of infected people", lwd = 3,
           ylim = c(0, upperboundylim))
      par(new = TRUE)
      
      #add legend
      legend(selecteddata$date[1], upperboundylim*0.95, 
             legend=c("Total number"), col=c("blue"), 
             lty = c(1), cex=1)
    }
    
  })
  
} 
