
library("ggplot2")
library("ggmap")

localUSArrests<-USArrests
localUSArrests
df
df<-df[-9,]
row.names(localUSArrests)
colnames(df)
localUSArrests$stateName <- df$stateName  
df <- merge(df, localUSArrests, by = "stateName")   #merging by the common column stateName
df       


statname <- localUSArrests$stateName
area <- state.area
center <- state.center

df <- data.frame(statname, area, center)



