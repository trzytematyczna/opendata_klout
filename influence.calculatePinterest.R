engagement <- read.csv("data/pinterest/user_id_engagement_spread_weights1.csv", header = T, stringsAsFactors = T, colClasses = c("factor", rep("numeric", 3)))
engagement$influence <- engagement$engagement * engagement$spread * exp(1/engagement$posts_num)
engagement <- engagement[order(engagement$influence, decreasing=T), ]
write.csv(engagement, "data/pinterest/influence.csv", quote = F, row.names = F)