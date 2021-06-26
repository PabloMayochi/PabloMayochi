inmuebles_caba <- read.csv("precio-venta-deptos.csv")

summary(inmuebles_caba)

head(inmuebles_caba)

inmuebles_caba <- janitor::clean_names(inmuebles_caba)

library(dplyr)

inmuebles_caba <- inmuebles_caba %>% rename(año = a_a_o)

inmuebles_caba <- filter(inmuebles_caba, !is.na(precio_prom))

promedio_año <- inmuebles_caba %>% 
  group_by(año) %>%
  summarise(promedio_por_año = mean(precio_prom), n = n())
promedio_año

promedio_comuna <- inmuebles_caba %>% 
  group_by(comuna) %>%
  summarise(promedio_por_comuna = mean(precio_prom), n = n())
promedio_comuna

estado_inmuebles <- inmuebles_caba %>% 
  group_by(estado) %>% 
  summarise(n=n())
estado_inmuebles
