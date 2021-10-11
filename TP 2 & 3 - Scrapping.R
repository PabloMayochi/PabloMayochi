library(rvest)
library(tidyverse)

# Ejercicio 2

# Scrapeamos los datos

crpyto_url <- read_html("https://www.tradingview.com/markets/cryptocurrencies/prices-all/")

crypt_table <- html_nodes(crpyto_url, css = "table")

crypt_table <- html_table(crypt_table, fill = T) %>% 
  as.data.frame()

# Quitamos caracteres que estan en las tablas descargadas para quedarnos con los numeros


# ALTERNATIVA PARA LIMPIEZA
 crypt_table %>% 
  as_tibble() %>% 
  janitor::clean_names() %>% 
  mutate(across(.cols = c(var_2:var_8), # COMBINO mutate() con across() donde defino primero sobre que columnas operara la transformacion
                .fns = ~ str_remove_all(string = ., pattern = "\\D"))) # aplico luego una tarea para todas las columnas (remover caracterres que no sean numericos VER: https://evoldyn.gitlab.io/evomics-2018/ref-sheets/R_strings.pdf)

# Imputamos los nombres correspondientes a las Columnas

x <- c("Crypto","Capitalizacion_Mercado", "Fd_Capitalizacion_Mercado", "Ultima_Cotiz", "Q_disponible", 
       "Q_total", "Volumen_operado", "Evolucion")

names(crypt_table) <- x

# Convertimos nuestros valores a numericos 

crypt_table <- 
  data.frame(apply(crypt_table[2:8],2, as.numeric)) %>% 
  cbind(Crypto = crypt_table$Crypto) %>% 
  select(8,1:7)

# Ejercicio 3

# Veamos cuales son las monedas mas operadas segun volumen

crypt_table %>% 
  select(Crypto, Volumen_operado) %>% 
  filter(Volumen_operado > 600) %>% 
  ggplot(., aes(reorder(Crypto, Volumen_operado), Volumen_operado )) +
  geom_bar(stat = "identity", aes(fill = Volumen_operado)) + coord_flip() +
  ggtitle("Top 10 Monedas operadas segun volumen") +
  xlab("Crypto") + ylab("Volumen_operado") + 
  theme(plot.title = element_text(hjust = 0.5, face = "bold", size = 15),
        axis.title.x = element_text(face = "bold", size =  13),
        axis.title.y = element_text(face = "bold", size = 13))

# Veamos las monedas que mas incrementaron su valor

crypt_table %>% 
  select(Crypto, Evolucion) %>% 
  filter(Evolucion > 10) %>% 
  ggplot(., aes(reorder(Crypto, Evolucion), Evolucion )) +
  geom_bar(stat = "identity", aes(fill = Evolucion)) + coord_flip() +
  ggtitle("Cryptomonedas con mayor valuacion en las ultimas 24hs") +
  xlab("Crypto") + ylab("Evolucion") + 
  theme(plot.title = element_text(hjust = 0.5, face = "bold", size = 15),
        axis.title.x = element_text(face = "bold", size =  13),
        axis.title.y = element_text(face = "bold", size = 13))
