
library(ggplot2)


get_slider_values <- function(input) {
  return(
    c(
      biodiversity = input$biodiversity_weight,
      wilderness = input$wilderness_weight,
      climatic_stability = input$climatic_stability_weight,
      land_use_stability = input$land_use_stability_weight,
      climate_protection = input$climate_protection_weight,
      area = input$area_weight
    )
  )
}


plot_maps <- function(selected_sites, pa_centroids, worldmap) {
  # split sites into three categories for coloring
  n_sites <- nrow(selected_sites)
  splits <- round(n_sites / 3)
  selected_sites$ranks <- c(rep("1", splits),
                               rep("2", splits),
                               rep("3", n_sites - (2 * splits)))
  
  # plot
  plot <- ggplot(selected_sites) +
    geom_sf(data = worldmap, fill = NA) +
    # Four types of points to show all and selected sites
    geom_point(data = pa_centroids,
               aes(x = x, y = y),
               shape = 8,
               size = 0.2,
               colour = "grey") +
    geom_point(data = selected_sites,
               aes(x = x, y = y, color = ranks),
               shape = 8,
               size = 1) +
    scale_color_manual(values = c("1" = "red",
                                  "2" = "orange",
                                  "3" = "yellow")) +
    coord_sf(xlim = c(-170, 180), ylim = c(-60, 90), expand = FALSE) +
    # Add shortened equator line
    geom_segment(
      aes(x = -180, xend = 180, y = 0, yend = 0),
      colour = "black",
      linetype = "dashed"
    ) +
    theme(legend.position = "none") +
    theme(axis.title = element_text(size = 16)) +
    theme(panel.background = element_rect(fill = "white", colour = "white")) +
    labs(x = "", y = "", title = "") +
    theme(
      axis.ticks.y = element_blank(),
      axis.text.y = element_blank(),
      axis.ticks.x = element_blank(),
      axis.text.x = element_blank()
    ) +
    ggtitle(paste("Top", n_sites, "sites globally")) +
    theme(plot.title = element_text(size = 21, face = "bold", hjust = 0))
  
  return(plot)
}


calculate_weights <- function(slider_values) {
  total <- sum(slider_values)
  one_percent <- total / 100
  weights <- slider_values / one_percent
  weights <- as.data.frame(weights, col.names = "weight")
  return(weights)
}


rank_data <- function(data_table, weights, max_sites = 30) {
  ranked <- data_table
  summed <- numeric(nrow(ranked)) # vector of zeros
  keys <- rownames(weights)
  for (key in keys) {
    value <- weights[key, ]
    ranked[, key] <- ranked[, key] * value
    summed <- summed + ranked[, key]
  }
  ranked <- data.frame(ranked, total_weight = summed)
  ranked <- ranked[order(ranked$total_weight, decreasing = TRUE), ]
  ranked$rank <- seq(nrow(ranked))
  return(ranked[1:max_sites, ])
}

