clear
set more off

local path "/nfs/home/S/sgoshev/rcebatch"
cd `path'//output

local list: dir . files "*"

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

*** 

saveold "`path'//mybootdata", replace

