************************************************************
* 许文立，2021:《交叠的秘密：经济学领域交叠DID导读与实践建议》
* 配套dofile

************************************************************
* 一、模拟数据的Bacon分解
************************************************************


clear
local units = 300
local start = 1
local end 	= 60

local time = `end' - `start' + 1
local obsv = `units' * `time'
set obs `obsv'

egen id	   = seq(), b(`time')  
egen t 	   = seq(), f(`start') t(`end') 	

sort  id t
xtset id t

lab var id "Panel variable"
lab var t  "Time  variable"


set seed 13082021



cap drop Y
cap drop D
cap drop cohort
cap drop effect
cap drop timing

gen Y 	   = 0					// outcome variable	
gen D 	   = 0					// intervention variable
gen cohort = .  				// total treatment variables
gen effect = .					// treatment effect size
gen timing = .					// when the treatment happens for each cohort


levelsof id, local(lvls)
foreach x of local lvls {
	local chrt = runiformint(0,6)	
	replace cohort = `chrt' if id==`x'
}

levelsof cohort , local(lvls)  //  let all cohorts be treated for now
foreach x of local lvls {
	
	// (a) effect
	
	local eff = runiformint(5,20)
		replace effect = `eff' if cohort==`x'
		
	// (b) timing	
	
	local timing = runiformint(`start' + 5,`end' - 5)	
	replace timing = `timing' if cohort==`x'
		replace D = 1 if cohort==`x' & t>= `timing' 
}

replace Y = id + t + cond(D==1, effect * (t - timing), 0)

levelsof cohort
local items = `r(r)'

local lines
levelsof id


forval x = 1/`r(r)' {
	
	qui summ cohort if id==`x'
	local color = `r(mean)' + 1
	colorpalette tableau, nograph
		
	local lines `lines' (line Y t if id==`x', lc("`r(p`color')'") lw(vthin))	||
}

twoway ///
	`lines'	///
		,	legend(off)


reghdfe Y D, absorb(id t)  

bacondecomp Y D,ddetail legend(lab(1 "先处理(处理组) vs. 后处理(控制组)") lab(2 "后处理(处理组) vs. 先处理(控制组)"))

************************************************************
* 二、BLL（2021，JF，“Big bad bank”）
************************************************************

// 表1的回归结果

#delimit;
clear;
set mem 100m;
set more off;

cd "/Users/xuwenli/OneDrive/DSGE建模及软件编程/教学大纲与讲稿/应用计量经济学讲稿/bbb";

// log using TableII.log, replace;

use "/Users/xuwenli/OneDrive/DSGE建模及软件编程/教学大纲与讲稿/应用计量经济学讲稿/bbb/macro_workfile.dta", clear;

label var _intra "Bank deregulation"

xtset statefip wrkyr

tabulate wrkyr, gen(wrkyr_dumm)
tabulate statefip, gen(state_dumm)

replace p10 = 1 if p10==0

generate logistic_gini = log(gini/(1-gini))
generate log_gini      = log(gini)
generate log_theil     = log(theil)
generate log_9010      = log(p90)-log(p10)
generate log_7525      = log(p75)-log(p25)

local Xs gsp_pc_growth prop_blacks prop_dropouts prop_female_headed unemploymentrate


// 处理状态图
// 加载处理状态图的panelview
// ssc install panelview,replace

panelview logistic_gini _intra,i(statefip) t(wrkyr) type(treat) xtitle("时间") ytitle("地区")

// TWFE回归结果

*xtreg logistic_gini _intra  wrkyr_dumm*, fe i(statefip) robust cluster(statefip);

reghdfe logistic_gini _intra , ab(statefip wrkyr) vce(cluster statefip)
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

local Xs gsp_pc_growth prop_blacks prop_dropouts prop_female_headed unemploymentrate

reghdfe logistic_gini _intra `Xs', ab(statefip wrkyr) vce(cluster statefip)
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

// 培根分解
xtset statefip wrkyr

ddtiming logistic_gini _intra,i(statefip) t(wrkyr)


// 偏误诊断：图5 负的权重图

set scheme s1mono
set seed 123456

// 产生权重

reg logistic_gini i.statefip i.wrkyr
predict yres_lgini, resid
replace yres_lgini = . if logistic_gini==.

reg _intra i.statefip i.wrkyr if logistic_gini!=.
predict tres_lgini, resid
replace tres_lgini = . if logistic_gini==.

gen tresp2 = tres_lgini*tres_lgini if logistic_gini!=.
egen tvariance = sum(tresp2)
gen weight_lgini = tres_lgini/tvariance 
replace weight_lgini = . if logistic_gini==.

gen yxtres_lgini = logistic_gini*tres_lgini if logistic_gini!=.
egen numer = sum(yxtres_lgini)
gen betahat = numer/tvariance

drop tresp2 tvariance numer betahat

// 权重直方图
tw ///
	(histogram weight_lgini if _intra==0, frac bcolor(vermillion%40)) ///
	(histogram weight_lgini if _intra==1, frac bcolor(sea%60)), ///
	xtitle(" " "余值化处理变量") xlabel(-0.007(0.001)0.006) ytitle(" " "比重") ///
	legend(order(2 1) label(1 "控制组") label(2 "处理组") col(1) ring(0) pos(11) size(small)) ///
	plotregion(margin(small))

