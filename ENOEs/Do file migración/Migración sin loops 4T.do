
clear

cd "/Users/sofiacorona/Desktop/Bases de Datos"

* ojo usar en lugar de svy, tab ------- [fweight = FAC]
* ojo usar en lugar de svy, regress --------  [aweight = FAC]

*** Cuarto trimestre ***

*2021

clear

cd "/Users/sofiacorona/Desktop/Bases de Datos"

use "ENOE/SDEMT421.dta"

* Definir como survey *

*svyset upm [pweight = fac_tri], strata(est_d_tri) singleunit(certainty)
*svy: tabulate l_nac_c, count format("%17.0f")

tab l_nac_c if l_nac_c == 225 | l_nac_c == 221 [fweight = fac_tri]
tab l_nac_c if l_nac_c >= 200 & l_nac_c < 300 [fweight = fac_tri]
tab l_nac_c if l_nac_c == 213 [fweight = fac_tri]


*2020

clear

cd "/Users/sofiacorona/Desktop/Bases de Datos"

use "ENOE/SDEMT420.dta"

* Definir como survey *

svyset upm [pweight = fac_tri], strata(est_d_tri) singleunit(certainty)

keep if l_nac_c == 200 | l_nac_c == 225 | l_nac_c == 221
 
svy: tabulate l_nac_c, count format("%17.0f")


*2019
clear

cd "/Users/sofiacorona/Desktop/Bases de Datos"

use "ENOE/base_sdemt419.dta"

* Definir como survey *

svyset UPM [pweight = FAC], strata(EST_D) singleunit(certainty)

keep if L_NAC_C == 200 | L_NAC_C == 225 | L_NAC_C == 221
 
svy: tabulate L_NAC_C, count format("%17.0f")


*2018
use "ENOE/base_sdemt418.dta"

* Definir como survey *

svyset upm [pweight = fac], strata(est_d) singleunit(certainty)

keep if l_nac_c == 200 | l_nac_c == 225 | l_nac_c == 221
 
svy: tabulate l_nac_c, count format("%17.0f")


*2017
use "ENOE/base_sdemt417.dta"

* Definir como survey *

svyset upm [pweight = fac], strata(est_d) singleunit(certainty)

keep if l_nac_c == 200 | l_nac_c == 225 | l_nac_c == 221
 
 
svy: tabulate l_nac_c, count format("%17.0f")


*2016

clear

cd "/Users/sofiacorona/Desktop/Bases de Datos"

use "ENOE/base_sdemt416.dta"

* Definir como survey *

svyset upm [pweight = fac], strata(est_d) singleunit(certainty)

keep if l_nac_c == 200 | l_nac_c == 225 | l_nac_c == 221
 
svy: tabulate l_nac_c, count format("%17.0f")


*2015

clear

cd "/Users/sofiacorona/Desktop/Bases de Datos"

use "ENOE/base_sdemt415.dta"

* Definir como survey *

svyset upm [pweight = fac], strata(est_d) singleunit(certainty)

keep if l_nac_c == 200 | l_nac_c == 225 | l_nac_c == 221
 
 
svy: tabulate l_nac_c, count format("%17.0f")


*2014
clear

cd "/Users/sofiacorona/Desktop/Bases de Datos"

use "ENOE/base_sdemt414.dta"

* Definir como survey *

svyset upm [pweight = fac], strata(est_d) singleunit(certainty)

keep if l_nac_c == 200 | l_nac_c == 225 | l_nac_c == 221
 
 
svy: tabulate l_nac_c, count format("%17.0f")

*2013

clear

cd "/Users/sofiacorona/Desktop/Bases de Datos"

use "ENOE/base_sdemt413.dta"

* Definir como survey *

svyset upm [pweight = fac], strata(est_d) singleunit(certainty)

keep if l_nac_c == 200 | l_nac_c == 225 | l_nac_c == 221
 
 
svy: tabulate l_nac_c, count format("%17.0f")


*2012

clear

cd "/Users/sofiacorona/Desktop/Bases de Datos"

use "ENOE/base_sdemt412.dta"

* Definir como survey *

svyset upm [pweight = fac], strata(est_d) singleunit(certainty)

keep if l_nac_c == 200 | l_nac_c == 225 | l_nac_c == 221
 
 
svy: tabulate l_nac_c, count format("%17.0f")


*2011

clear

cd "/Users/sofiacorona/Desktop/Bases de Datos"

use "ENOE/base_sdemt411.dta"

* Definir como survey *

svyset upm [pweight = fac], strata(est_d) singleunit(certainty)

keep if l_nac_c == 200 | l_nac_c == 225 | l_nac_c == 221 | l_nac_c == 201
  
svy: tabulate l_nac_c, count format("%17.0f")


*2010

clear

cd "/Users/sofiacorona/Desktop/Bases de Datos"

use "ENOE/base_sdemt410.dta"

* Definir como survey *

svyset upm [pweight = fac], strata(est_d) singleunit(certainty)

keep if l_nac_c == 200 | l_nac_c == 225 | l_nac_c == 221 | l_nac_c == 201

svy: tabulate l_nac_c, count format("%17.0f")
 
*2009

clear

cd "/Users/sofiacorona/Desktop/Bases de Datos"

use "ENOE/base_sdemt409.dta"

* Definir como survey *

svyset upm [pweight = fac], strata(est_d) singleunit(certainty)

keep if l_nac_c == 200 | l_nac_c == 225 | l_nac_c == 221 | l_nac_c == 201

svy: tabulate l_nac_c, count format("%17.0f")
 
*2008

clear

cd "/Users/sofiacorona/Desktop/Bases de Datos"

use "ENOE/base_sdemt408.dta"

* Definir como survey *

svyset upm [pweight = fac], strata(est_d) singleunit(certainty)

keep if l_nac_c == 200 | l_nac_c == 225 | l_nac_c == 221 | l_nac_c == 201

svy: tabulate l_nac_c, count format("%17.0f")
 
*2007

clear

cd "/Users/sofiacorona/Desktop/Bases de Datos"

use "ENOE/base_sdemt407.dta"

* Definir como survey *

svyset upm [pweight = fac], strata(est_d) singleunit(certainty)

keep if l_nac_c == 200 | l_nac_c == 225 | l_nac_c == 221 | l_nac_c == 201

svy: tabulate l_nac_c, count format("%17.0f") 

*2006

clear

cd "/Users/sofiacorona/Desktop/Bases de Datos"

use "ENOE/base_sdemt406.dta"

* Definir como survey *

svyset upm [pweight = fac], strata(est_d) singleunit(certainty)

keep if l_nac_c == 200 | l_nac_c == 225 | l_nac_c == 221 | l_nac_c == 201

svy: tabulate l_nac_c, count format("%17.0f") 

*2005

clear

cd "/Users/sofiacorona/Desktop/Bases de Datos"

use "ENOE/base_sdemt405.dta"

* Definir como survey *

svyset upm [pweight = fac], strata(est_d) singleunit(certainty)

keep if l_nac_c == 200 | l_nac_c == 225 | l_nac_c == 221 | l_nac_c == 201

svy: tabulate l_nac_c, count format("%17.0f") 
      




















