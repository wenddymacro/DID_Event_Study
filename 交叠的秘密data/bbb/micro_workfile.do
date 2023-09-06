************************************************************************************************
*** DATE:         December 2009
*** AUTHORS:      Beck, Levine, and Levkov
*** THIS PROGRAM: 1) Reads the raw CPS data and transforms it to STATA format
***               2) Creates an individual-level 'working' file for the 'Big Bad Banks...' paper
************************************************************************************************

clear
set mem 2g
set more off
cd "/home/alevkov/BeckLevineLevkov2010/data"


**********************************************************
*** Read raw CPS data and transform it to STATA format ***
**********************************************************
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
 using raw_cps.dat

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

label define gqlbl 0 `"NIU (Vacant units)"'
label define gqlbl 1 `"Households"', add
label define gqlbl 2 `"Group Quarters"', add
label values gq gqlbl

label define statefiplbl 01 `"Alabama"'
label define statefiplbl 02 `"Alaska"', add
label define statefiplbl 04 `"Arizona"', add
label define statefiplbl 05 `"Arkansas"', add
label define statefiplbl 06 `"California"', add
label define statefiplbl 08 `"Colorado"', add
label define statefiplbl 09 `"Connecticut"', add
label define statefiplbl 10 `"Delaware"', add
label define statefiplbl 11 `"District of Columbia"', add
label define statefiplbl 12 `"Florida"', add
label define statefiplbl 13 `"Georgia"', add
label define statefiplbl 15 `"Hawaii"', add
label define statefiplbl 16 `"Idaho"', add
label define statefiplbl 17 `"Illinois"', add
label define statefiplbl 18 `"Indiana"', add
label define statefiplbl 19 `"Iowa"', add
label define statefiplbl 20 `"Kansas"', add
label define statefiplbl 21 `"Kentucky"', add
label define statefiplbl 22 `"Louisiana"', add
label define statefiplbl 23 `"Maine"', add
label define statefiplbl 24 `"Maryland"', add
label define statefiplbl 25 `"Massachusetts"', add
label define statefiplbl 26 `"Michigan"', add
label define statefiplbl 27 `"Minnesota"', add
label define statefiplbl 28 `"Mississippi"', add
label define statefiplbl 29 `"Missouri"', add
label define statefiplbl 30 `"Montana"', add
label define statefiplbl 31 `"Nebraska"', add
label define statefiplbl 32 `"Nevada"', add
label define statefiplbl 33 `"New Hampshire"', add
label define statefiplbl 34 `"New Jersey"', add
label define statefiplbl 35 `"New Mexico"', add
label define statefiplbl 36 `"New York"', add
label define statefiplbl 37 `"North Carolina"', add
label define statefiplbl 38 `"North Dakota"', add
label define statefiplbl 39 `"Ohio"', add
label define statefiplbl 40 `"Oklahoma"', add
label define statefiplbl 41 `"Oregon"', add
label define statefiplbl 42 `"Pennsylvania"', add
label define statefiplbl 44 `"Rhode Island"', add
label define statefiplbl 45 `"South Carolina"', add
label define statefiplbl 46 `"South Dakota"', add
label define statefiplbl 47 `"Tennessee"', add
label define statefiplbl 48 `"Texas"', add
label define statefiplbl 49 `"Utah"', add
label define statefiplbl 50 `"Vermont"', add
label define statefiplbl 51 `"Virginia"', add
label define statefiplbl 53 `"Washington"', add
label define statefiplbl 54 `"West Virginia"', add
label define statefiplbl 55 `"Wisconsin"', add
label define statefiplbl 56 `"Wyoming"', add
label define statefiplbl 61 `"Maine-New Hampshire-Vermont"', add
label define statefiplbl 65 `"Montana-Idaho-Wyoming"', add
label define statefiplbl 68 `"Alaska-Hawaii"', add
label define statefiplbl 69 `"Nebraska-North Dakota-South Dakota"', add
label define statefiplbl 70 `"Maine-Massachusetts-New Hampshire-Rhode Island-Vermont"', add
label define statefiplbl 71 `"Michigan-Wisconsin"', add
label define statefiplbl 72 `"Minnesota-Iowa"', add
label define statefiplbl 73 `"Nebraska-North Dakota-South Dakota-Kansas"', add
label define statefiplbl 74 `"Delaware-Virginia"', add
label define statefiplbl 75 `"North Carolina-South Carolina"', add
label define statefiplbl 76 `"Alabama-Mississippi"', add
label define statefiplbl 77 `"Arkansas-Oklahoma"', add
label define statefiplbl 78 `"Arizona-New Mexico-Colorado"', add
label define statefiplbl 79 `"Idaho-Wyoming-Utah-Montana-Nevada"', add
label define statefiplbl 80 `"Alaska-Washington-Hawaii"', add
label define statefiplbl 81 `"New Hampshire-Maine-Vermont-Rhode Island"', add
label define statefiplbl 83 `"South Carolina-Georgia"', add
label define statefiplbl 84 `"Kentucky-Tennessee"', add
label define statefiplbl 85 `"Arkansas-Louisiana-Oklahoma"', add
label define statefiplbl 87 `"Iowa-N Dakota-S Dakota-Nebraska-Kansas-Minnesota-Missouri"', add
label define statefiplbl 88 `"Washington-Oregon-Alaska-Hawaii"', add
label define statefiplbl 89 `"Montana-Wyoming-Colorado-New Mexico-Utah-Nevada-Arizona"', add
label define statefiplbl 90 `"Delaware-Maryland-Virginia-West Virginia"', add
label define statefiplbl 99 `"State not identified"', add
label values statefip statefiplbl

