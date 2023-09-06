**********************************************************************************************************************************
*** Date:    December 2009
*** Authors: Beck, Levine, and Levkov
*** Purpose: Create Appendix Table VII in "Big Bad Banks? The Winners and Losers from Bank Deregulation in the United States"
*** Note:    Please change the working directories below 
**********************************************************************************************************************************

clear
set mem 2g
set more off
cd "/home/alevkov/BeckLevineLevkov2010"

log using Appendix_TableVII.log, replace


*****************************************************************
*** AGES 18-64 **************************************************
*****************************************************************
clear
infix ///
 int     year                                 1-4 ///
 long    serial                               5-9 ///
 float  hhwt                                10-16 ///
 float  hhwt04                              17-24 ///
 byte    gq                                  25 ///
 byte    statefip                            26-27 ///
 long    hhincome                            28-34 ///
 float  perwt                               35-42 ///
 float  perwt04                             43-50 ///
 int     relate                              51-54 ///
 byte    age                                 55-56 ///
 byte    sex                                 57 ///
 int     race                                58-60 ///
 int     hispan                              61-63 ///
 byte    educ99                              64-65 ///
 int     higrade                             66-68 ///
 byte    educrec                             69-70 ///
 byte    empstat                             71-72 ///
 byte    classwly                            73-74 ///
 byte    wkswork1                            75-76 ///
 byte    uhrswork                            77-78 ///
 long    inctot                              79-84 ///
 long    incwage                             85-90 ///
 long    incbus                              91-96 ///
 using "/home/alevkov/BeckLevineLevkov2010/data/raw_cps.dat"

replace hhwt=hhwt/100
replace hhwt04=hhwt04/100
replace perwt=perwt/100
replace perwt04=perwt04/100

label var year `"Survey year"'
label var serial `"Household serial number"'
label var hhwt `"Household weight"'
label var hhwt04 `"Household weight 2004"'
label var gq `"Group Quarters status"'
label var statefip `"State (FIPS code)"'
label var hhincome `"Total household income"'
label var perwt `"Person weight"'
label var perwt04 `"Person weight 2004"'
label var relate `"Relationship to household head"'
label var age `"Age"'
label var sex `"Sex"'
label var race `"Race"'
label var hispan `"Hispanic origin"'
label var educ99 `"Educational attainment, 1990"'
label var higrade `"Highest grade of school"'
label var educrec `"Educational attainment recode"'
label var empstat `"Employment status"'
label var classwly `"Class of worker last year"'
label var wkswork1 `"Weeks worked last year"'
label var uhrswork `"Usual hours worked per week (last yr)"'
label var inctot `"Total personal income"'
label var incwage `"Wage and salary income"'
label var incbus `"Non-farm business income"'


#delimit;
tabulate year, missing;

generate wrkyr = year - 1;


*** Sampling weights ***;
generate _perwt = perwt;
replace  _perwt = perwt04 if year == 2004;
label variable _perwt "Personal sampling weight";

generate _hhwt = hhwt;
replace  _hhwt = hhwt04 if year == 2004;
label variable _hhwt "Household sampling weight";


*** Age last year ***;
gen _agelyr = age-1 ;
label variable _agelyr "Age last year" ;


*** Gender and athnicity ***;
gen     _female = 0 ;
replace _female = 1 if sex == 2 ;
replace _female = . if sex == . ;

gen     _hispanic = 0 ;
replace _hispanic = 1 if hispan >=100 & hispan <=410 ;
replace _hispanic = . if hispan == 901 | hispan == 902 ;

gen _white = 0 ;
gen _black = 0 ;

replace _white = 1 if race == 100 ;
replace _black = 1 if race == 200 ;

replace _white = 0 if _hispanic == 1 ;
replace _black = 0 if _hispanic == 1 ;

label variable _white "1 if person is white and not a Hispanic" ;
label variable _black "1 if person is black and not a Hispanic" ;


*** Female-headed household indicator ***;
generate temp = 0;
replace  temp = 1 if _female == 1 & relate == 101;

bysort statefip wrkyr serial: egen _female_headed = max(temp);
drop temp;
label variable _female_headed "1 if female_headed household";


*** Years of completed education before 1992 ***;
gen _educomp =. ;

replace _educomp = 0 if higrade==10 ;
replace _educomp = 0 if higrade==31 ;

replace _educomp = 1 if higrade==40 ;
replace _educomp = 1 if higrade==41 ;
replace _educomp = 2 if higrade==50 ;
replace _educomp = 2 if higrade==51 ;
replace _educomp = 3 if higrade==60 ;
replace _educomp = 3 if higrade==61 ;
replace _educomp = 4 if higrade==70 ;
replace _educomp = 4 if higrade==71 ;
replace _educomp = 5 if higrade==80 ;
replace _educomp = 5 if higrade==81 ;
replace _educomp = 6 if higrade==90 ;
replace _educomp = 6 if higrade==91 ;

replace _educomp = 7 if higrade==100 ;
replace _educomp = 7 if higrade==101 ;
replace _educomp = 8 if higrade==110 ;
replace _educomp = 8 if higrade==111 ;
replace _educomp = 9 if higrade==120 ;
replace _educomp = 9 if higrade==121 ;

replace _educomp =10 if higrade==130 ;
replace _educomp =10 if higrade==131 ;
replace _educomp =11 if higrade==140 ;
replace _educomp =11 if higrade==141 ;
replace _educomp =12 if higrade==150 ;
replace _educomp =12 if higrade==151 ;
replace _educomp =13 if higrade==160 ;
replace _educomp =13 if higrade==161 ;
replace _educomp =14 if higrade==170 ;
replace _educomp =14 if higrade==171 ;
replace _educomp =15 if higrade==180 ;
replace _educomp =15 if higrade==181 ;
replace _educomp =16 if higrade==190 ;
replace _educomp =16 if higrade==191 ;
replace _educomp =17 if higrade==200 ;
replace _educomp =17 if higrade==201 ;

replace _educomp =18 if higrade==210 ;

replace _educomp =. if higrade==  . ;
replace _educomp =. if higrade==  0 ;
replace _educomp =. if higrade==999 ;


*** Years of completed education after 1992 ***;
gen _race = . ;

replace _race = 1 if race == 100 ;
replace _race = 2 if race == 200 ;
replace _race = 3 if race  > 200 & _race ~=. ;

