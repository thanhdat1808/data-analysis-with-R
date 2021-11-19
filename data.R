library(dplyr)
library(ggplot2)
library(readxl)
d <- read.csv("D:/C/ChuyenDe5-R/Dataset/weatherHistory.csv")
data<-d
str(data)
names(d)

colnames(data) <- c("date", "summany", "type", "temp", "atemp", "humidity", "wind", "windb", "vision", "loud", "pressure", "daily")

View(data)

tablename = c("temp", "atemp", "humidity", "wind", "vision", "pressure")
#danh sách biến phụ thuộc
response_variable_list = c("wind","vision","windb","humidity")
#danh sách biến độc lập
predictor_variable_list = c("temp","humidity")

model2 = lm(data = data, temp ~wind)
summary(lm(data = data, temp ~wind))
#Y=a+bX+e
#in Estimate Intercept is a and Windspeed is b, 
#-> if Windspeed increasing 1 unit then WindBD is also increasing 1.3130 unit 

#Draw Model 
plot(data = data , wind~temp)+abline(lm(data=data,wind~temp))

ggplot(data = data,
       mapping = aes(x = gsub(),y = humidity)       
)+ geom_point()
View(data[data$temp,data$atemp])
View(filter(d,d$Summary == 'Overcast' & d$Precip.Type == 'rain' & d$Temperature..C.>= 12))
