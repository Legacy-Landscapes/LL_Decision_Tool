
#-#-# load data functions #-#-#

load_weight_data <- function(filename) {
  colnames_mapping <- list("Int_Name" = "int_name",
                           "RealmNr" = "RealmNr",
                           "Biodiversity" = "biodiversity",
                           "Wilderness" = "wilderness",
                           "ClimateStability" = "climatic_stability",
                           "LandUseStability" = "land_use_stability",
                           "Size" = "area",
                           "ClimateProtection" = "climate_protection")
  data <- read.csv(filename)
  data <- data[names(colnames_mapping)]  # select columns
  colnames(data) <- colnames_mapping  # rename columns
  data$RealmName <- 0
  data$RealmName[data$RealmNr == 1] <- "Australasian"
  data$RealmName[data$RealmNr == 3] <- "Afrotropic"
  data$RealmName[data$RealmNr == 4] <- "Indomalaya"
  data$RealmName[data$RealmNr == 5] <- "Nearctic"
  data$RealmName[data$RealmNr == 6] <- "Neotropic"
  data$RealmName[data$RealmNr == 8] <- "Palearctic"
  return(data)
}


load_pa_centroids <- function(filename) {  # load the centroid file
  data <- read.csv(filename)
  colnames(data) <- c("C_ID", "International Name", "x", "y")
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