*** Men, white ***;
replace _educomp = 0.32  	if (_race==1 & _female==0 & (educ99 ==1 | educ99==0)) ;
replace _educomp = 3.19 	if (_race==1 & _female==0 & (educ99 ==4)) ;
replace _educomp = 7.24 	if (_race==1 & _female==0 & (educ99 ==5)) ;
replace _educomp = 8.97 	if (_race==1 & _female==0 & educ99 == 6) ;
replace _educomp = 9.92 	if (_race==1 & _female==0 & educ99 == 7) ;
replace _educomp = 10.86 	if (_race==1 & _female==0 & educ99 ==8) ;
replace _educomp = 11.58 	if (_race==1 & _female==0 & educ99 ==9) ;
replace _educomp = 11.99 	if (_race==1 & _female==0 & educ99 ==10) ;
replace _educomp = 13.48 	if (_race==1 & _female==0 & educ99 ==11) ;
replace _educomp = 14.23 	if (_race==1 & _female==0 & (educ99 ==12 | educ99==13)) ;
replace _educomp = 16.17 	if (_race==1 & _female==0 & educ99 ==14) ;
replace _educomp = 17.68 	if (_race==1 & _female==0 & educ99 ==15) ;
replace _educomp = 17.71 	if (_race==1 & _female==0 & educ99 ==16) ;
replace _educomp = 17.83 	if (_race==1 & _female==0 & educ99 ==17) ;

*** Women, white ***;
replace _educomp = 0.62 	if (_race==1 & _female==1 & (educ99 ==1 | educ99==0)) ;
replace _educomp = 3.15 	if (_race==1 & _female==1 & (educ99 ==4)) ;
replace _educomp = 7.23 	if (_race==1 & _female==1 & (educ99 ==5)) ;
replace _educomp = 8.99 	if (_race==1 & _female==1 & educ99 == 6) ;
replace _educomp = 9.95 	if (_race==1 & _female==1 & educ99 == 7) ;
replace _educomp = 10.87 	if (_race==1 & _female==1 & educ99 ==8) ;
replace _educomp = 11.73 	if (_race==1 & _female==1 & educ99 ==9) ;
replace _educomp = 12.00 	if (_race==1 & _female==1 & educ99 ==10) ;
replace _educomp = 13.35 	if (_race==1 & _female==1 & educ99 ==11) ;
replace _educomp = 14.22 	if (_race==1 & _female==1 & (educ99 ==12 | educ99==13)) ;
replace _educomp = 16.15 	if (_race==1 & _female==1 & educ99 ==14) ;
replace _educomp = 17.64 	if (_race==1 & _female==1 & educ99 ==15) ;
replace _educomp = 17.00 	if (_race==1 & _female==1 & educ99 ==16) ;
replace _educomp = 17.76 	if (_race==1 & _female==1 & educ99 ==17) ;

*** Men, black ***;
replace _educomp = 0.92  	if (_race==2 & _female==0 & (educ99 ==1 | educ99==0)) ;
replace _educomp = 3.28 	if (_race==2 & _female==0 & (educ99 ==4)) ;
replace _educomp = 7.04 	if (_race==2 & _female==0 & (educ99 ==5)) ;
replace _educomp = 9.02 	if (_race==2 & _female==0 & educ99 == 6) ;
replace _educomp = 9.91 	if (_race==2 & _female==0 & educ99 == 7) ;
replace _educomp = 10.90 	if (_race==2 & _female==0 & educ99 ==8) ;
replace _educomp = 11.41 	if (_race==2 & _female==0 & educ99 ==9) ;
replace _educomp = 11.98 	if (_race==2 & _female==0 & educ99 ==10) ;
replace _educomp = 13.57 	if (_race==2 & _female==0 & educ99 ==11) ;
replace _educomp = 14.33 	if (_race==2 & _female==0 & (educ99 ==12 | educ99==13));
replace _educomp = 16.13 	if (_race==2 & _female==0 & educ99 ==14) ;
replace _educomp = 17.51 	if (_race==2 & _female==0 & educ99 ==15) ;
replace _educomp = 17.83 	if (_race==2 & _female==0 & educ99 ==16) ;
replace _educomp = 18.00 	if (_race==2 & _female==0 & educ99 ==17) ;

*** Women, black ***;
replace _educomp = 0.00 	if (_race==2 & _female==1 & (educ99 == 1 | educ99==0)) ;
replace _educomp = 2.90 	if (_race==2 & _female==1 & (educ99 ==4)) ;
replace _educomp = 7.03 	if (_race==2 & _female==1 & (educ99 ==5)) ;
replace _educomp = 9.05 	if (_race==2 & _female==1 & educ99 == 6) ;
replace _educomp = 9.99 	if (_race==2 & _female==1 & educ99 == 7) ;
replace _educomp = 10.85 	if (_race==2 & _female==1 & educ99 ==8) ;
replace _educomp = 11.64 	if (_race==2 & _female==1 & educ99 ==9) ;
replace _educomp = 12.00 	if (_race==2 & _female==1 & educ99 ==10) ;
replace _educomp = 13.43 	if (_race==2 & _female==1 & educ99 ==11) ;
replace _educomp = 14.33 	if (_race==2 & _female==1 & (educ99 ==12 | educ99==13));
replace _educomp = 16.04 	if (_race==2 & _female==1 & educ99 ==14) ;
replace _educomp = 17.69 	if (_race==2 & _female==1 & educ99 ==15) ;
replace _educomp = 17.40 	if (_race==2 & _female==1 & educ99 ==16) ;
replace _educomp = 18.00 	if (_race==2 & _female==1 & educ99 ==17) ;

*** Men, other ethnicity ***;
replace _educomp = 0.62  	if (_race==3 & _female==0 & (educ99 ==1 | educ99==0)) ;
replace _educomp = 3.24 	if (_race==3 & _female==0 & (educ99 ==4)) ;
replace _educomp = 7.14 	if (_race==3 & _female==0 & (educ99 ==5)) ;
replace _educomp = 9.00 	if (_race==3 & _female==0 & educ99 == 6) ;
replace _educomp = 9.92 	if (_race==3 & _female==0 & educ99 == 7) ;
replace _educomp = 10.88 	if (_race==3 & _female==0 & educ99 ==8) ;
replace _educomp = 11.50 	if (_race==3 & _female==0 & educ99 ==9) ;
replace _educomp = 11.99 	if (_race==3 & _female==0 & educ99 ==10) ;
replace _educomp = 13.53 	if (_race==3 & _female==0 & educ99 ==11) ;
replace _educomp = 14.28 	if (_race==3 & _female==0 & (educ99 ==12 | educ99==13));
replace _educomp = 16.15 	if (_race==3 & _female==0 & educ99 ==14) ;
replace _educomp = 17.60 	if (_race==3 & _female==0 & educ99 ==15) ;
replace _educomp = 17.77 	if (_race==3 & _female==0 & educ99 ==16) ;
replace _educomp = 17.92 	if (_race==3 & _female==0 & educ99 ==17) ;

