library(shiny)
library(shinydashboard)
library(shinyjs)
library(shinyBS)

ui <- dashboardPage(skin = "green",
                    dashboardHeader(title = "Agrocampus Ouest"),
                    dashboardSidebar(disable = T),
                    dashboardBody(
                      h1("Loi du Khi-2 X(n)"),
                      fluidRow(
                        
                        column(width = 4,
                               box(width = 12,
                                   sliderInput(
                                     "slider_khi_ddl",
                                     "Degrés de liberté n :",
                                     min = 1,
                                     max = 20,
                                     value = 3),
                                   uiOutput("moy_var_khi")
                               ),
                               box(width = 12,
                                   title = "Calculateur de probabilités :",
                                   div(style="display: inline-block;vertical-align:top; width: 49%;",
                                       
                                   numericInput(inputId = "inputk1_khi",
                                                label = "k1 :",
                                                value = 0,
                                                step = 1,
                                                min = 0)
                                   ),
                                   div(style="display: inline-block;vertical-align:top; width: 49%;",
                                       
                                   numericInput(inputId = "inputk2_khi",
                                                label = "k2 :",
                                                value = 1,
                                                step = 1,
                                                min = 0)
                                   ),
                                   uiOutput("resu_calcu_khi")
                               )

                               
                        ),
                        column(width = 4,
                               tabBox(width = 12,
                                      title = "",
                                      tabPanel("Densité",
                                               plotOutput("densite_khi"),
                                               uiOutput("fonction_densite_khi")
                                      ),
                                      tabPanel("Répartition",
                                               plotOutput("repartition_khi"),
                                               uiOutput("fonction_repartition_khi")
                                      )
                               )
                        ),
                        column(width = 4,
                               box(
                                 width = 12,
                                 collapsible = T,
                                 collapsed = T,
                                 title = "Cours",
                                 uiOutput("def_khi"),
                                 uiOutput("formule_khi"),
                                 uiOutput("text_esp_var_khi"),
                                 uiOutput("calcu_proba_1_khi")
                                 
                               )
                               
                        )
                      )
                      
                      
                    )
)