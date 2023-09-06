**********************************************************************************************************************************
*** Date:    December 2009
*** Authors: Beck, Levine, and Levkov
*** Purpose: Create Figure 6 in "Big Bad Banks? The Winners and Losers from Bank Deregulation in the United States"
*** Note:    Please change the working directories below
**********************************************************************************************************************************


#delimit;
clear;
set more off;
set memory 100m;

cd "/home/alevkov/BeckLevineLevkov2010";

log using Figure6.log, replace;

use "/home/alevkov/BeckLevineLevkov2010/data/macro_workfile.dta", clear;

generate _tintra = wrkyr - branch_reform;
replace  _tintra = -10 if _tintra <-10;
replace  _tintra =  15 if _tintra > 15;

tab _tintra, missing;

generate d_10 = 0; replace d_10 = 1 if _tintra == -10;
generate d_9  = 0; replace d_9  = 1 if _tintra == -9;
generate d_8  = 0; replace d_8  = 1 if _tintra == -8;
generate d_7  = 0; replace d_7  = 1 if _tintra == -7;
generate d_6  = 0; replace d_6  = 1 if _tintra == -6;
generate d_5  = 0; replace d_5  = 1 if _tintra == -5;
generate d_4  = 0; replace d_4  = 1 if _tintra == -4;
generate d_3  = 0; replace d_3  = 1 if _tintra == -3;
generate d_2  = 0; replace d_2  = 1 if _tintra == -2;
generate d_1  = 0; replace d_1  = 1 if _tintra == -1;

generate d1  = 0; replace d1  = 1 if _tintra == 1;
generate d2  = 0; replace d2  = 1 if _tintra == 2;
generate d3  = 0; replace d3  = 1 if _tintra == 3;
generate d4  = 0; replace d4  = 1 if _tintra == 4;
generate d5  = 0; replace d5  = 1 if _tintra == 5;
generate d6  = 0; replace d6  = 1 if _tintra == 6;
generate d7  = 0; replace d7  = 1 if _tintra == 7;
generate d8  = 0; replace d8  = 1 if _tintra == 8;
generate d9  = 0; replace d9  = 1 if _tintra == 9;
generate d10 = 0; replace d10 = 1 if _tintra == 10;
generate d11 = 0; replace d11 = 1 if _tintra == 11;
generate d12 = 0; replace d12 = 1 if _tintra == 12;
generate d13 = 0; replace d13 = 1 if _tintra == 13;
generate d14 = 0; replace d14 = 1 if _tintra == 14;
generate d15 = 0; replace d15 = 1 if _tintra == 15;

generate t5 = invttail(48,0.025);

tabulate wrkyr, gen(wrkyr_dumm);

replace unemploymentrate=unemploymentrate/100;

xtreg unemploymentrate d_10-d15 wrkyr_dumm*, fe i(statefip) robust cluster(statefip);

generate b_10 = _b[d_10]; generate se_b_10 = _se[d_10];
generate b_10LB = b_10 - t5*se_b_10;
generate b_10UB = b_10 + t5*se_b_10;

generate b_9 = _b[d_9]; generate se_b_9 = _se[d_9];
generate b_9LB = b_9 - t5*se_b_9;
generate b_9UB = b_9 + t5*se_b_9;

generate b_8 = _b[d_8]; generate se_b_8 = _se[d_8];
generate b_8LB = b_8 - t5*se_b_8;
generate b_8UB = b_8 + t5*se_b_8;

generate b_7 = _b[d_7]; generate se_b_7 = _se[d_7];
generate b_7LB = b_7 - t5*se_b_7;
generate b_7UB = b_7 + t5*se_b_7;

generate b_6 = _b[d_6]; generate se_b_6 = _se[d_6];
generate b_6LB = b_6 - t5*se_b_6;
generate b_6UB = b_6 + t5*se_b_6;

generate b_5 = _b[d_5]; generate se_b_5 = _se[d_5];
generate b_5LB = b_5 - t5*se_b_5;
generate b_5UB = b_5 + t5*se_b_5;

generate b_4 = _b[d_4]; generate se_b_4 = _se[d_4];
generate b_4LB = b_4 - t5*se_b_4;
generate b_4UB = b_4 + t5*se_b_4;

