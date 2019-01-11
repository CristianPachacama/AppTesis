# library(dplyr)
# library(readr)
# library(dygraphs)
# dir = "Data/Clima Estaciones/Clima csv2"
# estacionesExist = list.files(dir)

# k=1
#Clima de la Estacion K-esima
# print(paste0(dir,"/",estacionK))
BDDc = read_delim(paste0(dir,"/",estacionK), #,".csv"), 
                  ";", escape_double = FALSE, trim_ws = TRUE, 
                  skip = 16)

fecha0 = unlist(strsplit(BDDc$Data[1],"/"))[-1]
fecha0 = gsub("(?<![0-9])0+", "", fecha0, perl = TRUE)
fecha0 = as.numeric(fecha0)
# fecha0 = c(2000,1)
BDDtsc = ts(BDDc[,-c(1:3,8)],start = fecha0[c(2,1)] , frequency = 12)


