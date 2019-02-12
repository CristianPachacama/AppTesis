# ACP Funcional Vazoe  ========================================
# VazoePca = reactive({
#   VazCluster = VazPcaFun()$MedVazPca
#   return(VazCluster)
# })

# ACP Funcional Precipitacion  ========================================
PrecipPca = reactive({
  BDDAux_precip = DatosModelo()$BDDRegresion %>% 
    select(Fecha,ends_with("PrecipitacaoTotal"))
  
  #Filtramos según Variable 
  BDDClimaPCA1 = BDDAux_precip %>% select(ends_with("PrecipitacaoTotal"))
  
  print("*********  Precipitacion  ***********")
  print(head(BDDClimaPCA1))
  
  #Reordenamos datos
  BDDClimaPCA1 = melt(BDDAux_precip[,-c(1)])
  BDDClimaPCA1$Tiempo = 1:(dim(BDDAux_precip)[1])
  names(BDDClimaPCA1) = c("Estacion","Clima","Tiempo")
  
  
  #Se realiza ACP
  ClimPca1 = MakeFPCAInputs(IDs = BDDClimaPCA1$Estacion,
                           tVec = BDDClimaPCA1$Tiempo,
                           yVec = BDDClimaPCA1$Clima)
  FitClimPca1 =  FPCA(ClimPca1$Ly, ClimPca1$Lt, 
                     list(plot = TRUE, 
                          methodMuCovEst = 'smooth', 
                          userBwCov = 20 , 
                          useBinnedData="OFF"))
  # plot(FitVazPca)
  
  Datos1 = data.frame(Fecha=BDDAux_precip$Fecha , PrecipClust = FitClimPca1$mu)
  print(head(Datos1))
  
  return(Datos1)
})

# ACP Funcional Temperatura Maxima  ===================================
TmpMaxPca = reactive({
  BDDAux_tmpMax = DatosModelo()$BDDRegresion %>% 
    select(Fecha,ends_with("TempMaximaMedia"))
  
  #Filtramos según Variable 
  BDDClimaPCA2 = BDDAux_tmpMax %>% select(ends_with("TempMaximaMedia"))
  
  print("*********  Temp Maxima  ***********")
  print(head(BDDClimaPCA2))
  
  BDDClimaPCA2 = melt(BDDAux_tmpMax[,-c(1)])
  BDDClimaPCA2$Tiempo = 1:(dim(BDDAux_tmpMax)[1])
  names(BDDClimaPCA2) = c("Estacion","Clima","Tiempo")
  
  #Se realiza ACP
  ClimPca2 = MakeFPCAInputs(IDs = BDDClimaPCA2$Estacion,
                           tVec = BDDClimaPCA2$Tiempo,
                           yVec = BDDClimaPCA2$Clima)
  FitClimPca2 =  FPCA(ClimPca2$Ly, ClimPca2$Lt, 
                     list(plot = TRUE, 
                          methodMuCovEst = 'smooth', 
                          userBwCov = 20 , 
                          useBinnedData="OFF"))
  # plot(FitVazPca)
  
  Datos2 = data.frame(Fecha=BDDAux_tmpMax$Fecha , TmpMaxClus = FitClimPca2$mu)
  print(head(Datos2))
  
  return(Datos2)
})

# ACP Funcional Temperatura Minima  ===================================
TmpMinPca = reactive({
  BDDAux_tmpMin = DatosModelo()$BDDRegresion %>% 
    select(Fecha,ends_with("TempMinimaMedia"))
  
  #Filtramos según Variable 
  BDDClimaPCA3 = BDDAux_tmpMin %>% select(ends_with("TempMinimaMedia"))
  
  print("*********  Temp MInima  ***********")
  print(head(BDDClimaPCA3))
  
  BDDClimaPCA3 = melt(BDDAux_tmpMin[,-c(1)])
  BDDClimaPCA3$Tiempo = 1:(dim(BDDAux_tmpMin)[1])
  names(BDDClimaPCA3) = c("Estacion","Clima","Tiempo")
  
  #Se realiza ACP
  ClimPca3 = MakeFPCAInputs(IDs = BDDClimaPCA3$Estacion,
                           tVec = BDDClimaPCA3$Tiempo,
                           yVec = BDDClimaPCA3$Clima)
  FitClimPca3 =  FPCA(ClimPca3$Ly, ClimPca3$Lt, 
                     list(plot = TRUE, 
                          methodMuCovEst = 'smooth', 
                          userBwCov = 20 , 
                          useBinnedData="OFF"))
  # plot(FitVazPca)
  
  Datos3 = data.frame(Fecha=BDDAux_tmpMin$Fecha , TmpMinClus = FitClimPca3$mu)
  print(head(Datos3))
  
  return(Datos3)
})

# ACP Funcional Temperatura Minima  ===================================
UmidadPca = reactive({
  BDDAux_umd = DatosModelo()$BDDRegresion %>% 
    select(Fecha,ends_with("UmidadeRelativaMedia"))
  
  #Filtramos según Variable 
  BDDClimaPCA4 = BDDAux_umd %>% select(ends_with("UmidadeRelativaMedia"))
  
  print("*********  Temp Humedad  ***********")
  print(head(BDDClimaPCA4))
  
  BDDClimaPCA4 = melt(BDDAux_umd[,-c(1)])
  BDDClimaPCA4$Tiempo = 1:(dim(BDDAux_umd)[1])
  names(BDDClimaPCA4) = c("Estacion","Clima","Tiempo")
  
  #Se realiza ACP
  ClimPca4 = MakeFPCAInputs(IDs = BDDClimaPCA4$Estacion,
                           tVec = BDDClimaPCA4$Tiempo,
                           yVec = BDDClimaPCA4$Clima)
  FitClimPca4 =  FPCA(ClimPca4$Ly, ClimPca4$Lt, 
                     list(plot = TRUE, 
                          methodMuCovEst = 'smooth', 
                          userBwCov = 20 , 
                          useBinnedData="OFF"))
  # plot(FitVazPca)
  
  Datos4 = data.frame(Fecha=BDDAux_umd$Fecha , HumedadClus = FitClimPca4$mu)
  print(head(Datos4))
  
  return(Datos4)
})





