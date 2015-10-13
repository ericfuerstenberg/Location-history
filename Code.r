library(RJSONIO)
library(ggmap)

#Loading in JSON file with location info
history<-fromJSON(file.choose())

locations<-history[['locations']]
head(locations)

#Pulling out latitude and longitude in vectors from the master list
locations[[1]][[2]] #this returns the lattitude for the first location reading
locations[[1]][[3]] #this returns longitude 

lats<-sapply(locations, function(x) x[[2]])
longs<-sapply(locations, function(x) x[[3]])

#binding latitude and longitude together
lat<-lats/10000000
lon<-longs/10000000
coords<-data.frame(lat,lon)

#Larger view
myMap <- get_map(location=c(lon = -119.8, lat = 34.45), source = "stamen", maptype = "watercolor", crop = FALSE, zoom = 12)
#SB Downtown
zoomMap<-get_map(location=c(lon = -119.71, lat = 34.42), source = "osm", maptype = "hybrid", crop = FALSE, zoom = 14)


#possible map types - toner, osm, stamen

par(mfrow=c(2,1))

#Plotting map
ggmap(myMap)
ggmap(zoomMap)

qmplot(lon,lat,data=coords)

#Map with xy axes
ggmap(myMap) +
	geom_point(aes(x = lon, y = lat), data = coords,
	alpha = .08, color="darkred", size = 2)
	
#Map without axes
ggmap(myMap,extent="device") +
	geom_point(aes(x = lon, y = lat), data = coords,
	alpha = .08, color="darkred", size = 2)

ggmap(zoomMap,extent="device") +
	geom_point(aes(x = lon, y = lat), data = coords,
	alpha = .08, color="darkred", size = 2) 
 
 
tiff(filename="LocationMap.tiff",width=8,height=7,,units="in",res=800)
dev.off()
 
lats2<-c(34.67,35.34,34.28)
longs2<-c(-118.8,-118.72,-119.91)
coords2<-data.frame(lats2,longs2)


lat<-lats/10000000
lon<-longs/10000000
coords<-data.frame(lat,lon)


myMap <- get_map(location=c(lon = -119.8, lat = 34.45), source = "stamen", maptype = "watercolor", crop = FALSE)



#Final map

ggmap(myMap) +
	geom_point(aes(x = lon, y = lat), data = coords,
	alpha = .08, color="darkred", size =2)
 
 head(coords)
 
 write.csv(coords,file="coords.csv")
 
 
search<-fromJSON(file.choose())