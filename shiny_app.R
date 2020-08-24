
library(shiny)
source("app_functions.R")
source("config.R")
source("load_data.R")


# load data
weight_data <- load_weight_data(data_file, columns_positive, columns_negative)
site_polygons <- load_site_maps(site_maps_file)
worldmap <- load_worldmap(worldmap_file)


# layout definition
ui <- fluidPage(
  headerPanel("Setting priorities for longterm conservation"),
  ## This is the overall header

  # Set the slider options in the side bar panel
  sidebarPanel(
    sliderInput(
      inputId = "biodiversity_weight",
      label = "High biodiversity",
      value = 0,
      min = 0,
      max = 1,
      step = 0.1,
      ticks = F
    ),
    sliderInput(
      inputId = "wilderness_weight",
      label = "High wilderness",
      value = 0,
      min = 0,
      max = 1,
      step = 0.1,
      ticks = F
    ),
    sliderInput(
      inputId = "climatic_stability_weight",
      label = "High climatic stability",
      value = 0,
      min = 0,
      max = 1,
      step = 0.1,
      ticks = F
    ),
    sliderInput(
      inputId = "land_use_stability_weight",
      label = "High land-use stability",
      value = 0,
      min = 0,
      max = 1,
      step = 0.1,
      ticks = F
    ),
    sliderInput(
      inputId = "climate_protection_weight",
      label = "High climate protection",
      value = 0,
      min = 0,
      max = 1,
      step = 0.1,
      ticks = F
    ),
    sliderInput(
      inputId = "area",
      label = "Large area",
      value = 0,
      min = 0,
      max = 1,
      step = 0.1,
      ticks = F
    ),
    width = 3
  ),

  # Set the different tabs in the main panel
  mainPanel(
    tabsetPanel(
      type = "tabs",
      tabPanel(
        "Conservation objectives",
        textOutput("heading"),
        textOutput("intro")
      ),
      tabPanel(
        "Weighting the objectives",
        textOutput("selected_var"),
        tableOutput("values")
      ),
      tabPanel("Ranking Table",
               tableOutput("table1")),
      tabPanel("Ranking map",
               textOutput("site_name"),
               plotOutput("map1"))
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

  weighing <- reactive({
    weights <- get_weights()
    return(rank_data(weight_data, weights, n_top_sites))
  })

  plot_sites <- reactive({
    ranked_data <- weighing()
    selected_polygons <-
      select_polygons(ranked_data, site_polygons, n_top_sites)
    return(plot_maps(selected_polygons))
  })

  # Show the changing percentages in an HTML table and annotate the table
  output$heading <- renderText({
    htmltools::HTML(intro_head)
  })

  # This is the introduction text
  output$intro <- renderText({
    htmltools::HTML(intro_text)
  })

  # This is the explanation text above the table
  output$selected_var <- renderText({
    htmltools::HTML(weight_text)
  })

  # This displays the changeable table
  output$values <- renderTable({
      weights <- get_weights()
      as.data.frame(weights)
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
