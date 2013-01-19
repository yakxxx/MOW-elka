library(cluster)
require(vegan)

source("utils.R")

tbl = read.table('shrinked.dat')
tbl = normalize_columns(tbl)
tbl = pre_select_attrs(tbl)

dissE = vegdist(tbl, method="raup")
km = kmeans(tbl, 7)
s_km = silhouette(km$cl, dissE)

#hk = cutree(hclust(dissE), 2)
#s_hk = silhouette(hk, dissE)
plot(s_km)
#plot(s_hk)
