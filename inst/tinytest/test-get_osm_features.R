library(tinytest)
library(checkmate)
using("checkmate")

## qgis inputs
Id = "5310938770"
Type = "node"

rsx_file = "get_osm_feature.rsx"

if (endsWith(getwd(), "inst/tinytest")) {
  rsx_file = file.path(
    "../.."
    , rsx_file
  )
}

source(rsx_file)

expect_class(
  Output
  , classes = c("sf", "data.frame")
  , info = "produces vector output"
)

expect_identical(
  Output$osm_id
  , target = Id
  , info = "downloads requested object"
)
