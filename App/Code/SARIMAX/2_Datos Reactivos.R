# Datos Modelo SARIMAX ==============================

# Datos Vazoe  Seleccionado  --------------
datosVazModel = reactive({
  # Recortar Serie Vazoe Elejida
  est_selec = input$nomb_est_vaz3
  
  print("************   Variable VAZOE  ***************")
  print(est_selec)
  
  Vazoe = BDDv
  Vazoe$Fecha = seq.Date(from=as.Date("1931-01-01"),to=as.Date("2015-12-01"),by="month")
  Vazoe  = Vazoe[,c("Fecha",est_selec)]
  FechasClim = datosClimModel()
  FechasClim = data.frame(Fecha = FechasClim$Fecha)
  
  Vazoe = FechasClim %>% inner_join(Vazoe)
  
  print("************   Vazoe Seleccionado  ***********")
  print(head(Vazoe))
  return(Vazoe)
})

# Data Clima Seleccionada  -----------------
datosClimModel = reactive({
  BDDRegresion = DatosModelo()$BDDRegresion
  # ListaClima = ClimVazMin()$Estacion_Clima
  seleccion = input$tab_clim_clus3_rows_selected
  
  ClimModel = data.frame(Fecha=BDDRegresion$Fecha)
  if(length(seleccion)>0){
    ListaClima = ClimVazMin()$Estacion_Clima
    seleccion = input$tab_clim_clus3_rows_selected
    
    
    ListaClima = ListaClima[seleccion]
    
    
    ListaClima = unique(ListaClima)
    print("***************  VARIABLES CLIMA  ****************")
    print(ListaClima)
    ClimModel = BDDRegresion %>% select(Fecha)
    for (k in 1:length(ListaClima)) {
      aux = BDDRegresion %>% select(Fecha,starts_with(ListaClima[k]))
      ClimModel = ClimModel %>% inner_join(aux)
    }
    
  }
  
  # ListaClima = unique(ListaClima)
  # print("***************  VARIABLES CLIMA  ****************")
  # print(ListaClima)
  # ClimModel = BDDRegresion %>% select(Fecha)
  # for (k in 1:length(ListaClima)) {
  #   aux = BDDRegresion %>% select(Fecha,starts_with(ListaClima[k]))
  #   ClimModel = ClimModel %>% inner_join(aux)
  # }

  return(ClimModel)
})

# Datos Cluster Vazoe  -------------------
VazoePca = reactive({
  VazCluster = VazPcaFun()$MedVazPca
  return(VazCluster)
})

# Datos de Variables Regresoras ------------
VarIndepX = reactive({
  
  #Variable Independiente
  X = datosClimModel()
  
  if(input$flujoBox){
    X = X %>% inner_join(VazoePca(),by="Fecha") 
  }
  if(input$precipBox){
    X = X %>% inner_join(PrecipPca(),by="Fecha") # en ACP F Clima
  }
  if(input$tempMaxBox){
    X = X %>% inner_join(TmpMaxPca(),by="Fecha") # en ACP F Clima
  }
  if(input$tempMinBox){
    X = X %>% inner_join(TmpMinPca(),by="Fecha") # en ACP F Clima
  }
  if(input$humedBox){
    X = X %>% inner_join(UmidadPca(),by="Fecha") # en ACP F Clima
  }
  
  return(X)
})

# Clima de Clusters está en "ACP Funcional/Clima"  -------


