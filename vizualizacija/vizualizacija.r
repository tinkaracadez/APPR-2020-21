SIreg <- uvozi.zemljevid("https://biogeo.ucdavis.edu/data/gadm3.6/shp/gadm36_SVN_shp.zip",
                              "gadm36_SVN_1", encoding="UTF-8") 

koordinate <- coordinates(SIreg) %>% as_tibble() 

# uporabim fortify, da lahko uporabljam ggplot2
SIreg_fort <- SIreg %>% 
 fortify()

SIreg_fort <- SIreg_fort %>%
  mutate(
    NAME_1=str_replace(NAME_1, "Notranjsko-kraška", "Primorsko-notranjska"),
    NAME_1=str_replace(NAME_1, "Spodnjeposavska", "Posavska"))
    
SIreg_fort <- SIreg_fort %>%
  rename(regija=NAME_1)

regije <- regije %>% mutate(
  rojeni=gsub("\\.", "", rojeni),
  rojeni=as.numeric(rojeni))

SIreg_zdr <- inner_join(regije, SIreg_fort, by="regija")

brez.ozadja <- theme_bw() +
  theme(
    axis.line=element_blank(),
    axis.text.x=element_blank(),
    axis.text.y=element_blank(),
    axis.ticks=element_blank(),
    axis.title.x=element_blank(),
    axis.title.y=element_blank(),
    panel.background=element_blank(),
    panel.border=element_blank(),
    panel.grid.major=element_blank(),
    panel.grid.minor=element_blank(),
    plot.background=element_blank()
  ) 

regije.imena <- c("Gorenjska", "Goriška", "Jugovzhodna Slovenija", "Koroška", "Primorsko-notranjska","Obalno-kraška","Osrednjeslovenska","Podravska","Pomurska","Savinjska","Posavska","Zasavska")

koord <- koordinate %>% 
  mutate(regija=regije.imena) %>% 
  .[c(3,1,2)]

# zemljevid števila živorojenih otrok v regijah za leto 2018

SIreg_zdr2018 <- SIreg_zdr %>% filter(leto=="2018") %>% 
  mutate(rojeni=as.numeric(rojeni))
brks <- quantile(SIreg_zdr2018$rojeni, seq(0,1,1/8))

legendaLabele <- paste(as.integer(brks[1:8]), as.integer(brks[2:9]), sep="-")
legendaNaslov <- "Število rojenih otrok"

zem.reg <- SIreg_zdr2018 %>%
  mutate(
    kvantil=factor(findInterval(SIreg_zdr2018$rojeni, brks, all.inside=TRUE))
    ) %>%
  ggplot() +
  geom_polygon(aes(x=long, y=lat, group=group, fill=kvantil), color="black", size=0.001) +
  scale_fill_brewer(
    type=9, palette="Reds",
    labels=legendaLabele,
    name=legendaNaslov
    ) +
  labs(title="Število rojenih otrok v letu 2018 za posamezne slovenske regije") +
  geom_text(data=koord, aes(x=V1, y=V2, label=regija), size=6) +
  brez.ozadja +
  theme(plot.title=element_text(size=20),
        legend.title=element_text(size=20),
        legend.text=element_text(size=20))

# primerjava števila živorojenih otrok v regijah z najvišjo in najnižjo vrednostjo

v <- c("Zasavska", "Primorsko-notranjska", "Osrednjeslovenska", "Podravska")

graf.reg <- ggplot(data=regije %>%
                     filter(regija %in% v),
                   aes(x=leto, y=rojeni, color=regija)) +
  geom_line(size=1) +
  xlab("Leto") +
  ylab("Število rojenih otrok") +
  scale_x_continuous(breaks=2009:2018) +
  labs(title="Število rojenih otrok v štirih slovenskih regijah") +
  guides(color=guide_legend(title="Regija")) +
  theme_bw(base_size=20) 

# primerjava števila živorojenih otrok v nekaterih evropskih državah

