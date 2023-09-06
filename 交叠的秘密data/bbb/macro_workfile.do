********************************************************************************************
*** DATE:         December 2009
*** AUTHORS:      Beck, Levine, and Levkov
*** THIS PROGRAM: Creates a state-year level 'working' file for the 'Big Bad Banks...' paper
*** NOTE:         Have to install inequality packages in Stata before running this .do file.
***               To do so type: 'ssc install egen_inequal' and 'ssc install ineqdeco'
********************************************************************************************                            


#delimit;
clear;
set more off;
set memory 4g;

cd "/home/alevkov/BeckLevineLevkov2010/data";

use micro_workfile.dta, clear;
keep if main_sample == 1;
keep statefip wrkyr _inctot_cpi_tr0199 _perwt serial;
generate Y = _inctot_cpi_tr0199;
save temp, replace;

*****************************;
*** Different percentiles ***;
*****************************;
use temp, clear;

collapse 
(p1)   p1=Y
(p2)   p2=Y
(p3)   p3=Y
(p4)   p4=Y
(p5)   p5=Y
(p6)   p6=Y
(p7)   p7=Y
(p8)   p8=Y
(p9)   p9=Y
(p10)  p10=Y
(p11)  p11=Y
(p12)  p12=Y
(p13)  p13=Y
(p14)  p14=Y
(p15)  p15=Y
(p16)  p16=Y
(p17)  p17=Y
(p18)  p18=Y
(p19)  p19=Y
(p20)  p20=Y
(p21)  p21=Y
(p22)  p22=Y
(p23)  p23=Y
(p24)  p24=Y
(p25)  p25=Y
(p26)  p26=Y
(p27)  p27=Y
(p28)  p28=Y
(p29)  p29=Y
(p30)  p30=Y
(p31)  p31=Y
(p32)  p32=Y
(p33)  p33=Y
(p34)  p34=Y
(p35)  p35=Y
(p36)  p36=Y
(p37)  p37=Y
(p38)  p38=Y
(p39)  p39=Y
(p40)  p40=Y
(p41)  p41=Y
(p42)  p42=Y
(p43)  p43=Y
(p44)  p44=Y
(p45)  p45=Y
(p46)  p46=Y
(p47)  p47=Y
(p48)  p48=Y
(p49)  p49=Y
(p50)  p50=Y
(p51)  p51=Y
(p52)  p52=Y
(p53)  p53=Y
(p54)  p54=Y
(p55)  p55=Y
(p56)  p56=Y
(p57)  p57=Y
(p58)  p58=Y
(p59)  p59=Y
(p60)  p60=Y
(p61)  p61=Y
(p62)  p62=Y
(p63)  p63=Y
(p64)  p64=Y
(p65)  p65=Y
(p66)  p66=Y
(p67)  p67=Y
(p68)  p68=Y
(p69)  p69=Y
(p70)  p70=Y
(p71)  p71=Y
(p72)  p72=Y
(p73)  p73=Y
(p74)  p74=Y
(p75)  p75=Y
(p76)  p76=Y
(p77)  p77=Y
(p78)  p78=Y
(p79)  p79=Y
(p80)  p80=Y
(p81)  p81=Y
(p82)  p82=Y
(p83)  p83=Y
(p84)  p84=Y
(p85)  p85=Y
(p86)  p86=Y
(p87)  p87=Y
(p88)  p88=Y
(p89)  p89=Y
(p90)  p90=Y
(p91)  p91=Y
(p92)  p92=Y
(p93)  p93=Y
(p94)  p94=Y
(p95)  p95=Y
(p96)  p96=Y
(p97)  p97=Y
(p98)  p98=Y
(p99)  p99=Y
[pw=_perwt], by(statefip wrkyr);
label var p1  "1st percentile of income distribution";
label var p2  "2nd percentile of income distribution";
label var p3  "3rd percentile of income distribution";
label var p4  "4th percentile of income distribution";
label var p5  "5th percentile of income distribution";
label var p6  "6th percentile of income distribution";
label var p7  "7th percentile of income distribution";
label var p8  "8th percentile of income distribution";
label var p9  "9th percentile of income distribution";
label var p10 "10th percentile of income distribution";

label var p11  "11th percentile of income distribution";
label var p12  "12th percentile of income distribution";
label var p13  "13th percentile of income distribution";
label var p14  "14th percentile of income distribution";
label var p15  "15th percentile of income distribution";
label var p16  "16th percentile of income distribution";
label var p17  "17th percentile of income distribution";
label var p18  "18th percentile of income distribution";
label var p19  "19th percentile of income distribution";
label var p20  "20th percentile of income distribution";

