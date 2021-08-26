# This script only contains configurable values for the app


#-----# Define text to be added to the different panels #-----#

#-#-# Background panel texts #-#-#
background_sidepanel <-
  p(h5("Contact"),
  p(em("alke.voskamp@senckenberg.de")))

zgf_credits <- p("Frankfurt Zoological Society")

sgn_credits <- p(p("Senckenberg Biodiversity and Climate Research Centre"))

backround_mainpanel_part_0 <-
  p(h4("The decision support tool"),
    p("The establishment and maintenance of protected areas (PAs) is viewed as a 
    key action in delivering post 2020 biodiversity targets and reaching the 
    sustainable development goals. PAs are expected to meet a wide range of 
    objectives, ranging from biodiversity protection to ecosystem service provision 
    and climate change mitigation. As available land and conservation funding are 
    limited, optimizing resources by selecting the most beneficial PAs is 
    therefore vital.", style = "text-align: justify;"), 
    p("This decision support tool enables a flexible approach to PA selection on a 
    global scale, which allows different conservation objectives to be weighted 
    and prioritized. It is meant to facilitate a first evaluation of the potential 
    of PAs for long term conservation before following up with detailed on the 
    ground assessments of the candidate sites.", style = "text-align: justify;"),
    p("The current version of the decision support tool contains a set of 1347 PAs.
    The included PAs were selected as a case study subset based loosely on the 
    criteria of the Legacy Landscapes Fund.", style = "text-align: justify;"))

backround_mainpanel_part_1 <-
  p(h4("Legacy Landscapes Fund"),
  p("Legacy Landscapes is a new international public-private initiative,
     led by the German   Government, to develop and implement a conservation
     and financing strategy for the safeguarding of selected protected areas.
     The Legacy Landscapes Fund has a terrestrial focus and will significantly
     contribute to the post-2020 Biodiversity-Framework of the COP 15 at
     the CBD in 2020.",
    h5("The Legacy Landscapes Fund concept is based on three pillars:"),
  p(strong("1."), "Permanent, stable and performance-based", 
    strong("funding"),"ensured by a combination of private donors and public 
    funds of about one million $ per site per year", style = "text-align: justify;"),
  p(strong("2."), "Effective and efficient", strong("management"), "that will
    be caried out in cooperation with national authorities, local communities and an NGO, with
    the annual disbursement of funds being controlled by an independent platform,
    and based on the fulfillment of certain indicators, the key
    performance indicators.", style = "text-align: justify;"),
    p(strong("3."), "Strategic site selection, based on the", 
    strong("biogeography"),"of the site", style = "text-align: justify;"), style = "text-align: justify;"))

backround_mainpanel_part_2 <-
  p(p("This decision support tool has been developed in cooperation between the 
     Frankfurt Zoological Society and the Senckenberg Biodiversity and Climate
     Research Centre to support the selection of suitable sites for the
     Legacy Landscapes Fund. The tool enables the comparison of potential sites
     based on macro-ecological variables and thus falls under the
     ‘Biogeography’ cornerstone of the Legacy Landscapes Fund concept. It
     facilitates the ranking of sites based on their performance across
     six different conservation objectives:", style = "text-align: justify;"),
     strong("Biodiversity, Ecosystem integrity, Climatic stability, Land-use
     stability, Climate protection and Size."), style = "text-align: justify;"
  )

background_figure3 <-
  p(p(strong("Figure 1: The three cornerstones of the Legacy
             Landscapes Fund concept"), "permanent, stable and performance-based
             funding; effective and efficient management and strategic site
             selection.", style = "text-align: justify;"))


#-#-# Conservation objectives panel texts #-#-#
objectives_strategy <-
  p(h4("The conservation objectives"),
    p("Six conservation objectives were selected to enable the comparison
     protected areas and evaluate their potential for long term conservation 
     based on macroecological data. The objectives were chosen to allow a first
     assessment based on the size of the site, the biodiversity it contains,
     its intactness and its potential for future persistence. Each of the
     conservation objectives is measured based on one or more macro-ecological
     variables as described below:", style = "text-align: justify;"),
    p(strong("Biodiversity:"), "includes the richness, endemism and diversity
      of species comprising four different taxa (mammals, birds, reptiles and
      amphibians)", style = "text-align: justify;"),
    p(strong("Ecosystem integrity:"), "includes the Biodiversity Intactness Index (BII),
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
    p(em("Details on the included variables and data sources and can be
          found in the text box at the bottom of the page.")))

objectives_figure4 <-
  p(p(strong("Figure 2: Conservation objectives and strategies"),
    "The six different conservation objectives Biodiversity, Ecosystem integrity,
    Climatic stability, Land-use stability, Climate protection and Size can
    be combined into different conservation goals. These conservation goals
    allow to weigh the different conservation objectives against each other,
    to set priorities when evaluation sites for conservation.", style = "text-align: justify;"))


#-#-# Site evaluation panel texts #-#-#
Rtable_text <-
  p(h4("Site evaluation based on weighted objectives"),
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
  p(strong("If the weights for 'Biodiversity' and 'Ecosystem integrity' are both set to 50%, you
    will see that the 'Talamanca Range' is the top site. This is because it
    has the second highest biodiversity among the included sites, with a 'Biodiversity'
    score of 0.99. But it also has a clear human footprint, indicated by the 'Ecosystem integrity'
    score of 0.71. In comparison the combined site 'Manu - Alto Purus' ranks third
    globally with a very good 'Biodiversity' score of 0.70 but additionally it is also
    very pristine with a very high 'Ecosystem integrity' score of 0.93.", style = "color:green"),
  p(em("The ranking table can be adjusted by using the sliders on the left
    hand side. Allocating different weights to the individual objectives will
    change the ranking of the sites. Using the"),
  em(strong("Select focal realm")), em("buttons above the table, the ranking
    table can be subset to show the resulting ranking for the individual
    realms or across all sites globally."), style = "text-align: justify;"), 
    style = "text-align: justify;"), style = "text-align: justify;"))


#-#-# Site map panel texts #-#-#
Rmap_text <-
  p(h4("Location of the selected sites"),
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
    style = "text-align: justify;"))

Rmap_disclaimer <-
  p(h6(tags$i("The country boarders displayed in this map are derived from Natural Earth
    (version 4.1.0) and do not imply the expression of any opinion concerning
    the legal status of any country, area or territory or of its authorities,
    or concerning the delamination of its boarders.")), style = "text-align: justify;")


#-#-# How to use panel texts #-#-#
Uncertainty_text <-
  p(h4("Interpreting the evaluation results"),
  p("The different conservation objectives are underly different sources of uncertainty,
    which need to be taken into account when using the decision support tool and 
    interpreting the evaluation results. See text box below for a brief description of 
    the uncertainty associated with each conservation indicator.", style = "text-align: justify;"))


#-#-# Side panel texts #-#-#
header_weighting <- h3("Weigh the objectives")
objectives_weigting <-
  p("Use the sliders to change the importance of the different
     conservation objectives in the site ranking.", style = "text-align: justify;",
     p(em("The colour code indicates the expected error margin, ranging from", 
       strong("green (high certainty)", style = "color:green"), "to", 
       strong("red (uncertain).", style = "color:red"), 
       "An objective can be left out of the site evaluation by leaving 
       its slider at 0."), style = "text-align: justify;"),
       p(em("The percentage weight allocated to the different conservation 
       objectives can be seen in the table below."), style = "text-align: justify;"))
objectives_table_disclaimer <-    
  p(em(strong("Note that combined allocated weights of the different
     conservation objectives always sum up to 100%.")), style = "text-align: justify;")


#-----# Set variable and subset names #-----#

#-#-# Displayed variable names table #-#-#
colnames_display <- list("int_name" = "International Name",
                         "RealmNr" = "RealmNr",
                         "biodiversity" = "Biodiversity",
                         "wilderness" = "Ecosystem integrity",
                         "climatic_stability" = "Climatic stability",
                         "land_use_stability" = "Land-use stability",
                         "area" = "Size",
                         "climate_protection" = "Climate protection",
                         "RealmName" = "Realm",
                         "ID" = "ID")

rownames_display <- list("biodiversity" = "Biodiversity",
                         "wilderness" = "Ecosystem integrity",
                         "climatic_stability" = "Climatic stability",
                         "land_use_stability" = "Land-use stability",
                         "climate_protection" = "Climate protection",
                         "area" = "Size")

#-#-# Subset names to display a selection of the data #-#-#
choices <- list("Global" = "Global",
               "Afrotropic" = "Afrotropic",
               "Australasia" = "Australasia",
               "Indomalaya" = "Indomalaya",
               "Nearctic" = "Nearctic",
               "Neotropic" = "Neotropic",
               "Palearctic" = "Palearctic")


#-----# Define the filepaths for the figures and data #-----#

#-#-# Data sources #-#-#
centroids <- "AppData/Global_IUCN_WHS_KBA_centroids.csv" # nolint
data_file <- "AppData/Final_dataset_IUCN_WHS_KBA_for_weighting_global.csv" # nolint
worldmap_file <- "AppData/ne_50m_admin_0_countries/ne_50m_admin_0_countries.shp" # nolint
figure1 <- "FZS_logo.jpg" # nolint
figure2 <- "Senckenberg_logo.png" # nolint
figure3 <- "Legacy_Landscapes_pillars.png" # nolint
figure4 <- "Concept_figure_site_selection.png" # nolint
layer_description <- "Layer_descriptions.pdf" # nolint
user_manual <- "How_to_use_the_app.pdf" # nolint


#-#-# Set number of top sites displayed #-#-#
n_top_sites <- 30
n_top_sites_realm <- 10


