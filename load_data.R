
#-#-# load data functions #-#-#

load_weight_data <- function(filename, columns_positive, columns_negative) {
  data <- read.csv(data_file)
  data <- data[c(
    columns_positive,
    columns_negative
  )]

  # scale negative columns
  data[columns_negative] <- normalize(data[columns_negative])
  data$id <- seq(nrow(data)) # why is this necessary?
  data <- data[order(data["Int_Name"], decreasing = FALSE), ]
  colnames(data) <- c(
    "int_name",
    "biodiversity",
    "area",
    "climate_protection",
    "climatic_stability",
    "land_use_stability",
    "wilderness",
    "id"
  )

  return(data)
}


load_site_maps <- function(filename) {
  data <- sf::st_read(filename)
  sf::st_crs(data) <- "+proj=longlat +datum=WGS84 +no_defs"
  data <- simplify_polygons(data)
  return(data)
}


load_worldmap <- function(filename) {
  worldmap <- sf::st_read(filename, layer = "ne_50m_admin_0_countries")
  worldmap <- simplify_polygons(worldmap)
  return(worldmap)
}


simplify_polygons <- function(sf_data, tolerance = 0.1) {
  return(
    project_for_sf(
      sf::st_simplify,
      sf_data,
      preserveTopology = TRUE,
      dTolerance = tolerance
    )
  )
}


#-#-# helper functions #-#-#

normalize <- function(df) {
  return(data.frame(lapply(df, function(x) scales::rescale(x, c(0, 1)))))
}


project_for_sf <- function(func, sf_data, ...) {
  # sf can not correctly project longlat format, so we project to
  # mercator, simplify and then project back to longlat
  crs <- sf::st_crs(sf_data)
  sf_data <- sf::st_transform(sf_data, 3857)
  sf_data <- func(sf_data, ...)
  sf_data <- sf::st_transform(sf_data, crs)
  return(sf_data)
}
