library(plotly)

opt <- function(data) {
  #num_posts <- x[1] # small
  #active_users <- x[2] # any
  #num_comments <- x[3] # big
  
  (data$num_comments / data$active_users) / (data$num_posts)
}

t <- small_user

#t$num_posts <- t$num_posts / max(t$num_posts)
#t$active_users <- t$active_users / max(t$active_users)
#t$num_comments <- t$num_comments / max(t$num_comments)
t$score <- opt(t)

to <- small_user
to$score <- opt(t)
to <- to[order(to$score, decreasing = T), ]
to <- to[1:100, ]

p <- plot_ly(to, x = to$num_posts, y=to$num_comments, size = to$active_users)
show(p)

write.csv(to, "data/top100.csv", row.names = F, quote = F)
