# GLOBALS ====

setwd(
  file.path(
    "C:/Users/florian.detsch/AppData/Roaming/QGIS/QGIS3/profiles/default",
    "processing/rscripts"
  )
)


# 2025-06-04 ====

## GET OSM FEATURE ====

library(osmdata)

poi = opq_osm_id(
  "5310938770"
  , type = "node"
) |> 
  opq_string() |> 
  osmdata_sf()

getElement(
  poi
  , name = "osm_points"
)


# 2025-06-05 ====

## UNIT TESTING ====

tinytest::run_test_dir()
