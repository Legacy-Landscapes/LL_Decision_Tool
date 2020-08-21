rm(list=ls())

library(shiny)
library(DT)
library(matrixStats)
library(maptools)
library(sf)
library(ggplot2)
library(rgdal)
library(sp)
library(rgeos)
library(rmapshaper)


#-#-# Loading the data that is used in shiny #-#-#
setwd("/Users/alkevoskamp/Documents/Legacy Landscapes/Site selection analysis/Site selection output/Combined outputs/")
BaseData <- read.csv("Final_dataset_IUCN_WHS_KBA_for_weighting_Afrotropical.csv")
head(BaseData)

WeightTable <- BaseData[c("Int_Name","Biodiversity","ClimateStability","LandUseStability","Wilderness","Area","ClimateProtection")]
head(WeightTable)


#-#-# Move HFP, ClimStab nad LU back to 0 to 1 scale #-#-#
PositiveData <- WeightTable[c("Int_Name","Biodiversity","Area","ClimateProtection")]
NegativeData <- WeightTable[c("ClimateStability","LandUseStability","Wilderness")]
Scaling <- lapply(1:ncol(NegativeData),function(s){
  print(s)
  oneCol <- NegativeData[s]
  name <- colnames(oneCol)
  oneColS <- (oneCol - min(oneCol,na.rm=T)) / (max(oneCol,na.rm=T) - min(oneCol,na.rm=T))
  colnames(oneColS) <- name
  return(oneColS)
})

ScaledNeg <- do.call(cbind,Scaling)
head(ScaledNeg)
str(ScaledNeg)
#setwd("/Users/alkevoskamp/Documents/LL shiny app/LL_app_data/")
#write.csv(ScaledNeg,"LL_Appdata.csv")

WeightTableS <- cbind(PositiveData,ScaledNeg)
WeightTableS$ID <- c(1:nrow(WeightTableS))
WeightTableS <- WeightTableS[order(WeightTableS["Int_Name"],decreasing=F),]
head(WeightTableS)


#-#-# Data for maps #-#-#
setwd("/Users/alkevoskamp/Documents/Legacy Landscapes/Site selection analysis/Combined data global/")
getinfo.shape("Combined_data_global_IUCN_WHS_KBA.shp") # Check the datastructure # Shapefile type: Polygon, (5), # of Shapes: 11408
SitePolygons <- readShapeSpatial("Combined_data_global_IUCN_WHS_KBA.shp")
head(SitePolygons@data)


#-#-# Worldmap (global and cropped) #-#-#
setwd("/Users/alkevoskamp/Documents/LL shiny app/LL_app_data/ne_50m_admin_0_countries/")
worldmap <- readOGR("ne_50m_admin_0_countries.shp", layer="ne_50m_admin_0_countries")

## Simplify the worldmap polygon
WorldSimple <- gSimplify(worldmap, tol=0.1, topologyPreserve=TRUE)
plot(WorldSimple)
length(WorldSimple)

## Turn into sf readable object
WorldSimple <- st_as_sf(WorldSimple)


#-#-#-#-#-#-#-#-#-#-#-#-# Define the layout of the LL shiny app web page #-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#
ui <- fluidPage(
  headerPanel('Setting priorities for longterm conservation'), ## This is the overall header
  
  ## Set the slider options in the side bar panel
  sidebarPanel(
    sliderInput(inputId = "Biodiversity_weight", 
                label = "High biodiversity", 
                value = 0, min = 0, max = 1, step = 0.1, ticks = F),
    sliderInput(inputId = "Wilderness_weight", 
                label = "High wilderness", 
                value = 0, min = 0, max = 1, step = 0.1, ticks = F),
    sliderInput(inputId = "Climatic_stability_weight", 
                label = "High climatic stability", 
                value = 0, min = 0, max = 1, step = 0.1, ticks = F),
    sliderInput(inputId = "Land_use_stability_weight", 
                label = "High land-use stability", 
                value = 0, min = 0, max = 1, step = 0.1, ticks = F),
    sliderInput(inputId = "Climate_protection_weight", 
                label = "High climate protection", 
                value = 0, min = 0, max = 1, step = 0.1, ticks = F),
    sliderInput(inputId = "Area_weight", 
                label = "Large area", 
                value = 0, min = 0, max = 1, step = 0.1, ticks = F),
    width = 3
  ),
  
  ## Set the different tabs in the main panel
  mainPanel(
    tabsetPanel(type="tabs",
      tabPanel("Conservation objectives",
        textOutput("Heading"),       
        textOutput("Intro")),
      tabPanel("Weighting the objectives",
        textOutput("selected_var"),
        tableOutput("values")),
      tabPanel("Ranking Table",
        tableOutput("table1")),
      tabPanel("Ranking map",
               textOutput("site_name"),
               plotOutput("map1"))
    ), width=6
  )
)


