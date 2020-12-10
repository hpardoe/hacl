# source_me_create_one_file_20200904.R should be run first
library("reshape2")

to_melt.df <- hipp_amyg_cnn.df[,c(1,3,4,7:10,39)]

names(to_melt.df)[4] <- "rhipp"
names(to_melt.df)[5] <- "lhipp"
names(to_melt.df)[6] <- "ramyg"
names(to_melt.df)[7] <- "lamyg"

msr <- c("rhipp","lhipp","ramyg","lamyg")
hipp_amyg_dice_melted.df <- melt(to_melt.df, value.name = "dice", measure.vars=msr)
names(hipp_amyg_dice_melted.df)[5] <- "structure"

for (i in 1:dim(hipp_amyg_dice_melted.df)[1]) {
  if ((hipp_amyg_dice_melted.df$structure[i] == "rhipp") | (hipp_amyg_dice_melted.df$structure[i] == "ramyg")) hipp_amyg_dice_melted.df$side[i] <- "right" else hipp_amyg_dice_melted.df$side[i] <- "left"
  if ((hipp_amyg_dice_melted.df$structure[i] == "rhipp") | (hipp_amyg_dice_melted.df$structure[i] == "lhipp")) hipp_amyg_dice_melted.df$limbic_structure[i] <- "hipp" else hipp_amyg_dice_melted.df$limbic_structure[i] <- "amyg"
}
summary(lm(dice ~ diagnosis + structure + side, data = hipp_amyg_dice_melted.df))
