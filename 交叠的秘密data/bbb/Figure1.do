**********************************************************************************************************************************
*** Date:    December 2009
*** Authors: Beck, Levine, and Levkov
*** Purpose: Create Figure 1 in "Big Bad Banks? The Winners and Losers from Bank Deregulation in the United States"
*** Note:    Please change the working directories below 
**********************************************************************************************************************************


#delimit;
clear;
set more off;
set memory 100m;

cd "/home/alevkov/BeckLevineLevkov2010";

log using Figure1.log, replace;

**************;
*** LEVELS ***;
**************;
use "/home/alevkov/BeckLevineLevkov2010/data/macro_workfile.dta", clear;
generate log_gini = log(gini);
xi: regress log_gini i.wrkyr;
predict r, residual;
keep if wrkyr<branch_reform;

bysort statefip: egen mean_gini = mean(r);
keep statefip state mean_gini branch_reform;
duplicates drop;

regress branch_reform mean_gini, robust;
twoway (scatter branch_reform mean_gini, msymbol(circle_hollow) mcolor(navy) mlabel(state) mlabcolor(navy)), 
       subtitle("(A)", size(small))
       ytitle("Year of bank deregulation") ytitle(, size(small)) ylabel(, labsize(small) angle(horizontal) nogrid) 
       xtitle(Average Gini coefficient prior to bank deregulation) xtitle(, size(small) margin(medsmall)) xlabel(, labsize(small)) 
       legend(off) graphregion(fcolor(white) lcolor(white) ifcolor(white) ilcolor(white));
       graph save Figure1A, asis replace;

       
***************;       
*** CHANGES ***;
***************;
use "/home/alevkov/BeckLevineLevkov2010/data/macro_workfile.dta", clear;
generate log_gini = log(gini);
sort statefip wrkyr;
bysort statefip: generate log_gini_lag = log_gini[_n-1]; 
generate d = log_gini - log_gini_lag;
xi: regress d i.wrkyr;
predict r, residual;
keep if wrkyr<branch_reform;

bysort statefip: egen growth = mean(r);
keep statefip state branch_reform growth;
duplicates drop;

regress branch_reform growth, robust;
twoway (scatter branch_reform growth, msymbol(circle_hollow) mcolor(navy) mlabel(state) mlabcolor(navy)), 
       subtitle("(B)", size(small))
       ytitle("Year of bank deregulation") ytitle(, size(small)) ylabel(, labsize(small) angle(horizontal) nogrid) 
       xtitle(Average change in the Gini coefficient prior to bank deregulation) xtitle(, size(small) margin(medsmall)) xlabel(, labsize(small)) 
       legend(off) graphregion(fcolor(white) lcolor(white) ifcolor(white) ilcolor(white));
       graph save Figure1B, asis replace;
       
log close;



