library(shiny)
library(ggplot2)
library(stringr)

shinyServer(function(input, output) {
  
  output$densite_fisher <- renderPlot({
    
    ddl1 <- input$slider_fisher_ddl1
    ddl2 <- input$slider_fisher_ddl2
    

    k1 <- input$inputk1_fisher
    k2 <- input$inputk2_fisher
    
    validate(
      need(
        k1 <= k2,"Choisir k1 plus petit que k2"
      )
    )
    
    x = seq(0,10,0.1)
    y = df(x,ddl1,ddl2)
    
    
    xddf <- data.frame(x=x,y=y)
    qplot(x,y,data=xddf,geom="line") +
      
      geom_ribbon(data = subset(xddf ,x <= k2 & x>= k1), aes(ymax = y), ymin=0, fill="blue", colour=NA, alpha=0.5) +
      
      theme_minimal()
    
    
    
  })
  
  output$repartition_fisher <- renderPlot({
    
    ddl1 <- input$slider_fisher_ddl1
    ddl2 <- input$slider_fisher_ddl2
    
    k1 <- input$inputk1_fisher
    k2 <- input$inputk2_fisher
    
    validate(
      need(
        k1 <= k2,"Choisir k1 plus petit que k2"
      )
    )
    
    x <- seq(0,15,0.1)
    
    
    pk1 = pf(q = k1, ddl1, ddl2)
    pk2 = pf(q = k2, ddl1, ddl2)
    
    
    
    
    
    val <- pf(q = x,ddl1, ddl2)
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
      geom_segment(aes(x = -5, y = pk1, xend = -5, yend = pk2), arrow = arrow(length = unit(0.5, "cm"), ends = "both")) +
      
      # xlim(min(x),max(x)) + 
      theme_minimal()
    
  })
  
  output$text_esp_var_fisher <- renderUI({
    withMathJax(helpText("L'espérance et la variance d'une loi de fisher ont pour formule : 
                       $$
                       Si \\ n_1 > 2 : \\
                       E(X) = \\frac{n_2}{n_2 - 2}
                       
                       $$
                       
                       $$
                       Si \\ n_2 > 4 : \\
                       V(X) = \\frac{2 n_2^2 (n_1 + n_2 -2)}{n_1 (n_2 -2)^2 (n_2 -4)}
                       $$"))
  })
  
  output$moy_var_fisher <- renderUI({
    ddl1 <- input$slider_fisher_ddl1
    ddl2 <- input$slider_fisher_ddl2
    
    if(ddl1 > 2 & ddl2 > 4){
      esp = round(ifelse(ddl1 > 0 & ddl2 > 0, ddl2/(ddl2-2), NA),2)
      var = round(ifelse(ddl2 >= 5, (2*ddl2**2*(ddl1 + ddl2 -2))/(ddl1 * (ddl2 - 2)**2 * (ddl2-4)), NA),2)
      
      str_glue("L'espérance de la loi vaut {esp} et la variance {var}.")
    } else if(ddl1 < 2 & ddl2 > 4){
      
      var = round(ifelse(ddl2 >= 5, (2*ddl2**2*(ddl1 + ddl2 -2))/(ddl1 * (ddl2 - 2)**2 * (ddl2-4)), NA),2)
      
      str_glue("L'espérance de la loi est indéterminée et la variance vaut {var}.")
      
    } else if(ddl1 > 2 & ddl2 <= 4){
      esp = round(ifelse(ddl1 > 0 & ddl2 > 0, ddl2/(ddl2-2), NA),2)
      
      str_glue("L'espérance de la loi vaut {esp} et la variance de cette loi est indéterminée.")
    } else if(ddl1 <= 2 & ddl2 <= 4){
      
      str_glue("L'espérance et la variance de la loi sont indéterminées.")
    }
    
    
    
  })
  
  output$fonction_densite_fisher <- renderUI({
    
    withMathJax(helpText('
                       
                       $$
                       
                       
                       f_{n1,n2} (x) = \\frac{(\\frac{n_1 x}{n_1 x + n_2})^{n_1/2} (1 - \\frac{n_1 x}{n_1 x + n_2}) ^{n_2/2}}
                       {x B(n_1/2,n_2/2)}
                       
                       
                       
                       
                       
                       $$
                       
                       
                       '))
    
  })
  
  output$fonction_repartition_fisher <- renderUI({
    
    withMathJax(helpText('
                       
                       $$
                       
                       F_{n1,n2} (k) = \\int_{- \\infty}^{k} f_{n1,n2} (x) \\mathrm{d}x
                       
                       $$
                       
                       
                       '))
    
  })
  
  output$def_fisher <- renderUI({
    HTML(
      "La loi de Fisher est une loi de probabilité continue qui survient très fréquemment en tant que loi de la statistique de test, dans des tests de ratio de vraisemblance ou dans l'analyse de la variance (ANOVA) via le test de Fisher.")
    
    
    
    
  })
  output$formule_fisher <- renderUI({
    withMathJax(
      helpText(
        "$$
      
      
      f_{n1,n2} (x) = \\frac{(\\frac{n_1 x}{n_1 x + n_2})^{n_1/2} (1 - \\frac{n_1 x}{n_1 x + n_2}) ^{n_2/2}}
      {x B(n_1/2,n_2/2)}
      
      
      
      
      
      $$
      "
      )
    )
  })
  
  
  output$calcu_proba_1_fisher <- renderUI({
    
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
  
  
  output$resu_calcu_fisher <- renderUI({
    ddl1 <- input$slider_fisher_ddl1
    ddl2 <- input$slider_fisher_ddl2
    
    validate(need(input$inputk1_fisher <= input$inputk2_fisher, "Choisir k1 plus petit que k2"))
    
    
    k1 <- input$inputk1_fisher
    k2 <- input$inputk2_fisher
    
    proba <- round(ifelse(k1 == k2, 0, pf(k2,ddl1,ddl2) - pf(k1,ddl1,ddl2)),3)
    
    if(k1 == k2){
      withMathJax(sprintf("$$P( X = %g) = %g$$",k2,proba))
    }else{
      withMathJax(sprintf("$$P(%g < X \\leq %g) = %g$$", k1,k2,proba))
    }
    
    
  })
  
})