################################################################################
# Packages #
################################################################################

# For reading SAS XPT file from NHANES website
# haven::read_xpt

library(haven)
library(srvyr)
# For using survey weights
# survey::svydesign, svymean, svyglm

library(dplyr)

####################################
# Fuentes##   ######################
####################################

guat_21<-read_spss("https://www.ine.gob.gt/sistema/uploads/2022/02/25/20220225223211Ixu5S3WjSZsRS7ClOTc9m3KRW54lcJcd.sav")
guat_10<-read_spss("https://www.ine.gob.gt/sistema/uploads/2014/01/08/sCXoMCbLernxMCdJjcEOISTYwtMraz91.sav")
guat_04<-read_spss("https://www.ine.gob.gt/sistema/uploads/2014/01/08/0PyTsGavWt4fUfJ8eSj0hUpMjUrZQj21.sav")

 ####################################
# Mineria     ######################
####################################

# Variables a definir
guat_filt_21<- guat_21 %>%
  select(FACTOR,PPA02,P03A05A,P03A05B,PPA06)   %>% 
  mutate(id = row_number(),
         PPA06 = ifelse(PPA06  %in% c(3,4) | is.na(PPA06) ,0,1))
                                                          
names(guat_filt_21)<-c("FACTOR","SEXO","NIVEL","GRADO","ETNI","id")
# Notamos NAs

guat_filt_10<- guat_10 %>%
  select(FACTOR,PPA03,P03A05A,P03A05B,PPA07)    %>% 
  mutate(id = row_number(),
         PPA07 = ifelse(PPA07  %in% c(3,4) | is.na(PPA07) ,0,1))
names(guat_filt_10)<-c("FACTOR","SEXO","NIVEL","GRADO","ETNI","id")

# Notamos NAs
guat_filt_04<- guat_04 %>%
  select(FACTOR,PPA02,P03A07A,P03A07B,P03A03)   %>% 
  mutate(id = row_number(),
         P03A03 = ifelse(P03A03 %in% c(8,6) | is.na(P03A03),0,1))
names(guat_filt_04)<-c("FACTOR","SEXO","NIVEL","GRADO","ETNI","id")

################################################################################
# Survey Weights #
################################################################################

# Here we use "svydesign" to assign the weights. We will use this new design
# variable "nhanesDesign" when running our analyses.

survey_21 <- guat_filt_21 %>% as_survey_design(ids = id, weight = FACTOR)
survey_10 <- guat_filt_10 %>% as_survey_design(ids = id, weight = FACTOR)
survey_04 <- guat_filt_04 %>% as_survey_design(ids = id, weight = FACTOR)

# Funciones para sacar proporciones rapidas

media_1x<-function(survey,x){
  x <- enquo(x)
  

  survey %>%
    group_by(!! x) %>%
    summarize(proportion = survey_mean(),
              total = survey_total())  
  
}

media_2x<-function(survey,x1,x2){
  x1 <- enquo(x1)
  x2 <- enquo(x2)
  
  survey %>%
    group_by(!! x1,!! x2) %>%
    summarize(proportion = survey_mean(),
              total = survey_total())  
  
}


################################################################################
# Statistics #
################################################################################

media_1x(survey_21,ETNI)
media_1x(survey_10,ETNI)
media_1x(survey_11,ETNI)

media_1x(survey_12,ETNI)

media_1x(survey_04,ETNI)

###########
# sexo y etni 

gu_21_h<-(media_2x(survey_21 %>% filter(SEXO==1),NIVEL,ETNI) %>% filter(ETNI==1))
gu_12_h<-(media_2x(survey_12%>% filter(SEXO==1),NIVEL,ETNI) %>% filter(ETNI==1))
gu_11_h<-(media_2x(survey_11%>% filter(SEXO==1),NIVEL,ETNI) %>% filter(ETNI==1))
gu_10_h<-(media_2x(survey_10%>% filter(SEXO==1),NIVEL,ETNI) %>% filter(ETNI==1))

