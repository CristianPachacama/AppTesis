# Resultados del Modelo

#Coeficientes  ------------------
output$coeficientes = renderPrint({
  #Modelo
  modelo = ModelFit()
  print(" ")
  print(" ")
  print("*******************   MODELO SARIMAX   ********************")
  print(summary(modelo))
  print("*******************   Resumen del Modelo   ********************")
  print(coeftest(modelo))
})


#Residuos  ----------------------
output$resid_graf = renderPlot({
  modelo = ModelFit()
  checkresiduals(modelo)
  
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
