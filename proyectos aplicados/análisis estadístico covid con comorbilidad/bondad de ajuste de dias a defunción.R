max(datos_fallecidos$DIAS.SINTOMAS.A.DEF)
min(datos_fallecidos$DIAS.SINTOMAS.A.DEF)
k=103
FO<-vector('numeric',length = k)
for(m in 0:102){
  FO[m+1]<-sum(datos_fallecidos$DIAS.SINTOMAS.A.DEF==m)
}

m1<-mean(datos_fallecidos$DIAS.SINTOMAS.A.DEF)
v1<- var(datos_fallecidos$DIAS.SINTOMAS.A.DEF)

a <- (m1/sqrt(v1))^2
B <- sqrt(v1/a)

x<-seq(0,120,length=k)
y<-x*0
y[1]<-pgamma(x[1],a,scale = B)-pgamma(-1,a,scale = B)
for (m in 2:k){
  y[m]<-pgamma(x[m],a,scale = B)-pgamma(x[m-1],a,scale = B)
}
FE<-y*length(datos_fallecidos$DIAS.SINTOMAS.A.DEF)
ii=1
A<-0
while(FE[ii]<5){
  A=A+FE[ii]
  ii=ii+1
}

A=A+FE[ii]


jj=1
Af<-0
while(FE[k+1-jj]<5){
  Af=Af+FE[k+1-jj]
  jj=jj+1
}

Af=Af+FE[k+1-jj]


FE2<-vector("numeric", length=(k-ii-jj+2))
FE2[1]<-A

for(m in (ii+1):(k-jj)){
  FE2[m+1-ii]<-FE[m]
}

FE2[k-ii-jj+2]<-Af

barplot(FE2)

#########################################

FO2<-vector("numeric", length=(k-ii-jj+2))
FO2[1]<-sum(FO[1:ii])

for(m in (ii+1):(k-jj)){
  FO2[m+1-ii]<-FO[m]
}

FO2[k-ii-jj+2]<-sum(FO[(k-jj+1):k])

barplot(FO2)
x2<-sum((FE2-FO2)^2/FE2)
x2
gradoslibertad<-length(FE2)-2-1
valorcritico<-qchisq(0.95,gradoslibertad)
valorcritico

