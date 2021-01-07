source("lib/uvozi.zemljevid.r", encoding="Windows-1250")
source("lib/libraries.r", encoding="Windows-1250")

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
brks <- quantile(SIreg_zdr2018$rojeni, seq(0,1,1/5))

legendaLabele <- paste(as.integer(brks[1:5]), as.integer(brks[2:6]), sep="-")
legendaNaslov <- "Število rojenih otrok"

SIreg_zdr2018 %>%
  mutate(
    kvantil=factor(findInterval(SIreg_zdr2018$rojeni, brks, all.inside=TRUE))
    ) %>%
  ggplot() +
  geom_polygon(aes(x=long, y=lat, group=group, fill=kvantil), color="black", size=0.001) +
  scale_fill_brewer(
    type=6, palette="Reds",
    labels=legendaLabele,
    name=legendaNaslov
    ) +
  labs(title="Število rojenih otrok v letu 2018 za posamezne slovenske regije") +
  geom_text(data=koord, aes(x=V1, y=V2, label=regija), size=2.5) +
  brez.ozadja +
  ggsave("regije2018.pdf", device="pdf")

# primerjava števila živorojenih otrok v regijah z najvišjo in najnižjo vrednostjo

v <- c("Zasavska", "Primorsko-notranjska", "Osrednjeslovenska", "Podravska")
regije$leto <- as.numeric(regije$leto)

graf.reg <- ggplot(data=regije %>%
                     filter(regija %in% v),
                   aes(x=leto, y=rojeni, color=regija)) +
  geom_line(size=1) +
  ylab("Število rojenih otrok") +
  scale_x_continuous(breaks=2009:2018) +
  labs(title="Število rojenih otrok v štirih slovenskih regijah") +
  theme_bw()

# print(graf.reg)

# primerjava števila živorojenih otrok v nekaterih evropskih državah

u <- c("France", "United Kingdom", "Liechtenstein", "Estonia", "Croatia", "Slovenia")
evropa$leto <- as.numeric(evropa$leto)

graf.evr <- ggplot(data=evropa %>%
                     filter(drzava %in% u),
                   aes(x=leto, y=rojeni, color=drzava)) +
  geom_line(size=1) +
  ylab("Število rojenih otrok") +
  scale_x_continuous(breaks=2009:2018) +
  labs(title="Število rojenih otrok v šestih evropskih državah") +
  theme_bw()

# primerjava števila rojstev po mesecih

w <- c("2009","2012", "2015", "2018")

graf.mes <- ggplot(data=meseci %>%
                     filter(leto %in% w),
                   aes(x=mesec, y=rojeni, color=leto)) +
  geom_line(size=1) +
  ylab("Število rojenih otrok") +
  #scale_x_continuous(breaks=waiver()) +
  labs(title="Število rojenih otrok po mesecih za štiri leta") +
  theme_bw()

print(graf.mes)







