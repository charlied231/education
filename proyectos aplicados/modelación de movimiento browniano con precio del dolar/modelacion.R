setwd("C:/Users/dinoc/Downloads/")

datos <- read.csv("datos_dolar.csv", header = FALSE, nrows=2740)

#summary(datos)
#colnames(datos)
#plot(datos$V2)

dt <- 0.05
k <- length(datos$V2)

fs <-vector("numeric", length = k-1)

for (i in 2:k)
{
  fs[i-1] = (datos$V2[i] - datos$V2[i-1])/datos$V2[i-1] 
}

m <- mean (fs)/dt*1
s2 <- var(fs)/dt*1

k <-2740

S <- vector("numeric", length = k)
S[1] = datos$V2[1]

for(i in 2:k)
{
  dB=rnorm(1,0,sqrt(dt))
  dS=S[i-1]*(m*dt-sqrt(s2)*dB)
  S[i]=S[i-1]+dS
}

plot(datos$V2,type="l",xlab="Tiempo (dias)",ylab="Valor (MXN)", ylim=c(8,30),xaxt="none")
axis(1, seq(0,2740,365))
title("Valor del dolar diario (2010-2020)")
lines(datos$V2,col="black")
lines(S,col="red")
legend(1, 30, legend=c("Valor real", "Valor generado con modelo browniano"),
       col=c("black", "red"), lty=1:1, cex=.8)

plot(fs,type="l",xlab="Tiempo (dias)",ylab="Delta de S")
title("Función de cambio del precio diario")

