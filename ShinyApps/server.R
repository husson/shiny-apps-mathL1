#library(shiny)
#require(mvtnorm)

shinyServer(function(input, output) {
  
  simu <- reactive({
#    input$goButton
    N <- 200*input$N
    moy <- NULL
      if ("gaussian" %in% input$Loi) x <- rnorm(N)
      if ("chi2" %in% input$Loi) x <- rchisq(N, 1)
      if ("uniform" %in% input$Loi) x <- runif(N,0,1)
      if ("lognormal" %in% input$Loi) x <- rlnorm(N)
      if ("bimodale" %in% input$Loi) {
        y <- as.integer(runif(N)>0.5)
        x <- (1-y)+(y-0.5)/5*rchisq(N, 1)
      }
    for (i in 1:1000){
      moy=c(moy,mean(x[sample(1:N,input$N)]))
    }
    return(list(moy=moy,x=x))
  })
  
  output$histoX <- renderPlot({
    if ("gaussian" %in% input$Loi) hist(simu()$x, freq=FALSE,breaks=20,main="Histogramme de x", xlab="X",col="lightblue",xlim=c(-3,3))
    if ("chi2" %in% input$Loi) hist(simu()$x, freq=FALSE,breaks=20,main="Histogramme de x", xlab="X", col="lightblue",xlim=c(0,4))
    if ("uniform" %in% input$Loi) hist(simu()$x, freq=FALSE,breaks=20,main="Histogramme de x", xlab="X", col="lightblue",xlim=c(0,1))
    if ("lognormal" %in% input$Loi) hist(simu()$x, freq=FALSE,breaks=60,main="Histogramme de x", xlab="X", col="lightblue",xlim=c(0,10))
    if ("bimodale" %in% input$Loi) hist(simu()$x, freq=FALSE,breaks=20,main="Histogramme de x", xlab="X",col="lightblue",xlim=c(0,1))
    })
  output$histo <- renderPlot({
    if ("gaussian" %in% input$Loi) hist(simu()$moy, freq=FALSE,breaks=20,main=paste("Histogramme de la moyenne d'un échantillon de taille",input$N), xlab="Moyenne de x",col="lightblue",xlim=c(-3,3))
    if ("chi2" %in% input$Loi) hist(simu()$moy, freq=FALSE,breaks=20,main=paste("Histogramme de la moyenne d'un échantillon de taille",input$N), xlab="Moyenne de x",col="lightblue",xlim=c(0,4))
    if ("uniform" %in% input$Loi) hist(simu()$moy, freq=FALSE,breaks=20,main=paste("Histogramme de la moyenne d'un échantillon de taille",input$N), xlab="Moyenne de x",col="lightblue",xlim=c(0,1))
    if ("lognormal" %in% input$Loi) hist(simu()$moy, freq=FALSE,breaks=20,main=paste("Histogramme de la moyenne d'un échantillon de taille",input$N), xlab="Moyenne de x",col="lightblue",xlim=c(0,10))
    if ("bimodale" %in% input$Loi) hist(simu()$moy, freq=FALSE,breaks=20,main=paste("Histogramme de la moyenne d'un échantillon de taille",input$N), xlab="Moyenne de x",col="lightblue",xlim=c(0,1))
    if ("gaussian" %in% input$Loi) curve(dnorm(x,mean(simu()$moy),sd(simu()$moy)), from = -3, to = 3,add=TRUE,col="red")
    if ("chi2" %in% input$Loi) curve(dnorm(x,mean(simu()$moy),sd(simu()$moy)), from = 0, to = 4,add=TRUE,col="red")
    if ("uniform" %in% input$Loi) curve(dnorm(x,mean(simu()$moy),sd(simu()$moy)), from = 0, to = 1,add=TRUE,col="red")
    if ("lognormal" %in% input$Loi) curve(dnorm(x,mean(simu()$moy),sd(simu()$moy)), from = 0, to = 10,add=TRUE,col="red")
    if ("bimodale" %in% input$Loi) curve(dnorm(x,mean(simu()$moy),sd(simu()$moy)), from = 0, to = 1,add=TRUE,col="red")
  })
  output$tablo <- renderTable({
    if ("gaussian" %in% input$Loi) tab <- cbind.data.frame(Pop_Ech=c("Population","Echantillon"),Moyenne=rbind(0,mean(simu()$moy)),Variance=rbind(1/input$N,var(simu()$moy)))
    if ("chi2" %in% input$Loi) tab <- cbind.data.frame(Pop_Ech=c("Population","Echantillon"),Moyenne=rbind(1,mean(simu()$moy)),Variance=rbind(2/input$N,var(simu()$moy)))
    if ("uniform" %in% input$Loi) tab <- cbind.data.frame(Pop_Ech=c("Population","Echantillon"),Moyenne=rbind(0.5,mean(simu()$moy)),Variance=rbind(1/(12*input$N),var(simu()$moy)))
    if ("lognormal" %in% input$Loi) tab <- cbind.data.frame(Pop_Ech=c("Population","Echantillon"),Moyenne=rbind(exp(0.5),mean(simu()$moy)),Variance=rbind((exp(1)-1)*exp(1)/input$N,var(simu()$moy)))
    if ("bimodale" %in% input$Loi) tab <- cbind.data.frame(Pop_Ech=c("Population","Echantillon"),Moyenne=rbind(0.5,mean(simu()$moy)),Variance=rbind(NA,var(simu()$moy)))
  tab
  },digits=4)
})
