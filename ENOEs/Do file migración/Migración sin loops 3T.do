




*** Tercer trimestre ***

*2021

clear

cd "/Users/sofiacorona/Desktop/Bases de Datos"

use "ENOE/SDEMT321.dta"

* Definir como survey *

*svyset upm [pweight = fac_tri], strata(est_d_tri) singleunit(certainty)
*svy: tabulate l_nac_c, count format("%17.0f")

tab l_nac_c if l_nac_c == 225 | l_nac_c == 221 [fweight = fac_tri] // guatemala y usa
tab l_nac_c if l_nac_c >= 200 & l_nac_c < 300 [fweight = fac_tri] // todos nacidos en america menos méxico
tab l_nac_c if l_nac_c == 213 [fweight = fac_tri] // canada



*2020

clear

cd "/Users/sofiacorona/Desktop/Bases de Datos"

use "ENOE/SDEMT320.dta"

* Definir como survey *

svyset upm [pweight = fac_tri], strata(est_d_tri) singleunit(certainty)

keep if l_nac_c == 200 | l_nac_c == 225 | l_nac_c == 221
 
svy: tabulate l_nac_c, count format("%17.0f")




*2019
clear

cd "/Users/sofiacorona/Desktop/Bases de Datos"

use "ENOE/base_sdemt319.dta"

* Definir como survey *

svyset UPM [pweight = FAC], strata(EST_D) singleunit(certainty)

keep if L_NAC_C == 200 | L_NAC_C == 225 | L_NAC_C == 221
 
svy: tabulate L_NAC_C, count format("%17.0f")

clear

cd "/Users/sofiacorona/Desktop/Bases de Datos"
*2018
use "ENOE/base_sdemt318.dta"

* Definir como survey *

svyset upm [pweight = fac], strata(est_d) singleunit(certainty)

keep if l_nac_c == 200 | l_nac_c == 225 | l_nac_c == 221
 
svy: tabulate l_nac_c, count format("%17.0f")

clear

cd "/Users/sofiacorona/Desktop/Bases de Datos"
*2017
use "ENOE/base_sdemt317.dta"

* Definir como survey *

svyset upm [pweight = fac], strata(est_d) singleunit(certainty)

keep if l_nac_c == 200 | l_nac_c == 225 | l_nac_c == 221
 
 
svy: tabulate l_nac_c, count format("%17.0f")


*2016

clear

cd "/Users/sofiacorona/Desktop/Bases de Datos"

use "ENOE/base_sdemt316.dta"

* Definir como survey *

svyset upm [pweight = fac], strata(est_d) singleunit(certainty)

keep if l_nac_c == 200 | l_nac_c == 225 | l_nac_c == 221
 
svy: tabulate l_nac_c, count format("%17.0f")


*2015

clear

cd "/Users/sofiacorona/Desktop/Bases de Datos"

use "ENOE/base_sdemt315.dta"

* Definir como survey *

svyset upm [pweight = fac], strata(est_d) singleunit(certainty)

keep if l_nac_c == 200 | l_nac_c == 225 | l_nac_c == 221
 
 
svy: tabulate l_nac_c, count format("%17.0f")


*2014
clear

cd "/Users/sofiacorona/Desktop/Bases de Datos"

use "ENOE/base_sdemt314.dta"

* Definir como survey *

svyset upm [pweight = fac], strata(est_d) singleunit(certainty)

keep if l_nac_c == 200 | l_nac_c == 225 | l_nac_c == 221
 
 
svy: tabulate l_nac_c, count format("%17.0f")

*2013

clear

cd "/Users/sofiacorona/Desktop/Bases de Datos"

use "ENOE/base_sdemt313.dta"

* Definir como survey *

svyset upm [pweight = fac], strata(est_d) singleunit(certainty)

keep if l_nac_c == 200 | l_nac_c == 225 | l_nac_c == 221
 
 
svy: tabulate l_nac_c, count format("%17.0f")


*2012

clear

cd "/Users/sofiacorona/Desktop/Bases de Datos"

use "ENOE/base_sdemt312.dta"

* Definir como survey *

svyset upm [pweight = fac], strata(est_d) singleunit(certainty)

keep if l_nac_c == 200 | l_nac_c == 225 | l_nac_c == 221
 
 
svy: tabulate l_nac_c, count format("%17.0f")


*2011

clear

cd "/Users/sofiacorona/Desktop/Bases de Datos"

use "ENOE/base_sdemt311.dta"

* Definir como survey *

svyset upm [pweight = fac], strata(est_d) singleunit(certainty)

keep if l_nac_c == 200 | l_nac_c == 225 | l_nac_c == 221 | l_nac_c == 201
  
svy: tabulate l_nac_c, count format("%17.0f")


*2010

clear

cd "/Users/sofiacorona/Desktop/Bases de Datos"

use "ENOE/base_sdemt310.dta"

* Definir como survey *

svyset upm [pweight = fac], strata(est_d) singleunit(certainty)

keep if l_nac_c == 200 | l_nac_c == 225 | l_nac_c == 221 | l_nac_c == 201

svy: tabulate l_nac_c, count format("%17.0f")
 
*2009

clear

cd "/Users/sofiacorona/Desktop/Bases de Datos"

use "ENOE/base_sdemt309.dta"

* Definir como survey *

svyset upm [pweight = fac], strata(est_d) singleunit(certainty)

keep if l_nac_c == 200 | l_nac_c == 225 | l_nac_c == 221 | l_nac_c == 201

svy: tabulate l_nac_c, count format("%17.0f")
 
*2008

clear

cd "/Users/sofiacorona/Desktop/Bases de Datos"

use "ENOE/base_sdemt308.dta"

* Definir como survey *

svyset upm [pweight = fac], strata(est_d) singleunit(certainty)

keep if l_nac_c == 200 | l_nac_c == 225 | l_nac_c == 221 | l_nac_c == 201

svy: tabulate l_nac_c, count format("%17.0f")
 
*2007

clear

cd "/Users/sofiacorona/Desktop/Bases de Datos"

use "ENOE/base_sdemt307.dta"

* Definir como survey *

svyset upm [pweight = fac], strata(est_d) singleunit(certainty)

keep if l_nac_c == 200 | l_nac_c == 225 | l_nac_c == 221 | l_nac_c == 201

svy: tabulate l_nac_c, count format("%17.0f") 

*2006

clear

cd "/Users/sofiacorona/Desktop/Bases de Datos"

use "ENOE/base_sdemt306.dta"

* Definir como survey *

svyset upm [pweight = fac], strata(est_d) singleunit(certainty)

keep if l_nac_c == 200 | l_nac_c == 225 | l_nac_c == 221 | l_nac_c == 201

svy: tabulate l_nac_c, count format("%17.0f") 

*2005

clear

cd "/Users/sofiacorona/Desktop/Bases de Datos"

use "ENOE/base_sdemt305.dta"

* Definir como survey *

svyset upm [pweight = fac], strata(est_d) singleunit(certainty)

keep if l_nac_c == 200 | l_nac_c == 225 | l_nac_c == 221 | l_nac_c == 201

svy: tabulate l_nac_c, count format("%17.0f") 
      




















