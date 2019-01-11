# Tabla de Variables Climaticas Asociadas al Cluster =========
load("Data/EstacionesPosicion.RData")

ClimVazMin = reactive({
  #Vazoes del Cluster
  datosV = clus_dat2() %>% arrange(Cluster) %>% 
    filter(Cluster==input$n_clus_acpf3) %>%
    select(Estacion_Vazoe = Estacion)
  
  #Lista  Vazoe - Clima
  datos0 = BDD_min %>% 
    select(Estacion_Clima=Clima_min,Estacion_Vazoe = Estacion) %>% 
    inner_join(datosV)
  
  #Lista Clima
  datos1 = BDD_min %>% 
    select(Estacion_Clima=Clima_min) %>% 
    distinct(Estacion_Clima) %>% 
    inner_join(datos0)
  
  #Lista Clima - Lon Lat Vaz
  datos2 = clima_dat %>% filter(Tipo=="Clima") %>% 
    select(Estacion_Clima=Estacion,Latitud,Longitud) %>% 
    inner_join(datos1, by="Estacion_Clima")
  
  return(datos2)
})

# Tabla   ------------------------------
output$tab_clim_clus3 = renderDataTable(server = FALSE,
                                        datatable(filter = 'top',
                                                  # extensions = c('Buttons'), #c('Responsive','Buttons'),
                                                  options = list(pageLength=7,searchHighlight = TRUE#,
                                                                 # dom = 'Bfrtip',
                                                                 # buttons = list('copy','print', list(
                                                                 #   extend = 'collection',
                                                                 #   buttons = c('csv', 'excel', 'pdf'),
                                                                 #   text = 'Descargar'
                                                                 # ))
                                                  ),
                                                  {
                                                    datos = ClimVazMin()
                                                    datos
                                                  })
                                        
)

