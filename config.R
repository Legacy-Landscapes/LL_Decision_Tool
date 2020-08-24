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
data_file <- "/home/tiuti/Downloads/ll_data/Final_dataset_IUCN_WHS_KBA_for_weighting_Afrotropical.csv" # nolint
site_maps_file <- "/home/tiuti/Downloads/ll_data/Combined_data_global_IUCN_WHS_KBA.shp" # nolint
worldmap_file <- "/home/tiuti/Downloads/ll_data/ne_50m_admin_0_countries/ne_50m_admin_0_countries.shp" # nolint


# variables:
columns_positive <- c("Int_Name",
                      "Biodiversity",
                      "Area",
                      "ClimateProtection")
columns_negative <- c("ClimateStability",
                      "LandUseStability",
                      "Wilderness")

n_top_sites <- 10
  