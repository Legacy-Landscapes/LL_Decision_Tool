
library(shiny)
library(shinyWidgets)
source("app_functions.R")
source("config.R")
source("load_data.R")


# load data
pa_centroids <- load_pa_centroids(centroids)
weight_data <- load_weight_data(data_file) 
worldmap <- load_worldmap(worldmap_file)


# layout definition
ui <- fluidPage(
  headerPanel("Setting priorities for longterm conservation"),
  ## This is the overall header

  # Set the slider options in the side bar panel
  sidebarPanel(
    sliderInput(
      inputId = "biodiversity_weight",
      label = "Biodiversity",
      value = 0,
      min = 0,
      max = 1,
      step = 0.1,
      ticks = F
    ),
    sliderInput(
      inputId = "wilderness_weight",
      label = "Wilderness",
      value = 0,
      min = 0,
      max = 1,
      step = 0.1,
      ticks = F
    ),
    sliderInput(
      inputId = "climatic_stability_weight",
      label = "Climatic stability",
      value = 0,
      min = 0,
      max = 1,
      step = 0.1,
      ticks = F
    ),
    sliderInput(
      inputId = "land_use_stability_weight",
      label = "Land-use stability",
      value = 0,
      min = 0,
      max = 1,
      step = 0.1,
      ticks = F
    ),
    sliderInput(
      inputId = "climate_protection_weight",
      label = "Climate protection",
      value = 0,
      min = 0,
      max = 1,
      step = 0.1,
      ticks = F
    ),
    sliderInput(
      inputId = "area_weight",
      label = "Size",
      value = 0,
      min = 0,
      max = 1,
      step = 0.1,
      ticks = F
    ),
    width = 2),

  # Set the different tabs in the main panel
  mainPanel(
    tabsetPanel(
      type = "tabs",
      tabPanel(
        "Background",
        sidebarLayout(
        mainPanel(backround_mainpanel,
                  img(src = figure3, height = 350, width = 430),
                  background_figure3, width = 12),
        sidebarPanel(background_sidepanel,width = 12),
        position="left"),
        mainPanel(img(src = figure1, height = 60, width = 60), ZGF_credits, width = 5),
        mainPanel(img(src = figure2, height = 50, width = 220), SGN_credits, width = 7)
      ),
      tabPanel(
        "Conservation objectives",
        sidebarLayout(
        sidebarPanel(objectives_weigting,width=6),
        mainPanel(tableOutput("values"),width=6)),
        objectives_strategy,
        img(src = figure4, height = 340, width = 550),
        objectives_figure4
      ),
      tabPanel("Ranking table",
               sidebarLayout(
               sidebarPanel(width = 12, prettyRadioButtons("radio", label = h3("Select focal realm"),
                            choices = choices, icon = icon("check"), animation = "pulse", status = "default", 
                            inline = T)),
               mainPanel(width = 12, Rtable_text)),
               tableOutput("table1")
               ),
      tabPanel("Ranking map",
               Rmap_text,
               textOutput("site_name"),
               plotOutput("map1"),
               Rmap_disclaimer)
    ),
    width = 6
  )
)


# logic definition
server <- function(input, output) {
  get_weights <- reactive({
    slider_values <- get_slider_values(input = input)
    return(calculate_weights(slider_values))
  })
  
  set_weights_table <- reactive({
    slider_values <- get_slider_values(input = input)
    return(calculate_weights_table(slider_values))
  })

  get_selection <- reactive({
    selected_extent <- input$radio
    return(selected_extent)
  })
  
  weighing <- reactive({
    weights <- get_weights()
    selection <- get_selection()
    return(rank_data(weight_data, weights, n_top_sites, selection)) 
  })

  plot_sites <- reactive({
    ranked_data <- weighing()
    selection <- get_selection() #
    if(selection == "Global"){
    selected_sites <- ranked_data[1:n_top_sites, ]
    }else{
    selected_sites <- ranked_data[1:n_top_sites_realm, ]
    }
    selected_sites <- merge(selected_sites,
                               pa_centroids,
                               by = "International Name", # this needs to be changed - easier if each site has a unique ID
                               all.x = T)
    return(plot_maps(selected_sites, pa_centroids, worldmap, selection)) #
  })

  # This displays the changeable table
  output$values <- renderTable({
     set_weights_table()
  }, rownames = TRUE)

  # Show the changing ranks in an HTML table
  output$table1 <- renderTable({
    weighing()
  })

  # Show the top sites in a global map
  output$map1 <- renderPlot({
    plot_sites()
  })
}


# run the app
shinyApp(ui = ui, server = server)

