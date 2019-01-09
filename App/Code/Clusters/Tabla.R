
#Tabla de Estaciones por Cluster   =======================================
output$tabla_cluster <- renderDataTable(server = FALSE,
                                        datatable(filter = 'top',
                                                  extensions = c('Buttons'), #c('Responsive','Buttons'),
                                                  options = list(pageLength=7,searchHighlight = TRUE,
                                                                 dom = 'Bfrtip',
                                                                 buttons = list('copy','print', list(
                                                                   extend = 'collection',
                                                                   buttons = c('csv', 'excel', 'pdf'),
                                                                   text = 'Descargar'
                                                                 ))
                                                  ),
                                                  {
                                                    #clus_dat() esta en Mapa.R
                                                    aux = clus_dat() %>% arrange(Cluster) 
                                                    aux[,c(-1,-3)]
                                                  })
)