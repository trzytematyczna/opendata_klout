user_posts <- read.csv("data/post_number.csv", header = T, stringsAsFactors = T, colClasses = c("factor", "numeric"))

user_posts_min <- min(user_posts$post_number)
user_posts_mean <- mean(user_posts$post_number)
user_posts_median <- median(user_posts$post_number)
user_posts_max <- max(user_posts$post_number)
