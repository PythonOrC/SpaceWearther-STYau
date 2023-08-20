seperate <- function(raw_data, name) {
    single_csvdata_1029 <- matrix(all_csvdata_1029[1, ], ncol = 17, nrow = 1440)
    index <- 0
    for (j in 1:nrow(all_csvdata_1029)) {
        if (all_csvdata_1029$IAGA[j] == name) {
            index <- index + 1
            single_csvdata_1029[index, ] <- all_csvdata_1029[j, ]
        }
    }
    return(single_csvdata_1029)
}