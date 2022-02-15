
#-#-# Set load data functions #-#-#

# Function to load site data table 
load_weight_data <- function(filename) {
  colnames_mapping <- list("Int_Name" = "int_name",
                           "RealmNr" = "RealmNr",
                           "PA_type" = "PA_type",
                           "COUNTRY" = "Country",
                           "ODA" = "ODA_status",
                           "Biodiversity" = "biodiversity",
                           "Wilderness" = "wilderness",
                           "ClimateStability" = "climatic_stability",
                           "LandUseStability" = "land_use_stability",
                           "Size" = "area",
                           "ClimateProtection" = "climate_protection")
  data <- read.csv(filename)
  data$Int_Name <- iconv(data$Int_Name,"WINDOWS-1252","UTF-8")
  data <- data[names(colnames_mapping)]  # select columns
  colnames(data) <- colnames_mapping  # rename columns
  data$RealmName <- 0
  data$RealmName[data$RealmNr == 1] <- "Australasia"
  data$RealmName[data$RealmNr == 3] <- "Afrotropic"
  data$RealmName[data$RealmNr == 4] <- "Indomalaya"
  data$RealmName[data$RealmNr == 5] <- "Nearctic"
  data$RealmName[data$RealmNr == 6] <- "Neotropic"
  data$RealmName[data$RealmNr == 8] <- "Palearctic"
  return(data)
}


# Function to load the site centroid coordinates file
load_pa_centroids <- function(filename) {  # load the centroid file
  data <- read.csv(filename)
  colnames(data) <- c("C_ID", "International Name", "x", "y")
  return(data)
}


# Function to load the country boarders shapefile
load_worldmap <- function(filename) {
  worldmap <- sf::st_read(filename, layer = "ne_50m_admin_0_countries")
  worldmap <- st_transform(worldmap, "ESRI:54030")
  worldmap <- simplify_polygons(worldmap)
  return(worldmap)
}


# Function to load and format the realm layer for the map
load_realmmap <- function(filename) {
  realmmap <- get(load(filename))
  realmmap <- subset(realmmap, y > -60)
  realmmap <- na.omit(realmmap)
  realmmap <- subset(realmmap, !(RealmWWF == 2))
  realmmap <- subset(realmmap, !(RealmWWF == 7))

  realmraster<- rasterFromXYZ(realmmap)
  crs(realmraster) <- "+proj=longlat +datum=WGS84 +no_defs +ellps=WGS84 +towgs84=0,0,0" 
  realmraster <- projectRaster(realmraster, crs = "+proj=robin +over")

  
  realmraster_df <- as.data.frame(realmraster, xy = TRUE) 
  realmraster_df$RealmWWF <- round(realmraster_df$RealmWWF,0)
  realmraster_df[is.na(realmraster_df)] <- 0
  
  realmraster_df$RealmName <- 0
  realmraster_df$RealmName[realmraster_df$RealmWWF == 1] <- "Australasia"
  realmraster_df$RealmName[realmraster_df$RealmWWF == 3] <- "Afrotropic"
  realmraster_df$RealmName[realmraster_df$RealmWWF == 4] <- "Indomalaya"
  realmraster_df$RealmName[realmraster_df$RealmWWF == 5] <- "Nearctic"
  realmraster_df$RealmName[realmraster_df$RealmWWF == 6] <- "Neotropic"
  realmraster_df$RealmName[realmraster_df$RealmWWF == 8] <- "Palearctic"
  #colnames(realmmap) <- c("x", "y", "RealmNr", "Realm")
  return(realmraster_df)
}

#-#-# helper functions #-#-#

# Function to simplify polygon layers and speed up displaying the map
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


# Function to transform data projection
project_for_sf <- function(func, sf_data, ...) {
  # sf can not correctly project longlat format, so we project to
  # mercator, simplify and then project back to longlat
  crs <- sf::st_crs(sf_data)
  sf_data <- sf::st_transform(sf_data, 3857)
  sf_data <- func(sf_data, ...)
  sf_data <- sf::st_transform(sf_data, crs)
  return(sf_data)
}

#-#-# Set global variables #-#-#
utils::globalVariables(c("rownames_display", "colnames_display"))


