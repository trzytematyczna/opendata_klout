library(dplyr)

pagerank <- read.csv("data/pagerank_weighted_results.csv")
micro <- read.csv("microinfluencers_100-500.csv")

merged <- merge(micro, pagerank)
merged <- merged%>%arrange(desc(pr_value))
merged$user_id <-format(merged$user_id, scientific = FALSE) 
write.csv(merged, quote = FALSE, file = "pagerank_weighted_microinfluencers.csv")

wpr<-read.csv("pagerank_weighted_microinfluencers.csv")
wpr$X.1 <- NULL
wpr$X<-NULL
wpr$wpr_order <- seq.int(nrow(wpr))

arim<-read.csv("result_microinfluencers_spread_100_to_500.csv")
arim$spread<-NULL
arim$arim_order <- seq.int(nrow(arim))

arim_vs_wpr <- merge(wpr, arim)
arim_vs_wpr$user_id <-format(arim_vs_wpr$user_id, scientific = FALSE) 
arim_vs_wpr <- arim_vs_wpr%>%arrange(desc(pr_value))

write.csv(arim_vs_wpr, row.names = FALSE, quote = FALSE, file = "microinfluencers_100-500_pr_order.csv")

arim_vs_wpr <- arim_vs_wpr%>%arrange(desc(influence))
write.csv(arim_vs_wpr, row.names = FALSE, quote = FALSE, file = "microinfluencers_100-500_arim_order.csv")

