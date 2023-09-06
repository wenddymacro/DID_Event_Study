**********************************************************************************************************************************
*** Date:    December 2009
*** Authors: Beck, Levine, and Levkov
*** Purpose: Create Appendix Table V in "Big Bad Banks? The Winners and Losers from Bank Deregulation in the United States"
*** Note:    Please change the working directories below
**********************************************************************************************************************************

#delimit;
clear;
set mem 2g;
set more off;

cd "/home/alevkov/BeckLevineLevkov2010";

log using Appendix_TableV.log, replace;

use "/home/alevkov/BeckLevineLevkov2010/data/micro_workfile.dta", clear;
keep if main_sample == 1;

*** drop the unemployed ***;
drop if empstat==20;
drop if empstat==21;
drop if empstat==22;

keep statefip wrkyr _inctot_cpi_tr0199 _perwt serial;
generate Y = _inctot_cpi_tr0199;
save temp, replace;

*****************************;
*** Different percentiles ***;
*****************************;
use temp, clear;

collapse 
(p10)  p10=Y
(p25)  p25=Y
(p50)  p50=Y
(p75)  p75=Y
(p90)  p90=Y
[pw=_perwt], by(statefip wrkyr);
sort statefip wrkyr;
save percentiles, replace;

***********************************;
*** More measures of inequality ***;
***********************************;
use temp, clear;
replace  Y = 1 if Y == 0; 

egen gini    = inequal(Y), by(statefip wrkyr) weights(_perwt) index(gini);
egen theil   = inequal(Y), by(statefip wrkyr) weights(_perwt) index(theil);

keep statefip wrkyr gini theil;
duplicates drop;
drop if gini==.;
sort statefip wrkyr;
merge statefip wrkyr using percentiles;
drop _merge*;
sort statefip wrkyr;
save temp, replace;


use "/home/alevkov/BeckLevineLevkov2010/data/macro_workfile.dta", clear;
keep statefip wrkyr _intra;
sort statefip wrkyr;
merge statefip wrkyr using temp;
drop _merge*;

tsset statefip wrkyr;

tabulate wrkyr, gen(wrkyr_dumm);
tabulate statefip, gen(state_dumm);

replace p10 = 1 if p10==0;

generate logistic_gini = log(gini/(1-gini));
generate log_gini      = log(gini);
generate log_theil     = log(theil);
generate log_9010      = log(p90)-log(p10);
generate log_7525      = log(p75)-log(p25);

xtreg logistic_gini _intra  wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
estimates store m1, title(Logistic Gini);

xtreg log_gini _intra  wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
estimates store m2, title(Log Gini);

xtreg log_theil _intra  wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
estimates store m3, title(Log Theil);

xtreg log_9010 _intra  wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
estimates store m4, title(Log 90/10);

xtreg log_7525 _intra  wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
estimates store m5, title(Log 75/25);


estout m1 m2 m3 m4 m5 using Appendix_TableV.txt, replace
keep(_intra)
cells(b(fmt(3)) se(star par) p(fmt(3) par({ }))) stats(r2 N, labels("R-squared" "Observations") fmt(2 0)) 
legend label collabel(none)
prehead("The Impact of Deregulation on Income Inequality:" "Excluding the Unemployed")
posthead("")
postfoot("")
starlevel(* 0.10 ** 0.05 *** 0.01);

erase temp.dta;
log close;
