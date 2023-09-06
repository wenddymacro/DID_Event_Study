**********************************************************************************************************************************
*** Date:    December 2009
*** Authors: Beck, Levine, and Levkov
*** Purpose: Create Appendix Figure 1 in "Big Bad Banks? The Winners and Losers from Bank Deregulation in the United States"
*** Note:    Please change the working directories below
**********************************************************************************************************************************


#delimit;
clear;
set more off;
set memory 100m;
set matsize 10000;

cd "/home/alevkov/BeckLevineLevkov2010";

log using Appendix_Figure1.log, replace;

use "/home/alevkov/BeckLevineLevkov2010/data/macro_workfile.dta", clear;
tsset statefip wrkyr;

tabulate wrkyr, gen(wrkyr_dumm);
tabulate statefip, gen(state_dumm);

replace p10 = 1 if p10==0;

generate temporary=.;
replace  temporary=unemploymentrate if wrkyr==1976;
bysort statefip: egen u1976=mean(temporary);
drop temporary;
save stam, replace;


*********************;
*** LOGISTIC GINI ***;
*********************;
use stam, clear;
generate Y = log(gini/(1-gini));

xtreg Y _intra wrkyr_dumm* if u1976<5.9, fe i(statefip) robust cluster(statefip);
gen   b1=_b[_intra];
gen   s1=_se[_intra];

xtreg Y _intra wrkyr_dumm* if u1976<6.7, fe i(statefip) robust cluster(statefip);
gen   b2=_b[_intra];
gen   s2=_se[_intra];

xtreg Y _intra wrkyr_dumm* if u1976>=6.7, fe i(statefip) robust cluster(statefip);
gen   b3=_b[_intra];
gen   s3=_se[_intra];

xtreg Y _intra wrkyr_dumm* if u1976>8.8, fe i(statefip) robust cluster(statefip);
gen   b4=_b[_intra];
gen   s4=_se[_intra];

keep b1-b4 s1-s4;
duplicates drop;
save temporary, replace;

use temporary, clear;
keep b1  b2  b3  b4;
xpose, clear;
rename v1 b;
gen u1976=_n;
sort u1976;
save betas, replace;

use temporary, clear;
keep s1  s2  s3  s4;
xpose, clear;
rename v1 se;
gen u1976=_n;
sort u1976;
merge u1976 using betas;
drop _merge*;

gen ci_lb = b-1.65*se;
gen ci_ub = b+1.65*se;

generate significant=1;
replace  significant=0 if ci_lb<0 & ci_ub>0;

label define mylabel 1 "Very Low";
label define mylabel 2 "Low", add;
label define mylabel 3 "High", add;
label define mylabel 4 "Very High", add;

label values u1976 mylabel;
generate measure = "Logistic(Gini)";
save measure1, replace;


*****************;
*** LOG THEIL ***;
*****************;
use stam, clear;
generate Y = log(theil);

xtreg Y _intra wrkyr_dumm* if u1976<5.9, fe i(statefip) robust cluster(statefip);
gen   b1=_b[_intra];
gen   s1=_se[_intra];

xtreg Y _intra wrkyr_dumm* if u1976<6.7, fe i(statefip) robust cluster(statefip);
gen   b2=_b[_intra];
gen   s2=_se[_intra];

xtreg Y _intra wrkyr_dumm* if u1976>=6.7, fe i(statefip) robust cluster(statefip);
gen   b3=_b[_intra];
gen   s3=_se[_intra];

xtreg Y _intra wrkyr_dumm* if u1976>8.8, fe i(statefip) robust cluster(statefip);
gen   b4=_b[_intra];
gen   s4=_se[_intra];

keep b1-b4 s1-s4;
duplicates drop;
save temporary, replace;

use temporary, clear;
keep b1  b2  b3  b4;
xpose, clear;
rename v1 b;
gen u1976=_n;
sort u1976;
save betas, replace;

use temporary, clear;
keep s1  s2  s3  s4;
xpose, clear;
rename v1 se;
gen u1976=_n;
sort u1976;
merge u1976 using betas;
drop _merge*;

gen ci_lb = b-1.65*se;
gen ci_ub = b+1.65*se;

generate significant=1;
replace  significant=0 if ci_lb<0 & ci_ub>0;

label define mylabel 1 "Very Low";
label define mylabel 2 "Low", add;
label define mylabel 3 "High", add;
label define mylabel 4 "Very High", add;

label values u1976 mylabel;
generate measure = "Log(Theil)";
save measure2, replace;


*************;
*** 90/10 ***;
*************;
use stam, clear;
generate Y = log(p90)-log(p10);

xtreg Y _intra wrkyr_dumm* if u1976<5.9, fe i(statefip) robust cluster(statefip);
gen   b1=_b[_intra];
gen   s1=_se[_intra];

xtreg Y _intra wrkyr_dumm* if u1976<6.7, fe i(statefip) robust cluster(statefip);
gen   b2=_b[_intra];
gen   s2=_se[_intra];

xtreg Y _intra wrkyr_dumm* if u1976>=6.7, fe i(statefip) robust cluster(statefip);
gen   b3=_b[_intra];
gen   s3=_se[_intra];

