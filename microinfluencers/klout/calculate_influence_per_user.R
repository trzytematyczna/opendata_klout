library(dplyr)

engagement <- read.csv("engagement_spread.csv",
                       header = T,
                       stringsAsFactors = T,
                       colClasses = c("factor", rep("numeric", 2)))
fc <- read.csv("fc_A.csv",
               header = T,
               stringsAsFactors = T,
               colClasses = c("factor", "numeric"))

# Compute microinfluencers with spread between 100 and 500 
computed_influence <- engagement %>%
  mutate(influence = engagement_value * exp(1/fc$engag_denominator)) %>%
  filter(spread > 100 & spread < 500) %>%
  arrange(desc(influence))

# Save users' influence ordered by the influence
write.csv(computed_influence %>% select(user_id, spread, influence),
          "result_microinfluencers_spread_100_to_500.csv",
          row.names = F,
          quote = F)

# Compute microinfluencers with spread between 1000 and 5000
computed_influence <- engagement %>%
  mutate(influence = engagement_value * exp(1/fc$engag_denominator)) %>%
  filter(spread > 1000 & spread < 5000) %>%
  arrange(desc(influence))

# Save users' influence ordered by the influence
write.csv(computed_influence %>% select(user_id, spread, influence),
          "result_microinfluencers_spread_1000_to_5000.csv",
          row.names = F,
          quote = F)