library("RColorBrewer")
mypal <- brewer.pal(4,"Pastel1")

t_col <- function(color, percent = 50, name = NULL) {
  #      color = color name
  #    percent = % transparency
  #       name = an optional name for the color

  ## Get RGB values for named color
  rgb.val <- col2rgb(color)

  ## Make new color using input color as base and alpha set by transparency
  t.col <- rgb(rgb.val[1], rgb.val[2], rgb.val[3],
              max = 255,
              alpha = (100 - percent) * 255 / 100,
              names = name)

              ## Save the color
  invisible(t.col)
}


pdf(file = "dsc_boxplots_20200904.pdf", width = 7, height = 3, pointsize = 10)

par(mfcol = c(1,4), mar = c(5, 4, 4, 2) + 0.1)
ylimits <- c(0.5,1)
par(mar = c(4, 4, 4, 2) + 0.1)
shade <- 70
mymedlw <- 1
boxplot(rhipp_dice ~ diagnosis, data = hipp_amyg_cnn.df, ylim = ylimits, main = "Right Hippocampus", col = c(mypal[1], t_col(mypal[1], shade)), medlwd = mymedlw, xlab="", ylab = "Dice Similarity Coefficient", names = c("Control", "Epilepsy"))
par(mar = c(4, 3, 4, 2) + 0.1)
boxplot(lhipp_dice ~ diagnosis, data = hipp_amyg_cnn.df, ylim = ylimits, main = "Left Hippocampus", col = c(mypal[2], t_col(mypal[2], shade)), ylab = "", xlab="", names = c("Control", "Epilepsy"), medlwd = mymedlw)
boxplot(ramyg_dice ~ diagnosis, data = hipp_amyg_cnn.df, ylim = ylimits, main = "Right Amygdala", col = c(mypal[3], t_col(mypal[3], shade)), ylab = "", outline=F, xlab="", names = c("Control", "Epilepsy"), medlwd = mymedlw)
boxplot(lamyg_dice ~ diagnosis, data = hipp_amyg_cnn.df, ylim = ylimits, main = "Left Amygdala", col = c(mypal[4], t_col(mypal[4], shade)), ylab = "", xlab="", names = c("Control", "Epilepsy"), medlwd = mymedlw)
dev.off()
