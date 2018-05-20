source("influence.plotTrend.R")

selected_users <- read.csv("data/selected_users.csv", header = T, stringsAsFactors = T, colClasses = c(rep("factor", 3), rep("numeric", 2)))

# Window settings
a_day_in_ms <- 1000 * 3600 * 24
window <- list(
  start=min(selected_users$post_timestamp), # from when we apply the windows
  end=max(selected_users$post_timestamp),   # until when we apply the windows
  size=7 * a_day_in_ms)                  # the size of the applied windows

for (uid in unique(selected_users$user_id)) {
  plotFilename <- paste("paper-plots/trend", uid, ".pdf", sep="")
  pdf(plotFilename, width = 8.27, height = 5.83)
  influence.plotTrend(selected_users %>% filter(user_id == uid), window)
  dev.off()
  embedFonts(plotFilename)
}
