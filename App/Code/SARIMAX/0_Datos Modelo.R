# Matiz de Distancias  ------------------
# source(file = "Code/SARIMAX/Extras/DistanciaAVazoes.R") #Aqui esta BDDmin

# Datos para Modelo ---------------------
DatosModelo = reactive({
  
  # Insumos Reactivos 
  nclu = input$n_clus_acpf3
  Clusters = clus_dat2() %>% arrange(Cluster) %>% 
    select(Estacion,Cluster)
  FitVazPca = VazPcaFun()$FitVazPca
  BDDv_corta = VazPcaFun()$BDDv_corta
  MedVazPca = VazPcaFun()$MedVazPca
  
  #Esaciones
  dir = "Data/Clima Estaciones"
  estacionesExist = list.files(dir)

  # Juntamos Data de Vazoes, Clima mas cercano y Cluster
  VazClimClust = BDD_min %>% inner_join(Clusters) %>% arrange(Cluster)
  
  VariablesClima = VazClimClust %>% filter(Cluster==nclu)
  
  estacionesAux = unique(as.character(VariablesClima$Clima_min))
  
  # Incluir o No el Flujo del Cluster
  if(input$flujoBox == TRUE){
    BDDRegresion = MedVazPca
  }else{
    BDDRegresion = data.frame(Fecha= MedVazPca$Fecha)
  }
  
  # Se añaden las Variables Climáticas --------------------
  for(k in  1:length(estacionesAux)){
    
    # k=1 #Estacion
    indEst = estacionesExist == paste0(estacionesAux[k],".csv")
    estacionK = estacionesExist[indEst]
    
    if(length(estacionK)>0){
      # print(estacionK)
      #Cargar Data de Clima asociadas al Cluster 
      source("Code/SARIMAX/Extras/DataClima.R",local = TRUE)
      
      #Limpiamos Data Clima
      source("Code/SARIMAX/Extras/LimpiezaSTL-Loess.R",local = TRUE)
      
      #Juntamos en una sola Base (PCAVazoe, Clim1Esta1,Clima2Esta1,....Clima6Esta1)
      LimBDDc = data.frame(LimBDDtsc)
      estacion_k = substr(estacionK,1,nchar(estacionK)-4)
      names(LimBDDc) = paste0(estacion_k,"_",names(LimBDDc))
      LimBDDc$Fecha = as.Date(LimBDDtsc)
      
      BDDRegresion = BDDRegresion %>% inner_join(LimBDDc,by="Fecha")
      
    }
    
  }
  
  #Vazoe obtenido del ACP Funcional 
  fecha0r = unlist(strsplit(x = as.character(BDDRegresion$Fecha[1]) , split = "-"))[-3]
  fecha0r = gsub("(?<![0-9])0+", "", fecha0r, perl = TRUE)
  fecha0r = as.numeric(fecha0r)
  
  # VazoePCAts = ts(BDDRegresion$VazoePCA,start = fecha0r , frequency = 12)
  VazoePCAts=1
  return(list("BDDRegresion"=BDDRegresion,"VazoePCAts"=VazoePCAts,"fecha0r"=fecha0r))
})

