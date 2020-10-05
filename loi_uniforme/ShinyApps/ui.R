library(shiny)

# Define UI for application that draws a histogramlibrary(shiny)
library(shinydashboard)
library(shinydashboard)

ui <- dashboardPage(skin = "green",
                    dashboardHeader(title = "Agrocampus Ouest"),
                    dashboardSidebar(disable = T),
                    dashboardBody(
                      h1("Loi Uniforme continue"),
                      fluidRow(
                        
                        column(width = 4,
                               box(width = 12,
                                   sliderInput(inputId = "slider_uniforme_minmax", label = h3("Intervalle de la loi Uniforme"), min = 0, max = 20, value = c(0, 10)),
                                   uiOutput("moy_var_uniforme")
                               ),
                               box(width = 12,
                                   title = "Calculateur de probabilités",
                                   
                                   div(style="display: inline-block;vertical-align:top; width: 49%;",
                                       
                                       numericInput(inputId = "inputk1",
                                                    label = "k1 :",
                                                    value = 0
                                       )
                                   ),
                                   div(style="display: inline-block;vertical-align:top; width: 49%;",
                                       
                                       numericInput(inputId = "inputk2",
                                                    label = "k2 :",
                                                    value = 1
                                       )
                                   ),
                                   uiOutput("resu_calcu")
                               )
                               
                               
                        ),
                        column(width = 4,
                               tabBox(width = 12,
                                      title = "",
                                      id = "tabset1",
                                      tabPanel("Densité",
                                               plotOutput("densite_uniforme"), 
                                               uiOutput("fonction_densite")
                                      ),
                                      tabPanel("Répartition", 
                                               plotOutput("repartition_uniforme"), 
                                               uiOutput("fonction_repartition")
                                      )
                               )
                        ),
                        column(width = 4,
                               box(
                                 width = 12,
                                 collapsible = T,
                                 collapsed = T,
                                 title = "Définition, espérance et variance",
                                 uiOutput("def_uniforme"),
                                 uiOutput("text_esp_var_uniforme"),
                                 uiOutput("calcu_proba_1")
                                 
                               ),
                               box(width = 12,
                                   collapsible = T,
                                   collapsed = T,
                                   title = "Pour s'entraîner",
                                   id = "tabsetexo",
                                   uiOutput("exercice_unif"),
                                   actionButton(
                                     inputId = "bouton_exo",
                                     label = "Afficher correction"
                                   ),
                                   conditionalPanel(
                                     condition = "input.bouton_exo % 2 != 0",
                                     uiOutput("correction_unif")
                                   )
                                   
                                   
                                   
                                   
                               )
                               
                        )
                      )
                    )
)
