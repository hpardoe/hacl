# source_me_create_one_file_20200904.R should be run first
library("reshape2")

mtl_involvement_df <- data.frame(id = c("sub-epilepsy03","sub-epilepsy05","sub-epilepsy11", "sub-epilepsy12","sub-epilepsy09","sub-epilepsy09","sub-epilepsy16"),
  affected_side = c("left","right","left","right","right","left","right"))


vol_melt.df <- hipp_amyg_cnn.df[,c(1,3,4,12:15,22,39)]

names(vol_melt.df)[4] <- "rhipp"
names(vol_melt.df)[5] <- "lhipp"
names(vol_melt.df)[6] <- "ramyg"
names(vol_melt.df)[7] <- "lamyg"

msr <- c("rhipp","lhipp","ramyg","lamyg")
hipp_amyg_vol_melted.df <- melt(vol_melt.df, value.name = "vol", measure.vars=msr)
names(hipp_amyg_vol_melted.df)[6] <- "structure"

for (i in 1:dim(hipp_amyg_vol_melted.df)[1]) {
  if ((hipp_amyg_vol_melted.df$structure[i] == "rhipp") | (hipp_amyg_vol_melted.df$structure[i] == "ramyg")) hipp_amyg_vol_melted.df$side[i] <- "right" else hipp_amyg_vol_melted.df$side[i] <- "left"
  if ((hipp_amyg_vol_melted.df$structure[i] == "rhipp") | (hipp_amyg_vol_melted.df$structure[i] == "lhipp")) hipp_amyg_vol_melted.df$limbic_structure[i] <- "hipp" else hipp_amyg_vol_melted.df$limbic_structure[i] <- "amyg"
}

#summary(lm(vol ~ diagnosis + structure + side + age + sex + brain_vol_mm3, data = hipp_amyg_vol_melted.df))

hipp_amyg_vol_melted.df$mtl_involvement <- FALSE
hipp_amyg_vol_melted.df$laterality <- "nonlateralized"

for (i in 1:dim(hipp_amyg_vol_melted.df)[1]) {
  if (any(hipp_amyg_vol_melted.df$id[i] == mtl_involvement_df$id)) {
    hipp_amyg_vol_melted.df$mtl_involvement[i] <- TRUE
    if (any((hipp_amyg_vol_melted.df$id[i] == mtl_involvement_df$id) & (hipp_amyg_vol_melted.df$side[i] == mtl_involvement_df$affected_side))) hipp_amyg_vol_melted.df$laterality[i] <- "ipsilateral" else if (any((hipp_amyg_vol_melted.df$id[i] == mtl_involvement_df$id) & (hipp_amyg_vol_melted.df$side[i] != mtl_involvement_df$affected_side))) hipp_amyg_vol_melted.df$laterality[i] <- "contralateral"
  }
}
