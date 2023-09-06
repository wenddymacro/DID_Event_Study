**********************************************************************************************************************************
*** Date:    December 2009
*** Authors: Beck, Levine, and Levkov
*** Purpose: Create Table V in "Big Bad Banks? The Winners and Losers from Bank Deregulation in the United States"
*** Note:    Please change the working directories below 
**********************************************************************************************************************************

#delimit;
clear;
set more off;
set memory 4g;

cd "/home/alevkov/BeckLevineLevkov2010";

log using TableV.log, replace;

******************************************;
*** AGES 25-35, UNCONDITIONAL EARNINGS ***;
******************************************;
use "/home/alevkov/BeckLevineLevkov2010/data/micro_workfile.dta", clear;
keep if main_sample == 1;
keep if _wageworker==1;
keep if _agelyr>=25 & _agelyr<=35;
keep statefip wrkyr _incwage_cpi _perwt serial;
generate Y = _incwage_cpi;
save temp, replace;

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
save ind_inequality_earnings2535, replace;


******************************************;
*** AGES 36-45, UNCONDITIONAL EARNINGS ***;
******************************************;
use "/home/alevkov/BeckLevineLevkov2010/data/micro_workfile.dta", clear;
keep if main_sample == 1;
keep if _wageworker==1;
keep if _agelyr>=36 & _agelyr<=45;
keep statefip wrkyr _incwage_cpi _perwt serial;
generate Y = _incwage_cpi;
save temp, replace;

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
save ind_inequality_earnings3645, replace;


******************************************;
*** AGES 46-54, UNCONDITIONAL EARNINGS ***;
******************************************;
use "/home/alevkov/BeckLevineLevkov2010/data/micro_workfile.dta", clear;
keep if main_sample == 1;
keep if _wageworker==1;
keep if _agelyr>=46 & _agelyr<=54;
keep statefip wrkyr _incwage_cpi _perwt serial;
generate Y = _incwage_cpi;
save temp, replace;

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

save ind_inequality_earnings4654, replace;


***********************;
*** ALL AGES POOLED ***;
***********************;
use ind_inequality_earnings2535.dta, clear;
generate ages = "25-35";
save temp2535, replace;

use ind_inequality_earnings3645.dta, clear;
generate ages = "36-45";
save temp3645, replace;

use ind_inequality_earnings4654.dta, clear;
generate ages = "46-54";
save temp4654, replace;

use temp2535, clear;
append using temp3645.dta;
append using temp4654.dta;
sort statefip wrkyr;
save temp, replace;

use "/home/alevkov/BeckLevineLevkov2010/data/macro_workfile.dta", clear;
keep statefip wrkyr _intra;
sort statefip wrkyr;
merge statefip wrkyr using temp;
drop _merge*;

drop if statefip==10;
drop if statefip==46;

tabulate wrkyr, gen(wrkyr_dumm);
tabulate statefip, gen(state_dumm);

replace p10 = 1 if p10==0;

generate logistic_gini = log(gini/(1-gini));
generate log_gini      = log(gini);
generate log_theil     = log(theil);
generate log_9010      = log(p90)-log(p10);
generate log_7525      = log(p75)-log(p25);

generate age2535=0;
generate age3645=0;
generate age4654=0;

replace age2535=1 if ages=="25-35";
replace age3645=1 if ages=="36-45";
replace age4654=1 if ages=="46-54";

generate _intra2535 = _intra*age2535;
generate _intra3645 = _intra*age3645;
generate _intra4654 = _intra*age4654;

tostring wrkyr, generate(year_string);
tostring statefip, generate(statefip_string);
generate year_age = year_string + ages;
generate state_age = statefip_string + ages;
quietly tabulate year_age, gen(year_age_dumm);
quietly tabulate state_age, gen(state_age_dumm);


regress logistic_gini _intra _intra3645 _intra4654 age3645 age4654 wrkyr_dumm* state_dumm* year_age_dumm* state_age_dumm*, robust cluster(statefip);
estimates store m1, title(Logistic Gini);

regress log_gini _intra _intra3645 _intra4654 age3645 age4654 wrkyr_dumm* state_dumm* year_age_dumm* state_age_dumm*, robust cluster(statefip);
estimates store m2, title(Log Gini);

regress log_theil _intra _intra3645 _intra4654 age3645 age4654 wrkyr_dumm* state_dumm* year_age_dumm* state_age_dumm*, robust cluster(statefip);
estimates store m3, title(Log Theil);

regress log_9010 _intra _intra3645 _intra4654 age3645 age4654 wrkyr_dumm* state_dumm* year_age_dumm* state_age_dumm*, robust cluster(statefip);
estimates store m4, title(Log 90/10);

regress log_7525 _intra _intra3645 _intra4654 age3645 age4654 wrkyr_dumm* state_dumm* year_age_dumm* state_age_dumm*, robust cluster(statefip);
estimates store m5, title(Log 75/25);

estout m1 m2 m3 m4 m5 using TableV.txt, replace
keep(_intra _intra3645 _intra4654)
cells(b(star fmt(3)) se(par) p(fmt(3) par({ }))) stats(r2 N, labels("R-squared" "Observations") fmt(2 0)) 
legend label collabel(none)
prehead("The Impact of Deregulation on Earnings Inequality")
posthead("Panel A: Unconditional Earnings")
postfoot("")
starlevel(* 0.10 ** 0.05 *** 0.01);



