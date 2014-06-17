downloadNotInstalled<-function(x){
    for(i in x){
      if(!require(i,character.only=TRUE)){
        install.packages(i,repos="http://cran.r-project.org")
        library(i,character.only=TRUE)
      }
    }
}
requiredPackages = c("shiny","vegan","matrixStats","RColorBrewer","gplots")
downloadNotInstalled(requiredPackages)

load("mousedata.rda")

shinyServer(function(input, output) {

  otuIndices = reactive({
    otuVars = rowSds(mat)
    otuIndices = order(otuVars, decreasing = TRUE)[1:input$n]
    otuIndices
  })

  output$plot1 <- renderPlot({
    mat2 = mat[otuIndices(), ]
    cc = as.matrix(cor(t(mat2),method=input$correlationMethod))
    hc = hclust(vegdist(mat2,method=input$distanceMethod))
    otuOrder = hc$order
    cc = cc[otuOrder, otuOrder]
    
    keysize = ifelse(input$hist,yes=1.5,no=.5) 
    if(input$hist){
      offsetRow=.5
      offsetCol=.5
    } else {
      offsetRow=0
      offsetCol=0
    }
    
    heatmap.2(t(cc),trace="none",dendrogram = "none",
    col = colorRampPalette(brewer.pal(9, "RdBu"))(50),Rowv=FALSE,Colv=FALSE,
    key=input$hist,keysize=keysize,offsetRow=offsetRow,offsetCol=offsetCol)
  })

})