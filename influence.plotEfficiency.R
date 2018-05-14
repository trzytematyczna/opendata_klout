#
# time_window -- in days (1d == 1000 * 3600 * 24 ms)
#influence.plotEfficiency <- function(user_posts, time_window) {
  
  user_posts <- top100posts %>% filter(user_id == "-2172252558949697874")
  user_posts <- user_posts %>% arrange(post_timestamp)
  
  a_day_in_ms <- 1000 * 3600 * 24
  time_window <- 7 * a_day_in_ms
  unique_post_ts <- unique(user_posts$post_timestamp)
  start_ts <- min(unique_post_ts)
  end_ts <- max(unique_post_ts)
  diff_ts <- end_ts - start_ts
  num_time_window <- round(diff_ts / time_window)
  # assing time window factors to each post (TODO: do this for the whole data before!)
  #user_posts$time_window <- 17;#rep(factor("tw1"), nrow(user_posts))
  for (tw in 0:num_time_window) {
    tw_end <- start_ts + tw * time_window
    user_posts$time_window <- ifelse(user_posts$post_timestamp >= tw_end, tw+1, user_posts$time_window)
  }
  #user_posts$time_window <- as.factor(paste(as.character("tw"), user_posts$time_window, sep=""))
  
  
  plot(unique_post_ts, rep(1, length(unique_post_ts)))
  abline(v = c(start_ts + 1:(num_time_window-1)*time_window), col = "red", lty=2)
  
  par(mfrow=c(1, 2))
  comment_count <- user_posts %>% group_by(time_window) %>% count()
  plot(comment_count$time_window, comment_count$n, type="b", lty=2, ylim=c(0, max(comment_count$n)*1.1))
  pl <- lm(n~time_window, comment_count)
  abline(pl)
  
  just_posts <- user_posts[!duplicated(user_posts$post_id), ]
  post_count <- just_posts %>% group_by(time_window) %>% count()
  plot(post_count$time_window, post_count$n, lty=2, type="b")
  pl <- lm(n~time_window, post_count)
  abline(pl)
  
#}