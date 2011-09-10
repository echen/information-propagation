# Make a static plot of upvote activity, and grab some general statistics.

library(ggplot2)

d = read.table("user-dates.txt", sep = "\t", header = F, col.names = c("user", "date"))
d = transform(d, date = as.Date(date, "%b %d, %Y"))

x = ddply(d, .(date), summarise, count = length(date))

qplot(date, weight = count, data = x, geom = "bar", binwidth = 1, xlab = "date", ylab = "# upvotes") + scale_x_date(major = "months", minor = "weeks", format = "%b '%y")

# Hack to add colors.
hack = read.table("rf-upvote-data.txt", sep = ",", header = T)
# x = transform(x, date = as.Date(x))
x$group = hack$group

cbgFillPalette <- scale_fill_manual(values=c("#555555", "#E69F00", "#56B4E9", "#009E73", "#0072B2", "#D55E00", "#CC79A7"))
qplot(date, weight = count, data = x, geom = "bar", binwidth = 1, xlab = "date", ylab = "# upvotes", fill = as.character(group)) + scale_x_date(major = "months", minor = "weeks", format = "%b '%y") + cbgFillPalette

d = read.table("reasons.txt", sep = "\t", header = F, col.names = c("user", "follows_topic", "has_referrer", "date"))
d = transform(d, follows_topic = follows_topic == 1, has_referrer = (has_referrer != ""))

# % of users not interested in initial topics
mean(d$follows_topic) # 68% follow, 32% don't.
# ...split by whether referred.
x = ddply(d, .(has_referrer), summarise, follows_topic = mean(follows_topic), count = length(has_referrer)) # true => 64%, false => 70%
# Percentage of users who follow one of the post topics, but didn't upvote the post until referred.
x = ddply(d, .(follows_topic), summarise, has_referrer = mean(has_referrer), count = length(follows_topic))
x = subset(d, follows_topic == T & has_referrer == T)
nrow(x) / nrow(d) # 23%
nrow(x) / nrow(subset(d, follows_topic == T)) # 33%

# Percentage of users referred by someone else.
mean(d$has_referrer) # 35% referred by someone else.

# Percentage of upvotes after a certain time.
32 / 141 # 23% of upvotes in first two weeks, 77% after first two weeks (i.e., after Mar 1).