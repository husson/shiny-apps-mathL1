library(shiny)
library(ggplot2)
library(stringr)

shinyServer(function(input, output) {
  
  output$densite_poisson <- renderPlot({
    
    lambda <- input$slider_poisson_lambda
    
    k1 <- input$inputk1_poisson
    k2 <- input$inputk2_poisson
    
    validate(
      need(
        k1 <= k2,"Choisir k1 plus petit que k2"
      )
    )
    
    largeur <- ifelse(lambda < 5, lambda*3,lambda*2)
    
    x = seq(0,largeur,1)
    y = dpois(x,lambda)
    
    if(k1 == k2){
      
      inout <- ifelse(x == k1,"TRUE","FALSE")
      
    } else {
      
      inout <- ifelse(x <= k2 & x > k1,"TRUE","FALSE")
      
    }
    
    xdd <- data.frame(x = as.factor(x),
                      y = y,
                      type = inout)
    
    ggplot(xdd, aes(x = x, y = y, fill = type)) + 
      geom_bar(stat = "identity", width = 0.1) + 
      scale_y_continuous(expand = c(0.01, 0)) +
      scale_fill_manual(values=c("#000000", "#E69F00")) +
      theme(legend.position='none') +
      theme_minimal() +
      theme(legend.position = "none" )
    
    
    
  })
  
  output$repartition_poisson <- renderPlot({
    
    lambda <- input$slider_poisson_lambda
    
    k1 <- input$inputk1_poisson
    k2 <- input$inputk2_poisson
    
    validate(
      need(
        k1 <= k2,"Choisir k1 plus petit que k2"
      )
    )
    
    largeur <- ifelse(lambda < 5, lambda*6,lambda*2.5)
    
    x <- seq(-1,largeur+1,1)
    
    
    pk1 = ppois(q = k1, lambda)
    pk2 = ppois(q = k2, lambda)
    
    
    
    
    
    y <- ppois(q = x,lambda)
    df <- data.frame(x,y)
    
    ggplot(df) + 
      aes(x = x, y = y) + 
      geom_step() +
      # segments pour k2
      geom_segment(aes(x = k2, y = 0, xend = k2, yend = pk2), color = "red", linetype="dashed") +
      geom_segment(aes(x = 0, y = pk2, xend = k2, yend = pk2), color = "red") + 
      # segments pour k1
      geom_segment(aes(x = k1, y = 0, xend = k1, yend = pk1), color = "blue", linetype="dashed") +
      geom_segment(aes(x = 0, y = pk1, xend = k1, yend = pk1), color = "blue") + 
      
      # flèche
      geom_segment(aes(x = 0, y = pk1, xend = 0, yend = pk2), arrow = arrow(length = unit(0.5, "cm"), ends = "both")) +
      
      theme_minimal()
    
  })
  
  output$text_esp_var_poisson <- renderUI({
    withMathJax(helpText("L'espérance et la variance d'une loi de Poisson ont pour formule : $$E(X) = V(X) = \\lambda $$"))
  })
  
  output$moy_var_poisson <- renderUI({
    
    esp = input$slider_poisson_lambda
    var = input$slider_poisson_lambda
    str_glue("L'espérance de la loi vaut {esp} et la variance {var}.")
    
  })
  
  output$fonction_densite_poisson <- renderUI({
    
    withMathJax(helpText('
                         
                         $$
                         P(X = k) = \\frac{\\lambda^k}{k!} e^{- \\lambda}
                         $$
                         
                         
                         '))
    
  })
  
  output$fonction_repartition_poisson <- renderUI({
    
    withMathJax(helpText('
                         
                         $$
                         
                         F(k) =
                         \\sum_{i = 0}^{k} P(X = i)
                         
                         
                         $$
                         
                         
                         '))
    
  })
  
  output$def_poisson <- renderUI({
    HTML(
      "La loi de Poisson est une loi de probabilité discrète qui décrit le comportement du nombre d'événements se produisant dans un intervalle de temps fixé :"
    )
    
    
    
    
  })
  output$formule_poisson <- renderUI({
    withMathJax(
      helpText(
        "$$
        P(X = k) = \\frac{\\lambda^k}{k!} e^{- \\lambda}
        $$
        "
      )
    )
  })
  
  
  output$calcu_proba_1_poisson <- renderUI({
    withMathJax(
      helpText(
        
        "Pour calculer les probabilités, il faut connaître les formules :
        $$ P(X \\leq k) = \\sum_{i = 0}^{k} P(X = i) = F(k)$$
        Également : $$P(k1 < X \\leq k2) = F(k2) - F(k1)$$
        (voir graphique - Répartition)
        "
        
        
      )
    )
    
  })
  
  
  output$resu_calcu_poisson <- renderUI({
    lambda <- input$slider_poisson_lambda
    
    validate(
      need(
        input$inputk1_poisson <= input$inputk2_poisson, "Choisir k1 plus petit que k2"
        )
      )
    
    
    k1 <- input$inputk1_poisson
    k2 <- input$inputk2_poisson
    
    proba <- ifelse(k1 == k2, dpois(k1,lambda), ppois(k2,lambda) - ppois(k1,lambda))
    
    if(k1 == k2){
      withMathJax(sprintf("$$P( X = %.00f) = %.03f$$",k2,proba))
    }else{
      withMathJax(sprintf("$$P(%.00f < X \\leq %.00f) = %.03f$$", k1,k2,proba))
    }
    
    
  })
  
  
  output$exercice_poisson <- renderUI({
    HTML("Une société constate en moyenne 3 accidents du travail par an. L’effectif total est relativement élevé, aussi considère-t-on que le nombre d’accidents suit une loi de Poisson de paramètre λ = 3. <br><br>
         1) Quelle est la probabilité d'observer strictement plus de 4 accident cette année ? <br>
         2) Quelle est la probabilité d'observer entre 5 et 8 accidents cette année ? <br>
         3) Quelle est la probabilité de faire 0 accident ? <br><br><br>
         ")
  })
  
  output$correction_poisson <- renderUI({
    HTML("
         <h1> CORRECTION </h1> <br>
         1) 1 - P(-1 < X <= 4) = 0.185 <br>
         2) P(4 < X <= 8) = 0.181 <br>
         3) P(X = 0) = 0.050 <br>
         ")
  })
  
})