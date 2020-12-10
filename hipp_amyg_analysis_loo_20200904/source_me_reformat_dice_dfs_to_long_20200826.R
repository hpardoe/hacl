# make dataframe like this
# dice  | side  | matched | structure | diagnosis | id
library("reshape2")
unmatched_prelim.df <- get_dice("testSessionDm20200505_unmatched.txt")
unmatched_more_cases.df <- get_dice("testSessionDm20200527_additional_epilepsy_cases_unmatched.txt")
matched_prelim.df <- get_dice("testSessionDm20200505_matched.txt")
matched_more_cases.df <- get_dice("testSessionDm20200826_additional_epilepsy_cases_matched.txt")

matched.df <- rbind(matched_prelim.df,matched_more_cases.df)
unmatched.df <- rbind(unmatched_prelim.df,unmatched_more_cases.df)





matched.df$matched <- "matched"
unmatched.df$matched <- "unmatched"

combined.df <- rbind(matched.df, unmatched.df)
names(combined.df)[2] <- "dice_background"
names(combined.df)[3] <- "dice_righthipp"
names(combined.df)[4] <- "dice_lefthipp"
names(combined.df)[5] <- "dice_rightamyg"
names(combined.df)[6] <- "dice_leftamyg"

combined.df$dice_background <- NULL

combLong.df <- melt(combined.df, value.name = "dice")

combLong.df$side <- "left"
combLong.df$side[ grep("right", combLong.df$variable) ] <- "right"

combLong.df$structure <- "hipp"
combLong.df$structure[ grep("amyg", combLong.df$variable) ] <- "amygdala"

combLong.df$diagnosis <- "control"
combLong.df$diagnosis[ grep("epilepsy", combLong.df$id) ] <- "epilepsy"

combLong.df$matched <- as.factor(combLong.df$matched)
combLong.df$side <- as.factor(combLong.df$side)
combLong.df$structure <- as.factor(combLong.df$structure)
combLong.df$diagnosis <- as.factor(combLong.df$diagnosis)
