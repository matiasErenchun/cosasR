#install.packages("FactoMineR")
library("FactoMineR")

library(ggplot2)

#install.packages("factoextra")
library("factoextra")

#install.packages('gsheet')

library(gsheet)
library(tidyverse)

#install.packages("NbClust")
library(NbClust)

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
get_eig(pcAmANITO)
fviz_screeplot(pcAmANITO, addlabels = TRUE, ylim = c(0, 50))
var <- get_pca_var(pcAmANITO)
head(var$coord)
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
km<-kmeans(var$coord, centers = 4, nstart = 14)
plot(pcAmANITO$ind$coord[,1:2],col=factor(km$cluster))

km2<-kmeans(pcAmANITO$ind$coord, centers = 3, nstart = 14)
plot(pcAmANITO$ind$coord[,1:2],col=factor(km2$cluster))
km2<-kmeans(pcAmANITO$ind$coord, centers = 5, nstart = 14)
plot(pcAmANITO$ind$coord[,1:2],col=factor(km2$cluster))
summary(km)
fviz_nbclust(pcAmANITO$ind$coord, kmeans, method = "gap_stat")
fviz_nbclust(var$coord, kmeans, method = "gap_stat")

fviz_nbclust(dataF, kmeans, method = "gap_stat")

miCluster<-NbClust(dataF, diss=NULL, distance = "euclidean", min.nc=2, max.nc=10, method = "kmeans", index = "kl") 
bClusters <- length(unique(miCluster$Best.partition))
bClusters
summary(bClusters)


fviz_nbclust(var$coord, kmeans, method = "gap_stat")


#agrupamiento jerarquico 
res.hc <- dataF%>%
  scale() %>%
  eclust("hclust", k = 3, graph = FALSE)

fviz_dend(res.hc, palette = "jco",
          rect = TRUE, show_labels = TRUE)
fviz_silhouette(res.hc)

#-----------------------------------------
res.hc <- dataF%>%
  scale() %>%
  eclust("hclust", k = 4, graph = FALSE)

fviz_dend(res.hc, palette = "jco",
          rect = TRUE, show_labels = TRUE)
fviz_silhouette(res.hc)
#---------------------------------------
res.hc <- dataF%>%
  scale() %>%
  eclust("hclust", k = 2, graph = FALSE)

fviz_dend(res.hc, palette = "jco",
          rect = TRUE, show_labels = TRUE)
fviz_silhouette(res.hc)


km.res <- kmeans(pcAmANITO$ind$coord, 3, nstart = 14)

# 3. Visualize
library("factoextra")
fviz_cluster(km.res, data = pcAmANITO$ind$coord,
             palette = c("#00AFBB","#2E9FDF", "#E7B800", "#FC4E07"),
             ggtheme = theme_minimal(),
             main = "Partitioning Clustering Plot"
)
