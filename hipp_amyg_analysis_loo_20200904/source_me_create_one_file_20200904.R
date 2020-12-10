library(stringr)
# read in files
dice.df <- read.table("leave_one_out_dice_overlap_20200730.dat", h=T)
demo.df <- read.csv("demographics_20200904.csv")
load("pan_hipp_amyg_vols_20200904.RData")

# make "id" column for dice.df and demo.df dataframes, vol.df is OK
dice.df$id <- str_split_fixed(dice.df$fname, "/", 3)[,2]
demo.df$id <- paste("sub", demo.df$subjectID, sep="-")

# merge them
hipp_amyg_cnn.df = Reduce(function(...) merge(..., by = "id"), list(demo.df,dice.df,vol.df))
hipp_amyg_cnn.df$diagnosis.x <- NULL
hipp_amyg_cnn.df$diagnosis <- hipp_amyg_cnn.df$diagnosis.y
hipp_amyg_cnn.df$diagnosis.y <- NULL

# exclude postsurgical case
hipp_amyg_cnn.df <- hipp_amyg_cnn.df[-35,]