// 偏误诊断：同质处理效应的检验

// 图6 检验线性关系

tw ///
	(scatter yres_lgini tres_lgini if _intra==0, msymbol(o) color(vermillion%20)) ///
	(scatter yres_lgini tres_lgini if _intra==1, msymbol(o) color(sea%20)) ///	
	(lpoly yres_lgini tres_lgini if _intra==0, lcolor(vermillion) lpattern(longdash) deg(1) bw(0.1)) ///
	(lfit yres_lgini tres_lgini if _intra==0, lcolor(vermillion) lpattern(solid)) ///	
	(lpoly yres_lgini tres_lgini if _intra==1, lcolor(sea) lpattern(longdash) deg(1) bw(0.1)) ///
	(lfit yres_lgini tres_lgini if _intra==1, lcolor(sea) lpattern(solid)), ///	
	legend(order(2 1) cols(1) label(2 "处理组") label(1 "控制组") ///
	ring(0) pos(11)) ///
	xtitle(" " "余值化处理变量") ytitle("余值化结果" " ")

// REGRESSIONS

gen txtres_lgini = _intra*tres_lgini

reg yres_lgini tres_lgini _intra txtres_lgini
mat V = r(table)
local _tempbeta1a = string(V[1,1],"%04.2f")
local _tempse1a = string(V[2,1],"%04.2f")
local _temppval1a = string(V[4,1],"%04.2f")
local _tempbeta1b = string(V[1,2],"%04.2f")
local _tempse1b = string(V[2,2],"%04.2f")
local _temppval1b = string(V[4,2],"%04.2f")
local _tempbeta1c = string(V[1,3],"%04.2f")
local _tempse1c = string(V[2,3],"%04.2f")
local _temppval1c = string(V[4,3],"%04.2f")

// dCHD权重分解
twowayfeweights logistic_gini statefip wrkyr _intra,type(feTR) test_random_weights(wrkyr)




// 事件研究

* 复制BLL2010结果

xtevent logistic_gini `Xs', pol(_intra) w(-9 14)  p(statefip) t(wrkyr)vce(cluster statefip) plot

* 去掉1977年以前就已经放松管制的地区

drop if statefip ==2 |statefip ==4 |statefip ==6 |statefip ==11 |statefip ==16 |statefip ==23 |statefip ==24 |statefip ==32 |statefip ==37 |statefip ==44 |statefip ==45 |statefip ==50

xtevent logistic_gini `Xs', pol(_intra) w(-9 14)  p(statefip) t(wrkyr)vce(cluster statefip) plot

// 其它稳健估计量

* 初次处理时间

bys statefip (wrkyr): egen Ei = min(wrkyr) if _intra ==1

* bys statefip :fillmissing Ei,with(next)

sort statefip Ei

bys statefip : replace Ei=Ei[1]

* 创建相对时间, 例如，处理后的时期数（如果从未处理，则缺失）
	gen K = wrkyr-Ei


// did_imputation of Borusyak et al. (2021)

	*Estimation
	did_imputation logistic_gini statefip wrkyr Ei, horizons(0/5) pretrends(5) autosample
	// Y:	outcome variable
	// i:	unit id variable
	// t:	time period variable
	// Ei:	variable for unit-specific treatment date (never-treated: Ei == missing)

	// allhorizons: include all non-negative horizons available
	// pretrends(): number of pre-treatment coefficients to be estimated (with too many pre-trend coefficients, the power of the joint test will be lower.)
	// standard errors are clustered at unit level by default

	*Plotting
	event_plot, default_look graph_opt(xtitle("事件发生后时期") ytitle("平均处理效应") ///
		title("Borusyak et al. (2021) imputation estimator") xlabel(-5(1)5) name(BJS, replace)) together

	*Storing estimates for later
	estimates store bjs
	
	
