#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

library(dplyr)
library(datasets)
library(ggplot2)



server = function(input, output, session){
  
   tableBovine <- eventReactive(input$file1GrosBovine, {
     inFile <- input$file1GrosBovine
     if(is.null(inFile))
        return(NULL)
     file.rename(inFile$datapath,
     paste(inFile$datapath))
     
    read_excel(paste(inFile$datapath), 1)
    
  })
   
 
  
 output$tableBovine <- DT::renderDataTable(DT::datatable({
   data <- tableBovine()
   if(input$TestSpeciesBof != "All"){
     data <- data %>% filter(Classement == input$TestSpeciesBof)
   }
   if(input$TestSpeciesPeriode != "All"){
     data <- data %>% filter(Période == input$TestSpeciesPeriode)
   }
  
     data
        
   }))
 
 output$df_iris <- DT::renderDataTable({
   if (input$filt_species != "Tout"){
     iris %>% filter(Species %in% input$filt_species)
   } else iris
 })
 
 # output$tableBovine <- DT::renderDataTable({
 #   if(input$TestSpeciesPeriode == "All"){
 #     tableBovine()
 #   }
 #   else{
 #     tableBovine() %>% filter(Période == input$TestSpeciesPeriode)
 #   }
 # })
 

 # output$variables = renderUI({
 #   #tableB <- tableBovine()
 #   selectInput('variables2', 'Variables', choices =  (tableBovine()["Age de l'animal (en mois)"])/12)
 # })
 
 # The following reactive function would return the column variable names corresponding to the dataset selected by the user.
 var <- reactive({
   switch(input$data1,
          "dataBovine" = names(tableBovine())
   )
 })
 
 output$vx <- renderUI({
   selectInput("variablex", "Select the First (X) variable", choices = var())
 })
 
 output$vy <- renderUI({
   selectInput("variabley", "Select the Second (Y) variable", choices = var())
 })
 
 output$col <- renderUI({
   selectInput("variablecol", "Select color variable", choices = var())
 })
 
 
 
 # renderPlot is used to plot the ggplot and the plot output will be stored in the output variable p which could be used in ui.r to display the plot
 # renderPlot is used to plot the ggplot and the plot output will be stored in the output variable p which could be used in ui.r to display the plot
 output$p <- renderPlot({
   
   # attach(get(input$data1))
   # plot(x= get(input$variablex), y= get(input$variabley), xlab=input$variablex, ylab=input$variabley, main = "my super plot", col = get(input$variablecol))
   
 
   
   
   # If ggplot needs to de drawn the following could also be used instead of the plot () function
   # ggplot(get(input$data1), aes_string(input$variablex,input$variabley)) + geom_point() 
   # OR alternatively the following could also be used
   ggplot(get(input$data1), aes(x=!!as.symbol(input$variablex), y=get(input$variabley), col = !!as.symbol(input$variablecol)), environment = environment()) + geom_point() +
     labs(x = input$variablex, y = input$variabley) + ggtitle("Filtré par : " ,input$variablecol )
 })

 
 # output$summary <- renderPrint({
 #   summary(tableBovine())
 # })
 
 
 output$modifiedData <- renderTable({
   tableBovine() 
   
 })
 
 # You can access the value of the widget with input$file, e.g.
 output$value <- renderPrint({
   str(input$file1GrosBovine)
 })
  
}