generate b_3 = _b[d_3]; generate se_b_3 = _se[d_3];
generate b_3LB = b_3 - t5*se_b_3;
generate b_3UB = b_3 + t5*se_b_3;

generate b_2 = _b[d_2]; generate se_b_2 = _se[d_2];
generate b_2LB = b_2 - t5*se_b_2;
generate b_2UB = b_2 + t5*se_b_2;

generate b_1 = _b[d_1]; generate se_b_1 = _se[d_1];
generate b_1LB = b_1 - t5*se_b_1;
generate b_1UB = b_1 + t5*se_b_1;

generate b1 = _b[d1]; generate se_b1 = _se[d1];
generate b1LB = b1 - t5*se_b1;

generate b1UB = b1 + t5*se_b1;

generate b2 = _b[d2]; generate se_b2 = _se[d2];
generate b2LB = b2 - t5*se_b2;
generate b2UB = b2 + t5*se_b2;

generate b3 = _b[d3]; generate se_b3 = _se[d3];
generate b3LB = b3 - t5*se_b3;
generate b3UB = b3 + t5*se_b3;

generate b4 = _b[d4]; generate se_b4 = _se[d4];
generate b4LB = b4 - t5*se_b4;
generate b4UB = b4 + t5*se_b4;

generate b5 = _b[d5]; generate se_b5 = _se[d5];
generate b5LB = b5 - t5*se_b5;
generate b5UB = b5 + t5*se_b5;

generate b6 = _b[d6]; generate se_b6 = _se[d6];
generate b6LB = b6 - t5*se_b6;
generate b6UB = b6 + t5*se_b6;

generate b7 = _b[d7]; generate se_b7 = _se[d7];
generate b7LB = b7 - t5*se_b7;
generate b7UB = b7 + t5*se_b7;

generate b8 = _b[d8]; generate se_b8 = _se[d8];
generate b8LB = b8 - t5*se_b8;
generate b8UB = b8 + t5*se_b8;

generate b9 = _b[d9]; generate se_b9 = _se[d9];
generate b9LB = b9 - t5*se_b9;
generate b9UB = b9 + t5*se_b9;

generate b10 = _b[d10]; generate se_b10 = _se[d10];
generate b10LB = b10 - t5*se_b10;
generate b10UB = b10 + t5*se_b10;

generate b11 = _b[d11]; generate se_b11 = _se[d11];
generate b11LB = b11 - t5*se_b11;
generate b11UB = b11 + t5*se_b11;

generate b12 = _b[d12]; generate se_b12 = _se[d12];
generate b12LB = b12 - t5*se_b12;
generate b12UB = b12 + t5*se_b12;

generate b13 = _b[d13]; generate se_b13 = _se[d13];
generate b13LB = b13 - t5*se_b13;
generate b13UB = b13 + t5*se_b13;

generate b14 = _b[d14]; generate se_b14 = _se[d14];
generate b14LB = b14 - t5*se_b14;
generate b14UB = b14 + t5*se_b14;

generate b15 = _b[d15]; generate se_b15 = _se[d15];
generate b15LB = b15 - t5*se_b15;
generate b15UB = b15 + t5*se_b15;

generate x=(b_10+b_9+b_8+b_7+b_6+b_5+b_4+b_3+b_2+b_1)/10;

generate b = .;
generate LB = .;
generate UB = .;

replace b = b_10  if _tintra == -10;
replace b = b_9  if _tintra == -9;
replace b = b_8  if _tintra == -8;
replace b = b_7  if _tintra == -7;
replace b = b_6  if _tintra == -6;
replace b = b_5  if _tintra == -5;
replace b = b_4  if _tintra == -4;
replace b = b_3  if _tintra == -3;
replace b = b_2  if _tintra == -2;
replace b = b_1  if _tintra == -1;
replace b = b1   if _tintra == 1;
replace b = b2   if _tintra == 2;
replace b = b3   if _tintra == 3;
replace b = b4   if _tintra == 4;
replace b = b5   if _tintra == 5;
replace b = b6   if _tintra == 6;
replace b = b7   if _tintra == 7;
replace b = b8   if _tintra == 8;
replace b = b9   if _tintra == 9;
replace b = b10  if _tintra == 10;
replace b = b11  if _tintra == 11;
replace b = b12  if _tintra == 12;
replace b = b13  if _tintra == 13;
replace b = b14  if _tintra == 14;
replace b = b15  if _tintra == 15;

