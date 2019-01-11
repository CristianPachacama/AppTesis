# Data de Entrenamiento y de Test   ============================

TrainTestClim = reactive({
  #Datos 
  BDDRegresion = datosClimModel()
  BDDRegresion = BDDRegresion[,-1]
  fecha0r =  DatosModelo()$fecha0r
  # Crear Data de Entrenamiento y Test  ------------------------
  ntr = round(particion*dim(BDDRegresion)[1])
  indTrain = -c((dim(BDDRegresion)[1]-ntr):(dim(BDDRegresion)[1]))
  BDDRegresionTS = ts(BDDRegresion,start=fecha0r,frequency = 12)
 
  # BDDtrain = BDDRegresionTS[indTrain ,]
  BDDtrain = ts(BDDRegresionTS[indTrain ,],start=fecha0r,frequency = 12)
  BDDtest = BDDRegresionTS[-indTrain ,]
  
  # print("************   BBD TRAIN CLIMA  ************")
  # print(BDDtrain)
  
  return(list("BDDtrain"=BDDtrain,"BDDtest"=BDDtest))
})


TrainTestVaz = reactive({
  #Datos 
  BDDRegresion = datosVazModel()
  # BDDRegresion = BDDRegresion[,-1]
  fecha0r =  DatosModelo()$fecha0r
  # Crear Data de Entrenamiento y Test  ------------------------
  ntr = round(particion*dim(BDDRegresion)[1])
  indTrain = -c((dim(BDDRegresion)[1]-ntr):(dim(BDDRegresion)[1]))
  BDDRegresionTS = ts(BDDRegresion,start=fecha0r,frequency = 12)
  
  # BDDtrain = BDDRegresionTS[indTrain ,]
  BDDtrain = ts(BDDRegresionTS[indTrain ,],start=fecha0r,frequency = 12)
  BDDtest = BDDRegresionTS[-indTrain ,]
  
  # print("************   BBD TRAIN VAZOE  ************")
  # print(BDDtrain)
  
  return(list("BDDtrain"=BDDtrain,"BDDtest"=BDDtest))
})