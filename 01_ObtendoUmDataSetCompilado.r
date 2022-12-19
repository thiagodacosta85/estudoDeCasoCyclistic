setwd("C:/Users/thiag/Desktop/EstudoDeCasoCyclistic")
 
# caregando as bibliotecas
 
library(readr)
library(dplyr)
library(tidyverse)
library(here)
library(janitor)
library(lubridate)

# importando os datasets

dez_2021 <- read_csv("CSVs/202112-divvy-tripdata.csv")
jan_2022 <- read_csv("CSVs/202201-divvy-tripdata.csv")
fev_2022 <- read_csv("CSVs/202202-divvy-tripdata.csv")
mar_2022 <- read_csv("CSVs/202203-divvy-tripdata.csv")
abr_2022 <- read_csv("CSVs/202204-divvy-tripdata.csv")
mai_2022 <- read_csv("CSVs/202205-divvy-tripdata.csv")
jun_2022 <- read_csv("CSVs/202206-divvy-tripdata.csv")
jul_2022 <- read_csv("CSVs/202207-divvy-tripdata.csv")
ago_2022 <- read_csv("CSVs/202208-divvy-tripdata.csv")
set_2022 <- read_csv("CSVs/202209-divvy-publictripdata.csv")
out_2022 <- read_csv("CSVs/202210-divvy-tripdata.csv")
nov_2022 <- read_csv("CSVs/202211-divvy-tripdata.csv")

# mesclando os datasets

doze_meses <- rbind(dez_2021, jan_2022,fev_2022,mar_2022, abr_2022, mai_2022, jun_2022, jul_2022, ago_2022, set_2022, out_2022, nov_2022)

str(doze_meses)

rm(dez_2021, jan_2022, fev_2022, mar_2022, abr_2022, mai_2022, jun_2022, jul_2022, ago_2022, set_2022, out_2022, nov_2022)

str(doze_meses)

write.csv(doze_meses, file = "C:/Users/thiag/Desktop/EstudoDeCasoCyclistic/CSVs/doze_meses.csv")

rm(doze_meses)

doze_meses <- read_csv("CSVs/doze_meses.csv")

str(doze_meses)

doze_meses$...1 <- NULL
head(doze_meses)

View(doze_meses)

# observando a estrutura geral do dataset total.

colnames(doze_meses)
nrow(doze_meses)
dim(doze_meses)
head(doze_meses)
tail(doze_meses)
str(doze_meses)
summary(doze_meses)

unique(doze_meses$member_casual)


# 'na' = not available

# especificando a ocorrência de 'na' por colunas
sum(is.na(doze_meses))
colSums(is.na(doze_meses))

# buscando com colunas com valores 'na' no dataset 
totalRegDataset <- dim(doze_meses)
totalRegistrosNa <- sum(is.na(doze_meses))
totalReg <- totalRegDataset[1]

# calculando percentual de reg 'na' no dataset

percRegNa <- ((totalRegistrosNa/totalReg))
print(percRegNa)
# 62% dos registros do dataset são incompletos e serão removidos.

cleanDozeMeses <- na.omit(doze_meses)
sum(is.na(cleanDozeMeses))
colSums(is.na(cleanDozeMeses))
dim(cleanDozeMeses)
write.csv(cleanDozeMeses, file = "C:/Users/thiag/Desktop/EstudoDeCasoCyclistic/CSVs/clean_doze_meses.csv")
