# Resultados del Modelo

#Coeficientes  ------------------
output$coeficientes = renderPrint({
  #Modelo
  modelo = ModelFit()
  print(" ")
  print(" ")
  print("*******************   MODELO SARIMAX   ********************")
  print(summary(modelo))
  print(coeftest(modelo))
})


#Residuos  ----------------------




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
