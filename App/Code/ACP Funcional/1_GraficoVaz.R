# Grafico de Series del Cluster

output$graf_vaz_clus2 = renderDygraph({
  
  est_selec = clus_dat2()
  est_selec = as.character(est_selec$Estacion)
  aux = BDDtsv[,est_selec]
  
  dygraph(aux)%>% 
    dyRangeSelector(dateWindow = c('2004-01-01','2015-12-31'))%>%
    dyHighlight(highlightSeriesBackgroundAlpha = 0.3)%>%
    dyLegend(show = "never")

})


