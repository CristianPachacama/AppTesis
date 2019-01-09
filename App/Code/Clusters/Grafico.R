
#Grafico de Series (CLUSTER)  ============================
# serie_cluster <- eventReactive(input$vaz_clu_grf_boton,{
#   est_selec<-input$tabla_cluster_rows_selected
#   # aux<-xts(BDD_unificada[,nombres],order.by =as.Date(BDD_unificada[,1]))
#   aux<-BDDtsv[,est_selec]
#   return(aux)
#   
# })

serie_cluster <- reactive({
  est_selec<-input$tabla_cluster_rows_selected
  # aux<-xts(BDD_unificada[,nombres],order.by =as.Date(BDD_unificada[,1]))
  aux<-BDDtsv[,est_selec]
  return(aux)
  
})

output$vaz_clu_grf <- renderDygraph({
  aux<-serie_cluster()
  dygraph(aux)%>% 
    dyRangeSelector(dateWindow = c('2000-01-01','2015-12-31'))%>%
    dyHighlight(highlightSeriesBackgroundAlpha = 0.3)%>%
    dyLegend(width = 400)
})
