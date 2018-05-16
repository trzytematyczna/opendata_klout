library(dplyr)

# Calculate min, avg, median, max time to comment in minutes
influence.commentTimeline <- function(user_posts) {
  user_posts %>%
    group_by(user_id, post_id) %>%
    summarise(minComment = min(action_timestamp - post_timestamp) / 1000 / 60,
              avgComment = mean(action_timestamp - post_timestamp) / 1000 / 60,
              medianComment = median(action_timestamp - post_timestamp) / 1000 / 60,
              maxComment = max(action_timestamp - post_timestamp) / 1000 / 60) %>%
    group_by(user_id) %>%
    summarise(medianUserComment = median(medianComment), avgUserComment = mean(medianComment))
}