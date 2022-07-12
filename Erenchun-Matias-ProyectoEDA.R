#install.packages("FactoMineR")
library("FactoMineR")

library(ggplot2)

#install.packages("factoextra")
library("factoextra")

#install.packages('gsheet')

library(gsheet)
library(tidyverse)

url<-"https://drive.google.com/file/d/1G-ggtM7IRk013dj2-afEzegNczK1tEyj/view"

data<-gsheet2tbl(url)
#View(data)
#------------------------------------------Preprocesar los datos para usar PCA----------------------------------------
#los datos horiginales tienen doble cabecera ademas que son leidos como chr tenemso que,
#corregir esto para poder usar PCA
data<-data[-1,]#eliminamos la primera fila donde estan categorias como Social distancing
#View(data)
nameColums<-as.character(data[1, ])#obtenemos los nombres d elas columnas para posterios mente cambiarlos
names(data)<-nameColums#cambiamos el nombre d elas columnas por los que ya tenemos (linea anterior)
#View(data)
dataF<-data[-1,]#eliminamos los nombre de los datos(ya estan como los nombres d elas columnas)
paises<-as.vector(dataF$Country)#obtenemos los nombres de los paises para ponerlos como nombre de las filas
dataF<-as.data.frame(dataF)
dataF<-apply(dataF[,-1],2, as.integer)#pasamos los valores de chr a int en todas las columnas
rownames(dataF)<-paises#agregamos los nombres de las filas
summary(dataF)
View(dataF)
pcAmANITO<- PCA(dataF,  graph = FALSE)#aplicamos PCA
View(pcAmANITO)
get_eig(pcAmANITO)
fviz_screeplot(pcAmANITO, addlabels = TRUE, ylim = c(0, 50))
fviz_pca_var(pcAmANITO, col.var="contrib",
             gradient.cols = c("#00AFBB", "#E7B800", "#FC4E07"),
             repel = TRUE # Avoid text overlapping
)
fviz_pca_ind(pcAmANITO, col.ind = "cos2", 
             gradient.cols = c("#00AFBB", "#E7B800", "#FC4E07"),
             repel = TRUE # Avoid text overlapping (slow if many points)
)
summary(pcAmANITO)
#para usar k-means https://stackoverflow.com/questions/61151538/compute-k-means-after-pca
km<-kmeans(pcAmANITO$ind$coord, centers = 4, nstart = 14)
#plot(pcAmANITO$ind$coord[,1:2],col=factor(km$cluster))
km2<-kmeans(pcAmANITO$ind$coord, centers = 3, nstart = 14)
#plot(pcAmANITO$ind$coord[,1:2],col=factor(km2$cluster))
km2<-kmeans(pcAmANITO$ind$coord, centers = 5, nstart = 14)
plot(pcAmANITO$ind$coord[,1:2],col=factor(km2$cluster))
summary(km)
fviz_nbclust(pcAmANITO$ind$coord, kmeans, method = "gap_stat")



