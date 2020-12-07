
#-#-# load data functions #-#-#

load_weight_data <- function(filename) {
  data <- read.csv(filename)
  data <- data[c("Int_Name","RealmNr","Biodiversity","Wilderness","ClimateStability","LandUseStability","Area","ClimateProtection")]
  colnames(data) <- c("int_name","RealmNr","biodiversity","wilderness","climatic_stability","land_use_stability","area","climate_protection")
  data <- data[c("RealmNr","int_name","biodiversity","wilderness","climatic_stability","land_use_stability","area","climate_protection")]

  return(data)
}


load_PA_centroids <- function(filename) { #load the centroid file
  data <- read.csv(filename)
  colnames(data) <- c("C_ID","int_name","x","y")
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

