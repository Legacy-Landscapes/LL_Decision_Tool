# This script only contains configurable values for the app


# text
intro_head <- "Introduction to the conservation objectives."
intro_text <-
  "Legacy Landscapes is a new international private-public initiative,
  led by the German Government, to develop and implement a conservation and
  finance strategy for the long-term safeguarding of selected protected areas.
  Legacy Landscapes will significantly contribute to the ‘post-2020 Biodiversity
  Framework’ of the COP 15 at the CBD in 2020.
  Explanation how to use the decision support tool."
weight_text <-
  "Percentage weight allocated to the different conservation objectives.
  Note that combined allocated weights of the different objectives
  always sum up to 100%."


# data sources:
centroids <- "/Users/alkevoskamp/Documents/GitHub/LL_Decision_Tool/AppData/Global_IUCN_WHS_KBA_centroids.csv" #centroid data path
data_file <- "/Users/alkevoskamp/Documents/GitHub/LL_Decision_Tool/AppData/Final_dataset_IUCN_WHS_KBA_for_weighting_global.csv" # nolint
site_maps_file <- "/Users/alkevoskamp/Documents/GitHub/LL_Decision_Tool/AppData/Combined_data_global_IUCN_WHS_KBA.shp" # nolint
worldmap_file <- "/Users/alkevoskamp/Documents/GitHub/LL_Decision_Tool/AppData/ne_50m_admin_0_countries/ne_50m_admin_0_countries.shp" # nolint


# variables:
# columns_positive <- c("Int_Name",
#                       "Biodiversity",
#                       "Area",
#                       "ClimateProtection")
# columns_negative <- c("ClimateStability",
#                       "LandUseStability",
#                       "Wilderness")

n_top_sites <- 10
  
