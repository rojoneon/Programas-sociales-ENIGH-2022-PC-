*Titulo: 				Análisis de programas sociales, incidencia y desigualdad
*Autor: 				Máximo Ernesto Jaramillo Molina
*Fuentes:				ENIGH 2022 y anteriores
*Fecha de finalización: 01 deAgosto de 2023

 
clear all
gl ruta=       	"~/Documents/" // Ruta donde tengas todas tus carpeta de ENIGH


***********************************2022
gl ruta22=       	"~/Documents/2022/bases/" // Ruta donde tengas todas tus bases 2022
use "$ruta22/Concen2022.dta", clear

*Análisis de datos de desigualdad
count
*90,102


*0. Preparación previa (crear deciles)

*Generar deciles y veintiles del hogar
xtile decil = ing_cor   [w=factor], nq(10)
xtile veintil = ing_cor   [w=factor], nq(20)

*Generar deciles y veintiles del hogar
gen ing_cor_pc=ing_cor/tot_integ
xtile decil_pc = ing_cor_pc   [w=factor], nq(10)
xtile veintil_pc = ing_cor_pc   [w=factor], nq(20)

*Generar deciles y veintiles del poblacion
gen factor_pob=factor*tot_integ
xtile decil_pc_pob = ing_cor_pc   [w=factor_pob], nq(10)
xtile veintil_pc_pob = ing_cor_pc   [w=factor_pob], nq(20)


*1. Cobertura

*Generar variable que de cuenta del número de hogares que reciben PS 
gen prog_soc_count=0
replace prog_soc_count=1 if bene_gob>0

*Tabular porcentaje de hogares que reciben programas sociales por decil
tabstat prog_soc_count [w=factor]

tabstat prog_soc_count [w=factor], by(decil) // Cifras mostradas en gráfica de artículo Esquivel
tabstat prog_soc_count [w=factor], by(decil_pc) // Cifras mostradas en reporte INDESIG (Jaramillo)
tabstat prog_soc_count [w=factor], by(decil_pc_pob)

svyset upm, strata(est_dis) weight(factor) vce(linearized) singleunit(missing)
svy linearized : mean prog_soc_count, over(decil)
svy linearized : mean prog_soc_count, over(decil_pc)


*2. Monto promedio transferido

*Monto promedio con todos los hogares por decil como divisor
tabstat bene_gob [w=factor], by(decil) // Cifras mostradas en gráfica de artículo Esquivel
tabstat bene_gob [w=factor], by(decil_pc) 
tabstat bene_gob [w=factor], by(decil_pc_pob)

*Monto promedio sólo con hogares beneficiarios por decil como divisor
tabstat bene_gob [w=factor] if bene_gob>0, by(decil) 
tabstat bene_gob [w=factor] if bene_gob>0, by(decil_pc) // Cifras mostradas en reporte INDESIG (Jaramillo), luego de dividir monto trimestral entre 3 para hacerlo mensual
tabstat bene_gob [w=factor] if bene_gob>0, by(decil_pc_pob)


*3. Distribución del total de recursos

*Estimar directamente la suma total de la masa monetaria, según deciles
tabstat bene_gob [w=factor], s(sum) by(decil) format(%16.2fc) // Cifras mostradas en gráfica de artículo Esquivel
tabstat bene_gob [w=factor], s(sum) by(decil_pc) format(%16.2fc) // Cifras mostradas en reporte INDESIG (Jaramillo)
tabstat bene_gob [w=factor], s(sum) by(decil_pc_pob) format(%16.2fc)

svy linearized : total bene_gob,
svy linearized : total bene_gob, over(decil) 
svy linearized : total bene_gob, over(decil_pc)

tabstat ing_cor  jubilacion remesas  bene_gob [w=factor], s(sum) by(decil_pc) format(%20.2fc) 

*Coeficiente de concentración de los programas sociales del gobierno
sgini ing_cor_pc [w=factor] 
sgini bene_gob [w=factor], sortvar(ing_cor)
sgini bene_gob [w=factor], sortvar(ing_cor_pc)
sgini bene_gob [w=factor_pob], sortvar(ing_cor_pc)

