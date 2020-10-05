library(shiny)
library(shinydashboard)
library(shinyjs)
library(shinyBS)

ui <- dashboardPage(skin = "green",
                    dashboardHeader(title="Loi Normale"),
                    dashboardSidebar(disable = T),
                    dashboardBody(
                      useShinyjs(),
#                      h1("Loi Normale"),
                      fluidRow(
                        column(width = 4,
                               box(width = 12,
                                   id = "slider_normale",
                                   
                                   
                                   div(
                                     style="display: inline-block;vertical-align:top; width: 69%;",
                                     sliderInput(
                                       inputId = "slider_esperance_normale", 
                                       label = HTML("&mu; :"), 
                                       min = -20, 
                                       max = 20, 
                                       value = 0,
                                       step = 0.5
                                     )
                                   ),
                                   
                                   div(style="display: inline-block;vertical-align:top; width: 29%;",
                                       numericInput(
                                         "numeric_esp",
                                         "",
                                         min = -20,
                                         max = 20,
                                         value = 0,
                                         step = 0.5
                                       )
                                   ),
                                   
                                   
                                   
                                   div(
                                     style="display: inline-block;vertical-align:top; width: 69%;",
                                     sliderInput(
                                       inputId = "slider_variance_normale",
                                       label = HTML("&sigma; :"), 
                                       min = 0.5, 
                                       max = 10, 
                                       value = 1, 
                                       step = 0.5
                                     )
                                   ),
                                   
                                   div(style="display: inline-block;vertical-align:top; width: 29%;",
                                       numericInput(
                                         "numeric_var",
                                         "",
                                         min = 0.5, 
                                         max = 10, 
                                         value = 1, 
                                         step = 0.5
                                       )
                                   ),
                                   
                                   
                                   uiOutput("explication_esp_var")
                               ),
                               box(width = 12,
                                   title = "Calculateur de probabilités",
                                   div(style="display: inline-block;vertical-align:top; width: 49%;",
                                       numericInput(inputId = "inputk1",
                                                    label = "k1 :",
                                                    value = -1.96,
                                                    width = '800%'
                                       )
                                   ),
                                   
                                   div(style="display: inline-block;vertical-align:top; width: 49%;",
                                       numericInput(inputId = "inputk2",
                                                    label = "k2 :",
                                                    value = 1.96,
                                                    width = '800%'
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
                                               plotOutput("densite_normale"), 
                                               uiOutput("fonction_densite")
                                      ),
                                      tabPanel("Répartition", 
                                               plotOutput("repartition_normale"), 
                                               uiOutput("fonction_repartition")
                                      )
                               )
                        ),
                        
                        column(width = 4,
                               
                               box(
                                 width = 12,
                                 collapsible = T,
                                 collapsed = T,
                                 id = "def_esp_var_cr",
                                 title = "Cours",
                                 uiOutput("def_normale"),
                                 uiOutput("calcu_proba_1")
                               ),
                               
                               box(width = 12,
                                   collapsible = T,
                                   collapsed = T,
                                   title = "Pour s'entraîner",
                                   id = "tab_exo_cor",
                                   uiOutput("question_normale"),
                                   actionButton(
                                     inputId = "bouton_exo",
                                     label = "Afficher correction"
                                   ),
                                   conditionalPanel(
                                     condition = "input.bouton_exo % 2 != 0",
                                     uiOutput("correction_normale")
                                   )
                               )
                               
                               
                               
                               
                               
                        )
                      )
                    )
)
