install.packages("dplyr")
library(dplyr)
iris%>%head(n=4)
#---------------------ejercicio1---------------------#
iris3PrimerasColumnas<-iris%>%select(Sepal.Length, Sepal.Width, Petal.Length)
#View(iris3PrimerasColumnas) esto es para ver en forma tabla tipo excel

#---------------------ejercicio2---------------------#
irisSinPetalwidth<-iris%>%select(-Petal.Width)
#View(irisSinPetalwidth)

#---------------------ejercicio3---------------------#
irisOnlyStartWithP<-iris%>%select(starts_with("P"))
#View(irisOnlyStartWithP)

#---------------------ejercicio4---------------------#
irisFiltrado<-iris%>%filter(Sepal.Length>=4.6,Petal.Width>=0.5)
#View(irisFiltrado)

#---------------------ejercicio5---------------------#
irisSelectSepalWandL<-iris%>%select(Sepal.Width,Sepal.Length)
#View(irisSelectSepalWandL)

#---------------------ejercicio6---------------------#
irisArrangeWithSepalW<-iris%>%arrange(Sepal.Width)
#View(irisArrangeWithSepalW)

#---------------------ejercicio7---------------------#
irisSelect<-iris%>%select(Sepal.Length,Sepal.Width,Petal.Length)%>%arrange(Sepal.Length,Sepal.Width)
#View(irisSelect)

#---------------------ejercicio8---------------------#
irismutate<-iris%>%mutate(proportion=Sepal.Length/Sepal.Width)
#View(irismutate)

#---------------------ejercicio9---------------------#
avg_slength<-iris%>%summarise(avg_slength=median(Sepal.Length))
#View(avg_slength)

#---------------------ejercicio10---------------------#
