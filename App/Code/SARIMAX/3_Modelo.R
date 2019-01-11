# MODELO SARIMAX  ==============================================

ModelFit = eventReactive(input$boton_modelo,{
  
  #Datos Particionados -------------
  # X = TrainTestClim()$BDDTrain
  # VazTrain = TrainTestVaz()$BDDTrain
  # VazTrain = VazTrain[,-1]
  
  #Datos Completos  ----------------
  X = datosClimModel()
  VazTrain = datosVazModel()
  
  fecha0r = DatosModelo()$fecha0r
  X = ts(X[,-1],start=fecha0r,frequency = 12)
  VazTrain = ts(VazTrain[,-1],start=fecha0r,frequency = 12)
  
  # print("**********  Train CLIMA ************")
  # print(X)
  # 
  # print("**********  Train VAZOE ************")
  # print(head(VazTrain))
  
  #Parametros  ------------------
  p_param = as.numeric(input$par_p)  #6
  d_param = as.numeric(input$par_d)  #0
  q_param = as.numeric(input$par_q)  #4
  P_param = as.numeric(input$par_P)  #1
  D_param = as.numeric(input$par_D)  #1
  Q_param = as.numeric(input$par_Q)  #0
  
  #Modelo usando funcion Arima ---------------------------------
  modeloClust = Arima(y= VazTrain,
                      order = c(p=p_param,d=d_param,q=q_param),
                      seasonal = list(order = c(P=P_param,D=D_param,Q=Q_param), period = 12),
                      xreg = X
  )
  
  
  return(modeloClust)
})

