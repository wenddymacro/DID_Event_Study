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
est store m1

reghdfe gdpr did invest consume export gov second agg innov,absorb(year id) vce(cluster id)
est store m2

xtreg gdpr did invest consume export gov second agg innov i.year ,fe vce(cluster id)
psacalc delta did     // 在处理效应为 0 时, delta 的值

// 事件研究

* 初次处理时间

bys id (year): egen Ei = min(year) if did ==1

* 安装
ssc install fillmissing,replace
bys id :fillmissing Ei,with(next)

* sort id Ei

* bys id : replace Ei=Ei[1]

* 创建相对时间, 例如，处理后的时期数（如果从未处理，则缺失）
	gen K = year-Ei


* 复制曹清峰（2010）结果
eventdd gdpr i.year, timevar(K) method(fe, cluster(id)) graph_op(ytitle("效应") xtitle("相对事件时间") title("无协变量") name(cao,replace)) level(90)


eventdd gdpr invest consume export gov second agg innov i.year, timevar(K) method(fe, cluster(id))  graph_op(ytitle("效应") xtitle("相对事件时间") title("有协变量") name(cao1,replace)) level(90)

graph combine "/Users/xuwenli/Downloads/cao.gph" "/Users/xuwenli/Downloads/cao1.gph"

* 平行趋势敏感性检验
matrix l_vec = 0 \ 0 \0 \ 1 \0
local plotopts xtitle(M) ytitle(90% 稳健置信区间)
honestdid,l_vec(l_vec) pre(16/27) post(28/32) mvec(0(0.01)0.05) delta(sd) alpha(0.1) coefplot `plotopts' 

// 加载数据

use /Users/xuwenli/Library/CloudStorage/OneDrive-个人/DSGE建模及软件编程/教学大纲与讲稿/应用计量经济学讲稿/国家新区的增长效应/数据/表2,clear

xtset id year
reghdfe gdpr did did01 invest consume export gov second agg innov,absorb(year id) vce(cluster id)
est store m3
reghdfe gdpr did did02 invest consume export gov second agg innov,absorb(year id) vce(cluster id)
est store m4
reghdfe gdpr did did01 did02 invest consume export gov second agg innov,absorb(year id) vce(cluster id)
est store m5

coefplot (m1 m2 m3 m4 m5), drop(_cons) keep(did) ///
    aseq swapnames vertical ///
    xlabel(1 "没有控制变量" 2 "控制变量" 3 "综改实验区" 4 "自贸试验区" 5 "所有协变量") ///
    ciopt(recast(rcap) lcolor(black)) mcolor(black)  ///
    yline(0, lp(dash)) graphregion(color(white))
	
xtreg gdpr did did01 invest consume export gov second agg innov i.year,fe vce(cluster id)
psacalc delta did
xtreg gdpr did did02 invest consume export gov second agg innov i.year,fe vce(cluster id)
psacalc delta did	
xtreg gdpr did did01 did02 invest consume export gov second agg innov i.year,fe vce(cluster id)
psacalc delta did


* 初次处理时间

bys id (year): egen Ei = min(year) if did ==1

* 安装
* ssc install fillmissing,replace
bys id :fillmissing Ei,with(next)

* sort id Ei

* bys id : replace Ei=Ei[1]

* 创建相对时间, 例如，处理后的时期数（如果从未处理，则缺失）
	gen K = year-Ei


eventdd gdpr did did01 invest consume export gov second agg innov i.year,timevar(K) method(fe, cluster(id)) level(90) graph_op(ytitle("效应") xtitle("相对事件时间")  name(cao,replace))

eventdd gdpr did did02 invest consume export gov second agg innov i.year,timevar(K) method(fe, cluster(id)) level(90) graph_op(ytitle("效应") xtitle("相对事件时间")  name(cao,replace))

eventdd gdpr did did01 did02 invest consume export gov second agg innov i.year,timevar(K) method(fe, cluster(id)) level(90) graph_op(ytitle("效应") xtitle("相对事件时间")  name(cao,replace))

// 平行趋势：处理前时期系数的联合检验：sup-t
xtevent gdpr, pol(did) w(11)  p(id) t(year) cluster(id) impute(stag)
xteventplot,noprepval nopostpval   

xtevent gdpr invest consume export gov second agg innov, pol(did) w(11)  p(id) t(year) cluster(id) impute(stag)
xteventplot,levels(90) noprepval nopostpval

// 平行趋势和预期效应：pre-trends test

xtevent gdpr, pol(did) w(11)  p(id) t(year) cluster(id) impute(stag)
xteventplot,nopostpval

xtevent gdpr, pol(did) w(11)  p(id) t(year) cluster(id) impute(stag)
xteventplot

//A failure of this hypothesis might indicate anticipatory behavior, or, in what seems a more common interpretation in practice, it might indicate the presence of a confound.

xtevent gdpr invest consume export gov second agg innov, pol(did) w(11)  p(id) t(year) cluster(id) impute(stag)
xteventplot,nopostpval


// // 交叠采用和异质性处理效应

// 培根分解

bacondecomp gdpr did,ddetail

bacondecomp gdpr did invest consume export gov second agg innov,stub(Bacon_) robust

// 静态模型检验
xtevent gdpr, policyvar(did) panelvar(id) timevar(year) window(11) cluster(id) impute(stag)
xteventplot,nopostpval
xteventplot, overlay(static) staticovplotopts(lcolor(red))



// 稳健估计量
// did_imputation of Borusyak et al. (2022)

	*Estimation
	did_imputation gdpr id year Ei, allhorizons pretrends(5) minn(0)
	// Y:	outcome variable
	// i:	unit id variable
	// t:	time period variable
	// Ei:	variable for unit-specific treatment date (never-treated: Ei == missing)

	// allhorizons: include all non-negative horizons available
	// pretrends(): number of pre-treatment coefficients to be estimated (with too many pre-trend coefficients, the power of the joint test will be lower.)
	// pretrends(): 检验“满足无预期假设下的平行趋势”
	// standard errors are clustered at unit level by default

	*Plotting
	event_plot, default_look graph_opt(xtitle("事件发生后时期") ytitle("平均处理效应") ///
		title("Borusyak et al. (2022) imputation estimator") xlabel(-5(1)12) name(BJS, replace)) together
		
		
// 时变混淆因子的影响

* 混淆因子检验：wiggly test
xtevent gdpr, pol(did) w(11)  p(id) t(year) cluster(id) impute(stag)
xteventplot, smpath(line) nopostpval   

xtevent gdpr invest consume export gov second agg innov, pol(did) w(-8 5)  p(id) t(year) cluster(id) impute(stag)
xteventplot,smpath(line) nopostpval

* 去趋势
*(1) 简单的时间趋势，t
xtevent gdpr invest consume export gov second agg innov year, pol(did) w(11)  p(id)  cluster(id) note impute(stag)
xteventplot,levels(90) nosupt noprepval nopostpval

*（2）交互固定效应估计量
xtevent gdpr invest consume export gov second agg innov, pol(did) w(11) cluster(id) reghdfe addabsorb(id#year) nofe note
xteventplot, nosupt noprepval nopostpval levels(90) xtitle("相对事件时间") ytitle("效应") name(es,replace)   // insufficient observations

eventdd gdpr invest consume export gov second agg innov, timevar(K) method(hdfe,absorb(id#year) cluster(id))  graph_op(ytitle("效应") xtitle("相对事件时间") title("有协变量") name(cao1,replace)) level(90)  //insufficient observations

*(3)共同相关效应估计量

*（4）合成控制法
fect gdpr, treat(did) unit(id) time(year) cov(invest consume export gov second agg innov) method("ife") r(2) se

fect gdpr, treat(did) unit(id) time(year) cov(invest consume export gov second agg innov) method("mc") lambda(0.003) se vartype("jackknife")

*（5）异质性时间趋势
xtevent gdpr invest consume export gov second agg innov, pol(did) w(11)  p(id) t(year) cluster(id) trend(-4, saveoverlay) impute(stag)
xteventplot, overlay(trend) nosupt xtitle("相对事件时间") ytitle("效应") levels(90) name(es,replace)
xteventplot, nosupt levels(90) xtitle("相对事件时间") ytitle("效应") name(es,replace)

*（6）不可观测混淆因子的代理变量
xtevent gdpr invest consume export gov second agg, pol(did) w(11)  p(id) t(year) vce(cluster id) proxy(innov)
xteventplot, nosupt noprepval nopostpval levels(90) xtitle("相对事件时间") ytitle("效应") name(es,replace)

************************************************************
* 四、许文立和孙磊（2022）：碳排放权交易试点与企业融资约束
************************************************************
use "/Users/xuwenli/Library/CloudStorage/OneDrive-个人/0paper/143碳排放权与融资约束 with 孙磊 and 郑梦圆等/data1.dta",clear

//预处理//
destring scode cfa diva casha k_0 inv, replace force
egen city_=group(city)
egen province_=group(province)
egen tclas_=group(tclas)
egen tcode_=group(tcode)
drop if province == "开曼群岛"

//选择样本区间//
drop if year<2008 | year>2019

//剔除缺失值//
drop if stock =="#N/A"
drop if stock ==""
drop if tclas=="J" 
drop if strpos(stock ,"ST")>0
drop if strpos(stock ,"PT")>0

//设置面板//
xtset scode year

//计算KZ值//
winsor2 cfa diva casha lev tobin yage k, cuts(1 99) replace by(year)

egen MED_CFA=median(cfa),by(year)
gen NCFA=1 if cfa<MED_CFA
replace NCFA=0 if NCFA==.
egen MED_DIVA=median(diva),by(year)
gen NDIVA=1 if diva<MED_DIVA
replace NDIVA=0 if NDIVA==.
egen MED_CASHA=median(casha),by(year)
gen NCASHA=1 if casha<MED_CASHA
replace NCASHA=0 if NCASHA==.
egen MED_LEV=median(lev),by(year)
gen NLEV=1 if lev>MED_LEV
replace NLEV=0 if NLEV==.
egen MED_TOBIN=median(tobin),by(year)
gen NTOBIN=1 if tobin>MED_TOBIN
replace NTOBIN=0 if NTOBIN==.

gen NKZ=NCFA+NDIVA+NCASHA+NLEV+NTOBIN
ologit NKZ cfa diva casha lev tobin
est store reg
predict KZ, xb
esttab reg , nogap replace star(* 0.1 ** 0.05 *** 0.01) b(3) t(3) pr2    
esttab reg using KZ回归结果.rtf, nogap replace star(* 0.1 ** 0.05 *** 0.01) b(3) t(3) pr2   

//计算SA值//
gen SIZE=log(k/100)
gen AGE=yage
gen SA=-0.737*SIZE+0.043*SIZE^2-0.040*AGE

//设置DID//
gen lcer=l.cer
gen l2cer=l2.cer
gen l3cer=l3.cer
gen l4cer=l4.cer
gen l5cer=l5.cer
gen l6cer=l6.cer
gen l7cer=l7.cer
gen l8cer=l8.cer
gen CER=1 if cer==1 | lcer==1 | l2cer==1 | l3cer==1 | l4cer==1 | l5cer==1 | l6cer==1 | l7cer==1 | l8cer==1 
replace CER=0 if CER==.
drop lcer l2cer l3cer l4cer l5cer l6cer l7cer l8cer

replace treat=0 if treat==.
gen time=CER/treat 
replace time=0 if time==.
sum CER treat time

//控制变量设定//
gen LogSIZE=log(size)
gen LogAGE=log(yage+1)
gen LogSD=log(sd)
gen LogROA=sign( roa )*log(abs( roa )+1)
gen LogPPE=log(ppe+1)
gen LogBM=log(bm+1)
gen Logliquidity=log(liquidity+1)
gen LogPGDP=log(pgdp)
gen LogPOP=log(pop)
gen LogISTR=log(inst+1)
gen LogFEXP=log(fine)
gen LogTIFA=log(fainv)
gen LogSCRS=log(rsc)
gen LogTIE=log(tie)

//温莎处理//
winsor2 LogSIZE LogSD LogROA LogPPE LogBM Logliquidity LogPGDP LogPOP LogISTR LogFEXP LogTIFA LogSCRS LogTIE, cut (1 99) replace by(year)

glob SL LogSIZE LogAGE LogSD LogROA LogPPE LogBM Logliquidity LogPGDP LogPOP LogISTR LogFEXP LogTIFA LogSCRS LogTIE

glob Xs LogSD LogROA LogPPE LogBM LogPGDP LogPOP LogISTR LogTIE

//描述性统计//
sum KZ SA CER $Xs using summary.docx if KZ !=. & LogSD !=. & LogROA !=. & LogPPE !=. & LogBM !=. & LogPGDP !=. & LogPOP !=. & LogISTR !=. & LogTIE !=. ,replace stats(N mean(%9.4f) sd(%9.4f) min(%9.4f) p25(%9.4f) median(%9.4f) p75(%9.4f) max(%9.4f))

//基准回归//
reghdfe KZ CER ,absorb(i.province_ i.tclas_ i.year) vce(cluster province)
outreg2 using basereg.docx,replace bdec(3) tdec(2) keep(KZ CER) addtext(Control, NO,Province FE, YES,Industry FE, YES,Year FE, YES,Province-Industry FE, NO,Industry-Year FE, NO)
reghdfe KZ CER $Xs ,absorb(i.province_ i.tclas_ i.year) vce(cluster province)
outreg2 using basereg.docx,append bdec(3) tdec(2) keep(KZ CER $Xs) addtext(Control, YES,Province FE, YES,Industry FE, YES,Year FE, YES,Province-Industry FE, NO,Industry-Year FE, NO)
reghdfe KZ CER $Xs ,absorb(i.province_#i.tclas_ i.year) vce(cluster province)
outreg2 using basereg.docx,append bdec(3) tdec(2) keep(KZ CER $Xs) addtext(Control, YES,Province FE, NO,Industry FE, NO,Year FE, YES,Province-Industry FE, YES,Industry-Year FE, NO)
reghdfe KZ CER $Xs ,absorb(i.province_ i.tclas_#i.year) vce(cluster province)
outreg2 using basereg.docx,append bdec(3) tdec(2) keep(KZ CER $Xs) addtext(Control, YES,Province FE, YES,Industry FE, NO,Year FE, YES,Province-Industry FE, NO,Industry-Year FE, YES)
save "/Users/xuwenli/Library/CloudStorage/OneDrive-个人/0paper/143碳排放权与融资约束 with 孙磊 and 郑梦圆等/baseregdata.dta" ,replace


//可视化图(公司层面)//
duplicates drop scode year,force 
panelview KZ CER $Xs if CER==1, i(scode) t(year) type(treat) mycolor(Reds) xlabdist(2) ylabdist(1) prepost bytiming
panelview KZ cer $Xs if cer==1, i(scode) t(year) type(treat) mycolor(Reds) xlabdist(2) ylabdist(1) prepost bytiming


//平行趋势图//
use "/Users/xuwenli/Library/CloudStorage/OneDrive-个人/0paper/143碳排放权与融资约束 with 孙磊 and 郑梦圆等/baseregdata.dta",clear

gen lCER=l.CER
gen R = year if CER==1 & lCER==0
egen reform = mean(R),by(scode)
drop R lCER

gen tDID= year- reform
replace tDID=-5 if tDID<-5
replace tDID=5 if tDID>5

tab tDID,missing

forvalues i=1/5{
gen d_`i' =0
replace d_`i' = 1 if treat == 1 & tDID == -`i'
}

