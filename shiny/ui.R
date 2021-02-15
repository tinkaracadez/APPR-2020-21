library(shiny)

shinyUI(fluidPage(
  tabsetPanel(
    tabPanel("Slovenske regije",
             sidebarPanel(
               selectInput(inputId="regije",
                           label="Izberi leto",
                           choices=unique(regije$leto))),
             mainPanel(plotOutput("regije"))),
    tabPanel("evropske države",
             sidebarPanel(
               selectInput(inputId="evropa",
                           label="Izberi državo",
                           choices=unique(EUpovrs$drzava),
                           selected=unique(EUpovrs$drzava)[24])),
             mainPanel(plotOutput("evropa"))),
    tabPanel("Napoved za Evropske države",
             sidebarPanel(
               selectInput(inputId="napoved",
                           label="Izberi državo",
                           choices=unique(EUpovrs$drzava),
                           selected=unique(EUpovrs$drzava)[24])),
             mainPanel(plotOutput("napoved")))
)))
