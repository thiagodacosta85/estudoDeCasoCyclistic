setwd("C:/Users/thiag/Desktop/EstudoDeCasoCyclistic")

library(readr)
library(dplyr)
library(tidyverse)
library(here)
library(janitor)
library(lubridate)

clean_doze_meses <- read_csv("CSVs/clean_doze_meses.csv")

# removendo a coluna indesejada

clean_doze_meses$...1 <- NULL
head(clean_doze_meses)

# conferindo a estrutura da tabela
str(clean_doze_meses)
dim(clean_doze_meses)
colnames(clean_doze_meses)
View(head(clean_doze_meses))


# verificando valores 'na'
sum(is.na(clean_doze_meses))
colSums(is.na(clean_doze_meses))
View(tail(clean_doze_meses))

# alterando as colunas start_station_id e end_station_id para valores numéricos

clean_doze_meses_v1 <- mutate(clean_doze_meses, start_station_id = as.numeric(start_station_id), 
                              end_station_id = as.numeric(end_station_id))

str(clean_doze_meses_v1)
dim(clean_doze_meses_v1)
colnames(clean_doze_meses_v1)
View(head(clean_doze_meses_v1))

sum(is.na(clean_doze_meses_v1))

# foram acrescentados campos 'na' após a conversão dos dados, portanto será necessária uma nova limpeza

clean_doze_meses_v2 <- na.omit(clean_doze_meses_v1)

# verificando a v2 do novo data set:

str(clean_doze_meses)
dim(clean_doze_meses_v2)

# exportando um novo dataset com os dado normalizados na v2

write.csv(clean_doze_meses_v2, file = "C:/Users/thiag/Desktop/EstudoDeCasoCyclistic/CSVs/clean_doze_meses_v2.csv")