label var p21  "21st percentile of income distribution";
label var p22  "22nd percentile of income distribution";
label var p23  "23rd percentile of income distribution";
label var p24  "24th percentile of income distribution";
label var p25  "25th percentile of income distribution";
label var p26  "26th percentile of income distribution";
label var p27  "27th percentile of income distribution";
label var p28  "28th percentile of income distribution";
label var p29  "29th percentile of income distribution";
label var p30  "30th percentile of income distribution";

label var p31  "31st percentile of income distribution";
label var p32  "32nd percentile of income distribution";
label var p33  "33rd percentile of income distribution";
label var p34  "34th percentile of income distribution";
label var p35  "35th percentile of income distribution";
label var p36  "36th percentile of income distribution";
label var p37  "37th percentile of income distribution";
label var p38  "38th percentile of income distribution";
label var p39  "39th percentile of income distribution";
label var p40  "40th percentile of income distribution";

label var p41  "41st percentile of income distribution";
label var p42  "42nd percentile of income distribution";
label var p43  "43rd percentile of income distribution";
label var p44  "44th percentile of income distribution";
label var p45  "45th percentile of income distribution";
label var p46  "46th percentile of income distribution";
label var p47  "47th percentile of income distribution";
label var p48  "48th percentile of income distribution";
label var p49  "49th percentile of income distribution";
label var p50  "50th percentile of income distribution";

label var p51  "51st percentile of income distribution";
label var p52  "52nd percentile of income distribution";
label var p53  "53rd percentile of income distribution";
label var p54  "54th percentile of income distribution";
label var p55  "55th percentile of income distribution";
label var p56  "56th percentile of income distribution";
label var p57  "57th percentile of income distribution";
label var p58  "58th percentile of income distribution";
label var p59  "59th percentile of income distribution";
label var p60  "60th percentile of income distribution";

label var p61  "61st percentile of income distribution";
label var p62  "62nd percentile of income distribution";
label var p63  "63rd percentile of income distribution";
label var p64  "64th percentile of income distribution";
label var p65  "65th percentile of income distribution";
label var p66  "66th percentile of income distribution";
label var p67  "67th percentile of income distribution";
label var p68  "68th percentile of income distribution";
label var p69  "69th percentile of income distribution";
label var p70  "70th percentile of income distribution";

label var p71  "71st percentile of income distribution";
label var p72  "72nd percentile of income distribution";
label var p73  "73rd percentile of income distribution";
label var p74  "74th percentile of income distribution";
label var p75  "75th percentile of income distribution";
label var p76  "76th percentile of income distribution";
label var p77  "77th percentile of income distribution";
label var p78  "78th percentile of income distribution";
label var p79  "79th percentile of income distribution";
label var p80  "80th percentile of income distribution";

label var p81  "81st percentile of income distribution";
label var p82  "82nd percentile of income distribution";
label var p83  "83rd percentile of income distribution";
label var p84  "84th percentile of income distribution";
label var p85  "85th percentile of income distribution";
label var p86  "86th percentile of income distribution";
label var p87  "87th percentile of income distribution";
label var p88  "88th percentile of income distribution";
label var p89  "89th percentile of income distribution";
label var p90  "90th percentile of income distribution";

label var p91  "91st percentile of income distribution";
label var p92  "92nd percentile of income distribution";
label var p93  "93rd percentile of income distribution";
label var p94  "94th percentile of income distribution";
label var p95  "95th percentile of income distribution";
label var p96  "96th percentile of income distribution";
label var p97  "97th percentile of income distribution";
label var p98  "98th percentile of income distribution";
label var p99  "99th percentile of income distribution";

sort statefip wrkyr;
save percentiles, replace;

***********************************;
*** More measures of inequality ***;
***********************************;
use temp, clear;
replace  Y = 1 if Y == 0; 

egen gini  = inequal(Y), by(statefip wrkyr) weights(_perwt) index(gini);
egen theil = inequal(Y), by(statefip wrkyr) weights(_perwt) index(theil);

label var gini "Gini index of income inequality";
label var theil "Theil index of income inequality";

keep statefip wrkyr gini theil;
duplicates drop;
drop if gini==.;
sort statefip wrkyr;
merge statefip wrkyr using percentiles;
drop _merge*;
erase percentiles.dta;
erase temp.dta;
sort statefip wrkyr;
generate macro_workfile=1;
save macro_workfile, replace;


*************************;
*** Percentage blacks ***;
*************************;
use micro_workfile.dta, clear;
keep if main_sample == 1;
collapse (mean) _black [pw=_perwt], by(statefip wrkyr);
rename _black prop_blacks;
label variable prop_blacks "Proportion blacks";
sort statefip wrkyr;
save blacks, replace;


