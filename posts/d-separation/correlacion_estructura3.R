library(dagitty)
setwd("C:/Users/Octavio Maqueo/Dropbox/01 Mis documentos/PROYECTOS/Robert")
g <-dagitty("dag {humedad->plagas->productividad
           plagas [exposure]
           productividad[outcome]}")
# (opcional) coordenadas para que se vea bonito al graficar
coordinates(g) <- list(
  x = c(humedad = 0, plagas = 1, productividad = 2),
  y = c(humedad = 0, plagas = 0, productividad = 0)
)
plot(g)
adjustmentSets(g, exposure = "plagas", outcome = "productividad")
# Independencias testables que implica el DAG:
impliedConditionalIndependencies(g)
# -> humedad ⟂⟂ productividad | Ppagas
set.seed(1)
n <- 5000
humedad <- rnorm(n, 0, 1)
plagas <- rbinom(n, 1, 1/(1+exp(-( -1 + 1.5*humedad ))))  # logístico
productividad <- rnorm(n, mean = plagas, sd = 0.5)

cor(humedad, productividad)                 # asociación marginal ≠ 0
cor(humedad[plagas==0], productividad[plagas==0])  # ≈ 0
cor(humedad[plagas==1], productividad[plagas==1])  # ≈ 0

# Regresión: sin Plagas → humedad “predice”; con Plagas → efecto de humedad ≈ 0
summary(lm(productividad ~ humedad))
summary(lm(productividad ~ humedad + plagas))
plot(humedad,productividad)
abline(summary(lm(productividad ~ humedad)), col = "red", lwd = 2)

#controlando para plagas
round(cor(humedad[plagas==0],productividad[plagas==0]),3)
round(cor(humedad[plagas==1],productividad[plagas==1]),3)
modelo2<-lm(productividad~humedad+plagas)
abline(modelo2, col = "blue",lwd = 2)
df<-data.frame(humedad,plagas,productividad)
print(df)
write.csv(df,file = "cadena.csv",row.names = TRUE)

