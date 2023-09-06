************************************************************************************************************************************
*** Date:    December 2009
*** Authors: Beck, Levine, and Levkov
*** Purpose: Create Appendix Tables XA and XB in "Big Bad Banks? The Winners and Losers from Bank Deregulation in the United States"
*** Note:    Please change the working directories below 
************************************************************************************************************************************


#delimit;
clear;
set mem 100m;
set matsize 10000;
set more off;

cd "/home/alevkov/BeckLevineLevkov2010";

log using Appendix_TableX.log, replace;

use "/home/alevkov/BeckLevineLevkov2010/data/macro_workfile.dta", clear;
generate base=1;
sort statefip wrkyr;
save temp, replace;


*************************;
*** unemployment rate ***;
*************************;
use "/home/alevkov/BeckLevineLevkov2010/data/BLS.dta", clear;
rename year wrkyr;
keep statefip wrkyr unemploymentrate;
sort statefip wrkyr;
bysort statefip: generate unemploymentrate_1=unemploymentrate[_n-1];
bysort statefip: generate unemploymentrate_2=unemploymentrate[_n-2];
bysort statefip: generate unemploymentrate_3=unemploymentrate[_n-3];
bysort statefip: generate unemploymentrate_4=unemploymentrate[_n-4];
bysort statefip: generate unemploymentrate_5=unemploymentrate[_n-5];
sort statefip wrkyr;
merge statefip wrkyr using temp;
drop _merge*;
keep if base==1;

label var _intra "Bank deregulation";

tsset statefip wrkyr;

tabulate wrkyr, gen(wrkyr_dumm);

local Xs gsp_pc_growth prop_blacks prop_dropouts prop_female_headed unemploymentrate;

generate logistic_gini = log(gini/(1-gini));
generate log_gini      = log(gini);


****************;
*** LOG GINI ***;
****************;
xtreg log_gini _intra wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
estimates store m1, title((1));

xtreg log_gini _intra `Xs' wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
estimates store m2, title((2));

xtreg log_gini _intra `Xs' unemploymentrate_1 wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
estimates store m3, title((3));

xtreg log_gini _intra `Xs' unemploymentrate_1 unemploymentrate_2 wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
estimates store m4, title((4));

xtreg log_gini _intra `Xs' unemploymentrate_1 unemploymentrate_2 unemploymentrate_3 wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
estimates store m5, title((5));

xtreg log_gini _intra `Xs' unemploymentrate_1 unemploymentrate_2 unemploymentrate_3 unemploymentrate_4 wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
estimates store m6, title((6));

xtreg log_gini _intra `Xs' unemploymentrate_1 unemploymentrate_2 unemploymentrate_3 unemploymentrate_4 unemploymentrate_5 wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
estimates store m7, title((7));


estout m1 m2 m3 m4 m5 m6 m7 using Appendix_TableXA.txt, replace
keep(_intra `Xs' unemploymentrate_1 unemploymentrate_2 unemploymentrate_3 unemploymentrate_4 unemploymentrate_5)
cells(b(star fmt(3)) se(par)) stats(r2 N, labels("R-squared" "Observations") fmt(2 0)) 
legend label collabel(none)
prehead("")
posthead("")
postfoot("")
starlevel(* 0.10 ** 0.05 *** 0.01);


*********************;
*** LOGISTIC GINI ***;
*********************;
xtreg logistic_gini _intra wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
estimates store m1, title((1));

xtreg logistic_gini _intra `Xs' wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
estimates store m2, title((2));

xtreg logistic_gini _intra `Xs' unemploymentrate_1 wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
estimates store m3, title((3));

xtreg logistic_gini _intra `Xs' unemploymentrate_1 unemploymentrate_2 wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
estimates store m4, title((4));

xtreg logistic_gini _intra `Xs' unemploymentrate_1 unemploymentrate_2 unemploymentrate_3 wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
estimates store m5, title((5));

xtreg logistic_gini _intra `Xs' unemploymentrate_1 unemploymentrate_2 unemploymentrate_3 unemploymentrate_4 wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
estimates store m6, title((6));

xtreg logistic_gini _intra `Xs' unemploymentrate_1 unemploymentrate_2 unemploymentrate_3 unemploymentrate_4 unemploymentrate_5 wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
estimates store m7, title((7));

estout m1 m2 m3 m4 m5 m6 m7 using Appendix_TableXB.txt, replace
keep(_intra `Xs' unemploymentrate_1 unemploymentrate_2 unemploymentrate_3 unemploymentrate_4 unemploymentrate_5)
cells(b(star fmt(3)) se(par)) stats(r2 N, labels("R-squared" "Observations") fmt(2 0))
legend label collabel(none)
prehead("")
posthead("")
postfoot("")
starlevel(* 0.10 ** 0.05 *** 0.01);


erase temp.dta;
log close;