*** Women, other ethnicity ***;
replace _educomp = 0.31 	if (_race==3 & _female==1 & (educ99 ==1 |educ99==0)) ;
replace _educomp = 3.03 	if (_race==3 & _female==1 & (educ99 ==4)) ;
replace _educomp = 7.13 	if (_race==3 & _female==1 & (educ99 ==5)) ;
replace _educomp = 9.02 	if (_race==3 & _female==1 & educ99 == 6) ;
replace _educomp = 9.97 	if (_race==3 & _female==1 & educ99 == 7) ;
replace _educomp = 10.86 	if (_race==3 & _female==1 & educ99 ==8) ;
replace _educomp = 11.69 	if (_race==3 & _female==1 & educ99 ==9) ;
replace _educomp = 12.00 	if (_race==3 & _female==1 & educ99 ==10) ;
replace _educomp = 13.47 	if (_race==3 & _female==1 & educ99 ==11) ;
replace _educomp = 14.28 	if (_race==3 & _female==1 & (educ99 ==12 | educ99==13));
replace _educomp = 16.10 	if (_race==3 & _female==1 & educ99 ==14) ;
replace _educomp = 17.67 	if (_race==3 & _female==1 & educ99 ==15) ;
replace _educomp = 17.20 	if (_race==3 & _female==1 & educ99 ==16) ;
replace _educomp = 17.88 	if (_race==3 & _female==1 & educ99 ==17) ;


*** Years of completed education for all years (categorical version) ***;
gen _hsd08      = 0 ;
gen _hsd911     = 0 ;
gen _hsg 	= 0 ;
gen  _sc 	= 0 ;
gen  _cg 	= 0 ;
gen  _ad 	= 0 ;

replace _hsd08  = 1 if educrec >=1 & educrec <=3 & educrec ~=0 & educrec ~=99 ;
replace _hsd911 = 1 if educrec >=4 & educrec <=6 & educrec ~=0 & educrec ~=99 ;
replace _hsg    = 1 if educrec ==7               & educrec ~=0 & educrec ~=99 ;
replace _sc     = 1 if educrec ==8               & educrec ~=0 & educrec ~=99 ;

replace _cg     = 1 if educrec ==9 & _educomp  <18 & year <=1991 & educrec ~=0 & educrec ~=99 & _educomp ~=.;
replace _cg     = 1 if educrec ==9 & educ99 ==14   & year >=1992 & educrec ~=0 & educrec ~=99 & educ99 ~=. & educ99 ~=0 ;

replace _ad     = 1 if educrec ==9 & _educomp >=18             & year <=1991 & educrec ~=0 & educrec ~=99 & _educomp ~=. ;
replace _ad     = 1 if educrec ==9 & educ99 >=15 & educ99 <=17 & year >=1992 & educrec ~=0 & educrec ~=99 & educ99 ~=. & educ99 ~=0 ;

replace _hsd08  = . if (educrec ==. | educrec == 0 | educrec == 99) ;
replace _hsd911 = . if (educrec ==. | educrec == 0 | educrec == 99) ;
replace _hsg    = . if (educrec ==. | educrec == 0 | educrec == 99) ;
replace _sc     = . if (educrec ==. | educrec == 0 | educrec == 99) ;
replace _cg     = . if (educrec ==. | educrec == 0 | educrec == 99) ;
replace _ad     = . if (educrec ==. | educrec == 0 | educrec == 99) ;

replace _cg  = . if _educomp == .                & year <=1991 ;
replace _cg  = . if (educ99  == . | educ99 == 0) & year >=1992 ;

replace _ad  = . if _educomp == .                & year <=1991 ;
replace _ad  = . if (educ99  == . | educ99 == 0) & year >=1992 ;

gen     _education = . ;
replace _education = 1 if _hsd08  == 1 ;
replace _education = 2 if _hsd911 == 1 ;
replace _education = 3 if _hsg    == 1 ;
replace _education = 4 if _sc     == 1 ;
replace _education = 5 if _cg     == 1 ;
replace _education = 6 if _ad     == 1 ;

replace _education = . if educrec == . ;
replace _education = 0 if educrec == 0 ;
replace _education = . if educrec ==99 ;

replace _education = 0 if educrec == 0 & year <=1991 ;
replace _education = 0 if educ99  == 0 & year >=1992 ;

label define _education 0 "NIU" 1 "HSD08" 2 "HSD911" 3 "HSG" 4 "SC" 5 "CG" 6 "AD" ;
label values _education _education ;

label variable _education "6 _education categories, hsd08 hsd911 hsg sc cg ad (IPUMS)" ; 


*** Income ***;
*** a. adjusting for missing values;
generate _inctot = inctot ;
replace  _inctot = . if inctot == 999998 | inctot == 999999;
label variable _inctot "Total personal income";

generate _incwage = incwage ;
replace  _incwage = . if incwage == 999998 | incwage == 999999;
replace  _incwage = . if gq~=1;
label variable _incwage "Wage and salary income";

generate _incbus = incbus ;
replace  _incbus = . if incbus == 999998 | incbus == 999999;
replace  _incbus = . if gq~=1;
label variable _incbus "Business income";

generate _hhincome = hhincome ;
replace  _hhincome = . if hhincome == 999999;
replace  _hhincome = . if hhincome <= 0; 
label variable _hhincome "Total household income";

*** b. adjusting for inflation;
generate _cpi = . ;
replace  _cpi =	56.9	if wrkyr == 	1976	;
replace  _cpi =	60.6	if wrkyr == 	1977	;
replace  _cpi =	65.2	if wrkyr == 	1978	;
replace  _cpi =	72.6	if wrkyr == 	1979	;
replace  _cpi =	82.4	if wrkyr == 	1980	;
replace  _cpi =	90.9	if wrkyr == 	1981	;
replace  _cpi =	96.5	if wrkyr == 	1982	;
replace  _cpi =	99.6	if wrkyr == 	1983	;
replace  _cpi =	103.9	if wrkyr == 	1984	;
replace  _cpi =	107.6	if wrkyr == 	1985	;
replace  _cpi =	109.6	if wrkyr == 	1986	;
replace  _cpi =	113.6	if wrkyr == 	1987	;
replace  _cpi =	118.3	if wrkyr == 	1988	;
replace  _cpi =	124	if wrkyr == 	1989	;
replace  _cpi =	130.7	if wrkyr == 	1990	;
replace  _cpi =	136.2	if wrkyr == 	1991	;
replace  _cpi =	140.3	if wrkyr == 	1992	;
replace  _cpi =	144.5	if wrkyr == 	1993	;
replace  _cpi =	148.2	if wrkyr == 	1994	;
replace  _cpi =	152.4	if wrkyr == 	1995	;
replace  _cpi =	156.9	if wrkyr == 	1996	;
replace  _cpi =	160.5	if wrkyr == 	1997	;
replace  _cpi =	163	if wrkyr == 	1998	;
replace  _cpi =	166.6	if wrkyr == 	1999	;
replace  _cpi =	172.2	if wrkyr == 	2000	;
replace  _cpi =	177.1	if wrkyr == 	2001	;
replace  _cpi =	179.9	if wrkyr == 	2002	;
replace  _cpi =	184	if wrkyr == 	2003	;
replace  _cpi =	188.9	if wrkyr == 	2004	;
replace  _cpi =	195.3	if wrkyr == 	2005	;
replace  _cpi =	201.6	if wrkyr == 	2006	;
replace  _cpi =	207.342 if wrkyr == 	2007	;

