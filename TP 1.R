inmuebles_caba <- read.csv("precio-venta-deptos.csv")

#Vemos un resumen de nuestros datos

summary(inmuebles_caba)

head(inmuebles_caba)

#Limpiamos los datos con funciones de Janitor

inmuebles_caba <- janitor::clean_names(inmuebles_caba)

library(dplyr)

inmuebles_caba <- inmuebles_caba %>% rename(a?o = a_a_o)

#Eliminamos los valores "missing" o "NA"

inmuebles_caba <- filter(inmuebles_caba, !is.na(precio_prom))

#Creamos una tabla de Promedio Año para ver los datos resumidos

promedio_año <- inmuebles_caba %>% 
  group_by(año) %>%
  summarise(promedio_por_año = mean(precio_prom), n = n())
promedio_año

#Como podemos observar, del 2014 al 2019 encontramos un aumento sostenido en los precios de venta de departamentos

promedio_comuna <- inmuebles_caba %>% 
  group_by(comuna) %>%
  summarise(promedio_por_comuna = mean(precio_prom), n = n()) %>% 
  arrange(promedio_por_comuna)
promedio_comuna

#Respecto a como se ve impactado por Comuna, las Comunas más "caras" son la Comuna 2, Comuna 14, y Comuna 13, mientras las más "baratas" son la Comuna 8, Comuna 4, y Comuna 9

estado_inmuebles <- inmuebles_caba %>% 
  group_by(estado) %>% 
  summarise(n=n())
estado_inmuebles

#Por último, vemos que en nuestro dataset, tenemos 947 inmuebles "A Estrenar" y 2138 inmuebles usados.