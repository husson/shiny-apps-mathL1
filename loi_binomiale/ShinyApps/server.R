library(shiny)
library(ggplot2)
library(stringr)

shinyServer(function(input, output, session) {
  
  output$densite_binom <- renderPlot({
    
    n <- input$slider_binom_n
    p <- input$slider_binom_p
    
    k1 <- input$inputk1_binom
    k2 <- input$inputk2_binom
    
    validate(
      need(
        k1 <= k2,"Choisir k1 plus petit que k2"
      )
    )
    
    x = seq(0,n+2,1)
    y = dbinom(x,n,p)
    

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
      
      theme_minimal() +
      
      theme(legend.position = "none" )
    

  })
  
  output$repartition_binom <- renderPlot({
    
    n <- input$slider_binom_n
    p <- input$slider_binom_p
    
    k1 <- input$inputk1_binom
    k2 <- input$inputk2_binom
    
    validate(
      need(
        k1 <= k2,"Choisir k1 plus petit que k2"
      )
    )
    
    x <- seq(-1,n+1,1)
    
    
    pk1 = pbinom(q = k1, n, p)
    pk2 = pbinom(q = k2, n, p)
    
    
    val <- pbinom(q = x, n,p)
    df <- data.frame(x,val)
    
    ggplot(df) + 
      aes(x = x, y = val) + 
      geom_step() +
      
      # segments pour k2
      geom_segment(aes(x = k2, y = 0, xend = k2, yend = pk2), color = "red", linetype="dashed") +
      geom_segment(aes(x = 0, y = pk2, xend = k2, yend = pk2), color = "red") +
      
      # segments pour k1
      geom_segment(aes(x = k1+1, y = 0, xend = k1+1, yend = pk1), color = "blue", linetype="dashed") +
      geom_segment(aes(x = 0, y = pk1, xend = k1, yend = pk1), color = "blue") +
      
      # flèche
      geom_segment(aes(x = 0, y = pk1, xend = 0, yend = pk2), arrow = arrow(length = unit(0.5, "cm"), ends = "both")) +
      
      theme_minimal()
    
  })
  
  output$text_esp_var_binom <- renderUI({
    withMathJax(helpText("L'espérance et la variance d'une loi binomiale ont pour formule : $$E(X) = np \\\\\\\\\\ V(X) = np(1-p)$$"))
  })
  
  output$moy_var_binom <- renderUI({
    
    esp = input$slider_binom_n*input$slider_binom_p
    var = input$slider_binom_n*input$slider_binom_p*(1-input$slider_binom_p)
    str_glue("L'espérance de la loi vaut {esp} et la variance {var}.")
    
  })
  
  output$fonction_densite_binom <- renderUI({
    
    withMathJax(helpText('
                       
                       $$
                       P(X = k) = C_n^k \\ p^k \\ (1-p)^{n-k}
                       $$
                       
                       
                       '))
    
  })
  
  output$fonction_repartition_binom <- renderUI({
    
    withMathJax(helpText('
                       
                       $$
                       
                       F(x) = \\left\\{
                       \\begin{array}{ll}
                       1 & si & x > n \\\\
                       \\sum_{i = 0}^{x} P(X = i) & si & 0 \\leq x \\leq n \\\\
                       0 & si & x < 0
                       \\end{array}
                       \\right.
                       
                       $$
                       
                       
                       '))
    
  })
  
  output$def_binom <- renderUI({
    HTML(
      "Une épreuve de Bernoulli est une expérience ayant 2 issues possibles : succès et échec, avec p la probabilité du succès (Pile ou Face, où p = 0.5).<br><br>La loi binomiale modélise le nombre de succès obtenus lors de la répétition indépendante de plusieurs épreuves de Bernoulli. <br><br>
    Cette loi de probabilité discrète est décrite par 2 paramètres : n le nombre d'expériences réalisées et p la probabilité du succès d'une expérience.<br><br>
    La variable aléatoire X compte le nombre de succès. Il est alors possible de calculer la probabilité d'obtenir k succès dans une répétition de n expériences :"
    )
    
    
    
    
  })
  output$formule_binom <- renderUI({
    withMathJax(
      helpText(
        "$$
      P(X = k) = C_n^k \\ p^k \\ (1-p)^{n-k}
      $$
      "
      )
    )
  })
  
  
  output$calcu_proba_1_binom <- renderUI({
    withMathJax(
      helpText(
        
        "Pour calculer les probabilités, il faut connaître la fonction de répartition :
      $$ P(X \\leq k) = \\sum_{i = 0}^{k} P(X = i) = F(k)$$
      Également : $$P(k1 < X \\leq k2) = F(k2) - F(k1)$$
      (voir graphique - Répartition)
      "
        
        
      )
    )
    
  })
  
  
  output$resu_calcu_binom <- renderUI({
    n <- input$slider_binom_n
    p <- input$slider_binom_p
    
    validate(need(input$inputk1_binom <= input$inputk2_binom, "Choisir k1 plus petit que k2"))
    
    
    k1 <- input$inputk1_binom
    k2 <- input$inputk2_binom
    
    proba <- ifelse(k1 == k2, dbinom(k1,n,p), pbinom(k2,n,p) - pbinom(k1,n,p))
    
    if(k1 == k2){
      withMathJax(sprintf("$$P(X = %g) = %g$$",k2,round(proba,4)))
    }else{

      withMathJax(sprintf("$$P(%g < X \\leq %g) = %g$$", k1,k2,round(proba,3)))
    }
    
    
  })
  
  
  output$exercice_binom <- renderUI({
    HTML("
       Exercice 1: <br> <br>
       On lance une pièce équilibrée 10 fois. La probabilité de faire Pile est égale à la probabilité de faire Face (0.5). <br><br>
       1) Quelle est la probabilité de faire strictement plus de 7 faces ? <br>
       2) Quelle est la probabilité de faire entre 1 et 5 piles ? <br>
       3) Quelle est la probabilité de faire exactement 10 faces ? <br><br>
       Exercice 2: <br><br>
       On joue au Yam's avec cinq dés équilibrés à 6 faces. Au premier lancer des 5 dés : <br><br>
       1) Quelle est la probabilité de ne faire aucun six ? <br>
       2) Quelle est la probabilité de faire entre 1 et 3 six en un seul lancer ? <br>
       3) Quelle est la probabilité de faire un Yam's (obtenir 5 six en un lancer) ? <br><br>
       ")
  })
  
  output$correction_binom <- renderUI({
    HTML("
       <h1> CORRECTION </h1> <br>
       Exercice 1 : <br>
       1) 1 - P(X < 7) = 1 - P(X <= 7) = 0.055 <br>
       2) P(1 <= X <= 5) = P(0 < X <= 5) = 0.622 <br>
       3) P(X = 10) = 0.001 <br><br>
Exercice 2 : <br>
1) P(X = 0) = 0.401 <br>
2) P(1 <= X <= 3) = 0.596 <br>
3) P(X = 5) = 0.0001 <br>
       
       
       ")
  })
  
  
  
  observe({
    
    updateSliderInput(
      session = session,
      inputId = "slider_binom_p",
      value = input$numeric_p
    )
  })
  
  
  observe({
    
    updateSliderInput(
      session = session,
      inputId = "numeric_p",
      value = input$slider_binom_p
    )
  })
  
  
  observe({
    
    updateSliderInput(
      session = session,
      inputId = "slider_binom_n",
      value = input$numeric_n
    )
  })
  
  
  observe({
    
    updateSliderInput(
      session = session,
      inputId = "numeric_n",
      value = input$slider_binom_n
    )
  })
  
  
})