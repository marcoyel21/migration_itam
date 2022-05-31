# -----------------------------------------------------------------------------
#                                 Migration
#
# Author: Roberto Gonzalez Tellez
# Date: May 9, 2022
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
salvador_20 <- read_spss(here("data", "EHPM", "EHPM 2020.sav"))

salvador_10_a <- read_sav(here("data", "EHPM", "EHPM_2010", "SEC021.sav")) %>% 
  mutate(id = row_number()) %>%
  select(id, R217A)

salvador_10_b <- read_sav(here("data", "EHPM", "EHPM_2010", "SEC01.sav")) %>% 
  mutate(id = row_number()) %>%
  select(id, FAC01, R104, R106)

salvador_10 <- inner_join(salvador_10_a, salvador_10_b,
                          by = "id")

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
         nivel = R217A)

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
                                       "BS", "Graduate", "Special Ed.")))

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

# Make a list with tables for presenting them together
salvador_age <- merge(salvador_age_10, salvador_age_20)
salvador_edu <- merge(salvador_edu_10, salvador_edu_20)
salvador_sex <- merge(salvador_sex_10, salvador_sex_20)

salvador_age <- rename(salvador_age, demographic = `By age`) %>%
  mutate(demographic = as.character(demographic))
salvador_sex <- rename(salvador_sex, demographic = `By sex`) %>%
  mutate(demographic = as.character(demographic))
salvador_edu <- rename(salvador_edu, demographic = `By education`) %>%
  mutate(demographic = as.character(demographic))

salvador_all <- bind_rows(salvador_age, salvador_sex) %>%
  bind_rows(salvador_edu)

tables <- list(salvador_all)
# Tabla por edad, sexo y educación
kable(tables, digits = 4) %>% kable_styling()

kable(salvador_age, digits = 4) %>% kable_styling()
kable(salvador_edu, digits = 4) %>% kable_styling()
kable(salvador_sex, digits = 4) %>% kable_styling()

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

