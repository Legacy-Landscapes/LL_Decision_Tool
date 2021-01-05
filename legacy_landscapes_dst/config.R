# This script only contains configurable values for the app


#-#-# Define text and pictures to be added to the different panels #-#-#

## Background panel
background_sidepanel <- 
  p("Frankfurt Zoological Society",
  p("Senckenberg Biodiversity and Climate Research Centre"),
  p(h5("Contact")),
  p(h6(em("alke.voskamp@senckenberg.de"))))

backround_mainpanel <-
  p(h4("Legacy Landscapes"),
  p("Legacy Landscapes is a new international private-public initiative,
  led by the German Government, to develop and implement a conservation and
  finance strategy for the long-term safeguarding of selected protected areas.
  Legacy Landscapes will significantly contribute to the ‘post-2020 Biodiversity
  Framework’ of the COP 15 at the CBD in 2020.
  Explanation how to use the decision support tool."))

## Conservation objectives panel
objectives_weigting <-
  p("Percentage weight allocated to the different conservation objectives.
  Note that combined allocated weights of the different objectives
  always sum up to 100%.")

objectives_strategy <-
  p(h4("The conservation objectives"),
  p("Percentage weight allocated to the different conservation objectives.
  Note that combined allocated weights of the different objectives
  always sum up to 100%."))


# displayed variable names
colnames_display <- list("int_name" = "International Name",
                         "RealmNr" = "RealmNr",
                         "biodiversity" = "Biodiversity",
                         "wilderness" = "Wilderness",
                         "climatic_stability" = "Climatic stability",
                         "land_use_stability" = "Land-use stability",
                         "area" = "Size",
                         "climate_protection" = "Climate protection",
                         "RealmName" = "Realm",
                         "ID" = "ID")


# data sources:
centroids <- "AppData/Global_IUCN_WHS_KBA_centroids.csv" #centroid data path
data_file <- "AppData/Final_dataset_IUCN_WHS_KBA_for_weighting_global.csv" # nolint
#site_maps_file <- "AppData/Combined_data_global_IUCN_WHS_KBA.shp" # nolint
worldmap_file <- "AppData/ne_50m_admin_0_countries/ne_50m_admin_0_countries.shp" # nolint
figure1 <- "Site_evaluation_concept.png"

n_top_sites <- 30

