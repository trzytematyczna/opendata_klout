library(dplyr)

influence.plotEfficiency <- function(user_posts, window) {
  diff_ts <- window$end - window$start
  num_time_window <- round(diff_ts / window$size) - 1 # skip the last "window" (usaully not a full window)
  # assing time window factors to each post
  for (tw in 0:num_time_window) {
    tw_end <- window$start + tw * window$size
    # post time window
    user_posts$time_window <- ifelse(user_posts$post_timestamp >= tw_end, tw+1, user_posts$time_window)
    # comment time window
    user_posts$time_window_comment <- ifelse(user_posts$action_timestamp >= tw_end, tw+1, user_posts$time_window_comment)
  }

  post_count <- user_posts %>%
    group_by(time_window) %>%
    summarise(n = length(unique(post_id)))
  
  comment_count <- user_posts %>%
    group_by(time_window) %>%
    count()
  
  pri_tw <- user_posts %>%
    group_by(time_window_comment) %>%
    summarise(pri = length(actor_id) / length(unique(actor_id)))
  # pri_tw <- user_posts %>%
  #   group_by(post_id,time_window_comment) %>%
  #   summarise(pri = length(actor_id) / length(unique(actor_id))) %>%
  #   group_by(time_window_comment) %>%
  #   summarise(pri = mean(pri))
  
  spread_tw <- user_posts %>%
    group_by(time_window) %>%
    summarise(n = length(unique(actor_id)))
  
  # plot data
  par(mfrow=c(1, 4))
  plot(post_count$time_window, post_count$n, lty=2, type="b",
       main = "Post count", xlab = "Window (timeline)", ylab="#posts", bty="n")
  abline(lm(n ~ time_window, post_count), col="red")
  
  plot(comment_count$time_window, comment_count$n, type="b", lty=2,
       main = "Comment count", xlab = "Window (timeline)", ylab="#comment", bty="n")
  abline(lm(n ~ time_window, comment_count), col="red")
  
  plot(pri_tw$time_window_comment, pri_tw$pri, type="b", lty=2, ,
       main = "PRI value (impact)", xlab = "Window (timeline)", ylab="Post-reaction intensity (PRI)", bty="n")
  abline(lm(pri~time_window_comment, pri_tw), col="red")
  
  plot(spread_tw$time_window, spread_tw$n, type="b", lty=2,
       main = "Spread value", xlab = "Window (timeline)", ylab="Spread (unique audience)", bty="n")
  abline(lm(n ~ time_window, spread_tw), col="red")
}