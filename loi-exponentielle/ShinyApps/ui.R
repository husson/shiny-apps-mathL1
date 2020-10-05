library(shiny)

# Define UI for application that draws a histogramlibrary(shiny)
library(shinydashboard)
library(shinydashboard)

ui <- dashboardPage(skin = "green",
                    dashboardHeader(title = "Loi Exponentielle E(λ)"),
                    dashboardSidebar(disable = T),
                    dashboardBody(
                      h4("Cette application permet de s'approprier le fonctionnement et de manipuler la loi exponentielle"),
                      HTML("<br>"),
                      fluidRow(
                        column(width = 4,
                               box(width = 12,
                                   
                                   
                                   div(
                                     style="display: inline-block;vertical-align:top; width: 69%;",
                                     sliderInput(inputId = "input_lambda_expo",
                                                 label = "Lambda :",
                                                 value = 1,
                                                 step = 0.01,
                                                 min = 0.001,
                                                 max = 3,
                                                 width = "300px")
                                   ),
                                   
                                   div(style="display: inline-block;vertical-align:top; width: 29%;",
                                       numericInput(
                                         "numeric_lambda",
                                         "",
                                         min = 0.001,
                                         max = 3,
                                         value = 1,
                                         step = 0.001
                                       )
                                   ),
                                   uiOutput("moy_var_exponentielle")
                               ),
                               box(width = 12,
                                   title = "Calcul de P(k1 ≤ X ≤ k2)",
                                   div(style="display: inline-block;vertical-align:top; width: 49%;",
                                       numericInput(inputId = "inputk1_expo",
                                                    label = "k1 :",
                                                    value = 0,
                                                    min = 0
                                       )
                                   ),
                                   div(style="display: inline-block;vertical-align:top; width: 49%;",
                                       numericInput(inputId = "inputk2_expo",
                                                    label = "k2 :",
                                                    value = 1,
                                                    min = 0
                                       )
                                   ),
                                   uiOutput("resu_calcu_expo")
                               )
                               
                               
                        ),
                        
                        column(width = 4,
                               tabBox(width = 12,
                                      title = "",
                                      tabPanel("Densité",
                                               plotOutput("densite_expo"),
                                               uiOutput("fonction_densite_expo")
                                      ),
                                      tabPanel("Répartition",
                                               plotOutput("repartition_expo"),
                                               uiOutput("fonction_repartition_expo")
                                      )
                               )
                        ),
                        
                        column(width = 4,
                               box(
                                 width = 12,
                                 collapsible = T,
                                 collapsed = T,
                                 title = "Cours",
                                 uiOutput("def_expo"),
                                 uiOutput("sans_memoire"),
                                 uiOutput("text_esp_var_expo"),
                                 uiOutput("calcu_proba_1_expo")
                                 
                               ),
                               box(width = 12,
                                   collapsible = T,
                                   collapsed = T,
                                   title = "Exemples",
                                   uiOutput("exercice_expo"),
                                   actionButton(
                                     inputId = "bouton_exo",
                                     label = "Afficher correction"
                                   ),
                                   conditionalPanel(
                                     condition = "input.bouton_exo % 2 != 0",
                                     uiOutput("correction_expo")
                                   )
                               )
                               
                        )
                      )
                    )
)