label define relatelbl 0101 `"Head/householder"', add
label define relatelbl 0201 `"Spouse"', add
label define relatelbl 0301 `"Child"', add
label define relatelbl 0303 `"Stepchild"', add
label define relatelbl 0501 `"Parent"', add
label define relatelbl 0701 `"Sibling"', add
label define relatelbl 0901 `"Grandchild"', add
label define relatelbl 1001 `"Other relatives, n.s."', add
label define relatelbl 1113 `"Partner/roommate"', add
label define relatelbl 1114 `"Unmarried partner"', add
label define relatelbl 1115 `"Housemate/roomate"', add
label define relatelbl 1241 `"Roomer/boarder/lodger"', add
label define relatelbl 1242 `"Foster children"', add
label define relatelbl 1260 `"Other nonrelatives"', add
label define relatelbl 9100 `"Armed Forces, relationship unknown"', add
label define relatelbl 9200 `"Age under 14, relationship unknown"', add
label define relatelbl 9900 `"Relationship unknown"', add
label values relate relatelbl

label define agelbl 00 `"Under 1 year"'
label define agelbl 01 `"1"', add
label define agelbl 02 `"2"', add
label define agelbl 03 `"3"', add
label define agelbl 04 `"4"', add
label define agelbl 05 `"5"', add
label define agelbl 06 `"6"', add
label define agelbl 07 `"7"', add
label define agelbl 08 `"8"', add
label define agelbl 09 `"9"', add
label define agelbl 10 `"10"', add
label define agelbl 11 `"11"', add
label define agelbl 12 `"12"', add
label define agelbl 13 `"13"', add
label define agelbl 14 `"14"', add
label define agelbl 15 `"15"', add
label define agelbl 16 `"16"', add
label define agelbl 17 `"17"', add
label define agelbl 18 `"18"', add
label define agelbl 19 `"19"', add
label define agelbl 20 `"20"', add
label define agelbl 21 `"21"', add
label define agelbl 22 `"22"', add
label define agelbl 23 `"23"', add
label define agelbl 24 `"24"', add
label define agelbl 25 `"25"', add
label define agelbl 26 `"26"', add
label define agelbl 27 `"27"', add
label define agelbl 28 `"28"', add
label define agelbl 29 `"29"', add
label define agelbl 30 `"30"', add
label define agelbl 31 `"31"', add
label define agelbl 32 `"32"', add
label define agelbl 33 `"33"', add
label define agelbl 34 `"34"', add
label define agelbl 35 `"35"', add
label define agelbl 36 `"36"', add
label define agelbl 37 `"37"', add
label define agelbl 38 `"38"', add
label define agelbl 39 `"39"', add
label define agelbl 40 `"40"', add
label define agelbl 41 `"41"', add
label define agelbl 42 `"42"', add
label define agelbl 43 `"43"', add
label define agelbl 44 `"44"', add
label define agelbl 45 `"45"', add
label define agelbl 46 `"46"', add
label define agelbl 47 `"47"', add
label define agelbl 48 `"48"', add
label define agelbl 49 `"49"', add
label define agelbl 50 `"50"', add
label define agelbl 51 `"51"', add
label define agelbl 52 `"52"', add
label define agelbl 53 `"53"', add
label define agelbl 54 `"54"', add
label define agelbl 55 `"55"', add
label define agelbl 56 `"56"', add
label define agelbl 57 `"57"', add
label define agelbl 58 `"58"', add
label define agelbl 59 `"59"', add
label define agelbl 60 `"60"', add
label define agelbl 61 `"61"', add
label define agelbl 62 `"62"', add
label define agelbl 63 `"63"', add
label define agelbl 64 `"64"', add
label define agelbl 65 `"65"', add
label define agelbl 66 `"66"', add
label define agelbl 67 `"67"', add
label define agelbl 68 `"68"', add
label define agelbl 69 `"69"', add
label define agelbl 70 `"70"', add
label define agelbl 71 `"71"', add
label define agelbl 72 `"72"', add
label define agelbl 73 `"73"', add
label define agelbl 74 `"74"', add
label define agelbl 75 `"75"', add
label define agelbl 76 `"76"', add
label define agelbl 77 `"77"', add
label define agelbl 78 `"78"', add
label define agelbl 79 `"79"', add
label define agelbl 80 `"80"', add
label define agelbl 81 `"81"', add
label define agelbl 82 `"82"', add
label define agelbl 83 `"83"', add
label define agelbl 84 `"84"', add
label define agelbl 85 `"85"', add
label define agelbl 86 `"86"', add
label define agelbl 87 `"87"', add
label define agelbl 88 `"88"', add
label define agelbl 89 `"89"', add
label define agelbl 90 `"90 (90+, 1988-2002)"', add
label define agelbl 91 `"91"', add
label define agelbl 92 `"92"', add
label define agelbl 93 `"93"', add
label define agelbl 94 `"94"', add
label define agelbl 95 `"95"', add
label define agelbl 96 `"96"', add
label define agelbl 97 `"97"', add
label define agelbl 98 `"98"', add
label define agelbl 99 `"99+"', add
label values age agelbl

label define sexlbl 1 `"Male"'
label define sexlbl 2 `"Female"', add
label values sex sexlbl

label define racelbl 100 `"White"'
label define racelbl 200 `"Black/Negro"', add
label define racelbl 300 `"American Indian/Aleut/Eskimo"', add
label define racelbl 650 `"Asian or Pacific Islander"', add
label define racelbl 651 `"Asian only"', add
label define racelbl 652 `"Hawaiian/Pacific Islander only"', add
label define racelbl 700 `"Other (single) race, n.e.c."', add
label define racelbl 801 `"White-Black"', add
label define racelbl 802 `"White-American Indian"', add
label define racelbl 803 `"White-Asian"', add
label define racelbl 804 `"White-Hawaiian/Pacific Islander"', add
label define racelbl 805 `"Black-American Indian"', add
label define racelbl 806 `"Black-Asian"', add
label define racelbl 807 `"Black-Hawaiian/Pacific Islander"', add
label define racelbl 808 `"American Indian-Asian"', add
label define racelbl 809 `"Asian-Hawaiian/Pacific Islander"', add
label define racelbl 810 `"White-Black-American Indian"', add
label define racelbl 811 `"White-Black-Asian"', add
label define racelbl 812 `"White-American Indian-Asian"', add
label define racelbl 813 `"White-Asian-Hawaiian/Pacific Islander"', add
label define racelbl 814 `"White-Black-American Indian-Asian"', add
label define racelbl 820 `"Two or three races, unspecified"', add
label define racelbl 830 `"Four or five races, unspecified"', add
label values race racelbl

