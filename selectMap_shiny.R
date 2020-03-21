library(mapedit)
library(leaflet)
library(mapview)
library(tidyverse)
library(sf)

Warna <- c("Andesit" = "red4", "TanahPenutup" = "peru", 
           "Tufa" = "darkorange", "Pasir" = "yellow2", 
           "Lempung" = "forestgreen", "Screen" = "blue",
           "Breksi" = "chocolate4", "Kerikil" = "yellow",
           "Lava" = "red1")

url <- "https://raw.githubusercontent.com/malikarrahiem/thesismalik/master/Complete_Logs.csv?token=AMDKGMXFOOP6CAQ4JJ2OJXS6ODU6A"
Logs <- read.csv(url, header = TRUE)

datamap <- selectMap(
  leaflet(Logs) %>%
    addTiles() %>%
    addCircleMarkers(data = Logs, 
                                      ~Longitude, ~Latitude, 
                                      layerId = ~KodeSumur, 
                                      popup = ~KodeSumur, 
                                      radius = 5, 
                                      weight= 5,
                                      stroke = TRUE,
                                      label = ~KodeSumur,
                                      color = 'navy',
                                      group = "Wells")
)

datamap

PlotPenampang <- function (x){
  KodeSumur2 <- datamap$id
  x <- Logs[Logs$KodeSumur %in% KodeSumur2,] %>% 
    mutate(KodeSumur=factor(KodeSumur, levels = datamap$id)) %>% 
    arrange(KodeSumur)
  PlotGrafik(x)
}

PlotPenampang(datamap)
