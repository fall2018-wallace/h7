
library("ggplot2")
library("ggmap")

localUSArrests<-USArrests
localUSArrests
df
df<-df[-9,]
row.names(localUSArrests)
colnames(df)
localUSArrests$stateName <- df$stateName  
df <- merge(df, localUSArrests)   #merging by the common column stateName
df       


statename <- localUSArrests$stateName
area <- state.area
center <- state.center

merge_df <- data.frame(statename, area, center)

merge_data <- merge(df, merge_df )

us <- map_data("state")

merge_data$statename <- tolower(merge_data$statename)




