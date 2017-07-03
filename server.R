#R group
require(shiny)

shinyServer <- function(input, output) {
  
  res=eventReactive(input$submit,{
    
    name=as.character(input$name)
    minHp=input$hp[1]
    maxHp=input$hp[2]
    
    res=mtcars
    if (name!="") {
      res=mtcars[name,]
    }
    res=res[res$hp<maxHp & res$hp>minHp,]
    
    validate(need(nrow(res)>0, "No matches found"))
    
  return(res)

  })
  
  output$res=renderDataTable({
    res=res()
    },options=list(hover = T, bordered = T, align="c", colnames = T, rownames = T, na="NA"))
  
  output$resTable=downloadHandler(filename="data_table.csv", 
                                       content = function(file) {
                                        write.csv(res,file,row.names = F) 
                                       }, contentType = "text/csv")
  
  output$priceList=downloadHandler(filename = "cars_prices.csv", 
                                   content=function(file){
                                     file.copy("price_list.csv")
                                   },contentType = "text/csv")
  
}