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


get_sample = function(data, no){
    x = data[sample(nrow(data), no),]
    diss = vegdist(x, method="raup")
    ret = list(data=x, diss=diss)
    return(ret)
}


select_features = function(data, k, sample_no){
    sample = get_sample(data, sample_no)
    x = sample$data
    diss = sample$diss

    eval_feature_set = function(f_set){
        eval_diss = vegdist(x[f_set], method="raup")
        km = kmeans(x[f_set], k, iter.max = 20)
        sil = summary(silhouette(km$cl, eval_diss))$avg.width
        print(sil)
        return(sil)
    }
    
    feature_set = hill.climbing.search(names(data), eval_feature_set)
    print(feature_set)
    return(feature_set)

}







