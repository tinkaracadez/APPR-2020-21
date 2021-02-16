library(shiny)

slovar <- c("Belgium"="Belgija",
            "Bulgaria"="Bolgarija",
            "Czechia"="Češka",
            "Denmark"="Danska",
            "Germany "="Nemčija",
            "Estonia"="Estonija",
            "Ireland"="Irska",
            "Greece"="Grčija",
            "Spain"="Španija",
            "France"="Francija",
            "Croatia"="Hrvaška",
            "Italy"="Italija",
            "Cyprus"="Ciper",
            "Latvia"="Latvija",
            "Lithuania"="Litva",
            "Luxembourg"="Luksemburg",
            "Hungary"="Madžarska",
            "Malta"="Malta",
            "Netherlands"="Nizozemska",
            "Austria"="Avstrija",              
            "Poland"="Poljska",
            "Portugal"="Portugalska",
            "Romania"="Romunija",
            "Slovenia"="Slovenija",
            "Slovakia"="Slovaška",
            "Finland"="Finska",
            "Sweden"="Švedska",
            "United Kingdom"="Velika Britanija",        
            "Iceland"="Islandija",
            "Liechtenstein"="Lihtenštajn",
            "Norway"="Norveška",
            "Switzerland"="Švica",           
            "Montenegro"="Črna gora",
            "North Macedonia"="Severna Makedonija",
            "Albania"="Albanija",
            "Serbia"="Srbija",                
            "Turkey"="Turčija",
            "Andorra"="Andora",
            "Belarus"="Belorusija",
            "Bosnia and Herzegovina"="Bosna in Hercegovina",
            "Kosovo "="Kosovo",
            "Moldova"="Moldavija",
            "Russia"="Rusija",
            "San Marino"="San Marino",
            "Ukraine"="Ukrajina",
            "Armenia"="Armenija",
            "Azerbaijan"="Azerbajdžan",
            "Georgia"="Gruzija")

shinyServer(function(input, output) {
  output$evropa <- renderPlot({
    ggplot(EUpovrs %>%
             filter(slovar[drzava] == input$evropa)
           ) +
      aes(x=leto, y=gostota) +
      geom_point(size=2, color="lightblue4") +
      geom_line(size=2, color="red4") +
      xlab("Leto") +
      ylab("Število rojenih otrok na km\u00B2") +
      scale_x_continuous(breaks=2009:2018) +
      theme_bw() +
      theme(axis.text.x=element_text(angle=45, hjust=1),
            axis.title.x = element_text(vjust=-0.5),
            axis.title.y = element_text(vjust=1.5)) 
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
            axis.title.x = element_text(vjust=-0.5),
            axis.title.y = element_text(vjust=1.5))
  })
  # napoved za evropske države (linearna regresija)
  output$napoved <- renderPlot({
    podatki <- EUpovrs %>%
      filter(slovar[drzava] == input$napoved)
    
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
            axis.title.x = element_text(vjust=-0.5),
            axis.title.y = element_text(vjust=1.5))
  })
})