forvalues i=0/5{
gen d`i' =0
replace d`i' = 1 if treat == 1 & tDID == `i'
}

order d_5 d_4 d_3 d_2 d_1 d0 d1 d2 d3 d4 d5
reghdfe KZ d_5-d_2 d0-d5 $Xs ,absorb(i.province_ i.tclas_ i.year) vce(cluster province)

gen t=invttail(30,0.05)

*生成b_j的系数和置信区间
forvalues i=2/5 { 
gen b_`i' = _b[d_`i'] 
gen se_b_`i' = _se[d_`i']
gen b_`i'LB = b_`i' - t * se_b_`i'
gen b_`i'UB = b_`i' + t * se_b_`i'
}

*生成bj的系数与置信区间
forvalues i=0/5 { 
gen b`i' = _b[d`i'] 
gen se_b`i' = _se[d`i']
gen b`i'LB = b`i' - t * se_b`i'
gen b`i'UB = b`i' + t * se_b`i'
}

gen b = .
gen LB = .
gen UB = .

*生成系数（政策前）
forvalues i=2/5 {
replace b = b_`i'  if tDID == -`i'
}

*生成系数（政策后）
forvalues i=0/5{
replace b = b`i'  if tDID == `i'
}

*生成系数置信区间下限（政策前）
forvalues i=2/5 {
replace LB = b_`i'LB if tDID == -`i'
}

