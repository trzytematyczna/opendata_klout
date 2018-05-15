library(dplyr)

# Calculate min, avg, median, max time to comment in minutes
influence.commentTimeline <- function(user_posts) {
  user_posts %>%
    group_by(post_id) %>%
    summarise(min = min(action_timestamp - post_timestamp) / 1000 / 60,
              avg = mean(action_timestamp - post_timestamp) / 1000 / 60,
              median = median(action_timestamp - post_timestamp) / 1000 / 60,
              max = max(action_timestamp - post_timestamp) / 1000 / 60)
}