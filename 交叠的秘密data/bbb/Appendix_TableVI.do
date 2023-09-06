**********************************************************************************************************************************
*** Date:    December 2009
*** Authors: Beck, Levine, and Levkov
*** Purpose: Create Appendix Table VI in "Big Bad Banks? The Winners and Losers from Bank Deregulation in the United States"
*** Note:    Please change the working directories below 
**********************************************************************************************************************************


#delimit;
clear;
set mem 100m;
set matsize 10000;
set more off;

cd "/home/alevkov/BeckLevineLevkov2010";

log using Appendix_TableVI.log, replace;

use "/home/alevkov/BeckLevineLevkov2010/data/macro_workfile.dta", clear;

label var _intra "Bank deregulation";

tsset statefip wrkyr;

tabulate wrkyr, gen(wrkyr_dumm);
tabulate statefip, gen(state_dumm);

replace p10 = 1 if p10==0;

generate logistic_gini = log(gini/(1-gini));
generate log_gini      = log(gini);
generate log_theil     = log(theil);
generate log_9010      = log(p90)-log(p10);
generate log_7525      = log(p75)-log(p25);

local Xs gsp_pc_growth prop_blacks prop_dropouts prop_female_headed unemploymentrate;

xtreg logistic_gini _intra  wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
estimates store m1, title(Logistic Gini);
xtreg logistic_gini wrkyr_dumm*, fe i(statefip) robust cluster(statefip);

xtreg log_gini _intra  wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
estimates store m2, title(Log Gini);
xtreg log_gini wrkyr_dumm*, fe i(statefip) robust cluster(statefip);

xtreg log_theil _intra  wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
estimates store m3, title(Log Theil);
xtreg log_theil wrkyr_dumm*, fe i(statefip) robust cluster(statefip);

xtreg log_9010 _intra  wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
estimates store m4, title(Log 90/10);
xtreg log_9010 wrkyr_dumm*, fe i(statefip) robust cluster(statefip);

xtreg log_7525 _intra  wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
estimates store m5, title(Log 75/25);
xtreg log_7525 wrkyr_dumm*, fe i(statefip) robust cluster(statefip);


*** Bootstraped standard errors ***;
bootstrap, reps(500): regress logistic_gini _intra  wrkyr_dumm* state_dumm*;
bootstrap, reps(500): regress log_gini      _intra  wrkyr_dumm* state_dumm*;
bootstrap, reps(500): regress log_theil     _intra  wrkyr_dumm* state_dumm*;
bootstrap, reps(500): regress log_9010      _intra  wrkyr_dumm* state_dumm*;
bootstrap, reps(500): regress log_7525      _intra  wrkyr_dumm* state_dumm*;


*** SUR standard errors ***;
sureg (logistic_gini _intra wrkyr_dumm* state_dumm*)
      (log_gini      _intra wrkyr_dumm* state_dumm*)
      (log_theil     _intra wrkyr_dumm* state_dumm*)
      (log_9010      _intra wrkyr_dumm* state_dumm*)
      (log_7525      _intra wrkyr_dumm* state_dumm*);
      
estout m1 m2 m3 m4 m5 using Appendix_TableVI.txt, replace
keep(_intra)
cells(b(star fmt(3)) se(par) p(fmt(3) par({ }))) stats(r2 N, labels("R-squared" "Observations") fmt(2 0)) 
legend label collabel(none)
prehead("The Impact of Deregulation on Income Inequality" "Robustness to Standard Errors")
posthead("Panel A: No controls")
postfoot("")
starlevel(* 0.10 ** 0.05 *** 0.01);


xtreg logistic_gini _intra `Xs' wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
estimates store m1, title(Logistic Gini);

xtreg log_gini _intra `Xs' wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
estimates store m2, title(Log Gini);

xtreg log_theil _intra `Xs' wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
estimates store m3, title(Log Theil);

xtreg log_9010 _intra `Xs' wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
estimates store m4, title(Log 90/10);

xtreg log_7525 _intra `Xs' wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
estimates store m5, title(Log 75/25);


*** Bootstraped standard errors ***;
bootstrap, reps(500): regress logistic_gini _intra `Xs' wrkyr_dumm* state_dumm*;
bootstrap, reps(500): regress log_gini      _intra `Xs' wrkyr_dumm* state_dumm*;
bootstrap, reps(500): regress log_theil     _intra `Xs' wrkyr_dumm* state_dumm*;
bootstrap, reps(500): regress log_9010      _intra `Xs' wrkyr_dumm* state_dumm*;
bootstrap, reps(500): regress log_7525      _intra `Xs' wrkyr_dumm* state_dumm*;


*** SUR standard errors ***;
sureg (logistic_gini _intra `Xs' wrkyr_dumm* state_dumm*)
      (log_gini      _intra `Xs' wrkyr_dumm* state_dumm*) 
      (log_theil     _intra `Xs' wrkyr_dumm* state_dumm*)
      (log_9010      _intra `Xs' wrkyr_dumm* state_dumm*) 
      (log_7525      _intra `Xs' wrkyr_dumm* state_dumm*);


estout m1 m2 m3 m4 m5 using Appendix_TableVI.txt, append
keep(_intra `Xs')
cells(b(star fmt(3)) se(par) p(fmt(3) par({ }))) stats(r2 N, labels("R-squared" "Observations") fmt(2 0)) 
legend label collabel(none)
posthead("Panel B: With controls")
postfoot("")
starlevel(* 0.10 ** 0.05 *** 0.01);

log close;