label define hispanlbl 000 `"Not Hispanic"'
label define hispanlbl 100 `"Mexican"', add
label define hispanlbl 102 `"Mexican American"', add
label define hispanlbl 103 `"Mexicano/Mexicana"', add
label define hispanlbl 104 `"Chicano/Chicana"', add
label define hispanlbl 108 `"Mexican (Mexicano)"', add
label define hispanlbl 109 `"Mexicano/Chicano"', add
label define hispanlbl 200 `"Puerto Rican"', add
label define hispanlbl 300 `"Cuban"', add
label define hispanlbl 400 `"Other Spanish"', add
label define hispanlbl 410 `"Central/South American"', add
label define hispanlbl 901 `"Do not know"', add
label define hispanlbl 902 `"N/A (and no response 1985-87)"', add
label values hispan hispanlbl

label define educ99lbl 00 `"NIU"'
label define educ99lbl 01 `"No school completed"', add
label define educ99lbl 04 `"1st-4th grade"', add
label define educ99lbl 05 `"5th-8th grade"', add
label define educ99lbl 06 `"9th grade"', add
label define educ99lbl 07 `"10th grade"', add
label define educ99lbl 08 `"11th grade"', add
label define educ99lbl 09 `"12th grade, no diploma"', add
label define educ99lbl 10 `"High school graduate, or GED"', add
label define educ99lbl 11 `"Some college, no degree"', add
label define educ99lbl 12 `"Associate degree, type of program not specified"', add
label define educ99lbl 13 `"Associate degree, occupational program"', add
label define educ99lbl 14 `"Associate degree, academic program"', add
label define educ99lbl 15 `"Bachelors degree"', add
label define educ99lbl 16 `"Masters degree"', add
label define educ99lbl 17 `"Professional degree"', add
label define educ99lbl 18 `"Doctorate degree"', add
label values educ99 educ99lbl

