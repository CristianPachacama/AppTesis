#Grafico Vazoe a Modelar
output$graf_vaz_estacion = renderDygraph({
  est_selec = input$nomb_est_vaz3
  aux = BDDtsv[,est_selec]
  
  dygraph(aux)%>% 
    dyRangeSelector(dateWindow = c('2000-01-01','2013-12-31'))%>%
    dyHighlight(highlightSeriesBackgroundAlpha = 0.3)#%>%
    # dyLegend(show = "never")
})