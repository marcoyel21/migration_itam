*Grafica Uno


** Archivo para 4Q21
import excel "/Users/sofiacorona/Library/Mobile Documents/com~apple~CloudDocs/AAA Escritorio - MacBook Pro de Sofia/000 Migración (compu Sofia)/1 Presentación 24 Febrero/Grafica 24feb 4Q21.xlsx", sheet("Hoja1") firstrow clear


** Archivo para 1Q20
clear
import excel "/Users/sofiacorona/Library/Mobile Documents/com~apple~CloudDocs/AAA Escritorio - MacBook Pro de Sofia/000 Migración (compu Sofia)/1 Presentación 24 Febrero/Grafica 24feb 1Q20.xlsx", sheet("Hoja1") firstrow clear

**generar quarter
gen qdate = qofd(Fecha)
format qdate %tq
tsset qdate, quarterly

*otra opción
gen a = Guatemala/1000 
gen b = (Guatemala + Otrospaisesamerica)/1000 
twoway bar a qdate || rbar a b qdate, scheme(gg_cividis) title("Migrats from Latin America in Mexico") legend(label(1 Guatemala) label(2 Rest of Latin America) position(6)) xtitle("")

*graph save "Graph" "/Users/sofiacorona/Desktop/Migracion grafica 1.gph", replace
