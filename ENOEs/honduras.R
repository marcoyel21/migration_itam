#Honduras

####################################
# Fuentes##   ######################
####################################
library(dplyr)
library(haven)

path = file.path( "EPHPM_0619.sav")
hond_hog = read_sav(path)

path = file.path( "EPHPM_CONSOLIDADA_2019.sav")
hond_per = read_sav(path)


####################################
# Mineria     ######################
####################################

# Variables a definir
hond_per<- hond_per %>%
  select(SEXO,CP407) 

names(hond_per)<-c("SEXO","NIVEL")
hond_per$NIVEL<-as.numeric(hond_per$NIVEL)
# Notamos NAs
summary(hond_per$NIVEL)

hond_per<- hond_per %>% mutate(NIVEL= ifelse(NIVEL==99,NA,NIVEL))
# Muchos NAs

####################################
# Agregados   ######################
####################################
## Mujeres
mean((hond_per %>% filter(SEXO ==1 ) %>% select(NIVEL))$NIVEL, na.rm = T)

## Hombres
mean((hond_per %>% filter(SEXO ==2 ) %>% select(NIVEL))$NIVEL, na.rm = T)

hist(hond_per$NIVEL)

####################################
# Comentarios   ######################
####################################

# Tiene montos!
# No es clara la documentacion, hay variables que no entendemos con claidad
# Ni el manejo de upm etc


