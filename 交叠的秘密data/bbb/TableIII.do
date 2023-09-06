**********************************************************************************************************************************
*** Date:    December 2009
*** Authors: Beck, Levine, and Levkov
*** Purpose: Create Table III in "Big Bad Banks? The Winners and Losers from Bank Deregulation in the United States"
*** Note:    Please change the working directories below 
**********************************************************************************************************************************


#delimit;
clear;
set mem 100m;
set more off;

cd "/home/alevkov/BeckLevineLevkov2010";

log using TableIII.log, replace;

use "/home/alevkov/BeckLevineLevkov2010/data/macro_workfile.dta", clear;

generate Y = log(gini/(1-gini));

tsset statefip wrkyr;

tabulate wrkyr, gen(year_dumm);


*** Column (1) ***;
generate _intra_unit = _intra*unit_banking;
label var _intra_unit "Deregulation x (unit banking)";
xtreg Y _intra unit_banking _intra_unit year_dumm*, fe i(statefip) robust cluster(statefip);
lincom _intra + _intra_unit; 


*** Column (2) ***;
generate _intra_dispersion = _intra*pop_dispersion;
label var _intra_dispersion "Deregulation x (initial population dispersion)";
sum pop_dispersion;
xtreg Y _intra pop_dispersion _intra_dispersion year_dumm*, fe i(statefip) robust cluster(statefip);
lincom _intra + 0.0099*_intra_dispersion;
lincom _intra + 0.0148*_intra_dispersion;
lincom _intra + 0.0376*_intra_dispersion;


*** Column (3) ***;
generate _intra_smallbanks = _intra*small_banks;
label var _intra_smallbanks "Deregulation x (initial share of small banks)";
sum small_banks, detail;
xtreg Y _intra small_banks _intra_smallbanks year_dumm*, fe i(statefip) robust cluster(statefip);
lincom _intra + 0.074*_intra_smallbanks;
lincom _intra + 0.109*_intra_smallbanks;
lincom _intra + 0.137*_intra_smallbanks;


*** Column (4) ***;
generate _intra_smallfirms = _intra*small_firms;
label var _intra_smallfirms "Deregulation x (initial share of small firms)";
sum small_firms, detail;
xtreg Y _intra small_firms _intra_smallfirms year_dumm*, fe i(statefip) robust cluster(statefip);
lincom _intra + 0.877*_intra_smallfirms;
lincom _intra + 0.885*_intra_smallfirms;
lincom _intra + 0.894*_intra_smallfirms;

log close;
