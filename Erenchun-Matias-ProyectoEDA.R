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

#Preprocesar datos

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

#---------------------------------------------------------------------

#2 calculo de pca

pcAmANITO<- PCA(dataF,  graph = FALSE)#aplicamos PCA
fviz_screeplot(pcAmANITO, addlabels = TRUE, ylim = c(0, 50))
get_eig(pcAmANITO)
#aqui podemos ver que teniendo desde la dimencion 1 a la 6 ya tenemos ams del 85%
#de la informacion, pudiendod escartar la sotras dimenciones

fviz_pca_var(pcAmANITO, col.var="contrib",
             gradient.cols = c("#00AFBB", "#E7B800", "#FC4E07"),
             repel = TRUE # Avoid text overlapping
)

fviz_pca_ind(pcAmANITO, col.ind = "cos2", 
             gradient.cols = c("#00AFBB", "#E7B800", "#FC4E07"),
             repel = TRUE # mueve los elementos si estan superpuestos
)

#---------------------------------------------------------------------

#3 aplicamos kmeans con distintos valores
#para usar k-means https://stackoverflow.com/questions/61151538/compute-k-means-after-pca
km <- kmeans(pcAmANITO$ind$coord, 4, nstart = 14)
fviz_cluster(km, data = pcAmANITO$ind$coord,
             palette = c("#00AFBB","#2E9FDF", "#E7B800", "#FC4E07"),
             ggtheme = theme_minimal(),
             main = "Partitioning Clustering Plot"
)

km2<-kmeans(pcAmANITO$ind$coord, centers = 3, nstart = 14)
fviz_cluster(km2, data = pcAmANITO$ind$coord,
             palette = c("#00AFBB","#2E9FDF", "#E7B800", "#FC4E07"),
             ggtheme = theme_minimal(),
             main = "Partitioning Clustering Plot"
)

km3<-kmeans(pcAmANITO$ind$coord, centers = 2, nstart = 14)
fviz_cluster(km3, data = pcAmANITO$ind$coord,
             palette = c("#00AFBB","#2E9FDF", "#E7B800", "#FC4E07"),
             ggtheme = theme_minimal(),
             main = "Partitioning Clustering Plot"
)

#-------------------------------------------------------------------

#4 buscar el numero correcto de clusters
#ahora buscamos en numero ideal de cluster, spoiler el metodo de la libreria no funciono.
fviz_nbclust(pcAmANITO$ind$coord, kmeans, method = "gap_stat")
fviz_nbclust(dataF, kmeans, method = "gap_stat")

#buscando en internet encontre este metodo.
miCluster<-NbClust(dataF, diss=NULL, distance = "euclidean", min.nc=2, max.nc=10, method = "kmeans", index = "kl")
head(miCluster)
bClusters <-miCluster$Best.nc
head(bClusters)
#obtenemos que el correcto de cluster es 4

#-------------------------------------------------------------------

#5 agrupamiento jerarquico 
res.hc <- dataF%>%
  scale() %>%
  eclust("hclust", k = 4, graph = FALSE)

fviz_dend(res.hc, palette = "jco",
          rect = TRUE, show_labels = TRUE)
#-------------------------------------------------------------------

#6 conclusiones

