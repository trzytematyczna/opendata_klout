library(radarchart)

influence <- read.csv("data/pinterest/influence.csv", header = T, stringsAsFactors = T, colClasses = c("factor", rep("numeric", 4)))
top <- influence[1:3, ]

# normalize to [0, 1]
top$spread <- top$spread / max(top$spread)
top$posts_num <- top$posts_num / max(top$posts_num)
top$engagement <- top$engagement / max(top$engagement)
top$influence <- top$influence / max(top$influence)

labs <- c("Spread", "Post number", "Engagement", "Influence")

scores <- list()
for (i in 1:nrow(top)) {
  scores[[paste("u", as.character(i), sep="")]] <- as.numeric(as.vector(top[i, 2:5])) 
}

show(chartJSRadar(scores = scores, labs = labs, maxScale = 1))