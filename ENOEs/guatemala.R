#GUATEMALA

####################################
# Fuentes##   ######################
####################################

guat_hog<-read.csv("https://www.ine.gob.gt/sistema/uploads/2022/02/14/20220214215047YFwPqR0P2L23elonGRCnkhwrkPEb6vOV.csv")
guat_pers<-read.csv("https://www.ine.gob.gt/sistema/uploads/2022/02/14/20220214214745mzIxoTsLKBOBI3sLQROJqn4f0HCNodaB.csv")


####################################
# Mineria     ######################
####################################

# Variables a definir
guat_pers<- guat_pers %>%
  select(UPM,FACTOR,PPA02,P03A05A,P03A05B) 

names(guat_pers)<-c("UPM","FACTOR","SEXO","NIVEL","GRADO")
guat_pers$NIVEL<-as.numeric(guat_pers$NIVEL)
# Notamos NAs
summary(guat_pers$NIVEL)

####################################
# Agregados   ######################
####################################
## HOMBRES#
mean((guat_pers %>% filter(SEXO =="1" ) %>% select(NIVEL)+1)$NIVEL, na.rm = T)-1

## MUJERES
mean((guat_pers %>% filter(SEXO =="2" ) %>% select(NIVEL)+1)$NIVEL, na.rm = T)-1

hist(guat_pers$NIVEL)

####################################
# Comentarios   ######################
####################################

# Tiene montos!
# No se ha realizado el manejo correcto de upms etc
