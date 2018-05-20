# Load PRI
pri <- read.csv("data/pri.csv", header = T, stringsAsFactors = T, colClasses = c(rep("factor", 2), rep("numeric", 2)))
# Load Spread
spread <- read.csv("data/spread.csv", header = T, stringsAsFactors = T, colClasses = c("factor", "numeric"))
# Load User_posts 
user_posts <- read.csv("data/post_number.csv", header = T, stringsAsFactors = T, colClasses = c("factor", "numeric"))

pri$pri <- pri$reaction_sum / pri$user_reacted_count
user_pri_mean <- aggregate(pri~user_id, data = pri, FUN=mean)
user_data <- merge(spread, user_posts, by="user_id")
user_data <- merge(user_data, user_pri_mean, by="user_id")
user_data$influence <- user_data$active_users * user_data$pri * exp(1/user_data$post_number)
user_data <- user_data[order(user_data$influence, decreasing = T), ]

write.csv(user_data, file = "data/user_data.csv", quote = F, row.names = F)