gu_21_m<-(media_2x(survey_21 %>% filter(SEXO==2),NIVEL,ETNI) %>% filter(ETNI==1))
gu_12_m<-(media_2x(survey_12%>% filter(SEXO==2),NIVEL,ETNI) %>% filter(ETNI==1))
gu_11_m<-(media_2x(survey_11%>% filter(SEXO==2),NIVEL,ETNI) %>% filter(ETNI==1))
gu_10_m<-(media_2x(survey_10%>% filter(SEXO==2),NIVEL,ETNI) %>% filter(ETNI==1))

library(ggplot2)
ggplot() +
  geom_line(aes(gu_21_h$NIVEL, gu_21_h$total, color = "2021_h"))+
  geom_line(aes( gu_12_h$NIVEL, gu_12_h$total, color = "2012_h"))+
  geom_line(aes( gu_11_h$NIVEL, gu_11_h$total, color = "2011_h"))+
  geom_line(aes( gu_10_h$NIVEL, gu_10_h$total, color = "2010_h"))

ggplot() +
  geom_line(aes(gu_21_m$NIVEL, gu_21_m$total, color = "2021_m"))+
  geom_line(aes( gu_12_m$NIVEL, gu_12_m$total, color = "2012_m"))+
  geom_line(aes( gu_11_m$NIVEL, gu_11_m$total, color = "2011_m"))+
  geom_line(aes( gu_10_m$NIVEL, gu_10_m$total, color = "2010_m"))


###########
  # TOTAL POBLACION NIVEL
gu_21<-media_2x(survey_21 ,NIVEL,ETNI)  %>% filter(ETNI==0)

gu_10<-media_2x(survey_10,NIVEL,ETNI) %>% filter(ETNI==0)
gu_04<-media_2x(survey_04,NIVEL,ETNI) %>% filter(ETNI==0)


ggplot() +
  geom_line(aes(gu_21$NIVEL, gu_21$total, color = "2021"))+
  geom_line(aes( gu_10$NIVEL, gu_10$total, color = "2010")) +
  geom_line(aes( gu_04$NIVEL-1, gu_04$total, color = "2004")) 


######
# 
# SEXO

gu_21_h<-media_2x(survey_21 %>% filter(SEXO==1),NIVEL,ETNI) 
gu_10_h<-media_2x(survey_10%>% filter(SEXO==1),NIVEL,ETNI)
gu_04_h<-media_2x(survey_04%>% filter(SEXO==1),NIVEL,ETNI)

gu_21_m<-media_2x(survey_21 %>% filter(SEXO==2),NIVEL,ETNI)
gu_10_m<-media_2x(survey_10%>% filter(SEXO==2),NIVEL,ETNI )
gu_04_m<-media_2x(survey_04%>% filter(SEXO==2),NIVEL,ETNI )

ggplot() +
  geom_line(aes(gu_21_h$NIVEL, gu_21_h$total, color = "2021_h"))+
  geom_line(aes( gu_10_h$NIVEL, gu_10_h$total, color = "2010_h")) +
  geom_line(aes( gu_04_h$NIVEL-1, gu_04_h$total, color = "2004_h"))# +

ggplot() +  
  geom_line(aes(gu_21_m$NIVEL, gu_21_m$total, color = "2021_m"))+
  geom_line(aes( gu_10_m$NIVEL, gu_10_m$total, color = "2010_m"))+
  geom_line(aes(gu_04_m$NIVEL-1, gu_04_m$total, color = "2004_m"))






###########
# sexo y etni 

tot_h_21<-sum((media_2x(survey_21 %>% filter(SEXO==1),NIVEL,ETNI))$total)
tot_h_10<-sum((media_2x(survey_10%>% filter(SEXO==1),NIVEL,ETNI))$total)
tot_h_04<-sum((media_2x(survey_04%>% filter(SEXO==1),NIVEL,ETNI))$total)

tot_m_21<-sum((media_2x(survey_21 %>% filter(SEXO==2),NIVEL,ETNI))$total)
tot_m_10<-sum((media_2x(survey_10%>% filter(SEXO==2),NIVEL,ETNI))$total)
tot_m_04<-sum((media_2x(survey_04%>% filter(SEXO==2),NIVEL,ETNI))$total)


