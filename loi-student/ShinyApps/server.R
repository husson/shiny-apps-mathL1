library(shiny)
library(ggplot2)
library(stringr)

shinyServer(function(input, output) {
  
  output$densite_student <- renderPlot({
    
    ddl <- input$slider_student_ddl
    
    k1 <- input$inputk1_student
    k2 <- input$inputk2_student
    
    validate(
      need(
        k1 <= k2,"Choisir k1 plus petit que k2"
      )
    )
    
    
    x = seq(-5,5,0.1)
    y = dt(x,ddl)
    
    
    xddf <- data.frame(x=x,y=y)
    qplot(x,y,data=xddf,geom="line") +
      
      geom_ribbon(data = subset(xddf ,x <= k2 & x>= k1), aes(ymax = y), ymin=0, fill="blue", colour=NA, alpha=0.5) +
      
      theme_minimal()
    
    
    
  })
  
  output$repartition_student <- renderPlot({
    
    ddl <- input$slider_student_ddl
    
    k1 <- input$inputk1_student
    k2 <- input$inputk2_student
    
    validate(
      need(
        k1 <= k2,"Choisir k1 plus petit que k2"
      )
    )
    
    x <- seq(-8,8,0.1)
    
    
    pk1 = pt(q = k1, ddl)
    pk2 = pt(q = k2, ddl)
    
    
    
    
    
    val <- pt(q = x,ddl)
    df <- data.frame(x,val)
    
    ggplot(df) + 
      aes(x = x, y = val) + 
      geom_line() +
      # segments pour k2
      geom_segment(aes(x = k2, y = 0, xend = k2, yend = pk2), color = "red", linetype="dashed") +
      geom_segment(aes(x = -10, y = pk2, xend = k2, yend = pk2), color = "red") + 
      # segments pour k1
      geom_segment(aes(x = k1, y = 0, xend = k1, yend = pk1), color = "blue", linetype="dashed") +
      geom_segment(aes(x = -10, y = pk1, xend = k1, yend = pk1), color = "blue") + 
      
      # flèche
      geom_segment(aes(x = 0, y = pk1, xend = 0, yend = pk2), arrow = arrow(length = unit(0.5, "cm"), ends = "both")) +
      
      # xlim(min(x),max(x)) + 
      theme_minimal()
    
  })
  
  output$text_esp_var_student <- renderUI({
    withMathJax(helpText("L'espérance et la variance d'une loi de student ont pour formule : 
                         $$
                         
                         E(X) = \\left\\{
                         \\begin{array}{ll}
                         forme \\ indéterminée                  & si & n \\leq 1 \\\\
                         
                         
                         
                         
                         
                         0 & si & n > 1
                         \\end{array}
                         \\right. 
                         
                         $$
                         
                         $$
                         V(X) = \\left\\{
                         \\begin{array}{ll}
                         
                         forme \\ indéterminée                  & si & n \\leq 1 \\\\
                         + \\infty & si & 1 < n \\leq 2 \\\\ 
                         \\frac{n}{n-2} & si & n > 2
                         
                         \\end{array}
                         \\right.
                         $$"))
  })
  
  output$moy_var_student <- renderUI({
    n <- input$slider_student_ddl
    
    if(n > 1){
      esp = ifelse(n > 1, 0, NA)
      var = round(ifelse(n > 2, n/(n+2), ifelse(n <= 1, NA, Inf)),3)
      str_glue("L'espérance de la loi vaut {esp} et la variance {var}.")
    } else {
      str_glue("L'espérance et la variance sont indéterminés")
    }
    
    
  })
  
  output$fonction_densite_student <- renderUI({
    
    withMathJax(helpText('
                         
                         $$
                         
                         
                         f_n (x) = \\frac{1}{\\sqrt{n \\pi}} \\frac{\\Gamma (\\frac{n+1}{2})}{\\frac{n}{2}} (1+ \\frac{x^2}{n})^{- \\frac{n+1}{2}}
                         
                         
                         
                         
                         
                         $$
                         
                         
                         '))
    
  })
  
  output$fonction_repartition_student <- renderUI({
    
    withMathJax(helpText('
                         
                         $$
                         
                         F_n (k) = \\int_{- \\infty}^{k} f_n (x) \\mathrm{d}x
                         
                         $$
                         
                         
                         '))
    
  })
  
  output$def_student <- renderUI({
    HTML(
      "La loi de Student à p degrés de liberté est une loi de probabilité, faisant intervenir le quotient entre une variable suivant une loi normale centrée réduite et la racine carrée d'une variable distribuée suivant une loi du Khi-2 à p degrés de liberté. Elle est notamment utilisée pour les tests de Student."
    )
    
    
  })
  output$formule_student <- renderUI({
    withMathJax(
      helpText(
        "$$
        
        
        f_n (x) = \\frac{1}{\\sqrt{n \\pi}} \\frac{\\Gamma (\\frac{n+1}{2})}{\\frac{n}{2}} (1+ \\frac{x^2}{n})^{- \\frac{n+1}{2}}
        
        
        
        
        
        $$
        "
      )
    )
  })
  
  
  output$calcu_proba_1_student <- renderUI({
    
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
  
  
  output$resu_calcu_student <- renderUI({
    n <- input$slider_student_ddl
    
    validate(need(input$inputk1_student <= input$inputk2_student, "Choisir k1 plus petit que k2"))
    
    
    k1 <- input$inputk1_student
    k2 <- input$inputk2_student
    
    proba <- round(ifelse(k1 == k2, 0, pt(k2,n) - pt(k1,n)),3)
    
    if(k1 == k2){
      withMathJax(sprintf("$$P( X = %g) = %g$$",k2,proba))
    }else{
      withMathJax(sprintf("$$P(%g < X \\leq %g) = %g$$", k1,k2,proba))
    }
    
    
  })
  
  
})