library(shiny)

library(ggplot2)


ui <- fluidPage(
 
  titlePanel("Welcome to VoldePlot!!"),
  
  sidebarLayout(
    
    sidebarPanel(
    
      fileInput("file","Upload CSV file",accept=".csv"),
   
      checkboxInput("header","Header",TRUE),
   
      selectInput("logfc_col","Log2 Fold Change Column",choices =NULL),
    
      selectInput("pvalue_col","P-value Column", choices= NULL),
   
      sliderInput("logfc_cutoff","Select cutoff values for Log Fold Change",min=-5,max=5,value=c(-1,1),step=0.1),
   
      numericInput("pvalue_cutoff"," Input P-Value Cut Off",value=0.05),
    
      selectInput("gene_col","Select Gene Name/Symbol Column",choices= NULL),
   
      selectInput("selected_gene","Select Gene of Interest",choices=NULL)
   
    ),
   
    mainPanel(
    
      plotOutput("volcanoPlot"),
     
      tableOutput("geneData"),
     
      tableOutput("volcanoPlotData")
    
    )
 
  )

)





server <- function(input,output,session){

  data <- reactive({
  
    req(input$file)
   
    read.csv(input$file$datapath)
 
  })

  
  observe({
  
    df <- data()
    
    updateSelectInput(session,"logfc_col",choices=names(df))
  
    updateSelectInput(session,"pvalue_col",choices=names(df))
    
    updateSliderInput(session,"logfc_cutoff",value=NULL)
   
    updateNumericInput(session,"pvalue_cutoff",value=NULL)
    
  
  })
  
 
  observe({
  
    df<- data()
   
    updateSelectInput(session,"gene_col",choices=names(df))
    
    updateSelectInput(session,"selected_gene",choices= unique(df[[input$gene_col]]))
    
    
    
 
  
  })
  
  
  
 
  
  output$volcanoPlotData<-renderTable({
   
    
    df<- data()
  
    
    req(input$logfc_col,input$pvalue_col,input$logfc_cutoff,input$pvalue_cutoff,input$gene_col,input$selected_gene)
  
    
    df$Expression <- "NO"
  
    
    df$Expression[df[[input$logfc_col]]>=max(input$logfc_cutoff) & df[[input$pvalue_col]] <= input$pvalue_cutoff] <- "UP"
   
    
    df$Expression[df[[input$logfc_col]]<=min(input$logfc_cutoff) & df[[input$pvalue_col]] <= input$pvalue_cutoff] <- "DOWN"
    
    

    df
    
 
  
  })
  
 
  
  output$geneData <- renderTable({
  
    
    df<- data()
   
    
    req(input$logfc_col,input$pvalue_col,input$logfc_cutoff,input$pvalue_cutoff,input$gene_col,input$selected_gene)
   
    
    df$Expression <- "NO"
   
    
    df$Expression[df[[input$logfc_col]]>=max(input$logfc_cutoff) & df[[input$pvalue_col]] <= input$pvalue_cutoff] <- "UP"
   
    
    df$Expression[df[[input$logfc_col]]<=min(input$logfc_cutoff) & df[[input$pvalue_col]] <= input$pvalue_cutoff] <- "DOWN"
    
    
   
    
    df[df[[input$gene_col]] == input$selected_gene, ]
    
 
  
  })
  
 
  
 
  
  output$volcanoPlot <- renderPlot({
    
    
    df<- data()
  
    
    req(input$logfc_col,input$pvalue_col,input$logfc_cutoff,input$pvalue_cutoff,input$gene_col,input$selected_gene)
   
    
    df$Expression <- "NO"
    
    
    df$Expression[df[[input$logfc_col]]>=max(input$logfc_cutoff) & df[[input$pvalue_col]] <= input$pvalue_cutoff] <- "UP"
    
    
    df$Expression[df[[input$logfc_col]]<=min(input$logfc_cutoff) & df[[input$pvalue_col]] <= input$pvalue_cutoff] <- "DOWN"
    
    
  
    
    ggplot(df,aes(x=.data[[input$logfc_col]],y=-log10(.data[[input$pvalue_col]]),col=Expression))+
     
    
      geom_point()+
      
    
    scale_color_manual(values=c("red","black","green"))+
     
    
    geom_vline(xintercept= input$logfc_cutoff,col="blue")+
     
    
    
    
    geom_hline(yintercept=-log10(input$pvalue_cutoff),col="blue")+
     
    
    
    labs(title= "Volcano Plot",x= "Log2 Fold Change",y="-Log10(P Value)")+
     
    
    theme_minimal()
    
 
  
  })
  
  


}

shinyApp(ui,server)