*生成系数置信区间下限（政策后）
forvalues i=0/5 {
replace LB = b`i'LB if tDID == `i'
}

*生成系数置信区间上限（政策前）
forvalues i=2/5 {
replace UB = b_`i'UB if tDID == -`i'
}

*生成系数置信区间上限（政策后）
forvalues i=0/5 {
replace UB = b`i'UB if tDID == `i'
}

*生成基期
replace b = 0  if tDID == -1
replace LB = 0 if tDID == -1
replace UB = 0 if tDID == -1

keep tDID b LB UB
duplicates drop tDID,force
sort tDID

twoway (connected b tDID, sort lcolor(black) mcolor(black) msymbol(circle_hollow) cmissing(n))(rcap LB UB tDID, lcolor(black)lpattern(dash) msize(medium)),ytitle("政策动态效应",size(medium)) yline(0, lwidth(vthin) lpattern(dash) lcolor(teal)) ylabel(-0.40 "-0.40" -0.20 "-0.20" 0 "0.00" 0.20 "0.20" 0.40 "0.40" 0.60 "0.60" 0.80 "0.80", labsize(medsmall) angle(horizontal) nogrid) xtitle("政策时点",size(medium)) xline(0, lwidth(vthin) lpattern(dash) lcolor(teal))  xlabel(-5 "pre_5" -4 "pre_4" -3 "pre_3" -2 "pre_2" -1 "pre_1" 0 "current" 1 "post_1" 2 "post_2" 3 "post_3" 4 "post_4" 5 "post_5", labsize(medsmall))  legend(off)graphregion(fcolor(white) lcolor(white) ifcolor(white) ilcolor(white)) scheme(s1mono)
save "平行趋势图.gph",replace


