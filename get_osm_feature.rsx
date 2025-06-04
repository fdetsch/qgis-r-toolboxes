##Toolboxes=group
##QgsProcessingParameterString|Id|Object ID, e.g. "5310938770"
##Type=enum literal node;way;relation
##Output=output vector
##Get OSM Feature=name

feature = osmdata::opq_osm_id(
  Id
  , type = Type
) |>
  osmdata::opq_string() |>
  osmdata::osmdata_sf()

Output = feature$osm_points