label define higradelbl 000 `"NIU"'
label define higradelbl 010 `"None"', add
label define higradelbl 031 `"Did not finish 1st grade"', add
label define higradelbl 040 `"1st grade"', add
label define higradelbl 041 `"Did not finish 2nd grade"', add
label define higradelbl 050 `"2nd grade"', add
label define higradelbl 051 `"Did not finish 3rd grade"', add
label define higradelbl 060 `"3rd grade"', add
label define higradelbl 061 `"Did not finish 4th grade"', add
label define higradelbl 070 `"4th grade"', add
label define higradelbl 071 `"Did not finish 5th grade"', add
label define higradelbl 080 `"5th grade"', add
label define higradelbl 081 `"Did not finish 6th grade"', add
label define higradelbl 090 `"6th grade"', add
label define higradelbl 091 `"Did not finish 7th grade"', add
label define higradelbl 100 `"7th grade"', add
label define higradelbl 101 `"Did not finish 8th grade"', add
label define higradelbl 110 `"8th grade"', add
label define higradelbl 111 `"Did not finish 9th grade"', add
label define higradelbl 120 `"9th grade"', add
label define higradelbl 121 `"Did not finish 10th grade"', add
label define higradelbl 130 `"10th grade"', add
label define higradelbl 131 `"Did not finish 11th grade"', add
label define higradelbl 140 `"11th grade"', add
label define higradelbl 141 `"Did not finish 12th grade"', add
label define higradelbl 150 `"12th grade"', add
label define higradelbl 151 `"Did not finish 1st year college"', add
label define higradelbl 160 `"1st year college"', add
label define higradelbl 161 `"Did not finish 2nd year"', add
label define higradelbl 170 `"2nd year college"', add
label define higradelbl 171 `"Did not finish 3rd year"', add
label define higradelbl 180 `"3rd year college"', add
label define higradelbl 181 `"Did not finish 4th year"', add
label define higradelbl 190 `"4th year college"', add
label define higradelbl 191 `"Did not finish 5th year"', add
label define higradelbl 200 `"5th year college"', add
label define higradelbl 201 `"Did not finish 6th year"', add
label define higradelbl 210 `"6th year college"', add
label define higradelbl 999 `"Missing/Unknown"', add
label values higrade higradelbl

label define educreclbl 00 `"NIU"'
label define educreclbl 01 `"None or preschool"', add
label define educreclbl 02 `"Grades 1, 2, 3, or 4"', add
label define educreclbl 03 `"Grades 5, 6, 7, or 8"', add
label define educreclbl 04 `"Grade 9"', add
label define educreclbl 05 `"Grade 10"', add
label define educreclbl 06 `"Grade 11"', add
label define educreclbl 07 `"Grade 12"', add
label define educreclbl 08 `"1 to 3 years of college"', add
label define educreclbl 09 `"4+ years of college"', add
label define educreclbl 99 `"Missing/Unknown"', add
label values educrec educreclbl

