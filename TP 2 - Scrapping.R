library(rvest)
library(tidyverse)

url <- "https://www.coinbase.com/es-LA/price"

coinbase <- read_html(url)

coinbase

coinbase_table <- coinbase %>% 
  html_nodes(xpath = '//*[@id="main"]/div[1]/table') %>% 
  html_table(fill = T)

coinbase_table[[1]]
