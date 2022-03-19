*Primer Dofile para explorar ENOE tabla SDEM*
*con MAC*

clear
*ojo..al usar MAC se usa / en todas las direcciones.

cd "/Users/sofiacorona/Desktop/Bases de Datos"

*2019 está por separado ya que para el tercer y cuarto trimestre todas las variables vienen con mayúsculas

use "ENOE/SDEMT419.dta"

*Generar identificador de vivienda 
egen id_hogar = concat(CD_A ENT CON V_SEL N_HOG H_MUD)

*Generar identificador personal
egen id_p = concat(CD_A ENT CON V_SEL N_HOG H_MUD N_REN)

*Generar identificador trimestral
*gen id_trim = `quarterloop'`yearloop'

*Dejar variables relevantes
*keep UPM id_p id_hogar SEX EDA L_NAC_C CS_P12 CS_NR_ORI FAC EST EST_D

sort id_p
*algo no le gusta en este renglón
save "ENOE/base_sdemt419.dta", replace 


*De 2010 a 2018

foreach yearloop of numlist 10(1)18 {
forvalues quarterloop= 1(1)4 {

use "ENOE/SDEMT`quarterloop'`yearloop'.dta"

*Generar identificador de vivienda 
egen id_hogar = concat(cd_a ent con v_sel n_hog h_mud)

*Generar identificador personal
egen id_p = concat(cd_a ent con v_sel n_hog h_mud n_ren)

*Generar identificador trimestral
*gen id_trim = `quarterloop'`yearloop'

*Dejar variables relevantes
*keep upm id_p id_hogar sex eda l_nac_c cs_p12 cs_nr_ori fac est est_d

sort id_p

save "ENOE/base_sdemt`quarterloop'`yearloop'.dta", replace
}
}

*De 2005 a 2009

clear
cd "/Users/sofiacorona/Desktop/Bases de Datos"

foreach yearloop of numlist 5(1)9 {
forvalues quarterloop= 1(1)4 {

use "ENOE/SDEMT`quarterloop'0`yearloop'.dta"

*Generar identificador de vivienda 
egen id_hogar = concat(cd_a ent con v_sel n_hog h_mud)

*Generar identificador personal
egen id_p = concat(cd_a ent con v_sel n_hog h_mud n_ren)

*Generar identificador trimestral
*gen id_trim = `quarterloop'`yearloop'

*Dejar variables relevantes
*keep upm id_p id_hogar sex eda l_nac_c cs_p12 cs_nr_ori fac est est_d

sort id_p

save "ENOE/base_sdemt`quarterloop'0`yearloop'.dta", replace
}
}
