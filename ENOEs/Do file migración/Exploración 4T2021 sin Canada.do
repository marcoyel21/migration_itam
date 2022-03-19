***** OJO este dofile quita a Canada de Latam

***es diferente de los anteriores ****

clear

cd "/Users/sofiacorona/Desktop/Bases de Datos"

log using "/Users/sofiacorona/Desktop/Presentacion 24feb 4T21 sin Canada.smcl", replace

use "/Users/sofiacorona/Desktop/Bases de Datos/ENOE/SDEMT421.dta"

****** 4T2021 ********

rename fac_tri fac

***generar variable de lugar de nacimiento.

*** OJO a partir del 3T21 cambió la codificación de los países.  Ahora debemos 

/* Siempre arrancar con missing para que no se introduzcan los missing en la categoría igual a cero.
nacido en México = 0, 
nacido en Guatemala = 1,
nacido en resto de America = 2, 
nacido en USA = 3, 
nacido en Europa = 4, 
nacido en Africa y Asia = 5 
nacido en Canada = 6 tambien estan en código 2*/

generate lugar_nacimiento = .
replace lugar_nacimiento = 0 if l_nac_c <= 33
replace lugar_nacimiento = 1 if l_nac_c == 225 // Guatemala
replace lugar_nacimiento = 2 if l_nac_c >= 200 & l_nac_c < 300 & l_nac_c != 225 & l_nac_c != 221 & l_nac_c != 213
replace lugar_nacimiento = 3 if l_nac_c == 221 // USA
replace lugar_nacimiento = 6 if l_nac_c == 213 // Canada 
replace lugar_nacimiento = 4 if l_nac_c >= 400  &  l_nac_c < 500
replace lugar_nacimiento = 5 if l_nac_c >= 100  &  l_nac_c < 200 | l_nac_c >= 300 &  l_nac_c < 400 | l_nac_c >= 500


*** generar variable de interés, migrantes de latam (incluye Canadá)
* Dicotómica. Vale uno para los nacidos en guatemala y el resto de america (no incluye USA).  Vale cero para nacidos en México, USA, Europa, Africa y Asia.

generate latam = .
replace latam = 0 if lugar_nacimiento == 0 | lugar_nacimiento == 3 | lugar_nacimiento == 4 |lugar_nacimiento == 5 |lugar_nacimiento == 5
replace latam = 1 if lugar_nacimiento == 1  | lugar_nacimiento == 2

*generar regiones de la República.  Norte = 1, Centro = 2 y Sur = 3.

generate region = .
replace region = 1 if ent == 2 | ent == 3 | ent == 8 | ent == 10 | ent == 25 | ent == 26 | ent == 5 | ent == 19 | ent == 28

replace region = 2 if ent == 1 | ent == 6 | ent == 9 | ent == 11 | ent == 13 | ent == 14 | ent == 15 | ent == 16 | ent == 17  | ent == 18 | ent == 19 | ent == 21 | ent == 22 | ent == 24 | ent == 29 | ent == 30 | ent == 32

replace region = 3 if ent == 7 | ent == 12 | ent == 20 | ent == 4 | ent == 23 | ent == 27 | ent == 31

* generar variable de educación.
generate grado_edu = .
replace grado_edu = 1 if cs_p13_1 <= 2 | cs_p13_1 == 99 // primaria o menos más no sabe
replace grado_edu = 2 if cs_p13_1 == 3 // secundaria
replace grado_edu = 3 if cs_p13_1 == 4 | cs_p13_1 == 5 | cs_p13_1 == 6 // preparatoria, normal y carrera técnica
replace grado_edu = 4 if cs_p13_1 == 7 // profesional
replace grado_edu = 5 if cs_p13_1 == 8 | cs_p13_1 == 9 // maestria y doctorado
 

*tabular educación

tab grado_edu if latam == 1 [fweight = fac]
tab grado_edu if latam == 0 [fweight = fac]

*tabular educación para mayores de 18 años

tab grado_edu if latam == 1 & eda >= 18 [fweight = fac]
tab grado_edu if latam == 0 & eda >= 18 [fweight = fac]

