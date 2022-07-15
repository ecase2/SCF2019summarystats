/* 
	CHANGING GLOBAL VARIABLES: these go into mdn.do to calculate the stats
		
		$mainvar: variable of interest (i.e. wealth, debt...)
		$subset : first subsetting demographic variable (i.e. race)
		$subset2: secondary subsetting demographic var 
		$mdn    : median calculated & saved in mdn.do 
		$i & $j	: value of subset to keep, within mdn.do 
		$double : indicator = 1 if it's a double cross 
		
	MATRIX SHORTHAND NAMES: 
	
		matrix A: carries one cross section of stats
		matrix B: carries all DOUBLE cross section of stats 
		mat Bi: carries one double cross, is added to mat B

*/

clear all 
use temp_sumstats

* keep only the variables I need 

keep $mainvar agegroup racecl4 racecl occat1 edugroup wgt y1 yy1 rep hretqliq hbus hhouses
merge 1:1 y1 using p19_rw1.dta

* sscc winstat (linstat)? 
* writing files for distributing: 
	* sscc has resources and classes 
	* danny uses chtc... much greater upfront investment, not better just different

putexcel set "outputfiles/$mainvar", sheet("README") modify
putexcel A1 = "This file explores the $mainvar variable in the 2019 survey of consumer finance extract data."
putexcel A1:p3, merge
putexcel A4 = "Each sheet represents a different cross section of the data. Please reference the codebook for variable descriptions."
putexcel A4:p6, merge
putexcel A7 = "Means, medians, and their standard errors are calculating using the Stata package scfcombo, which was written specifically for this dataset &accounts for imputation and sampling variance in the errors."
putexcel A7:p9, merge
putexcel A10 = "NOTE: values are in thousands of 2019 dollars"
putexcel A10:p12, merge 
putexcel A13 = "Standard errors were calculated using $itr bootstrap iterations"
putexcel A13:p15, merge 
putexcel A1:p30, font(Arial, 14) bold txtwrap top


* all families:
global subset "all families"
do mdn
mat allfam = result 
mat allfam[1,5] = 5777
mat rownames allfam = "all families"
putexcel set "outputfiles/$mainvar", sheet("$subset") modify 
putexcel A1:H3, font(Arial, 14)
putexcel A1 = matrix(allfam), names nformat(account_d2_cur)
putexcel A1:E1, bold border(bottom)
putexcel A1:A2, bold border(right)


* main subset varlist:
local xvars "agegroup racecl4 racecl occat1 edugroup"
* secondary cross-subset list (will be modified):
local vars2 "racecl4 racecl edugroup"


* for each var, get: the levels and the labels 
foreach x in `xvars' {
	levelsof `x' 
	loc lvls`x' = r(r)
	
	* empty local for the rownames of subset x 
	local lbls`x'
	
		forvalues i = 1/`lvls`x''{
			* pull out the value label for rownames
			local lbl : label (`x') `i'
			local lbls`x' `" `lbls`x'' "`lbl'" "'
		}
		
}



* calculate and store stats 
foreach x in `xvars' {
	global subset "`x'"
	
	mat A = J(`lvls`x'', 5,.)
	mat rownames A = `lbls`x''
	mat colnames A = "mean" "mean se" "median" "median se" "N"
	
	forvalues i =1/`lvls`x'' {
		global i = `i'
		global double = 0 
		do mdn 
		mat A[`i',1] = result 
		count if ($subset == $i) & rep == 1
		sca obcount = r(N)
		mat A[`i', 5] = obcount
	}
	putexcel set "outputfiles/$mainvar", sheet("$subset") modify 
	putexcel A1:F7, font(Arial, 14)
	putexcel A1 = matrix(A), names nformat(account_d2_cur)
	putexcel A1:A6, bold border(right)
	putexcel A1:F1, bold border(bottom)
	
	
	if ("`x'" != "racecl") & ("`x'" != "racecl4") {
		* exclude x from the list of possible cross overs;
		*	(race vars don't get crossed with anything as first var)
		unab exclude : `x'
		local yvars : list vars2 - exclude
		
		foreach y in `yvars' {
			global subset2 "`y'"
			global double = 1
			putexcel set "outputfiles/$mainvar", sheet(`" "$subset" & "$subset2" "') modify 
			putexcel A1:G20, font(Arial, 14)
			 
			forvalues j = 1/`lvls`y'' {
				global j = `j'
				global double = 1 
				mat B`j' = J(`lvls`x'', 5, .)
				mat rownames B`j' = `lbls`x''
				mat colnames B`j' = "mean" "mean se" "median" "median se" "N"
				
				loc lbly: label (`y') `j'
				loc row = 2 + (`j' - 1)*`lvls`x''
				putexcel A`row' = "`lbly'"
				
				forvalues i = 1/`lvls`x'' {
					global i = `i'
					
					if "$mainvar" == "bus" {
						count if ($subset == $i) & ($subset2 == $j ) & (hbus == 1) & rep == 1
						sca obcount = r(N)
					}
					else if "$mainvar" == "retqliq" {
						count if ($subset == $i) & ($subset2 == $j ) & (hretqliq == 1) & rep == 1
						sca obcount = r(N)
					}
					else if "$mainvar" == "houses" {
						count if ($subset == $i) & ($subset2 == $j ) & (hhouses == 1) & rep == 1
						sca obcount = r(N)
					}
					else {
						count if ($subset == $i) & ($subset2 == $j ) & rep == 1
						sca obcount = r(N)
					}
					
					if obcount >=4 {
						do mdn 
						mat B`j'[`i',1] = result
					}
					else {
						mat B`j'[`i',1] = -999
					}
					mat B`j'[`i', 5] = obcount 
					mat list B`j' 
					di "$subset = $i and $subset2 = $j"
					pause 
					
				}
				 
			}
			
			mat B = B1 
			forvalues j = 2/`lvls`y'' {
				mat B = B\B`j'
			}
			putexcel B1 = matrix(B), names nformat(account_d2_cur)
			putexcel A1:B20, bold 
			putexcel B1:B16, border(right)
			putexcel A1:G1, bold border(bottom)
			

		}
		
	}

}

putexcel save
