************************************************************************************************
*** DATE:         December 2009
*** AUTHORS:      Beck, Levine, and Levkov
*** THIS PROGRAM: 1) Reads May and ORG CPS supplements for the years 1977-2006, w/o 1982
***               2) Creates an individual-level 'working' file with hourly wage information 
***                  for Figure 4 in the 'Big Bad Banks...' paper
************************************************************************************************

#delimit;
clear;
set mem 4g;
set more off;
cd "/home/alevkov/BeckLevineLevkov2010/data";


************************************;
*** READ MAY CPS DATA, 1977-1981 ***;
************************************;
use cpsmay77.dta, clear;
generate year=1977;
save temp77, replace;

use cpsmay78.dta, clear;
generate year=1978;
save temp78, replace;

use cpsmay79.dta, clear;
generate year=1979;
save temp79, replace;

use cpsmay80.dta, clear;
generate year=1980;
save temp80, replace;

use cpsmay81.dta, clear;
generate year=1981;
save temp81, replace;

use cpsmay82.dta, clear;
generate year=1982;
save temp82, replace;

use temp77, clear;
append using temp78;
append using temp79;
append using temp80;
append using temp81;
append using temp82;

*** Prime-ages ***;
rename x67 age;
keep if age>=25 & age<=54;

*** Men ***;
rename x70 sex;
generate male=.;
replace  male=0 if sex==2;
replace  male=1 if sex==1;
drop if male==.;

*** White ***;
rename x69 race;
generate white=0;
replace  white=1 if race==1;
*keep if white==1;
drop race;

*** Non-agricultural wage and salary workers ***;
rename x108 wage_salary;
rename x116 agriculture;

*** Employed (either working or with job but not at work) ***;
rename x100 employed;

*** Coding industries ***;
rename x63 ind;
generate industry="";
replace  industry="Agriculture" 				if ind>=17 & ind<=28;
replace  industry="Mining" 					if ind>=47 & ind<=57;
replace  industry="Construction" 				if ind>=67 & ind<=77;
replace  industry="Manufacturing" 				if ind>=107 & ind<=397;
replace  industry="Wholesale and retail trade" 			if ind>=507 & ind<=698;
replace  industry="Transportation, utilities, and information" 	if ind>=407 & ind<=479;
replace  industry="Financial activities" 			if ind>=707 & ind<=718;
replace  industry="Professional and business services" 		if ind>=727 & ind<=759;
replace  industry="Professional and business services" 		if ind>=769 & ind<=798;
replace  industry="Educational and health services" 		if ind>=828 & ind<=897;
replace  industry="Leisure and hospitality"			if ind>=807 & ind<=809;
replace  industry="Public administration"			if ind>=907 & ind<=937;
drop if industry=="";

*** Correcting sampling weights ***;
rename x80 ernwgt;
generate weight = ernwgt;
replace  weight = weight/12;
replace  weight = weight/100;

*** Creating years of completed education ***;
rename x72 grdhi;
rename x73 grdcom;
rename grdhi _grdhi;
replace _grdhi=_grdhi-1;

generate educomp=.;
replace  educomp=_grdhi   if grdcom==1 & _grdhi~=0;
replace  educomp=_grdhi-1 if grdcom==2 & _grdhi~=0;
replace  educomp=0        if _grdhi==0;

gen educ08=0;
replace educ08=1 if educomp<=8;
gen educ911=0;
replace educ911=1 if educomp>8 & educomp<=11;
gen educ12=0;
replace educ12=1 if educomp>11 & educomp<=12;
gen educ1315=0;
replace educ1315=1 if educomp>12 & educomp<=15;
gen educ16plus=0;
replace educ16plus=1 if educomp>15;

*** Years of potential experience ***;
generate exp_unrounded=max(age-educomp-6,0);
gen exp=round(exp_unrounded,1);
gen exp2=exp^2;
gen exp3=exp^3;
gen exp4=exp^4;
drop exp_unrounded;