label define empstatlbl 00 `"NIU"'
label define empstatlbl 10 `"At work"', add
label define empstatlbl 12 `"Has job, not at work last week"', add
label define empstatlbl 13 `"Armed Forces"', add
label define empstatlbl 20 `"Unemployed"', add
label define empstatlbl 21 `"Unemployed, experienced worker"', add
label define empstatlbl 22 `"Unemployed, new worker"', add
label define empstatlbl 30 `"Not in labor force"', add
label define empstatlbl 31 `"NILF, housework"', add
label define empstatlbl 32 `"NILF, unable to work"', add
label define empstatlbl 33 `"NILF, school"', add
label define empstatlbl 34 `"NILF, other"', add
label define empstatlbl 35 `"NILF, unpaid, lt 15 hours"', add
label values empstat empstatlbl

label define classwlylbl 00 `"NIU"'
label define classwlylbl 10 `"Self-employed"', add
label define classwlylbl 13 `"Self-employed, not incorporated"', add
label define classwlylbl 14 `"Self-employed, incorporated"', add
label define classwlylbl 20 `"Works for wages or salary"', add
label define classwlylbl 22 `"Wage/salary, private"', add
label define classwlylbl 24 `"Wage/salary, government"', add
label define classwlylbl 25 `"Federal government employee"', add
label define classwlylbl 27 `"State government employee"', add
label define classwlylbl 28 `"Local government employee"', add
label define classwlylbl 29 `"Unpaid family worker"', add
label define classwlylbl 99 `"Missing/Unknown"', add
label values classwly classwlylbl

save micro_workfile, replace


****************************************************************
*** Create a 'working' file for the 'Big Bad Banks...' paper ***
****************************************************************
#delimit;
use micro_workfile, clear;
tabulate year, missing;

generate wrkyr = year - 1;


*** Sampling weights ***;
generate _perwt = perwt;
replace  _perwt = perwt04 if year == 2004;
label variable _perwt "Personal sampling weight";

generate _hhwt = hhwt;
replace  _hhwt = hhwt04 if year == 2004;
label variable _hhwt "Household sampling weight";


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


*** Labor supply ***;
gen _wkslyr = wkswork1 ;
label variable _wkslyr "Weeks worked last year" ;

gen _hrslyr = uhrswork ;
label variable _hrslyr "Usual hours worked per week last year" ;

gen _anhrslyr = _wkslyr*_hrslyr ;
label variable _anhrslyr "Annual hours worked last year" ;

gen     _wageworker = 0 ;
replace _wageworker = 1 if classwly >=22 & classwly <=28 ;
label variable _wageworker "1 if wage/salary worker last year" ;

gen     _self_employed = 0 ;
replace _self_employed = 1 if classwly >=10 & classwly <=14 ;
label variable _self_employed "1 if Self-employed worker last year" ;

gen     _FY = 0 ;
replace _FY = 1 if _wkslyr >= 50 ;
label variable _FY "1 if person worked 50 weeks last year" ;

gen     _FT = 0 ;
replace _FT = 1 if _hrslyr >= 35 ;
label variable _FT "1 if person worked 35+ hours per week last year" ;

gen     _FTFY = _FT*_FY ;
label variable _FTFY "1 if person worked 52 weeks last year and 35+ hours per week" ;

label define _FTFY 1 "Full-Time_Full-Year" 0 "Not Full-Time_Full-Year"   ;
label values _FTFY _FTFY ;
  
label variable _FTFY "50+ wkslyr and 35+ _hrslyr" ;


*** Potential experience ***;
gen _agelyr = age-1 ;
label variable _agelyr "Age last year" ;

gen     _exp = _agelyr - 7 - _educomp ;
replace _exp = 0 if _exp < 0 ;

gen _exp1 = _exp - 15;
gen _exp2 = _exp1^2;
gen _exp3 = _exp1^3;
gen _exp4 = _exp1^4;

label variable _exp "Potential experience" ;


*** Education-potential experience interactions ***;
generate _hsd08_exp1 = _hsd08 * _exp1;
generate _hsd08_exp2 = _hsd08 * _exp2;
generate _hsd08_exp3 = _hsd08 * _exp3;
generate _hsd08_exp4 = _hsd08 * _exp4;

generate _hsd911_exp1 = _hsd911 * _exp1;
generate _hsd911_exp2 = _hsd911 * _exp2;
generate _hsd911_exp3 = _hsd911 * _exp3;
generate _hsd911_exp4 = _hsd911 * _exp4;

generate _hsg_exp1 = _hsg * _exp1;
generate _hsg_exp2 = _hsg * _exp2;
generate _hsg_exp3 = _hsg * _exp3;
generate _hsg_exp4 = _hsg * _exp4;

generate _cg_exp1 = _cg * _exp1;
generate _cg_exp2 = _cg * _exp2;
generate _cg_exp3 = _cg * _exp3;
generate _cg_exp4 = _cg * _exp4;

generate _ad_exp1 = _ad * _exp1;
generate _ad_exp2 = _ad * _exp2;
generate _ad_exp3 = _ad * _exp3;
generate _ad_exp4 = _ad * _exp4;


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
erase temp.dta;

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
replace  main_sample = 0 if _inctot_cpi_tr0199 == .;
replace  main_sample = 0 if _hhincome_cpi == .;
replace  main_sample = 0 if _hsd08==. | _hsd911==. | _hsg==. | _sc==. | _cg==. | _ad==.;
replace  main_sample = 0 if _white==. | _black==. | _hispanic==.;
replace  main_sample = 0 if statefip == 10;
replace  main_sample = 0 if statefip == 46;
replace  main_sample = 0 if _hhwt == . | _hhwt == 0;
replace  main_sample = 0 if _perwt == . | _perwt == 0;

tabulate main_sample, missing;
compress;
save micro_workfile, replace;


