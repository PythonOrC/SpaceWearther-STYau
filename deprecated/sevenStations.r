httpgd::hgd()
httpgd::hgd_browse()

op <- par(
    mfrow = c(7, 1),
    oma = c(3, 1, 0, 0) + 0.1,
    mar = c(0, 3, 1, 1) + 0.1,
    mgp = c(2, 1, 0),
    xpd = NA
)

VIC_csvdata_1029 <- read.csv("D:/Personal/Coding/Space Weather/20031029-supermag.csv", header = TRUE, sep = ",", fill = TRUE, comment.char = "")
all_csvdata_1029 <- read.csv("D:\\Personal\\Coding\\Space Weather\\20031029-supermag-6-stations.csv", header = TRUE, sep = ",", fill = TRUE, comment.char = "")

BOU_csvdata_1029 <- seperate(all_csvdata_1029, "BOU")
NEW_csvdata_1029 <- seperate(all_csvdata_1029, "NEW")
BSL_csvdata_1029 <- seperate(all_csvdata_1029, "BSL")
FRD_csvdata_1029 <- seperate(all_csvdata_1029, "FRD")
FRN_csvdata_1029 <- seperate(all_csvdata_1029, "FRN")
TUC_csvdata_1029 <- seperate(all_csvdata_1029, "TUC")

plot(unlist(NEW_csvdata_1029[, 12]), type = "l", , xlab = "", ylab = "nT NEW")
title("DBN 20031029")
plot(VIC_csvdata_1029$dbn_nez, type = "l", , xlab = "", ylab = "nT VIC")
plot(unlist(BOU_csvdata_1029[, 12]), type = "l", , xlab = "", ylab = "nT BOU")
plot(unlist(FRD_csvdata_1029[, 12]), type = "l", , xlab = "", ylab = "nT FRD")
plot(unlist(FRN_csvdata_1029[, 12]), type = "l", , xlab = "", ylab = "nT FRN")
plot(unlist(BSL_csvdata_1029[, 12]), type = "l", , xlab = "", ylab = "nT BSL")
plot(unlist(TUC_csvdata_1029[, 12]), type = "l", , xlab = "", ylab = "nT TUC")

plot(unlist(NEW_csvdata_1029[, 13]), type = "l", , xlab = "", ylab = "nT NEW")
title("DBE 20031029")
plot(VIC_csvdata_1029$dbe_nez, t3pe = "l", , xlab = "", ylab = "nT VIC")
plot(unlist(BOU_csvdata_1029[, 13]), type = "l", , xlab = "", ylab = "nT BOU")
plot(unlist(FRD_csvdata_1029[, 13]), type = "l", , xlab = "", ylab = "nT FRD")
plot(unlist(FRN_csvdata_1029[, 13]), type = "l", , xlab = "", ylab = "nT FRN")
plot(unlist(BSL_csvdata_1029[, 13]), type = "l", , xlab = "", ylab = "nT BSL")
plot(unlist(TUC_csvdata_1029[, 13]), type = "l", , xlab = "", ylab = "nT TUC")

plot(unlist(NEW_csvdata_1029[, 14]), type = "l", , xlab = "", ylab = "nT NEW")
title("DBZ 20031029")
plot(VIC_csvdata_1029$dbz_nez, t4pe = "l", , xlab = "", ylab = "nT VIC")
plot(unlist(BOU_csvdata_1029[, 14]), type = "l", , xlab = "", ylab = "nT BOU")
plot(unlist(FRD_csvdata_1029[, 14]), type = "l", , xlab = "", ylab = "nT FRD")
plot(unlist(FRN_csvdata_1029[, 14]), type = "l", , xlab = "", ylab = "nT FRN")
plot(unlist(BSL_csvdata_1029[, 14]), type = "l", , xlab = "", ylab = "nT BSL")
plot(unlist(TUC_csvdata_1029[, 14]), type = "l", , xlab = "", ylab = "nT TUC")