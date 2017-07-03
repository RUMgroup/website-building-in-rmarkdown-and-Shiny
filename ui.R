#R group
require(shiny)
nameList=as.character(rownames(mtcars))

shinyUI <- fluidPage(
  
  sidebarPanel(
    tags$head(tags$script(src="enterButton.js")),
    fluidRow(selectInput("name",label = "Model",choices = c("",nameList))),
    fluidRow(sliderInput("hp","Horsepower range",min =50 ,max=350,value=c(50,150))),
    fluidRow(actionButton("submit",label = "Submit"))
  ),
  
  mainPanel(
    dataTableOutput("res"),
    
    conditionalPanel(
      condition="output.res",fluidRow(downloadLink("resTable","Download table"),
                                      fluidRow(downloadLink("priceList","Download price list")))
    )
    )
)