*****************************************************;
*** AGES 25-35, EARNINGS CONDITIONAL ON EDUCATION ***;
*****************************************************;
use "/home/alevkov/BeckLevineLevkov2010/data/micro_workfile.dta", clear;
keep if main_sample == 1;
keep if _wageworker==1;
keep if _agelyr>=25 & _agelyr<=35;
keep statefip wrkyr _incwage_cpi _hsd08 _hsd911 _hsg _sc _cg _ad _female _white _black _hispanic _perwt serial;
generate log_earnings=log(_incwage_cpi);
xi: regress log_earnings _hsd08 _hsd911 _hsg _sc _cg _ad i.wrkyr [pw=_perwt];
predict Y, residual;
replace Y=Y+20;
sum Y;
save temp, replace;

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

save ind_inequality_earnings2535, replace;


*****************************************************;
*** AGES 36-45, EARNINGS CONDITIONAL ON EDUCATION ***;
*****************************************************;
use "/home/alevkov/BeckLevineLevkov2010/data/micro_workfile.dta", clear;
keep if main_sample == 1;
keep if _wageworker==1;
keep if _agelyr>=36 & _agelyr<=45;
keep statefip wrkyr _incwage_cpi _hsd08 _hsd911 _hsg _sc _cg _ad _female _white _black _hispanic _perwt serial;
generate log_earnings=log(_incwage_cpi);
xi: regress log_earnings _hsd08 _hsd911 _hsg _sc _cg _ad i.wrkyr [pw=_perwt];
predict Y, residual;
replace Y=Y+20;
sum Y;
save temp, replace;

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

save ind_inequality_earnings3645, replace;


*****************************************************;
*** AGES 46-54, EARNINGS CONDITIONAL ON EDUCATION ***;
*****************************************************;
use "/home/alevkov/BeckLevineLevkov2010/data/micro_workfile.dta", clear;
keep if main_sample == 1;
keep if _wageworker==1;
keep if _agelyr>=46 & _agelyr<=54;
keep statefip wrkyr _incwage_cpi _hsd08 _hsd911 _hsg _sc _cg _ad _female _white _black _hispanic _perwt serial;
generate log_earnings=log(_incwage_cpi);
xi: regress log_earnings _hsd08 _hsd911 _hsg _sc _cg _ad i.wrkyr [pw=_perwt];
predict Y, residual;
replace Y=Y+20;
sum Y;
save temp, replace;

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

save ind_inequality_earnings4654, replace;


***********************;
*** ALL AGES POOLED ***;
***********************;
use ind_inequality_earnings2535.dta, clear;
generate ages = "25-35";
save temp2535, replace;

use ind_inequality_earnings3645.dta, clear;
generate ages = "36-45";
save temp3645, replace;

use ind_inequality_earnings4654.dta, clear;
generate ages = "46-54";
save temp4654, replace;

use temp2535, clear;
append using temp3645.dta;
append using temp4654.dta;
sort statefip wrkyr;
save temp, replace;

use "/home/alevkov/BeckLevineLevkov2010/data/macro_workfile.dta", clear;
keep statefip wrkyr _intra;
sort statefip wrkyr;
merge statefip wrkyr using temp;
drop _merge*;

drop if statefip==10;
drop if statefip==46;

tabulate wrkyr, gen(wrkyr_dumm);
tabulate statefip, gen(state_dumm);

replace p10 = 1 if p10==0;

generate logistic_gini = log(gini/(1-gini));
generate log_gini      = log(gini);
generate log_theil     = log(theil);
generate log_9010      = log(p90)-log(p10);
generate log_7525      = log(p75)-log(p25);

generate age2535=0;
generate age3645=0;
generate age4654=0;

replace age2535=1 if ages=="25-35";
replace age3645=1 if ages=="36-45";
replace age4654=1 if ages=="46-54";

generate _intra2535 = _intra*age2535;
generate _intra3645 = _intra*age3645;
generate _intra4654 = _intra*age4654;

tostring wrkyr, generate(year_string);
tostring statefip, generate(statefip_string);
generate year_age = year_string + ages;
generate state_age = statefip_string + ages;
quietly tabulate year_age, gen(year_age_dumm);
quietly tabulate state_age, gen(state_age_dumm);


regress logistic_gini _intra _intra3645 _intra4654 age3645 age4654 wrkyr_dumm* state_dumm* year_age_dumm* state_age_dumm*, robust cluster(statefip);
estimates store m1, title(Logistic Gini);

regress log_gini _intra _intra3645 _intra4654 age3645 age4654 wrkyr_dumm* state_dumm* year_age_dumm* state_age_dumm*, robust cluster(statefip);
estimates store m2, title(Log Gini);

regress log_theil _intra _intra3645 _intra4654 age3645 age4654 wrkyr_dumm* state_dumm* year_age_dumm* state_age_dumm*, robust cluster(statefip);
estimates store m3, title(Log Theil);

regress log_9010 _intra _intra3645 _intra4654 age3645 age4654 wrkyr_dumm* state_dumm* year_age_dumm* state_age_dumm*, robust cluster(statefip);
estimates store m4, title(Log 90/10);

regress log_7525 _intra _intra3645 _intra4654 age3645 age4654 wrkyr_dumm* state_dumm* year_age_dumm* state_age_dumm*, robust cluster(statefip);
estimates store m5, title(Log 75/25);

estout m1 m2 m3 m4 m5 using TableV.txt, append
keep(_intra _intra3645 _intra4654)
cells(b(star fmt(3)) se(par) p(fmt(3) par({ }))) stats(r2 N, labels("R-squared" "Observations") fmt(2 0)) 
legend label collabel(none)
prehead("")
posthead("Panel B: Earnings Conditional on Education")
postfoot("")
starlevel(* 0.10 ** 0.05 *** 0.01);

erase temp.dta;
erase temp2535.dta;
erase temp3645.dta;
erase temp4654.dta;
erase percentiles.dta;
erase ind_inequality_earnings2535.dta;
erase ind_inequality_earnings3645.dta;
erase ind_inequality_earnings4654.dta;
log close;

