# urejena tabela za rojene po mesecih
meseci <- read_csv2("podatki/St_rojenih_SLO_meseci.csv",
                  locale=locale(encoding="cp1250")) %>%
  rename(leto=LETO, mesec="MESEC ROJSTVA", rojeni="Živorojeni")

# urejena tabela za rojene po dnevih
dnevi <- read_csv2("podatki/St_rojenih_SLO_dnevi.csv",
                   locale=locale(encoding="cp1250"),
                   na=c("", " ", "-")) %>%
  rename(mesec=MESEC, dan="DAN V MESECU", rojeni="Živorojeni") %>%
  drop_na(rojeni) %>%
  mutate(
    leto=mesec
  ) %>%
  .[c(4,1,2,3)] %>%
  mutate(
    leto=str_replace(leto, "M\\d{2}", ""),
    mesec=str_replace(mesec, "\\d{4}M", ""),
    mesec=str_replace(mesec, "^0", ""),
    leto=as.numeric(leto),
    mesec=as.numeric(mesec)
  ) 

# tabela za rojene po regijah (HTML)
stran <- read_html("podatki/St_rojenih_SLO_regije.htm",
                   locale=locale(encoding="cp1250"))
regije <- stran %>% 
  html_nodes(xpath="//table") %>%
  .[[1]] %>%
  html_table(fill=TRUE) %>%
  rename(
    leto=3,
    regija=1,
    rojeni=2
  ) %>%
  .[c(3,1,2)] %>%
  mutate(
    leto=regija,
    leto=gsub("^\\D", NA, leto),
    rojeni=gsub("[a-z]", NA, rojeni),
    rojeni=gsub("\\.", "", rojeni),
    rojeni=as.numeric(rojeni),
    leto=as.numeric(leto)
    ) %>%
  fill(leto) %>%
  drop_na(rojeni) %>%
  drop_na(regija) %>% 
  data.frame()

# urejena tabela za rojene v evropskih državah (Excel)
evropa <- read_xlsx("podatki/St_rojenih_EU.xlsx",
                    sheet="Sheet 1",
                    skip=9,
                    n_max=48,
                    na=c("", " ", ":")) %>% select(-seq(3,21, by = 2)) 
colnames(evropa) <- c("drzava", 2009:2018)
evropa <- evropa %>%
  mutate(
    drzava=str_replace(drzava, "\\(.*\\)", "")
  ) %>%
  pivot_longer(
    c(-drzava),
    names_to="leto",
    values_to="rojeni"
  )

# tabela s površinami evropskih držav
url <- "https://en.wikipedia.org/wiki/List_of_European_countries_by_area"
stran2 <- read_html(url, locale=locale(encoding="cp1250"))

povrsine <- stran2 %>%
  html_nodes(xpath="//table") %>%
  .[[1]] %>%
  html_table() %>%
  select(c(2,3)) %>% 
  rename(
    drzava=1,
    povrsina=2
  ) %>% 
  mutate(
    drzava=str_replace(drzava, "\\*", ""),
    povrsina=parse_number(povrsina),
    drzava=str_replace(drzava, "Czech Republic", "Czechia"),
    drzava=str_replace(drzava, "Germany", "Germany "),
    drzava=str_replace(drzava, "Kosovo", "Kosovo ")
    ) %>% 
  data.frame()

# shranjevanje tabel v mapo podatki
write.csv(meseci, file="podatki/meseci.csv")
write.csv(dnevi, file="podatki/dnevi.csv")
write.csv(regije, file="podatki/regije.csv")
write.csv(evropa, file="podatki/evropa.csv")
write.csv(povrsine, file="podatki/povrsine.csv")