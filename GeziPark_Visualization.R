library("maps")
library("mapdata")
library("RJSONIO")
library("RCurl")
library("geosphere")
library("RgoogleMaps")

# Collect Tweets from CouchDB and create dataframe with lat/long
geo <- data.frame()
tweets <- fromJSON(getURL("http://localhost:5984/twitterstream/_design/geo/_view/count_locations?reduce=false"))
for (tweet in tweets$rows) {
    geo <- rbind(geo, data.frame(long=tweet$key[1], lat=tweet$key[2]))
}
numtweets <- length(geo$long)

# Create "Made with ..." tagline
tagline <- paste("Made with Python and R by Benedikt Koehler (@furukama) ", Sys.time(), " - ", numtweets, " geotagged Tweets", sep="")

# Europe Map
png("map_gezi_europe.png", width=1200,height=700)
map(database="worldHires", col="#e2e2e2", fill=TRUE, bg="white", lwd=0.1, plot=TRUE, xlim=c(-25,70), ylim=c(35,71), border="white")
points(x=geo$long,y=geo$lat,col="#c0101025",cex=2, pch=".")
text(5,35.5,labels=tagline, cex=0.8)
title(main="Tweeting about a revolution (Tweets sent from Europe)", cex.main=1.4)
dev.off()

# World Map
png("map_gezi_international.png", width=1200,height=700)
map(database="worldHires", col="#e2e2e2", fill=TRUE, bg="white", lwd=0.1, plot=TRUE, border="white")
for (i in 1:length(geo$long)) {
    inter <- gcIntermediate(c(geo$long[i], geo$lat[i]), c(28.9869156, 41.0386949), n=200, addStartEnd=TRUE)
    lines(inter, col="#c0101025", lwd=0.6)
}
text(-90,-80,labels=tagline, cex=0.8)
title(main="Tweeting about a revolution", cex.main=1.4)
dev.off()

# Turkey Map
png("map_gezi_turkey.png", width=1200,height=700,)
map(database="worldHires", plot=TRUE,xlim=c(20,50),ylim=c(32,45),col="#e2e2e2", fill=TRUE, bg="white", lwd=0.1, border="white")
points(x=geo$long,y=geo$lat,col="#f0202025",cex=4, pch=".")
text(27,32.5,labels=tagline, cex=0.8)
title(main="Tweeting about a revolution (Tweets sent from Turkey)", col.main="black", cex.main=1.4)
dev.off()

# Istanbul Map (uses GoogleMaps)
png("map_gezi_istanbul.png", width=640,height=640)
map <- GetMap(center = c(lat = 41.0386949, lon = 28.9869156), size = c(640, 640), destfile = "istanbul.png", zoom = 12, maptype = c("mobile"), GRAYSCALE = TRUE, SCALE=2)
PlotOnStaticMap(map,geo$lat,geo$long, pch=20:20, cex=1.5, col="#f0202025")
text(0,300,labels="Tweeting about a revolution (Tweets sent from Turkey)", cex=1.4)
text(-60,-290,labels=tagline, cex=0.8)
dev.off()