generate _cpi_deflator2000 = 172.2 / _cpi ;

generate  _inctot_cpi = _inctot * _cpi_deflator2000 ;
label variable _inctot_cpi "Total personal income, in 2000 dollars";

generate  _incwage_cpi  =  _incwage  * _cpi_deflator2000 ;
label variable _incwage_cpi  "Wage and salary income, in 2000 dollars";

generate  _incbus_cpi   =  _incbus   * _cpi_deflator2000 ;
label variable _incbus_cpi   "Business income, in 2000 dollars";

generate  _hhincome_cpi =  _hhincome * _cpi_deflator2000 ;
label variable _hhincome_cpi "Total household income, in 2000 dollars";

sort wrkyr;
save temp, replace;

*** c. cutting outliers;
use temp, clear;
keep if _female==0;
keep if _white==1;
keep if _agelyr>=18 & _agelyr<=64;

collapse 
(p1)  pct01 = _inctot_cpi
(p99) pct99 = _inctot_cpi
[pw=_perwt], by(wrkyr);
sort wrkyr;
merge wrkyr using temp;
drop _merge*;

generate _inctot_cpi_tr01   = _inctot_cpi;
generate _inctot_cpi_tr99   = _inctot_cpi;
generate _inctot_cpi_tr0199 = _inctot_cpi;

replace  _inctot_cpi_tr01   = . if _inctot_cpi <= pct01;
replace  _inctot_cpi_tr99   = . if _inctot_cpi >= pct99;
replace  _inctot_cpi_tr0199 = . if _inctot_cpi <= pct01;
replace  _inctot_cpi_tr0199 = . if _inctot_cpi >= pct99;
replace  _inctot_cpi_tr0199 = . if _inctot_cpi_tr0199 < 0;

label variable _inctot_cpi_tr01   "Total personal income, in 2000 dollars, w/o 01 prc. outliers";
label variable _inctot_cpi_tr99   "Total personal income, in 2000 dollars, w/o 99 prc. outliers";
label variable _inctot_cpi_tr0199 "Total personal income, in 2000 dollars, w/o 01 and 99 prc. outliers";
drop pct01 pct99;


*** Main sample indicator ***;
generate main_sample = 1;
replace  main_sample = 0 if _agelyr < 18;
replace  main_sample = 0 if _agelyr > 64;
replace  main_sample = 0 if gq ~= 1;
replace  main_sample = 0 if _hhincome_cpi == .;
replace  main_sample = 0 if _hsd08==. | _hsd911==. | _hsg==. | _sc==. | _cg==. | _ad==.;
replace  main_sample = 0 if _white==. | _black==. | _hispanic==.;
replace  main_sample = 0 if statefip == 10;
replace  main_sample = 0 if statefip == 46;
replace  main_sample = 0 if _hhwt == . | _hhwt == 0;
replace  main_sample = 0 if _perwt == . | _perwt == 0;

tabulate main_sample, missing;

keep if main_sample==1;

replace _inctot_cpi        = 1 if _inctot_cpi        <= 0;
replace _inctot_cpi_tr01   = 1 if _inctot_cpi_tr01   <= 0;
replace _inctot_cpi_tr99   = 1 if _inctot_cpi_tr99   <= 0;
replace _inctot_cpi_tr0199 = 1 if _inctot_cpi_tr0199 <= 0;

egen gini_inctot_cpi        = inequal(_inctot_cpi),        by(statefip wrkyr) weights(_perwt) index(gini);
egen gini_inctot_cpi_tr01   = inequal(_inctot_cpi_tr01),   by(statefip wrkyr) weights(_perwt) index(gini);
egen gini_inctot_cpi_tr99   = inequal(_inctot_cpi_tr99),   by(statefip wrkyr) weights(_perwt) index(gini);
egen gini_inctot_cpi_tr0199 = inequal(_inctot_cpi_tr0199), by(statefip wrkyr) weights(_perwt) index(gini);

keep statefip wrkyr gini_*;
duplicates drop;
drop if gini_inctot_cpi        ==.;
drop if gini_inctot_cpi_tr01   ==.;
drop if gini_inctot_cpi_tr99   ==.;
drop if gini_inctot_cpi_tr0199 ==.;

generate log_gini_inctot_cpi        = log(gini_inctot_cpi);
generate log_gini_inctot_cpi_tr01   = log(gini_inctot_cpi_tr01);
generate log_gini_inctot_cpi_tr99   = log(gini_inctot_cpi_tr99);
generate log_gini_inctot_cpi_tr0199 = log(gini_inctot_cpi_tr0199);

generate logistic_gini_inctot_cpi        = log(gini_inctot_cpi/(1-gini_inctot_cpi));
generate logistic_gini_inctot_cpi_tr01   = log(gini_inctot_cpi_tr01/(1-gini_inctot_cpi_tr01));
generate logistic_gini_inctot_cpi_tr99   = log(gini_inctot_cpi_tr99/(1-gini_inctot_cpi_tr99));
generate logistic_gini_inctot_cpi_tr0199 = log(gini_inctot_cpi_tr0199/(1-gini_inctot_cpi_tr0199));

sort statefip wrkyr;
save temp, replace;


use "/home/alevkov/BeckLevineLevkov2010/data/macro_workfile.dta", clear;
keep statefip wrkyr _intra;
sort statefip wrkyr;
merge statefip wrkyr using temp;
drop _merge*;

label var _intra "Bank deregulation";

tsset statefip wrkyr;

tabulate wrkyr, gen(wrkyr_dumm);

xtreg logistic_gini_inctot_cpi        _intra wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
estimates store m1, title((1));

xtreg logistic_gini_inctot_cpi_tr01   _intra wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
estimates store m2, title((2));

xtreg logistic_gini_inctot_cpi_tr99   _intra wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
estimates store m3, title((3));

xtreg logistic_gini_inctot_cpi_tr0199 _intra wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
estimates store m4, title((4));


xtreg log_gini_inctot_cpi        _intra wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
estimates store m5, title((5));

xtreg log_gini_inctot_cpi_tr01   _intra wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
estimates store m6, title((6));

xtreg log_gini_inctot_cpi_tr99   _intra wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
estimates store m7, title((7));

xtreg log_gini_inctot_cpi_tr0199 _intra wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
estimates store m8, title((8));

estout m1 m2 m3 m4 m5 m6 m7 m8 using Appendix_TableVII.txt, replace
keep(_intra)
cells(b(star fmt(3)) se(par) p(fmt(3) par({ }))) stats(r2 N, labels("R-squared" "Observations") fmt(2 0)) 
legend label collabel(none)
prehead("Robustness of the Results to Inclusion of Observations with Outlying Income")
posthead("Panel A: Ages 18-64")
postfoot("")
starlevel(* 0.10 ** 0.05 *** 0.01);

