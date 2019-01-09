
# MAPA de Vazoes por Cluster =========================================

#Genera Data para Mapa ---------
clus_dat<-eventReactive(input$vaz_clus_boton,{
  D_aux <- switch(input$vaz_clus_metric,
                  'D_ccor'=DistMatrix(BDDv[c(-1,-2),],Metrica = 'ccor'),
                  'D_cor'=DistMatrix(BDDv[c(-1,-2),],Metrica = 'cor'),
                  'D_cort'=DistMatrix(BDDv[c(-1,-2),],Metrica = 'cort'),
                  'D_acf'=DistMatrix(BDDv[c(-1,-2),],Metrica = 'acf'),
                  'D_euc'=DistMatrix(BDDv[c(-1,-2),],Metrica = 'euc'),
                  'D_fourier'=DistMatrix(BDDv[c(-1,-2),],Metrica = 'fourier'),
                  'D_ifnrm'=DistMatrix(BDDv[c(-1,-2),],Metrica = 'infnorm'),
                  'D_manh'=DistMatrix(BDDv[c(-1,-2),],Metrica = 'manhattan'),
                  'D_mink'=DistMatrix(BDDv[c(-1,-2),],Metrica = 'minkowski'),
                  'D_pacf'=DistMatrix(BDDv[c(-1,-2),],Metrica = 'pacf'),
                  'D_per'=DistMatrix(BDDv[c(-1,-2),],Metrica = 'per')
  )
  
  aux_cluster <- cluster_geografico(D=D_aux,k=as.numeric(input$vaz_clus_k),
                                    tipo=input$vaz_clus_metod,
                                    vazoes_code)
  
  return(aux_cluster$BDD_cluster)
})

# Mapa Cluster   -------------------------------------------------
output$mapa_cluster <- renderLeaflet({
  
  BDD_cluster <- clus_dat()
  # Etiquetas de Estaciones
  burbuja_clust <- paste(sep = "<br/>",
                         "<b><a href='-'>Tipo: </a></b>Vazoes",
                         paste0("<b><a href='-'>Estación: </a></b>", BDD_cluster$Estacion),
                         paste0("<b><a href='-'>Longitud: </a></b>", BDD_cluster$Longitud),
                         paste0("<b><a href='-'>Latitud: </a></b>" ,BDD_cluster$Latitud),
                         paste0("<b><a href='-'>Cluster: </a></b>" , BDD_cluster$Cluster)
  )
  
  #Modificar colorde Marcadores para estaciones
  getColor_clus <- function(BDD_cluster) {  
    #La funcion crea un vector con colores basado en una condicion
    sapply(BDD_cluster$Cluster, function(Cluster) {
      if(Cluster == 1) {
        "blue"
      } else if(Cluster == 2) {
        "orange"
      } else if(Cluster == 3) {
        "green"
      } else if(Cluster == 4) {
        'purple'
      } else if(Cluster == 5) {
        "gray"
      } else if(Cluster == 6) {
        "red"
      } else if(Cluster == 7) {
        "lightgray"
      } else if(Cluster == 8) {
        "darkblue"
      } else{
        NA
      }
      
    })
  }
  
  icons_clus <- awesomeIcons(
    icon = 'ios-close',
    iconColor = 'black',
    library = 'ion',
    markerColor = getColor_clus(BDD_cluster) 
  )
  
  #Generacion de Mapa (Leaflet)
  
  leaflet() %>% addTiles() %>%
    
    #Marcadores: 
    addAwesomeMarkers(lng=BDD_cluster$Longitud,lat=BDD_cluster$Latitud,#group ='Clima',
                      icon=icons_clus,popup=burbuja_clust)%>%
    #Añadir Minimapa
    addMiniMap(position='bottomright',toggleDisplay = TRUE)%>%
    # Estilo del MAPA 
    addProviderTiles("Esri.OceanBasemap") 
  #http://leaflet-extras.github.io/leaflet-providers/preview/index.html
  
})
