require(FSelector)
require(vegan)

TRESH = 0.01

pre_select_attrs = function(data){
    rows_num = nrow(data)
    column_probability = colSums(data) / rows_num 
    filter = column_probability > TRESH
    return(data[filter])
}

normalize_columns = function(data){
    filter = colMeans(data) > 0.5
    for(i in 1:ncol(data)){
        if(filter[i]==TRUE){
            data[i] = (data[i] + 1) %% 2
        }
    }
    return(data)

}


select_k = function(data){
    x = data[sample(nrow(data), 3000),]
    diss = vegdist(x, method="raup")
    
    k=-1
    max_s_km = -1
    for(i in 2:20){
        km = kmeans(x, i, iter.max = 20)
        s_km = summary(silhouette(km$cl, diss))$avg.width
        if(s_km > max_s_km){
             max_s_km = s_km
             k = i
        }
    }
    return(c(k, max_s_km))
}


select_features = function(data){


}
