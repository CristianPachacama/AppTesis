# Time Series Cluster Analysis

#### Análisis Clúster para series de tiempo estacionales y modelización de caudales de ríos del Brasil.

#### Author: Cristian Pachacama

#### Director: PhD. Adriana Uquillas

## Abstract

This paper deals with the application of the Cluster Analysis for Time Series
oriented to the modeling of flows of the main rivers of Brazil, which were measured
in 150 stations distributed in them, this from climatic variables and the combination
of techniques of modeling as Principal Functional Components Analysis (FPCA),
SARIMAX and STL-Loess.

Specifically what is done is to create a small number of clusters (from 2 to 4 clusters)
from the 150 stations (where the flows were measured), where each group will
contain stations in which their flows have a temporary behavior similar possible,
then for each of these clusters, through the use of ACPF, we will find a single time
series that summarizes the behavior of the flows of the cluster. Finally, the time series
of each cluster is modeled from climatic variables, using them as explanatory
variables in the SARIMAX modeling framework.

We will show later the advantages and the efficiency of modeling a huge amount
of time series with the use of these techniques, this because the model that explains
each cluster can be extended (using the same delays and explanatory variables) to
each of the time series that compose it. We perform comparative studies between
an individual model (SARIMAX) for a specific flow and the model of the cluster
to which it belongs, obtaining similar results in terms of predictability. Where an
Average Quadratic Error (RMSE) of 0.3 % and an AIC of 652,21 was obtained for
the individual model, while for the cluster model an RMSE of 0.4 % was obtained,
and an AIC of 762,32.

Thus we show that we managed to move from the problem of modeling 150 time 
series, to modeling the time series of a few clusters.

*Keywords:* Time Series Cluster Analysis, STL-Loess decomposition, Functional
Principal Component Analysis.


