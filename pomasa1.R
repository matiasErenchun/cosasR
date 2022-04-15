#libreria para poder leer documentos
library(readxl)
pomasa1 <- read_excel("D:/pomasa1.xlsx", 
                      sheet = "Hoja1")#cambiar la url por la url del archivo a leer.
#<--------------------------------------->
#en esta parte lo que hacmeos es tomar la columna resultados para 
# separarla para agregarla como 3 columnas diferentes una para cada medicion
View(pomasa1)
resultados = pomasa1$Results
i<-1
largo = length(resultados)
medicion1<-c()
medicion2<-c()
medicion3<-c()
counter=1
columnaAnterior=1
resultados
#como sabemos cada 3 resultados corresponde a un parametro, por ende en este ciclo for tomamos cada medicion
# asignanadolas al vector correspondiente
for (variable in resultados) 
{
  if(counter==1)
  {
    medicion1<-c(medicion1,variable)
  }
  if (counter==2)
  {
    medicion2<-c(medicion2,variable)
  
  }
  if(counter==3)
  {
    medicion3<-c(medicion3,variable)
  
    counter<-0
  }
  counter<-counter+1
}
medicion1
medicion2
medicion3
pomasa1$Results<-NULL#eliminamos results 
head(pomasa1)
nuevoData<-pomasa1[!is.na(pomasa1$Properties),]#eliminamos todas las columnas que son nan
nuevoData$medicion1<-medicion1
nuevoData$medicion2<-medicion2
nuevoData$medicion3<-medicion3
#str(nuevoData) esto e spara ver lso
#tipos de datos y un resumen d ela informaciond e la tabla 
#View(nuevoData)
#https://es.stackoverflow.com/questions/194515/c%c3%b3mo-promedio-variables-por-fila
#https://www.rdocumentation.org/packages/base/versions/3.6.2/topics/apply
#la funcion apply permite ejecutar una determinada operacion/funcion en un rano de columnas de una tabla fila por fila
#esta tiene como entrada el delimitador o rango entre las cuales se ejecutara la funcion
#el salto(con un valor 1 si se quiere ir fila por fila )
#la funcion u operacion a ejecutar, adicional mente se permite ingresar  eleemntos propios d ela funcion a ejecutar
nuevoData$mediaMediciones<-apply(nuevoData[,c(4:6)],1,mean, na.rm=FALSE)
nuevoData$desviacionEstandar<-apply(nuevoData[,c(4:6)],1,sd, na.rm=FALSE)
View(nuevoData)
#https://tutorials.methodsconsultants.com/posts/reading-and-writing-excel-files-with-r-using-readxl-and-writexl/
#para escribir en R
install.packages("writexl")
library(writexl)
write_xlsx(nuevoData, "pomasa1.xlsx", sheetName = "hoja1",row.names=FALSE)
install.packages("xlsx")
library(xlsx)
write.xlsx(nuevoData, file="nuevoData.xlsx", sheetName="hoja1", col.names=TRUE ,row.names=TRUE, append=TRUE)

#<------------------hoja2-------------->
#
pomasa2 <- read_excel("D:/pomasa1.xlsx", 
                      sheet = "Hoja2")
View(pomasa2)