//安慰剂检验//
use "/Users/xuwenli/Library/CloudStorage/OneDrive-个人/0paper/143碳排放权与融资约束 with 孙磊 and 郑梦圆等/baseregdata.dta",clear

reghdfe KZ CER $Xs ,absorb(i.province_ i.tclas_ i.year) vce(cluster province)
*真实系数 = 0.421
*真实t值 = 3.53
*真实p值 = 0.001

permute CER beta=_b[CER] se=_se[CER] df_m=e(df_r),reps(1000) seed(123) saving("anweiji.dta",replace) : reghdfe KZ CER $Xs ,absorb(i.province_ i.tclas_ i.year) vce(cluster province)

use "anweiji.dta",clear
gen t_value=beta/se
gen p_value=2*ttail(df,abs(beta/se))

*系数图
dpplot beta, msymbol(circle_hollow) msize(vlarge) xline(0.421,lc(red*0.8) lp(dash)) xline(0,lc(black*1) lp(solid)) xlabel(-0.4(0.1)0.5,grid format(%4.2f) labsize(medium)) xtitle("系数值", size(*1)) ytitle("核密度", size(*1)) ylabel(,grid nogrid format(%4.1f) labsize(medium)) note("") caption("") graphregion(fcolor(white))
save "安慰剂系数图.gph",replace