*** Add state names ***;
rename x7 state;
generate state_name="";
replace  state_name="Maine" 		if state==11;
replace  state_name="New Hampshire" 	if state==12;
replace  state_name="Vermont"		if state==13;
replace  state_name="Massachusetts"	if state==14;
replace  state_name="Rhode Island"	if state==15;
replace  state_name="Connecticut"	if state==16;
replace  state_name="New York"		if state==21;
replace  state_name="New Jersey"	if state==22;
replace  state_name="Pennsylvania"	if state==23;
replace  state_name="Ohio"		if state==31;
replace  state_name="Indiana"		if state==32;
replace  state_name="Illinois"		if state==33;
replace  state_name="Michigan"		if state==34;
replace  state_name="Wisconsin"		if state==35;
replace  state_name="Minnesota"		if state==41;
replace  state_name="Iowa" 		if state==42;
replace  state_name="Missouri"		if state==43;
replace  state_name="North Dakota"	if state==44;
replace  state_name="South Dakota"	if state==45;
replace  state_name="Nebraska"		if state==46;
replace  state_name="Kansas"		if state==47;
replace  state_name="Delaware"		if state==51;
replace  state_name="Maryland"		if state==52;
replace  state_name="District of Columbia" if state==53;
replace  state_name="Virginia" 		if state==54;
replace  state_name="West Virginia"	if state==55;
replace  state_name="North Carolina"	if state==56;
replace  state_name="South Carolina"	if state==57;
replace  state_name="Georgia"		if state==58;
replace  state_name="Florida"		if state==59;
replace  state_name="Kentucky"		if state==61;
replace  state_name="Tennessee"		if state==62;
replace  state_name="Alabama"		if state==63;
replace  state_name="Mississippi"	if state==64;
replace  state_name="Arkansas"		if state==71;
replace  state_name="Louisiana"		if state==72;
replace  state_name="Oklahoma" 		if state==73;
replace  state_name="Texas"		if state==74;
replace  state_name="Montana"		if state==81;
replace  state_name="Idaho"		if state==82;
replace  state_name="Wyoming"		if state==83;
replace  state_name="Colorado"		if state==84;
replace  state_name="New Mexico"	if state==85;
replace  state_name="Arizona"		if state==86;
replace  state_name="Utah"		if state==87;
replace  state_name="Nevada"		if state==88;
replace  state_name="Washington"	if state==91;
replace  state_name="Oregon"		if state==92;
replace  state_name="California"	if state==93;
replace  state_name="Alaska"		if state==94;
replace  state_name="Hawaii"		if state==95;
drop state;
drop if state_name=="Delaware";
drop if state_name=="South Dakota";
generate cps=1;
sort state_name;
save temp, replace;

use state_names_and_codes.dta, clear;
sort state_name;
merge state_name using temp;
drop _merge*;
keep if cps==1;
rename x8 region;

*** earnings ***;
generate _hourly_earnings = x188;

*** hours worked last week ***;
generate _hours = x28;
replace  _hours = . if x28 <= 0;
sum _hours;

replace  _hourly_earnings = . if agriculture~=0;
replace  _hourly_earnings = . if wage_salary~=1;
gen ok=0;
replace ok=1 if employed==1 | employed==2;
replace  _hourly_earnings = . if ok==0;
drop ok;
replace _hourly_earnings = . if _hours==.;
replace _hourly_earnings = . if _hours==0;

keep statefip year age educ08 educ911 educ12 educ1315 educ16plus exp exp2 exp3 exp4
     industry weight _hourly_earnings _hours male white;
tab year, missing;
save temp_may.dta, replace;


************************************;
*** READ ORG CPS DATA, 1983-2006 ***;
************************************;
use cpsorg83_06.dta, clear;
keep if _year>=1983;

describe;

tab _year, missing;

*** Prime-ages ***;
keep if age>=25 & age<=54;

*** Men ***;
generate male=.;
replace  male=0 if sex==2;
replace  male=1 if sex==1;
drop if male==.;
drop sex;

*** White ***;
generate white=0;
replace  white=1 if race==1;
*keep if white==1;
drop race;

