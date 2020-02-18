#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(dplyr)
library(readxl)
library(shinythemes)

ui = fluidPage(
  titlePanel("Haragia"),
  sidebarLayout(
    sidebarPanel(
      fileInput('file1GrosBovine', label = h3('Choose gros bovine - xls/xlsx file'),
                accept = c(".xlsx")
      ),
      
      
      fluidRow(column(12, verbatimTextOutput("value"))),
      hr(),
      #verbatimTextOutput("summary"),
      
     
      #unique(dataBovine$Classement) "U+" "U=" "U-" "R+" "R=" "R-"
      # selectInput("filt_species",
      #             "Filtrez sur les espèces : ",
      #             choices = c(unique(dataBovine$Classement), "Tout"),
      #             selected = "Tout"),
      # 
      # uiOutput('variables'),
      
    
      
      selectInput("TestSpeciesBof", 
                  label = "Select the Classement",
                  choices = c("U+", 
                              "U=",
                              "U-", 
                              "U",
                              "R+",
                              "R=",
                              "R-",
                              "All"
                  ),
                  selected = "All"),
      
      selectInput("TestSpeciesPeriode", 
                  label = "Période",
                  choices = c("1 Janvier-Mars 2019", 
                              "2 Avril-Juin 2019",
                              "3 Juillet-Sept 2019", 
                              "4 Octobre-Décembre 2019",
                              "All"
                  ),
                  selected = "All"),
      
      
      
      # select input with the list of datasets
      selectInput(inputId = "data1", label = "Select the Dataset of your choice", choices = c("dataBovine")),
      br(),
      helpText("The following selectInput drop down choices are dynamically populated based on the dataset selected by the user above"),
      br(),
      uiOutput("vx"), # vx is coming from renderUI in server.r
      br(),
      br(),
      uiOutput("vy"), # vy is coming from renderUI in server.r   
      br(),
      uiOutput("col") # vy is coming from renderUI in server.r 
    ),
    mainPanel(
      DT::dataTableOutput('tableBovine'),
      plotOutput("p"),
      tableOutput("modifiedData")
      
      )
    
  )
)