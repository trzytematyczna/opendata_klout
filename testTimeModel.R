source("influence.plotEfficiency.R")
source("influence.plotEfficiency2.R")
source("influence.plotEfficiency3.R")
source("influence.commentTimeline.R")

## Some posts and their properties (time window 7d)
# 1) 7668600250826378255 -- classic slide down on all counts
# 2) 6252890798757017754 -- constant posts and comments, increasing spread, but droping pri
# 3) 1540784020687880833  -- more posts, but all the rest going down
# 4) -3000490335411638731 -- balancing!
# 5) -5562342665076700406 -- all go up!
user_posts <- top100posts %>% filter(user_id == sample(top100posts$user_id, 1))

# Window settings
a_day_in_ms <- 1000 * 3600 * 24
window <- list(
  start=min(top100posts$post_timestamp), # from when we apply the windows
  end=max(top100posts$post_timestamp),   # until when we apply the windows
  size=7 * a_day_in_ms)                  # the size of the applied windows

influence.plotEfficiency(user_posts, window)
#timeline <- influence.commentTimeline(user_posts)

window <- list(
  start=min(top100posts$post_timestamp), # from when we apply the windows
  end=max(top100posts$post_timestamp),   # until when we apply the windows
  size=7 * a_day_in_ms,                  # the size of the applied windows
  step=1 * a_day_in_ms)                  # moving window step

## TODO: make PRI absolute from size of the time window?
#influence.plotEfficiency2(user_posts, window)

just_7_days <- user_posts %>% filter(post_timestamp <= window$start + window$size * 2 & action_timestamp <= window$start + window$size * 2)

influence.plotEfficiency3(just_7_days)

timeline <- influence.commentTimeline(top100posts)
par(mfrow=c(1, 2))
plot(density(timeline$medianUserComment))
plot(density(timeline$avgUserComment))