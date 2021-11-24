library(dplyr)
library(ggplot2)
library(readxl)
d <- read.csv("D:/C/ChuyenDe5-R/Dataset/weatherHistory.csv")
data<-d
str(data)
names(d)
d <- d[,-5]
d <- d[,-9]

colnames(d)<- c("Date","Summary", "Precip.Type","Temperature","Humidity","Wind.speed","Wind.Bearing.Degree","Visibility","Pressure","Daily.Summary")
view(d)

View(data)
nameDiagram =c("Temperature", "Humidity", "Wind Speed", "Visibility", "Pressure millibars")
tablename = c("Temperature", "Humidity", "Wind.speed", "Visibility", "Pressure")
#danh sach bien phu thuoc
response_variable_list = c("Wind.speed","Visibility","Wind.Bearing","Humidity","Temperature")
#danh sach bien doc lap
predictor_variable_list = c("Temperature","Humidity")

