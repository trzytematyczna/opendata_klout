#pri <- read.csv("csv/pri.csv", header = T)
#spread <- read.csv("csv/spread.csv", header = T)
spread$user_id <- as.factor(spread$user_id)
spread <- spread[order(spread$user_id), ]

pri$user_id <- as.factor(pri$user_id)
pri <- pri[order(pri$user_id), ]
pri$pri_ratio <- pri$reaction_sum/pri$user_reacted_count
user_pri_mean <- aggregate(pri_ratio~user_id, data = pri, FUN=mean)
user_pri_median <- aggregate(pri_ratio~user_id, data = pri, FUN=median)

pri_spread <- merge(spread, user_pri_mean, by="user_id")
influence <- data.frame(user_id=pri_spread$user_id, influence=(pri_spread$active_users*pri_spread$pri_ratio))
full_influence <- merge(pri_spread, influence, by="user_id")
full_influence <- full_influence[order(full_influence$influence, decreasing = T), ]

#influence <- data.frame(user_id=pri_spread$user_id, influence=(pri_spread$active_users*pri_spread$pri_ratio))
#influence <- influence[order(influence$influence, decreasing = TRUE), ]

#top_influencers <- influence[1:10, ]$user_id
#full_top_influencers <- pri_spread[pri_spread$user_id %in% top_influencers, ]