*t统计量图
dpplot t_value,msymbol(circle_hollow) msize(vlarge) xline(3.53, lc(blue*0.8) lp(dash)) xline(0, lc(black*1) lp(solid)) xlabel(-4(1)6,grid format(%4.2f) labsize(medium)) xtitle("t统计量", size(*1)) xlabel(,grid format(%4.2f) labsize(medium)) ytitle("核密度", size(*1)) ylabel(,grid nogrid format(%4.1f) labsize(medium)) note("") caption("") graphregion(fcolor(white)) 
save "安慰剂t统计量图.gph",replace

*p值图
dpplot p_value,msymbol(circle_hollow) msize(vlarge) xline(0.001, lc(green*0.8) lp(dash)) xline(0.1,lc(black*1) lp(solid)) xtitle("p值", size(*1)) xlabel(,grid format(%4.2f) labsize(medium)) ytitle("核密度", size(*1)) ylabel(,grid nogrid format(%4.1f) labsize(medium)) note("") caption("") graphregion(fcolor(white)) 
save "安慰剂p值图.gph",replace

*事件研究法
use "/Users/xuwenli/Library/CloudStorage/OneDrive-个人/0paper/143碳排放权与融资约束 with 孙磊 and 郑梦圆等/baseregdata.dta",clear
bys scode (year): egen Ei = min(year) if cer ==1
bys scode :fillmissing Ei,with(next)
	gen time_to_treat =year-Ei
*	replace time_to_treat =-5 if time_to_treat<=-5
	replace cer=0 if cer==.
*	ssc install eventdd,replace
eventdd KZ i.year i.province_ i.tclas_,timevar(time_to_treat) ci(rcap) cluster(province_) graph_op(ytitle("动态处理效应") xtitle("相对事件时间") xlabel(-5(1)5)) level(90) baseline(-1) inrange leads(5) lags(5)

eventdd KZ $Xs i.year i.province_ i.tclas_,timevar(time_to_treat) ci(rcap) cluster(province_) graph_op(ytitle("动态处理效应") xtitle("相对事件时间") xlabel(-5(1)5)) level(90) baseline(-1) inrange leads(5) lags(5)

// 平行趋势：处理前时期系数的联合检验：sup-t
xtevent KZ, pol(cer) w(5)  p(scode) t(year) cluster(province_)
xteventplot,noprepval nopostpval   

xtevent KZ $Xs, pol(cer) w(5)  p(scode) t(year) cluster(province_)
xteventplot,noprepval nopostpval

// 平行趋势和预期效应：pre-trends test

xtevent KZ, pol(cer) w(5)  p(scode) t(year) cluster(province_)
xteventplot, nopostpval 

//A failure of this hypothesis might indicate anticipatory behavior, or, in what seems a more common interpretation in practice, it might indicate the presence of a confound.

xtevent KZ $Xs, pol(cer) w(5)  p(scode) t(year) cluster(province_)
xteventplot,nopostpval


//异质性处理效应检验//
* 负权重检验

twowayfeweights KZ scode year cer, type(feTR) test_random_weights(year)

// 静态模型检验

xtevent KZ, policyvar(CER) panelvar(scode) timevar(year) window(-5 6) cluster(province)
xteventplot, nosupt noprepval nopostpval xtitle("碳排放权交易试点相对时间") ytitle("效应")
xteventplot, levels(90) overlay(static) staticovplotopts(lcolor(red)) nosupt xtitle("碳排放权交易试点相对时间") ytitle("融资约束效应")

xtevent KZ, policyvar(cer) panelvar(scode) timevar(year) window(-5 6) cluster(province)
xteventplot, nosupt noprepval nopostpval xtitle("碳排放权交易试点相对时间") ytitle("效应")
xteventplot, levels(90) overlay(static) staticovplotopts(lcolor(red)) nosupt xtitle("碳排放权交易试点相对时间") ytitle("融资约束效应")

*DIDF方法
"/Users/xuwenli/Library/CloudStorage/OneDrive-个人/0paper/143碳排放权与融资约束 with 孙磊 and 郑梦圆等/baseregdata.dta",clear
gen Lcer=l.cer
gen L2cer=l2.cer
gen L3cer=l3.cer
gen L4cer=l4.cer
gen L5cer=l5.cer
gen CER_flex = 1 if L5cer==1 | L4cer==1 | L3cer==1 | L2cer==1 | Lcer==1
replace CER_flex = 0 if CER_flex == .
flexpaneldid_preprocessing, id(scode) treatment(CER_flex) time(year) matchvars(LogSD LogPPE LogBM LogPGDP LogPOP LogISTR LogTIE) matchtimerel(-1) matchvarsexact(LogROA) prepdataset("preprocessed_data.dta") replace

