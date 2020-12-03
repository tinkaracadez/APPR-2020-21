# Analiza podatkov s programom R, 2020/21

Repozitorij z gradivi pri predmetu APPR v študijskem letu 2020/21

* [![Shiny](http://mybinder.org/badge.svg)](http://mybinder.org/v2/gh/tinkaracadez/APPR-2020-21/master?urlpath=shiny/APPR-2020-21/projekt.Rmd) Shiny
* [![RStudio](http://mybinder.org/badge.svg)](http://mybinder.org/v2/gh/tinkaracadez/APPR-2020-21/master?urlpath=rstudio) RStudio

## Tematika

### Analiza rodnosti v Sloveniji in primerjava z evropskimi državami

#### Predstavitev teme: 

Odločila sem se, da bom analizirala rodnost v Sloveniji in jo primerjava z ostalimi državami EU. Za zadnje desetletje bom za različne spremenljivke natančneje analizirala število živorojenih otrok v Sloveniji, nato pa za isto časovno obdobje primerjala samo število rojstev v Sloveniji v primerjavi z ostalimi evropskimi državami.

Rodnost v Sloveniji oz. število živorojenih otrok bom analizirala glede na:

* regijo oz. občino
* dan oz. mesec rojstva
* starost in izobrazbo matere ter vrstni red rojstva
* zakonsko oz. zunajzakonsko zvezo med staršema
    
Z evropskimi državami pa bom kasneje primerjala le samo število rojstev živorojenih otrok (za obdobje 10 let).
Tu bom navedla:

* državo
* število živorojenih otrok v določenem letu
    
    
#### Cilji: 

V okviru projekta bom najprej ugotovila, koliko otrok je bilo letno rojenih v posameznih regijah, katera regija jih je imela največ v vsakem letu in kakšno je povprečje v obravnavanem obdobju. Prav tako bom ugotavljala, katerega meseca je bilo v posameznih letih rojenih največ otrok in kako je s tem v povprečju v obravnavanem obdobju. Izpostavila bom, kateri so tisti dnevi, ko je bilo rojenih največ otrok. Zanimalo me bo tudi, kakšna je starost in izobrazba mater v povezavi z vrstnim redom rojstva. Zanimalo me bo tudi, koliko otrok je bil rojenih v zakonski oziroma zunajzakonski zvezi med staršema. Na koncu pa bom samo število živorojenih rojstev v Sloveniji primerjala s številom le-teh v ostalih državah članicah EU in na ta način ugotovila, v kateri državi je bilo največ rojstev ter izračunala, kakšno je bilo maksimalno, minimalno in povprečno število rojstev po državah v zadnjem desetjetju.


#### Podatki: 

Podatke bom iz naslednjih spletnih strani izvozila v različnih formatih.

* [EU (2009-2018)](https://ec.europa.eu/eurostat/databrowser/view/DEMO_FMONTH__custom_270818/default/table?lang=en)
* [SLO-regije](https://pxweb.stat.si/SiStatData/pxweb/sl/Data/-/05J2008S.px/table/tableViewLayout2/)
* [SLO-meseci](https://pxweb.stat.si/SiStatData/pxweb/sl/Data/-/05J1030S.px/table/tableViewLayout2/)
* [SLO-dnevi](https://pxweb.stat.si/SiStatData/pxweb/sl/Data/-/05J1031S.px/table/tableViewLayout2/)
* [SLO-matere](https://pxweb.stat.si/SiStatData/pxweb/sl/Data/-/05J1027S.px/table/tableViewLayout2/)
* [SLO-zveza](https://pxweb.stat.si/SiStatData/pxweb/sl/Data/-/05J1018S.px/table/tableViewLayout2/)
    
    
## Program

Glavni program in poročilo se nahajata v datoteki `projekt.Rmd`.
Ko ga prevedemo, se izvedejo programi, ki ustrezajo drugi, tretji in četrti fazi projekta:

* obdelava, uvoz in čiščenje podatkov: `uvoz/uvoz.r`
* analiza in vizualizacija podatkov: `vizualizacija/vizualizacija.r`
* napredna analiza podatkov: `analiza/analiza.r`

Vnaprej pripravljene funkcije se nahajajo v datotekah v mapi `lib/`.
Podatkovni viri so v mapi `podatki/`.
Zemljevidi v obliki SHP, ki jih program pobere,
se shranijo v mapo `../zemljevidi/` (torej izven mape projekta).

## Potrebni paketi za R

Za zagon tega vzorca je potrebno namestiti sledeče pakete za R:

* `knitr` - za izdelovanje poročila
* `rmarkdown` - za prevajanje poročila v obliki RMarkdown
* `shiny` - za prikaz spletnega vmesnika
* `DT` - za prikaz interaktivne tabele
* `rgdal` - za uvoz zemljevidov
* `rgeos` - za podporo zemljevidom
* `digest` - za zgoščevalne funkcije (uporabljajo se za shranjevanje zemljevidov)
* `readr` - za branje podatkov
* `rvest` - za pobiranje spletnih strani
* `tidyr` - za preoblikovanje podatkov v obliko *tidy data*
* `dplyr` - za delo s podatki
* `gsubfn` - za delo z nizi (čiščenje podatkov)
* `ggplot2` - za izrisovanje grafov
* `mosaic` - za pretvorbo zemljevidov v obliko za risanje z `ggplot2`
* `maptools` - za delo z zemljevidi
* `tmap` - za izrisovanje zemljevidov
* `extrafont` - za pravilen prikaz šumnikov (neobvezno)

## Binder

Zgornje [povezave](#analiza-podatkov-s-programom-r-202021)
omogočajo poganjanje projekta na spletu z orodjem [Binder](https://mybinder.org/).
V ta namen je bila pripravljena slika za [Docker](https://www.docker.com/),
ki vsebuje večino paketov, ki jih boste potrebovali za svoj projekt.

Če se izkaže, da katerega od paketov, ki ji potrebujete, ni v sliki,
lahko za sprotno namestitev poskrbite tako,
da jih v datoteki [`install.R`](install.R) namestite z ukazom `install.packages`.
Te datoteke (ali ukaza `install.packages`) **ne vključujte** v svoj program -
gre samo za navodilo za Binder, katere pakete naj namesti pred poganjanjem vašega projekta.

Tako nameščanje paketov se bo izvedlo pred vsakim poganjanjem v Binderju.
Če se izkaže, da je to preveč zamudno,
lahko pripravite [lastno sliko](https://github.com/jaanos/APPR-docker) z želenimi paketi.

Če želite v Binderju delati z git,
v datoteki `gitconfig` nastavite svoje ime in priimek ter e-poštni naslov
(odkomentirajte vzorec in zamenjajte s svojimi podatki) -
ob naslednjem zagonu bo mogoče delati commite.
Te podatke lahko nastavite tudi z `git config --global` v konzoli
(vendar bodo veljale le v trenutni seji).
