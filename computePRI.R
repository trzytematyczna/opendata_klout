library(dplyr)

pri <- read.csv("data/pri.csv", header = T, stringsAsFactors = T, colClasses = c("factor", "factor", rep("numeric", 2)))
spread <- read.csv("data/spread.csv", header = T, stringsAsFactors = T, colClasses = c("factor", "numeric"))
spread$user_id <- as.factor(spread$user_id)
spread <- spread[order(spread$user_id), ]

pri$user_id <- as.factor(pri$user_id)
pri <- pri[order(pri$user_id), ]
pri$pri_ratio <- pri$reaction_sum/pri$user_reacted_count
user_pri_mean <- aggregate(pri_ratio~user_id, data = pri, FUN=mean)
user_pri_median <- aggregate(pri_ratio~user_id, data = pri, FUN=median)

pri_spread <- merge(spread, user_pri_median, by="user_id")
influence <- data.frame(user_id=pri_spread$user_id, influence=(pri_spread$active_users*pri_spread$pri_ratio))
full_influence <- merge(pri_spread, influence, by="user_id")
full_influence <- full_influence[order(full_influence$influence, decreasing = T), ]

## Prepare user table
user <- data.frame(user_id = pri$user_id);
# Add num of posts of each user
user <- user %>% 
  group_by(user_id) %>% 
  summarise(num_posts = length(user_id))
# Add spread (uniqe audience)
user <- merge(user, spread, by="user_id")
# Add num of received comments
user_received_comments <- pri %>% group_by(user_id) %>% summarise(num_comments = sum(reaction_sum))
user <- merge(user, user_received_comments, by="user_id")

## Test data
# user$num_comments >= user$active_user
