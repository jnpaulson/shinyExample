downloadNotInstalled<-function(x){
    for(i in x){
      if(!require(i,character.only=TRUE)){
        install.packages(i,repos="http://cran.r-project.org")
        library(i,character.only=TRUE)
      }
    }
}
requiredPackages = c("shiny","vegan","matrixStats","RColorBrewer")
downloadNotInstalled(requiredPackages)

load("mousedata.rda")

shinyUI(pageWithSidebar(
  headerPanel('Correlation Matrix Heatmap'),
  sidebarPanel(
    numericInput('n', 'Number of features:', 200,
                min=10,max=nrow(mat)),
    selectInput('distanceMethod', 'Distance method:', c("euclidean","manhattan","canberra", "bray", 
        "kulczynski", "gower", "morisita", "horn", "mountford", 
        "jaccard", "raup", "binomial", "chao", "altGower", "cao")),
    selectInput('correlationMethod', 'Correlation:',c("pearson", "kendall", 
      "spearman")),
    radioButtons('hist','Include Density:',c("TRUE"="TRUE","FALSE"="FALSE"))
  ),
  mainPanel(
    plotOutput('plot1',height="700px")
  )
))