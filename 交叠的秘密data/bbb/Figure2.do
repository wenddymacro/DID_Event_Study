**********************************************************************************************************************************
*** Date:    December 2009
*** Authors: Beck, Levine, and Levkov
*** Purpose: Create Figure 2 in "Big Bad Banks? The Winners and Losers from Bank Deregulation in the United States"
*** Note:    Please change the working directories below 
**********************************************************************************************************************************


#delimit;
clear;
set mem 100m;
set more off;

cd "/home/alevkov/BeckLevineLevkov2010";

log using Figure2.log, replace;

use "/home/alevkov/BeckLevineLevkov2010/data/macro_workfile.dta", clear;

replace p1=log(p1);
replace p2=log(p2);
replace p3=log(p3);
replace p4=log(p4);
replace p5=log(p5);
replace p6=log(p6);
replace p7=log(p7);
replace p8=log(p8);
replace p9=log(p9);
replace p10=log(p10);
replace p11=log(p11);
replace p12=log(p12);
replace p13=log(p13);
replace p14=log(p14);
replace p15=log(p15);
replace p16=log(p16);
replace p17=log(p17);
replace p18=log(p18);
replace p19=log(p19);
replace p20=log(p20);
replace p21=log(p21);
replace p22=log(p22);
replace p23=log(p23);
replace p24=log(p24);
replace p25=log(p25);
replace p26=log(p26);
replace p27=log(p27);
replace p28=log(p28);
replace p29=log(p29);
replace p30=log(p30);
replace p31=log(p31);
replace p32=log(p32);
replace p33=log(p33);
replace p34=log(p34);
replace p35=log(p35);
replace p36=log(p36);
replace p37=log(p37);
replace p38=log(p38);
replace p39=log(p39);
replace p40=log(p40);
replace p41=log(p41);
replace p42=log(p42);
replace p43=log(p43);
replace p44=log(p44);
replace p45=log(p45);
replace p46=log(p46);
replace p47=log(p47);
replace p48=log(p48);
replace p49=log(p49);
replace p50=log(p50);
replace p51=log(p51);
replace p52=log(p52);
replace p53=log(p53);
replace p54=log(p54);
replace p55=log(p55);
replace p56=log(p56);
replace p57=log(p57);
replace p58=log(p58);
replace p59=log(p59);
replace p60=log(p60);
replace p61=log(p61);
replace p62=log(p62);
replace p63=log(p63);
replace p64=log(p64);
replace p65=log(p65);
replace p66=log(p66);
replace p67=log(p67);
replace p68=log(p68);
replace p69=log(p69);
replace p70=log(p70);
replace p71=log(p71);
replace p72=log(p72);
replace p73=log(p73);
replace p74=log(p74);
replace p75=log(p75);
replace p76=log(p76);
replace p77=log(p77);
replace p78=log(p78);
replace p79=log(p79);
replace p80=log(p80);
replace p81=log(p81);
replace p82=log(p82);
replace p83=log(p83);
replace p84=log(p84);
replace p85=log(p85);
replace p86=log(p86);
replace p87=log(p87);
replace p88=log(p88);
replace p89=log(p89);
replace p90=log(p90);
replace p91=log(p91);
replace p92=log(p92);
replace p93=log(p93);
replace p94=log(p94);
replace p95=log(p95);
replace p96=log(p96);
replace p97=log(p97);
replace p98=log(p98);
replace p99=log(p99);

tsset statefip wrkyr;

tabulate wrkyr, gen(wrkyr_dumm);

xtreg p1 _intra  wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
gen   b1=_b[_intra];
gen   s1=_se[_intra];

xtreg p2 _intra  wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
gen   b2=_b[_intra];
gen   s2=_se[_intra];

xtreg p3 _intra  wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
gen   b3=_b[_intra];
gen   s3=_se[_intra];

xtreg p4 _intra  wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
gen   b4=_b[_intra];
gen   s4=_se[_intra];

xtreg p5 _intra  wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
gen   b5=_b[_intra];
gen   s5=_se[_intra];

xtreg p6 _intra  wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
gen   b6=_b[_intra];
gen   s6=_se[_intra];

xtreg p7 _intra  wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
gen   b7=_b[_intra];
gen   s7=_se[_intra];

xtreg p8 _intra  wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
gen   b8=_b[_intra];
gen   s8=_se[_intra];