replace LB = b_10LB if _tintra == -10;
replace LB = b_9LB if _tintra == -9;
replace LB = b_8LB if _tintra == -8;
replace LB = b_7LB if _tintra == -7;
replace LB = b_6LB if _tintra == -6;
replace LB = b_5LB if _tintra == -5;
replace LB = b_4LB if _tintra == -4;
replace LB = b_3LB if _tintra == -3;
replace LB = b_2LB if _tintra == -2;
replace LB = b_1LB if _tintra == -1;
replace LB = b1LB  if _tintra == 1;
replace LB = b2LB  if _tintra == 2;
replace LB = b3LB  if _tintra == 3;
replace LB = b4LB  if _tintra == 4;
replace LB = b5LB  if _tintra == 5;
replace LB = b6LB  if _tintra == 6;
replace LB = b7LB  if _tintra == 7;
replace LB = b8LB  if _tintra == 8;
replace LB = b9LB  if _tintra == 9;
replace LB = b10LB  if _tintra == 10;
replace LB = b11LB  if _tintra == 11;
replace LB = b12LB  if _tintra == 12;
replace LB = b13LB  if _tintra == 13;
replace LB = b14LB  if _tintra == 14;
replace LB = b15LB  if _tintra == 15;

replace UB = b_10UB if _tintra == -10;
replace UB = b_9UB if _tintra == -9;
replace UB = b_8UB if _tintra == -8;
replace UB = b_7UB if _tintra == -7;
replace UB = b_6UB if _tintra == -6;
replace UB = b_5UB if _tintra == -5;
replace UB = b_4UB if _tintra == -4;
replace UB = b_3UB if _tintra == -3;
replace UB = b_2UB if _tintra == -2;
replace UB = b_1UB if _tintra == -1;
replace UB = b1UB  if _tintra == 1;
replace UB = b2UB  if _tintra == 2;
replace UB = b3UB  if _tintra == 3;
replace UB = b4UB  if _tintra == 4;
replace UB = b5UB  if _tintra == 5;
replace UB = b6UB  if _tintra == 6;
replace UB = b7UB  if _tintra == 7;
replace UB = b8UB  if _tintra == 8;
replace UB = b9UB  if _tintra == 9;
replace UB = b10UB if _tintra == 10;
replace UB = b11UB if _tintra == 11;
replace UB = b12UB if _tintra == 12;
replace UB = b13UB if _tintra == 13;
replace UB = b14UB if _tintra == 14;
replace UB = b15UB if _tintra == 15;

gen trend=(b_10-b_1)/9;

keep _tintra b LB UB trend;
duplicates drop;

replace b=b-trend*(-_tintra)   if _tintra<0;
replace LB=LB-trend*(-_tintra) if _tintra<0;
replace UB=UB-trend*(-_tintra) if _tintra<0;

replace b=b+trend*_tintra   if _tintra>0;
replace LB=LB+trend*_tintra if _tintra>0;
replace UB=UB+trend*_tintra if _tintra>0;

sort _tintra;


twoway (connected b  _tintra, sort lcolor(navy) mcolor(navy) msymbol(circle_hollow) cmissing(n))
       (rcap LB UB _tintra, lcolor(navy) lpattern(dash) msize(medium)),
       ytitle(Percentage change) ytitle(, size(small)) 
       yline(0, lwidth(vthin) lpattern(dash) lcolor(teal)) ylabel(, labsize(small) angle(horizontal) nogrid) 
       xtitle(Years relative to branch deregulation) xtitle(, size(small)) 
       xline(0, lwidth(vthin) lpattern(dash) lcolor(teal)) xlabel(-10(5)15, labsize(small)) xmtick(-10(1)15, nolabels ticks) 
       legend(off)
       graphregion(fcolor(white) lcolor(white) ifcolor(white) ilcolor(white));
       graph save Figure6, asis replace;
       
log close;

