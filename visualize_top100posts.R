library(dplyr)

top100posts <- read.csv("data/top100posts.csv", header = T, colClasses = c(rep("factor", 3), rep("numeric", 2), "character", "numeric"))
top100posts <- top100posts[order(top100posts$post_id), ]

# The same posts might have different timestamps, we need to average them and truncate!
posts_mean_ts <- with(top100posts, aggregate(post_timestamp ~ post_id, FUN = mean))
posts_mean_ts$post_timestamp <- ceiling(posts_mean_ts$post_timestamp)

top100posts <- merge(top100posts, posts_mean_ts, by = "post_id")
top100posts <- top100posts %>% select(-post_timestamp.x)
colnames(top100posts)[7] <- "post_timestamp"

just_posts <- top100posts[!duplicated(top100posts$post_id), ]
start_time <- min(just_posts$post_timestamp)
time_of_day <- 1000 * 3600 * 24 # ms
time_of_day <- time_of_day * 192

just_posts <- just_posts[just_posts$post_timestamp < start_time + time_of_day, ]

plot(just_posts$post_timestamp, just_posts$user_id)

