**********************************************************************************************************************************
*** Date:    December 2009
*** Authors: Beck, Levine, and Levkov
*** Purpose: Create Table II in "Big Bad Banks? The Winners and Losers from Bank Deregulation in the United States"
*** Note:    Please change the working directories below 
**********************************************************************************************************************************


#delimit;
clear;
set mem 100m;
set more off;

cd "/Users/xuwenli/OneDrive/DSGE建模及软件编程/教学大纲与讲稿/应用计量经济学讲稿/bbb";

log using TableII.log, replace;

use "/Users/xuwenli/OneDrive/DSGE建模及软件编程/教学大纲与讲稿/应用计量经济学讲稿/bbb/macro_workfile.dta", clear;

label var _intra "Bank deregulation";

xtset statefip wrkyr;

tabulate wrkyr, gen(wrkyr_dumm);
tabulate statefip, gen(state_dumm);

replace p10 = 1 if p10==0;

generate logistic_gini = log(gini/(1-gini));
generate log_gini      = log(gini);
generate log_theil     = log(theil);
generate log_9010      = log(p90)-log(p10);
generate log_7525      = log(p75)-log(p25);

local Xs gsp_pc_growth prop_blacks prop_dropouts prop_female_headed unemploymentrate;

*xtreg logistic_gini _intra  wrkyr_dumm*, fe i(statefip) robust cluster(statefip);

reghdfe logistic_gini _intra , ab(statefip wrkyr) vce(cluster statefip);
estimates store m1, title(Logistic Gini);

* xtreg log_gini _intra  wrkyr_dumm*, fe i(statefip) robust cluster(statefip);

reghdfe log_gini _intra , ab(statefip wrkyr) vce(cluster statefip);
estimates store m2, title(Log Gini);

*xtreg log_theil _intra  wrkyr_dumm*, fe i(statefip) robust cluster(statefip);

reghdfe log_theil _intra , ab(statefip wrkyr) vce(cluster statefip);
estimates store m3, title(Log Theil);

*xtreg log_9010 _intra  wrkyr_dumm*, fe i(statefip) robust cluster(statefip);

reghdfe log_9010 _intra , ab(statefip wrkyr) vce(cluster statefip);
estimates store m4, title(Log 90/10);

*xtreg log_7525 _intra  wrkyr_dumm*, fe i(statefip) robust cluster(statefip);

reghdfe log_7525 _intra , ab(statefip wrkyr) vce(cluster statefip);
estimates store m5, title(Log 75/25);

estout m1 m2 m3 m4 m5 using TableII.txt, replace
keep(_intra)
cells(b(star fmt(3)) se(par({ }))) stats(r2 N, labels("R-squared" "Observations") fmt(2 0)) 
legend label collabel(none)
prehead("表1" "去管制政策对收入分配的影响")
posthead("Panel A: 无控制变量")
postfoot("")
starlevel(* 0.10 ** 0.05 *** 0.01);


* xtreg logistic_gini _intra `Xs' wrkyr_dumm*, fe i(statefip) robust cluster(statefip);

reghdfe logistic_gini _intra `Xs', ab(statefip wrkyr) vce(cluster statefip);
estimates store m1, title(Logistic Gini);

* xtreg log_gini _intra `Xs' wrkyr_dumm*, fe i(statefip) robust cluster(statefip);

reghdfe log_gini _intra `Xs', ab(statefip wrkyr) vce(cluster statefip);
estimates store m2, title(Log Gini);

* xtreg log_theil _intra `Xs' wrkyr_dumm*, fe i(statefip) robust cluster(statefip);

reghdfe log_theil _intra `Xs', ab(statefip wrkyr) vce(cluster statefip);
estimates store m3, title(Log Theil);

* xtreg log_9010 _intra `Xs' wrkyr_dumm*, fe i(statefip) robust cluster(statefip);

reghdfe log_9010 _intra `Xs', ab(statefip wrkyr) vce(cluster statefip);
estimates store m4, title(Log 90/10);

* xtreg log_7525 _intra `Xs' wrkyr_dumm*, fe i(statefip) robust cluster(statefip);

reghdfe log_7525 _intra `Xs', ab(statefip wrkyr) vce(cluster statefip);
estimates store m5, title(Log 75/25);


estout m1 m2 m3 m4 m5 using TableII.txt, append
keep(_intra `Xs')
cells(b(star fmt(3)) se(par({ })) ) stats(r2 N, labels("R-squared" "Observations") fmt(2 0)) 
legend label collabel(none)
posthead("Panel B: 有控制变量")
postfoot("")
starlevel(* 0.10 ** 0.05 *** 0.01);

log close;

