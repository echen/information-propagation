# Look at user clusters using Gephi's community detection algorithm.

d = read.table("user-network-data-simplified.txt", sep = "\t", header = F, col.names = c("user", "which", "purple", "red", "green", "modularity"))

x = ddply(d, .(modularity), function(df) {
  purple = subset(df, which == "purple")
  red = subset(df, which == "red")
  green = subset(df, which == "green")
  size = nrow(df)
  data.frame(
    purple = nrow(purple) / size,
    red = nrow(red) / size,
    green = nrow(green) / size
  )            
})