library("RColorBrewer")
mypal <- brewer.pal(4,"Pastel1")

hipp_max <- max(c(hipp_amyg_cnn.df$rhippvol_cnn_mm3, hipp_amyg_cnn.df$lhippvol_cnn_mm3, hipp_amyg_cnn.df$rhippvol_manual_mm3, hipp_amyg_cnn.df$lhippvol_manual_mm3))
hipp_min <- min(c(hipp_amyg_cnn.df$rhippvol_cnn_mm3, hipp_amyg_cnn.df$lhippvol_cnn_mm3, hipp_amyg_cnn.df$rhippvol_manual_mm3, hipp_amyg_cnn.df$lhippvol_manual_mm3))

amyg_max <- max(c(hipp_amyg_cnn.df$ramygvol_cnn_mm3, hipp_amyg_cnn.df$lamygvol_cnn_mm3, hipp_amyg_cnn.df$ramygvol_manual_mm3, hipp_amyg_cnn.df$lamygvol_manual_mm3))
amyg_min <- min(c(hipp_amyg_cnn.df$ramygvol_cnn_mm3, hipp_amyg_cnn.df$lamygvol_cnn_mm3, hipp_amyg_cnn.df$ramygvol_manual_mm3, hipp_amyg_cnn.df$lamygvol_manual_mm3))

my_pointsize <- 1.5

pdf(file = "vol_scatterplots_20200904.pdf", width = 10, height = 3, pointsize = 10)

par(mfcol = c(1,4), mar = c(5, 4, 4, 2) + 0.1)

# right hipp vol plot
plot(rhippvol_cnn_mm3 ~ rhippvol_manual_mm3, data = hipp_amyg_cnn.df[ hipp_amyg_cnn.df$diagnosis == "control", ],
  ylim = c(0,hipp_max),
  xlim = c(0,hipp_max),
  col = mypal[1],
  pch = 15,
  cex = my_pointsize,
  xlab = "Manual hipp volume (mm³)",
  ylab = "CNN-based hipp volume (mm³)")

points(rhippvol_cnn_mm3 ~ rhippvol_manual_mm3, data = hipp_amyg_cnn.df[ hipp_amyg_cnn.df$diagnosis == "epilepsy", ],
  col = mypal[1],
  pch = 16,
  cex = my_pointsize)

abline(a = 0, b = 1, lty = 2)

title(main = "Right Hippocampus")

# left hipp vol plot
plot(lhippvol_cnn_mm3 ~ lhippvol_manual_mm3, data = hipp_amyg_cnn.df[ hipp_amyg_cnn.df$diagnosis == "control", ],
  ylim = c(0,hipp_max),
  xlim = c(0,hipp_max),
  col = mypal[2],
  pch = 15,
  cex = my_pointsize,
  xlab = "Manual hipp volume (mm³)",
  ylab = "CNN-based hipp volume (mm³)")

points(lhippvol_cnn_mm3 ~ lhippvol_manual_mm3, data = hipp_amyg_cnn.df[ hipp_amyg_cnn.df$diagnosis == "epilepsy", ],
  col = mypal[2],
  pch = 16,
  cex = my_pointsize)

abline(a = 0, b = 1, lty = 2)

title(main = "Left Hippocampus")

# right amygdala plot
plot(ramygvol_cnn_mm3 ~ ramygvol_manual_mm3, data = hipp_amyg_cnn.df[ hipp_amyg_cnn.df$diagnosis == "control", ],
  ylim = c(0,amyg_max),
  xlim = c(0,amyg_max),
  col = mypal[3],
  pch = 15,
  cex = my_pointsize,
  xlab = "Manual amygdala volume (mm³)",
  ylab = "CNN-based amygdala volume (mm³)")

points(ramygvol_cnn_mm3 ~ ramygvol_manual_mm3, data = hipp_amyg_cnn.df[ hipp_amyg_cnn.df$diagnosis == "epilepsy", ],
  col = mypal[3],
  pch = 16,
  cex = my_pointsize)

abline(a = 0, b = 1, lty = 2)

title(main = "Right Amygdala")

# left amygdala plot
plot(lamygvol_cnn_mm3 ~ lamygvol_manual_mm3, data = hipp_amyg_cnn.df[ hipp_amyg_cnn.df$diagnosis == "control", ],
  ylim = c(0,amyg_max),
  xlim = c(0,amyg_max),
  col = mypal[4],
  pch = 15,
  cex = my_pointsize,
  xlab = "Manual amygdala volume (mm³)",
  ylab = "CNN-based amygdala volume (mm³)")

points(lamygvol_cnn_mm3 ~ lamygvol_manual_mm3, data = hipp_amyg_cnn.df[ hipp_amyg_cnn.df$diagnosis == "epilepsy", ],
  col = mypal[4],
  pch = 16,
  cex = my_pointsize)

abline(a = 0, b = 1, lty = 2)

title(main = "Left Amygdala")

dev.off()
