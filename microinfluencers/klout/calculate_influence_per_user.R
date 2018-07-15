library(dplyr)

engagement <- read.csv("engagement.csv", header = T, stringsAsFactors = T, colClasses = c("factor", rep("numeric", 2)))
# FC doesn't contain the num of posts ! Is it true? They are the same in both CSVs
fc <- read.csv("fc_A.csv", header = T, stringsAsFactors = T, colClasses = c("factor", "numeric"))

engagement <- engagement %>%
  mutate(influence = (engag_numerator / engag_denominator) * exp(1/engag_denominator)) %>%
  arrange(influence) %>%
  filter(engag_denominator > 100)