tot_21<-sum((media_2x(survey_21 ,NIVEL,ETNI))$total)
tot_10<-sum((media_2x(survey_10,NIVEL,ETNI))$total)
tot_04<-sum((media_2x(survey_04,NIVEL,ETNI))$total)

tot_21_ind<-sum((media_2x(survey_21 ,NIVEL,ETNI) %>% filter(ETNI==1))$total)
tot_10_ind<-sum((media_2x(survey_10,NIVEL,ETNI) %>% filter(ETNI==1))$total)
tot_04_ind<-sum((media_2x(survey_04,NIVEL,ETNI) %>% filter(ETNI==1))$total)

tot_21_ind_m<-sum((media_2x(survey_21 %>% filter(SEXO==2) ,NIVEL,ETNI) %>% filter(ETNI==1))$total)
tot_10_ind_m<-sum((media_2x(survey_10  %>% filter(SEXO==2),NIVEL,ETNI) %>% filter(ETNI==1))$total)
tot_04_ind_m<-sum((media_2x(survey_04  %>% filter(SEXO==2),NIVEL,ETNI) %>% filter(ETNI==1))$total)

tot_21_ind_h<-sum((media_2x(survey_21 %>% filter(SEXO==1) ,NIVEL,ETNI) %>% filter(ETNI==1))$total)
tot_10_ind_h<-sum((media_2x(survey_10  %>% filter(SEXO==1),NIVEL,ETNI) %>% filter(ETNI==1))$total)
tot_04_ind_h<-sum((media_2x(survey_04  %>% filter(SEXO==1),NIVEL,ETNI) %>% filter(ETNI==1))$total)


crecimiento_h<-c(tot_h_04,tot_h_10,tot_h_21)
crecimiento_m<-c(tot_m_04,tot_m_10,tot_m_21)
crecimiento<-c(tot_04,tot_10,tot_21)

crecimiento_ind_m<-c(tot_04_ind_m,tot_10_ind_m,tot_21_ind_m)
crecimiento_ind_h<-c(tot_04_ind_h,tot_10_ind_h,tot_21_ind_h)

library(ggplot2)
ggplot() +
  geom_line(aes(c(2004,2010,2021), crecimiento_h, color = "hombres"))+
  geom_line(aes( c(2004,2010,2021), crecimiento_m, color = "mujeres")) 

ggplot() +
  geom_line(aes( c(2004,2010,2021), crecimiento_ind_h,color = "hombres_ind"))+
  geom_line(aes( c(2004,2010,2021), crecimiento_ind_m,color = "muj_ind"))

#### conocimiento son mujeres indigenas!



guat_11<-read_spss( "https://www.ine.gob.gt/sistema/uploads/2014/01/09/XYKxAZaV3CDIRzDog5RWYQO2VBNFq1BF.sav")
guat_12<-read_spss( "https://www.ine.gob.gt/sistema/uploads/2014/01/09/CLA2BEVcA9AaQj9cHX7yWQrAra9YUFrr.sav")


guat_filt_11<- guat_11 %>%
  select(FACTOR_EXP,Sexo,PO3A05A,PO3A05B,PPA07)%>% 
  mutate(id = row_number(),
         PPA07 = ifelse(PPA07  %in% c(3,4) | is.na(PPA07) ,0,1))
names(guat_filt_11)<-c("FACTOR","SEXO","NIVEL","GRADO","ETNI","id")

guat_filt_12<- guat_12 %>%
  select(FACTOR,PPA02,P03A03,P03A04,PPA06)%>%  
  mutate(id = row_number()) %>% mutate(PPA06 = ifelse(PPA06  %in% c(3,4) | is.na(PPA06) ,0,1))

names(guat_filt_12)<-c("FACTOR","SEXO","NIVEL","GRADO","ETNI","id")


survey_11 <- guat_filt_11 %>% as_survey_design(ids = id, weight = FACTOR)
survey_12 <- guat_filt_12 %>% as_survey_design(ids = id, weight = FACTOR)


#### REPITO


###########
# sexo y etni 

