library(dplyr)

# Moving window
influence.plotEfficiency2 <- function(user_posts, window) {
  #num_time_window <- round(diff_ts / window$step) - window$size # skip the last < window$size (usaully not a full window)
  num_time_window <- ((window$end - window$start) - window$size) / window$step
  
  post_count <- numeric(num_time_window)
  comment_count <- numeric(num_time_window)
  pri <- numeric(num_time_window)
  spread <- numeric(num_time_window)
  
  # assing time window factors to each post
  for (tw in 0:(num_time_window-1)) {
    tw_begin <- window$start + tw * window$step
    tw_end <- window$start + tw * window$step + window$size
    show(tw)
    # get subste of data according to the moving window
    user_sub <- user_posts %>% filter(post_timestamp >= tw_begin & post_timestamp < tw_end)
    post_count[tw+1] <- length(unique(user_sub$post_id))
    comment_count[tw+1] <- nrow(user_sub)
    spread[tw+1] <- length(unique(user_sub$actor_id))
    user_sub <- user_posts %>% filter(action_timestamp >= tw_begin & action_timestamp < tw_end)
    pri[tw+1] <- length(user_sub$actor_id) / length(unique(user_sub$actor_id))
  }
  
  post_count <- data.frame(time_window=1:num_time_window, n=post_count)
  comment_count <- data.frame(time_window=1:num_time_window, n=comment_count)
  spread <- data.frame(time_window=1:num_time_window, n=spread)
  pri <- data.frame(time_window=1:num_time_window, n=pri)
  
  # # plot data
  par(mfrow=c(1, 4))
  plot(post_count$time_window, post_count$n, lty=2, type="b",
       main = "Post count", xlab = "Window (timeline)", ylab="#posts", bty="n")
  abline(lm(n ~ time_window, post_count), col="red")
  # 
  plot(comment_count$time_window, comment_count$n, type="b", lty=2,
      main = "Comment count", xlab = "Window (timeline)", ylab="#comment", bty="n")
  abline(lm(n ~ time_window, comment_count), col="red")

  plot(pri$time_window, pri$n, type="b", lty=2, ,
       main = "PRI value (impact)", xlab = "Window (timeline)", ylab="Post-reaction intensity (PRI)", bty="n")
  abline(lm(n~time_window, pri), col="red")

  plot(spread$time_window, spread$n, type="b", lty=2,
       main = "Spread value", xlab = "Window (timeline)", ylab="Spread (unique audience)", bty="n")
  abline(lm(n ~ time_window, spread), col="red")
}