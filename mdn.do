/*
	THIS FILE SHOULD BE FED:
		$mainvar
		$subset  and $i
		$subset2 and $j
		$double
		$itr
*/


* empty matrix for results 
mat result = J(1,5, .)
mat colnames result = "mean" "mean se" "median" "median se" "N"


if "$subset" == "all families" {
	if "$mainvar" == "retqliq"{
		scfcombo $mainvar [aw = wgt] if hretqliq == 1, command(reg) reps($itr )
		mat result[1,1] = r(table)[1,1]
		mat result[1,2] = r(table)[2,1]
		scfcombo $mainvar [aw = wgt] if hretqliq == 1, command(qreg) reps($itr )
		mat result[1,3] = r(table)[1,1]
		mat result[1,4] = r(table)[2,1]
	}
	else if "$mainvar" == "bus"{
		scfcombo $mainvar [aw = wgt] if hbus == 1, command(reg) reps($itr )
		mat result[1,1] = r(table)[1,1]
		mat result[1,2] = r(table)[2,1]
		scfcombo $mainvar [aw = wgt] if hbus == 1, command(qreg) reps($itr )
		mat result[1,3] = r(table)[1,1]
		mat result[1,4] = r(table)[2,1]
	}
	else if "$mainvar" == "houses"{
		scfcombo $mainvar [aw = wgt] if hhouses == 1, command(reg) reps($itr )
		mat result[1,1] = r(table)[1,1]
		mat result[1,2] = r(table)[2,1]
		scfcombo $mainvar [aw = wgt] if hhouses == 1, command(qreg) reps($itr )
		mat result[1,3] = r(table)[1,1]
		mat result[1,4] = r(table)[2,1]
	}
	else{
		scfcombo $mainvar [aw = wgt], command(reg) reps($itr )
		mat result[1,1] = r(table)[1,1]
		mat result[1,2] = r(table)[2,1]
		scfcombo $mainvar [aw = wgt], command(qreg) reps($itr )
		mat result[1,3] = r(table)[1,1]
		mat result[1,4] = r(table)[2,1]
	}
}	
else if $double == 0 {
	if "$mainvar" == "retqliq"{
		scfcombo $mainvar [aw = wgt] if ($subset == $i ) & (hretqliq == 1) , command(reg) reps($itr )
		mat result[1,1] = r(table)[1,1]
		mat result[1,2] = r(table)[2,1]
		scfcombo $mainvar [aw = wgt] if ($subset == $i ) & (hretqliq == 1) , command(qreg) reps($itr )
		mat result[1,3] = r(table)[1,1]
		mat result[1,4] = r(table)[2,1]
	}
	else if "$mainvar" == "bus"{
		scfcombo $mainvar [aw = wgt] if ($subset == $i ) & (hbus == 1) , command(reg) reps($itr )
		mat result[1,1] = r(table)[1,1]
		mat result[1,2] = r(table)[2,1]
		scfcombo $mainvar [aw = wgt] if ($subset == $i ) & (hbus == 1) , command(qreg) reps($itr )
		mat result[1,3] = r(table)[1,1]
		mat result[1,4] = r(table)[2,1]
	}
	else if "$mainvar" == "houses"{
		scfcombo $mainvar [aw = wgt] if ($subset == $i ) & (hhouses == 1) , command(reg) reps($itr )
		mat result[1,1] = r(table)[1,1]
		mat result[1,2] = r(table)[2,1]
		scfcombo $mainvar [aw = wgt] if ($subset == $i ) & (hhouses == 1) , command(qreg) reps($itr )
		mat result[1,3] = r(table)[1,1]
		mat result[1,4] = r(table)[2,1]
	}
	else{
		scfcombo $mainvar [aw = wgt] if $subset == $i , command(reg) reps($itr )
		mat result[1,1] = r(table)[1,1]
		mat result[1,2] = r(table)[2,1]
		scfcombo $mainvar [aw = wgt] if $subset == $i , command(qreg) reps($itr )
		mat result[1,3] = r(table)[1,1]
		mat result[1,4] = r(table)[2,1]
	}
}
else if $double == 1 {
	if "$mainvar" == "retqliq" {
		scfcombo $mainvar [aw = wgt] if ($subset == $i ) & ($subset2 == $j ) & (hretqliq == 1), command(reg) reps($itr )
		mat result[1,1] = r(table)[1,1]
		mat result[1,2] = r(table)[2,1]
		scfcombo $mainvar [aw = wgt] if ($subset == $i ) & ($subset2 == $j ) & (hretqliq == 1), command(qreg) reps($itr )
		mat result[1,3] = r(table)[1,1]
		mat result[1,4] = r(table)[2,1]
	}
	else if "$mainvar" == "bus" {
		scfcombo $mainvar [aw = wgt] if ($subset == $i ) & ($subset2 == $j ) & (hbus == 1), command(reg) reps($itr )
		mat result[1,1] = r(table)[1,1]
		mat result[1,2] = r(table)[2,1]
		scfcombo $mainvar [aw = wgt] if ($subset == $i ) & ($subset2 == $j ) & (hbus == 1), command(qreg) reps($itr )
		mat result[1,3] = r(table)[1,1]
		mat result[1,4] = r(table)[2,1]
	}
	else if "$mainvar" == "houses" {
		scfcombo $mainvar [aw = wgt] if ($subset == $i ) & ($subset2 == $j ) & (hhouses == 1), command(reg) reps($itr )
		mat result[1,1] = r(table)[1,1]
		mat result[1,2] = r(table)[2,1]
		scfcombo $mainvar [aw = wgt] if ($subset == $i ) & ($subset2 == $j ) & (hhouses == 1), command(qreg) reps($itr )
		mat result[1,3] = r(table)[1,1]
		mat result[1,4] = r(table)[2,1]
	}
	else {
		scfcombo $mainvar [aw = wgt] if ($subset == $i ) & ($subset2 == $j ), command(reg) reps($itr )
		mat result[1,1] = r(table)[1,1]
		mat result[1,2] = r(table)[2,1]
		scfcombo $mainvar [aw = wgt] if ($subset == $i ) & ($subset2 == $j ), command(qreg) reps($itr )
		mat result[1,3] = r(table)[1,1]
		mat result[1,4] = r(table)[2,1]
	}
}