erase temp.dta;
#delimit cr



*****************************************************************
*** AGES 25-54 **************************************************
*****************************************************************
clear
infix ///
 int     year                                 1-4 ///
 long    serial                               5-9 ///
 float  hhwt                                10-16 ///
 float  hhwt04                              17-24 ///
 byte    gq                                  25 ///
 byte    statefip                            26-27 ///
 long    hhincome                            28-34 ///
 float  perwt                               35-42 ///
 float  perwt04                             43-50 ///
 int     relate                              51-54 ///
 byte    age                                 55-56 ///
 byte    sex                                 57 ///
 int     race                                58-60 ///
 int     hispan                              61-63 ///
 byte    educ99                              64-65 ///
 int     higrade                             66-68 ///
 byte    educrec                             69-70 ///
 byte    empstat                             71-72 ///
 byte    classwly                            73-74 ///
 byte    wkswork1                            75-76 ///
 byte    uhrswork                            77-78 ///
 long    inctot                              79-84 ///
 long    incwage                             85-90 ///
 long    incbus                              91-96 ///
 using "/home/alevkov/BeckLevineLevkov2010/data/raw_cps.dat"

replace hhwt=hhwt/100
replace hhwt04=hhwt04/100
replace perwt=perwt/100
replace perwt04=perwt04/100

label var year `"Survey year"'
label var serial `"Household serial number"'
label var hhwt `"Household weight"'
label var hhwt04 `"Household weight 2004"'
label var gq `"Group Quarters status"'
label var statefip `"State (FIPS code)"'
label var hhincome `"Total household income"'
label var perwt `"Person weight"'
label var perwt04 `"Person weight 2004"'
label var relate `"Relationship to household head"'
label var age `"Age"'
label var sex `"Sex"'
label var race `"Race"'
label var hispan `"Hispanic origin"'
label var educ99 `"Educational attainment, 1990"'
label var higrade `"Highest grade of school"'
label var educrec `"Educational attainment recode"'
label var empstat `"Employment status"'
label var classwly `"Class of worker last year"'
label var wkswork1 `"Weeks worked last year"'
label var uhrswork `"Usual hours worked per week (last yr)"'
label var inctot `"Total personal income"'
label var incwage `"Wage and salary income"'
label var incbus `"Non-farm business income"'


#delimit;
tabulate year, missing;

generate wrkyr = year - 1;


*** Sampling weights ***;
generate _perwt = perwt;
replace  _perwt = perwt04 if year == 2004;
label variable _perwt "Personal sampling weight";

generate _hhwt = hhwt;
replace  _hhwt = hhwt04 if year == 2004;
label variable _hhwt "Household sampling weight";


*** Age last year ***;
gen _agelyr = age-1 ;
label variable _agelyr "Age last year" ;


*** Gender and athnicity ***;
gen     _female = 0 ;
replace _female = 1 if sex == 2 ;
replace _female = . if sex == . ;

gen     _hispanic = 0 ;
replace _hispanic = 1 if hispan >=100 & hispan <=410 ;
replace _hispanic = . if hispan == 901 | hispan == 902 ;

gen _white = 0 ;
gen _black = 0 ;

replace _white = 1 if race == 100 ;
replace _black = 1 if race == 200 ;

replace _white = 0 if _hispanic == 1 ;
replace _black = 0 if _hispanic == 1 ;

label variable _white "1 if person is white and not a Hispanic" ;
label variable _black "1 if person is black and not a Hispanic" ;


*** Female-headed household indicator ***;
generate temp = 0;
replace  temp = 1 if _female == 1 & relate == 101;

bysort statefip wrkyr serial: egen _female_headed = max(temp);
drop temp;
label variable _female_headed "1 if female_headed household";


*** Years of completed education before 1992 ***;
gen _educomp =. ;

replace _educomp = 0 if higrade==10 ;
replace _educomp = 0 if higrade==31 ;

replace _educomp = 1 if higrade==40 ;
replace _educomp = 1 if higrade==41 ;
replace _educomp = 2 if higrade==50 ;
replace _educomp = 2 if higrade==51 ;
replace _educomp = 3 if higrade==60 ;
replace _educomp = 3 if higrade==61 ;
replace _educomp = 4 if higrade==70 ;
replace _educomp = 4 if higrade==71 ;
replace _educomp = 5 if higrade==80 ;
replace _educomp = 5 if higrade==81 ;
replace _educomp = 6 if higrade==90 ;
replace _educomp = 6 if higrade==91 ;

replace _educomp = 7 if higrade==100 ;
replace _educomp = 7 if higrade==101 ;
replace _educomp = 8 if higrade==110 ;
replace _educomp = 8 if higrade==111 ;
replace _educomp = 9 if higrade==120 ;
replace _educomp = 9 if higrade==121 ;

replace _educomp =10 if higrade==130 ;
replace _educomp =10 if higrade==131 ;
replace _educomp =11 if higrade==140 ;
replace _educomp =11 if higrade==141 ;
replace _educomp =12 if higrade==150 ;
replace _educomp =12 if higrade==151 ;
replace _educomp =13 if higrade==160 ;
replace _educomp =13 if higrade==161 ;
replace _educomp =14 if higrade==170 ;
replace _educomp =14 if higrade==171 ;
replace _educomp =15 if higrade==180 ;
replace _educomp =15 if higrade==181 ;
replace _educomp =16 if higrade==190 ;
replace _educomp =16 if higrade==191 ;
replace _educomp =17 if higrade==200 ;
replace _educomp =17 if higrade==201 ;

replace _educomp =18 if higrade==210 ;

replace _educomp =. if higrade==  . ;
replace _educomp =. if higrade==  0 ;
replace _educomp =. if higrade==999 ;


*** Years of completed education after 1992 ***;
gen _race = . ;

replace _race = 1 if race == 100 ;
replace _race = 2 if race == 200 ;
replace _race = 3 if race  > 200 & _race ~=. ;

*** Men, white ***;
replace _educomp = 0.32  	if (_race==1 & _female==0 & (educ99 ==1 | educ99==0)) ;
replace _educomp = 3.19 	if (_race==1 & _female==0 & (educ99 ==4)) ;
replace _educomp = 7.24 	if (_race==1 & _female==0 & (educ99 ==5)) ;
replace _educomp = 8.97 	if (_race==1 & _female==0 & educ99 == 6) ;
replace _educomp = 9.92 	if (_race==1 & _female==0 & educ99 == 7) ;
replace _educomp = 10.86 	if (_race==1 & _female==0 & educ99 ==8) ;
replace _educomp = 11.58 	if (_race==1 & _female==0 & educ99 ==9) ;
replace _educomp = 11.99 	if (_race==1 & _female==0 & educ99 ==10) ;
replace _educomp = 13.48 	if (_race==1 & _female==0 & educ99 ==11) ;
replace _educomp = 14.23 	if (_race==1 & _female==0 & (educ99 ==12 | educ99==13)) ;
replace _educomp = 16.17 	if (_race==1 & _female==0 & educ99 ==14) ;
replace _educomp = 17.68 	if (_race==1 & _female==0 & educ99 ==15) ;
replace _educomp = 17.71 	if (_race==1 & _female==0 & educ99 ==16) ;
replace _educomp = 17.83 	if (_race==1 & _female==0 & educ99 ==17) ;

