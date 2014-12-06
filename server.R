# setwd('C:/Data/Data Science/Coursera capstone/App/')

library(shiny)
library(RWeka)
library(data.table)


options(shiny.maxRequestSize=64*1024^2) 
load("nGramsLite.RData")
source("ngramPredictionFunction.R")


# Define server logic required to generate and plot a random distribution
shinyServer(function(input, output, session) {
  
  observe({
    t1 <- Sys.time()
    input$phrase
    out2 <- ngramPredictionFunction(input$phrase, ngram1, ngram2, ngram3, ngram4)
    words <- as.data.frame(out2)[,1]
    t2 <- Sys.time()                            
    output$table <- renderTable({ data.frame(out2[,1, with=FALSE]) })
    output$time  <-renderPrint({ print(t2-t1)  })
    session$sendCustomMessage(type = "myCallbackHandler", words)

  })
  
})