"/Users/xuwenli/Library/CloudStorage/OneDrive-个人/0paper/143碳排放权与融资约束 with 孙磊 and 郑梦圆等/baseregdata.dta",clear
gen Lcer=l.cer
gen L2cer=l2.cer
gen L3cer=l3.cer
gen L4cer=l4.cer
gen L5cer=l5.cer
gen CER_flex = 1 if L5cer==1 | L4cer==1 | L3cer==1 | L2cer==1 | Lcer==1
replace CER_flex = 0 if CER_flex == .
flexpaneldid KZ, id(scode) treatment(CER_flex) time(year) statmatching(con(LogSD LogPPE LogBM LogPGDP LogPOP LogISTR LogTIE)) outcometimerelstart(3) outcomedev(-2 -1) test prepdataset("preprocessed_data.dta")


*DIDM方法
use "/Users/xuwenli/Library/CloudStorage/OneDrive-个人/0paper/143碳排放权与融资约束 with 孙磊 and 郑梦圆等/baseregdata.dta",clear
twowayfeweights KZ scode year cer,type(feTR)
ereturn list

did_multiplegt KZ scode year CER ,robust_dynamic dynamic(5) placebo(5) breps(100)

did_multiplegt KZ scode year cer ,robust_dynamic dynamic(5) placebo(5) breps(100) average_effect cluster(province_) controls($Xs)
ereturn list
event_plot e(estimates)#e(variances), default_look graph_opt(xtitle("政策时点") ytitle("政策动态效应",size(medium)) title("事件研究图") xlabel(-5 "pre_5" -4 "pre_4" -3 "pre_3" -2 "pre_2" -1 "pre_1" 0 "current" 1 "post_1" 2 "post_2" 3 "post_3" 4 "post_4" 5 "post_5")) stub_lag(Effect_#) stub_lead(Placebo_#) together
save "异质性处理效应检验DIDM.gph",replace


*did_imputation方法
use "/Users/xuwenli/Library/CloudStorage/OneDrive-个人/0paper/143碳排放权与融资约束 with 孙磊 and 郑梦圆等/baseregdata.dta",clear
bys scode (year): egen Ei = min(year) if CER ==1
* ssc install fillmissing,replace
bys scode :fillmissing Ei,with(next)
sort scode Ei
bys scode : replace Ei=Ei[1]
	gen K = year-Ei
* ssc install did_imputation,replace
did_imputation KZ scode year Ei, allhorizons pretrends(5) autosample
*Plotting
	event_plot, default_look graph_opt(xtitle("事件发生后时期") ytitle("平均处理效应") ///
		title("Borusyak et al. (2022) imputation estimator") name(BJS, replace)) together
		
did_imputation KZ scode year Ei, allhorizons pretrends(5) autosample controls($Xs)
*Plotting
event_plot, default_look graph_opt(xtitle("事件发生后时期") ytitle("平均处理效应") ///
		title("Borusyak et al. (2022) imputation estimator") name(BJS, replace)) together



* 不可观测混淆因子的事件研究
* 混淆因子检验：wiggly test
xtevent KZ, pol(cer) w(6)  p(scode) t(year) cluster(province_)
xteventplot, smpath(line) nopostpval 

//A failure of this hypothesis might indicate anticipatory behavior, or, in what seems a more common interpretation in practice, it might indicate the presence of a confound.

xtevent KZ $Xs, pol(cer) w(5)  p(scode) t(year) cluster(province_)
xteventplot,smpath(line) nopostpval

xtevent KZ, policyvar(cer) panelvar(scode) timevar(year) w(6) cluster(province)
xteventplot, nosupt
xtevent KZ, policyvar(cer) panelvar(scode) timevar(year) w(6) trend(-5)
xteventplot, overlay(trend) nosupt
xteventplot, nosupt levels(90)


xtevent KZ $Xs, policyvar(cer) panelvar(scode) timevar(year) w(6) trend(-5)
xteventplot, overlay(trend) nosupt
xteventplot, nosupt levels(90)

