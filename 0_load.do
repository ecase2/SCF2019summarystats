/*
	third way RA project 
	emily case 
	
	created: 6.1.22
*/



use "rscfp2019.dta"		// summary extracted public data

gen wealth = asset - debt

la var asset "Sum of financial assets and nonfinancial assets"
la var debt "Total debt"
la var networth "Wealth calculated from asset - debt (see definitions for asset and debt)"
la var retqliq "Retirement1: Includes IRAs, Keoghs, thrift-type accts, & future&current acct-type pensions"
la var reteq "Retirment2: includes IRAs,Keoghs&thrift-type plans invested in stocks/stock MFs"
la var homeeq "Value of primary residence - ttl debt from primary res"
la var bus "Value of active & nonactive businesses"


gen rep = y1 - yy1 * 10 

* svyset yy1 [pw = wgt]


* three clusters of age, like in Bhutta 
gen agegroup = 3
replace agegroup = 2 if (agecl < 4)
replace agegroup = 1 if (agecl <= 1)
la define ages 1 "18-34" 2 "35-54" 3 "55 and older"
la val agegroup ages
la var agegroup "Age range categories"


* values 
la define races_nonmix 1 "white, non-mixed " 2 "black, non-mixed " 3 "hispanic/latino, non-mixed " 4 "other"
la val racecl4 races_nonmix
la var racecl4 "Race, by 4 categories: white, black, hispanic, and other. *non-mixed"

replace race = 4 if race == 5
la define races 1 "white, non-hispanic" 2 "black" 3 "hispanic" 4 "other"
la val race races

la define race2cat 1 "white, non-hispanic" 2 "nonwhite or hispanic"
la val racecl race2cat
la var racecl "Race, by 2 categories: white & non-hispanic or nonwhite/hispanic"


la define occs 1 "work for employer" 2 "self-employed" 3 "retired/disabled/student" 4 "not working, other"
la val occat1 occs
la var occat1 "Job type category"
 
 
replace educ = . if educ == -1
gen edugroup = 1
replace edugroup = 2 if educ == 8
replace edugroup = 3 if educ >= 9 
replace edugroup = 4 if educ >= 12
la define educl 1  "less than HS" 2 "HS degree" 3 "some college/assoc." 4 "Bach./graduate school" 
la val edugroup educl 
la var edugroup "Years of education, split into 4 categories"

save temp_sumstats.dta, replace 




