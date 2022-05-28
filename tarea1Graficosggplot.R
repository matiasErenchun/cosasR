#head(mtcars,4)
#mpg cyl disp  hp drat    wt  qsec vs am gear carb
#Mazda RX4      21.0   6  160 110 3.90 2.620 16.46  0  1    4    4
#Mazda RX4 Wag  21.0   6  160 110 3.90 2.875 17.02  0  1    4    4
#Datsun 710     22.8   4  108  93 3.85 2.320 18.61  1  1    4    1
#Hornet 4 Drive 21.4   6  258 110 3.08 3.215 19.44  1  0    3    1
dim(mtcars)
library(ggplot2)
library(dplyr)
library(RColorBrewer)

#Ejercicio 1
ggplot(mtcars, aes(factor(am), qsec)) +
  geom_boxplot()

#ejercicio 2

container<-mtcars%>%count(carb)
View(container)
ggplot(container, aes(x=carb,y=n)) +
  geom_col( colour = "black")

#ejercicio 3
contenedor<-mtcars%>%count(cyl, gear)
View(contenedor)
ggplot(contenedor, aes(x=cyl, y=n, fill=factor(gear))) +
  geom_col( colour = "black") +
  scale_fill_brewer(palette = "Pastel1")

#ejercicio 4

ggplot(mtcars, aes(x = wt, y = mpg)) +
  geom_point(alpha = 0.3, color = "blue")
