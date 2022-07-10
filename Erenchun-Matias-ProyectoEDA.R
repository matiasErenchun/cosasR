#install.packages("FactoMineR")
library("FactoMineR")

library(ggplot2)

#install.packages("factoextra")
library("factoextra")


url<-"https://drive.google.com/file/d/1G-ggtM7IRk013dj2-afEzegNczK1tEyj/view"

#install.packages('gsheet')

library(gsheet)

data<-gsheet2tbl(url)
View(data)
data<-data[-1,]
View(data)
nameColums<-as.character(data[1, ])
View(nameColums)
head(data,n=10)
names(data)<-nameColums
View(data)
dataF<-data[-1,]
head(dataF,n=10)
dataM<-dataF[-c(1),]
head(dataM,n=10)
# <- PCA(data,  graph = FALSE)



