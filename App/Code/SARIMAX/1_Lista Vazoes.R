# Lista Reactiva de Vazoes del Cluster ----------

observe({
  
  list_vazoes_clus = clus_dat2() %>% arrange(Cluster) %>% 
    filter(Cluster==input$n_clus_acpf3) %>%
    select(Estacion)
  
  updateSelectInput(session, inputId = "nomb_est_vaz3",
                    choices = list_vazoes_clus$Estacion)
  
})

