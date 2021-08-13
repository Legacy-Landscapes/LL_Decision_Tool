# This script only contains configurable values for the app


#-#-# Define text to be added to the different panels #-#-#

## Background panel
background_sidepanel <-
  p(h5("Contact"),
  p(em("alke.voskamp@senckenberg.de")))

zgf_credits <- p("Frankfurt Zoological Society")

sgn_credits <- p(p("Senckenberg Biodiversity and Climate Research Centre"))

backround_mainpanel_part_1 <-
  p(h4("Legacy Landscapes"),
  p("Legacy Landscapes is a new international public-private initiative,
     led by the German   Government, to develop and implement a conservation
     and financing strategy for the safeguarding of selected protected areas.
     Legacy Landscapes has a terrestrial focus and will significantly
     contribute to the ‘post-2020 Biodiversity-Framework’ of the COP 15 at
     the CBD in 2020.",
    h5("The Legacy Landscapes concept is based on three pillars:"),
  p(strong("1."), "Permanent, stable and performance-based", 
    strong("funding"),"ensured by a combination of private donors and public 
    funds of about one million $ per site per year", style = "text-align: justify;"),
  p(strong("2."), "Effective and efficient", strong("management"), "that will
    be caried out in cooperation with national authorities and an NGO, with
    the annual disbursement of funds being controlled by an independent platform,
    and based on the fulfillment of certain indicators, the ‘key
    performance indicators’.", style = "text-align: justify;"),
    p(strong("3."), "Strategic site selection, based on the", 
    strong("biogeography"),"of the site", style = "text-align: justify;"), style = "text-align: justify;"))

backround_mainpanel_part_2 <-
  p(p("This app has been developed in cooperation between the Frankfurt
     Zoological Society and the Senckenberg Biodiversity and Climate
     Research Centre to support the selection of suitable sites for the
     Legacy Landscapes fund. The app enables the comparison of potential sites
     based on macro-ecological variables and thus falls under the
     ‘Biogeography’ cornerstone of the Legacy Landscapes concept. It
     facilitates the ranking of sites based on their performance across
     six different conservation objectives:", style = "text-align: justify;"),
     strong("Biodiversity, Wilderness, Climatic stability, Land-use
     stability, Climate protection and Size."), style = "text-align: justify;"
  )

background_figure3 <-
  p(p(strong("Figure 1: The three cornerstones of the Legacy
             Landscapes concept"), "permanent, stable and performance-based
             funding; effective and efficient management and strategic site
             selection.", style = "text-align: justify;"))

## Conservation objectives panel
header_weighting <- h3("Weigh the objectives")
objectives_weigting <-
  p("Use the sliders above to change the importance of the different
     conservation objectives in the site ranking. The percentage weight
     allocated to the different conservation objectives can be seen in the
     table below.",style = "text-align: justify;")
 objectives_table_disclaimer <-    
    p(em(strong("Note that combined allocated weights of the different
     conservation objectives always sum up to 100%.")), style = "text-align: justify;")

objectives_strategy <-
  p(h4("The conservation objectives"),
    p("Six conservation objectives were selected to enable the comparison
     between eligible sites for the Legacy Landscapes fund based on
     macroecological data. The objectives were chosen to allow a first
     assessment based on the size of the site, the biodiversity it contains,
     its intactness and its potential for future persistence. Each of the
     conservation objectives is measured based on one or more macro-ecological
     variables as described below:", style = "text-align: justify;"),
    p(strong("Biodiversity:"), "includes the richness, endemism and diversity
      of species comprising four different taxa (mammals, birds, reptiles and
      amphibians)", style = "text-align: justify;"),
    p(strong("Wilderness:"), "includes the Biodiversity Intactness Index (BII),
      the human footprint and the observed change from biome to anthrome
      in the area over the past 20 years", style = "text-align: justify;"),
    p(strong("Climatic stability:"), "includes the projected stability of
      ecological communities (mammals, birds, reptiles and amphibians) and
      the projected change in tree cover by the mid of the century under a
      medium warming scenario", style = "text-align: justify;"),
    p(strong("Land-use stability:"),"includes the projected change in land-use
      in the buffer zone around the site", style = "text-align: justify;"),
    p(strong("Climate protection:"), "includes the amount of baseline,
      vulnerable and irreplaceable carbon storage within the site", 
      style = "text-align: justify;"),
    p(strong("Size of the site:"), "is the extent of the site in km2", 
      style = "text-align: justify;"),
    p("The six different conservation objectives can be combined into different
       conservation goals as laid out in the figure below. Using the sliders on
       the left the conservation objectives can be combined by allocating a
       weight to each objective. Objectives allocated a weight of 0 are
       excluded from the weighting. The resulting ranking based on the selected
       objectives and the allocated importance (weight) can be seen in the",
       strong(em("Site evaluation")), "tab. The location of the top scoring sites
        can be seen in the", strong(em("Site Map")), "tab.", style = "text-align: justify;"),
    p(em("Details on the included variables, data sources and methods can be
          found on the accompanying webpage")))

objectives_figure4 <-
  p(p(strong("Figure 2: Conservation objectives and strategies"),
    "The six different conservation objectives Biodiversity, Wilderness,
    Climatic stability, Land-use stability, Climate protection and Size can
    be combined into different conservation goals. These conservation goals
    allow to weigh the different conservation objectives against each other,
    to set priorities when selecting suitable sites for the Legacy Landscapes
    fund.", style = "text-align: justify;"))

## Ranking table panel
Rtable_text <-
  p("The ranking table shows the overall ranking of the potential sites based
    on the applied weights. The values for the different conservation
    objectives are scaled across all sites included in the ranking. The values
    range from 0 to 1, with 0 being allocated to the site with the lowest score
    and 1 being allocated to the site with the highest score for the
    conservation objective. The scaled ranks are shown for each conservation
    objective, for each site on the right hand site of the table and remain the
    same independent of the weighting. This means the scaled value that a site has
    for a certain conservation objective indicates the overall ranking position
    of that site for that objective, as the following example shows:",
  p(strong("If the weights for 'Biodiversity' and 'Wilderness' are both set to 50%, you
    will see that the 'Talamanca Range' is the top site. This is because it
    has the second highest biodiversity among the included sites, with a 'Biodiversity'
    score of 0.99. But it also has a clear human footprint, indicated by the 'Wilderness'
    score of 0.71. In comparison the combined site 'Manu - Alto Purus' ranks third
    globally with a very good 'Biodiversity' score of 0.70 but additionally it is also
    very pristine with a very high 'Wilderness' score of 0.93.", style = "color:green"),
  p(em("The ranking table can be adjusted by using the sliders on the left
    hand side. Allocating different weights to the individual objectives will
    change the ranking of the sites. Using the"),
  em(strong("Select focal realm")), em("buttons above the table, the ranking
    table can be subset to show the resulting ranking for the individual
    realms or across all sites globally."), style = "text-align: justify;"), 
    style = "text-align: justify;"), style = "text-align: justify;")

## Ranking map panel
Rmap_text <-
  p("The map shows the location of the top sites ranked by their suitability
    based on the applied weights across the six conservation objectives.
    Depending on the selection the map shows either the top 30 sites globally
    or the top 10 sites for a selected biogeographic realm.",
  p("The white points show the locations for all sites included in the analysis.
    The red, orange and yellow points show the location of the top sites with
    red indicating the sites of highest suitability.",
  p(em("The choice of biogeographic realm can be changed by using the"),
    strong(em("Select focal realm")), "button on the previous page.", 
    style = "text-align: justify;"), style = "text-align: justify;"),
    style = "text-align: justify;")

Rmap_disclaimer <-
  p(h6(tags$i("The country boarders displayed in this map are derived from Natural Earth
    (version 4.1.0) and do not imply the expression of any opinion concerning
    the legal status of any country, area or territory or of its authorities,
    or concerning the delamination of its boarders.")), style = "text-align: justify;")


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
choices <- list("Global" = "Global",
               "Afrotropic" = "Afrotropic",
               "Australasia" = "Australasia",
               "Indomalaya" = "Indomalaya",
               "Nearctic" = "Nearctic",
               "Neotropic" = "Neotropic",
               "Palearctic" = "Palearctic")



#-#-# Define the filepaths for the figures and data #-#-#

# data sources:
centroids <- "AppData/Global_IUCN_WHS_KBA_centroids.csv" # nolint
data_file <- "AppData/Final_dataset_IUCN_WHS_KBA_for_weighting_global.csv" # nolint
worldmap_file <- "AppData/ne_50m_admin_0_countries/ne_50m_admin_0_countries.shp" # nolint
figure1 <- "FZS_logo.png" # nolint
figure2 <- "Senckenberg_logo.png" # nolint
figure3 <- "Legacy_Landscapes_pillars.png" # nolint
figure4 <- "Concept_figure_site_selection.png" # nolint

n_top_sites <- 30
n_top_sites_realm <- 10

#-#-# Content download report 
Table_intro <- p("This table shows...")