******************************;
*** % High-school dropouts ***;
******************************;
use micro_workfile.dta, clear;
keep if main_sample == 1;
generate _hsdrop = 0;
replace  _hsdrop = 1 if _hsd08==1;
replace  _hsdrop = 1 if _hsd911==1;
collapse (mean) _hsdrop [pw=_perwt], by(statefip wrkyr);
rename _hsdrop prop_dropouts;
label variable prop_dropouts "Proportion high-school dropouts";
sort statefip wrkyr;
save hs_drops, replace;


*******************************************;
*** Percentage female-headed households ***;
*******************************************;
use micro_workfile.dta, clear;
keep if main_sample == 1;
keep statefip wrkyr _hhwt serial _female_headed;
bysort statefip wrkyr serial: egen d = max(_female_headed);
duplicates drop;
collapse (mean) _female_headed [pw=_hhwt], by(statefip wrkyr);
rename _female_headed prop_female_headed;
label variable prop_female_headed "Proportion female-headed households";
sort statefip wrkyr;
save female_headed, replace;

*************************;
*** Unemployment rate ***;
*************************;
use BLS, clear;
rename year wrkyr;
keep statefip wrkyr unemploymentrate;
label var unemploymentrate "Unemployment rate";
sort statefip wrkyr;
save unemployed, replace;

**********************;
*** GSP per capita ***;
**********************;
use GSP, clear;
sort statefip year;
save gsp, replace;


****************************;
*** Population estimates ***;
****************************;
use population, clear;
sort statefip year;
merge statefip year using gsp;
drop _merge;
keep if year>=1975;
generate gsp_pc=(gsp*1000000)/population;
generate _cpi=.;
replace  _cpi =	53.8	if year == 	1975	;
replace  _cpi =	56.9	if year == 	1976	;
replace  _cpi =	60.6	if year == 	1977	;
replace  _cpi =	65.2	if year == 	1978	;
replace  _cpi =	72.6	if year == 	1979	;
replace  _cpi =	82.4	if year == 	1980	;
replace  _cpi =	90.9	if year == 	1981	;
replace  _cpi =	96.5	if year == 	1982	;
replace  _cpi =	99.6	if year == 	1983	;
replace  _cpi =	103.9	if year == 	1984	;
replace  _cpi =	107.6	if year == 	1985	;
replace  _cpi =	109.6	if year == 	1986	;
replace  _cpi =	113.6	if year == 	1987	;
replace  _cpi =	118.3	if year == 	1988	;
replace  _cpi =	124	if year == 	1989	;
replace  _cpi =	130.7	if year == 	1990	;
replace  _cpi =	136.2	if year == 	1991	;
replace  _cpi =	140.3	if year == 	1992	;
replace  _cpi =	144.5	if year == 	1993	;
replace  _cpi =	148.2	if year == 	1994	;
replace  _cpi =	152.4	if year == 	1995	;
replace  _cpi =	156.9	if year == 	1996	;
replace  _cpi =	160.5	if year == 	1997	;
replace  _cpi =	163	if year == 	1998	;
replace  _cpi =	166.6	if year == 	1999	;
replace  _cpi =	172.2	if year == 	2000	;
replace  _cpi =	177.1	if year == 	2001	;
replace  _cpi =	179.9	if year == 	2002	;
replace  _cpi =	184	if year == 	2003	;
replace  _cpi =	188.9	if year == 	2004	;
replace  _cpi =	195.3	if year == 	2005	;
replace  _cpi =	201.6	if year == 	2006	;
replace  _cpi =	207.342 if year == 	2007	;

generate _cpi_deflator2000 = 172.200 / _cpi ;

replace gsp_pc = gsp_pc*_cpi_deflator2000;
label var gsp_pc "Per capita Gross State Product (2000 dollars)";
drop gsp;

sort statefip year;
bysort statefip: generate prev=gsp_pc[_n-1];
generate gsp_pc_growth = (gsp_pc - prev)/prev;
drop prev;
label var gsp_pc_growth "Growth rate of per capita Gross State Product (2000 dollars)";
rename year wrkyr;
sort statefip wrkyr;
save gsp, replace;


*************************;
*** Merging all files ***;
*************************;
use macro_workfile, clear;
merge statefip wrkyr using blacks hs_drops female_headed unemployed gsp;
drop _merge*;
erase blacks.dta;
erase hs_drops.dta;
erase female_headed.dta;
erase unemployed.dta;
erase gsp.dta;
keep if wrkyr>=1976 & wrkyr<=2006;
keep if macro_workfile==1;
sum prop_blacks;
sort statefip;
save temp, replace;


*******************************;
*** Bank deregulation dates ***; 
*******************************;
use reforms, clear;
sort statefip;
merge statefip using temp;
drop _merge*;
erase temp.dta;
keep if macro_workfile==1;

generate _intra = 0 ;
replace  _intra = 1 if wrkyr > branch_reform     ;

label variable _intra "=1 in the years after bank branch deregulation";
label variable branch_reform "Year of bank branch deregulation";

