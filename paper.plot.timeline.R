#load(file = "data/postCommentTimeline.RData")
plotFilename <- "paper-plots/timeline.pdf"
pdf(plotFilename, width = 8.27, height = 5.83)
hist(timeline$medianUserComment, breaks = 100,
     xlim=c(0,500),
     ylim=c(0, 20000),
     xlab="Time to obtain half of all comments by the posting user [in minutes]",
     ylab="Number of users",
     main = "")
dev.off()
embedFonts(plotFilename)