*** Women, white ***;
replace _educomp = 0.62 	if (_race==1 & _female==1 & (educ99 ==1 | educ99==0)) ;
replace _educomp = 3.15 	if (_race==1 & _female==1 & (educ99 ==4)) ;
replace _educomp = 7.23 	if (_race==1 & _female==1 & (educ99 ==5)) ;
replace _educomp = 8.99 	if (_race==1 & _female==1 & educ99 == 6) ;
replace _educomp = 9.95 	if (_race==1 & _female==1 & educ99 == 7) ;
replace _educomp = 10.87 	if (_race==1 & _female==1 & educ99 ==8) ;
replace _educomp = 11.73 	if (_race==1 & _female==1 & educ99 ==9) ;
replace _educomp = 12.00 	if (_race==1 & _female==1 & educ99 ==10) ;
replace _educomp = 13.35 	if (_race==1 & _female==1 & educ99 ==11) ;
replace _educomp = 14.22 	if (_race==1 & _female==1 & (educ99 ==12 | educ99==13)) ;
replace _educomp = 16.15 	if (_race==1 & _female==1 & educ99 ==14) ;
replace _educomp = 17.64 	if (_race==1 & _female==1 & educ99 ==15) ;
replace _educomp = 17.00 	if (_race==1 & _female==1 & educ99 ==16) ;
replace _educomp = 17.76 	if (_race==1 & _female==1 & educ99 ==17) ;

*** Men, black ***;
replace _educomp = 0.92  	if (_race==2 & _female==0 & (educ99 ==1 | educ99==0)) ;
replace _educomp = 3.28 	if (_race==2 & _female==0 & (educ99 ==4)) ;
replace _educomp = 7.04 	if (_race==2 & _female==0 & (educ99 ==5)) ;
replace _educomp = 9.02 	if (_race==2 & _female==0 & educ99 == 6) ;
replace _educomp = 9.91 	if (_race==2 & _female==0 & educ99 == 7) ;
replace _educomp = 10.90 	if (_race==2 & _female==0 & educ99 ==8) ;
replace _educomp = 11.41 	if (_race==2 & _female==0 & educ99 ==9) ;
replace _educomp = 11.98 	if (_race==2 & _female==0 & educ99 ==10) ;
replace _educomp = 13.57 	if (_race==2 & _female==0 & educ99 ==11) ;
replace _educomp = 14.33 	if (_race==2 & _female==0 & (educ99 ==12 | educ99==13));
replace _educomp = 16.13 	if (_race==2 & _female==0 & educ99 ==14) ;
replace _educomp = 17.51 	if (_race==2 & _female==0 & educ99 ==15) ;
replace _educomp = 17.83 	if (_race==2 & _female==0 & educ99 ==16) ;
replace _educomp = 18.00 	if (_race==2 & _female==0 & educ99 ==17) ;

*** Women, black ***;
replace _educomp = 0.00 	if (_race==2 & _female==1 & (educ99 == 1 | educ99==0)) ;
replace _educomp = 2.90 	if (_race==2 & _female==1 & (educ99 ==4)) ;
replace _educomp = 7.03 	if (_race==2 & _female==1 & (educ99 ==5)) ;
replace _educomp = 9.05 	if (_race==2 & _female==1 & educ99 == 6) ;
replace _educomp = 9.99 	if (_race==2 & _female==1 & educ99 == 7) ;
replace _educomp = 10.85 	if (_race==2 & _female==1 & educ99 ==8) ;
replace _educomp = 11.64 	if (_race==2 & _female==1 & educ99 ==9) ;
replace _educomp = 12.00 	if (_race==2 & _female==1 & educ99 ==10) ;
replace _educomp = 13.43 	if (_race==2 & _female==1 & educ99 ==11) ;
replace _educomp = 14.33 	if (_race==2 & _female==1 & (educ99 ==12 | educ99==13));
replace _educomp = 16.04 	if (_race==2 & _female==1 & educ99 ==14) ;
replace _educomp = 17.69 	if (_race==2 & _female==1 & educ99 ==15) ;
replace _educomp = 17.40 	if (_race==2 & _female==1 & educ99 ==16) ;
replace _educomp = 18.00 	if (_race==2 & _female==1 & educ99 ==17) ;

*** Men, other ethnicity ***;
replace _educomp = 0.62  	if (_race==3 & _female==0 & (educ99 ==1 | educ99==0)) ;
replace _educomp = 3.24 	if (_race==3 & _female==0 & (educ99 ==4)) ;
replace _educomp = 7.14 	if (_race==3 & _female==0 & (educ99 ==5)) ;
replace _educomp = 9.00 	if (_race==3 & _female==0 & educ99 == 6) ;
replace _educomp = 9.92 	if (_race==3 & _female==0 & educ99 == 7) ;
replace _educomp = 10.88 	if (_race==3 & _female==0 & educ99 ==8) ;
replace _educomp = 11.50 	if (_race==3 & _female==0 & educ99 ==9) ;
replace _educomp = 11.99 	if (_race==3 & _female==0 & educ99 ==10) ;
replace _educomp = 13.53 	if (_race==3 & _female==0 & educ99 ==11) ;
replace _educomp = 14.28 	if (_race==3 & _female==0 & (educ99 ==12 | educ99==13));
replace _educomp = 16.15 	if (_race==3 & _female==0 & educ99 ==14) ;
replace _educomp = 17.60 	if (_race==3 & _female==0 & educ99 ==15) ;
replace _educomp = 17.77 	if (_race==3 & _female==0 & educ99 ==16) ;
replace _educomp = 17.92 	if (_race==3 & _female==0 & educ99 ==17) ;