xtreg p9 _intra  wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
gen   b9=_b[_intra];
gen   s9=_se[_intra];

xtreg p10 _intra  wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
gen   b10=_b[_intra];
gen   s10=_se[_intra];

xtreg p11 _intra  wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
gen   b11=_b[_intra];
gen   s11=_se[_intra];

xtreg p12 _intra  wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
gen   b12=_b[_intra];
gen   s12=_se[_intra];

xtreg p13 _intra  wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
gen   b13=_b[_intra];
gen   s13=_se[_intra];

xtreg p14 _intra  wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
gen   b14=_b[_intra];
gen   s14=_se[_intra];

xtreg p15 _intra  wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
gen   b15=_b[_intra];
gen   s15=_se[_intra];

xtreg p16 _intra  wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
gen   b16=_b[_intra];
gen   s16=_se[_intra];

xtreg p17 _intra  wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
gen   b17=_b[_intra];
gen   s17=_se[_intra];

xtreg p18 _intra  wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
gen   b18=_b[_intra];
gen   s18=_se[_intra];

xtreg p19 _intra  wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
gen   b19=_b[_intra];
gen   s19=_se[_intra];

xtreg p20 _intra  wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
gen   b20=_b[_intra];
gen   s20=_se[_intra];

xtreg p21 _intra  wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
gen   b21=_b[_intra];
gen   s21=_se[_intra];

xtreg p22 _intra  wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
gen   b22=_b[_intra];
gen   s22=_se[_intra];

xtreg p23 _intra  wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
gen   b23=_b[_intra];
gen   s23=_se[_intra];

xtreg p24 _intra  wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
gen   b24=_b[_intra];
gen   s24=_se[_intra];

xtreg p25 _intra  wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
gen   b25=_b[_intra];
gen   s25=_se[_intra];

xtreg p26 _intra  wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
gen   b26=_b[_intra];
gen   s26=_se[_intra];

xtreg p27 _intra  wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
gen   b27=_b[_intra];
gen   s27=_se[_intra];

xtreg p28 _intra  wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
gen   b28=_b[_intra];
gen   s28=_se[_intra];

xtreg p29 _intra  wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
gen   b29=_b[_intra];
gen   s29=_se[_intra];

xtreg p30 _intra  wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
gen   b30=_b[_intra];
gen   s30=_se[_intra];

xtreg p31 _intra  wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
gen   b31=_b[_intra];
gen   s31=_se[_intra];

xtreg p32 _intra  wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
gen   b32=_b[_intra];
gen   s32=_se[_intra];

xtreg p33 _intra  wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
gen   b33=_b[_intra];
gen   s33=_se[_intra];

xtreg p34 _intra  wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
gen   b34=_b[_intra];
gen   s34=_se[_intra];

xtreg p35 _intra  wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
gen   b35=_b[_intra];
gen   s35=_se[_intra];

xtreg p36 _intra  wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
gen   b36=_b[_intra];
gen   s36=_se[_intra];

xtreg p37 _intra  wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
gen   b37=_b[_intra];
gen   s37=_se[_intra];

xtreg p38 _intra  wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
gen   b38=_b[_intra];
gen   s38=_se[_intra];

xtreg p39 _intra  wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
gen   b39=_b[_intra];
gen   s39=_se[_intra];

xtreg p40 _intra  wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
gen   b40=_b[_intra];
gen   s40=_se[_intra];

xtreg p41 _intra  wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
gen   b41=_b[_intra];
gen   s41=_se[_intra];

xtreg p42 _intra  wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
gen   b42=_b[_intra];
gen   s42=_se[_intra];

xtreg p43 _intra  wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
gen   b43=_b[_intra];
gen   s43=_se[_intra];

xtreg p44 _intra  wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
gen   b44=_b[_intra];
gen   s44=_se[_intra];

xtreg p45 _intra  wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
gen   b45=_b[_intra];
gen   s45=_se[_intra];

xtreg p46 _intra  wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
gen   b46=_b[_intra];
gen   s46=_se[_intra];

xtreg p47 _intra  wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
gen   b47=_b[_intra];
gen   s47=_se[_intra];

xtreg p48 _intra  wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
gen   b48=_b[_intra];
gen   s48=_se[_intra];

xtreg p49 _intra  wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
gen   b49=_b[_intra];
gen   s49=_se[_intra];

xtreg p50 _intra  wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
gen   b50=_b[_intra];
gen   s50=_se[_intra];