*4 Impacto en el ingresos

gen ing_cor_sin_bene_gob = ing_cor - bene_gob
*Calcular la suma total de los ingresos corrientes, los beneficios gubernamentales, y sacar el aumento por decil 
tabstat ing_cor bene_gob ing_cor_sin_bene_gob [w=factor], s(sum) by(decil) format(%24.2fc) // Cifras mostradas en gráfica de artículo Esquivel
tabstat ing_cor bene_gob ing_cor_sin_bene_gob [w=factor], s(sum) by(decil_pc) format(%24.2fc) 

*Generar incidencia de programas sociales sobre ingreso corriente total
gen prog_soc_inci=bene_gob/ ing_cor
*Tabular la incidencia en el ingreso corriente, con todos los hogares por decil como divisor
tabstat prog_soc_inci [w=factor], s(mean) by(decil) format(%16.5fc) 
tabstat prog_soc_inci [w=factor], s(mean) by(decil_pc) format(%16.5fc)
*Tabular la incidencia en el ingreso corriente, con todos los hogares por decil como divisor
tabstat prog_soc_inci [w=factor], s(mean) by(decil) format(%16.5fc) 
tabstat prog_soc_inci [w=factor] if bene_gob>0, by(decil_pc) // Cifras mostradas en reporte INDESIG (Jaramillo)





***********************************2020
gl ruta20=       	"~/Documents/2020/bases/" // Ruta donde tengas todas tus bases 2020

use "$ruta20/Concen2020.dta", clear 


*Análisis de datos de desigualdad
count
*89,006


*0. Preparación previa (crear deciles)

*Generar deciles y veintiles del hogar
xtile decil = ing_cor   [w=factor], nq(10)
xtile veintil = ing_cor   [w=factor], nq(20)

*Generar deciles y veintiles del hogar
gen ing_cor_pc=ing_cor/tot_integ
xtile decil_pc = ing_cor_pc   [w=factor], nq(10)
xtile veintil_pc = ing_cor_pc   [w=factor], nq(20)

*Generar deciles y veintiles del poblacion
gen factor_pob=factor*tot_integ
xtile decil_pc_pob = ing_cor_pc   [w=factor_pob], nq(10)
xtile veintil_pc_pob = ing_cor_pc   [w=factor_pob], nq(20)


*1. Cobertura

*Generar variable que de cuenta del número de hogares que reciben PS 
gen prog_soc_count=0
replace prog_soc_count=1 if bene_gob>0

*Tabular porcentaje de hogares que reciben programas sociales por decil
tabstat prog_soc_count [w=factor]

tabstat prog_soc_count [w=factor], by(decil) // Cifras mostradas en gráfica de artículo Esquivel
tabstat prog_soc_count [w=factor], by(decil_pc) // Cifras mostradas en reporte INDESIG (Jaramillo)
tabstat prog_soc_count [w=factor], by(decil_pc_pob)

svyset upm, strata(est_dis) weight(factor) vce(linearized) singleunit(missing)
svy linearized : mean prog_soc_count, over(decil)
svy linearized : mean prog_soc_count, over(decil_pc)


*2. Monto promedio transferido

*Monto promedio con todos los hogares por decil como divisor
tabstat bene_gob [w=factor], by(decil) // Cifras mostradas en gráfica de artículo Esquivel
tabstat bene_gob [w=factor], by(decil_pc) 
tabstat bene_gob [w=factor], by(decil_pc_pob)

*Monto promedio sólo con hogares beneficiarios por decil como divisor
tabstat bene_gob [w=factor] if bene_gob>0, by(decil) 
tabstat bene_gob [w=factor] if bene_gob>0, by(decil_pc) // Cifras mostradas en reporte INDESIG (Jaramillo), luego de dividir monto trimestral entre 3 para hacerlo mensual
tabstat bene_gob [w=factor] if bene_gob>0, by(decil_pc_pob)


