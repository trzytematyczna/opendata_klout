load("data/user_data.RData")

library(radarchart)

top <- user_data[1:3, ]

# normalize to [0, 1]
top$active_users <- top$active_users / max(top$active_users)
top$post_number <- top$post_number / max(top$post_number)
top$pri <- top$pri / max(top$pri)
top$influence <- top$influence / max(top$influence)

labs <- c("Spread", "Post number", "Engagement", "Influence")

scores <- list()
for (i in 1:nrow(top)) {
  scores[[paste("u", as.character(i), sep="")]] <- as.numeric(as.vector(top[i, 2:5])) 
}

show(chartJSRadar(scores = scores, labs = labs, maxScale = 1))