generate unit_banking = 0;
replace  unit_banking = 1 if state == "CO";
replace  unit_banking = 1 if state == "AR";
replace  unit_banking = 1 if state == "FL";
replace  unit_banking = 1 if state == "IL";
replace  unit_banking = 1 if state == "IA";
replace  unit_banking = 1 if state == "KS";
replace  unit_banking = 1 if state == "MN";
replace  unit_banking = 1 if state == "MO";
replace  unit_banking = 1 if state == "MT";
replace  unit_banking = 1 if state == "NE";
replace  unit_banking = 1 if state == "ND";
replace  unit_banking = 1 if state == "OK";
replace  unit_banking = 1 if state == "TX";
replace  unit_banking = 1 if state == "WI";
replace  unit_banking = 1 if state == "WV";
replace  unit_banking = 1 if state == "WY";
label var unit_banking "=1 if unit banking state";

sort statefip wrkyr;
save macro_workfile, replace;


****************************************;
*** Kroszner and Strahan (QJE, 1999) ***;
****************************************;
use qje99.dta, clear;

destring , force replace;

rename bank9210 statefip;

replace year = year + 1900;

sort statefip year;

gen dem=(sen+house+gov)/3;
replace lncon1 = lncon1-fedfund;

gen bankpow=0;
replace bankpow=1 if ins_year <= 91 & ins_year >= 70;

gen inter2=(1-ins_dum)*ins_bkva;

label var ass4_ass "Small bank asset share of all banking assets in the state";
label var cap_dif4 "Capital ratio of small banks relative to large in the state";
label var inter1 "Relative size of insurance in states where banks may sell insurance, 0 otherwise";
label var ins_dum "Indicator is 1 if banks may sell insurance in the state";
label var inter2 "Relative size of insurance in states where banks may not sell insurance, 0 otherwise";
label var e_interp "Small firm share of the number of firms in the state";
label var dem "Share of state government controlled by Democrats";
label var uniform "Indicator is 1 if state controlled by one party";
label var lncon1 "Average yield on bank loans in the state minus Fed funds rate";
label var unit "Indicator is 1 if state has unit banking law";
label var ins_bkva "Relative size of insurance";
label var bankpow "Indicator is 1 if state changes bank insurance powers";

summ ass4_ass cap_dif4 inter1 ins_dum inter2 e_interp dem uniform unit bankpow;
generate ks99=1;
label var ks99 "=1 if from Kroszner and Strahan (1999) sample";

rename year wrkyr;
sort statefip wrkyr;
merge statefip wrkyr using macro_workfile;
drop _merge*;
keep if macro_workfile==1;
sort statefip;
save macro_workfile, replace;


*****************************;
*** Population dispersion ***;
*****************************;
use pop_density.dta, clear;
rename state state_name;
rename y1960 pop_density1960;
gen a=1;
keep a state_name pop_density1960;
sort state_name;
save temp, replace;

use state_names_and_codes.dta, clear;
gen b=1;
sort state_name;
merge state_name using temp;
keep statefip pop_density1960;
sort statefip;
merge statefip using macro_workfile;
drop _merge*;
keep if macro_workfile==1;

generate pop_dispersion = 1 / pop_density1960;
label var pop_dispersion "Population dispersion in 1960";
drop pop_density1960;
sum prop_blacks;
sort state_name;
save macro_workfile, replace;


*******************************************************;
*** More data from Kroszner and Strahan (QJE, 1999) ***;
*******************************************************;
#delimit cr
use strahan_qje1999, clear
keep if year=="76"
rename ins_dum sell_insurance
rename ins_bkva insurance_size
rename ass4_ass small_banks
destring small_banks, replace
rename e_interp small_firms
keep state_name sell_insurance insurance_size small_banks small_firms
duplicates drop
label var sell_insurance "=1 if banks were allowed to sell insurance"
label var insurance_size "Relative size of insurance"
label var small_banks "Small bank asset share of all banking assets in state"
label var small_firms "Small firm share of the number of firms in the state"
sort state_name
merge state_name using macro_workfile
drop _merge*
keep if macro_workfile==1
drop macro_workfile
#delimit;

label var state "State postal code";
label var state_name "State name";
label var statefip "State FIPS code";
label var wrkyr "Year";
label var death "Last year in the sample before deregulation (from Kroszner and Strahan 1999)";
label var reg1 "Regional indicator 1 (from Kroszner and Strahan 1999)";
label var reg2 "Regional indicator 2 (from Kroszner and Strahan 1999)";
label var reg3 "Regional indicator 3 (from Kroszner and Strahan 1999)";

drop _cpi* failass fedfund gov house ins_year interstate_reform sen;

aorder;
label data "Data for 'Big Bad Banks?' paper.";
describe;
sort statefip wrkyr;
save macro_workfile, replace;


