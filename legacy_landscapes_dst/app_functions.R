
library(ggplot2)
library(dplyr) # dplyr added to the functions


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


plot_maps <- function(selected_sites, pa_centroids, worldmap, selection) {
  # split sites into three categories for coloring
  n_sites <- nrow(selected_sites)
  splits <- round(n_sites / 3)
  selected_sites$suitability <- c(rep("Very high", splits),
                               rep("High", splits),
                               rep("Good", n_sites - (2 * splits)))

  # plot
  plot <- ggplot(selected_sites) +
    geom_sf(data = worldmap, fill = "black", color = "grey60", size = 0.2) +
    # Four types of points to show all and selected sites
    geom_point(data = pa_centroids,
               aes(x = x, y = y),
               shape = 16,
               size = 0.2,
               colour = "grey90") +
    geom_point(data = selected_sites,
               aes(x = x, y = y, color = suitability),
               shape = 18,
               size = 2.5) +
    scale_color_manual(name = "Suitability top sites:",
                       values = c("Very high" = "red",
                                  "High" = "orange",
                                  "Good" = "gold")) +
    coord_sf(xlim = c(-170, 180), ylim = c(-60, 90), expand = FALSE) +
    # Add shortened equator line
    geom_segment(
      aes(x = -180, xend = 180, y = 0, yend = 0),
      colour = "black",
      linetype = "dashed"
    ) +
    theme(legend.key = element_blank(), legend.position = "bottom",
          legend.title = element_text(size = 14, face = "bold"),
          legend.text = element_text(size = 12)) +
    guides(colour = guide_legend(override.aes = list(size = 5))) +
    theme(axis.title = element_text(size = 16)) +
    theme(panel.background = element_rect(fill = "white", colour = "white")) +
    labs(x = "", y = "", title = "") +
    theme(
      axis.ticks.y = element_blank(),
      axis.text.y = element_blank(),
      axis.ticks.x = element_blank(),
      axis.text.x = element_blank()) +
    ggtitle(paste("Location top", n_sites, "sites", selection)) +
    theme(plot.title = element_text(size = 21, face = "bold", hjust = 0))
  return(plot)
}


calculate_weights <- function(slider_values) {
  total <- sum(slider_values)
  one_percent <- total / 100
  weights <- slider_values / one_percent
  weights <- as.data.frame(weights, col.names = "weights")
  return(weights)
}

calculate_weights_table <- function(slider_values) {
  total <- sum(slider_values)
  one_percent <- total / 100
  weights_table <- slider_values / one_percent
  weights_table <- as.data.frame(weights_table)
  row.names(weights_table) <- rownames_display
  colnames(weights_table) <- "Percentage weight"
  return(weights_table)
}

#add selected realm value into function
rank_data <- function(data_table, weights, selection) {
  ranked <- data_table
  ranked$ID <- c(1:nrow(ranked)) # add ID to merge data later
  ranked_orig_vals <- ranked # keep original values to display
  colnames(ranked_orig_vals) <- colnames_display # add display names
  summed <- numeric(nrow(ranked)) # vector of zeros
  keys <- rownames(weights)
  for (key in keys) {
    value <- weights[key, ]
    ranked[, key] <- ranked[, key] * value
    summed <- summed + ranked[, key]
  }
  ranked <- data.frame(ranked, total_weight = summed)
  ranked_orig_vals <- merge(ranked_orig_vals, ranked[c("ID", "total_weight")], by = "ID") # merge original values with weight
  ranked_orig_vals <-
    ranked_orig_vals[order(ranked_orig_vals$total_weight, decreasing = TRUE), ] # order by weight
  ranked_orig_vals$Rank <- seq(nrow(ranked_orig_vals)) # add rank for display
  ranked_orig_vals <- ranked_orig_vals[c(12, 10, 2, 4, 5, 6, 7, 9, 8)] # select order and columns to display
  ranked_orig_vals %>% mutate_if(is.numeric, ~round(., 2)) # round to 2 decimals to display
  
  if (!selection == "Global") {
    ranked_orig_vals <- subset(ranked_orig_vals, Realm == selection)
    ranked_orig_vals$Rank <- c(1:nrow(ranked_orig_vals))

    return(ranked_orig_vals)
  }

    return(ranked_orig_vals)
}