tot_h_21<-sum((media_2x(survey_21 %>% filter(SEXO==1),NIVEL,ETNI))$total)
tot_h_10<-sum((media_2x(survey_10%>% filter(SEXO==1),NIVEL,ETNI))$total)
tot_h_04<-sum((media_2x(survey_04%>% filter(SEXO==1),NIVEL,ETNI))$total)

tot_m_21<-sum((media_2x(survey_21 %>% filter(SEXO==2),NIVEL,ETNI))$total)
tot_m_10<-sum((media_2x(survey_10%>% filter(SEXO==2),NIVEL,ETNI))$total)
tot_m_04<-sum((media_2x(survey_04%>% filter(SEXO==2),NIVEL,ETNI))$total)


tot_21<-sum((media_2x(survey_21 ,NIVEL,ETNI))$total)
tot_12<-sum((media_2x(survey_12,NIVEL,ETNI))$total)
tot_11<-sum((media_2x(survey_11,NIVEL,ETNI))$total)
tot_10<-sum((media_2x(survey_10,NIVEL,ETNI))$total)
tot_04<-sum((media_2x(survey_04,NIVEL,ETNI))$total)

tot_21_ind<-sum((media_2x(survey_21 ,NIVEL,ETNI) %>% filter(ETNI==1))$total)
tot_12_ind<-sum((media_2x(survey_12,NIVEL,ETNI) %>% filter(ETNI==1))$total)
tot_11_ind<-sum((media_2x(survey_11,NIVEL,ETNI) %>% filter(ETNI==1))$total)
tot_10_ind<-sum((media_2x(survey_10,NIVEL,ETNI) %>% filter(ETNI==1))$total)
tot_04_ind<-sum((media_2x(survey_04,NIVEL,ETNI) %>% filter(ETNI==1))$total)

tot_21_ind_m<-sum((media_2x(survey_21 %>% filter(SEXO==2) ,NIVEL,ETNI) %>% filter(ETNI==1))$total)
tot_12_ind_m<-sum((media_2x(survey_12  %>% filter(SEXO==2),NIVEL,ETNI) %>% filter(ETNI==1))$total)
tot_11_ind_m<-sum((media_2x(survey_11  %>% filter(SEXO==2),NIVEL,ETNI) %>% filter(ETNI==1))$total)
tot_10_ind_m<-sum((media_2x(survey_10  %>% filter(SEXO==2),NIVEL,ETNI) %>% filter(ETNI==1))$total)
tot_04_ind_m<-sum((media_2x(survey_04  %>% filter(SEXO==2),NIVEL,ETNI) %>% filter(ETNI==1))$total)

tot_21_ind_h<-sum((media_2x(survey_21 %>% filter(SEXO==1) ,NIVEL,ETNI) %>% filter(ETNI==1))$total)
tot_12_ind_h<-sum((media_2x(survey_12  %>% filter(SEXO==1),NIVEL,ETNI) %>% filter(ETNI==1))$total)
tot_11_ind_h<-sum((media_2x(survey_11  %>% filter(SEXO==1),NIVEL,ETNI) %>% filter(ETNI==1))$total)
tot_10_ind_h<-sum((media_2x(survey_10  %>% filter(SEXO==1),NIVEL,ETNI) %>% filter(ETNI==1))$total)
tot_04_ind_h<-sum((media_2x(survey_04  %>% filter(SEXO==1),NIVEL,ETNI) %>% filter(ETNI==1))$total)


crecimiento_h<-c(tot_h_10,tot_h_21)
crecimiento_m<-c(tot_m_10,tot_m_21)
crecimiento<-c(tot_10,tot_11,tot_12,tot_21)

crecimiento_ind_m<-c(tot_10_ind_m,tot_11_ind_m,tot_12_ind_m,tot_21_ind_m)
crecimiento_ind_h<-c(tot_10_ind_h,tot_11_ind_h,tot_12_ind_h,tot_21_ind_h)

library(ggplot2)
ggplot() +
  geom_line(aes(c(2010,2011,2012,2021), crecimiento))

ggplot() +
  geom_line(aes( c(2010,2011,2012,2021), crecimiento_ind_h,color = "hombres_ind"))+
  geom_line(aes( c(2010,2011,2012,2021), crecimiento_ind_m,color = "muj_ind"))
