httpgd::hgd()
httpgd::hgd_browse()
# load ACE data
ACE_csvdata_1029 <- read.csv("D:/Personal/Coding/Space Weather/ACE_2003_10_29.csv", header = TRUE, sep = ",", fill = TRUE, comment.char = "")
# remove NA from the original data
ACE_data_1029 <- ACE_csvdata_1029[1:360, 1:10]
for (i in (1:360))
{
    ACE_data_1029[i, 1:10] <- ACE_csvdata_1029[(i * 2 - 1), 1:10]
}
# # plot original ACE data
# x11()
# op <- par(
#     mfrow = c(6, 1),
#     oma = c(3, 1, 0, 0) + 0.1,
#     mar = c(0, 3, 1, 1) + 0.1,
#     mgp = c(2, 1, 0),
#     xpd = NA
# )
# plot.ts(ACE_data_1029$Bgse_x, type = "l", , xlab = "", ylab = "nT")
# axis(side = 2)
# title("Bgse_x 20031029")
# plot.ts(ACE_data_1029$Bgse_y, type = "l", , xlab = "", ylab = "nT")
# axis(side = 2)
# title("Bgse_y 20031029")
# plot.ts(ACE_data_1029$Bgse_z, type = "l", , xlab = "", ylab = "nT")
# axis(side = 2)
# title("Bgse_z 20031029")

# interpolate ACE to 1 minute
# approx   (x, y = NULL, xout, method = "linear", n = 50,
#          yleft, yright, rule = 1, f = 0, ties = mean, na.rm = TRUE)
x <- 1:360
ACE_data_1029Bgse_x <- approx(x, ACE_data_1029$Bgse_x, method = "linear", n = 1440)$y
ACE_data_1029Bgse_y <- approx(x, ACE_data_1029$Bgse_y, method = "linear", n = 1440)$y
ACE_data_1029Bgse_z <- approx(x, ACE_data_1029$Bgse_z, method = "linear", n = 1440)$y
# plot(ACE_data_1029Bgse_x)
# plot(ACE_data_1029Bgse_y)
# plot(ACE_data_1029Bgse_z)




# op <- par(
#     mfrow = c(8, 1),
#     oma = c(3, 1, 0, 0) + 0.1,
#     mar = c(0, 3, 1, 1) + 0.1,
#     mgp = c(2, 1, 0),
#     xpd = NA
# )

# VIC_csvdata_1029 <- read.csv("D:/Personal/Coding/Space Weather/20031029-supermag.csv", header = TRUE, sep = ",", fill = TRUE, comment.char = "")
# all_csvdata_1029 <- read.csv("D:/Personal/Coding/Space Weather/20031029-supermag-6-stations.csv", header = TRUE, sep = ",", fill = TRUE, comment.char = "")
# VIC_csvdata_1029 <- seperate(VIC_csvdata_1029, "VIC")
# BOU_csvdata_1029 <- seperate(all_csvdata_1029, "BOU")
# NEW_csvdata_1029 <- seperate(all_csvdata_1029, "NEW")
# BSL_csvdata_1029 <- seperate(all_csvdata_1029, "BSL")
# FRD_csvdata_1029 <- seperate(all_csvdata_1029, "FRD")
# FRN_csvdata_1029 <- seperate(all_csvdata_1029, "FRN")
# TUC_csvdata_1029 <- seperate(all_csvdata_1029, "TUC")

# plot(unlist(NEW_csvdata_1029[, 12]), type = "l", , xlab = "", ylab = "nT NEW")
# title("DBN 20031029")
# plot(unlist(VIC_csvdata_1029[, 12]), type = "l", , xlab = "", ylab = "nT VIC")
# plot(unlist(BOU_csvdata_1029[, 12]), type = "l", , xlab = "", ylab = "nT BOU")
# plot(unlist(FRD_csvdata_1029[, 12]), type = "l", , xlab = "", ylab = "nT FRD")
# plot(unlist(FRN_csvdata_1029[, 12]), type = "l", , xlab = "", ylab = "nT FRN")
# plot(unlist(BSL_csvdata_1029[, 12]), type = "l", , xlab = "", ylab = "nT BSL")
# plot(unlist(TUC_csvdata_1029[, 12]), type = "l", , xlab = "", ylab = "nT TUC")
# plot(ACE_data_1029Bgse_z)

