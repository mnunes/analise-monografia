# pacotes necessarios

library(pdftools)
library(tidyverse)
theme_set(theme_bw() +
            theme(axis.text.x = element_text(angle = 45, vjust = 1, hjust = 1)))
library(stringi)
library(lubridate)

# lista de arquivos

arquivos <- list.files("relatorios/")

# limpeza da lista de arquivos
# a expressao regular abaixo mantem apenas
# os arquivos com nome no formato yyyy-mm-dd.pdf

arquivos <- grep("^\\d{4}-\\d{2}-\\d{2}.pdf", arquivos, value = TRUE)
arquivos <- paste("relatorios/", arquivos, sep = "")

# funcao para ler os arquivos pdf, extrair o texto
# e limpar eventuais sujeiras

limpeza <- function(x){
  
  x <- pdf_text(x)
  
  paginas <- length(x)
  
  x <- x %>%
    paste(., collapse = " ") %>%
    str_remove_all("\\n") %>%
    str_remove_all(" \\. ")
  
  return(c(nchar(x), 
           stri_count(x, regex="\\S+"),
           paginas))
  
}

# aplica a funcao limpeza e formata o data frame final

dados <- arquivos %>%
  map(limpeza) %>%
  do.call(rbind.data.frame, .) %>%
  bind_cols(arquivos) %>%
  select(data = 4, caracteres = 1, palavras = 2, paginas = 3) %>%
  mutate(data = ymd(gsub("\\.pdf", "", data)))

# graficos

ggplot(dados, aes(x = data, y = caracteres)) +
  geom_line() +
  geom_point(pch = 1) +
  labs(x = "Data", y = "Número de caracteres na monografia") +
  scale_x_date(breaks = "1 month", date_labels = "%B/%y")

ggplot(dados, aes(x = data, y = palavras)) +
  geom_line() +
  geom_point(pch = 1) +
  labs(x = "Data", y = "Número de palavras na monografia") +
  scale_x_date(breaks = "1 month", date_labels = "%B/%y")

ggplot(dados, aes(x = data, y = paginas)) +
  geom_line() +
  geom_point(pch = 1) +
  labs(x = "Data", y = "Número de páginas na monografia") +
  scale_x_date(breaks = "1 month", date_labels = "%B/%y")
