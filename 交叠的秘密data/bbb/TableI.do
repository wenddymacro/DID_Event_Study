**********************************************************************************************************************************
*** Date:    December 2009
*** Authors: Beck, Levine, and Levkov
*** Purpose: Create Table I in "Big Bad Banks? The Winners and Losers from Bank Deregulation in the United States"
*** Note:    Please change the working directories below 
**********************************************************************************************************************************

#delimit;
clear;
set mem 100m;
set more off;

cd "/home/alevkov/BeckLevineLevkov2010";

log using TableI.log, replace;

use "/home/alevkov/BeckLevineLevkov2010/data/macro_workfile.dta", clear;

keep if ks99==1;
drop if inter1 == . | inter2 == .;

replace gini = gini * 100;

label var gini "Gini coefficient of income inequality";

replace wrkyr = wrkyr - 1975;

local financialXs ass4_ass cap_dif4 inter1 ins_dum inter2 e_interp dem uniform lncon1 unit bankpow;
local laborXs gsp_pc_growth prop_blacks prop_dropouts prop_female_headed unemploymentrate;

stset wrkyr death, id(statefip);

streg gini, robust cluster(statefip) dist(weibull) time;
estimates store m1, title((1));

streg gini `laborXs', robust cluster(statefip) dist(weibull) time;
estimates store m2, title((2));

streg gini `financialXs', robust cluster(statefip) dist(weibull) time;
estimates store m3, title((3));

streg gini `laborXs' `financialXs', robust cluster(statefip) dist(weibull) time;
estimates store m4, title((4));

streg gini `laborXs' `financialXs' reg1-reg3, robust cluster(statefip) dist(weibull) time;
estimates store m5, title((5));

estout m1 m2 m3 m4 m5 using TableI.txt, replace
keep(gini)
cells(b(star fmt(2)) se(par)) stats(N, labels(Observations) fmt(0)) 
legend label collabel(none)  
prehead("Table I" "Timing of Bank Deregulation and Pre-Existing Income Inequality: The Duration Model") 
posthead("") prefoot("") 
postfoot("")
starlevel(* 0.10 ** 0.05 *** 0.01) nolz nolegend;


log close;