# plot(unlist(NEW_csvdata_1029[, 13]), type = "l", , xlab = "", ylab = "nT NEW")
# title("DBE 20031029")
# plot(unlist(VIC_csvdata_1029[, 13]), t3pe = "l", , xlab = "", ylab = "nT VIC")
# plot(unlist(BOU_csvdata_1029[, 13]), type = "l", , xlab = "", ylab = "nT BOU")
# plot(unlist(FRD_csvdata_1029[, 13]), type = "l", , xlab = "", ylab = "nT FRD")
# plot(unlist(FRN_csvdata_1029[, 13]), type = "l", , xlab = "", ylab = "nT FRN")
# plot(unlist(BSL_csvdata_1029[, 13]), type = "l", , xlab = "", ylab = "nT BSL")
# plot(unlist(TUC_csvdata_1029[, 13]), type = "l", , xlab = "", ylab = "nT TUC")
# plot(ACE_data_1029Bgse_x)


# plot(unlist(NEW_csvdata_1029[, 14]), type = "l", , xlab = "", ylab = "nT NEW")
# title("DBZ 20031029")
# plot(unlist(VIC_csvdata_1029[, 14]), t4pe = "l", , xlab = "", ylab = "nT VIC")
# plot(unlist(BOU_csvdata_1029[, 14]), type = "l", , xlab = "", ylab = "nT BOU")
# plot(unlist(FRD_csvdata_1029[, 14]), type = "l", , xlab = "", ylab = "nT FRD")
# plot(unlist(FRN_csvdata_1029[, 14]), type = "l", , xlab = "", ylab = "nT FRN")
# plot(unlist(BSL_csvdata_1029[, 14]), type = "l", , xlab = "", ylab = "nT BSL")
# plot(unlist(TUC_csvdata_1029[, 14]), type = "l", , xlab = "", ylab = "nT TUC")
# plot(ACE_data_1029Bgse_y)
# # plot(unlist(FRD_csvdata_1029[, 13]), type = "l", , xlab = "", ylab = "nT FRD")
# # title("DBE 20031029")
# # plot(VIC_csvdata_1029$dbe_nez, type = "l", , xlab = "", ylab = "nT VIC")
# # plot(unlist(NEW_csvdata_1029[, 13]), type = "l", , xlab = "", ylab = "nT NEW")
# # plot(unlist(BOU_csvdata_1029[, 13]), type = "l", , xlab = "", ylab = "nT BOU")
# # plot(unlist(BSL_csvdata_1029[, 13]), type = "l", , xlab = "", ylab = "nT BSL")
# # plot(unlist(FRN_csvdata_1029[, 13]), type = "l", , xlab = "", ylab = "nT FRN")
# # plot(unlist(TUC_csvdata_1029[, 13]), type = "l", , xlab = "", ylab = "nT TUC")

# # plot(unlist(FRD_csvdata_1029[, 14]), type = "l", , xlab = "", ylab = "nT FRD")
# # title("DBZ 20031029")
# # plot(VIC_csvdata_1029$dbz_nez, type = "l", , xlab = "", ylab = "nT VIC")
# # plot(unlist(NEW_csvdata_1029[, 14]), type = "l", , xlab = "", ylab = "nT NEW")
# # plot(unlist(BOU_csvdata_1029[, 14]), type = "l", , xlab = "", ylab = "nT BOU")
# # plot(unlist(BSL_csvdata_1029[, 14]), type = "l", , xlab = "", ylab = "nT BSL")
# # plot(unlist(FRN_csvdata_1029[, 14]), type = "l", , xlab = "", ylab = "nT FRN")
# # plot(unlist(TUC_csvdata_1029[, 14]), type = "l", , xlab = "", ylab = "nT TUC")