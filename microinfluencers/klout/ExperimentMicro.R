source("BuildGraph.R")
library(dplyr)

globalInfluence <- read.csv(filename)
g <- graph(directed = TRUE, edges = as.character(t(globalInfluence[,1:2])))
pr <- page_rank(g)
pr_df <- data.frame(user_id=as.factor(names(pr$vector)), pr_value=unname(pr$vector))
pr_df_ordered <- pr_df%>%arrange(desc(pr_value))
write.csv(pr_df_ordered, quote = FALSE, file = "pagerank_results.csv")

pr_weight <- page_rank(g, weights = globalInfluence$weight)
pr_weight_df <- data.frame(user_id=as.factor(names(pr_weight$vector)), pr_value=unname(pr_weight$vector))
pr_weight_df_ordered <- pr_weight_df%>%arrange(desc(pr_value))

write.csv(pr_df_weight_ordered, quote = FALSE, file = "pagerank_weighted_results.csv")
