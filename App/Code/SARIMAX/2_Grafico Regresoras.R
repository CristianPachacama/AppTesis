# Grafico Clima

output$graf_clim_clus3 = renderDygraph({
  
  #Datos
  # BDD = DatosModelo()$BDD
  BDD = VarIndepX()
  fecha = DatosModelo()$fecha0r
  
  #Series Clima a Graficar
  # ind =NULL
  # #Filtro de series seleccionadas
  # if(is.null(ind)){
  #   aux = BDD[,-1]
  # }else{
  #   aux = BDD[,ind]
  # }
  
  #Guardamos en TS object
  aux = BDD[,-1]
  aux = ts(aux,start = fecha , frequency = 12)
  
  dygraph(data = aux, main = "Variables Regresoras")%>%
    dyHighlight(highlightSeriesBackgroundAlpha = 0.3)%>%
    dyLegend(show= "follow",width = 400)
  
  # dygraph(aux)%>% 
  #   dyRangeSelector(dateWindow = c('2004-01-01','2015-12-31'))%>%
  #   dyHighlight(highlightSeriesBackgroundAlpha = 0.3)%>%
  #   dyLegend(show = "never")
  
})

