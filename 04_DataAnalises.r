setwd("C:/Users/thiag/Desktop/EstudoDeCasoCyclistic")

library(readr)
library(dplyr)
library(tidyverse)
library(here)
library(janitor)
library(lubridate)

paraAnalises <- read_csv("CSVs/paraAnalises.csv")

View(head(paraAnalises))

paraAnalises$...1 <- NULL
View(head(paraAnalises))

# para uma análise 'tátil', é necessário converter os segundos um minutos:

# tempo total dos passeios
mean(paraAnalises$ride_length/60)

# media do tempo dos passeios
median(paraAnalises$ride_length/60)

# maior tempo em passeios
max(paraAnalises$ride_length/60)

# menor tempo em passeios
min(paraAnalises$ride_length/60) #shortest ride

# existem dados de registros incorretos que mostram passeios maiores que 24h, corrigindo:
paraAnalises <- paraAnalises[!(paraAnalises$ride_length>86400),]

# uma nova rodada de analise:

summary(paraAnalises$ride_length/60)
mean(paraAnalises$ride_length/60)
median(paraAnalises$ride_length/60)
max(paraAnalises$ride_length/60)
min(paraAnalises$ride_length/60)

# observando o comportamento dos dois tipos de usuarios:
aggregate(paraAnalises$ride_length/60 ~ paraAnalises$member_casual, FUN = mean)
aggregate(paraAnalises$ride_length/60 ~ paraAnalises$member_casual, FUN = median)
aggregate(paraAnalises$ride_length/60 ~ paraAnalises$member_casual, FUN = max)
aggregate(paraAnalises$ride_length/60 ~ paraAnalises$member_casual, FUN = min)

# tempo médio de viagem comparando os tipos de usuarios:

paraAnalises$date <- as.Date(paraAnalises$started_at)
paraAnalises$month <- format(as.Date(paraAnalises$date), "%m")
paraAnalises$month_day <- format(as.Date(paraAnalises$date), "%d")
paraAnalises$year <- format(as.Date(paraAnalises$date), "%Y")
paraAnalises$day_of_week <- format(as.Date(paraAnalises$date), "%A")

aggregate(paraAnalises$ride_length/60 ~ paraAnalises$member_casual + paraAnalises$day_of_week, FUN = mean)

# ordenando a saída:

paraAnalises$day_of_week <- ordered(paraAnalises$day_of_week, levels=c("segunda", "terca", "quarta", "quinta", "sexta", "sabado", "domingo"))
aggregate(paraAnalises$ride_length/60 ~ paraAnalises$member_casual + paraAnalises$day_of_week, FUN = mean)

View(head(paraAnalises))


# tipos de viagem por modo de usuario e dias da semana

paraAnalises %>% 
  mutate(weekday = wday(started_at, label = TRUE)) %>%
  group_by(member_casual, weekday) %>%
  summarise(number_of_rides = n()
            ,average_duration = mean(ride_length/60)) %>%
  arrange(member_casual, weekday)

# corridas por tipo de usuario
paraAnalises %>% 
  mutate(weekday = wday(started_at, label = TRUE)) %>% 
  group_by(member_casual, weekday) %>% 
  summarise(number_of_rides = n()
            ,average_duration = mean(ride_length)) %>% 
  arrange(member_casual, weekday)  %>% 
  ggplot(aes(x = weekday, y = number_of_rides, fill = member_casual)) +
  geom_col(position = "dodge")

# duracao media
paraAnalises %>% 
  mutate(weekday = wday(started_at, label = TRUE)) %>% 
  group_by(member_casual, weekday) %>% 
  summarise(number_of_rides = n()
            ,average_duration = mean(ride_length)) %>% 
  arrange(member_casual, weekday)  %>% 
  ggplot(aes(x = weekday, y = average_duration, fill = member_casual)) +
  geom_col(position = "dodge")

##Exporting this dataframe to a CSV file:
write.csv(paraAnalises,"C:/Users/thiag/Desktop/EstudoDeCasoCyclistic/CSVs/finalizado.csv", row.names = FALSE)
write.csv(paraAnalises, file = "CyclisticFinal.csv")
