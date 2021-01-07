library(knitr)
library(rvest)
library(gsubfn)
library(tidyr)
library(tmap)
library(shiny)
library(stringr)
library(dplyr)
library(ggplot2)
library(rgdal)
library(RColorBrewer)
library(emojifont)
require(readr)
require(readxl)
require(openxlsx)

options(gsubfn.engine="R")

# Uvozimo funkcije za pobiranje in uvoz zemljevida.
source("lib/uvozi.zemljevid.r", encoding="UTF-8")
