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

# 2010 is more complicated since there are many files so it's easier to 
# load them all and bind_rows and then process the single appended dataset
temp_files <- list.files(path = here("data", "EHPM", "EHPM_2010"), 
                         pattern = "*.sav",
                         full.names = TRUE)
# Garbage collect to save memory since data is large
gc(full = TRUE)

# read in data and bind rows
salvador_10 <- lapply(temp_files, read_spss) %>%
  bind_rows()

#### Select variables of interest for computation efficiency #### -------------
salvador_relevant_20 <- salvador_20 %>%
  select(fac00, r104, r106, r204, r204g) %>%
  rename(factor = fac00,
         sexo = r104,
         edad = r106,
         nivel = r204,
         grado = r204g)

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

#### Create survey design object to easily use weights and factor variables ####
survey_salvador_20 <- salvador_relevant_20 %>%
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
names(salvador_age_20) <- c("By sex", "2020")

salvador_edu_20 <- survey_salvador_20 %>%
  group_by(nivel_factor) %>%
  summarise(proportion = survey_mean(),
            total = survey_total()) %>%
  select(nivel_factor, proportion)
names(salvador_age_20) <- c("By education", "2020")

# Make a list with tables for presenting them together
list(salvador_age_20, salvador_sex_20, salvador_edu_20) %>%
  kable()

#### END OF SCRIPT #### -------------------------------------------------------





