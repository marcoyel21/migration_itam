




*** Segundo trimestre ***

*2021

clear

cd "/Users/sofiacorona/Desktop/Bases de Datos"

use "ENOE/SDEMT221.dta"

* Definir como survey *

rename *, lower

svyset upm [pweight = fac_tri], strata(est_d_tri) singleunit(certainty)

keep if l_nac_c == 200 | l_nac_c == 225 | l_nac_c == 221
 
svy: tabulate l_nac_c, count format("%17.0f")


/*2020 ****  No hay información por pandemia,  fue la ETOE

clear

cd "/Users/sofiacorona/Desktop/Bases de Datos"

use "ENOE/SDEMT220.dta"

* Definir como survey *

svyset upm [pweight = fac], strata(est_d) singleunit(certainty)

keep if l_nac_c == 200 | l_nac_c == 225 | l_nac_c == 221
 
svy: tabulate l_nac_c, count format("%17.0f")*/



*2019

clear

cd "/Users/sofiacorona/Desktop/Bases de Datos"

use "ENOE/base_sdemt219.dta"

* Definir como survey *

svyset upm [pweight = fac], strata(est_d) singleunit(certainty)

keep if l_nac_c == 200 | l_nac_c == 225 | l_nac_c == 221
 
svy: tabulate l_nac_c, count format("%17.0f")

clear

cd "/Users/sofiacorona/Desktop/Bases de Datos"
*2018
use "ENOE/base_sdemt218.dta"

* Definir como survey *

svyset upm [pweight = fac], strata(est_d) singleunit(certainty)

keep if l_nac_c == 200 | l_nac_c == 225 | l_nac_c == 221
 
svy: tabulate l_nac_c, count format("%17.0f")

clear

cd "/Users/sofiacorona/Desktop/Bases de Datos"
*2017
use "ENOE/base_sdemt217.dta"

* Definir como survey *

svyset upm [pweight = fac], strata(est_d) singleunit(certainty)

keep if l_nac_c == 200 | l_nac_c == 225 | l_nac_c == 221
 
 
svy: tabulate l_nac_c, count format("%17.0f")


*2016

clear

cd "/Users/sofiacorona/Desktop/Bases de Datos"

use "ENOE/base_sdemt216.dta"

* Definir como survey *

svyset upm [pweight = fac], strata(est_d) singleunit(certainty)

keep if l_nac_c == 200 | l_nac_c == 225 | l_nac_c == 221
 
svy: tabulate l_nac_c, count format("%17.0f")


*2015

clear

cd "/Users/sofiacorona/Desktop/Bases de Datos"

use "ENOE/base_sdemt215.dta"

* Definir como survey *

svyset upm [pweight = fac], strata(est_d) singleunit(certainty)

keep if l_nac_c == 200 | l_nac_c == 225 | l_nac_c == 221
 
 
svy: tabulate l_nac_c, count format("%17.0f")


*2014
clear

cd "/Users/sofiacorona/Desktop/Bases de Datos"

use "ENOE/base_sdemt214.dta"

* Definir como survey *

svyset upm [pweight = fac], strata(est_d) singleunit(certainty)

keep if l_nac_c == 200 | l_nac_c == 225 | l_nac_c == 221
 
 
svy: tabulate l_nac_c, count format("%17.0f")

*2013

clear

cd "/Users/sofiacorona/Desktop/Bases de Datos"

use "ENOE/base_sdemt213.dta"

* Definir como survey *

svyset upm [pweight = fac], strata(est_d) singleunit(certainty)

keep if l_nac_c == 200 | l_nac_c == 225 | l_nac_c == 221
 
 
svy: tabulate l_nac_c, count format("%17.0f")


*2012

clear

cd "/Users/sofiacorona/Desktop/Bases de Datos"

use "ENOE/base_sdemt212.dta"

* Definir como survey *

svyset upm [pweight = fac], strata(est_d) singleunit(certainty)

keep if l_nac_c == 200 | l_nac_c == 225 | l_nac_c == 221 | l_nac_c == 201
 
 
svy: tabulate l_nac_c, count format("%17.0f")


*2011

clear

cd "/Users/sofiacorona/Desktop/Bases de Datos"

use "ENOE/base_sdemt211.dta"

* Definir como survey *

svyset upm [pweight = fac], strata(est_d) singleunit(certainty)

keep if l_nac_c == 200 | l_nac_c == 225 | l_nac_c == 221 | l_nac_c == 201
  
svy: tabulate l_nac_c, count format("%17.0f")


*2010

clear

cd "/Users/sofiacorona/Desktop/Bases de Datos"

use "ENOE/base_sdemt210.dta"

* Definir como survey *

svyset upm [pweight = fac], strata(est_d) singleunit(certainty)

keep if l_nac_c == 200 | l_nac_c == 225 | l_nac_c == 221 | l_nac_c == 201

svy: tabulate l_nac_c, count format("%17.0f")
 
*2009

clear

cd "/Users/sofiacorona/Desktop/Bases de Datos"

use "ENOE/base_sdemt209.dta"

* Definir como survey *

svyset upm [pweight = fac], strata(est_d) singleunit(certainty)

keep if l_nac_c == 200 | l_nac_c == 225 | l_nac_c == 221 | l_nac_c == 201

svy: tabulate l_nac_c, count format("%17.0f")
 
*2008

clear

cd "/Users/sofiacorona/Desktop/Bases de Datos"

use "ENOE/base_sdemt208.dta"

* Definir como survey *

svyset upm [pweight = fac], strata(est_d) singleunit(certainty)

keep if l_nac_c == 200 | l_nac_c == 225 | l_nac_c == 221 | l_nac_c == 201

svy: tabulate l_nac_c, count format("%17.0f")
 
*2007

clear

cd "/Users/sofiacorona/Desktop/Bases de Datos"

use "ENOE/base_sdemt207.dta"

* Definir como survey *

svyset upm [pweight = fac], strata(est_d) singleunit(certainty)

keep if l_nac_c == 200 | l_nac_c == 225 | l_nac_c == 221 | l_nac_c == 201

svy: tabulate l_nac_c, count format("%17.0f") 

*2006

clear

cd "/Users/sofiacorona/Desktop/Bases de Datos"

use "ENOE/base_sdemt206.dta"

* Definir como survey *

svyset upm [pweight = fac], strata(est_d) singleunit(certainty)

keep if l_nac_c == 200 | l_nac_c == 225 | l_nac_c == 221 | l_nac_c == 201

svy: tabulate l_nac_c, count format("%17.0f") 

*2005

clear

cd "/Users/sofiacorona/Desktop/Bases de Datos"

use "ENOE/base_sdemt205.dta"

* Definir como survey *

svyset upm [pweight = fac], strata(est_d) singleunit(certainty)

keep if l_nac_c == 200 | l_nac_c == 225 | l_nac_c == 221 | l_nac_c == 201

svy: tabulate l_nac_c, count format("%17.0f") 
      




















