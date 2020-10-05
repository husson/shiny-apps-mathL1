library(shiny)
library(shinydashboard)
library(shinyjs)
library(shinyBS)

ui <- dashboardPage(skin = "green",
                    dashboardHeader(title = "Agrocampus Ouest"),
                    dashboardSidebar(disable = T),
                    dashboardBody(
                      h1("Loi de Fisher F(n1,n2)"),
                      fluidRow(
                        
                        column(width = 4,
                               box(width = 12,
                                   sliderInput(
                                     "slider_fisher_ddl1",
                                     "Degrés de liberté n1 :",
                                     min = 1,
                                     max = 20,
                                     value = 3),
                                   sliderInput(
                                     "slider_fisher_ddl2",
                                     "Degrés de liberté n2 :",
                                     min = 1,
                                     max = 20,
                                     value = 3),
                                   uiOutput("moy_var_fisher")
                               ),
                               box(width = 12,
                                   title = "Calculateur de probabilités :",
                                   div(style="display: inline-block;vertical-align:top; width: 49%;",
                                       
                                   numericInput(inputId = "inputk1_fisher",
                                                label = "k1 :",
                                                value = 0,
                                                step = 1)
                                   ),
                                   div(style="display: inline-block;vertical-align:top; width: 49%;",
                                       
                                   numericInput(inputId = "inputk2_fisher",
                                                label = "k2 :",
                                                value = 1,
                                                step = 1)
                                   ),
                                   uiOutput("resu_calcu_fisher")
                               )
                               
                               
                        ),
                        column(width = 4,
                               tabBox(width = 12,
                                      title = "",
                                      tabPanel("Densité",
                                               plotOutput("densite_fisher"),
                                               uiOutput("fonction_densite_fisher")
                                      ),
                                      tabPanel("Répartition",
                                               plotOutput("repartition_fisher"),
                                               uiOutput("fonction_repartition_fisher")
                                      )
                               )
                        ),
                        column(width = 4,
                               box(
                                 width = 12,
                                 collapsible = T,
                                 collapsed = T,
                                 title = "Cours",
                                 uiOutput("def_fisher"),
                                 uiOutput("formule_fisher"),
                                 uiOutput("text_esp_var_fisher"),
                                 uiOutput("calcu_proba_1_fisher")
                                 
                               )
                               
                               
                        )
                      )
                      
                      
                    )
)