##Toolboxes=group
##ValueLayer=vector
##QgsProcessingParameterField|ValueField|Value field|None|ValueLayer|QgsProcessingParameterDataType.Numeric|False|False
##GroupLayer=vector
##QgsProcessingParameterField|GroupField|Grouping field|None|GroupLayer|QgsProcessingParameterDataType.String|False|True
##QgsProcessingParameterNumber|Digits|Number of decimal places|QgsProcessingParameterNumber.Integer|1
##Output=output table
##Calculate Area-Weighted Average=name

library(dplyr)

# intersect value and boundary layers
clipped_values = suppressWarnings(
  sf::st_intersection(
    ValueLayer
    , GroupLayer
  )
)

# compute areas
area_col = basename(tempfile())
clipped_values[[area_col]] = as.numeric(
  sf::st_area(clipped_values)
)

# calculate statistics
Output = sf::st_drop_geometry(clipped_values) %>% 
  {
    if (nzchar(GroupField)) dplyr::group_by_at(., GroupField) else .
  } |> 
  summarize(

    # minimum
    min = min(.data[[ValueField]])

    # weighted mean
    , mean = stats::weighted.mean(
      .data[[ValueField]]
      , w = .data[[area_col]]
    ) |> 
      round(
        digits = Digits # default `1L`
      )
    
    # maximum
    , max = max(.data[[ValueField]])
    , .groups = "keep"
  )
