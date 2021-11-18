library(dplyr)
library(ggplot2)
library(readxl)
d <- read.csv("D:/dataset/weatherHistory.csv")
data<-d
str(data)
names(d)
colnames(data) <- c("date", "summany", "type", "temp", "atemp", "h", "wind", "windb", "vision", "loud", "p", "daily")

