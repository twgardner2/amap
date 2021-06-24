# 'tigris' requires 'rgdal', which requires 'units' and 'sf'. Install this stuff first:
# sudo apt-get install gdal-bin proj-bin libgdal-dev libproj-dev libudunits2-dev

library(leaflet)
library(tidyverse)
library(tigris)
library(RColorBrewer)

setwd('~/Documents/amap')

# cache zip boundaries that are download via tigris package
options(tigris_use_cache = TRUE)

# Helper values and functions
va_zipcodes <- c('20', '22', '23', '24')



# Load data
nvazips <- read.csv("data/nvazips.csv")
smInv <- read.csv("data/invoice_sm.csv")
zipcodes <- tigris::zctas(starts_with = va_zipcodes)

# Calculate zipcode totals
zipcode_totals <- smInv %>% 
  mutate(CustomerZip = str_sub(CustomerZip, start=1, end=5)) %>% 
  group_by(CustomerZip) %>% 
  summarize(zipcode_totals = sum(Amount))

zipcode_totals %>% select(zipcode_totals) %>% table()

# Geojoin totals with zipcodes
zipcodes_w_totals <- geo_join(zipcodes, 
         zipcode_totals, 
         by_sp = "GEOID10", 
         by_df = "CustomerZip",
         how = "left")
# Palette
bins <- c(0, 1e3, 1e4, 1e5, 1e6, Inf)
pal <- colorBin("YlOrRd", domain = zipcode_totals$zipcode_totals, bins = bins)


# Leaflet map
zipcodes_w_totals %>% 
  leaflet %>% 
  # add base map
  addProviderTiles("CartoDB") %>% 
  # add zip codes
  addPolygons(fillColor = ~pal(zipcode_totals),
              weight = 0.5,
              opacity = 1,
              color = "black",
              dashArray = "1",
              fillOpacity = 0.7,
              highlight = highlightOptions(weight = 2,
                                           color = "#666",
                                           dashArray = "",
                                           fillOpacity = 0.7,
                                           bringToFront = TRUE)) %>% 
  setView(lng = -77.8, lat = 38.7,  zoom = 9) %>% 
  # add legend
  addLegend(pal = pal, 
            values = ~zipcode_totals, 
            opacity = 0.7, 
            position = "bottomright")

