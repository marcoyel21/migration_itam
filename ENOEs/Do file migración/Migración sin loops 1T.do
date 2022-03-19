**MIGRACION

**Dofile para obtener nacidos en Guatemala, otrros paises de america y EUA


*** Primer trimestre ***

*2021

clear

cd "/Users/sofiacorona/Desktop/Bases de Datos"

use "ENOE/SDEMT121.dta"

* Definir como survey *

svyset upm [pweight = fac_tri], strata(est_d_tri) singleunit(certainty)

keep if l_nac_c == 200 | l_nac_c == 225 | l_nac_c == 221
 
svy: tabulate l_nac_c, count format("%17.0f")


*2020

clear

cd "/Users/sofiacorona/Desktop/Bases de Datos"

use "ENOE/SDEMT120.dta"

* Definir como survey *

svyset upm [pweight = fac], strata(est_d) singleunit(certainty)

keep if l_nac_c == 200 | l_nac_c == 225 | l_nac_c == 221
 
svy: tabulate l_nac_c, count format("%17.0f")


*2019

clear

cd "/Users/sofiacorona/Desktop/Bases de Datos"

use "ENOE/base_sdemt119.dta"

* Definir como survey *

svyset upm [pweight = fac], strata(est_d) singleunit(certainty)

keep if l_nac_c == 200 | l_nac_c == 225 | l_nac_c == 221
 
svy: tabulate l_nac_c, count format("%17.0f")


*2018
clear

cd "/Users/sofiacorona/Desktop/Bases de Datos"

use "ENOE/base_sdemt118.dta"

* Definir como survey *

svyset upm [pweight = fac], strata(est_d) singleunit(certainty)

keep if l_nac_c == 200 | l_nac_c == 225 | l_nac_c == 221
 
svy: tabulate l_nac_c, count format("%17.0f")


*2017
clear

cd "/Users/sofiacorona/Desktop/Bases de Datos"

use "ENOE/base_sdemt117.dta"

* Definir como survey *

svyset upm [pweight = fac], strata(est_d) singleunit(certainty)

keep if l_nac_c == 200 | l_nac_c == 225 | l_nac_c == 221
 
 
svy: tabulate l_nac_c, count format("%17.0f")


*2016

clear

cd "/Users/sofiacorona/Desktop/Bases de Datos"

use "ENOE/base_sdemt116.dta"

* Definir como survey *

svyset upm [pweight = fac], strata(est_d) singleunit(certainty)

keep if l_nac_c == 200 | l_nac_c == 225 | l_nac_c == 221
 
svy: tabulate l_nac_c, count format("%17.0f")


*2015

clear

cd "/Users/sofiacorona/Desktop/Bases de Datos"

use "ENOE/base_sdemt115.dta"

* Definir como survey *

svyset upm [pweight = fac], strata(est_d) singleunit(certainty)

keep if l_nac_c == 200 | l_nac_c == 225 | l_nac_c == 221
 
 
svy: tabulate l_nac_c, count format("%17.0f")


*2014
clear

cd "/Users/sofiacorona/Desktop/Bases de Datos"

use "ENOE/base_sdemt114.dta"

* Definir como survey *

svyset upm [pweight = fac], strata(est_d) singleunit(certainty)

keep if l_nac_c == 200 | l_nac_c == 225 | l_nac_c == 221
 
 
svy: tabulate l_nac_c, count format("%17.0f")

*2013

clear

cd "/Users/sofiacorona/Desktop/Bases de Datos"

use "ENOE/base_sdemt113.dta"

* Definir como survey *

svyset upm [pweight = fac], strata(est_d) singleunit(certainty)

keep if l_nac_c == 200 | l_nac_c == 225 | l_nac_c == 221
 
 
svy: tabulate l_nac_c, count format("%17.0f")


*2012

clear

cd "/Users/sofiacorona/Desktop/Bases de Datos"

use "ENOE/base_sdemt112.dta"

* Definir como survey *

svyset upm [pweight = fac], strata(est_d) singleunit(certainty)

keep if l_nac_c == 200 | l_nac_c == 225 | l_nac_c == 221 | l_nac_c == 201
 
 
svy: tabulate l_nac_c, count format("%17.0f")


*2011

clear

cd "/Users/sofiacorona/Desktop/Bases de Datos"

use "ENOE/base_sdemt111.dta"

* Definir como survey *

svyset upm [pweight = fac], strata(est_d) singleunit(certainty)

keep if l_nac_c == 200 | l_nac_c == 225 | l_nac_c == 221 | l_nac_c == 201
  
svy: tabulate l_nac_c, count format("%17.0f")


*2010

clear

cd "/Users/sofiacorona/Desktop/Bases de Datos"

use "ENOE/base_sdemt110.dta"

* Definir como survey *

svyset upm [pweight = fac], strata(est_d) singleunit(certainty)

keep if l_nac_c == 200 | l_nac_c == 225 | l_nac_c == 221 | l_nac_c == 201

svy: tabulate l_nac_c, count format("%17.0f")
 
*2009

clear

cd "/Users/sofiacorona/Desktop/Bases de Datos"

use "ENOE/base_sdemt109.dta"

* Definir como survey *

svyset upm [pweight = fac], strata(est_d) singleunit(certainty)

keep if l_nac_c == 200 | l_nac_c == 225 | l_nac_c == 221 | l_nac_c == 201

svy: tabulate l_nac_c, count format("%17.0f")
 
*2008

clear

cd "/Users/sofiacorona/Desktop/Bases de Datos"

use "ENOE/base_sdemt108.dta"

* Definir como survey *

svyset upm [pweight = fac], strata(est_d) singleunit(certainty)

keep if l_nac_c == 200 | l_nac_c == 225 | l_nac_c == 221 | l_nac_c == 201

svy: tabulate l_nac_c, count format("%17.0f")
 
*2007

clear

cd "/Users/sofiacorona/Desktop/Bases de Datos"

use "ENOE/base_sdemt107.dta"

* Definir como survey *

svyset upm [pweight = fac], strata(est_d) singleunit(certainty)

keep if l_nac_c == 200 | l_nac_c == 225 | l_nac_c == 221 | l_nac_c == 201

svy: tabulate l_nac_c, count format("%17.0f") 

*2006

clear

cd "/Users/sofiacorona/Desktop/Bases de Datos"

use "ENOE/base_sdemt106.dta"

* Definir como survey *

svyset upm [pweight = fac], strata(est_d) singleunit(certainty)

keep if l_nac_c == 200 | l_nac_c == 225 | l_nac_c == 221 | l_nac_c == 201

svy: tabulate l_nac_c, count format("%17.0f") 

*2005

clear

cd "/Users/sofiacorona/Desktop/Bases de Datos"

use "ENOE/base_sdemt105.dta"

* Definir como survey *

svyset upm [pweight = fac], strata(est_d) singleunit(certainty)

keep if l_nac_c == 200 | l_nac_c == 225 | l_nac_c == 221 | l_nac_c == 201

svy: tabulate l_nac_c, count format("%17.0f") 
      




















