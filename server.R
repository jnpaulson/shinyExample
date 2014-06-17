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
    image(t(cc),col = colorRampPalette(brewer.pal(9, "RdBu"))(50))
  })

})