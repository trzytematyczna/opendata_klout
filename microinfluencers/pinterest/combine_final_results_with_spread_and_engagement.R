library(dplyr)

spread_engagement <- read.csv("arim/user_id_engagement_spread_weights1.csv")
spread_engagement <- spread_engagement %>%
  select(user_id, spread, engagement)

arim_order <- read.csv("trimming_microinfluencers/results_final/microinfluencers_100-500_arim_order.csv")
pr_order <- read.csv("trimming_microinfluencers/results_final/microinfluencers_100-500_pr_order.csv")

colnames(arim_order) <- gsub("joined.", "", colnames(arim_order))
colnames(pr_order) <- gsub("joined.", "", colnames(pr_order))

spread_engagement$user_id <-format(spread_engagement$user_id, scientific = FALSE)
arim_order$user_id <-format(arim_order$user_id, scientific = FALSE)
pr_order$user_id <-format(pr_order$user_id, scientific = FALSE) 

arim_order <- merge(arim_order, spread_engagement, by = "user_id")
pr_order <- merge(spread_engagement, pr_order, by = "user_id")

write.csv(arim_order, "trimming_microinfluencers/results_final/microinfluencers_100-500_arim_order_full.csv", row.names = F)
write.csv(pr_order, "trimming_microinfluencers/results_final/microinfluencers_100-500_pr_order_full.csv", row.names = F)