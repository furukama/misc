# Twitter Germany will be based in Berlin – Taking a look at the
# numbers
#
# Blogpost:
# http://beautifuldata.net/2012/03/twitter-germany-will-be-based-in-berlin-taking-a-look-at-the-numbers/

library(ggplot2)

# Reading in the data: The data set is pre-processed by a Python
# script. The format is pretty simple. This is how it looks like:
#
# City, Followers, Following, Statuses
# Berlin, 2026, 947, 1272, 3460725
# Aachen, 346, 94, 24582, 258664
# ...

data <- read.csv("location.csv")

# Chart 1: Twitter users by city
ggplot(data,aes(City))+geom_histogram()+opts(axis.text.x=theme_text(angle=90, hjust=1),title="Twitter users by city")+ylab("Twitter users")

# Chart 2: Average number of followers by city
ggplot(data,aes(factor(City),Followers))+geom_boxplot()+opts(axis.text.x=theme_text(angle=90, hjust=1),title="Average number of followers by city")+ylab("Followers")

# Chart 3: Average number of followers by city (outliers removed)
ggplot(data,aes(factor(City),Followers))+geom_boxplot(outlier.shape=NA)+opts(axis.text.x=theme_text(angle=90, hjust=1),title="Average number of followers by city")+scale_y_continuous(limits = quantile(data$Followers, c(0.1, 0.9)))+ylab("Followers")

# Chart 4: Average number of friends by city
ggplot(data,aes(factor(City),Following))+geom_boxplot()+opts(axis.text.x=theme_text(angle=90, hjust=1),title="Average number of friends by city")+ylab("Friends")+xlab("City")

# Chart 5: Average number of friends by city (outliers removed)
ggplot(data,aes(factor(City),Following))+geom_boxplot(outlier.shape=NA)+opts(axis.text.x=theme_text(angle=90, hjust=1),title="Average number of friends by city")+scale_y_continuous(limits = quantile(data$Following, c(0.1, 0.9)))+ylab("Friends")+xlab("City")

# Chart 6: Followers x Friends
ggplot(data,aes(Followers,Following))+geom_point()+opts(axis.text.x=theme_text(angle=90, hjust=1),title="Followers x Friends")+ylab("Friends")+geom_abline(method="lm", colour="red")

# Chart 7: Followers x Friends (Zoom)
ggplot(data,aes(Followers,Following))+geom_point()+opts(axis.text.x=theme_text(angle=90, hjust=1),title="Followers x Friends")+ylab("Friends")+geom_abline(method="lm", colour="red")+scale_x_continuous(limits = quantile(data$Followers, c(0, 0.99)))+scale_y_continuous(limits = quantile(data$Following, c(0, 0.99)))

# Chart 8: Twitter users with 1900-2100 friends by city
bots <- data[data$Following>1900&data$Following<2100,]
ggplot(bots,aes(City))+geom_histogram()+opts(axis.text.x=theme_text(angle=90, hjust=1),title="Twitter users with 1900-2100 friends by city")+ylab("Twitter users")

# Chart 9: Average number of statuses by city
ggplot(data,aes(factor(City),Statuses))+geom_boxplot()+opts(axis.text.x=theme_text(angle=90, hjust=1),title="Average number of statuses by city")+ylab("Statuses")+xlab("City")

# Chart 10: Average number of statuses by city (outliers removed)
ggplot(data,aes(factor(City),Statuses))+geom_boxplot(outlier.shape=NA)+opts(axis.text.x=theme_text(angle=90, hjust=1),title="Average number of statuses by city")+scale_y_continuous(limits = quantile(data$Following, c(0.1, 0.9)))+ylab("Statuses")+xlab("City")