//稳健性检验//
use "C:\Users\LENOVO\Desktop\安徽大学\论文撰写\【思路】环境类财政政策，信息披露与企业投融资\baseregdata.dta",clear
*替换结果变量衡量方法
reghdfe SA CER $Xs ,absorb(i.province_ i.tclas_ i.year) vce(cluster province)
outreg2 using robustnessreg1.docx,replace bdec(3) tdec(2) keep(SA CER) addtext(Control, YES,Control滞后一期, NO,Province FE, YES,Industry FE, YES,Year FE, YES,Province-Industry FE, NO,Industry-Year FE, NO)
reghdfe SA CER $Xs ,absorb(i.province_#i.tclas_ i.year) vce(cluster province)
outreg2 using robustnessreg1.docx,append bdec(3) tdec(2) keep(SA CER) addtext(Control, YES,Control滞后一期, NO,Province FE, NO,Industry FE, NO,Year FE, YES,Province-Industry FE, YES,Industry-Year FE, NO)
reghdfe SA CER $Xs ,absorb(i.province_ i.tclas_#i.year) vce(cluster province)
outreg2 using robustnessreg1.docx,append bdec(3) tdec(2) keep(SA CER) addtext(Control, YES,Control滞后一期, NO,Province FE, YES,Industry FE, NO,Year FE, YES,Province-Industry FE, NO,Industry-Year FE, YES)


xtevent SA, policyvar(cer) panelvar(scode) timevar(year) w(6) cluster(province)
xteventplot, nosupt
xtevent SA, policyvar(cer) panelvar(scode) timevar(year) w(6) trend(-3)
xteventplot, overlay(trend) nosupt
xteventplot, nosupt levels(90)

xtevent SA $Xs, policyvar(cer) panelvar(scode) timevar(year) w(6) trend(-3)
xteventplot, overlay(trend) nosupt
xteventplot, nosupt levels(90)

*改变DID定义方式：碳排放权交易试点
gen Policy=1 if (province=="北京市" | province=="天津市" | province=="上海市" | province=="重庆市" | province=="湖北省" | province=="广东省" | city=="深圳市") & year>=2013
replace Policy=0 if Policy==.
reghdfe KZ Policy $Xs ,absorb(i.province_ i.tclas_ i.year) vce(cluster province)
outreg2 using robustnessreg1.docx,append bdec(3) tdec(2) keep(KZ Policy) addtext(Control, YES,Control滞后一期, NO,Province FE, YES,Industry FE, YES,Year FE, YES,Province-Industry FE, NO,Industry-Year FE, NO)

xtevent KZ, policyvar(Policy) panelvar(scode) timevar(year) w(5) cluster(province)
xteventplot, nosupt

xtevent KZ, policyvar(Policy) panelvar(scode) timevar(year) w(5) trend(-3)
xteventplot, overlay(trend) nosupt
xteventplot, nosupt levels(90)

xtevent KZ $Xs, policyvar(Policy) panelvar(scode) timevar(year) w(5) cluster(province)
xteventplot, nosupt

xtevent KZ $Xs, policyvar(Policy) panelvar(scode) timevar(year) w(5) trend(-3)
xteventplot, overlay(trend) nosupt
xteventplot, nosupt levels(90)

*更改控制变量：滞后一期
gen lLogSD=l.LogSD
gen lLogROA=l.LogROA
gen lLogPPE=l.LogPPE
gen lLogBM=l.LogBM
gen lLogPGDP=l.LogPGDP
gen lLogPOP=l.LogPOP
gen lLogISTR=l.LogISTR
gen lLogTIE=l.LogTIE
glob lXs lLogSD lLogROA lLogPPE lLogBM lLogPGDP lLogPOP lLogISTR lLogTIE
reghdfe KZ CER $lXs ,absorb(i.province_ i.tclas_ i.year) vce(cluster province)
outreg2 using robustnessreg1.docx,append bdec(3) tdec(2) keep(KZ CER) addtext(Control, NO,Control滞后一期, YES,Province FE, YES,Industry FE, YES,Year FE, YES,Province-Industry FE, NO,Industry-Year FE, NO)

*排除同期政策干扰（低碳试点城市|水权试点）
gen WRT=1 if (province=="宁夏回族自治区" | province=="江西省" | province=="湖北省" | province=="内蒙古自治区" | province=="河南省" | province=="甘肃省" | province=="广东省") & (year>=2014)
replace WRT=0 if WRT==.
reghdfe KZ CER WRT $Xs ,absorb(i.province_ i.tclas_ i.year) vce(cluster province)
outreg2 using robustnessreg2.docx,replace bdec(3) tdec(2) keep(KZ CER WRT) addtext(Control, YES,Province FE, YES,Industry FE, YES,Year FE, YES)

xtevent KZ WRT, policyvar(cer) panelvar(scode) timevar(year) w(5) cluster(province)
xteventplot, nosupt

xtevent KZ WRT, policyvar(cer) panelvar(scode) timevar(year) w(5) trend(-3)
xteventplot, overlay(trend) nosupt
xteventplot, nosupt levels(90)

xtevent KZ WRT $Xs, policyvar(Policy) panelvar(scode) timevar(year) w(5) cluster(province)
xteventplot, nosupt

xtevent KZ WRT $Xs, policyvar(Policy) panelvar(scode) timevar(year) w(5) trend(-3)
xteventplot, overlay(trend) nosupt
xteventplot, nosupt levels(90)

gen LCCity=1 if (province=="广东省" | province=="辽宁省" | province=="湖北省" | province=="陕西省" | province=="云南省" | province=="天津市" | province=="重庆市" | city=="厦门市" | city=="杭州市" | city=="南昌市" | city=="贵阳市" | city=="保定市") & (year>=2010)
replace LCCity=0 if LCCity==.
reghdfe KZ CER LCCity $Xs ,absorb(i.province_ i.tclas_ i.year) vce(cluster province)
outreg2 using robustnessreg2.docx,append bdec(3) tdec(2) keep(KZ CER LCCity) addtext(Control, YES,Province FE, YES,Industry FE, YES,Year FE, YES)

*溢出效应检验//
gen SpillE=1 if (tcode=="C25" | tcode=="C26" | tcode=="C30" | tcode=="C31" | tcode=="C32" | tcode=="C22" | tcode=="D44" | tcode=="G56")& (year>=2013)
replace SpillE=0 if SpillE==.
reghdfe KZ SpillE $Xs if treat==0 ,absorb(i.province_ i.tclas_ i.year) vce(cluster province)
outreg2 using robustnessreg2.docx,append bdec(3) tdec(2) keep(KZ CER SpillE) addtext(Control, YES,Province FE, YES,Industry FE, YES,Year FE, YES)


//异质性分析//
use "C:\Users\LENOVO\Desktop\安徽大学\论文撰写\【思路】环境类财政政策，信息披露与企业投融资\baseregdata.dta",clear
*企业所有制（国有|民营|外资）
gen SOE=1 if strmatch(enid ,"*1*")==1
replace SOE=2 if strmatch(enid ,"*2*")==1
replace SOE=3 if strmatch(enid ,"*3*")==1
reghdfe KZ CER $Xs if SOE==1 ,absorb(i.province_ i.tclas_ i.year) vce(cluster province)
outreg2 using heterogeneousregreg1.docx,replace bdec(3) tdec(2) keep(KZ CER) addtext(Control, YES,Province FE, YES,Industry FE, YES,Year FE, YES)
reghdfe KZ CER $Xs if SOE==2 ,absorb(i.province_ i.tclas_ i.year) vce(cluster province)
outreg2 using heterogeneousregreg1.docx,append bdec(3) tdec(2) keep(KZ CER) addtext(Control, YES,Province FE, YES,Industry FE, YES,Year FE, YES)
reghdfe KZ CER $Xs if SOE==3 ,absorb(i.province_ i.tclas_ i.year) vce(cluster province)
outreg2 using heterogeneousregreg1.docx,append bdec(3) tdec(2) keep(KZ CER) addtext(Control, YES,Province FE, YES,Industry FE, YES,Year FE, YES)

*企业规模(大型企业|中小型企业)
astile p_size=LogSIZE,nquantiles(4) by(year)
reghdfe KZ CER $Xs if p_size==4 ,absorb(i.province_ i.tclas_ i.year) vce(cluster province)
outreg2 using heterogeneousregreg1.docx,append bdec(3) tdec(2) keep(KZ CER) addtext(Control, YES,Province FE, YES,Industry FE, YES,Year FE, YES)
reghdfe KZ CER $Xs if p_size==3 | p_size==2 | p_size==1 ,absorb(i.province_ i.tclas_ i.year) vce(cluster province)
outreg2 using heterogeneousregreg1.docx,append bdec(3) tdec(2) keep(KZ CER) addtext(Control, YES,Province FE, YES,Industry FE, YES,Year FE, YES)

*企业年龄（企业年龄长|短）
astile p_age=LogAGE,nquantiles(4) by(year)
reghdfe KZ CER $Xs if p_age==4 ,absorb(i.province_ i.tclas_ i.year) vce(cluster province)
outreg2 using heterogeneousregreg1.docx,append bdec(3) tdec(2) keep(KZ CER) addtext(Control, YES,Province FE, YES,Industry FE, YES,Year FE, YES)
reghdfe KZ CER $Xs if p_age==3 | p_age==2 | p_age==1 ,absorb(i.province_ i.tclas_ i.year) vce(cluster province)
outreg2 using heterogeneousregreg1.docx,append bdec(3) tdec(2) keep(KZ CER) addtext(Control, YES,Province FE, YES,Industry FE, YES,Year FE, YES)

*资源配置效率（垄断|非垄断）
gen Mon=1 if (tcode=="B07" | tcode=="B06" |tcode=="C25" | tcode=="D44" | tcode=="D45" | tcode=="D46" | tcode=="G53" | tcode=="G56" | tcode=="C37" | tcode=="I63" | tcode=="R85")
replace Mon=0 if Mon==.
reghdfe KZ CER $Xs if Mon==1 ,absorb(i.province_ i.tclas_ i.year) vce(cluster province)
outreg2 using heterogeneousregreg1.docx,append bdec(3) tdec(2) keep(KZ CER) addtext(Control, YES,Province FE, YES,Industry FE, YES,Year FE, YES)
reghdfe KZ CER $Xs if Mon==0 ,absorb(i.province_ i.tclas_ i.year) vce(cluster province)
outreg2 using heterogeneousregreg1.docx,append bdec(3) tdec(2) keep(KZ CER) addtext(Control, YES,Province FE, YES,Industry FE, YES,Year FE, YES)
