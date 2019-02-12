# MODELO SARIMAX  ==============================================


# Modelo  ----------------
ModelFit = eventReactive(input$boton_modelo,{
  
  #Datos Completos
  Xtrain = VarIndepX()
  
  #Variable Dependiente
  VazTrain = datosVazModel()
  
  #Fechas
  fecha0r = DatosModelo()$fecha0r
  # Xtrain2 = ts(Xtrain[,-1],start=fecha0r,frequency = 12)
  VazTrain = ts(VazTrain[,-1],start=fecha0r,frequency = 12)
  
  #Parametros  ------------------
  p_param = as.numeric(input$par_p)  #6
  d_param = as.numeric(input$par_d)  #0
  q_param = as.numeric(input$par_q)  #4
  P_param = as.numeric(input$par_P)  #1
  D_param = as.numeric(input$par_D)  #1
  Q_param = as.numeric(input$par_Q)  #0
  
  #Modelo usando funcion Arima ---------------------------------
  if(dim(Xtrain)[2] == 1){
    
    modeloClust = Arima(y= VazTrain,
                        order = c(p=p_param,d=d_param,q=q_param),
                        seasonal = list(order = c(P=P_param,D=D_param,Q=Q_param), 
                                        period = 12)
    )
    
  }else{
    
    Xtrain = ts(Xtrain[,-1],start=fecha0r,frequency = 12)
    modeloClust = Arima(y= VazTrain,
                        order = c(p=p_param,d=d_param,q=q_param),
                        seasonal = list(order = c(P=P_param,D=D_param,Q=Q_param), 
                                        period = 12),
                        xreg = Xtrain
    )
    
  }
  
  
  return(modeloClust)
})


#Predicciones  ------------------






# summary(modeloClust)
# coeftest(modeloClust)
# checkresiduals(modeloClust)
# 
# {
#   prediccion = forecast(modeloClust,xreg = BDDtest[,c(VarXsMacro)])
#   autoplot(prediccion)
# }
# 
# 
# test_forecast(
#   actual = log(VazoePCAts),
#   forecast.obj = prediccion,
#   test = BDDtest[, "VazoePCA"]
# )

