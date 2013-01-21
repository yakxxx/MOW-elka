library(cluster)
require(vegan)

source("utils.R")


load_data = function(filename="shrinked.dat"){
# Loads raw data from file and normalizes it
    tbl = read.table(filename)
    tbl = normalize_columns(tbl)
    tbl = pre_select_attrs(tbl)
    return(tbl)
}

select_k = function(data, sample_no){
# Sample rows of data for speed, and then choose best k for
# kmeans algorithm
    sample = get_sample(data, SAMPLE) 
    x = sample$data
    diss = sample$diss
        
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



select_and_save_features = function(data, k, sample_no=100){
# Choose the best (aproximately) set of features for clustering
# and save it for future use in file
    features = select_features(data, k, sample_no)
    save(features, file='features.rda')
    return(features)
}

load_selected_features = function(){
# Loads selected set fo features
    load('features.rda')
    return(features)
}

load_filtered_data = function(){
# Load data and previously selected features and cuts data to
# have only columns selected as features before.
# Run select_and_save feature at least once to create 'features.rda' file
    tbl = load_data()
    features = load_selected_features()
    return(tbl[features])

}

evaluate_kmeans = function(data, k){
    km = kmeans(data, k, iter.max=20)
    diss = vegdist(data, method="raup")
    sil = silhouette(km$cl, diss)
    plot(sil)

}

evaluate_kmedoids = function(data, k){
    diss = vegdist(data, method="raup")
    sil = silhouette(pam(diss, k)$clustering, diss)
    plot(sil)

}


evaluate_agnes = function(agnes_out, k, data){
    diss = vegdist(data, method="raup")
    clust = cutree(agnes_out, k)
    sil = silhouette(clust, diss)
    plot(sil)
}

compute_agnes = function(data){
    diss = vegdist(data, method="raup")
    ag = agnes(diss)
    return(ag)
}