*** Coding industries ***;
generate industry="";
replace  industry="Agriculture" 	if indmaj==1 & _year>=2003;
replace  industry="Agriculture" 	if (indmaj==1 | indmaj==21) & _year>=1984 & _year<=2002;
replace  industry="Agriculture" 	if ind>=10 & ind<=31 & _year==1983;

replace  industry="Mining" 	if indmaj==2 & _year>=2003;
replace  industry="Mining" 	if indmaj==2 & _year>=1984 & _year<=2002;
replace  industry="Mining" 	if ind>=40 & ind<=50 & _year==1983;

replace  industry="Construction" 	if indmaj==3 & _year>=2003;
replace  industry="Construction" 	if indmaj==3 & _year>=1984 & _year<=2002;
replace  industry="Construction" 	if ind==60 & _year==1983;

replace  industry="Manufacturing" 	if indmaj==4 & _year>=2003;
replace  industry="Manufacturing" 	if (indmaj==4 | indmaj==5) & _year>=1984 & _year<=2002;
replace  industry="Manufacturing" 	if ind>=100 & ind<=392 & _year==1983;

replace  industry="Wholesale and retail trade" if indmaj==5 & _year>=2003;
replace  industry="Wholesale and retail trade" if (indmaj==9 | indmaj==10) & _year>=1984 & _year<=2002;
replace  industry="Wholesale and retail trade" if ind>=500 & ind<=571 & _year==1983;
replace  industry="Wholesale and retail trade" if ind>=580 & ind<=691 & _year==1983;

replace  industry="Transportation, utilities, and information" if (indmaj==6 | indmaj==7) & _year>=2003;
replace  industry="Transportation, utilities, and information" if (indmaj==6 | indmaj==7 | indmaj==8) & _year>=1984 & _year<=2002;
replace  industry="Transportation, utilities, and information" if ind>=400 & ind<=472 & _year==1983;

replace  industry="Financial activities" if indmaj==8 & _year>=2003;
replace  industry="Financial activities" if indmaj==11 & _year>=1984 & _year<=2002;
replace  industry="Financial activities" if ind>=700 & ind<=712 & _year==1983;

replace  industry="Professional and business services" if indmaj==9 & _year>=2003;
replace  industry="Professional and business services" if (indmaj==13 | indmaj==14 | indmaj==20) & _year>=1984 & _year<=2002;
replace  industry="Professional and business services" if ind>=721 & ind<=760 & _year==1983;
replace  industry="Professional and business services" if ind>=761 & ind<=791 & _year==1983;

replace  industry="Educational and health services" if indmaj==10 & _year>=2003;
replace  industry="Educational and health services" if (indmaj==16 | indmaj==17 | indmaj==18) & _year>=1984 & _year<=2002;
replace  industry="Educational and health services" if ind>=812 & ind<=892 & _year==1983;

replace  industry="Leisure and hospitality"	if indmaj==11 & _year>=2003;
replace  industry="Leisure and hospitality" 	if indmaj==15 & _year>=1984 & _year<=2002;
replace  industry="Leisure and hospitality"	if ind>=800 & ind<=802 & _year==1983;

replace  industry="Public administration"	if indmaj==13 & _year>=2003;
replace  industry="Public administration" 	if indmaj==22 & _year>=1984 & _year<=2002;
replace  industry="Public administration"	if ind>=900 & ind<=932 & _year==1983;

replace  industry="Armed forces"	if indmaj==14 & _year>=2003;
replace  industry="Armed forces" 	if indmaj==23 & _year>=1984 & _year<=2002;

replace  industry="Other services"	if indmaj==12;
replace  industry="Other services" 	if (indmaj==12 | indmaj==19) & _year>=1984 & _year<=2002;
drop if industry=="";


*** Correcting sampling weights ***;
generate weight = ernwgt;
replace  weight = weight/12;
replace  weight = weight/100   if _year<=1993;
replace  weight = weight/10000 if _year>=1994;
drop ernwgt;

*** Creating years of completed education ***;
rename grdhi _grdhi;
replace _grdhi=_grdhi-1 if _year>=1983 & _year<=1988;

