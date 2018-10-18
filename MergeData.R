
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

area <- ggplot(merge_data, aes(map_id = statename))
area <- map_area + geom_map(map = us, aes(fill = merge_data$area))      
area <- map_area + expand_limits(x = us$long , y = us$lat) + coord_map() + ggtitle("Area of United States")
area


#Step C: Create a color shaded map of the U.S. based on the Murder rate for each state 
#â¢Repeat step B, but color code the map based on the murder rate of each state.
mur <- ggplot(merge_data, aes(map_id = statename))
mur <- map_mur + geom_map(map = us, aes(fill = merge_data$Murder))      
mur <- map_mur + expand_limits(x = us$long , y = us$lat) + coord_map() + ggtitle("United States based on the Murder rate per state")
mur

#â¢Show the population as a circle per state
#(the larger the population, the larger the circle) using the location defined by the center of each state


pop <- ggplot(merge_data, aes(map_id = statename))
pop <- map_mur_pop + geom_map(map = us, aes(fill = merge_data$Murder)) 
pop <- map_mur_pop + expand_limits(x = us$long , y = us$lat) + coord_map() + ggtitle("United States based on the Murder rate per state")
pop<- map_mur_pop + geom_point( x = merge_data$x, y = merge_data$y, aes(size = merge_data$population))      
pop<- map_mur_pop + ggtitle("Area of United States") 
pop

NYC <- geocode(source = "dsk", "nyc, new york,ny")
NYC

#Step D: Zoom the map
#â¢Repeat step C, but only show the states in the north east
#Hint: get the lat and lon of new york city
#Hint: set the xlim and ylim to NYC +/- 10

zoom <- ggplot(merge_data, aes(map_id = statename))
zoom <- zoom_map + geom_map(map = us, aes(fill = merge_data$Murder)) 
zoom <- zoom_map + expand_limits(x  = us$long, y = us$lat ) + coord_fixed(xlim = c(NYC$lon -10,NYC$lon +10), ylim = c(NYC$lat +10,NYC$lat -10)) 
zoom <- zoom_map + geom_point( x = merge_data$x, y = merge_data$y, aes(size = merge_data$population))      
zoom <- zoom_map + ggtitle(" NYC Murder Rate")
zoom



