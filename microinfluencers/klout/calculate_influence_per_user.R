library(dplyr)

engagement <- read.csv("engagement_spread.csv",
                       header = T,
                       stringsAsFactors = T,
                       colClasses = c("factor", rep("numeric", 2)))
fc <- read.csv("fc_A.csv",
               header = T,
               stringsAsFactors = T,
               colClasses = c("factor", "numeric"))

# Compute 
computed_influence <- engagement %>%
  mutate(influence = engagement_value * exp(1/fc$engag_denominator)) %>%
  filter(spread > 100) %>%
  arrange(desc(influence))

# Save users' influence ordered by the influence
write.csv(computed_influence %>% select(user_id, spread, influence),
          "result_by_influence.csv",
          row.names = F,
          quote = F)
# Save users' influence ordered by user's audience (spread)
write.csv(computed_influence %>% select(user_id, spread, influence) %>% arrange(desc(spread)),
          "result_by_spread.csv",
          row.names = F,
          quote = F)

# Compute all
computed_influence <- engagement %>%
  mutate(influence = engagement_value * exp(1/fc$engag_denominator)) %>%
  arrange(desc(influence))

# Save users' influence ordered by user's audience (spread) for all
write.csv(computed_influence %>% select(user_id, spread, influence) %>% arrange(desc(spread)),
          "result_by_spread_all.csv",
          row.names = F,
          quote = F)