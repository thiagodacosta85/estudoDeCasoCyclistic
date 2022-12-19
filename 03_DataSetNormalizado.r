setwd("C:/Users/thiag/Desktop/EstudoDeCasoCyclistic")

library(readr)
library(dplyr)
library(tidyverse)
library(here)
library(janitor)
library(lubridate)

dsNormalizado <- read_csv("CSVs/clean_doze_meses_v2.csv")

# removendo a coluna indesejada

dsNormalizado$...1 <- NULL
head(dsNormalizado)

# conferindo a estrutura da tabela
str(dsNormalizado)
dim(dsNormalizado)
colnames(dsNormalizado)
View(head(dsNormalizado))


# verificando valores 'na'
sum(is.na(dsNormalizado))
colSums(is.na(dsNormalizado))

# trabalhando na exibição das datas

# dsNormalizado$date <- as.Date(dsNormalizado$started_at)
# dsNormalizado$month <- format(as.Date(dsNormalizado$date), "%m")
# dsNormalizado$month_day <- format(as.Date(dsNormalizado$date), "%d")
# dsNormalizado$year <- format(as.Date(dsNormalizado$date), "%Y")
# dsNormalizado$day_of_week <- format(as.Date(dsNormalizado$date), "%A")

glimpse(dsNormalizado)

view(head(dsNormalizado))
view(tail(dsNormalizado))

# View(dsNormalizado)
##testing filter on start_station_name
dsNormalizado %>% 
  filter(start_station_name =="St. Clair St & Erie St")
unique(dsNormalizado$start_station_id)
unique(dsNormalizado$end_station_id)
unique(dsNormalizado$start_station_name)

# calculando o tamanho em da viagem

dsNormalizado$ride_length <- difftime(dsNormalizado$ended_at,dsNormalizado$started_at)

str(dsNormalizado)

is.factor(dsNormalizado$ride_length)
dsNormalizado$ride_length <- as.numeric(as.character(dsNormalizado$ride_length))
is.numeric(dsNormalizado$ride_length)

# o dataset inclui dados incorretos com valores negativos sobre uso das biciletas.

dsNormalizado %>% 
  filter(dsNormalizado=="HQ QR")

dsNormalizado_v1 <- dsNormalizado[!(dsNormalizado$start_station_name == "HQ QR" | dsNormalizado$ride_length<1),]
rm(dsNormalizado)

sum(is.na(dsNormalizado_v1))
dsNormalizado_v1
str(dsNormalizado_v1)

write.csv(dsNormalizado_v1, file = "C:/Users/thiag/Desktop/EstudoDeCasoCyclistic/CSVs/paraAnalises.csv")



