library(dplyr)


#full results of pagerank (weighted) for all data
pr_rank <- read.csv("/Users/admin/Desktop/data/opendata_klout/microinfluencers/klout/pagerank/pagerank_calculated/pagerank_weighted_results_normalized.csv")

#list of uid of micorinfluencers (100 to 500)
micro_list <- read.csv("microinfluencersList_100-500.csv")

#wpr -> list of microinfluencers with pagerank values
wpr <- merge(micro_list, pr_rank)
wpr <- wpr%>%arrange(desc(pr_value))
wpr$user_id <-format(wpr$user_id, scientific = FALSE) 

wpr$X<-NULL
#adding order according to pagerank value
wpr$wpr_order <- seq.int(nrow(wpr))

arim<-read.csv("arim_result_microinfluencers_spread_100_to_500.csv")
arim$spread<-NULL
#adding order according to arim influence value
arim$user_id <-format(arim$user_id, scientific = FALSE) 
arim$arim_order <- seq.int(nrow(arim))

joined <- merge(wpr, arim)
joined$user_id <-format(joined$user_id, scientific = FALSE) 
#order by pagerank
joined <- joined%>%arrange(desc(pr_value))

result_pr <- data.frame(joined$user_id,joined$wpr_order,joined$pr_normalized,joined$arim_order,joined$influence_normalised)
write.csv(result_pr, row.names = FALSE, quote = FALSE, file = "microinfluencers_100-500_pr_order.csv")

#order by arim
joined <- joined%>%arrange(desc(influence))
result_arim <- data.frame(joined$user_id,joined$wpr_order,joined$pr_normalized,joined$arim_order,joined$influence_normalised)
write.csv(result_arim, row.names = FALSE, quote = FALSE, file = "microinfluencers_100-500_arim_order.csv")