*** Women, other ethnicity ***;
replace _educomp = 0.31 	if (_race==3 & _female==1 & (educ99 ==1 |educ99==0)) ;
replace _educomp = 3.03 	if (_race==3 & _female==1 & (educ99 ==4)) ;
replace _educomp = 7.13 	if (_race==3 & _female==1 & (educ99 ==5)) ;
replace _educomp = 9.02 	if (_race==3 & _female==1 & educ99 == 6) ;
replace _educomp = 9.97 	if (_race==3 & _female==1 & educ99 == 7) ;
replace _educomp = 10.86 	if (_race==3 & _female==1 & educ99 ==8) ;
replace _educomp = 11.69 	if (_race==3 & _female==1 & educ99 ==9) ;
replace _educomp = 12.00 	if (_race==3 & _female==1 & educ99 ==10) ;
replace _educomp = 13.47 	if (_race==3 & _female==1 & educ99 ==11) ;
replace _educomp = 14.28 	if (_race==3 & _female==1 & (educ99 ==12 | educ99==13));
replace _educomp = 16.10 	if (_race==3 & _female==1 & educ99 ==14) ;
replace _educomp = 17.67 	if (_race==3 & _female==1 & educ99 ==15) ;
replace _educomp = 17.20 	if (_race==3 & _female==1 & educ99 ==16) ;
replace _educomp = 17.88 	if (_race==3 & _female==1 & educ99 ==17) ;


*** Years of completed education for all years (categorical version) ***;
gen _hsd08      = 0 ;
gen _hsd911     = 0 ;
gen _hsg 	= 0 ;
gen  _sc 	= 0 ;
gen  _cg 	= 0 ;
gen  _ad 	= 0 ;

replace _hsd08  = 1 if educrec >=1 & educrec <=3 & educrec ~=0 & educrec ~=99 ;
replace _hsd911 = 1 if educrec >=4 & educrec <=6 & educrec ~=0 & educrec ~=99 ;
replace _hsg    = 1 if educrec ==7               & educrec ~=0 & educrec ~=99 ;
replace _sc     = 1 if educrec ==8               & educrec ~=0 & educrec ~=99 ;

replace _cg     = 1 if educrec ==9 & _educomp  <18 & year <=1991 & educrec ~=0 & educrec ~=99 & _educomp ~=.;
replace _cg     = 1 if educrec ==9 & educ99 ==14   & year >=1992 & educrec ~=0 & educrec ~=99 & educ99 ~=. & educ99 ~=0 ;

replace _ad     = 1 if educrec ==9 & _educomp >=18             & year <=1991 & educrec ~=0 & educrec ~=99 & _educomp ~=. ;
replace _ad     = 1 if educrec ==9 & educ99 >=15 & educ99 <=17 & year >=1992 & educrec ~=0 & educrec ~=99 & educ99 ~=. & educ99 ~=0 ;

replace _hsd08  = . if (educrec ==. | educrec == 0 | educrec == 99) ;
replace _hsd911 = . if (educrec ==. | educrec == 0 | educrec == 99) ;
replace _hsg    = . if (educrec ==. | educrec == 0 | educrec == 99) ;
replace _sc     = . if (educrec ==. | educrec == 0 | educrec == 99) ;
replace _cg     = . if (educrec ==. | educrec == 0 | educrec == 99) ;
replace _ad     = . if (educrec ==. | educrec == 0 | educrec == 99) ;

replace _cg  = . if _educomp == .                & year <=1991 ;
replace _cg  = . if (educ99  == . | educ99 == 0) & year >=1992 ;

replace _ad  = . if _educomp == .                & year <=1991 ;
replace _ad  = . if (educ99  == . | educ99 == 0) & year >=1992 ;

gen     _education = . ;
replace _education = 1 if _hsd08  == 1 ;
replace _education = 2 if _hsd911 == 1 ;
replace _education = 3 if _hsg    == 1 ;
replace _education = 4 if _sc     == 1 ;
replace _education = 5 if _cg     == 1 ;
replace _education = 6 if _ad     == 1 ;

replace _education = . if educrec == . ;
replace _education = 0 if educrec == 0 ;
replace _education = . if educrec ==99 ;

replace _education = 0 if educrec == 0 & year <=1991 ;
replace _education = 0 if educ99  == 0 & year >=1992 ;

label define _education 0 "NIU" 1 "HSD08" 2 "HSD911" 3 "HSG" 4 "SC" 5 "CG" 6 "AD" ;
label values _education _education ;

label variable _education "6 _education categories, hsd08 hsd911 hsg sc cg ad (IPUMS)" ; 


*** Income ***;
*** a. adjusting for missing values;
generate _inctot = inctot ;
replace  _inctot = . if inctot == 999998 | inctot == 999999;
label variable _inctot "Total personal income";

generate _incwage = incwage ;
replace  _incwage = . if incwage == 999998 | incwage == 999999;
replace  _incwage = . if gq~=1;
label variable _incwage "Wage and salary income";

generate _incbus = incbus ;
replace  _incbus = . if incbus == 999998 | incbus == 999999;
replace  _incbus = . if gq~=1;
label variable _incbus "Business income";

generate _hhincome = hhincome ;
replace  _hhincome = . if hhincome == 999999;
replace  _hhincome = . if hhincome <= 0; 
label variable _hhincome "Total household income";

*** b. adjusting for inflation;
generate _cpi = . ;
replace  _cpi =	56.9	if wrkyr == 	1976	;
replace  _cpi =	60.6	if wrkyr == 	1977	;
replace  _cpi =	65.2	if wrkyr == 	1978	;
replace  _cpi =	72.6	if wrkyr == 	1979	;
replace  _cpi =	82.4	if wrkyr == 	1980	;
replace  _cpi =	90.9	if wrkyr == 	1981	;
replace  _cpi =	96.5	if wrkyr == 	1982	;
replace  _cpi =	99.6	if wrkyr == 	1983	;
replace  _cpi =	103.9	if wrkyr == 	1984	;
replace  _cpi =	107.6	if wrkyr == 	1985	;
replace  _cpi =	109.6	if wrkyr == 	1986	;
replace  _cpi =	113.6	if wrkyr == 	1987	;
replace  _cpi =	118.3	if wrkyr == 	1988	;
replace  _cpi =	124	if wrkyr == 	1989	;
replace  _cpi =	130.7	if wrkyr == 	1990	;
replace  _cpi =	136.2	if wrkyr == 	1991	;
replace  _cpi =	140.3	if wrkyr == 	1992	;
replace  _cpi =	144.5	if wrkyr == 	1993	;
replace  _cpi =	148.2	if wrkyr == 	1994	;
replace  _cpi =	152.4	if wrkyr == 	1995	;
replace  _cpi =	156.9	if wrkyr == 	1996	;
replace  _cpi =	160.5	if wrkyr == 	1997	;
replace  _cpi =	163	if wrkyr == 	1998	;
replace  _cpi =	166.6	if wrkyr == 	1999	;
replace  _cpi =	172.2	if wrkyr == 	2000	;
replace  _cpi =	177.1	if wrkyr == 	2001	;
replace  _cpi =	179.9	if wrkyr == 	2002	;
replace  _cpi =	184	if wrkyr == 	2003	;
replace  _cpi =	188.9	if wrkyr == 	2004	;
replace  _cpi =	195.3	if wrkyr == 	2005	;
replace  _cpi =	201.6	if wrkyr == 	2006	;
replace  _cpi =	207.342 if wrkyr == 	2007	;

