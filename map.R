# library(readxl)
library(ggmap)
library(ggpubr)
library(ggExtra)
# library(corrplot)
library(psych)
# library(ellipse)
library(caret)
library(readxl)
library(DescTools)
library(plotly)
library(scales)
library(caret)
library(tidyverse)
library(dplyr)

library(devtools)
# install_github('arilamstein/choroplethrMaps')
library(choroplethr)
library(choroplethrZip)

setwd("~/MSBA/MOD5/MAP")

nvazips=read.csv("data/nvazips.csv")
smInv=read.csv("data/invoice_sm.csv")

map <- smInv %>% select(CustomerZip, Amount)

map <- map %>% group_by(CustomerZip) %>% summarise(value=sum(Amount))
map <- rename(map, region = CustomerZip)
map
validMap <- map[grepl("^[0-9]{5}(?:-[0-9]{4})?$", map$region),]
validMap <- validMap %>% filter(value > 1000)


# nvazips <- rename(nvazips, region = ZIP.Code, value=Population)

# data(df_pop_zip)
zip_choropleth(validMap, 
               state_zoom = "virginia",
               title      = "VTA ",
               legend     = "Revenue")










### I dunno whats below this line















nyc_fips = c(36005, 36047, 36061, 36081, 36085)
zip_choropleth(df_pop_zip,
               county_zoom = nyc_fips,
               title       = "2012 New York City ZCTA Population Estimates",
               legend      = "Population")

zip_choropleth(df_pop_zip,
               msa_zoom = "New York-Newark-Jersey City, NY-NJ-PA",
               title    = "2012 NY-Newark-Jersey City MSA\nZCTA Population Estimates",
               legend   = "Population")


library(dplyr)
library(choroplethrMaps)
data(county.regions)

regions <- county.regions %>% filter(state.abb=="VA")

nva_names = c("alexandria" , "arlington" , "clarke" , "culpeper" , "fairfax" , "falls church" , "fauquier" , "frederick" , "fredericksburg" , "loudoun" , "madison" , "manassas" , "manassas park" , "prince william" , "rappahannock" , "spotsylvania" , "stafford" , "warren" , "winchester" )

nva_county_fips = regions %>%
  filter(county.name %in% nyc_county_names) %>%
  select(region)

  nva_county_fips = regions %>%
  # filter(county.name %in% nyc_county_names) %>%
  select(region)

county_choropleth(df_pop_county, 
                title        = "Population of Counties in New York City",
                legend       = "Population",
                num_colors   = 1,
                county_zoom = nva_county_fips$region)



library(muRL)
data(murljobs)
zip.plot(murljobs)
murljobs <- read.murl(system.file("extdata", "murljobs.csv", package = "muRL"))
zip.plot(murljobs, map.type = "state", region = "maryland")

zip.plot(validMap, map.type = "state", region = "maryland")

zip_choropleth(validMap, 
               map.type   = "state",
               state_zoom = "virginia", 
               title      = "2012 ZCTA Population Estimates",
               legend     = "Population")

# 
# library(dplyr)
# library(choroplethrMaps)
# data(.regions)
# 
# regions <- .regions %>% filter(state.abb=="VA")
# 
# 
# 
# nyc_fips = regions %>%
#   filter(state.abb=="VA" & .name %in% nyc__names) %>%
#   select(region)
# 
# _choropleth(df_pop_, 
#             title        = "Population of Counties in New York City",
#             legend       = "Population",
#             num_colors   = 1,
#             _zoom = nyc__fips$region)