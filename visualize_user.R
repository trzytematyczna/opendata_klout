library(plotly)
library(dplyr)
# User data visualization (bubble chart, x: active_users, y: num_comments, size: num_posts)

small_user <- user[user$num_posts > 10 & user$active_users > 500 & user$num_comments > 1000 & user$num_comments < 50000,]

#small_user <- sample_n(user, 30);

p <- plot_ly(small_user, x = small_user$num_comments, y=small_user$active_users, size = small_user$num_posts)
show(p)

p <- plot_ly(small_user, x = small_user$active_users, y=small_user$num_posts, size = small_user$num_comments)
show(p)

p <- plot_ly(small_user, x = small_user$num_posts, y=small_user$num_comments, size = small_user$active_users)
show(p)