*3. Distribución del total de recursos

*Estimar directamente la suma total de la masa monetaria, según deciles
tabstat bene_gob [w=factor], s(sum) by(decil) format(%16.2fc) // Cifras mostradas en gráfica de artículo Esquivel
tabstat bene_gob [w=factor], s(sum) by(decil_pc) format(%16.2fc) // Cifras mostradas en reporte INDESIG (Jaramillo)
tabstat bene_gob [w=factor], s(sum) by(decil_pc_pob) format(%16.2fc)

svy linearized : total bene_gob,
svy linearized : total bene_gob, over(decil) 
svy linearized : total bene_gob, over(decil_pc)

tabstat ing_cor  jubilacion remesas  bene_gob [w=factor], s(sum) by(decil_pc) format(%20.2fc) 

*Coeficiente de concentración de los programas sociales del gobierno
sgini ing_cor_pc [w=factor] 
sgini bene_gob [w=factor], sortvar(ing_cor_pc)

*4 Impacto en el ingresos

gen ing_cor_sin_bene_gob = ing_cor - bene_gob
*Calcular la suma total de los ingresos corrientes, los beneficios gubernamentales, y sacar el aumento por decil 
tabstat ing_cor bene_gob ing_cor_sin_bene_gob [w=factor], s(sum) by(decil) format(%24.2fc) // Cifras mostradas en gráfica de artículo Esquivel
tabstat ing_cor bene_gob ing_cor_sin_bene_gob [w=factor], s(sum) by(decil_pc) format(%24.2fc) 

*Generar incidencia de programas sociales sobre ingreso corriente total
gen prog_soc_inci=bene_gob/ ing_cor
*Tabular la incidencia en el ingreso corriente, con todos los hogares por decil como divisor
tabstat prog_soc_inci [w=factor], s(mean) by(decil) format(%16.5fc) 
tabstat prog_soc_inci [w=factor], s(mean) by(decil_pc) format(%16.5fc)
*Tabular la incidencia en el ingreso corriente, con todos los hogares por decil como divisor
tabstat prog_soc_inci [w=factor], s(mean) by(decil) format(%16.5fc) 
tabstat prog_soc_inci [w=factor] if bene_gob>0, by(decil_pc) // Cifras mostradas en reporte INDESIG (Jaramillo)





***********************************2018

gl ruta18=       	"$ruta/2018/bases"
use "$ruta18/Concen2018.dta", clear 


*Análisis de datos de desigualdad
count
*74,647


*0. Preparación previa (crear deciles)

*Generar deciles y veintiles del hogar
xtile decil = ing_cor   [w=factor], nq(10)
xtile veintil = ing_cor   [w=factor], nq(20)

*Generar deciles y veintiles del hogar
gen ing_cor_pc=ing_cor/tot_integ
xtile decil_pc = ing_cor_pc   [w=factor], nq(10)
xtile veintil_pc = ing_cor_pc   [w=factor], nq(20)

*Generar deciles y veintiles del poblacion
gen factor_pob=factor*tot_integ
xtile decil_pc_pob = ing_cor_pc   [w=factor_pob], nq(10)
xtile veintil_pc_pob = ing_cor_pc   [w=factor_pob], nq(20)


*1. Cobertura

*Generar variable que de cuenta del número de hogares que reciben PS 
gen prog_soc_count=0
replace prog_soc_count=1 if bene_gob>0

*Tabular porcentaje de hogares que reciben programas sociales por decil
tabstat prog_soc_count [w=factor]

tabstat prog_soc_count [w=factor], by(decil) // Cifras mostradas en gráfica de artículo Esquivel
tabstat prog_soc_count [w=factor], by(decil_pc) // Cifras mostradas en reporte INDESIG (Jaramillo)
tabstat prog_soc_count [w=factor], by(decil_pc_pob)

