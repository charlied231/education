setwd("C:/users/documents") #ubicación del archivo csv con los datos

datos <- read.csv("base_covid_acondicionados.csv", header = TRUE, nrows=566600)

summary(datos)
colnames(datos)

#Contagiados

#filtrar base solo para los contagiados
datos_contagiados <- datos[datos$RESULTADO == "Positivo SARS-CoV-2",]

#Contagio por genero
Nh <- nrow(datos_contagiados[datos_contagiados$SEXO == "HOMBRE",])
Nm <- nrow(datos_contagiados[datos_contagiados$SEXO == "MUJER",])

Vc <- c(Nm,Nh)
labels <- c("Mujeres", "Hombres")
piepercent<- round(100*Vc/sum(Vc), 1)
pie(Vc,labels = piepercent, radius = 1, main = "Contagios por genero", col = palette("Tableau 10"))
legend("topright", labels, cex = 1,fill = palette("Tableau 10"))

#Contagio por edad
Mu <- mean(datos_contagiados$EDAD)
De <- sqrt(var(datos_contagiados$EDAD))

rango <- c((Mu-(3*De)),(Mu+(3*De)))
max_value = ceiling(rango[2])

hist(datos_contagiados$EDAD, main = "Contagios por edad", xlab = "Edad", ylab = "Numero de casos",col = "blue",border = "navy", xlim = c(0,max_value),breaks = 50, freq=FALSE)
# edades <- seq(0, max_value, 1)
# Ve <- vector("numeric",length = max_value)
# 
# for(i in 1:max_value){
#   Ve[i] <- nrow(datos_contagiados[(datos_contagiados$EDAD >= edades[i]) & (datos_contagiados$EDAD < edades[i+1]),]) 
# }
# 
# barplot(Ve)




#Fallecidos

#filtrar base solo para los contagiados
datos_fallecidos <- datos[((datos$RESULTADO == "Positivo SARS-CoV-2") & (datos$FECHA_DEF != "9999-99-99")),]

#Fallecidos por genero
Nhf <- nrow(datos_fallecidos[datos_fallecidos$SEXO == "HOMBRE",])
Nmf <- nrow(datos_fallecidos[datos_fallecidos$SEXO == "MUJER",])

Vf <- c(Nmf,Nhf)
barplot(Vf,main = "Fallecidos por genero",names.arg=labels,col = palette())
piepercent<- round(100*Vf/sum(Vf), 1)
pie(Vf,labels = piepercent, radius = 1, main = "Fallecidos por genero", col = palette("Tableau 10"))
legend("topright", labels, cex = 1,fill = palette("Tableau 10"))

#Fallecidos por edad
Mu <- mean(datos_fallecidos$EDAD)
De <- sqrt(var(datos_fallecidos$EDAD))

rango <- c((Mu-(3*De)),(Mu+(3*De)))
max_value = ceiling(rango[2])

hist((datos_fallecidos$EDAD), main = "Fallecidos por edad", xlab = "Edad", ylab = "Numero de muertes",col = "blue",border = "navy", xlim = c(0,max_value), breaks = 50,freq=FALSE)
y_value <- hist((datos_fallecidos$EDAD), main = "Fallecidos por edad", xlab = "Edad", ylab = "Numero de muertes",col = "blue",border = "navy", xlim = c(0,max_value), breaks = 50,freq=FALSE)$count

x <- seq(0,100,1)
y <- dnorm(x,mean = Mu, sd = De)
plot(x,y, main= "Distibución normal (Mu = 60.99, De = 14.17) - Modelo matemático con los datos")

#Fallecidos (dias desde contagio)
Mu <- mean(datos_fallecidos$DIAS.SINTOMAS.A.DEF)
De <- sqrt(var(datos_fallecidos$DIAS.SINTOMAS.A.DEF))

rango <- c((Mu-(3*De)),(Mu+(3*De)))
max_value = ceiling(rango[2])
#cat("media gamma",mean((datos_fallecidos$DIAS.SINTOMAS.A.DEF)))
#cat("varianza gamma",var((datos_fallecidos$DIAS.SINTOMAS.A.DEF)))

hist((datos_fallecidos$DIAS.SINTOMAS.A.DEF), main = "Dias desde los 1eros sintomas a la defunción", xlab = "Dias", ylab = "Frecuencia",col = "blue",border = "navy", xlim = c(0,max_value),breaks = 70,freq=FALSE)

x <- seq(0,35,35/100)
y <- dgamma(x, shape = 2.42, scale=4.74, log = FALSE)
plot(x,y,  main = "Distribución gamma (alpha = 2.42, betha = 4.74) - Modelo matemático con los datos")

#Porcentaje de fallecidos
Nf <- nrow(datos_fallecidos)
Nc <- nrow(datos_contagiados) - Nf

Vcf <- c(Nc,Nf)
piepercent<- round(100*Vcf/sum(Vcf), 1)
pie(Vcf,labels = piepercent, radius = 1, main = "Contagiados/fallecidos", col=palette("Tableau 10"))
legend("topright", c("Contagiados","Fallecidos"), cex = 1, fill = palette("Tableau 10"))

#Porcentaje de fallecidos c/diabetes
Nfd <- nrow(datos_fallecidos[datos_fallecidos$DIABETES == "SI",])
Ncd <- nrow(datos_contagiados[datos_contagiados$DIABETES == "SI",]) - Nfd

Vcfd <- c(Ncd,Nfd)

piepercent<- round(100*Vcfd/sum(Vcfd), 1)
pie(Vcfd,labels = piepercent, radius = 1, main = "Contagiados/fallecidos (Con diabetes)", col=palette("Tableau 10"))
legend("topright", c("Contagiados","Fallecidos"), cex = 1, fill = palette("Tableau 10"))

#Porcentaje de fallecidos s/diabetes
Nfsd <- nrow(datos_fallecidos[datos_fallecidos$DIABETES == "NO",])
Ncsd <- nrow(datos_contagiados[datos_contagiados$DIABETES == "NO",]) - Nfsd

Vcfsd <- c(Ncsd,Nfsd)
piepercent<- round(100*Vcfsd/sum(Vcfsd), 1)
pie(Vcfsd,labels = piepercent, radius = 1, main = "Contagiados/fallecidos (Sin diabetes)", col=palette("Tableau 10"))
legend("topright", c("Contagiados","Fallecidos"), cex = 1, fill = palette("Tableau 10"))

#Fallecidos con/sin diabetes
Ntd <- Nfd + Nfsd
barplot(c(Nfd/Ntd,Nfsd/Ntd), main = "Fallecidos (Con/sin diabetes)", col=palette("Tableau 10"))
legend("bottom", c("0.37","0.63"), cex = 1, fill = palette("Tableau 10"))



