
library("ggplot2")
library("ggmap")

#Step A: Load and Merge datasets

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

area <- ggplot(merge_data, aes(map_id = statename))
area <- area + geom_map(map = us, aes(fill = merge_data$area))      
area <- area + expand_limits(x = us$long , y = us$lat) + coord_map() + ggtitle("Area of United States")
area


#Step C: 

mur <- ggplot(merge_data, aes(map_id = statename))
mur <- mur + geom_map(map = us, aes(fill = merge_data$Murder))      
mur <- mur + expand_limits(x = us$long , y = us$lat) + coord_map() + ggtitle("United States based on the Murder rate per state")
mur
pop <- ggplot(merge_data, aes(map_id = statename))
pop <- pop + geom_map(map = us, aes(fill = merge_data$Murder)) 
pop <- pop + expand_limits(x = us$long , y = us$lat) + coord_map() + ggtitle("United States based on the Murder rate per state")
pop <- pop + geom_point( x = merge_data$x, y = merge_data$y, aes(size = merge_data$population))      
pop <- pop + ggtitle("Area of United States") 
pop

NYC <- geocode(source = "dsk", "nyc, new york,ny")
NYC

#Step D: Zoom the map
#â¢Repeat step C, but only show the states in the north east
#Hint: get the lat and lon of new york city
#Hint: set the xlim and ylim to NYC +/- 10

zoom <- ggplot(merge_data, aes(map_id = statename))
zoom <- zoom + geom_map(map = us, aes(fill = merge_data$Murder)) 
zoom <- zoom + expand_limits(x  = us$long, y = us$lat ) + coord_fixed(xlim = c(NYC$lon -10,NYC$lon +10), ylim = c(NYC$lat +10,NYC$lat -10)) 
zoom <- zoom + geom_point( x = merge_data$x, y = merge_data$y, aes(size = merge_data$population))      
zoom <- zoom + ggtitle(" NYC Murder Rate")
zoom