generate educomp=.;
replace educomp=_grdhi   if _year>=1983 & _year<=1991 & grdcom==1 & _grdhi~=0;
replace educomp=_grdhi-1 if _year>=1983 & _year<=1991 & grdcom==2 & _grdhi~=0;
replace educomp=0        if _year>=1983 & _year<=1991 & _grdhi==0;

replace educomp = .32   if _year>=1992 & (grdatn ==31 | grdatn==00);
replace educomp = 3.19  if _year>=1992 & (grdatn ==32);
replace educomp = 7.24  if _year>=1992 & (grdatn ==33 | grdatn==34);
replace educomp = 8.97  if _year>=1992 & (grdatn == 35);
replace educomp = 9.92  if _year>=1992 & (grdatn == 36);
replace educomp = 10.86 if _year>=1992 & (grdatn ==37);
replace educomp = 11.58 if _year>=1992 & (grdatn ==38);
replace educomp = 11.99 if _year>=1992 & (grdatn ==39);
replace educomp = 13.48 if _year>=1992 & (grdatn ==40);
replace educomp = 14.23 if _year>=1992 & (grdatn ==41 | grdatn==42);
replace educomp = 16.17 if _year>=1992 & (grdatn ==43);
replace educomp = 17.68 if _year>=1992 & (grdatn ==44);
replace educomp = 17.71 if _year>=1992 & (grdatn ==45);
replace educomp = 17.83 if _year>=1992 & (grdatn ==46);

gen educ08=0;
replace educ08=1 if educomp<=8;
gen educ911=0;
replace educ911=1 if educomp>8 & educomp<=11;
gen educ12=0;
replace educ12=1 if educomp>11 & educomp<=12;
gen educ1315=0;
replace educ1315=1 if educomp>12 & educomp<=15;
gen educ16plus=0;
replace educ16plus=1 if educomp>15;


*** Years of potential experience ***;
generate exp_unrounded=max(age-educomp-6,0);
gen exp=round(exp_unrounded,1);
gen exp2=exp^2;
gen exp3=exp^3;
gen exp4=exp^4;
drop exp_unrounded;

tab _year, missing;

*** Add state names ***;
generate state_name="";
replace  state_name="Maine" 		if state==11;
replace  state_name="New Hampshire" 	if state==12;
replace  state_name="Vermont"		if state==13;
replace  state_name="Massachusetts"	if state==14;
replace  state_name="Rhode Island"	if state==15;
replace  state_name="Connecticut"	if state==16;
replace  state_name="New York"		if state==21;
replace  state_name="New Jersey"	if state==22;
replace  state_name="Pennsylvania"	if state==23;
replace  state_name="Ohio"		if state==31;
replace  state_name="Indiana"		if state==32;
replace  state_name="Illinois"		if state==33;
replace  state_name="Michigan"		if state==34;
replace  state_name="Wisconsin"		if state==35;
replace  state_name="Minnesota"		if state==41;
replace  state_name="Iowa" 		if state==42;
replace  state_name="Missouri"		if state==43;
replace  state_name="North Dakota"	if state==44;
replace  state_name="South Dakota"	if state==45;
replace  state_name="Nebraska"		if state==46;
replace  state_name="Kansas"		if state==47;
replace  state_name="Delaware"		if state==51;
replace  state_name="Maryland"		if state==52;
replace  state_name="District of Columbia" if state==53;
replace  state_name="Virginia" 		if state==54;
replace  state_name="West Virginia"	if state==55;
replace  state_name="North Carolina"	if state==56;
replace  state_name="South Carolina"	if state==57;
replace  state_name="Georgia"		if state==58;
replace  state_name="Florida"		if state==59;
replace  state_name="Kentucky"		if state==61;
replace  state_name="Tennessee"		if state==62;
replace  state_name="Alabama"		if state==63;
replace  state_name="Mississippi"	if state==64;
replace  state_name="Arkansas"		if state==71;
replace  state_name="Louisiana"		if state==72;
replace  state_name="Oklahoma" 		if state==73;
replace  state_name="Texas"		if state==74;
replace  state_name="Montana"		if state==81;
replace  state_name="Idaho"		if state==82;
replace  state_name="Wyoming"		if state==83;
replace  state_name="Colorado"		if state==84;
replace  state_name="New Mexico"	if state==85;
replace  state_name="Arizona"		if state==86;
replace  state_name="Utah"		if state==87;
replace  state_name="Nevada"		if state==88;
replace  state_name="Washington"	if state==91;
replace  state_name="Oregon"		if state==92;
replace  state_name="California"	if state==93;
replace  state_name="Alaska"		if state==94;
replace  state_name="Hawaii"		if state==95;
drop state;
drop if state_name=="Delaware";
drop if state_name=="South Dakota";

