# TODO: interpolation
# x <- 1:1440
# FRD_wavelet_tmp <- approx(x, FRD_wavelet_tmpp, method = "linear", n = 1440)$y
#                                   ^ original data

library(waveslim)

is.nan.data.frame <- function(x) {
    do.call(cbind, lapply(x, is.nan))
}

toDataFrame <- function(station, time, data) {
    return(data.frame(Station = c(station), Date_UTC = c(time), Wavelet = c("dBN"), Data = data[[station]]))
}

extract <- function(data) {
    # Extract the wavelet coefficients at a given level
    # data: the data to be processed
    # return: the wavelet coefficients at the given level
    stations <- unique(data$IAGA)
    wf <- "la8"
    boundary <- "reflection"
    N <- 1440
    levels <- floor(log(N, 2))
    data_wavelet <- list()
    for (station in stations) {
        single_data <- data[data$IAGA == station, ]
        single_data <- single_data[, 5]
        single_data[is.nan(single_data)] <- 0
        data_wavelet.wt <- modwt(single_data, wf = wf, n.levels = levels, boundary = boundary)
        data_wavelet_mra <- mra.wt(data_wavelet.wt)
        data_wavelet[[station]] <- data_wavelet_mra
    }
    return(data_wavelet)
}

write_to_csv <- function(data, time, file_name) {
    if (file.exists(file_name)) {
        file.remove(file_name)
    }
    station <- names(data)[1]
    content <- toDataFrame(station, time, data)

    for (station in names(data)[-1]) {
        content <- rbind(content, toDataFrame(station, time, data))
    }
    write.csv(content, file_name, row.names = FALSE)
}

read_data <- function(file_name, argument) {
    data <- read.csv(file_name, header = TRUE, sep = ",", fill = TRUE, comment.char = "")
    columns <- c("Date_UTC", "IAGA", "GEOLON", "GEOLAT", argument)
    return(data[, columns])
}

process_data <- function(input, output, argument) {
    data <- read_data(input, argument)
    time <- unique(data$Date_UTC)
    data_wavelet <- extract(data)
    write_to_csv(data_wavelet, time, output)
}

# for (j in 1:levels) {
#     plot(VIC_wavelet_mra_1029dbn[[j]], type = "l", , xlab = "", ylab = "nT")
#     axis(side = 2)
#     title(paste("dBN 20031029, level ", j, sep = ""))
#     print(diff(range(VIC_wavelet_mra_1029dbn[[j]])))
# }
# plot(VIC_csvdata_1029$dbn_nez, type = "l", , xlab = "", ylab = "nT")
# title("dBN 20031029 (raw data)")



# BOU, NEW, BSL, FRD, FRN, TUC

# process_data("20031029-supermag.csv", "VIC_dbn.csv", "dbn_nez", 1)
process_data("20031029-supermag-6-stations.csv", "6_station_dbn.csv", "dbn_nez")

print("All done")

# ! https://www.geeksforgeeks.org/program-distance-two-points-earth/
#* needed for distance calculation in matlab