// did_multiplegt of de Chaisemartin and D'Haultfoeuille (2020)

	*Estimation
	did_multiplegt logistic_gini statefip wrkyr _intra, robust_dynamic dynamic(5) placebo(5) longdiff_placebo breps(100) cluster(statefip)
	// Y:	outcome variable
	// i:	unit id variable
	// t:	time period variable
	// D:	treatment variable
	
	// robust_dynamic: uses estimator from dCdH (2021) on DID with intertemporal effects
	// dynamic(): number of dynamic treatment effects to be estimated (can only be used with robust_dynamic)
	// placebo(): number of placebo estimates to be estimated (When the longdiff_placebo and dynamic options are requested, the number of placebos requested cannot be larger than the number of dynamic effects)
	// longdiff_placebo: estimates placebo effects using long differences (comparable to dynamic TE estimates)
	// breps(): number of bootstrap iterations for computation of standard errors
	// cluster(i): computes standard errors using block bootstrap at level specified
	
	// Note that, according to the help file, by default "placebos are
	// first-difference estimators, while dynamic effects are long-difference
	// estimators, so they are not really comparable." Thus, we should not plot
	// and compare them in the same graph, if the "longdiff_placebo" option is
	// not specified.

	*Plotting
	event_plot e(estimates)#e(variances), default_look graph_opt(xtitle("事件发生后时期") ///
		ytitle("平均处理效应") title("de Chaisemartin and D'Haultfoeuille (2020)") xlabel(-5(1)5) ///
		name(dCdH, replace)) stub_lag(Effect_#) stub_lead(Placebo_#) together
	// bmat#vmat: name of point estimate matrix and name of variance-covariance matrix
	// stub_lag((prefix#postfix): name of lag coefficients in estimation output
	// stub_lead(prefix#postfix): name of lead coefficients in estimation output
	// graph_opt(): twoway options for graph overall
	// together: show leads and lags as one line

	*Storing estimates for later
	matrix dcdh_b = e(estimates)
	matrix dcdh_v = e(variances)


// csdid of Callaway and Sant'Anna (2021) (v1.6 written by Fernando Rios-Avila @friosavila)

	*Preparation
	gen gvar = cond(Ei>1999, 0, Ei) // group variable as required for the csdid command

	*Estimation
	 csdid logistic_gini, ivar(statefip) time(wrkyr) gvar(gvar) method(reg)
	 estat event
	// Y: 		outcome variable
	// ivar():	unit id variable
	// time():	time period variable
	// gvar():	variable for unit-specific treatment date (never treated: gvar == 0)
	// (defines "group" in CS jargon)
	
	// agg(): aggregation to use
	// wboot: Wild Bootstrap standard errors (default is asymptotic normal)
	// cluster(): should in principle be possible but throws an error (for me at least)
	// by default uses never treated units as control group (could specify "notyet")
	
	// Note that this command is work in progress. As such, it may subject to
	// ongoing changes. For example, the wboot option currently seems to
	// throw an error if specified. Further, the confidence intervals are not
	// yet correct (not uniform as in CS).
	
	// Also, note that Nick Huntington-Klein provides a Stata package that
	// acts as a wrapper for the "did" package by CS in R (via rcall, i.e. 
	// need to have R installed). It is available on his github page:
	// https://github.com/NickCH-K/did

	*Plotting
	event_plot e(b)#e(V), default_look graph_opt(xtitle("事件发生后时期") ///
		ytitle("平均处理效应") xlabel(-14(1)5) title("Callaway and Sant'Anna (2020)") name(CS, replace)) ///
		stub_lag(T+#) stub_lead(T-#) together

	*Storing estimates for later
	matrix cs_b = e(b)
	matrix cs_v = e(V)


// eventstudyinteract of Sun and Abraham (2020)

	*Preparation
	sum Ei
	gen lastcohort = Ei==r(max) // dummy for the latest- or never-treated cohort
	forvalues l = 0/5 {
		gen L`l'event = K==`l'
	}
	forvalues l = 1/14 {
		gen F`l'event = K==-`l'
	}
	drop F1event // normalize K=-1 (and also K=-15) to zero

	*Estimation
	eventstudyinteract logistic_gini L*event F*event, vce(cluster statefip) absorb(statefip wrkyr) cohort(Ei) control_cohort(lastcohort)
	// Y: outcome variable
	// L*event: lags to include
	// F*event: leads to include
	// vce(): options for variance-covariance matrix (cluster SE)
	// absorb(): absorb unit and time fixed effects
	// cohort(): variable for unit-specific treatment date (never-treated: Ei == missing)
	// control_cohort(): indicator variable for control cohort (either latest-treated or never-treated units)

	*Plotting
	event_plot e(b_iw)#e(V_iw), default_look graph_opt(xtitle("事件发生后时期") ///
		ytitle("平均处理效应") xlabel(-14(1)5) title("Sun and Abraham (2020)") name(SA, replace)) ///
		stub_lag(L#event) stub_lead(F#event) together

	*Storing estimates for later
	matrix sa_b = e(b_iw)
	matrix sa_v = e(V_iw)


// did2s of Gardner (2021)

	* Estimation
	did2s logistic_gini, first_stage(i.statefip i.wrkyr) second_stage(F*event L*event) treatment(_intra) cluster(statefip)
	// Y: outcome variable
	// first_stage(): fixed effects used to estimate counterfactual Y_it(0). This should be everything besides treatment
	// second_stage(): treatment such as dummy variable or event-study leads and lags
	// cluster(): variable to cluster on 

	
	*Plotting
	event_plot, default_look stub_lag(L#event) stub_lead(F#event) together ///
		graph_opt(xtitle("事件发生后时期") ytitle("平均处理效应") xlabel(-14(1)5) ///
		title("Gardner (2021)") name(DID2S, replace))
		
	*Saving estimates for later
	matrix did2s_b = e(b)
	matrix did2s_v = e(V)

	
// stackedev of Cengiz et al. (2019) 

	*Create a variable equal to the time that the unit first received treatment. It must be missing for never treated units.
	gen treat_year=.
	replace treat_year=Ei if Ei!=2000

	*Create never treated indicator that equals one if a unit never received treatment and zero if it did.
	gen no_treat= (Ei==2000)

	*Preparation
	cap drop F*event L*event
	sum Ei
	forvalues l = 0/5 {
		gen L`l'event = K==`l'
		replace L`l'event = 0 if no_treat==1
	}
	forvalues l = 1/14 {
		gen F`l'event = K==-`l'
		replace F`l'event = 0 if no_treat==1
	}
	drop F1event // normalize K=-1 (and also K=-15) to zero

	* Run stackedev		
	preserve
	stackedev logistic_gini F*event L*event, cohort(treat_year) time(wrkyr) never_treat(no_treat) unit_fe(statefip) clust_unit(statefip) 
	restore
	// Y: outcome variable
	// L*event: lags to include
	// F*event: leads to include
	// time(): numerical variable equal to time
	// never_treat(): binary indicator that equals one if a unit never received treatment and zero if it did
	// unit_fe(): variable indicating unit fixed effects
	// clust_unit(): variable indicating the unit by which to cluster variances
	

	*Plotting
	event_plot e(b)#e(V), default_look graph_opt(xtitle("事件发生后时期") ///
		ytitle("平均处理效应") xlabel(-14(1)5) title("Cengiz et al. (2019)") name(CDLZ, replace)) ///
		stub_lag(L#event) stub_lead(F#event) together	
		
	*Saving estimates for later
	matrix stackedev_b = e(b)
	matrix stackedev_v = e(V)
	
	
// TWFE OLS estimation

	*Estimation
	reghdfe logistic_gini F*event L*event, absorb(statefip wrkyr) vce(cluster statefip)

	*Plotting
	event_plot, default_look stub_lag(L#event) stub_lead(F#event) together ///
		graph_opt(xtitle("事件发生后时期") ytitle("OLS系数") xlabel(-14(1)5) ///
		title("OLS") name(OLS, replace))

	*Saving estimates for later
	estimates store ols

	
	
// Construct vector of true average treatment effects by number of periods since treatment

//	matrix btrue = J(1,6,.)
//	matrix colnames btrue = tau0 tau1 tau2 tau3 tau4 tau5
//	qui forvalues h = 0/5 {
//		sum tau if K==`h'
//		matrix btrue[1,`h'+1]=r(mean)
//	}


// Combine all plots using the stored estimates (5 leads and lags around event)

event_plot bjs dcdh_b#dcdh_v cs_b#cs_v sa_b#sa_v did2s_b#did2s_v stackedev_b#stackedev_v ols, ///
	stub_lag(tau# Effect_# T+# L#event L#event L#event L#event) stub_lead(pre# Placebo_# T-# F#event F#event F#event F#event) ///
	plottype(scatter) ciplottype(rcap) ///
	together perturb(-0.325(0.1)0.325) trimlead(5) noautolegend ///
	graph_opt(title("稳健估计量", size(med)) ///
		xtitle("事件发生后时期", size(small)) ytitle("平均处理效应", size(small)) xlabel(-5(1)5)  ///
		legend(order(1 "Borusyak et al." 4 "de Chaisemartin-D'Haultfoeuille" ///
				 6 "Callaway-Sant'Anna" 8 "Sun-Abraham" 10 "Gardner" 12 "Cengiz et al." 14 "TWFE OLS") rows(2) position(6) region(style(none))) ///
	/// the following lines replace default_look with something more elaborate
		xline(-0.5, lcolor(gs8) lpattern(dash)) yline(0, lcolor(gs8)) graphregion(color(white)) bgcolor(white) ylabel(, angle(horizontal)) ///
	) ///
//	lag_opt1(msymbol(+) color(black)) lag_ci_opt1(color(black)) ///
	lag_opt2(msymbol(O) color(cranberry)) lag_ci_opt2(color(cranberry)) ///
	lag_opt3(msymbol(Dh) color(navy)) lag_ci_opt3(color(navy)) ///
    lag_opt4(msymbol(Th) color(forest_green)) lag_ci_opt4(color(forest_green)) ///
	lag_opt5(msymbol(Sh) color(dkorange)) lag_ci_opt5(color(dkorange)) ///
	lag_opt6(msymbol(Th) color(blue)) lag_ci_opt6(color(blue)) 
	lag_opt7(msymbol(Dh) color(red)) lag_ci_opt7(color(red)) ///
    lag_opt8(msymbol(Oh) color(purple)) lag_ci_opt8(color(purple))
// graph export "$output/seven_estimators_example_5t.png", replace

// Combine all plots using the stored estimates (5 leads and lags around event)

    event_plot bjs dcdh_b#dcdh_v cs_b#cs_v sa_b#sa_v did2s_b#did2s_v stackedev_b#stackedev_v ols, ///
	stub_lag(tau# Effect_# T+# L#event L#event L#event L#event) stub_lead(pre# Placebo_# T-# F#event F#event F#event F#event) ///
	plottype(scatter) ciplottype(rcap) ///
	together perturb(-0.325(0.1)0.325) trimlead(14) noautolegend ///
	graph_opt(title("Event study estimators in a simulated panel (400 units, 15 periods)", size(med)) ///
		xtitle("Periods since the event", size(small)) ytitle("Average causal effect", size(small)) xlabel(-14(1)5)  ///
		legend(order( 2 "Borusyak et al." 4 "de Chaisemartin-D'Haultfoeuille" ///
				 6 "Callaway-Sant'Anna" 8 "Sun-Abraham" 10 "Gardner" 12 "Cengiz et al." 14 "TWFE OLS") rows(2) position(6) region(style(none))) ///
	/// the following lines replace default_look with something more elaborate
		xline(-0.5, lcolor(gs8) lpattern(dash)) yline(0, lcolor(gs8)) graphregion(color(white)) bgcolor(white) ylabel(, angle(horizontal)) ///
	) ///
//	lag_opt1(msymbol(+) color(black)) lag_ci_opt1(color(black)) ///
	lag_opt2(msymbol(O) color(cranberry)) lag_ci_opt2(color(cranberry)) ///
	lag_opt3(msymbol(Dh) color(navy)) lag_ci_opt3(color(navy)) ///
	lag_opt4(msymbol(Th) color(forest_green)) lag_ci_opt4(color(forest_green)) ///
	lag_opt5(msymbol(Sh) color(dkorange)) lag_ci_opt5(color(dkorange)) ///
	lag_opt6(msymbol(Th) color(blue)) lag_ci_opt6(color(blue)) ///
	lag_opt7(msymbol(Dh) color(red)) lag_ci_opt7(color(red)) ///
	lag_opt8(msymbol(Oh) color(purple)) lag_ci_opt8(color(purple))
// graph export "$output/seven_estimators_example_allt.png", replace


************************************************************
* 三、曹清峰（2020，中国工业经济，《国家级新区对区域经济增长的带动效应》）
************************************************************

// 加载数据

use /Users/xuwenli/Library/CloudStorage/OneDrive-个人/DSGE建模及软件编程/教学大纲与讲稿/应用计量经济学讲稿/国家新区的增长效应/数据/表1,clear

// 处理状态图

panelview gdpr did,i(id) t(year) type(treat) xtitle("时间") ytitle("地区")


// 表3的回归结果

xtset id year

reghdfe gdpr did,absorb(year id) vce(cluster id)

reghdfe gdpr did invest consume export gov second agg innov,absorb(year id) vce(cluster id)

// 培根分解

bacondecomp gdpr did,ddetail

bacondecomp gdpr did invest consume export gov second agg innov,stub(Bacon_) robust

// 事件研究

* 初次处理时间

bys id (year): egen Ei = min(year) if did ==1

* 安装
* ssc install fillmissing,replace
bys id :fillmissing Ei,with(next)

* sort id Ei

* bys id : replace Ei=Ei[1]

* 创建相对时间, 例如，处理后的时期数（如果从未处理，则缺失）
	gen K = year-Ei	
	
	
* 复制曹清峰（2010）结果
* reghdfe事件研究
forvalues x = 0/12 {
	g Post`x'=(K==`x')     // 等价于gen Dt`x'=1 if Dur==`x'
}
* For placebo estimates, pre-treatment periods
forvalues x = 2/13 {
	g Pre_`x'=(K==-`x')
}

reghdfe gdpr Pre_* Post*,ab(id year) cluster(id) noconstant


matrix temp = e(V)
mat list temp
matrix V_b = temp[1..25,1..25]
matrix e = J(25,1,1/25)
matrix temp=r(table)'
mat list temp
matrix res=J(26,4,0)
matrix res[13,1]=-1
forvalues x = 2/13 {
matrix res[14-`x',1]=-`x'
matrix res[14-`x',2]=temp[`x'-1,1]
matrix res[14-`x',3]=temp[`x'-1,5]
matrix res[14-`x',4]=temp[`x'-1,6]
}
forvalues x = 0/12 {
matrix res[`x'+14,1]=`x'
matrix res[`x'+14,2]=temp[`x'+13,1]
matrix res[`x'+14,3]=temp[`x'+13,5]
matrix res[`x'+14,4]=temp[`x'+13,6]
}

matrix res_avg[2,1] = res[14..25,2]'*e

matrix temp = e'*(V_b*e)
matrix res_avg[2,2] = sqrt(temp[1,1])

preserve
drop _all
svmat res
twoway (scatter res2 res1, msize(medlarge) msymbol(o) mcolor(navy) legend(off)) ///
	(line res2 res1, lcolor(navy)) (rcap res4 res3 res1, lcolor(maroon)), ///
	 xtitle("国家级新区相对设立时间") ///
	 ytitle("经济增长效应") xline(-1,lp(dash)) yline(0,lp(dash)) name(g1,replace) scheme(s1mono)
restore

* Joint nullity of all placebos
testparm Pre_*


* 平行趋势检验RR（2022，RES，Forthcoming）

* 并行计算
* net install parallel, from(https://raw.github.com/gvegayon/parallel/stable) replace
* mata mata mlib index

matrix list e(b)
mata rows(st_matrix("e(V)")), cols(st_matrix("e(V)"))
matrix l_vec=(0\0\0\0\1\0\0\0\0\0\0\0\0)
honestdid, l_vec(l_vec) pre(1/12) post(13/25) mvec(0 (0.025)0.25)
mata `s(HonestEventStudy)'.CI
mata `s(HonestEventStudy)'.betahat
mata `s(HonestEventStudy)'.numPrePeriods
mata `s(HonestEventStudy)'.numPostPeriods
mata `s(HonestEventStudy)'.options.alpha
mata `s(HonestEventStudy)'.options.l_vec
mata `s(HonestEventStudy)'.options.Mvec
mata `s(HonestEventStudy)'.options.grid_lb
mata `s(HonestEventStudy)'.options.grid_ub

*（1）相对偏离程度的敏感性检验
matrix l_vec=(0\0\0\0\1\0\0\0\0\0\0\0\0)

honestdid, l_vec(l_vec) pre(1/12) post(13/25) mvec(0(0.025)0.25)

local plotopts xtitle(Mbar) ytitle(95% Robust CI)
honestdid, cached coefplot `plotopts'

*（2）平滑限制的敏感性检验
matrix l_vec=(0\0\0\0\1\0\0\0\0\0\0\0\0)

honestdid, l_vec(l_vec) pre(1/12) post(13/25) mvec(0(0.025)0.25) delta(sd)

local plotopts xtitle(Mbar) ytitle(95% Robust CI)
honestdid, cached coefplot `plotopts'




* 事件研究图
eventdd gdpr i.year, timevar(K) method(fe, cluster(id))  level(90) graph_op(ytitle("效应") xtitle("相对事件时间")  name(cao,replace))



eventdd gdpr invest consume export gov second agg innov i.year, timevar(K) method(fe, cluster(id)) level(90) graph_op(ytitle("效应") xtitle("相对事件时间")  name(cao,replace))

* 去趋势
xtevent gdpr invest consume export gov second agg innov, pol(did) w(11)  p(id) t(year) cluster(id) trend(-4)
xteventplot, overlay(trend) nosupt xtitle("relative-event-time") ytitle("effect") levels(90) name(es,replace)
xteventplot, nosupt levels(90) xtitle("relative-event-time") ytitle("effect") name(es,replace)


// 其它稳健估计量



// did_imputation of Borusyak et al. (2022)

	*Estimation
	did_imputation gdpr id year Ei, allhorizons pretrends(5) minn(0)
	// Y:	outcome variable
	// i:	unit id variable
	// t:	time period variable
	// Ei:	variable for unit-specific treatment date (never-treated: Ei == missing)

	// allhorizons: include all non-negative horizons available
	// pretrends(): number of pre-treatment coefficients to be estimated (with too many pre-trend coefficients, the power of the joint test will be lower.)
	// standard errors are clustered at unit level by default

	*Plotting
	event_plot, default_look graph_opt(xtitle("事件发生后时期") ytitle("平均处理效应") ///
		title("Borusyak et al. (2022) imputation estimator") xlabel(-5(1)12) name(BJS, replace)) together

	*Storing estimates for later
	estimates store bjs
	
	
// did_multiplegt of de Chaisemartin and D'Haultfoeuille (2020)

	*Estimation
	did_multiplegt gdpr id year did, robust_dynamic dynamic(5) placebo(5) longdiff_placebo breps(100) cluster(id)
	// Y:	outcome variable
	// i:	unit id variable
	// t:	time period variable
	// D:	treatment variable
	
	// robust_dynamic: uses estimator from dCdH (2021) on DID with intertemporal effects
	// dynamic(): number of dynamic treatment effects to be estimated (can only be used with robust_dynamic)
	// placebo(): number of placebo estimates to be estimated (When the longdiff_placebo and dynamic options are requested, the number of placebos requested cannot be larger than the number of dynamic effects)
	// longdiff_placebo: estimates placebo effects using long differences (comparable to dynamic TE estimates)
	// breps(): number of bootstrap iterations for computation of standard errors
	// cluster(i): computes standard errors using block bootstrap at level specified
	
	// Note that, according to the help file, by default "placebos are
	// first-difference estimators, while dynamic effects are long-difference
	// estimators, so they are not really comparable." Thus, we should not plot
	// and compare them in the same graph, if the "longdiff_placebo" option is
	// not specified.

	*Plotting
	event_plot e(estimates)#e(variances), default_look graph_opt(xtitle("事件发生后时期") ///
		ytitle("平均处理效应") title("de Chaisemartin and D'Haultfoeuille (2020)") xlabel(-5(1)5) ///
		name(dCdH, replace)) stub_lag(Effect_#) stub_lead(Placebo_#) together
	// bmat#vmat: name of point estimate matrix and name of variance-covariance matrix
	// stub_lag((prefix#postfix): name of lag coefficients in estimation output
	// stub_lead(prefix#postfix): name of lead coefficients in estimation output
	// graph_opt(): twoway options for graph overall
	// together: show leads and lags as one line

	*Storing estimates for later
	matrix dcdh_b = e(estimates)
	matrix dcdh_v = e(variances)


// csdid of Callaway and Sant'Anna (2021) (v1.6 written by Fernando Rios-Avila @friosavila)

	*Preparation
	gen gvar = cond(Ei>2015, 0, Ei) // group variable as required for the csdid command

	*Estimation
	 csdid gdpr, ivar(id) time(year) gvar(gvar) agg(event)
	// Y: 		outcome variable
	// ivar():	unit id variable
	// time():	time period variable
	// gvar():	variable for unit-specific treatment date (never treated: gvar == 0)
	// (defines "group" in CS jargon)
	
	// agg(): aggregation to use
	// wboot: Wild Bootstrap standard errors (default is asymptotic normal)
	// cluster(): should in principle be possible but throws an error (for me at least)
	// by default uses never treated units as control group (could specify "notyet")
	
	// Note that this command is work in progress. As such, it may subject to
	// ongoing changes. For example, the wboot option currently seems to
	// throw an error if specified. Further, the confidence intervals are not
	// yet correct (not uniform as in CS).
	
	// Also, note that Nick Huntington-Klein provides a Stata package that
	// acts as a wrapper for the "did" package by CS in R (via rcall, i.e. 
	// need to have R installed). It is available on his github page:
	// https://github.com/NickCH-K/did

	*Plotting
	event_plot e(b)#e(V), default_look graph_opt(xtitle("事件发生后时期") ///
		ytitle("平均处理效应") xlabel(-11(1)12) title("Callaway and Sant'Anna (2021)") name(CS, replace)) ///
		stub_lag(Tp#) stub_lead(Tm#) together

	*Storing estimates for later
	matrix cs_b = e(b)
	matrix cs_v = e(V)


// eventstudyinteract of Sun and Abraham (2020)

	*Preparation
	sum Ei
	gen lastcohort = Ei==r(max) // dummy for the latest- or never-treated cohort
	forvalues l = 0/5 {
		gen L`l'event = K==`l'
	}
	forvalues l = 1/14 {
		gen F`l'event = K==-`l'
	}
	drop F1event // normalize K=-1 (and also K=-15) to zero

	*Estimation
	eventstudyinteract gdpr L*event F*event, vce(cluster id) absorb(id year) cohort(Ei) control_cohort(lastcohort)
	// Y: outcome variable
	// L*event: lags to include
	// F*event: leads to include
	// vce(): options for variance-covariance matrix (cluster SE)
	// absorb(): absorb unit and time fixed effects
	// cohort(): variable for unit-specific treatment date (never-treated: Ei == missing)
	// control_cohort(): indicator variable for control cohort (either latest-treated or never-treated units)

	*Plotting
	event_plot e(b_iw)#e(V_iw), default_look graph_opt(xtitle("事件发生后时期") ///
		ytitle("平均处理效应") xlabel(-14(1)5) title("Sun and Abraham (2020)") name(SA, replace)) ///
		stub_lag(L#event) stub_lead(F#event) together

	*Storing estimates for later
	matrix sa_b = e(b_iw)
	matrix sa_v = e(V_iw)


// did2s of Gardner (2021)

	* Estimation
	did2s gdpr, first_stage(i.id i.year) second_stage(F*event L*event) treatment(did) cluster(id)
	// Y: outcome variable
	// first_stage(): fixed effects used to estimate counterfactual Y_it(0). This should be everything besides treatment
	// second_stage(): treatment such as dummy variable or event-study leads and lags
	// cluster(): variable to cluster on 

	
	*Plotting
	event_plot, default_look stub_lag(L#event) stub_lead(F#event) together ///
		graph_opt(xtitle("事件发生后时期") ytitle("平均处理效应") xlabel(-14(1)5) ///
		title("Gardner (2021)") name(DID2S, replace))
		
	*Saving estimates for later
	matrix did2s_b = e(b)
	matrix did2s_v = e(V)

	
// stackedev of Cengiz et al. (2019) 

	*Create a variable equal to the time that the unit first received treatment. It must be missing for never treated units.
	gen treat_year=.
	replace treat_year=Ei if Ei!=2016

	*Create never treated indicator that equals one if a unit never received treatment and zero if it did.
	gen no_treat= (Ei==2016)

	*Preparation
	cap drop F*event L*event
	sum Ei
	forvalues l = 0/5 {
		gen L`l'event = K==`l'
		replace L`l'event = 0 if no_treat==1
	}
	forvalues l = 1/14 {
		gen F`l'event = K==-`l'
		replace F`l'event = 0 if no_treat==1
	}
	drop F1event // normalize K=-1 (and also K=-15) to zero

	* Run stackedev		
	preserve
	stackedev gdpr F*event L*event, cohort(treat_year) time(year) never_treat(no_treat) unit_fe(id) clust_unit(id) 
	restore
	// Y: outcome variable
	// L*event: lags to include
	// F*event: leads to include
	// time(): numerical variable equal to time
	// never_treat(): binary indicator that equals one if a unit never received treatment and zero if it did
	// unit_fe(): variable indicating unit fixed effects
	// clust_unit(): variable indicating the unit by which to cluster variances
	

	*Plotting
	event_plot e(b)#e(V), default_look graph_opt(xtitle("事件发生后时期") ///
		ytitle("平均处理效应") xlabel(-12(1)5) title("Cengiz et al. (2019)") name(CDLZ, replace)) ///
		stub_lag(L#event) stub_lead(F#event) together	
		
	*Saving estimates for later
	matrix stackedev_b = e(b)
	matrix stackedev_v = e(V)
	
	
// TWFE OLS estimation

	*Estimation
	reghdfe gdpr F*event L*event, absorb(id year) vce(cluster id)

	*Plotting
	event_plot, default_look stub_lag(L#event) stub_lead(F#event) together ///
		graph_opt(xtitle("事件发生后时期") ytitle("OLS系数") xlabel(-14(1)5) ///
		title("OLS") name(OLS, replace))

	*Saving estimates for later
	estimates store ols

	
	
// Construct vector of true average treatment effects by number of periods since treatment

//	matrix btrue = J(1,6,.)
//	matrix colnames btrue = tau0 tau1 tau2 tau3 tau4 tau5
//	qui forvalues h = 0/5 {
//		sum tau if K==`h'
//		matrix btrue[1,`h'+1]=r(mean)
//	}


// Combine all plots using the stored estimates (5 leads and lags around event)

event_plot bjs dcdh_b#dcdh_v cs_b#cs_v sa_b#sa_v did2s_b#did2s_v stackedev_b#stackedev_v ols, ///
	stub_lag(tau# Effect_# T+# L#event L#event L#event L#event) stub_lead(pre# Placebo_# T-# F#event F#event F#event F#event) ///
	plottype(scatter) ciplottype(rcap) ///
	together perturb(-0.325(0.1)0.325) trimlead(5) noautolegend ///
	graph_opt(title("稳健估计量", size(med)) ///
		xtitle("事件发生后时期", size(small)) ytitle("平均处理效应", size(small)) xlabel(-5(1)5)  ///
		legend(order(1 "Borusyak et al." 4 "de Chaisemartin-D'Haultfoeuille" ///
				 6 "Callaway-Sant'Anna" 8 "Sun-Abraham" 10 "Gardner" 12 "Cengiz et al." 14 "TWFE OLS") rows(2) position(6) region(style(none))) ///
	/// the following lines replace default_look with something more elaborate
		xline(-0.5, lcolor(gs8) lpattern(dash)) yline(0, lcolor(gs8)) graphregion(color(white)) bgcolor(white) ylabel(, angle(horizontal)) ///
	) ///
//	lag_opt1(msymbol(+) color(black)) lag_ci_opt1(color(black)) ///
	lag_opt2(msymbol(O) color(cranberry)) lag_ci_opt2(color(cranberry)) ///
	lag_opt3(msymbol(Dh) color(navy)) lag_ci_opt3(color(navy)) ///
    lag_opt4(msymbol(Th) color(forest_green)) lag_ci_opt4(color(forest_green)) ///
	lag_opt5(msymbol(Sh) color(dkorange)) lag_ci_opt5(color(dkorange)) ///
	lag_opt6(msymbol(Th) color(blue)) lag_ci_opt6(color(blue)) 
	lag_opt7(msymbol(Dh) color(red)) lag_ci_opt7(color(red)) ///
    lag_opt8(msymbol(Oh) color(purple)) lag_ci_opt8(color(purple))
// graph export "$output/seven_estimators_example_5t.png", replace

// Combine all plots using the stored estimates (5 leads and lags around event)

    event_plot bjs dcdh_b#dcdh_v cs_b#cs_v sa_b#sa_v did2s_b#did2s_v stackedev_b#stackedev_v ols, ///
	stub_lag(tau# Effect_# T+# L#event L#event L#event L#event) stub_lead(pre# Placebo_# T-# F#event F#event F#event F#event) ///
	plottype(scatter) ciplottype(rcap) ///
	together perturb(-0.325(0.1)0.325) trimlead(14) noautolegend ///
	graph_opt(title("Event study estimators in a simulated panel (400 units, 15 periods)", size(med)) ///
		xtitle("Periods since the event", size(small)) ytitle("Average causal effect", size(small)) xlabel(-14(1)5)  ///
		legend(order( 2 "Borusyak et al." 4 "de Chaisemartin-D'Haultfoeuille" ///
				 6 "Callaway-Sant'Anna" 8 "Sun-Abraham" 10 "Gardner" 12 "Cengiz et al." 14 "TWFE OLS") rows(2) position(6) region(style(none))) ///
	/// the following lines replace default_look with something more elaborate
		xline(-0.5, lcolor(gs8) lpattern(dash)) yline(0, lcolor(gs8)) graphregion(color(white)) bgcolor(white) ylabel(, angle(horizontal)) ///
	) ///
//	lag_opt1(msymbol(+) color(black)) lag_ci_opt1(color(black)) ///
	lag_opt2(msymbol(O) color(cranberry)) lag_ci_opt2(color(cranberry)) ///
	lag_opt3(msymbol(Dh) color(navy)) lag_ci_opt3(color(navy)) ///
	lag_opt4(msymbol(Th) color(forest_green)) lag_ci_opt4(color(forest_green)) ///
	lag_opt5(msymbol(Sh) color(dkorange)) lag_ci_opt5(color(dkorange)) ///
	lag_opt6(msymbol(Th) color(blue)) lag_ci_opt6(color(blue)) ///
	lag_opt7(msymbol(Dh) color(red)) lag_ci_opt7(color(red)) ///
	lag_opt8(msymbol(Oh) color(purple)) lag_ci_opt8(color(purple))
// graph export "$output/seven_estimators_example_allt.png", replace