EUpovrs <- inner_join(evropa, povrsine, by="drzava")

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

u <- c("Malta", "Iceland", "Netherlands", "Finland", "France", "Slovenia", "Luxembourg", "United Kingdom")
EUpovrs$leto <- as.numeric(EUpovrs$leto)
EUpovrs <- EUpovrs %>% mutate(gostota=rojeni/povrsina)

graf.evr <- ggplot(data=EUpovrs %>%
                     filter(drzava %in% u),
                   aes(x=leto, y=gostota, color=slovar[drzava])) +
  geom_line(size=1) +
  xlab("Leto") +
  ylab("Število rojenih otrok na km\u00B2") +
  scale_x_continuous(breaks=2009:2018) +
  labs(title="Število rojenih otrok na km\u00B2 v osmih evropskih državah") +
  guides(color=guide_legend(title="Država")) +
  theme_bw(base_size=20)

# primerjava števila rojstev po mesecih

meseci$mesec <- factor(meseci$mesec, levels = unique(meseci$mesec))

graf.mes <- ggplot(data=meseci,
                   aes(x=leto, y=rojeni, color=mesec)) +
  geom_line(size=1) +
  xlab("Leto") +
  ylab("Število rojenih otrok") +
  scale_x_continuous(breaks=2009:2018) +
  labs(title="Število rojenih otrok v posameznih mesecih") +
  guides(color=guide_legend(title="Mesec")) +
  theme_bw(base_size=20)

# število rojstev v Evropi za leti 2009 in 2018

w <- c("Ukraine", "San Marino", "Russia", "Moldova", "Kosovo ", "Bosnia and Herzegovina", "Albania", "Liechtenstein", "Andorra")

graf.evr2 <- ggplot(EUpovrs %>%
                      filter(leto %in% c("2009", "2018")) %>%
                      filter(!(drzava %in% w)),
                    aes(x=gostota, y=reorder(slovar[drzava], -gostota), fill=factor(leto))) +
  geom_col(position="dodge") +
  labs(title="Število rojenih otrok na km\u00B2 v evropskih državah za leti 2009 in 2018") +
  xlab("Število otrok na km\u00B2") +
  ylab("Država") +
  guides(fill=guide_legend(title="Leto")) +
  geom_vline(mapping=aes(xintercept=mean(EUpovrs %>% filter(leto==2018) %>% filter(!(drzava %in% w)) %>% .$gostota)),
             col="indianred2") +
  geom_vline(mapping=aes(xintercept=mean(EUpovrs %>% filter(leto==2009) %>% filter(!(drzava %in% w)) %>% .$gostota)),
             col="cadetblue3") +
  scale_fill_manual(values=c("cadetblue3", "indianred2")) +
  theme_bw(base_size=20)

# napoved števila rojstev za Slovenijo

quadratic <- lm(data=EUpovrs %>% filter(drzava=="Slovenia"), gostota ~ I(leto))
leta <- data.frame(leto=seq(2019, 2025, 1))
prediction <- mutate(leta, gostota=predict(quadratic, leta))

graf.napoved <- ggplot(EUpovrs %>%
         filter(drzava == "Slovenia")) +
  aes(x=leto, y=gostota) +
  geom_smooth(method="lm", fullrange=TRUE, color="red4", formula=y ~ x) +
  geom_point(size=2, color="royalblue4") +
  geom_point(data=prediction %>% filter(leto >= 2019), color="green4", size=3) +
  scale_x_continuous('Leto', breaks=seq(2009, 2025, 1), limits=c(2009, 2025)) +
  labs(title="Napoved števila rojenih otrok na km\u00B2 v Sloveniji do leta 2025") +
  ylab("Število rojenih otrok na km\u00B2") +
  theme_bw(base_size=20) +
  theme(axis.text.x=element_text(angle=45, hjust=1),
        axis.title.x = element_text(vjust=-4),
        axis.title.y = element_text(vjust=5))





