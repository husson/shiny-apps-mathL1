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

shinyServer(function(input, output) {
  
  output$densite_uniforme <- renderPlot({
    
    vmin <- input$slider_uniforme_minmax[1]
    vmax <- input$slider_uniforme_minmax[2]

    k1 <- input$inputk1
    k2 <- input$inputk2
    
    validate(
      need(
        k1 <= k2,"Choisir k1 plus petit que k2"
      )
    )
    
    
    x <- seq((vmin-3),(vmax+3),0.01)
    y <- ifelse(x >= vmin & x <= vmax,1/(-vmin+vmax),0)
    xddf <- data.frame(x=x,y=y)
    qplot(x,y,data=xddf,geom="line") +
      geom_ribbon(data=subset(xddf ,x <= k2 & x>= k1 & x > vmin),aes(ymax=y),ymin=0,
                  fill="blue",colour=NA,alpha=0.5) +
      scale_y_continuous(limits=c(0, 1.1)) +
      theme_minimal()

  })
  
  output$repartition_uniforme <- renderPlot({
    
    vmin <- input$slider_uniforme_minmax[1]
    vmax <- input$slider_uniforme_minmax[2]
    
    k1 <- input$inputk1
    k2 <- input$inputk2
    
    validate(
      need(
        k1 <= k2,"Choisir k1 plus petit que k2"
      )
    )
    
    pk1 = punif(q = k1, input$slider_uniforme_minmax[1], input$slider_uniforme_minmax[2])
    pk2 = punif(q = k2, input$slider_uniforme_minmax[1], input$slider_uniforme_minmax[2])
      
    
    
    
    
    x <- seq((vmin-3),(vmax+3),0.01)
    val <- punif(q = x, vmin, vmax)
    
    
    
    
    df <- data.frame(x,val)
    ggplot(df) + 
      aes(x = x, y = val) + 
      geom_line() +
      # segments pour k2
      geom_segment(aes(x = k2, y = 0, xend = k2, yend = pk2), color = "red") +
      geom_segment(aes(x = vmin, y = pk2, xend = k2, yend = pk2), color = "red") + 
      # segments pour k1
      geom_segment(aes(x = k1, y = 0, xend = k1, yend = pk1), color = "blue") +
      geom_segment(aes(x = vmin, y = pk1, xend = k1, yend = pk1), color = "blue") + 
      ylim(-0.2,1) + 
      xlim(min(x),max(x)) + 
      theme_minimal()
    
  })
  
  output$text_esp_var_uniforme <- renderUI({
    withMathJax(helpText("L'espérance et la variance d'une loi uniforme ont pour formule : $$E(X) = \\frac{a+b}{2} \\\\\\\\\\ V(X) = \\frac{(b-a)^2}{12}$$"))
  })
  
  output$moy_var_uniforme <- renderUI({
    
    esp = round((input$slider_uniforme_minmax[1] + input$slider_uniforme_minmax[2])/2,1)
    var = round((input$slider_uniforme_minmax[2] - input$slider_uniforme_minmax[1])**2/12,1)
    str_glue("L'espérance de la loi vaut {esp} et la variance {var}.")
    
  })
  
  output$fonction_densite <- renderUI({
    
    withMathJax(helpText('
                         
                         $$
                         f(x) = \\left\\{
                         \\begin{array}{ll}
                         \\frac{1}{b-a} & pour & a \\leq x \\leq b\\\\\\\
                         0 & \\mbox{sinon.}
                         \\end{array}
                         \\right.
                         $$
                         
                         
                         '))
    
                         })
  
  output$fonction_repartition <- renderUI({
    
    withMathJax(helpText('
                         
                         $$
                         F(x) = \\left\\{
                         \\begin{array}{ll}
                         0 & pour & x < a \\\\\
                         \\frac{x-a}{b-a} & pour & a \\leq x \\leq b \\\\\\\
                         1 & pour & x > b \\
                         \\end{array}
                         \\right.
                         $$
                         
                         
                         '))
  
})

output$def_uniforme <- renderUI({
  withMathJax(
    helpText('Une loi de probabilité est dite uniforme sur un intervalle [a;b] si sa densité de probabilité est la fonction f définie sur [a;b] telle que
             $$
             f(x) = \\left\\{
             \\begin{array}{ll}
             \\frac{1}{b-a} & pour & a \\leq x \\leq b\\\\\\\
             0 & \\mbox{sinon.}
             \\end{array}
             \\right.
             $$'))
  
  
  
})


output$calcu_proba_1 <- renderUI({
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


output$resu_calcu <- renderUI({
  k1 <- input$inputk1
  k2 <- input$inputk2
  
  validate(
    need(
      k1 <= k2,"Choisir k1 plus petit que k2"
    )
  )
  
  proba = punif(q = k2, input$slider_uniforme_minmax[1], input$slider_uniforme_minmax[2]) - punif(q = k1, input$slider_uniforme_minmax[1], input$slider_uniforme_minmax[2])
  withMathJax(sprintf("$$P(%g < X \\leq %g) = %g$$", k1,k2,round(proba,3)))
  
  
})

output$exercice_unif <- renderUI({
  HTML("Exercice 1 : <br> On note X le temps d'attente, en minutes, avant l'arrrivée du métro dans une certaine station et on suppose que X suit la loi uniforme sur [0;6]. <br> <br>
  1) Quelle est la probabilité que le temps d'attente soit compris entre 2 et 5 minutes ? <br>
  2) Quelle est la probabilité que le temps d'attente soit supérieur à 4 minutes ?<br>
  3) Quel est le temps d'attente moyen dans cette station ? <br> <br> <br>
  Exercice 2: <br> Dans un supermarché, le temps d'attente X à la caisse, exprimé en minutes, suit la loi uniforme sur l'intervalle [1;11]. <br> <br>
  1) Quelle est la probabilité que le temps d'attente soit compris entre 3 et 5 minutes ? <br>
  2) Quelle est la probabilité qu'un client attende plus de 8 minutes à la caisse ? <br>
  3) Préciser le temps d'attente moyen à la caisse. <br><br><br><br>
  ")
})

output$correction_unif <- renderUI({
  HTML("
  <h1> CORRECTION </h1> <br> <br>
  Exercice 1 : <br> <br>
       1) P(2 < X < 5) = 0.5. <br>
       2) P(X > 4) = P(4 < X < 6) = 0.33. <br>
       3) Il faut ici calculer l'espérance de X, qui vaut ici (6+0)/2 = 3. Le temps d'attente moyen est donc de 3 minutes. <br> <br>
       Exercice 2 : <br> <br>
       1) P(3 < X < 5) = 0.2 <br>
       2) P(X > 8) = P(8 < X < 11) = 0.3. <br>
       3) Il faut ici calculer l'espérance de X, qui vaut ici (1+11)/2 = 6. Le temps d'attente moyen est donc de 6 minutes.
  ")
})

})
