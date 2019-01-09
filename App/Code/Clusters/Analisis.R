
# ANALISIS CLUSTERIZACION  ======================

# TSDist
# Distance measure to be used. It must be one of: "euclidean", 
# "manhattan", "minkowski", "infnorm", "ccor", "sts", "dtw", 
# "keogh.lb", "edr", "erp", "lcss", "fourier", "tquest", 
# "dissim", "acf", "pacf", "ar.lpc.ceps", "ar.mah", 
# "ar.mah.statistic", "ar.mah.pvalue", "ar.pic", "cdm", 
# "cid", "cor", "cort", "wav", "int.per", "per", "mindist.sax", 
# "ncd", "pred", "spec.glk", "spec.isd", "spec.llr", "pdc", "frechet"

DistMatrix = function(BDD=BDDv,Metrica= "acf"){
  N = dim(BDD)[2] - 2
  D = matrix(0,nrow = N, ncol = N)
  for(i in 1:(N-1)){
    for(j in (i+1):N){
      D[i,j]=TSDistances(x=BDD[,2+i],y=BDD[,2+j],distance = Metrica)
    }
  }
  D=D+t(D)
  return(D)
  
}

#Funcion Extra ------
cluster_geografico = function(D,k=4,tipo='kmedias',vazoes_code){
  k_aux<-k
  map <- smacofSym(D)
  fit <- switch(tipo,
                'kmedias' = {kmeans(map$conf, centers = k_aux)},
                'clara' = {clara(map$conf, k=k_aux, samples = 50, stand=TRUE, pamLike = TRUE)},
                'gerarquico' = {hclust(D)}
  )
  grupo <- switch (tipo,
                   'kmedias' = {fit$cluster},
                   'clara' = {fit$cluster},
                   'gerarquico' = {cutree(fit, k = k_aux)}
  )
  D1<-as.numeric(map$conf[,'D1']);
  D2<-as.numeric(map$conf[,'D2']);
  
  BDD_cluster<-data.frame(Nombre_ST = paste0('VAZOES(',vazoes_code$Estacion,')'),
                          Estacion=vazoes_code$Estacion,
                          Codigo_ONS=vazoes_code$Codigo_ONS,
                          Latitud=vazoes_code$Latitud,
                          Longitud=vazoes_code$Longitud,
                          D1, D2, Cluster=as.factor(as.character(grupo))
  )
  
  BDD_cluster<-data.frame(Nombre_ST = paste0('VAZOES(',vazoes_code$Estacion,')'),
                          Estacion=vazoes_code$Estacion,
                          Codigo_ONS=vazoes_code$Codigo_ONS,
                          Latitud=vazoes_code$Latitud,
                          Longitud=vazoes_code$Longitud,
                          D1, D2, Cluster=as.factor(as.character(grupo))
  )
  if(k_aux >= 1){
    est_cluster1<-as.character(BDD_cluster$Nombre_ST[BDD_cluster$Cluster==1])
  }
  if(k_aux >=2){
    est_cluster2<-as.character(BDD_cluster$Nombre_ST[BDD_cluster$Cluster==2])
  }
  if(k_aux >=3){
    est_cluster3<-as.character(BDD_cluster$Nombre_ST[BDD_cluster$Cluster==3])
  }
  if(k_aux >=4){
    est_cluster4<-as.character(BDD_cluster$Nombre_ST[BDD_cluster$Cluster==4])
  }
  if(k_aux >=5){
    est_cluster5<-as.character(BDD_cluster$Nombre_ST[BDD_cluster$Cluster==5])
  }
  if(k_aux >=6){
    est_cluster6<-as.character(BDD_cluster$Nombre_ST[BDD_cluster$Cluster==6])
  }
  if(k_aux >=7){
    est_cluster7<-as.character(BDD_cluster$Nombre_ST[BDD_cluster$Cluster==7])
  }
  if(k_aux>=8){
    est_cluster8<-as.character(BDD_cluster$Nombre_ST[BDD_cluster$Cluster==8])
  }
  if(k_aux > 8){
    print('Valor de k demasiado grande, elige un menor número de clusters')
  }
  
  resultado <- switch (k_aux,
                       {list('map'=map,'grupo'=grupo,'BDD_cluster'=BDD_cluster,
                             'est_cluster1' = est_cluster1)},
                       {list('map'=map,'grupo'=grupo,'BDD_cluster'=BDD_cluster,
                             'est_cluster1' = est_cluster1,'est_cluster2' = est_cluster2)},
                       {list('map'=map,'grupo'=grupo,'BDD_cluster'=BDD_cluster,
                             'est_cluster1' = est_cluster1,'est_cluster2' = est_cluster2,
                             'est_cluster3' = est_cluster3)},
                       {list('map'=map,'grupo'=grupo,'BDD_cluster'=BDD_cluster,
                             'est_cluster1' = est_cluster1,'est_cluster2' = est_cluster2,
                             'est_cluster3' = est_cluster3,'est_cluster4' = est_cluster4)},
                       {list('map'=map,'grupo'=grupo,'BDD_cluster'=BDD_cluster,
                             'est_cluster1' = est_cluster1,'est_cluster2' = est_cluster2,
                             'est_cluster3' = est_cluster3,'est_cluster4' = est_cluster4,
                             'est_cluster5' = est_cluster5)},
                       {list('map'=map,'grupo'=grupo,'BDD_cluster'=BDD_cluster,
                             'est_cluster1' = est_cluster1,'est_cluster2' = est_cluster2,
                             'est_cluster3' = est_cluster3,'est_cluster4' = est_cluster4,
                             'est_cluster5' = est_cluster5,'est_cluster6' = est_cluster6)},
                       {list('map'=map,'grupo'=grupo,'BDD_cluster'=BDD_cluster,
                             'est_cluster1' = est_cluster1,'est_cluster2' = est_cluster2,
                             'est_cluster3' = est_cluster3,'est_cluster4' = est_cluster4,
                             'est_cluster5' = est_cluster5,'est_cluster6' = est_cluster6,
                             'est_cluster7' = est_cluster7)},
                       {list('map'=map,'grupo'=grupo,'BDD_cluster'=BDD_cluster,
                             'est_cluster1' = est_cluster1,'est_cluster2' = est_cluster2,
                             'est_cluster3' = est_cluster3,'est_cluster4' = est_cluster4,
                             'est_cluster5' = est_cluster5,'est_cluster6' = est_cluster6,
                             'est_cluster7' = est_cluster7,'est_cluster8' = est_cluster8)}
  )
  
  return(resultado)
  
}
