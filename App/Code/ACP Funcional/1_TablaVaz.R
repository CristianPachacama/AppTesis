# Tabla Vazoes del Cluster ---------------
# Datos 
clus_dat2 = reactive({
  D_aux = switch(input$vaz_clus_metric,
                  'D_ccor'= DistMatrix(BDDv[c(-1,-2),],Metrica = 'ccor'),
                  'D_cor'= DistMatrix(BDDv[c(-1,-2),],Metrica = 'cor'),
                  'D_cort'= DistMatrix(BDDv[c(-1,-2),],Metrica = 'cort'),
                  'D_acf'= DistMatrix(BDDv[c(-1,-2),],Metrica = 'acf'),
                  'D_euc'= DistMatrix(BDDv[c(-1,-2),],Metrica = 'euc'),
                  'D_fourier'= DistMatrix(BDDv[c(-1,-2),],Metrica = 'fourier'),
                  'D_ifnrm'= DistMatrix(BDDv[c(-1,-2),],Metrica = 'infnorm'),
                  'D_manh'= DistMatrix(BDDv[c(-1,-2),],Metrica = 'manhattan'),
                  'D_mink'= DistMatrix(BDDv[c(-1,-2),],Metrica = 'minkowski'),
                  'D_pacf'= DistMatrix(BDDv[c(-1,-2),],Metrica = 'pacf'),
                  'D_per'= DistMatrix(BDDv[c(-1,-2),],Metrica = 'per')
  )
  
  aux_cluster = cluster_geografico(D=D_aux,k=as.numeric(input$vaz_clus_k),
                                    tipo=input$vaz_clus_metod,
                                    vazoes_code)
  
  return(aux_cluster$BDD_cluster)
})

# Tabla 
output$tab_vaz_clus2 <- renderDataTable(server = FALSE,
                                        datatable(filter = 'top',
                                                  # extensions = c('Buttons'), #c('Responsive','Buttons'),
                                                  options = list(pageLength=7,searchHighlight = TRUE#,
                                                                 # dom = 'Bfrtip',
                                                                 # buttons = list('copy','print', list(
                                                                 #   extend = 'collection',
                                                                 #   buttons = c('csv', 'excel', 'pdf'),
                                                                 #   text = 'Descargar'
                                                                 # ))
                                                  ),
                                                  {
                                                    aux = clus_dat2() %>% arrange(Cluster) %>% 
                                                      filter(Cluster==input$n_clus_acpf2) %>%
                                                      select(Estacion,Latitud,Longitud,Cluster)
                                                    # aux[,c(-1,-3)]
                                                  })
)