xtreg p51 _intra  wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
gen   b51=_b[_intra];
gen   s51=_se[_intra];

xtreg p52 _intra  wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
gen   b52=_b[_intra];
gen   s52=_se[_intra];

xtreg p53 _intra  wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
gen   b53=_b[_intra];
gen   s53=_se[_intra];

xtreg p54 _intra  wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
gen   b54=_b[_intra];
gen   s54=_se[_intra];

xtreg p55 _intra  wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
gen   b55=_b[_intra];
gen   s55=_se[_intra];

xtreg p56 _intra  wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
gen   b56=_b[_intra];
gen   s56=_se[_intra];

xtreg p57 _intra  wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
gen   b57=_b[_intra];
gen   s57=_se[_intra];

xtreg p58 _intra  wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
gen   b58=_b[_intra];
gen   s58=_se[_intra];

xtreg p59 _intra  wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
gen   b59=_b[_intra];
gen   s59=_se[_intra];

xtreg p60 _intra  wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
gen   b60=_b[_intra];
gen   s60=_se[_intra];

xtreg p61 _intra  wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
gen   b61=_b[_intra];
gen   s61=_se[_intra];

xtreg p62 _intra  wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
gen   b62=_b[_intra];
gen   s62=_se[_intra];

xtreg p63 _intra  wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
gen   b63=_b[_intra];
gen   s63=_se[_intra];

xtreg p64 _intra  wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
gen   b64=_b[_intra];
gen   s64=_se[_intra];

xtreg p65 _intra  wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
gen   b65=_b[_intra];
gen   s65=_se[_intra];

xtreg p66 _intra  wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
gen   b66=_b[_intra];
gen   s66=_se[_intra];

xtreg p67 _intra  wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
gen   b67=_b[_intra];
gen   s67=_se[_intra];

xtreg p68 _intra  wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
gen   b68=_b[_intra];
gen   s68=_se[_intra];

xtreg p69 _intra  wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
gen   b69=_b[_intra];
gen   s69=_se[_intra];

xtreg p70 _intra  wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
gen   b70=_b[_intra];
gen   s70=_se[_intra];

xtreg p71 _intra  wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
gen   b71=_b[_intra];
gen   s71=_se[_intra];

xtreg p72 _intra  wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
gen   b72=_b[_intra];
gen   s72=_se[_intra];

xtreg p73 _intra  wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
gen   b73=_b[_intra];
gen   s73=_se[_intra];

xtreg p74 _intra  wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
gen   b74=_b[_intra];
gen   s74=_se[_intra];

xtreg p75 _intra  wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
gen   b75=_b[_intra];
gen   s75=_se[_intra];

xtreg p76 _intra  wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
gen   b76=_b[_intra];
gen   s76=_se[_intra];

xtreg p77 _intra  wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
gen   b77=_b[_intra];
gen   s77=_se[_intra];

xtreg p78 _intra  wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
gen   b78=_b[_intra];
gen   s78=_se[_intra];

xtreg p79 _intra  wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
gen   b79=_b[_intra];
gen   s79=_se[_intra];

xtreg p80 _intra  wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
gen   b80=_b[_intra];
gen   s80=_se[_intra];

xtreg p81 _intra  wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
gen   b81=_b[_intra];
gen   s81=_se[_intra];

xtreg p82 _intra  wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
gen   b82=_b[_intra];
gen   s82=_se[_intra];

xtreg p83 _intra  wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
gen   b83=_b[_intra];
gen   s83=_se[_intra];

xtreg p84 _intra  wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
gen   b84=_b[_intra];
gen   s84=_se[_intra];

xtreg p85 _intra  wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
gen   b85=_b[_intra];
gen   s85=_se[_intra];

xtreg p86 _intra  wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
gen   b86=_b[_intra];
gen   s86=_se[_intra];

xtreg p87 _intra  wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
gen   b87=_b[_intra];
gen   s87=_se[_intra];

xtreg p88 _intra  wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
gen   b88=_b[_intra];
gen   s88=_se[_intra];

xtreg p89 _intra  wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
gen   b89=_b[_intra];
gen   s89=_se[_intra];

xtreg p90 _intra  wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
gen   b90=_b[_intra];
gen   s90=_se[_intra];

xtreg p91 _intra  wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
gen   b91=_b[_intra];
gen   s91=_se[_intra];

xtreg p92 _intra  wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
gen   b92=_b[_intra];
gen   s92=_se[_intra];

