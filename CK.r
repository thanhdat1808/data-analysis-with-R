install.packages("DMwR", lib ="C:/Program Files/R/R-4.1.1/library" )

#dataset Weather in Szeged in 2016, Szeged is a city of Hungary

library(dplyr)
library(ggplot2)
library(tidyverse)
library(ggthemes)
library(GGally)


weather = read.csv('D:/C/ChuyenDe5-R/Dataset/weatherHistory.csv')
View(weather)
names(weather)
weather <- weather[,-5]
weather <- weather[,-9]

colnames(weather)<- c("Date","Summary", "Precip.Type","Temperature","Humidity","Wind.speed","Wind.Bearing.Degree","Visibility","Pressure","Daily.Summary")

weather <- filter(weather,weather$Precip.Type != 'null')
### Filter
#Avegare of Temperature, Humidity
mean(weather$Temperature,na.rm = 'True')
mean(weather$Humidity,na.rm = 'True')

d1 <- filter(weather,weather$Precip.Type=='rain')
View(d1)


######### MODEL



head(weather, n = 4L)
options(repr.plot.width = 10, repr.plot.height = 10)
pairs(weather,col=weather$Precip.Type)

names(df)

#D??? th??? nhi???t d??? c???a thành ph??? qua t???ng gi???
dat1=weather[order(weather$Date),]
ggplot(data=dat1, aes(x=dat1$Date, y=dat1$Temperature, group = 1)) + geom_line() + xlab("Date") + ylab("Temperature(*C)")

#linear regression model of wind speed and wind bearing degree
model1 = lm(data = weather, Wind.Bearing.Degree~Wind.speed)
summary(model1)
#Y=a+bX+e
#in Estimate Intercept is a and Windspeed is b, 
#-> if Windspeed increasing 1 unit then WindBD is also increasing 1.3130 unit 

#Draw Model 
plot(weather$Wind.Bearing.Degree~weather$Wind.speed)+abline(model1)

confint(model1)


#linear regression model of wind speed and wind bearing degree
model2 = lm(data = weather, Humidity ~ Temperature)
summary(model2)
#Y=a+bX+e
#in Estimate Intercept is a and Windspeed is b, 
#-> if Windspeed increasing 1 unit then WindBD is also increasing 1.3130 unit 

#Draw Model 
plot(weather$Humidity~weather$Temperature)+abline(model2)


model3 = lm(weather$Temperature ~ weather$Precip.Type)
summary(model3)
#R-Squared: value precip.type giai thich 22,73% giao dong ve temperature giua cac moc thoi gian
boxplot(weather$Temperature ~ weather$Precip.Type)
t.test(weather$Temperature ~ weather$Precip.Type)


model4 = lm(weather$Temperature ~ weather$Precip.Type + weather$Humidity)
summary(model4)

#L???i, chua xong
df1 = data.frame(weather$Precip.Type,weather$Temperature)
View(df1)
df1$Rain <- df1$weather.Precip.Type
df1$Rain <- gsub("rain", 1, df1$Rain)
df1$Rain <- gsub("snow", 0, df1$Rain)
df1$Rain <- as.numeric(df1$Rain)
model5 = glm( df1$Rain ~ df1$weather.Temperature, data= df1)
summary(model5)
boxplot(df1$weather.Temperature~ df1$Rain )
