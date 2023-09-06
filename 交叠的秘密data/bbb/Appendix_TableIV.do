**********************************************************************************************************************************
*** Date:    December 2009
*** Authors: Beck, Levine, and Levkov
*** Purpose: Create Appendix Table IV in "Big Bad Banks? The Winners and Losers from Bank Deregulation in the United States"
*** Note:    Please change the working directories below
**********************************************************************************************************************************

#delimit;
clear;
set mem 100m;
set more off;

cd "/home/alevkov/BeckLevineLevkov2010";

log using Appendix_TableIV.log, replace;


**********************;
*** LOGISTIC(GINI) ***;
**********************;
use "/home/alevkov/BeckLevineLevkov2010/data/macro_workfile.dta", clear;
generate y = log(gini/(1-gini));
bysort statefip: egen mean1 = mean(y);
keep statefip mean1;
duplicates drop;
sort statefip;
save mean1, replace;

use "/home/alevkov/BeckLevineLevkov2010/data/macro_workfile.dta", clear;
generate y = log(gini/(1-gini));
bysort wrkyr: egen mean2 = mean(y);
keep wrkyr mean2;
duplicates drop;
sort wrkyr;
save mean2, replace;

use "/home/alevkov/BeckLevineLevkov2010/data/macro_workfile.dta", clear;
generate y = log(gini/(1-gini));
sort statefip;
merge statefip using mean1;
drop _merge;
tab1 statefip, missing;
sort wrkyr;
merge wrkyr using mean2;
tab1 wrkyr, missing;
erase mean1.dta;
erase mean2.dta;

generate state_de_trended       = y - mean1;
generate wrkyr_de_trended       = y - mean2;
generate state_wrkyr_de_trended = y - mean1 - mean2;

*** SIMPLE STATS ***;
summarize y;

*** CROSS-STATES STANDARD DEVIATION ***;
summarize state_de_trended;

*** WITHIN-STATES STANDARD DEVIATION ***;
summarize wrkyr_de_trended;

*** WITHIN STATE-wrkyr STANDARD DEVIATION ***;
summarize state_wrkyr_de_trended;


*****************;
*** LOG(GINI) ***;
*****************;
use "/home/alevkov/BeckLevineLevkov2010/data/macro_workfile.dta", clear;
generate y = log(gini);
bysort statefip: egen mean1 = mean(y);
keep statefip mean1;
duplicates drop;
sort statefip;
save mean1, replace;

use "/home/alevkov/BeckLevineLevkov2010/data/macro_workfile.dta", clear;
generate y = log(gini);
bysort wrkyr: egen mean2 = mean(y);
keep wrkyr mean2;
duplicates drop;
sort wrkyr;
save mean2, replace;

use "/home/alevkov/BeckLevineLevkov2010/data/macro_workfile.dta", clear;
generate y = log(gini);
sort statefip;
merge statefip using mean1;
drop _merge;
tab1 statefip, missing;
sort wrkyr;
merge wrkyr using mean2;
tab1 wrkyr, missing;
erase mean1.dta;
erase mean2.dta;

generate state_de_trended       = y - mean1;
generate wrkyr_de_trended       = y - mean2;
generate state_wrkyr_de_trended = y - mean1 - mean2;

*** SIMPLE STATS ***;
summarize y;

*** CROSS-STATES STANDARD DEVIATION ***;
summarize state_de_trended;

*** WITHIN-STATES STANDARD DEVIATION ***;
summarize wrkyr_de_trended;

*** WITHIN STATE-wrkyr STANDARD DEVIATION ***;
summarize state_wrkyr_de_trended;


******************;
*** LOG(THEIL) ***;
******************;
use "/home/alevkov/BeckLevineLevkov2010/data/macro_workfile.dta", clear;
generate y = log(theil);
bysort statefip: egen mean1 = mean(y);
keep statefip mean1;
duplicates drop;
sort statefip;
save mean1, replace;

use "/home/alevkov/BeckLevineLevkov2010/data/macro_workfile.dta", clear;
generate y = log(theil);
bysort wrkyr: egen mean2 = mean(y);
keep wrkyr mean2;
duplicates drop;
sort wrkyr;
save mean2, replace;

