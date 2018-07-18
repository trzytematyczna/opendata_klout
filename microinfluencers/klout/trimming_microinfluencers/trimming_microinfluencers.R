library(dplyr)


#full results of pagerank (weighted) for all data
pagerank <- read.csv("/Users/admin/Desktop/data/opendata_klout/microinfluencers/klout/pagerank/pagerank_calculated/pagerank_weighted_results.csv")

#list of uid of micorinfluencers (100 to 500)
micro <- read.csv("microinfluencersList_100-500.csv")

#wpr -> list of microinfluencers with pagerank values
wpr <- merge(micro, pagerank)
wpr <- wpr%>%arrange(desc(pr_value))
wpr$user_id <-format(wpr$user_id, scientific = FALSE) 

wpr$X<-NULL
#adding order according to pagerank value
wpr$wpr_order <- seq.int(nrow(wpr))

arim<-read.csv("result_microinfluencers_spread_100_to_500.csv")
arim$spread<-NULL
#adding order according to arim influence value
arim$arim_order <- seq.int(nrow(arim))

arim_vs_wpr <- merge(wpr, arim)
arim_vs_wpr$user_id <-format(arim_vs_wpr$user_id, scientific = FALSE) 
#order by pagerank
arim_vs_wpr <- arim_vs_wpr%>%arrange(desc(pr_value))
write.csv(arim_vs_wpr, row.names = FALSE, quote = FALSE, file = "microinfluencers_100-500_pr_order.csv")

#order by arim
arim_vs_wpr <- arim_vs_wpr%>%arrange(desc(influence))
write.csv(arim_vs_wpr, row.names = FALSE, quote = FALSE, file = "microinfluencers_100-500_arim_order.csv")

