# Datos Modelo SARIMAX ==============================

#Data Clima Seleccionada  ----------------
datosClimModel = reactive({
  BDDRegresion = DatosModelo()$BDDRegresion
  ListaClima = ClimVazMin()$Estacion_Clima
  seleccion = input$tab_clim_clus3_rows_selected
  if(length(seleccion)>0){
    ListaClima = ListaClima[seleccion]
  }
  
  ListaClima = unique(ListaClima)
  print("***************  VARIABLES CLIMA  ****************")
  print(ListaClima)
  ClimModel = BDDRegresion %>% select(Fecha)
  for (k in 1:length(ListaClima)) {
    aux = BDDRegresion %>% select(Fecha,starts_with(ListaClima[k]))
    ClimModel = ClimModel %>% inner_join(aux)
  }
  
  return(ClimModel)
})

#Datos empalmados Vazoes   ---------------
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


# est_selec = "[SEGREDO + DESVIO] ARTIFICIAL (75)"