xtreg Y _intra wrkyr_dumm* if u1976>8.8, fe i(statefip) robust cluster(statefip);
gen   b4=_b[_intra];
gen   s4=_se[_intra];

keep b1-b4 s1-s4;
duplicates drop;
save temporary, replace;

use temporary, clear;
keep b1  b2  b3  b4;
xpose, clear;
rename v1 b;
gen u1976=_n;
sort u1976;
save betas, replace;

use temporary, clear;
keep s1  s2  s3  s4;
xpose, clear;
rename v1 se;
gen u1976=_n;
sort u1976;
merge u1976 using betas;
drop _merge*;

gen ci_lb = b-1.65*se;
gen ci_ub = b+1.65*se;

generate significant=1;
replace  significant=0 if ci_lb<0 & ci_ub>0;

label define mylabel 1 "Very Low";
label define mylabel 2 "Low", add;
label define mylabel 3 "High", add;
label define mylabel 4 "Very High", add;

label values u1976 mylabel;
generate measure = "90/10 ratio";
save measure3, replace;


*************;
*** 75/25 ***;
*************;
use stam, clear;
generate Y = log(p75)-log(p25);

xtreg Y _intra wrkyr_dumm* if u1976<5.9, fe i(statefip) robust cluster(statefip);
gen   b1=_b[_intra];
gen   s1=_se[_intra];

xtreg Y _intra wrkyr_dumm* if u1976<6.7, fe i(statefip) robust cluster(statefip);
gen   b2=_b[_intra];
gen   s2=_se[_intra];

xtreg Y _intra wrkyr_dumm* if u1976>=6.7, fe i(statefip) robust cluster(statefip);
gen   b3=_b[_intra];
gen   s3=_se[_intra];

xtreg Y _intra wrkyr_dumm* if u1976>8.8, fe i(statefip) robust cluster(statefip);
gen   b4=_b[_intra];
gen   s4=_se[_intra];

keep b1-b4 s1-s4;
duplicates drop;
save temporary, replace;

use temporary, clear;
keep b1  b2  b3  b4;
xpose, clear;
rename v1 b;
gen u1976=_n;
sort u1976;
save betas, replace;

use temporary, clear;
keep s1  s2  s3  s4;
xpose, clear;
rename v1 se;
gen u1976=_n;
sort u1976;
merge u1976 using betas;
drop _merge*;

gen ci_lb = b-1.65*se;
gen ci_ub = b+1.65*se;

generate significant=1;
replace  significant=0 if ci_lb<0 & ci_ub>0;

label define mylabel 1 "Very Low";
label define mylabel 2 "Low", add;
label define mylabel 3 "High", add;
label define mylabel 4 "Very High", add;

label values u1976 mylabel;
generate measure = "75/25 ratio";
save measure4, replace;

use measure1, clear;
append using measure2;

label var measure "measures of income inequality";
twoway (bar b u1976 if significant==0, sort fcolor(navy) lcolor(navy) barwidth(0.6) fintensity(30)) 
       (bar b u1976 if significant==1, sort fcolor(navy) lcolor(navy) barwidth(0.6)), 
       ytitle(Change in income inequality) ytitle(, size(small)) ylabel(, labsize(small) angle(horizontal)) 
       xtitle(Initial unemployment rate) xtitle(, size(small) margin(medsmall)) xlabel(1(1)4, valuelabel) 
       by(, graphregion(fcolor(white) lcolor(white) ifcolor(white) ilcolor(white))) 
       by(measure) 
       subtitle(, size(medsmall) nobox) 
       legend(order(1 "Not significant" 2 "Significant at 10%") size(small))
       graphregion(fcolor(white) lcolor(white) ifcolor(white) ilcolor(white)) plotregion(fcolor(white) lcolor(white) ifcolor(white) ilcolor(white));
       graph save Appendix_Figure1A, asis replace;
       

use measure3, clear;
append using measure4;
label var measure "measures of income inequality";

twoway (bar b u1976 if significant==0, sort fcolor(navy) lcolor(navy) barwidth(0.6) fintensity(30)) 
       (bar b u1976 if significant==1, sort fcolor(navy) lcolor(navy) barwidth(0.6)), 
       ytitle(Change in income inequality) ytitle(, size(small)) ylabel(, labsize(small) angle(horizontal)) 
       xtitle(Initial unemployment rate) xtitle(, size(small) margin(medsmall)) xlabel(1(1)4, valuelabel) 
       by(, graphregion(fcolor(white) lcolor(white) ifcolor(white) ilcolor(white))) 
       by(measure) 
       subtitle(, size(medsmall) nobox) 
       legend(order(1 "Not significant" 2 "Significant at 10%") size(small))
       graphregion(fcolor(white) lcolor(white) ifcolor(white) ilcolor(white)) plotregion(fcolor(white) lcolor(white) ifcolor(white) ilcolor(white));
       graph save Appendix_Figure1B, asis replace;

erase temporary.dta;
erase stam.dta;
erase betas.dta;
erase measure1.dta;
erase measure2.dta;
erase measure3.dta;
erase measure4.dta;

log close;

