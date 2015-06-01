
clear
set more off

cd output

local list: dir . files "*.dta"

di `list'

local f=1
foreach file of local list {
        di "`file"'
        if `f'== 1 {
                use `file', clear
        }
        else {
                append using `file'
        }
        local ++f
}

saveold "`path'//mybootdata", replace

// histogram
hist(mean_myvar)

// save graph
graph export tst.eps
