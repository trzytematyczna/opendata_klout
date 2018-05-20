library(dplyr)

# Calculate min, avg, median, max time to comment in minutes
influence.postCommentTimeline <- function(user_posts) {
  user_posts %>%
    group_by(post_id) %>%
    summarise(avgComment = mean(action_timestamp - post_timestamp) / 1000 / 60,
              medianComment = median(action_timestamp - post_timestamp) / 1000 / 60)
}