* change results to "thousands of dollars" to look better in excel
mat result = result /1000



*** FIRST ATTEMPT: ***
//
//
// quietly{
//
// forval imp = 1/5 {		// loop through the imputation values 
// 	clear
// 	use temp_sumstats
//	
// 	* drop subsetted values 
// 	if "$subset" != "all families"{
// 		keep if $subset == $i
//		
// 		if $double == 1 {
// 			keep if $subset2 == $j
// 		}
// 	}
//
// 	* pull out the number of valid imputations
// 	*	(when running on "all families", should be 5777)
// 	qui sum imputation if imputation == `imp'
// 	sca impwgt = r(N)/_N	// _N is ALL obs 
//	
// 	keep if imputation == `imp'
// 	global nobs = _N 
//	
//	
// * median 
//
// 	sort $mainvar 
//	
// 	gen cumulative = wgt		// cumulative weights 
// 	replace cumulative = cumulative[_n-1] + wgt[_n] if _n != 1 
//
// 	* the "cutoff" value 
// 	qui total wgt 
// 	sca twgt`imp' = e(b)[1,1]
// 	sca cutoff = .5 * twgt`imp'
//	
// 	* find the first obs where cumulative wgt is >= cutoff 
// 	egen mdn = min(cond(cumulative >= cutoff, _n, .)) 
// 	qui sum mdn
//	
// 	local dmedian`imp' = $mainvar[r(mean)]
//
// 	sca dmedian`imp' = `dmedian`imp'' * impwgt 
//	
// }
//
// local mdn = (dmedian1 + dmedian2 + dmedian3 + dmedian4 + dmedian5)
// global mdn = round(`mdn', 1)
//
//
// clear 
// use temp_sumstats.dta
// } 
//
// if $double == 0 {
// 	di "median for variable $mainvar, subset by $subset = $i:"
//
// }
// else {
// 	di "median for variable $mainvar, subset by $subset = $i and $subset2 = $j:"
// }
//
// di $mdn


