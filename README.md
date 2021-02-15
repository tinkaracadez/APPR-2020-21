# Analiza podatkov s programom R, 2020/21

Repozitorij z gradivi pri predmetu APPR v študijskem letu 2020/21

* [![Shiny](http://mybinder.org/badge.svg)](http://mybinder.org/v2/gh/tinkaracadez/APPR-2020-21/master?urlpath=shiny/APPR-2020-21/projekt.Rmd) Shiny
* [![RStudio](http://mybinder.org/badge.svg)](http://mybinder.org/v2/gh/tinkaracadez/APPR-2020-21/master?urlpath=rstudio) RStudio

## Tematika

### Analiza rodnosti v Sloveniji in primerjava z evropskimi državami

#### Predstavitev teme: 

Odločila sem se, da bom analizirala rodnost v Sloveniji in jo primerjava z ostalimi državami EU. Za zadnjih 10 let bom za različne spremenjivke natančneje analizirala število živorojenih otrok v Sloveniji, nato pa za enako časovno obdobje primerjala samo število rojstev v Sloveniji v primerjavi z ostalimi evropskimi državami.

Rodnost v Sloveniji oz. število živorojenih otrok bom analizirala glede na:

* statistično regijo
* mesec rojstva

Z ostalimi evropskimi državami pa bom nato primerjala le samo število rojstev živorojenih otrok (za obdobje 10 let).
Tu bom navedla:

* državo
* število živorojenih otrok v določenem letu
    
    
#### Cilji: 

V okviru projekta bom najprej ugotovila, koliko otrok je bilo letno rojenih v posameznih regijah, katera regija jih je imela največ v vsakem letu in kakšno je povprečje v obravnavanem obdobju. Prav tako bom ugotavljala, katerega meseca je bilo v posameznih letih rojenih največ otrok in kako je s tem v povprečju v obravnavanem obdobju. 
Na koncu pa bom samo število živorojenih otrok v Sloveniji primerjala s številom le-teh v ostalih evropskih državah in na ta način ugotovila, v kateri državi je bilo največ rojstev ter izračunala, kakšno je bilo maksimalno, minimalno in povprečno število rojstev po državah v zadnjem desetjetju.


#### Podatki: 

Podatke bom iz naslednjih spletnih strani izvozila v različnih formatih(HTML in CSV).

* [Eurostat](https://ec.europa.eu/eurostat/databrowser/view/DEMO_FMONTH__custom_270818/default/table?lang=en)
* [Statistični urad Republike Slovenije](https://pxweb.stat.si/sistat/Podrocja/Index/100/prebivalstvo)

    
    
## Program

Glavni program in poročilo se nahajata v datoteki `projekt.Rmd`.
Ko ga prevedemo, se izvedejo programi, ki ustrezajo drugi, tretji in četrti fazi projekta:

* obdelava, uvoz in čiščenje podatkov: `uvoz/uvoz.R`
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
