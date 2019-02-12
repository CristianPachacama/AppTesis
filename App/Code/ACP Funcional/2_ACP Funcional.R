# library(fpca)
# library(fdapace)
# library(readr)
# library(reshape2)

#Cargamos Datos de Vazoes ---------------------------------
load("Data/DataVazoes.RData")
# BDDv$Fecha = as.character(seq.Date(from=as.Date("1931-01-01"),to=as.Date("2015-12-01"),by="month"))

# ACP Funcional Vazoe  ===================================
VazPcaFun = reactive({
  
  
  # Lista Reactiva de Vazoes por Cluster ------------------
  EstacionesClus = clus_dat2() %>% arrange(Cluster) %>% 
    filter(Cluster==input$n_clus_acpf2) %>%
    select(Estacion,Cluster)
  
  #Acortar Series( solo 240meses es decir 20 años) !! -----
  
  lagsACP = 240  #!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  
  BDDv_corta = BDDv[(dim(BDDv)[1]-lagsACP):(dim(BDDv)[1]),]
  fechasV = as.Date(BDDtsv)
  BDDv_corta$Fecha = fechasV[(dim(BDDv)[1]-lagsACP):(dim(BDDv)[1])]
  
  SeriesClus = melt(BDDv_corta[,EstacionesClus$Estacion])
  SeriesClus$Tiempo = 1:(dim(BDDv_corta)[1])
  names(SeriesClus) = c("Estacion","Vazoe","Tiempo")
  
  #Pasamos a un objeto FPCA
  VazPca = MakeFPCAInputs(IDs = SeriesClus$Estacion,
                          tVec = SeriesClus$Tiempo,
                          yVec = SeriesClus$Vazoe)
  
  # ACP Funcional  -----------------------
  FitVazPca =  FPCA(VazPca$Ly, VazPca$Lt, 
                    list(plot = TRUE, 
                         methodMuCovEst = 'smooth', 
                         userBwCov = 20 , 
                         useBinnedData="OFF")
                    )
  
  MedVazPca = data.frame(Fecha=BDDv_corta$Fecha,
                         VazoePCA = FitVazPca$mu)
  
  return(list("FitVazPca"= FitVazPca,
              "BDDv_corta"= BDDv_corta,
              "MedVazPca"= MedVazPca))
  
})




