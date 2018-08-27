clear
set more off
// change to the output directory
cd output
// get a list of the output files created by bootstrap.do
local list: dir . files "output*.dta"
//loop over the output files appending each one
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
// save the appended results
saveold "mybootresults", replace

// make a histogram
hist(mean_myvar)

// save the graph
graph export "stata_bootstrap.eps", replace
