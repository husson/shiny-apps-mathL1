library(shiny)
library(ggplot2)
library(stringr)

shinyServer(function(input, output) {
  output$densite_khi <- renderPlot({
    
    ddl <- input$slider_khi_ddl
    
    k1 <- input$inputk1_khi
    k2 <- input$inputk2_khi
    
    validate(
      need(
        k1 <= k2,"Choisir k1 plus petit que k2"
      )
    )
    
    largeur <- ifelse(ddl < 5, 15,ddl*3)
    
    x = seq(0,largeur,0.1)
    y = dchisq(x,ddl)
    
    
    xddf <- data.frame(x=x,y=y)
    qplot(x,y,data=xddf,geom="line") +
      
      geom_ribbon(data = subset(xddf ,x <= k2 & x>= k1), aes(ymax = y), ymin=0, fill="blue", colour=NA, alpha=0.5) +
      
      theme_minimal()
    
    
    
  })
  
  output$repartition_khi <- renderPlot({
    
    ddl <- input$slider_khi_ddl
    
    k1 <- input$inputk1_khi
    k2 <- input$inputk2_khi
    
    validate(
      need(
        k1 <= k2,"Choisir k1 plus petit que k2"
      )
    )
    largeur <- ifelse(ddl < 5, 15,ddl*3)
    
    x <- seq(-1,largeur+1,0.1)
    
    
    pk1 = pchisq(q = k1, ddl)
    pk2 = pchisq(q = k2, ddl)
    
    
    
    
    
    val <- pchisq(q = x,ddl)
    df <- data.frame(x,val)
    
    ggplot(df) + 
      aes(x = x, y = val) + 
      geom_line() +
      # segments pour k2
      geom_segment(aes(x = k2, y = 0, xend = k2, yend = pk2), color = "red", linetype="dashed") +
      geom_segment(aes(x = 0, y = pk2, xend = k2, yend = pk2), color = "red") + 
      # segments pour k1
      geom_segment(aes(x = k1, y = 0, xend = k1, yend = pk1), color = "blue", linetype="dashed") +
      geom_segment(aes(x = 0, y = pk1, xend = k1, yend = pk1), color = "blue") +
      
      # flèche
      geom_segment(aes(x = 0, y = pk1, xend = 0, yend = pk2), arrow = arrow(length = unit(0.5, "cm"), ends = "both")) +
      
      # xlim(min(x),max(x)) + 
      theme_minimal()
    
  })
  
  output$text_esp_var_khi <- renderUI({
    withMathJax(helpText("L'espérance et la variance d'une loi de khi ont pour formule : $$E(X) = n \\\\\\\\\\ V(X) = 2n $$ "))
  })
  
  output$moy_var_khi <- renderUI({
    
    esp = input$slider_khi_ddl
    var = 2*input$slider_khi_ddl
    str_glue("L'espérance de la loi vaut {esp} et la variance {var}.")
    
  })
  
  output$fonction_densite_khi <- renderUI({
    
    withMathJax(helpText('
                       
                       $$
                       
                       
                       f_n (x) = \\left\\{
                       \\begin{array}{ll}
                       \\frac{1}{2^{\\frac{n}{2}} \\Gamma (n/2)} e^{\\frac{-x}{2}} x^{\\frac{n}{2}-1}                  & si & x > 0 \\\\
                       
                       
                       
                       
                       
                       0 & sinon
                       \\end{array}
                       \\right.
                       
                       
                       
                       
                       
                       $$
                       
                       
                       '))
    
  })
  
  output$fonction_repartition_khi <- renderUI({
    
    withMathJax(helpText('
                       
                       $$
                       
                       F_n (x) = \\int_{- \\infty}^{x} f_n (t) \\mathrm{d}t
                       
                       $$
                       
                       
                       '))
    
  })
  
  output$def_khi <- renderUI({
    HTML(
      "La somme de carrés de variables indépendantes suivant une loi normale centrée réduite suit une loi du Khi-2 à n degrés de liberté. Cette propriété fonde les tests statistiques du khi-2."
    )
    
    
    
    
  })
  output$formule_khi <- renderUI({
    withMathJax(
      helpText(
        "$$
      
      
      f(x) = \\left\\{
      \\begin{array}{ll}
      \\frac{1}{2^{\\frac{n}{2}} \\Gamma (n/2)} e^{\\frac{-x}{2}} x^{\\frac{n}{2}-1}                  & si & x > 0 \\\\
      
      
      
      
      
      0 & sinon
      \\end{array}
      \\right.
      
      
      
      
      
      $$
      "
      )
    )
  })
  
  
  output$calcu_proba_1_khi <- renderUI({
    
    withMathJax(
      helpText(
        
        "Pour calculer les probabilités, il faut connaître les formules :
      $$ P(X \\leq k) = \\int_{-\\infty}^{k}  f(x) \\mathrm{d}x = F(k)$$
      Également : $$P(k1 < X \\leq k2) = F(k2) - F(k1)$$
      (voir graphique - Répartition)
      "
        
        
      )
    )
    
  })
  
  
  output$resu_calcu_khi <- renderUI({
    n <- input$slider_khi_ddl
    
    validate(need(input$inputk1_khi <= input$inputk2_khi, "Choisir k1 plus petit que k2"))
    
    
    k1 <- input$inputk1_khi
    k2 <- input$inputk2_khi
    
    proba <- round(ifelse(k1 == k2, 0, pchisq(k2,n) - pchisq(k1,n)),3)
    
    if(k1 == k2){
      withMathJax(sprintf("$$P(X = %g) = %.00f$$",k2,proba))
    }else{
      withMathJax(sprintf("$$P(%g < X \\leq %g) = %g$$", k1,k2,proba))
    }
    
    
  })
  
  
})