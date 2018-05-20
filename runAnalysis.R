# Load PRI
#pri <- read.csv("data/orig_pri.csv", header = T, stringsAsFactors = T, colClasses = c(rep("factor", 2), rep("numeric", 2)))
#save(pri, file="data/pri.RData")
# Load Spread
#spread <- read.csv("data/orig_spread.csv", header = T, stringsAsFactors = T, colClasses = c("factor", "numeric"))
#save(spread, file="data/spread.RData")
# Load User_posts 
#spread <- read.csv("data/orig_spread.csv", header = T, stringsAsFactors = T, colClasses = c("factor", "numeric"))
#user_posts <- read.csv("data/post_number.csv", header = T, stringsAsFactors = T, colClasses = c("factor", "numeric"))
#save(user_posts, file="data/user_posts.RData")

pri$pri <- pri$reaction_sum / pri$user_reacted_count
user_pri_mean <- aggregate(pri~user_id, data = pri, FUN=mean)

user_data <- merge(spread, user_posts, by="user_id")
user_data <- merge(user_data, user_pri_mean, by="user_id")

user_data$influence <- user_data$active_users * user_data$pri * exp(1/user_data$post_number)

user_data <- user_data[order(user_data$influence, decreasing = T), ]

save(user_data, file="data/user_data.RData")