/* 
	THIS FILE RUNS EVERYTHING AND CREATES EXCEL FILES!! 
	
	DEAR OUTSIDE USER: you should only need to download the data and code, 
		then change the filepath (noted below) in order to run this code 
		properly. PLEASE NOTE: messing around with the other do files will 
		probably break something. 
		
		FILES NEEDED: this one, 0_load.do, mdn.do, output.do, the data and its
		weights (rscfp2019.dta and p19_rw1.dta) from the federal reserve's website. 
		
	AUTHOR: emily case (ecase2@wisc.edu)
	
	LAST EDITED: 7.13.2022 ish 
	
	NOTES:
		* what is really weird about this dataset is that there are 
		  (1) probability weights on observations and (2) imputations. 
		  Working with both at the same time is annoying as f*ck, especially 
		  for calculating medians.  
		* EMILY NEEDS TO SPOT CHECK SOME CALCULATIONS! 
		* EMILY NEEDS TO: clarify other main variables 
			* also create codebook
			* maybe mess with distributions via sscc

*/

clear all
set more off


* DEAR USER: CHANGE filepath TO YOUR WORKINGN DIRECTORY (whatever folder holds the code)
global filepath = "/Users/emilycase/Desktop/third way/code"

cd "$filepath"
  
cap mkdir "outputfiles"	//creates a folder for the output 



* load and clean the data, which is saved as temp_sumstats.dta
qui do 0_load.do 

* pass variables of interest through output2.do
*		DEAR USER: you may add variables to the local mainvars, but ... 
*		NOTE: variables should be in dollars! not categorical 
*		NOTE: it's not the fastest code, it will take a minute or so! 
*			  wait for the results panel to say "end of do-file" to open files 


* CHOOSE BOOTSTRAP ITERATIONS AMOUNT
* iteration should be 200 at minimum, but to write whole code, changing it to 10
global itr = 600

local mainvars "houses" //"retqliq bus houses asset debt networth "

foreach variable in `mainvars' {
	* change the global input 
	global mainvar = "`variable'"
	do output
	di "FILE FOR $mainvar COMPLETED"
	qui do excelfmt 
	di "FORMATTING FOR $mainvar COMPLETED"
}







