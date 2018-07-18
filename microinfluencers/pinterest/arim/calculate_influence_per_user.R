library(dplyr)

engagement <- read.csv("user_id_engagement_spread_weights1.csv",
                       header = T,
                       stringsAsFactors = T,
                       colClasses = c("factor", rep("numeric", 3)))
fc <- read.csv("fc_A.csv",
               header = T,
               stringsAsFactors = T,
               colClasses = c("factor", "numeric"))

# Compute microinfluencers with spread between 100 and 500 
computed_influence <- engagement %>%
  mutate(influence = engagement * exp(1/fc$posts_no_ae_denominator)) %>%
  filter(spread > 100 & spread < 500) %>%
  arrange(desc(influence)) %>%
  mutate(influence_normalised = (influence-min(influence))/(max(influence)-min(influence)))

# Save users' influence ordered by the influence
write.csv(computed_influence %>% select(user_id, spread, influence, influence_normalised),
           "../trimming_microinfluencers/result_microinfluencers_spread_100_to_500.csv",
           row.names = F,
           quote = F)
 
# Compute microinfluencers with spread between 1000 and 5000
computed_influence <- engagement %>%
  mutate(influence = engagement * exp(1/fc$posts_no_ae_denominator)) %>%
  filter(spread > 1000 & spread < 5000) %>%
  arrange(desc(influence)) %>%
  mutate(influence_normalised = (influence-min(influence))/(max(influence)-min(influence)))

# Save users' influence ordered by the influence
write.csv(computed_influence %>% select(user_id, spread, influence, influence_normalised),
          "../trimming_microinfluencers/result_microinfluencers_spread_1000_to_5000.csv",
          row.names = F,
          quote = F)