******. Generamos Tabuladores *****

tabulate latam [fweight = fac]
tabulate latam region [fweight = fac], row column

tabulate latam sex [fweight = fac], row column

** Todas las regiones

* Latam
tab eda5c if latam ==1 [fweight = fac]
tab pos_ocu if latam ==1 [fweight = fac]
tab emp_ppal if latam ==1 [fweight = fac]
tab clase2 if latam ==1 [fweight = fac]

* Non Latam
tab eda5c if latam ==0 [fweight = fac]
tab pos_ocu if latam ==0 [fweight = fac]
tab emp_ppal if latam ==0 [fweight = fac]
tab clase2 if latam ==0 [fweight = fac]

* Mexicanos
tab eda5c if lugar_nacimiento ==0 [fweight = fac]
tab pos_ocu if lugar_nacimiento ==0 [fweight = fac]
tab emp_ppal if lugar_nacimiento ==0 [fweight = fac]
tab clase2 if lugar_nacimiento ==0 [fweight = fac]


*** Region Norte

* Latam
tab eda5c if latam ==1 & region == 1 [fweight = fac]
tab pos_ocu if latam ==1 & region == 1 [fweight = fac]
tab emp_ppal if latam ==1 & region == 1 [fweight = fac]
tab clase2 if latam ==1 & region == 1 [fweight = fac]

* Non Latam
tab eda5c if latam ==0 & region == 1 [fweight = fac]
tab pos_ocu if latam ==0 & region == 1 [fweight = fac]
tab emp_ppal if latam ==0 & region == 1 [fweight = fac]
tab clase2 if latam ==0 & region == 1 [fweight = fac]

* Mexicanos
tab eda5c if lugar_nacimiento ==0 & region == 1 [fweight = fac]
tab pos_ocu if lugar_nacimiento ==0 & region == 1 [fweight = fac]
tab emp_ppal if lugar_nacimiento ==0 & region == 1 [fweight = fac]
tab clase2 if lugar_nacimiento ==0 & region == 1 [fweight = fac]


*** Region Centro

* Latam
tab eda5c if latam ==1 & region == 2 [fweight = fac]
tab pos_ocu if latam ==1 & region == 2 [fweight = fac]
tab emp_ppal if latam ==1 & region == 2 [fweight = fac]
tab clase2 if latam ==1 & region == 2 [fweight = fac]

* Non Latam
tab eda5c if latam ==0 & region == 2 [fweight = fac]
tab pos_ocu if latam ==0 & region == 2 [fweight = fac]
tab emp_ppal if latam ==0 & region == 2 [fweight = fac]
tab clase2 if latam ==0 & region == 2 [fweight = fac]

* Mexicanos
tab eda5c if lugar_nacimiento ==0 & region == 2 [fweight = fac]
tab pos_ocu if lugar_nacimiento ==0 & region == 2 [fweight = fac]
tab emp_ppal if lugar_nacimiento ==0 & region == 2 [fweight = fac]
tab clase2 if lugar_nacimiento ==0 & region == 2 [fweight = fac]


*** Region Sur

* Latam
tab eda5c if latam ==1 & region == 3 [fweight = fac]
tab pos_ocu if latam ==1 & region == 3 [fweight = fac]
tab emp_ppal if latam ==1 & region == 3 [fweight = fac]
tab clase2 if latam ==1 & region == 3 [fweight = fac]

* Non Latam
tab eda5c if latam ==0 & region == 3 [fweight = fac]
tab pos_ocu if latam ==0 & region == 3 [fweight = fac]
tab emp_ppal if latam ==0 & region == 3 [fweight = fac]
tab clase2 if latam ==0 & region == 3 [fweight = fac]

* Mexicanos
tab eda5c if lugar_nacimiento ==0 & region == 3 [fweight = fac]
tab pos_ocu if lugar_nacimiento ==0 & region == 3 [fweight = fac]
tab emp_ppal if lugar_nacimiento ==0 & region == 3 [fweight = fac]
tab clase2 if lugar_nacimiento ==0 & region == 3 [fweight = fac]




log close



