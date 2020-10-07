library(shiny)
library(shinydashboard)
library(shinyjs)
library(shinyBS)

ui <- dashboardPage(skin = "green",
                    dashboardHeader(title = "Agrocampus Ouest"),
                    dashboardSidebar(disable = T),
                    dashboardBody(
                      h1("Loi de Student t(n)"),
                      fluidRow(
                        
                        column(width = 4,
                               box(width = 12,
                                   sliderInput(
                                     "slider_student_ddl",
                                     "Degrés de liberté n :",
                                     min = 1,
                                     max = 20,
                                     value = 3),
                                   uiOutput("moy_var_student")
                               ),
                               box(width = 12,
                                   title = "Calculateur de probabilités :",
                                   div(style="display: inline-block;vertical-align:top; width: 49%;",
                                       numericInput(inputId = "inputk1_student",
                                                    label = "k1 :",
                                                    value = 0,
                                                    step = 1
                                       )
                                   ),
                                   div(style="display: inline-block;vertical-align:top; width: 49%;",
                                       
                                       numericInput(inputId = "inputk2_student",
                                                    label = "k2 :",
                                                    value = 1,
                                                    step = 1
                                       )
                                   ),
                                   uiOutput("resu_calcu_student")
                               )
                               
                        ),
                        column(width = 4,
                               tabBox(width = 12,
                                      title = "",
                                      tabPanel("Densité",
                                               plotOutput("densite_student"),
                                               uiOutput("fonction_densite_student")
                                      ),
                                      tabPanel("Répartition",
                                               plotOutput("repartition_student"),
                                               uiOutput("fonction_repartition_student")
                                      )
                               )
                        ),
                        column(width = 4,
                               box(
                                 width = 12,
                                 collapsible = T,
                                 collapsed = T,
                                 title = "Cours",
                                 uiOutput("def_student"),
                                 uiOutput("formule_student"),
                                 uiOutput("text_esp_var_student"),
                                 uiOutput("calcu_proba_1_student")
                                 
                               )
                               
                               
                        )
                      )
                      
                      
                    )
)