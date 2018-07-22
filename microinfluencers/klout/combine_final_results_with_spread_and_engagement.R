spread_engagement <- read.csv("arim/engagement_spread.csv")

arim_order <- read.csv("trimming_microinfluencers/results_final/microinfluencers_100-500_arim_order.csv")
pr_order <- read.csv("trimming_microinfluencers/results_final/microinfluencers_100-500_pr_order.csv")

colnames(arim_order) <- gsub("joined.", "", colnames(arim_order))
colnames(pr_order) <- gsub("joined.", "", colnames(pr_order))

spread_engagement$user_id <-format(spread_engagement$user_id, scientific = FALSE)
arim_order$user_id <-format(arim_order$user_id, scientific = FALSE)
pr_order$user_id <-format(pr_order$user_id, scientific = FALSE) 

arim_order <- merge(arim_order, spread_engagement, by = "user_id")
pr_order <- merge(spread_engagement, pr_order, by = "user_id")

# format data
arim_order$pr_normalized <- round(arim_order$pr_normalized, digits = 6)
arim_order$influence_normalised <- round(arim_order$influence_normalised, digits = 6)
arim_order$engagement_value <- round(arim_order$engagement_value, digits = 6)

pr_order$pr_normalized <- round(pr_order$pr_normalized, digits = 6)
pr_order$influence_normalised <- round(pr_order$influence_normalised, digits = 6)
pr_order$engagement_value <- round(pr_order$engagement_value, digits = 6)

write.csv(arim_order, "trimming_microinfluencers/results_final/microinfluencers_100-500_arim_order_full.csv", row.names = F)
write.csv(pr_order, "trimming_microinfluencers/results_final/microinfluencers_100-500_pr_order_full.csv", row.names = F)