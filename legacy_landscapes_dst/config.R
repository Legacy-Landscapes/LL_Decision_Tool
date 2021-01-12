# This script only contains configurable values for the app


#-#-# Define text to be added to the different panels #-#-#

## Background panel
background_sidepanel <- 
  p("Frankfurt Zoological Society",
  p("Senckenberg Biodiversity and Climate Research Centre"),
  p(h5("Contact")),
  p(em("alke.voskamp@senckenberg.de")))

backround_mainpanel <-
  p(h4("Legacy Landscapes"),
  p("Legacy Landscapes is a new international public-private initiative, 
     led by the German   Government, to develop and implement a conservation 
     and financing strategy for the safeguarding of selected protected areas. 
     Legacy Landscapes will significantly contribute to the ‘post-2020 
     Biodiversity-Framework’ of the COP 15 at the CBD in 2020."),
  p(h5("The Legacy Landscapes concept is based on three pillars:")),
  p(strong("1."),"Permanent, stable and performance-based funding ensured by 
     a combination of private donors and public funds of about one 
     million $ per site per year"),
  p(strong("2."), "Effective and efficient management that will be caried out in 
     cooperation with national authorities and an NGO, with the annual 
     disbursement of funds being controlled by an independent platform, 
     and based on the fulfillment of certain indicators, the ‘key 
     performance indicators’."),
  p(strong("3."), "Strategic site selection"),
  p("This app has been developed in cooperation between the Frankfurt 
     Zoological Society and the Senckenberg Biodiversity and Climate 
     Research Centre to support the selection of suitable sites for the 
     Legacy Landscapes fund. The app facilitates the ranking of sites based 
     on their performance across six different conservation objectives:"), 
     strong("Biodiversity, Wilderness, Climatic stability, Land-use stability, 
     Climate protection and Size.")
  )

## Conservation objectives panel
objectives_weigting <-
  p("Use the sliders on the left to change the importance of the different 
     conservation objectives in the site ranking. The percentage weight allocated 
     to the different conservation objectives can be seen in the table on the right.", 
    p(em(strong("Note that combined allocated weights of the different conservation 
      objectives always sum up to 100%.")),style = "color:red"),style = "color:red")

objectives_strategy <-
  p(h4("The conservation objectives"),
    p("Six conservation objectives were selected to enable the comparison between 
       eligible sites for the Legacy Landscapes fund based on macroecological data. 
       The objectives were chosen to allow a first assessment based on the size of the 
       site, the biodiversity it contains, its intactness and its potential for future 
       persistence. Each of the conservation objectives is measured based on one or more 
       ecological variables as described below:"),
    p(strong("Biodiversity"),":includes the richness, endemism and diversity of species 
       comprising four different taxa (mammals, birds, reptiles and amphibians)"),
    p(strong("Wilderness"),":includes the Biodiversity Intactness Index (BII), the human 
       footprint and the observed change from biome to anthrome in the area over the past 
       20 years"),
    p(strong("Climatic stability"),":includes the projected stability of ecological 
       communities (mammals, birds, reptiles and amphibians) and the projected change 
       in tree cover by the mid of the century under a medium warming scenario"),
    p(strong("Land-use stability"),":includes the projected change in land-use in 
       the buffer zone around the site"),
    p(strong("Climate protection"),":includes the amount of baseline, vulnerable and 
       irreplaceable carbon storage within the site"),
    p(strong("Size of the site")),
    p("The six different conservation objectives can be combined into different 
       conservation goals as laid out in the figure below. Using the sliders on the 
       left the conservation objectives can be combined by allocating a weight to 
       each objective. Objectives allocated a weight of 0 are excluded from the weighting. 
       The according ranking based on the selected objectives and the allocated 
       importance (weight) ran be seen in the ‘Ranking Table’ tab. The location 
       of the top scoring sites can be seen in the ‘Ranking Map’ tab."),
    p(em("Details on the included variables, data sources and methods can be 
          found on the accompanying webpage")))

objectives_figure4 <- 
  p(strong("Conservation objectives and strategies"),
    "The six different conservation objectives Biodiversity, Wilderness, Climatic 
     stability, Land-use stability, Climate protection and Size can be combined into 
     different conservation goals. These conservation goals allow to weigh the different 
     conservation objectives against each other, to set priorities when selecting suitable 
     sites for the Legacy Landscapes fund.")

## Ranking table panel
Rtable_text <- 
  p("The ranking table shows the overall ranking of the potential sites based on the applied weights.")

## Ranking map panel
Rmap_text <- 
  p("The map shows the location of the top sites ranked by their suitability based on the applied weights 
     across the six conservation objectives. Depending on the selection the map shows either the top 30 
     sites globally or the top 10 sites for a biogeographic realm.",
  p("The choice of biogeographic realm can be changed on the previous page by using the", em("Select focal realm"), 
     "button. The white points show the locations for all sites included in the analysis. The red, orange and 
     yellow points show the location of the top sites with red indication the sites of highest suitability.")
     )
     

Rmap_disclaimer <- p("*The country boarders displayed in this map are derived from Natural Earth
    (version 4.1.0) and do not imply the expression of any opinion concerning the legal status of any
    country, area or territory or of its authorities, or concerning the delamination of its boarders.",
    style = "font-size:10px")


#-#-# Set variable and subset names #-#-#
## displayed variable names table
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

rownames_display <- list("biodiversity" = "Biodiversity",
                         "wilderness" = "Wilderness",
                         "climatic_stability" = "Climatic stability",
                         "land_use_stability" = "Land-use stability",
                         "climate_protection" = "Climate protection",
                         "area" = "Size")

## subset names to display a selection of the data
choices = list("Global" = "Global", "Afrotropic" = "Afrotropic", "Australasia" = "Australasia", "Indomalaya" = "Indomalaya",
               "Nearctic" = "Nearctic", "Neotropic" = "Neotropic", "Palearctic" = "Palearctic")



#-#-# Define the filepaths for the figures and data #-#-#

# data sources:
centroids <- "AppData/Global_IUCN_WHS_KBA_centroids.csv" #centroid data path
data_file <- "AppData/Final_dataset_IUCN_WHS_KBA_for_weighting_global.csv" # nolint
#site_maps_file <- "AppData/Combined_data_global_IUCN_WHS_KBA.shp" # nolint
worldmap_file <- "AppData/ne_50m_admin_0_countries/ne_50m_admin_0_countries.shp" # nolint
figure1 <- "Site_evaluation_concept.png"

n_top_sites <- 30
n_top_sites_realm <- 10

