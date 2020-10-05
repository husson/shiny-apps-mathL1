library(shiny)
library(shinydashboard)
library(shinyjs)
library(shinyBS)

ui <- dashboardPage(skin = "green",
                    dashboardHeader(title = "Agrocampus Ouest"),
                    dashboardSidebar(disable = T),
                    dashboardBody(
                      h1("Loi Binomiale B(n,p)"),
                      fluidRow(
                        column(width = 4,
                               box(width = 12,
                                   
                                   div(
                                     style="display: inline-block;vertical-align:top; width: 69%;",
                                     sliderInput(
                                       "slider_binom_n",
                                       "Valeur de n :",
                                       min = 1,
                                       max = 30,
                                       value = 5)
                                   ),
                                   
                                   div(style="display: inline-block;vertical-align:top; width: 29%;",
                                       numericInput(
                                         "numeric_n",
                                         "",
                                         min = 1,
                                         max = 30,
                                         value = 5,
                                         step = 1
                                       )
                                   ),
                                   
                                   div(
                                     style="display: inline-block;vertical-align:top; width: 69%;",
                                     sliderInput(
                                       "slider_binom_p",
                                       "Valeur de p :",
                                       min = 0,
                                       max = 1,
                                       step = 0.001,
                                       value = 0.5
                                     )
                                   ),
                                   
                                   div(style="display: inline-block;vertical-align:top; width: 29%;",
                                       numericInput(
                                         "numeric_p",
                                         "",
                                         min = 0,
                                         max = 1,
                                         value = 0.5,
                                         step = 0.001
                                       )
                                   ),
                                   
                                   
                                   uiOutput("moy_var_binom")
                               ),
                               box(width = 12,
                                   title = "Calcul de P(k1 < X <= k2)",
                                   
                                   
                                   
                                   div(
                                     style="display: inline-block;vertical-align:top; width: 49%;",
                                     numericInput(inputId = "inputk1_binom",
                                                  label = "k1 :",
                                                  value = 0,
                                                  step = 1,
                                                  min = -1
                                     )
                                   ),
                                   
                                   div(style="display: inline-block;vertical-align:top; width: 49%;",
                                       numericInput(inputId = "inputk2_binom",
                                                    label = "k2 :",
                                                    value = 1,
                                                    step = 1,
                                                    min = 0
                                       )
                                   ),
                                   uiOutput("resu_calcu_binom")
                               )
                               
                               
                        ),
                        column(width = 4,
                               tabBox(width = 12,
                                      title = "",
                                      tabPanel("Loi de probabilité",
                                               plotOutput("densite_binom"),
                                               uiOutput("fonction_densite_binom")
                                      ),
                                      tabPanel("Répartition",
                                               plotOutput("repartition_binom"),
                                               uiOutput("fonction_repartition_binom")
                                      )
                               )
                        ),
                        
                        column(width = 4,
                               box(
                                 width = 12,
                                 collapsible = T,
                                 collapsed = T,
                                 title = "Cours",
                                 uiOutput("def_binom"),
                                 uiOutput("formule_binom"),
                                 uiOutput("text_esp_var_binom"),
                                 uiOutput("calcu_proba_1_binom")
                                 
                               ),
                               box(width = 12,
                                   collapsible = T,
                                   collapsed = T,
                                   title = "Pour s'entraîner",
                                   uiOutput("exercice_binom"),
                                   actionButton(
                                     inputId = "bouton_exo",
                                     label = "Afficher correction"
                                   ),
                                   conditionalPanel(
                                     condition = "input.bouton_exo % 2 != 0",
                                     uiOutput("correction_binom")
                                   )
                               )
                               
                        )
                      )
                    )
)