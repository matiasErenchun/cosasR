#install.packages("FactoMineR")
library("FactoMineR")

library(ggplot2)

#install.packages("factoextra")
library("factoextra")

#install.packages('gsheet')

library(gsheet)

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