svyset upm, strata(est_dis) weight(factor) vce(linearized) singleunit(missing)
svy linearized : mean prog_soc_count, over(decil)
svy linearized : mean prog_soc_count, over(decil_pc)


*2. Monto promedio transferido

*Monto promedio con todos los hogares por decil como divisor
tabstat bene_gob [w=factor], by(decil) // Cifras mostradas en gráfica de artículo Esquivel
tabstat bene_gob [w=factor], by(decil_pc) 
tabstat bene_gob [w=factor], by(decil_pc_pob)

*Monto promedio sólo con hogares beneficiarios por decil como divisor
tabstat bene_gob [w=factor] if bene_gob>0, by(decil) 
tabstat bene_gob [w=factor] if bene_gob>0, by(decil_pc) // Cifras mostradas en reporte INDESIG (Jaramillo), luego de dividir monto trimestral entre 3 para hacerlo mensual
tabstat bene_gob [w=factor] if bene_gob>0, by(decil_pc_pob)


*3. Distribución del total de recursos

*Estimar directamente la suma total de la masa monetaria, según deciles
tabstat bene_gob [w=factor], s(sum) by(decil) format(%16.2fc) // Cifras mostradas en gráfica de artículo Esquivel
tabstat bene_gob [w=factor], s(sum) by(decil_pc) format(%16.2fc) // Cifras mostradas en reporte INDESIG (Jaramillo)
tabstat bene_gob [w=factor], s(sum) by(decil_pc_pob) format(%16.2fc)

svy linearized : total bene_gob,
svy linearized : total bene_gob, over(decil) 
svy linearized : total bene_gob, over(decil_pc)

tabstat ing_cor  jubilacion remesas  bene_gob [w=factor], s(sum) by(decil_pc) format(%20.2fc) 

*Coeficiente de concentración de los programas sociales del gobierno
sgini ing_cor_pc [w=factor] 
sgini bene_gob [w=factor], sortvar(ing_cor_pc)

*4 Impacto en el ingresos

gen ing_cor_sin_bene_gob = ing_cor - bene_gob
*Calcular la suma total de los ingresos corrientes, los beneficios gubernamentales, y sacar el aumento por decil 
tabstat ing_cor bene_gob ing_cor_sin_bene_gob [w=factor], s(sum) by(decil) format(%24.2fc) // Cifras mostradas en gráfica de artículo Esquivel
tabstat ing_cor bene_gob ing_cor_sin_bene_gob [w=factor], s(sum) by(decil_pc) format(%24.2fc) 

*Generar incidencia de programas sociales sobre ingreso corriente total
gen prog_soc_inci=bene_gob/ ing_cor
*Tabular la incidencia en el ingreso corriente, con todos los hogares por decil como divisor
tabstat prog_soc_inci [w=factor], s(mean) by(decil) format(%16.5fc) 
tabstat prog_soc_inci [w=factor], s(mean) by(decil_pc) format(%16.5fc)
*Tabular la incidencia en el ingreso corriente, con todos los hogares por decil como divisor
tabstat prog_soc_inci [w=factor], s(mean) by(decil) format(%16.5fc) 
tabstat prog_soc_inci [w=factor] if bene_gob>0, by(decil_pc) // Cifras mostradas en reporte INDESIG (Jaramillo)





***********************************2016

use "$ruta/2016/bases/Concen16.dta", clear


*Análisis de datos de desigualdad
count
*70,311


*0. Preparación previa (crear deciles)

*Generar deciles y veintiles del hogar
xtile decil = ing_cor   [w=factor], nq(10)
xtile veintil = ing_cor   [w=factor], nq(20)

*Generar deciles y veintiles del hogar
gen ing_cor_pc=ing_cor/tot_integ
xtile decil_pc = ing_cor_pc   [w=factor], nq(10)
xtile veintil_pc = ing_cor_pc   [w=factor], nq(20)

*Generar deciles y veintiles del poblacion
gen factor_pob=factor*tot_integ
xtile decil_pc_pob = ing_cor_pc   [w=factor_pob], nq(10)
xtile veintil_pc_pob = ing_cor_pc   [w=factor_pob], nq(20)


