# -----------------------------------------------------------------------------
#                                 Migration
#
# Author: Roberto Gonzalez Tellez & Marco Antonio Ramos
# Date: Jun  26, 2022
#
# Objective: Create tabulation of women's labour participation for El Salvador
#            by education level
# -----------------------------------------------------------------------------

#### Load packages for handling survey data and creating tables #### ----------
if (!require("pacman")) {
  install.packages("pacman")
}

pacman::p_load(haven, srvyr, tidyverse, kableExtra, here)

# Avoid scientific notation
options(scipen = 99999)

#### Read in datasets: EHPM for years 2020 and 2010 #### ----------------------
salvador_20 <- read_spss(here( "EHPM 2020.sav"))

salvador_10_a <- read_sav(here( "EHPM_2010", "SEC021.sav")) %>% 
  mutate(id = row_number()) %>%
  select(id, R217A)

salvador_10_b <- read_sav(here( "EHPM_2010", "sec04.sav")) %>% 
  mutate(id = row_number()) %>%
  select(id, R403,R407) %>% mutate(ocupacion=ifelse(R403==1,"Ocupado", 
                                              ifelse((R403==2|R403==3) & R407==1,"Desocupado", 
                                              ifelse((R403==2|R403==3) & R407==2,"Inactivo",NA ))))
  
salvador_10_c <- read_sav(here( "EHPM_2010", "SEC01.sav")) %>% 
  mutate(id = row_number()) %>%
  select(id, FAC01, R104, R106)

salvador_10 <- inner_join(salvador_10_a, salvador_10_b,
                          by = "id")

salvador_10 <- inner_join(salvador_10, salvador_10_c,
                          by = "id")


###############
# COMENTARIO SOBRE EL CALCULO LABORAL
############
#2010

#R403-¿Realizó trabajo la semana pasada?
#1-Si
#2-No
# Si es 1 entonces es Ocupado
# Si es dos vemos la siguiente pregunta
# R407 -¿Busco trabajo la semana pasada?
#1-Si
#2-No
# SI es 1 y 1, entonces es desocupado
# Si es 1 y 0, es inactivo


#2020
#Labels:
#  value              label
#10            Ocupado
#22  Desocupado oculto
#21 Desocupado abierto
#23  Desocupado oculto
#24  Desocupado oculto
#25  Desocupado oculto
#30           Inactivo




#### Select variables of interest for computation efficiency #### -------------
salvador_relevant_20 <- salvador_20 %>%
  select(fac00, r104, r106, r204, r204g, actpr) %>%
  rename(factor = fac00,
         sexo = r104,
         edad = r106,
         nivel = r204,
         grado = r204g,
         ocupacion = actpr)

salvador_relevant_10 <- salvador_10 %>%
  rename(factor = FAC01,
         sexo = R104,
         edad = R106,
         nivel = R217A,
         ocupacion=ocupacion)

#### Impute an id number to each individual in the survey #### ----------------
salvador_relevant_20 <- salvador_relevant_20 %>%
  rowid_to_column(var = "id") %>%
  # add age and education level categories
  mutate(edad_factor = cut(edad, 
                           breaks = c(-Inf, 13, 24, 44, 64, Inf),
                           labels = c("Under 14", "14 to 24", "25 to 44",
                                      "45 to 64", "65 and over")),
         nivel_factor = cut(nivel,
                            breaks = c(-Inf, 2, 3, 4, 5, Inf),
                            labels = c("Primary (or less)", "High School", 
                                       "BS", "Graduate", "Special Ed.")),
         ocupacion_factor = cut(ocupacion,
                            breaks = c(0, 11, 29, 31),
                            labels = c("Ocupado", "Desocupado", 
                                       "Inactivo")))

salvador_relevant_10 <- salvador_relevant_10 %>%
  # add age and education level categories
  mutate(edad_factor = cut(edad, 
                           breaks = c(-Inf, 13, 24, 44, 64, Inf),
                           labels = c("Under 14", "14 to 24", "25 to 44",
                                      "45 to 64", "65 and over")),
         nivel_factor = cut(nivel,
                            breaks = c(-Inf, 2, 3, 4, 5, Inf),
                            labels = c("Primary (or less)", "High School", 
                                       "BS", "Graduate", "Special Ed.")))

#### Create survey design object to easily use weights and factor variables ####
survey_salvador_20 <- salvador_relevant_20 %>%
  as_survey_design(ids = id)

