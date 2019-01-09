# Grafico 1 Resumen ACP Funcional

output$graf_acpf1 = renderPlot({
  
  modelo = VazPcaFun()$FitVazPca
  plot(modelo)
  
})

output$graf_acpf2 = renderPlot({
  
  modelo = VazPcaFun()$FitVazPca
  
  par(mfrow=c(1,2))
  CreatePathPlot(modelo, subset = c(3,5,10), K = 3, main = 'K = 3', pch = 4) ; grid()
  CreatePathPlot(modelo, subset = c(3,5,10), K = 4, main = 'K = 1', pch = 4); grid()
})


output$graf_acpf3 = renderPlot({
  
  modelo = VazPcaFun()$FitVazPca
  
  par(mfrow=c(1,2))
  CreateOutliersPlot(modelo, optns = list(K = 3, variant = 'KDE'))
  CreateFuncBoxPlot(modelo, xlab = 'Meses', ylab = 'Flujos', optns = list(K =3, variant='bagplot'))
})