*1. Cobertura

*Generar variable que de cuenta del número de hogares que reciben PS 
gen prog_soc_count=0
replace prog_soc_count=1 if bene_gob>0

*Tabular porcentaje de hogares que reciben programas sociales por decil
tabstat prog_soc_count [w=factor]

tabstat prog_soc_count [w=factor], by(decil) // Cifras mostradas en gráfica de artículo Esquivel
tabstat prog_soc_count [w=factor], by(decil_pc) // Cifras mostradas en reporte INDESIG (Jaramillo)
tabstat prog_soc_count [w=factor], by(decil_pc_pob)

svyset upm, strata(est_dis) weight(factor) vce(linearized) singleunit(missing)
svy linearized : mean prog_soc_count, over(decil)
svy linearized : mean prog_soc_count, over(decil_pc)


*2. Monto promedio transferido

*Monto promedio con todos los hogares por decil como divisor
tabstat bene_gob [w=factor], by(decil) // Cifras mostradas en gráfica de artículo Esquivel
tabstat bene_gob [w=factor], by(decil_pc) 
tabstat bene_gob [w=factor], by(decil_pc_pob)

*Monto promedio sólo con hogares beneficiarios por decil como divisor
tabstat bene_gob [w=factor] if bene_gob>0, by(decil) 
tabstat bene_gob [w=factor] if bene_gob>0, by(decil_pc) // Cifras mostradas en reporte INDESIG (Jaramillo), luego de dividir monto trimestral entre 3 para hacerlo mensual
tabstat bene_gob [w=factor] if bene_gob>0, by(decil_pc_pob)


*3. Distribución del total de recursos

*Estimar directamente la suma total de la masa monetaria, según deciles
tabstat bene_gob [w=factor], s(sum) by(decil) format(%16.2fc) // Cifras mostradas en gráfica de artículo Esquivel
tabstat bene_gob [w=factor], s(sum) by(decil_pc) format(%16.2fc) // Cifras mostradas en reporte INDESIG (Jaramillo)
tabstat bene_gob [w=factor], s(sum) by(decil_pc_pob) format(%16.2fc)

svy linearized : total bene_gob,
svy linearized : total bene_gob, over(decil) 
svy linearized : total bene_gob, over(decil_pc)

tabstat ing_cor  jubilacion remesas  bene_gob [w=factor], s(sum) by(decil_pc) format(%20.2fc) 

*Coeficiente de concentración de los programas sociales del gobierno
sgini ing_cor_pc [w=factor] 
sgini bene_gob [w=factor], sortvar(ing_cor_pc)


*4 Impacto en el ingresos

gen ing_cor_sin_bene_gob = ing_cor - bene_gob
*Calcular la suma total de los ingresos corrientes, los beneficios gubernamentales, y sacar el aumento por decil 
tabstat ing_cor bene_gob ing_cor_sin_bene_gob [w=factor], s(sum) by(decil) format(%24.2fc) // Cifras mostradas en gráfica de artículo Esquivel
tabstat ing_cor bene_gob ing_cor_sin_bene_gob [w=factor], s(sum) by(decil_pc) format(%24.2fc) 

*Generar incidencia de programas sociales sobre ingreso corriente total
gen prog_soc_inci=bene_gob/ ing_cor
*Tabular la incidencia en el ingreso corriente, con todos los hogares por decil como divisor
tabstat prog_soc_inci [w=factor], s(mean) by(decil) format(%16.5fc) 
tabstat prog_soc_inci [w=factor], s(mean) by(decil_pc) format(%16.5fc)
*Tabular la incidencia en el ingreso corriente, con todos los hogares por decil como divisor
tabstat prog_soc_inci [w=factor], s(mean) by(decil) format(%16.5fc) 
tabstat prog_soc_inci [w=factor] if bene_gob>0, by(decil_pc) // Cifras mostradas en reporte INDESIG (Jaramillo)