generate _cpi_deflator2000 = 172.2 / _cpi ;

generate  _inctot_cpi = _inctot * _cpi_deflator2000 ;
label variable _inctot_cpi "Total personal income, in 2000 dollars";

generate  _incwage_cpi  =  _incwage  * _cpi_deflator2000 ;
label variable _incwage_cpi  "Wage and salary income, in 2000 dollars";

generate  _incbus_cpi   =  _incbus   * _cpi_deflator2000 ;
label variable _incbus_cpi   "Business income, in 2000 dollars";

generate  _hhincome_cpi =  _hhincome * _cpi_deflator2000 ;
label variable _hhincome_cpi "Total household income, in 2000 dollars";

sort wrkyr;
save temp, replace;

*** c. cutting outliers;
use temp, clear;
keep if _female==0;
keep if _white==1;
keep if _agelyr>=25 & _agelyr<=54;

collapse 
(p1)  pct01 = _inctot_cpi
(p99) pct99 = _inctot_cpi
[pw=_perwt], by(wrkyr);
sort wrkyr;
merge wrkyr using temp;
drop _merge*;

generate _inctot_cpi_tr01   = _inctot_cpi;
generate _inctot_cpi_tr99   = _inctot_cpi;
generate _inctot_cpi_tr0199 = _inctot_cpi;

replace  _inctot_cpi_tr01   = . if _inctot_cpi <= pct01;
replace  _inctot_cpi_tr99   = . if _inctot_cpi >= pct99;
replace  _inctot_cpi_tr0199 = . if _inctot_cpi <= pct01;
replace  _inctot_cpi_tr0199 = . if _inctot_cpi >= pct99;
replace  _inctot_cpi_tr0199 = . if _inctot_cpi_tr0199 < 0;

label variable _inctot_cpi_tr01   "Total personal income, in 2000 dollars, w/o 01 prc. outliers";
label variable _inctot_cpi_tr99   "Total personal income, in 2000 dollars, w/o 99 prc. outliers";
label variable _inctot_cpi_tr0199 "Total personal income, in 2000 dollars, w/o 01 and 99 prc. outliers";
drop pct01 pct99;


*** Main sample indicator ***;
generate main_sample = 1;
replace  main_sample = 0 if _agelyr < 25;
replace  main_sample = 0 if _agelyr > 54;
replace  main_sample = 0 if gq ~= 1;
replace  main_sample = 0 if _hhincome_cpi == .;
replace  main_sample = 0 if _hsd08==. | _hsd911==. | _hsg==. | _sc==. | _cg==. | _ad==.;
replace  main_sample = 0 if _white==. | _black==. | _hispanic==.;
replace  main_sample = 0 if statefip == 10;
replace  main_sample = 0 if statefip == 46;
replace  main_sample = 0 if _hhwt == . | _hhwt == 0;
replace  main_sample = 0 if _perwt == . | _perwt == 0;

tabulate main_sample, missing;

keep if main_sample==1;

replace _inctot_cpi        = 1 if _inctot_cpi        <= 0;
replace _inctot_cpi_tr01   = 1 if _inctot_cpi_tr01   <= 0;
replace _inctot_cpi_tr99   = 1 if _inctot_cpi_tr99   <= 0;
replace _inctot_cpi_tr0199 = 1 if _inctot_cpi_tr0199 <= 0;

egen gini_inctot_cpi        = inequal(_inctot_cpi),        by(statefip wrkyr) weights(_perwt) index(gini);
egen gini_inctot_cpi_tr01   = inequal(_inctot_cpi_tr01),   by(statefip wrkyr) weights(_perwt) index(gini);
egen gini_inctot_cpi_tr99   = inequal(_inctot_cpi_tr99),   by(statefip wrkyr) weights(_perwt) index(gini);
egen gini_inctot_cpi_tr0199 = inequal(_inctot_cpi_tr0199), by(statefip wrkyr) weights(_perwt) index(gini);

keep statefip wrkyr gini_*;
duplicates drop;
drop if gini_inctot_cpi        ==.;
drop if gini_inctot_cpi_tr01   ==.;
drop if gini_inctot_cpi_tr99   ==.;
drop if gini_inctot_cpi_tr0199 ==.;

generate log_gini_inctot_cpi        = log(gini_inctot_cpi);
generate log_gini_inctot_cpi_tr01   = log(gini_inctot_cpi_tr01);
generate log_gini_inctot_cpi_tr99   = log(gini_inctot_cpi_tr99);
generate log_gini_inctot_cpi_tr0199 = log(gini_inctot_cpi_tr0199);

generate logistic_gini_inctot_cpi        = log(gini_inctot_cpi/(1-gini_inctot_cpi));
generate logistic_gini_inctot_cpi_tr01   = log(gini_inctot_cpi_tr01/(1-gini_inctot_cpi_tr01));
generate logistic_gini_inctot_cpi_tr99   = log(gini_inctot_cpi_tr99/(1-gini_inctot_cpi_tr99));
generate logistic_gini_inctot_cpi_tr0199 = log(gini_inctot_cpi_tr0199/(1-gini_inctot_cpi_tr0199));

sort statefip wrkyr;
save temp, replace;


use "/home/alevkov/BeckLevineLevkov2010/data/macro_workfile.dta", clear;
keep statefip wrkyr _intra;
sort statefip wrkyr;
merge statefip wrkyr using temp;
drop _merge*;

label var _intra "Bank deregulation";

tsset statefip wrkyr;

tabulate wrkyr, gen(wrkyr_dumm);

xtreg logistic_gini_inctot_cpi        _intra wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
estimates store m1, title((1));

xtreg logistic_gini_inctot_cpi_tr01   _intra wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
estimates store m2, title((2));

xtreg logistic_gini_inctot_cpi_tr99   _intra wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
estimates store m3, title((3));

xtreg logistic_gini_inctot_cpi_tr0199 _intra wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
estimates store m4, title((4));


xtreg log_gini_inctot_cpi        _intra wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
estimates store m5, title((5));

xtreg log_gini_inctot_cpi_tr01   _intra wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
estimates store m6, title((6));

xtreg log_gini_inctot_cpi_tr99   _intra wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
estimates store m7, title((7));

xtreg log_gini_inctot_cpi_tr0199 _intra wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
estimates store m8, title((8));

estout m1 m2 m3 m4 m5 m6 m7 m8 using Appendix_TableVII.txt, append
keep(_intra)
cells(b(star fmt(3)) se(par) p(fmt(3) par({ }))) stats(r2 N, labels("R-squared" "Observations") fmt(2 0)) 
legend label collabel(none)
prehead("")
posthead("Panel B: Ages 25-54")
postfoot("")
starlevel(* 0.10 ** 0.05 *** 0.01);

erase temp.dta;

log close;


