clear all
set more off

set obs 10

gen id = _n
expand 5

bys id: gen time = _n
gen myvar = 10 * id + time + rnormal(0, 3)

save mydata, replace
