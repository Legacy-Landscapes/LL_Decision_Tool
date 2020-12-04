
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


plot_maps <- function(selected_polygons) {
  #centroids <- project_for_sf(sf::st_centroid, selected_polygons)
  #selected_polygons <- cbind(selected_polygons, sf::st_coordinates(centroids))
  
  selected_polygons <- merge(selected_polygons,pa_centroids,by="int_name",all.x=T)
  
  ggplot(nba, aes(x= MIN, y= PTS, colour="green", label=Name))+
    geom_point() +geom_text(aes(label=Name),hjust=0, vjust=0)
  
  
  plot <- ggplot(selected_polygons) +
  #plot <- ggplot(selected_polygons,aes(x= x, y= y, shape = 8, size = 1, colour="red", label=int_name))
    #geom_sf(data = worldmap, fill = NA) +
    #geom_sf(data = selected_polygons, fill = "red", color = "red") +
    geom_point(data=selected_polygons,aes(x=x, y=y,label=int_name), shape=8, size = 1,colour="red")
    coord_sf(xlim = c(-30, 60), ylim = c(-40, 40), expand = FALSE) +
    # Add shortened equator line
    geom_segment(
      aes(x = -30, xend = 60, y = 0, yend = 0),
      colour = "black",
      linetype = "dashed"
    ) +
    theme(legend.position = "none") +
    theme(axis.title = element_text(size = 28)) +
    theme(panel.background = element_rect(fill = "white", colour = "white")) +
    labs(x = "", y = "", title = "") +
    theme(
      axis.ticks.y = element_blank(),
      axis.text.y = element_blank(),
      axis.ticks.x = element_blank(),
      axis.text.x = element_blank()
    ) +
    ggtitle("Top 10 sites") +
    theme(plot.title = element_text(size = 21, face = "bold", hjust = 0))

  return(plot)
}


#select_polygons <- function(ranked_data, all_polygons, n = 10) {
#  return(all_polygons[all_polygons$SP_ID %in% ranked_data$id[1:n], ])
#}


calculate_weights <- function(slider_values) {
  total <- sum(slider_values)
  one_percent <- total / 100
  weights <- slider_values / one_percent
  weights <- as.data.frame(weights, col.names = "weight")
  return(weights)
}


rank_data <- function(data_table, weights, max_sites = 20) {
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