generate cps=1;
sort state_name;
save temp, replace;

use state_names_and_codes.dta, clear;
sort state_name;
merge state_name using temp;
drop _merge*;
keep if cps==1;
rename _year year;

*** earnings ***;
generate _hourly_earnings = ernhr;

*** working hours last week ***;
sum hours, detail;
generate _hours = hours;
replace  _hours = . if hours <= 0;
sum _hours;

*** Non-agricultural wage and salary workers ***;
replace  _hourly_earnings = . if bnagws~=1;

*** Employed (either working or with job but not at work) ***;
gen ok=0;
replace ok=1 if mlr==1 | mlr==2;
replace  _hourly_earnings = . if ok==0;
drop ok;
replace _hourly_earnings = . if _hours==.;
replace _hourly_earnings = . if _hours==0;

keep statefip year age educ08 educ911 educ12 educ1315 educ16plus exp exp2 exp3 exp4
     industry weight _hourly_earnings _hours male white;
save temp_org.dta, replace;


***********************************;
*** APPEND MAY AND ORG CPS DATA ***;
***********************************;
use temp_may.dta, clear;
append using temp_org.dta;
generate cps=1;
erase temp_may.dta;
erase temp_org.dta;

tab year, missing;

replace _hourly_earnings = . if _hourly_earnings == -99;
replace _hourly_earnings = . if _hourly_earnings == -1;
replace _hourly_earnings = . if _hourly_earnings <= 0;
replace _hourly_earnings = _hourly_earnings/100;

generate _cpi=.;
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

generate _hourly_earnings_cpi = _hourly_earnings * (96.5 / _cpi);
drop _cpi;

*** See Katz and Autor (1999, p.1471);
*** The minimum wage in 1982 is $3.75;
replace _hourly_earnings_cpi = . if _hourly_earnings_cpi<1.675;

sort year;
save temp, replace;

use temp, clear;
collapse 
(p99) pct99 = _hourly_earnings_cpi
[pw=weight], by(year);
sort year;
merge year using temp;
drop _merge*;

replace _hourly_earnings_cpi = . if _hourly_earnings_cpi >= pct99;
drop pct99;

summarize _hourly_earnings_cpi, detail;

sort statefip;
save temp, replace;


******************************;
*** READ DEREGULATION DATA ***;
******************************;
use reforms.dta, clear;
sort statefip;
merge statefip using temp;
drop _merge*;
keep if cps==1;
drop if statefip==10;
drop if statefip==46;

generate _intra = 0 ;
replace  _intra = 1 if year > branch_reform     ;
generate _tintra = year - branch_reform      ;

keep if year>=1977;
tab year, missing;

keep statefip state state_name year branch_reform _intra _tintra male white educ08 educ911 educ12 educ1315 educ16plus exp exp2 exp3 exp4 _hourly_earnings_cpi _hours weight;

order statefip state state_name year branch_reform _intra _tintra male white educ08 educ911 educ12 educ1315 educ16plus exp exp2 exp3 exp4 _hourly_earnings_cpi _hours weight;

save wage_workfile.dta, replace;
erase temp.dta;
erase temp77.dta;
erase temp78.dta;
erase temp79.dta;
erase temp80.dta;
erase temp81.dta;
erase temp82.dta;