xtreg p93 _intra  wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
gen   b93=_b[_intra];
gen   s93=_se[_intra];

xtreg p94 _intra  wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
gen   b94=_b[_intra];
gen   s94=_se[_intra];

xtreg p95 _intra  wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
gen   b95=_b[_intra];
gen   s95=_se[_intra];

xtreg p96 _intra  wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
gen   b96=_b[_intra];
gen   s96=_se[_intra];

xtreg p97 _intra  wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
gen   b97=_b[_intra];
gen   s97=_se[_intra];

xtreg p98 _intra  wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
gen   b98=_b[_intra];
gen   s98=_se[_intra];

xtreg p99 _intra  wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
gen   b99=_b[_intra];
gen   s99=_se[_intra];

keep b1-b99 s1-s99;
duplicates drop;
save temp, replace;

use temp, clear;
keep b1  b2  b3  b4  b5  b6  b7  b8  b9  b10
     b11 b12 b13 b14 b15 b16 b17 b18 b19 b20
     b21 b22 b23 b24 b25 b26 b27 b28 b29 b30
     b31 b32 b33 b34 b35 b36 b37 b38 b39 b40
     b41 b42 b43 b44 b45 b46 b47 b48 b49 b50
     b51 b52 b53 b54 b55 b56 b57 b58 b59 b60
     b61 b62 b63 b64 b65 b66 b67 b68 b69 b70
     b71 b72 b73 b74 b75 b76 b77 b78 b79 b80
     b81 b82 b83 b84 b85 b86 b87 b88 b89 b90
     b91 b92 b93 b94 b95 b96 b97 b98 b99;
xpose, clear;
rename v1 b;
gen percentile=_n;
sort percentile;
save betas, replace;

use temp, clear;
keep s1  s2  s3  s4  s5  s6  s7  s8  s9  s10
     s11 s12 s13 s14 s15 s16 s17 s18 s19 s20
     s21 s22 s23 s24 s25 s26 s27 s28 s29 s30
     s31 s32 s33 s34 s35 s36 s37 s38 s39 s40
     s41 s42 s43 s44 s45 s46 s47 s48 s49 s50
     s51 s52 s53 s54 s55 s56 s57 s58 s59 s60
     s61 s62 s63 s64 s65 s66 s67 s68 s69 s70
     s71 s72 s73 s74 s75 s76 s77 s78 s79 s80
     s81 s82 s83 s84 s85 s86 s87 s88 s89 s90
     s91 s92 s93 s94 s95 s96 s97 s98 s99;
xpose, clear;
rename v1 se;
gen percentile=_n;
sort percentile;
merge percentile using betas;
drop _merge*;

gen ci_lb = b-1.96*se;
gen ci_ub = b+1.96*se;

drop if percentile<=4;
drop if percentile>=6  & percentile<10;
drop if percentile>=11 & percentile<15;
drop if percentile>=16 & percentile<20;
drop if percentile>=21 & percentile<25;
drop if percentile>=26 & percentile<30;
drop if percentile>=31 & percentile<35;
drop if percentile>=36 & percentile<40;
drop if percentile>=41 & percentile<45;
drop if percentile>=46 & percentile<50;
drop if percentile>=51 & percentile<55;
drop if percentile>=56 & percentile<60;
drop if percentile>=61 & percentile<65;
drop if percentile>=66 & percentile<70;
drop if percentile>=71 & percentile<75;
drop if percentile>=76 & percentile<80;
drop if percentile>=81 & percentile<85;
drop if percentile>=86 & percentile<90;
drop if percentile>=91 & percentile<95;
drop if percentile>=96;


twoway (bar b percentile if percentile<=35, sort fcolor(navy) lcolor(navy) barwidth(3))
       (bar b percentile if percentile>=40, sort fcolor(navy) lcolor(navy) barwidth(3) fintensity(30)), 
       ytitle(Percentage change) ytitle(, size(small)) ylabel(, labsize(small) angle(horizontal) nogrid) 
       xtitle(Percentile of income distribution) xtitle(, size(small)) xlabel(5(5)95, labsize(small)) 
       legend(order(1 "Significant at 5%" 2 "Not significant") size(small))
       graphregion(fcolor(white) lcolor(white) ifcolor(white) ilcolor(white));
       graph save Figure2, asis replace;

erase temp.dta;
erase betas.dta;
     
log close;
