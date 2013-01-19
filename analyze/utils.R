

TRESH = 0.01

pre_select_attrs = function(data){
    rows_num = nrow(data)
    column_probability = colSums(data) / rows_num 
    filter = column_probability < 1 - TRESH
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
