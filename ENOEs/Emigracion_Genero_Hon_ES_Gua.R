# El Salvador

#  Librerias
library(readxl)
library(ggplot2)

# Basee de datos
Emigracion_SAL_GUA_HON <- 
  read_excel("Documents/BaseDatosEmigración.xlsx")

# Análisis exploratorio de datos
View(Emigracion_SAL_GUA_HON)
variable.names(Emigracion_SAL_GUA_HON)

# Variables a definir
Emig_ES_GUA_HON <- Emigracion_SAL_GUA_HON %>%
  select(`Country Origin Name`,
         `Migration by Gender Name`,
         `Country Dest Name`,
         `1960 [1960]`,
         `1970 [1970]`,
         `1980 [1980]`,
         `1990 [1990]`,
         `2000 [2000]`
         )

names(Emig_ES_GUA_HON) <-
  c("Paìs_Origen",
    "Sexo",
    "Pais_Destino",
    "1960",
    "1970",
    "1980",
    "1990",
    "2000")

Emig_2 <- Emig_ES_GUA_HON %>%
  select(`1960`,
         `1970`,
         `1980`,
         `1990`,
         `2000`
  )

# Total de emigrantes de los tres países de 1960 al 2000

Total_Emig_1960a2000 <- colSums(Emig_2)
Total_Emig_1960a2000
# 1960  1970  1980  1990  2000 
# 4035  5758  6899  9747 36757 

# Mujeres y hombres de El Salvador que emigraron de 1960 al 2000

# El Salvador
ElSalvador <- Emig_ES_GUA_HON %>% 
  filter(Paìs_Origen == "El Salvador")
# Mujeres
Mujeres_ES <- ElSalvador %>% 
  filter(Sexo == "Female")
Mujeres_ES_1960a2000 <- colSums(Mujeres_ES[,4:8])
Mujeres_ES_1960a2000
# 1960 1970 1980 1990 2000 
# 384  683  910 4477 7958 
# Hombres
Hombres_ES <- ElSalvador %>% 
  filter(Sexo == "Male")
Hombres_ES_1960a2000 <- colSums(Hombres_ES[,4:8])
Hombres_ES_1960a2000
# 1960 1970 1980 1990 2000 
# 556  887 1167 4302 7853 

# Mujeres y hombres de Guatemala que emigraron de 1960 al 2000

# Guatemala
Guatemala <- Emig_ES_GUA_HON %>% 
  filter(Paìs_Origen == "Guatemala")
# Mujeres
Mujeres_GUA <- Guatemala %>% 
  filter(Sexo == "Female")
Mujeres_GUA_1960a2000 <- colSums(Mujeres_GUA[,4:8])
Mujeres_GUA_1960a2000
# 1960 1970 1980 1990 2000 
# 964 1281 1487  210 7954 
# Hombres
Hombres_GUA <- Guatemala %>% 
  filter(Sexo == "Male")
Hombres_GUA_1960a2000 <- colSums(Hombres_GUA[,4:8])
Hombres_GUA_1960a2000
# 1960 1970 1980 1990 2000 
# 1036 1414 1683  257 7579 

# Mujeres y hombres de Honduras que emigraron de 1960 al 2000

# Honduras
Honduras <- Emig_ES_GUA_HON %>% 
  filter(Paìs_Origen == "Honduras")
# Mujeres
Mujeres_HON <- Honduras %>% 
  filter(Sexo == "Female")
Mujeres_HON_1960a2000 <- colSums(Mujeres_HON[,4:8])
Mujeres_HON_1960a2000
# 1960 1970 1980 1990 2000 
# 555  747  821  258 2663 
# Hombres
Hombres_HON <- Honduras %>% 
  filter(Sexo == "Male")
Hombres_HON_1960a2000 <- colSums(Hombres_HON[,4:8])
Hombres_HON_1960a2000
# 1960 1970 1980 1990 2000 
# 540  746  831  243 2750 

# Gràficas

# Variable
años <- c(1960,1970,1980,1990,2000)
Tot_Emig <- c(4035,5758,6899,9747,36757)
Resumen <- data.frame(años,Tot_Emig,
                      Mujeres_ES_1960a2000,
                      Hombres_ES_1960a2000,
                      Mujeres_GUA_1960a2000,
                      Hombres_GUA_1960a2000,
                      Mujeres_HON_1960a2000,
                      Hombres_HON_1960a2000)

names(Resumen) <-
  c("Años",
    "Total Emigrantes",
    "Mujeres El Salvador",
    "Hombres El Salvador",
    "Mujeres Guatemala",
    "Hombres Guatemala",
    "Mujeres Honduras",
    "Hombres Honduras")
View(Resumen)

# Barras
barras <- ggplot(Emig_ES_GUA_HON, 
                 aes(x = Sexo)) + geom_bar(width=0.5, 
                                           colour="blue", 
                                           fill="red")
barras + xlab("Sexo") + ylab ("Número de casos")
