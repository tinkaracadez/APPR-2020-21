library(shiny)

shinyServer(function(input, output) {
  output$evropa <- renderPlot({
    ggplot(EUpovrs %>%
             filter(drzava == input$evropa)
           ) +
      aes(x=leto, y=gostota) +
      geom_point(size=2, color="lightblue4") +
      geom_line(size=2, color="red4") +
      xlab("Leto") +
      ylab("Število rojenih otrok na km\u00B2") +
      scale_x_continuous(breaks=2009:2018) +
      theme_bw() +
      theme(axis.text.x=element_text(angle=45, hjust=1),
            axis.title.x = element_text(vjust=-5),
            axis.title.y = element_text(vjust=5)) 
  })
  output$regije <- renderPlot({
    ggplot(regije %>%
             filter(leto == input$regije)
           ) +
      aes(x=regija, y=rojeni) +
      geom_col(position="dodge") +
      xlab("Regija") +
      ylab("Število rojenih otrok") +
      #ylim(0, 1000) +
      theme_bw() +
      theme(axis.text.x=element_text(angle=45, hjust=1), 
            axis.title.x = element_text(vjust=-2.5),
            axis.title.y = element_text(vjust=5))
  })
  # napoved za evropske države (linearna regresija)
  output$napoved <- renderPlot({
    podatki <- EUpovrs %>%
      filter(drzava == input$napoved)
    
    quadratic <- lm(data=podatki, gostota ~ I(leto))
    leta <- data.frame(leto=seq(2019, 2025, 1))
    prediction <- mutate(leta, gostota=predict(quadratic, leta))
    
    ggplot(podatki) +
      aes(x=leto, y=gostota) +
      geom_smooth(method="lm", fullrange=TRUE, color="red4", formula=y ~ x) +
      geom_point(size=2, color="royalblue4") +
      geom_point(data=prediction %>% filter(leto >= 2019), color="green4", size=3) +
      scale_x_continuous('Leto', breaks=seq(2009, 2025, 1), limits=c(2009, 2025)) +
      ylab("Število rojenih otrok na km\u00B2") +
      theme_bw() +
      theme(axis.text.x=element_text(angle=45, hjust=1),
            axis.title.x = element_text(vjust=-5),
            axis.title.y = element_text(vjust=5))
  })
})

