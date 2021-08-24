library(rvest)
library(tidyverse)

crpyto_url <- read_html("https://www.tradingview.com/markets/cryptocurrencies/prices-all/")

crypt_table <- html_nodes(crpyto_url, css = "table")

crypt_table <- html_table(crypt_table, fill = T) %>% 
  as.data.frame()

crypt_table$Var.2 <- gsub("B","", crypt_table$Var.2)
crypt_table$Var.2 <- gsub("M","", crypt_table$Var.2)
crypt_table$Var.2 <- gsub("K","", crypt_table$Var.2)
crypt_table$Var.3 <- gsub("B","", crypt_table$Var.3)
crypt_table$Var.3 <- gsub("M","", crypt_table$Var.3)
crypt_table$Var.3 <- gsub("K","", crypt_table$Var.3)
crypt_table$Var.4 <- gsub("B","", crypt_table$Var.2)
crypt_table$Var.4 <- gsub("M","", crypt_table$Var.4)
crypt_table$Var.4 <- gsub("K","", crypt_table$Var.4)
crypt_table$Var.5 <- gsub("B","", crypt_table$Var.5)
crypt_table$Var.5 <- gsub("M","", crypt_table$Var.5)
crypt_table$Var.5 <- gsub("K","", crypt_table$Var.5)
crypt_table$Var.6 <- gsub("B","", crypt_table$Var.6)
crypt_table$Var.6 <- gsub("M","", crypt_table$Var.6)
crypt_table$Var.6 <- gsub("K","", crypt_table$Var.6)
crypt_table$Var.7 <- gsub("B","", crypt_table$Var.7)
crypt_table$Var.7 <- gsub("M","", crypt_table$Var.7)
crypt_table$Var.7 <- gsub("K","", crypt_table$Var.7)
crypt_table$Var.8 <- gsub("B","", crypt_table$Var.8)
crypt_table$Var.8 <- gsub("M","", crypt_table$Var.8)
crypt_table$Var.8 <- gsub("K","", crypt_table$Var.8)
crypt_table$Var.8 <- gsub("%","", crypt_table$Var.8)

x <- c("Currency","Mkt Cap", "Fd Mkt Cap", "Last", "Avail coins", 
       "Total coins", "Traded Vol", "Chng%")

names(crypt_table) <- x

crypt_table <- 
  data.frame(apply(crypt_table[2:8],2, as.numeric)) %>% 
  cbind(currency = crypt_table$Currency) %>% 
  select(8,1:7)

crypt_table %>% 
  select(currency, Traded.Vol) %>% 
  filter(Traded.Vol > 600) %>% 
  ggplot(., aes(reorder(currency, Traded.Vol), Traded.Vol )) +
  geom_bar(stat = "identity", aes(fill = Traded.Vol)) + coord_flip() +
  ggtitle("Top 10 Traded Volume") +
  xlab("Currency") + ylab("Traded Volume") + 
  theme(plot.title = element_text(hjust = 0.5, face = "bold", size = 15),
        axis.title.x = element_text(face = "bold", size =  13),
        axis.title.y = element_text(face = "bold", size = 13))