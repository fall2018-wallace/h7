
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

# Step B.
# a. 

map_area <- ggplot(merge_data, aes(map_id = statename))
map_area <- map_area + geom_map(map = us, aes(fill = merge_data$area))      
map_area <- map_area + expand_limits(x = us$long , y = us$lat) + coord_map() + ggtitle("Area of United States")
map_area


#Step C: Create a color shaded map of the U.S. based on the Murder rate for each state 
#â¢Repeat step B, but color code the map based on the murder rate of each state.
map_mur <- ggplot(merge_data, aes(map_id = statename))
map_mur <- map_mur + geom_map(map = us, aes(fill = merge_data$Murder))      
map_mur <- map_mur + expand_limits(x = us$long , y = us$lat) + coord_map() + ggtitle("United States based on the Murder rate per state")
map_mur