survey_salvador_10 <- salvador_relevant_10 %>%
  as_survey_design(ids = id, 
                   weight = factor)

#### Create table of proportion of respondents by age, sex and education #### -
salvador_age_20 <- survey_salvador_20 %>%
  group_by(edad_factor) %>%
  summarise(proportion = survey_mean(),
            total = survey_total()) %>%
  select(edad_factor, proportion)
names(salvador_age_20) <- c("By age", "2020")

salvador_sex_20 <- survey_salvador_20 %>%
  group_by(sexo) %>%
  summarise(proportion = survey_mean(),
            total = survey_total()) %>%
  select(sexo, proportion)
names(salvador_sex_20) <- c("By sex", "2020")

salvador_edu_20 <- survey_salvador_20 %>%
  group_by(nivel_factor) %>%
  summarise(proportion = survey_mean(),
            total = survey_total()) %>%
  select(nivel_factor, proportion)
names(salvador_edu_20) <- c("By education", "2020")

salvador_oc_20 <- survey_salvador_20 %>% filter(edad >14)%>%
  group_by(ocupacion_factor) %>% 
  summarise(proportion = survey_mean(),
            total = survey_total()) %>%
  select(ocupacion_factor, proportion)
names(salvador_oc_20) <- c("By ocupation", "2020")

# 2010
salvador_age_10 <- survey_salvador_10 %>%
  group_by(edad_factor) %>%
  summarise(proportion = survey_mean(),
            total = survey_total()) %>%
  select(edad_factor, proportion)
names(salvador_age_10) <- c("By age", "2010")

salvador_sex_10 <- survey_salvador_10 %>%
  group_by(sexo) %>%
  summarise(proportion = survey_mean(),
            total = survey_total()) %>%
  select(sexo, proportion)
names(salvador_sex_10) <- c("By sex", "2010")

salvador_edu_10 <- survey_salvador_10 %>%
  group_by(nivel_factor) %>%
  summarise(proportion = survey_mean(),
            total = survey_total()) %>%
  select(nivel_factor, proportion)
names(salvador_edu_10) <- c("By education", "2010")

salvador_oc_10 <- survey_salvador_10 %>%filter(edad >14)%>%
  group_by(ocupacion) %>%
  summarise(proportion = survey_mean(),
            total = survey_total()) %>%
  select(ocupacion, proportion)
names(salvador_oc_10) <- c("By ocupation", "2010")

# Make a list with tables for presenting them together
salvador_age <- merge(salvador_age_10, salvador_age_20)
salvador_edu <- merge(salvador_edu_10, salvador_edu_20)
salvador_sex <- merge(salvador_sex_10, salvador_sex_20)
salvador_ocu <- merge(salvador_oc_10, salvador_oc_20)


salvador_age <- rename(salvador_age, demographic = `By age`) %>%
  mutate(demographic = as.character(demographic))
salvador_sex <- rename(salvador_sex, demographic = `By sex`) %>%
  mutate(demographic = as.character(demographic))
salvador_edu <- rename(salvador_edu, demographic = `By education`) %>%
  mutate(demographic = as.character(demographic))
salvador_ocu <- rename(salvador_ocu, demographic = `By ocupation`) %>%
  mutate(demographic = as.character(demographic))

salvador_all <- bind_rows(salvador_age, salvador_sex) %>%
  bind_rows(salvador_edu)%>%
  bind_rows(salvador_ocu)

tables <- list(salvador_all)
# Tabla por edad, sexo y educación
kable(tables, digits = 4) %>% kable_styling()

kable(salvador_age, digits = 4) %>% kable_styling()
kable(salvador_edu, digits = 4) %>% kable_styling()
kable(salvador_sex, digits = 4) %>% kable_styling()
kable(salvador_ocu, digits = 4) %>% kable_styling()


#### END OF SCRIPT #### -------------------------------------------------------


#survey_salvador_10 %>%
#  filter(is.na(nivel_factor)) %>%
#  group_by(edad_factor) %>%
#  summarise(prop = survey_mean()) %>%
#  kable() %>%
#  kable_styling()
#
#survey_salvador_20 %>%
#  filter(is.na(nivel_factor)) %>%
#  group_by(edad_factor) %>%
#  summarise(prop = survey_total()) %>%
#  kable() %>%
#  kable_styling()
#
#survey_salvador_20 %>%
#  filter(ocupacion == 10) %>%
#  group_by(nivel_factor) %>%
#  summarise(count = survey_total()) %>%
#  kable() %>%
#  kable_styling()