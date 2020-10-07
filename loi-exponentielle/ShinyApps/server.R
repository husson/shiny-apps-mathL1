#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)
library(stringr)

shinyServer(function(input, output, session) {
  
  ##############################################################
  ######################## LOI EXPONEN #########################
  ##############################################################
  
  
  
  
  
  
  output$densite_expo <- renderPlot({
    
    validate(need(input$input_lambda_expo > 0, "Lambda doit être supérieur à 0"))
    
    lambda <- input$input_lambda_expo
    
    k1 <- input$inputk1_expo
    k2 <- input$inputk2_expo
    
    validate(
      need(
        k1 <= k2,"Choisir k1 plus petit que k2"
      )
    )
    
    
    x <- seq(0,(1/lambda)+10,0.01)
    
    y <- lambda*exp(-lambda*x)
    
    xddf <- data.frame(x=x,y=y)
    qplot(x,y,data=xddf,geom="line") +
      
      geom_ribbon(data = subset(xddf ,x <= k2 & x>= k1), aes(ymax = y), ymin=0, fill="blue", colour=NA, alpha=0.5) +
      
      theme_minimal()
    
  })
  
  output$repartition_expo <- renderPlot({
    
    validate(need(input$input_lambda_expo > 0, "Lambda doit être supérieur à 0"))
    
    lambda <- input$input_lambda_expo
    
    k1 <- input$inputk1_expo
    k2 <- input$inputk2_expo
    
    validate(
      need(
        k1 <= k2,"Choisir k1 plus petit que k2"
      )
    )
    
    
    x <- seq(0,lambda+5,0.01)
    
    
    pk1 = pexp(q = k1, input$input_lambda_expo)
    pk2 = pexp(q = k2, input$input_lambda_expo)
    
    
    
    
    
    val <- pexp(q = x, lambda)
    
    
    
    
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
  
  output$text_esp_var_expo <- renderUI({
    validate(need(input$input_lambda_expo > 0, "Lambda doit être supérieur à 0"))
    
    withMathJax(helpText("L'espérance et la variance d'une loi exponentielle ont pour formule : $$E(X) = \\frac{1}{\\lambda} \\\\\\\\\\ V(X) = \\frac{1}{\\lambda^2}$$"))
  })
  
  output$moy_var_exponentielle <- renderUI({
    validate(need(input$input_lambda_expo > 0, "Lambda doit être supérieur à 0"))
    
    
    esp = round(1/input$input_lambda_expo,2)
    var = round(1/(input$input_lambda_expo**2),3)
    str_glue("L'espérance de la loi vaut {esp} et la variance {var}.")
    
  })
  
  output$fonction_densite_expo <- renderUI({
    
    withMathJax(helpText('
                         
                         $$
                         f_{\\lambda} (x) = \\left\\{
                         \\begin{array}{ll}
                         \\lambda e^{-\\lambda x} & si & x \\geq 0 \\\\
                         0 & si & x < 0
                         \\end{array}
                         \\right.
                         $$
                         
                         
                         '))
    
  })
  
  output$fonction_repartition_expo <- renderUI({
    
    withMathJax(helpText('
                         
                         $$
                         F_{\\lambda} (x) = \\left\\{
                         \\begin{array}{ll}
                         1 - e^{-\\lambda x} & si & x \\geq 0 \\\\
                         0 & si & x < 0
                         \\end{array}
                         \\right.
                         $$
                         
                         
                         '))
    
  })
  
  output$def_expo <- renderUI({
    withMathJax(
      helpText('Une loi de probabilité est dite exponentielle si sa densité de probabilité est la fonction f telle que :
               $$
               f_{\\lambda} (x) = \\left\\{
               \\begin{array}{ll}
               \\lambda e^{-\\lambda x} & si & x \\geq 0\\\\\\\
               0 & si & x < 0
               \\end{array}
               \\right.
               $$'))
    
    
    
  })
  
#   output$sans_memoire <- renderUI({
#     withMathJax(
#       helpText(
#         
#         "La loi exponentielle est une loi sans mémoire. Cette propriété se traduit par :
# $$ \\forall s,t \\geq 0 & P_{T > t} (T > s+t) = P(T > s)) $$
#                
#                ")
#     )
#     
#     
#     
#   })
  
  output$sans_memoire <- renderUI({
    withMathJax(
      helpText(
        "La loi exponentielle est une loi sans mémoire. Cette propriété se traduit par :
$$ \\forall{s,t} \\geq 0, P_{T>t}(T > s + t) = P(T > s) $$
               
               "
        
        
      )
    )
  })
  
  
  output$calcu_proba_1_expo <- renderUI({
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
  
  
  output$resu_calcu_expo <- renderUI({
    
    validate(need(input$input_lambda_expo > 0, "Lambda doit être supérieur à 0"))
    validate(need(input$inputk1_expo <= input$inputk2_expo, "Choisir k1 plus petit que k2"))
    
    
    k1 = input$inputk1_expo
    k2 = input$inputk2_expo
    
    proba = pexp(q = k2, input$input_lambda_expo) - pexp(q = k1, input$input_lambda_expo)
    
    if(k1 == k2){
      withMathJax(sprintf("$$P(X = %g) = %.03f$$",k2,0))
    }else{
      withMathJax(sprintf("$$P(%g < X \\leq %g) = %.03f$$", k1,k2,proba))
    }
    
    
  })
  
  output$exercice_expo <- renderUI({
    HTML("La durée (en minutes) d'une conversation téléphonique de Mme X est une variable aléatoire qui suit une loi exponentielle de paramètre 0.3. <br> <br>
         1) Quelle est la probabilité d'observer une conversation de plus de 5 minutes ? <br>
         2) Quelle est la probabilité d'observer une conversation durant entre 1 et 3 minutes ? <br>
         3) Sachant que l'appel dure depuis déjà 5 minutes, quelle est la probabilité que la conversation se poursuive jusqu'à 9 minutes ? <br>
         4) Quelle est la durée moyenne d'une conversation téléphonique de Mme X ? <br> <br> <br>

         ")
  })
  
  output$correction_expo <- renderUI({
    HTML("
         <h1> CORRECTION </h1> <br> <br>
         1) 1 - P(0 < X < 5) = 1 - 0.777 = 0.223. <br>
         2) P(1 < X < 3) = 0.334. <br>
         3) P(X > 4) = 1 - P(0 < X < 4) = 1 - 0.699 = 0.301 (loi sans mémoire)<br>
         4) 3.33 minutes. <br> <br>
         
         ")
  })
  
  observe({
    
    updateSliderInput(
      session = session,
      inputId = "input_lambda_expo",
      value = input$numeric_lambda
    )
  })
  
  
  observe({
    
    updateSliderInput(
      session = session,
      inputId = "numeric_lambda",
      value = input$input_lambda_expo
    )
  })
  
})