use "/home/alevkov/BeckLevineLevkov2010/data/macro_workfile.dta", clear;
generate y = log(theil);
sort statefip;
merge statefip using mean1;
drop _merge;
tab1 statefip, missing;
sort wrkyr;
merge wrkyr using mean2;
tab1 wrkyr, missing;
erase mean1.dta;
erase mean2.dta;

generate state_de_trended       = y - mean1;
generate wrkyr_de_trended       = y - mean2;
generate state_wrkyr_de_trended = y - mean1 - mean2;

*** SIMPLE STATS ***;
summarize y;

*** CROSS-STATES STANDARD DEVIATION ***;
summarize state_de_trended;

*** WITHIN-STATES STANDARD DEVIATION ***;
summarize wrkyr_de_trended;

*** WITHIN STATE-wrkyr STANDARD DEVIATION ***;
summarize state_wrkyr_de_trended;


******************;
*** LOG(90/10) ***;
******************;
use "/home/alevkov/BeckLevineLevkov2010/data/macro_workfile.dta", clear;
replace p10=1 if p10==0;
generate y = log(p90)-log(p10);
bysort statefip: egen mean1 = mean(y);
keep statefip mean1;
duplicates drop;
sort statefip;
save mean1, replace;

use "/home/alevkov/BeckLevineLevkov2010/data/macro_workfile.dta", clear;
replace p10=1 if p10==0;
generate y = log(p90)-log(p10);
bysort wrkyr: egen mean2 = mean(y);
keep wrkyr mean2;
duplicates drop;
sort wrkyr;
save mean2, replace;

use "/home/alevkov/BeckLevineLevkov2010/data/macro_workfile.dta", clear;
replace p10=1 if p10==0;
generate y = log(p90)-log(p10);
sort statefip;
merge statefip using mean1;
drop _merge;
tab1 statefip, missing;
sort wrkyr;
merge wrkyr using mean2;
tab1 wrkyr, missing;
erase mean1.dta;
erase mean2.dta;

generate state_de_trended       = y - mean1;
generate wrkyr_de_trended       = y - mean2;
generate state_wrkyr_de_trended = y - mean1 - mean2;

*** SIMPLE STATS ***;
summarize y;

*** CROSS-STATES STANDARD DEVIATION ***;
summarize state_de_trended;

*** WITHIN-STATES STANDARD DEVIATION ***;
summarize wrkyr_de_trended;

*** WITHIN STATE-wrkyr STANDARD DEVIATION ***;
summarize state_wrkyr_de_trended;


******************;
*** LOG(75/25) ***;
******************;
use "/home/alevkov/BeckLevineLevkov2010/data/macro_workfile.dta", clear;
generate y = log(p75)-log(p25);
bysort statefip: egen mean1 = mean(y);
keep statefip mean1;
duplicates drop;
sort statefip;
save mean1, replace;

use "/home/alevkov/BeckLevineLevkov2010/data/macro_workfile.dta", clear;
generate y = log(p75)-log(p25);
bysort wrkyr: egen mean2 = mean(y);
keep wrkyr mean2;
duplicates drop;
sort wrkyr;
save mean2, replace;

use "/home/alevkov/BeckLevineLevkov2010/data/macro_workfile.dta", clear;
generate y = log(p75)-log(p25);
sort statefip;
merge statefip using mean1;
drop _merge;
tab1 statefip, missing;
sort wrkyr;
merge wrkyr using mean2;
tab1 wrkyr, missing;
erase mean1.dta;
erase mean2.dta;

generate state_de_trended       = y - mean1;
generate wrkyr_de_trended       = y - mean2;
generate state_wrkyr_de_trended = y - mean1 - mean2;

*** SIMPLE STATS ***;
summarize y;

*** CROSS-STATES STANDARD DEVIATION ***;
summarize state_de_trended;

*** WITHIN-STATES STANDARD DEVIATION ***;
summarize wrkyr_de_trended;

*** WITHIN STATE-wrkyr STANDARD DEVIATION ***;
summarize state_wrkyr_de_trended;


log close;