#-#-#-#-#-#-#-#-#-#-#-#-# Define the content of the shiny app #-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#
server <- function(input, output) {
  
  #-#-# Set the table that shows the chosen percentages from the sliders #-#-#
  sliderValuesTable <- reactive({   # Reactive returns what is in the last line within the brackets (or set to return)

    Total <- sum(input$Biodiversity_weight,input$Wilderness_weight,
                           input$Climatic_stability_weight,input$Land_use_stability_weight,
                           input$Climate_protection_weight,input$Area_weight)
    OnePerc <- Total/100

    WeightData <- data.frame(
      Conservation_Objective = c("High biodiversity",
               "High wilderness",
               "High climatic stability",
               "High land-use stability",
               "High climate protection",
               "Large area",
               "Sum"),
      Percentage_weight = as.numeric(c(input$Biodiversity_weight/OnePerc,
                             input$Wilderness_weight/OnePerc,
                             input$Climatic_stability_weight/OnePerc,
                             input$Land_use_stability_weight/OnePerc,
                             input$Climate_protection_weight/OnePerc,
                             input$Area_weight/OnePerc,
                             sum(input$Biodiversity_weight/OnePerc,
                                 input$Wilderness_weight/OnePerc,
                                 input$Climatic_stability_weight/OnePerc,
                                 input$Land_use_stability_weight/OnePerc,
                                 input$Climate_protection_weight/OnePerc,
                                 input$Area_weight/OnePerc)),
      stringsAsFactors = FALSE))
    
    colnames(WeightData) <- c("Conservation objective", "Weight (in %)")
    
    return(WeightData)

    })
  
  
  #-#-# Show the changing percentages in an HTML table and annotate the table #-#-#
  output$Heading <- renderText({
    head1 <- "Introduction to the conservation objectives."
    HTML(paste(head1)) 
  })
  
  output$Intro <- renderText({ # This is the introduction text
    line1 <- "Legacy Landscapes is a new international private-public initiative, 
    led by the German Government, to develop and implement a conservation and finance
    strategy for the long-term safeguarding of selected protected areas. 
    Legacy Landscapes will significantly contribute to the ‘post-2020 Biodiversity 
    Framework’ of the COP 15 at the CBD in 2020."
    line2 <- "Explanation how to use the decision support tool."
    HTML(paste(line1, line2)) 
  })
  
  
  #-#-# Show the changing percentages in an HTML table and annotate the table #-#-#
  output$selected_var <- renderText({ # This is the explanation text above the table
  str1 <- "Percentage weight allocated to the different conservation objectives."
  str2 <- "Note that combined allocated weights of the differnt objectives always sum up to 100%."
  HTML(paste(str1, str2)) 
  })
  
  output$values <- renderTable({ # This displays the changable table
  sliderValuesTable()
  })

  
  #-#-# Set the table that shows the ranking of the different sites based on the set weights #-#-#
  dataValuesTable <- reactive({

    RankData <- data.frame(DF1 <- data.frame(ID = WeightTableS$ID,
                                             Site_name = WeightTableS$Int_Name,
                                             High_biodiversity_weight = (c(WeightTableS$Biodiversity)*input$Biodiversity_weight),
                                             High_wilderness_weight = (c(WeightTableS$Wilderness)*input$Wilderness_weight),
                                             High_climatic_stability_weight = (c(WeightTableS$ClimateStability)*input$Climatic_stability_weight),
                                             High_land_use_stability_weight = (c(WeightTableS$LandUseStability)*input$Land_use_stability_weight),
                                             High_climate_protection_weight = (c(WeightTableS$ClimateProtection)*input$Climate_protection_weight),
                                             Large_area_weight = (c(WeightTableS$Area)*input$Area_weight),
                                             stringsAsFactors = FALSE),
                           DF2 <- data.frame(RankFlex = c(rowMeans(as.matrix(cbind(c(WeightTableS$Biodiversity)*input$Biodiversity_weight,
                                                                               c(WeightTableS$Wilderness)*input$Wilderness_weight,
                                                                               c(WeightTableS$ClimateStability)*input$Climatic_stability_weight,
                                                                               c(WeightTableS$LandUseStability)*input$Land_use_stability_weight,
                                                                               c(WeightTableS$ClimateProtection)*input$Climate_protection_weight,
                                                                               c(WeightTableS$Area)*input$Area_weight),ncol=6))),
                                                                               stringsAsFactors = FALSE))
     #-#-# Order and restructure the output table #-#-#
     RankData <- RankData[order(RankData["RankFlex"],decreasing=T),] # Decreasing T - because the highest weighted mean score is the best
     RankData$Rank <- c(1:nrow(RankData)) # Add a rank to each site
     RankData <- RankData[c("Rank","Site_name","ID")] # Only those two - the other values change because they are multiplied with the weight
     RankData <- merge(RankData,WeightTableS,by="ID",all.x=T) # Merge original values back into table?
     RankData <- RankData[c("Rank","Site_name","Biodiversity","Area","ClimateProtection","ClimateStability","LandUseStability","Wilderness")]
     RankData <- RankData[order(RankData["Rank"],decreasing=F),] # Order again because merging reshuffles the data - decreasing F because now it start with rank 1 
     RankData <- RankData[1:20,] # Show only top 20
     return(RankData)
    })
  
  
  #-#-# Set the plot that shows the ranking of the different sites based on the set weights #-#-#
  dataValuesPlot <- reactive({
    RankDataP <- dataValuesTable()
    
    Site1 <- as.vector(RankDataP$Site_name[1])
    Site2 <- as.vector(RankDataP$Site_name[2])
    Site3 <- as.vector(RankDataP$Site_name[3])
    Site4 <- as.vector(RankDataP$Site_name[4])
    Site5 <- as.vector(RankDataP$Site_name[5])
    Site6 <- as.vector(RankDataP$Site_name[6])
    Site7 <- as.vector(RankDataP$Site_name[7])
    Site8 <- as.vector(RankDataP$Site_name[8])
    Site9 <- as.vector(RankDataP$Site_name[9])
    Site10 <- as.vector(RankDataP$Site_name[10])
 
    Poly1 <- SitePolygons[SitePolygons@data$IntName == Site1,]
    Poly2 <- SitePolygons[SitePolygons@data$IntName == Site2,]
    Poly3 <- SitePolygons[SitePolygons@data$IntName == Site3,]
    Poly4 <- SitePolygons[SitePolygons@data$IntName == Site4,]
    Poly5 <- SitePolygons[SitePolygons@data$IntName == Site5,]
    Poly6 <- SitePolygons[SitePolygons@data$IntName == Site6,]
    Poly7 <- SitePolygons[SitePolygons@data$IntName == Site7,]
    Poly8 <- SitePolygons[SitePolygons@data$IntName == Site8,]
    Poly9 <- SitePolygons[SitePolygons@data$IntName == Site9,]
    Poly10 <- SitePolygons[SitePolygons@data$IntName == Site10,]
    
    #Poly10 <- SitePolygons[SitePolygons@data$IntName == "Virunga",]
    #CombinedPoly <- rbind(Poly10,Poly10)
    
    CombinedPoly <- rbind(Poly1,Poly2,Poly3,Poly4,Poly5,
                          Poly6,Poly7,Poly8,Poly9,Poly10)
    
    CombinedPoly <- ms_simplify(CombinedPoly)
    CombinedPolySF <- st_as_sf(CombinedPoly)
    st_crs(CombinedPolySF) <- "+proj=longlat +datum=WGS84 +no_defs"

    Poly1.df <- fortify(Poly1, region = "IntName")
    Poly2.df <- fortify(Poly2, region = "IntName")
    Poly3.df <- fortify(Poly3, region = "IntName")
    Poly4.df <- fortify(Poly4, region = "IntName")
    Poly5.df <- fortify(Poly5, region = "IntName")
    Poly6.df <- fortify(Poly6, region = "IntName")
    Poly7.df <- fortify(Poly7, region = "IntName")
    Poly8.df <- fortify(Poly8, region = "IntName")
    Poly9.df <- fortify(Poly9, region = "IntName")
    Poly10.df <- fortify(Poly10, region = "IntName")
    
    CombinedPolyF <- rbind(Poly1.df,Poly2.df,Poly3.df,Poly4.df,Poly5.df,
                          Poly6.df,Poly7.df,Poly8.df,Poly9.df,Poly10.df)
    
    idList <- CombinedPoly@data$SP_ID
    centroids.df <- as.data.frame(coordinates(CombinedPoly))
    names(centroids.df) <- c("Longitude", "Latitude")  
    NameList <- CombinedPoly@data$IntName
    
    name.df <- data.frame(id = idList, name = NameList, centroids.df)
    
    plot <- ggplot(name.df) + #
      geom_sf(data = WorldSimple, fill = NA) +
      geom_sf(data = CombinedPolySF, fill = "red", color = "red") + #, lwd = 2
      coord_sf(xlim = c(-30, 60), ylim = c(-40, 40), expand = FALSE) +
      #geom_text(aes(label = name, x = Longitude, y = Latitude)) + 
      geom_segment(aes(x = -30, xend = 60, y = 0, yend = 0), colour="black", linetype="dashed") + #Add shortened equator line 
      theme(legend.position = "none") + # Positioning the legend 
      theme(axis.title=element_text(size=28)) + # Change font size legend
      theme(panel.background=element_rect(fill='white',colour="white")) + # Remove the background
      labs(x="", y="", title="") + # Remove axis titles
      theme(axis.ticks.y = element_blank(),axis.text.y = element_blank(), # Get rid of axis ticks/text
            axis.ticks.x = element_blank(),axis.text.x = element_blank()) +
      ggtitle("Top 10 sites") + 
      theme(plot.title = element_text(size = 21,face="bold",hjust = 0))
    return(plot)

  })

  #-#-# Show the changing ranks in an HTML table #-#-#
  output$table1 <- renderTable({
  dataValuesTable()
  })
  
  #-#-# Show the top sites in a global map #-#-# 
  output$map1 <- renderPlot(
  dataValuesPlot() 
  )
}
  
#-#-#-#-#-#-#-#-#-#-#-#-# Send everything to the server #-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#
shinyApp(ui = ui, server = server)




### Chaos...

#   ?sliderInput

