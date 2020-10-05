library(shiny)
library(shinydashboard)
library(shinyjs)
library(shinyBS)

ui <- dashboardPage(skin = "green",
                    dashboardHeader(title = "Agrocampus Ouest"),
                    dashboardSidebar(disable = T),
                    dashboardBody(
                      h1("Loi de Poisson P(λ)"),
                      fluidRow(
                        column(width = 4,
                               
                               box(width = 12,
                                   sliderInput(
                                     "slider_poisson_lambda",
                                     "Valeur de λ :",
                                     min = 1,
                                     max = 25,
                                     value = 5),
                                   uiOutput("moy_var_poisson")
                               ),
                               box(width = 12,
                                   title = "Calcul de P(k1 < X <= k2)",
                                   div(style="display: inline-block;vertical-align:top; width: 49%;",
                                       
                                       numericInput(inputId = "inputk1_poisson",
                                                    label = "k1 :",
                                                    value = 0,
                                                    step = 1,
                                                    min = -1)
                                   ),
                                   div(style="display: inline-block;vertical-align:top; width: 49%;",
                                       
                                       numericInput(inputId = "inputk2_poisson",
                                                    label = "k2 :",
                                                    value = 1,
                                                    step = 1,
                                                    min = 0)
                                   ),
                                   uiOutput("resu_calcu_poisson")
                               )
                               
                        ),
                        
                        column(width = 4,
                               tabBox(width = 12,
                                      title = "",
                                      tabPanel("Loi de probabilité",
                                               plotOutput("densite_poisson"),
                                               uiOutput("fonction_densite_poisson")
                                      ),
                                      tabPanel("Répartition",
                                               plotOutput("repartition_poisson"),
                                               uiOutput("fonction_repartition_poisson")
                                      )
                               )
                        ),
                        
                        column(width = 4,
                               box(
                                 width = 12,
                                 collapsible = T,
                                 collapsed = T,
                                 title = "Cours",
                                 uiOutput("def_poisson"),
                                 uiOutput("formule_poisson"),
                                 uiOutput("text_esp_var_poisson"),
                                 uiOutput("calcu_proba_1_poisson")
                                 
                               ),
                               box(width = 12,
                                   collapsible = T,
                                   collapsed = T,
                                   title = "Pour s'entraîner",
                                   uiOutput("exercice_poisson"),
                                   actionButton(
                                     inputId = "bouton_exo",
                                     label = "Afficher correction"
                                   ),
                                   conditionalPanel(
                                     condition = "input.bouton_exo % 2 != 0",
                                     uiOutput("correction_poisson")
                                   )
                               )
                               
                        )
                      )
                      
                      
                    )
)