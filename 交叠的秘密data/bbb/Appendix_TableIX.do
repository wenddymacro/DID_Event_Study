**********************************************************************************************************************************
*** Date:    December 2009
*** Authors: Beck, Levine, and Levkov
*** Purpose: Create Appendix Table IX in "Big Bad Banks? The Winners and Losers from Bank Deregulation in the United States"
*** Note:    Please change the working directories below
*** Note:    The calculation of Theil index is very time consuming
**********************************************************************************************************************************


#delimit;
clear;
set mem 2g;
set more off;

cd "/home/alevkov/BeckLevineLevkov2010";

log using Appendix_TableIX.log, replace;

*******************************************;
*** CALCULATING THEIL INDEX FOR PANEL A ***;
*******************************************;
use "/home/alevkov/BeckLevineLevkov2010/data/micro_workfile.dta", clear;
keep if main_sample == 1;

generate ok=0;
replace  ok=1 if classwly==13 | classwly==14;
replace  ok=1 if classwly>=22 & classwly<=28;
keep if ok==1;

*** Group 1 -- white;
*** Group 2 -- non-white;
generate group=.;
replace  group=1 if _white==1;
replace  group=2 if _white==0;
drop if group==.;
tab group, missing;

keep statefip wrkyr _inctot_cpi_tr0199 _perwt serial group;

generate Y = _inctot_cpi_tr0199;

#delimit cr
generate total    = .
generate between  = .
generate within   = .
generate within_1 = .
generate within_2 = .

save temporary, replace

************
*** 1976 ***
************
use temporary, clear
keep if wrkyr==1976

levels statefip, local(state)
 levels wrkyr, local(time)
  foreach s of local state {
   foreach t of local time {
   quietly ineqdeco Y [aw = _perwt]          if statefip==`s' & wrkyr==`t', bygroup(group)
   quietly replace total    = r(ge1)         if statefip==`s' & wrkyr==`t'
   quietly replace between  = r(between_ge1) if statefip==`s' & wrkyr==`t'
   quietly replace within   = r(within_ge1)  if statefip==`s' & wrkyr==`t'
   quietly replace within_1 = r(ge1_1)       if statefip==`s' & wrkyr==`t'
   quietly replace within_2 = r(ge1_2)       if statefip==`s' & wrkyr==`t'
   display "Now running year " `t' " and state... " `s'
}
}
keep statefip wrkyr total between within within_1 within_2  
duplicates drop
sort statefip
save theil1976, replace

************
*** 1977 ***
************
use temporary, clear
keep if wrkyr==1977

levels statefip, local(state)
 levels wrkyr, local(time)
  foreach s of local state {
   foreach t of local time {
   quietly ineqdeco Y [aw = _perwt]          if statefip==`s' & wrkyr==`t', bygroup(group)
   quietly replace total    = r(ge1)         if statefip==`s' & wrkyr==`t'
   quietly replace between  = r(between_ge1) if statefip==`s' & wrkyr==`t'
   quietly replace within   = r(within_ge1)  if statefip==`s' & wrkyr==`t'
   quietly replace within_1 = r(ge1_1)       if statefip==`s' & wrkyr==`t'
   quietly replace within_2 = r(ge1_2)       if statefip==`s' & wrkyr==`t'
   display "Now running year " `t' " and state... " `s'
}
}
keep statefip wrkyr total between within within_1 within_2  
duplicates drop
sort statefip
save theil1977, replace

************
*** 1978 ***
************
use temporary, clear
keep if wrkyr==1978

levels statefip, local(state)
 levels wrkyr, local(time)
  foreach s of local state {
   foreach t of local time {
   quietly ineqdeco Y [aw = _perwt]          if statefip==`s' & wrkyr==`t', bygroup(group)
   quietly replace total    = r(ge1)         if statefip==`s' & wrkyr==`t'
   quietly replace between  = r(between_ge1) if statefip==`s' & wrkyr==`t'
   quietly replace within   = r(within_ge1)  if statefip==`s' & wrkyr==`t'
   quietly replace within_1 = r(ge1_1)       if statefip==`s' & wrkyr==`t'
   quietly replace within_2 = r(ge1_2)       if statefip==`s' & wrkyr==`t'
   display "Now running year " `t' " and state... " `s'
}
}
keep statefip wrkyr total between within within_1 within_2  
duplicates drop
sort statefip
save theil1978, replace

************
*** 1979 ***
************
use temporary, clear
keep if wrkyr==1979

levels statefip, local(state)
 levels wrkyr, local(time)
  foreach s of local state {
   foreach t of local time {
   quietly ineqdeco Y [aw = _perwt]          if statefip==`s' & wrkyr==`t', bygroup(group)
   quietly replace total    = r(ge1)         if statefip==`s' & wrkyr==`t'
   quietly replace between  = r(between_ge1) if statefip==`s' & wrkyr==`t'
   quietly replace within   = r(within_ge1)  if statefip==`s' & wrkyr==`t'
   quietly replace within_1 = r(ge1_1)       if statefip==`s' & wrkyr==`t'
   quietly replace within_2 = r(ge1_2)       if statefip==`s' & wrkyr==`t'
   display "Now running year " `t' " and state... " `s'
}
}
keep statefip wrkyr total between within within_1 within_2  
duplicates drop
sort statefip
save theil1979, replace

************
*** 1980 ***
************
use temporary, clear
keep if wrkyr==1980

levels statefip, local(state)
 levels wrkyr, local(time)
  foreach s of local state {
   foreach t of local time {
   quietly ineqdeco Y [aw = _perwt]          if statefip==`s' & wrkyr==`t', bygroup(group)
   quietly replace total    = r(ge1)         if statefip==`s' & wrkyr==`t'
   quietly replace between  = r(between_ge1) if statefip==`s' & wrkyr==`t'
   quietly replace within   = r(within_ge1)  if statefip==`s' & wrkyr==`t'
   quietly replace within_1 = r(ge1_1)       if statefip==`s' & wrkyr==`t'
   quietly replace within_2 = r(ge1_2)       if statefip==`s' & wrkyr==`t'
   display "Now running year " `t' " and state... " `s'
}
}
keep statefip wrkyr total between within within_1 within_2  
duplicates drop
sort statefip
save theil1980, replace


************
*** 1981 ***
************
use temporary, clear
keep if wrkyr==1981

levels statefip, local(state)
 levels wrkyr, local(time)
  foreach s of local state {
   foreach t of local time {
   quietly ineqdeco Y [aw = _perwt]          if statefip==`s' & wrkyr==`t', bygroup(group)
   quietly replace total    = r(ge1)         if statefip==`s' & wrkyr==`t'
   quietly replace between  = r(between_ge1) if statefip==`s' & wrkyr==`t'
   quietly replace within   = r(within_ge1)  if statefip==`s' & wrkyr==`t'
   quietly replace within_1 = r(ge1_1)       if statefip==`s' & wrkyr==`t'
   quietly replace within_2 = r(ge1_2)       if statefip==`s' & wrkyr==`t'
   display "Now running year " `t' " and state... " `s'
}
}
keep statefip wrkyr total between within within_1 within_2  
duplicates drop
sort statefip
save theil1981, replace

************
*** 1982 ***
************
use temporary, clear
keep if wrkyr==1982

levels statefip, local(state)
 levels wrkyr, local(time)
  foreach s of local state {
   foreach t of local time {
   quietly ineqdeco Y [aw = _perwt]          if statefip==`s' & wrkyr==`t', bygroup(group)
   quietly replace total    = r(ge1)         if statefip==`s' & wrkyr==`t'
   quietly replace between  = r(between_ge1) if statefip==`s' & wrkyr==`t'
   quietly replace within   = r(within_ge1)  if statefip==`s' & wrkyr==`t'
   quietly replace within_1 = r(ge1_1)       if statefip==`s' & wrkyr==`t'
   quietly replace within_2 = r(ge1_2)       if statefip==`s' & wrkyr==`t'
   display "Now running year " `t' " and state... " `s'
}
}
keep statefip wrkyr total between within within_1 within_2  
duplicates drop
sort statefip
save theil1982, replace

************
*** 1983 ***
************
use temporary, clear
keep if wrkyr==1983

levels statefip, local(state)
 levels wrkyr, local(time)
  foreach s of local state {
   foreach t of local time {
   quietly ineqdeco Y [aw = _perwt]          if statefip==`s' & wrkyr==`t', bygroup(group)
   quietly replace total    = r(ge1)         if statefip==`s' & wrkyr==`t'
   quietly replace between  = r(between_ge1) if statefip==`s' & wrkyr==`t'
   quietly replace within   = r(within_ge1)  if statefip==`s' & wrkyr==`t'
   quietly replace within_1 = r(ge1_1)       if statefip==`s' & wrkyr==`t'
   quietly replace within_2 = r(ge1_2)       if statefip==`s' & wrkyr==`t'
   display "Now running year " `t' " and state... " `s'
}
}
keep statefip wrkyr total between within within_1 within_2  
duplicates drop
sort statefip
save theil1983, replace

************
*** 1984 ***
************
use temporary, clear
keep if wrkyr==1984

levels statefip, local(state)
 levels wrkyr, local(time)
  foreach s of local state {
   foreach t of local time {
   quietly ineqdeco Y [aw = _perwt]          if statefip==`s' & wrkyr==`t', bygroup(group)
   quietly replace total    = r(ge1)         if statefip==`s' & wrkyr==`t'
   quietly replace between  = r(between_ge1) if statefip==`s' & wrkyr==`t'
   quietly replace within   = r(within_ge1)  if statefip==`s' & wrkyr==`t'
   quietly replace within_1 = r(ge1_1)       if statefip==`s' & wrkyr==`t'
   quietly replace within_2 = r(ge1_2)       if statefip==`s' & wrkyr==`t'
   display "Now running year " `t' " and state... " `s'
}
}
keep statefip wrkyr total between within within_1 within_2  
duplicates drop
sort statefip
save theil1984, replace

************
*** 1985 ***
************
use temporary, clear
keep if wrkyr==1985

levels statefip, local(state)
 levels wrkyr, local(time)
  foreach s of local state {
   foreach t of local time {
   quietly ineqdeco Y [aw = _perwt]          if statefip==`s' & wrkyr==`t', bygroup(group)
   quietly replace total    = r(ge1)         if statefip==`s' & wrkyr==`t'
   quietly replace between  = r(between_ge1) if statefip==`s' & wrkyr==`t'
   quietly replace within   = r(within_ge1)  if statefip==`s' & wrkyr==`t'
   quietly replace within_1 = r(ge1_1)       if statefip==`s' & wrkyr==`t'
   quietly replace within_2 = r(ge1_2)       if statefip==`s' & wrkyr==`t'
   display "Now running year " `t' " and state... " `s'
}
}
keep statefip wrkyr total between within within_1 within_2  
duplicates drop
sort statefip
save theil1985, replace

************
*** 1986 ***
************
use temporary, clear
keep if wrkyr==1986

levels statefip, local(state)
 levels wrkyr, local(time)
  foreach s of local state {
   foreach t of local time {
   quietly ineqdeco Y [aw = _perwt]          if statefip==`s' & wrkyr==`t', bygroup(group)
   quietly replace total    = r(ge1)         if statefip==`s' & wrkyr==`t'
   quietly replace between  = r(between_ge1) if statefip==`s' & wrkyr==`t'
   quietly replace within   = r(within_ge1)  if statefip==`s' & wrkyr==`t'
   quietly replace within_1 = r(ge1_1)       if statefip==`s' & wrkyr==`t'
   quietly replace within_2 = r(ge1_2)       if statefip==`s' & wrkyr==`t'
   display "Now running year " `t' " and state... " `s'
}
}
keep statefip wrkyr total between within within_1 within_2  
duplicates drop
sort statefip
save theil1986, replace

************
*** 1987 ***
************
use temporary, clear
keep if wrkyr==1987

levels statefip, local(state)
 levels wrkyr, local(time)
  foreach s of local state {
   foreach t of local time {
   quietly ineqdeco Y [aw = _perwt]          if statefip==`s' & wrkyr==`t', bygroup(group)
   quietly replace total    = r(ge1)         if statefip==`s' & wrkyr==`t'
   quietly replace between  = r(between_ge1) if statefip==`s' & wrkyr==`t'
   quietly replace within   = r(within_ge1)  if statefip==`s' & wrkyr==`t'
   quietly replace within_1 = r(ge1_1)       if statefip==`s' & wrkyr==`t'
   quietly replace within_2 = r(ge1_2)       if statefip==`s' & wrkyr==`t'
   display "Now running year " `t' " and state... " `s'
}
}
keep statefip wrkyr total between within within_1 within_2  
duplicates drop
sort statefip
save theil1987, replace

************
*** 1988 ***
************
use temporary, clear
keep if wrkyr==1988

levels statefip, local(state)
 levels wrkyr, local(time)
  foreach s of local state {
   foreach t of local time {
   quietly ineqdeco Y [aw = _perwt]          if statefip==`s' & wrkyr==`t', bygroup(group)
   quietly replace total    = r(ge1)         if statefip==`s' & wrkyr==`t'
   quietly replace between  = r(between_ge1) if statefip==`s' & wrkyr==`t'
   quietly replace within   = r(within_ge1)  if statefip==`s' & wrkyr==`t'
   quietly replace within_1 = r(ge1_1)       if statefip==`s' & wrkyr==`t'
   quietly replace within_2 = r(ge1_2)       if statefip==`s' & wrkyr==`t'
   display "Now running year " `t' " and state... " `s'
}
}
keep statefip wrkyr total between within within_1 within_2  
duplicates drop
sort statefip
save theil1988, replace

************
*** 1989 ***
************
use temporary, clear
keep if wrkyr==1989

levels statefip, local(state)
 levels wrkyr, local(time)
  foreach s of local state {
   foreach t of local time {
   quietly ineqdeco Y [aw = _perwt]          if statefip==`s' & wrkyr==`t', bygroup(group)
   quietly replace total    = r(ge1)         if statefip==`s' & wrkyr==`t'
   quietly replace between  = r(between_ge1) if statefip==`s' & wrkyr==`t'
   quietly replace within   = r(within_ge1)  if statefip==`s' & wrkyr==`t'
   quietly replace within_1 = r(ge1_1)       if statefip==`s' & wrkyr==`t'
   quietly replace within_2 = r(ge1_2)       if statefip==`s' & wrkyr==`t'
   display "Now running year " `t' " and state... " `s'
}
}
keep statefip wrkyr total between within within_1 within_2  
duplicates drop
sort statefip
save theil1989, replace

************
*** 1990 ***
************
use temporary, clear
keep if wrkyr==1990

levels statefip, local(state)
 levels wrkyr, local(time)
  foreach s of local state {
   foreach t of local time {
   quietly ineqdeco Y [aw = _perwt]          if statefip==`s' & wrkyr==`t', bygroup(group)
   quietly replace total    = r(ge1)         if statefip==`s' & wrkyr==`t'
   quietly replace between  = r(between_ge1) if statefip==`s' & wrkyr==`t'
   quietly replace within   = r(within_ge1)  if statefip==`s' & wrkyr==`t'
   quietly replace within_1 = r(ge1_1)       if statefip==`s' & wrkyr==`t'
   quietly replace within_2 = r(ge1_2)       if statefip==`s' & wrkyr==`t'
   display "Now running year " `t' " and state... " `s'
}
}
keep statefip wrkyr total between within within_1 within_2  
duplicates drop
sort statefip
save theil1990, replace

************
*** 1991 ***
************
use temporary, clear
keep if wrkyr==1991

levels statefip, local(state)
 levels wrkyr, local(time)
  foreach s of local state {
   foreach t of local time {
   quietly ineqdeco Y [aw = _perwt]          if statefip==`s' & wrkyr==`t', bygroup(group)
   quietly replace total    = r(ge1)         if statefip==`s' & wrkyr==`t'
   quietly replace between  = r(between_ge1) if statefip==`s' & wrkyr==`t'
   quietly replace within   = r(within_ge1)  if statefip==`s' & wrkyr==`t'
   quietly replace within_1 = r(ge1_1)       if statefip==`s' & wrkyr==`t'
   quietly replace within_2 = r(ge1_2)       if statefip==`s' & wrkyr==`t'
   display "Now running year " `t' " and state... " `s'
}
}
keep statefip wrkyr total between within within_1 within_2  
duplicates drop
sort statefip
save theil1991, replace

************
*** 1992 ***
************
use temporary, clear
keep if wrkyr==1992

levels statefip, local(state)
 levels wrkyr, local(time)
  foreach s of local state {
   foreach t of local time {
   quietly ineqdeco Y [aw = _perwt]          if statefip==`s' & wrkyr==`t', bygroup(group)
   quietly replace total    = r(ge1)         if statefip==`s' & wrkyr==`t'
   quietly replace between  = r(between_ge1) if statefip==`s' & wrkyr==`t'
   quietly replace within   = r(within_ge1)  if statefip==`s' & wrkyr==`t'
   quietly replace within_1 = r(ge1_1)       if statefip==`s' & wrkyr==`t'
   quietly replace within_2 = r(ge1_2)       if statefip==`s' & wrkyr==`t'
   display "Now running year " `t' " and state... " `s'
}
}
keep statefip wrkyr total between within within_1 within_2  
duplicates drop
sort statefip
save theil1992, replace

************
*** 1993 ***
************
use temporary, clear
keep if wrkyr==1993

levels statefip, local(state)
 levels wrkyr, local(time)
  foreach s of local state {
   foreach t of local time {
   quietly ineqdeco Y [aw = _perwt]          if statefip==`s' & wrkyr==`t', bygroup(group)
   quietly replace total    = r(ge1)         if statefip==`s' & wrkyr==`t'
   quietly replace between  = r(between_ge1) if statefip==`s' & wrkyr==`t'
   quietly replace within   = r(within_ge1)  if statefip==`s' & wrkyr==`t'
   quietly replace within_1 = r(ge1_1)       if statefip==`s' & wrkyr==`t'
   quietly replace within_2 = r(ge1_2)       if statefip==`s' & wrkyr==`t'
   display "Now running year " `t' " and state... " `s'
}
}
keep statefip wrkyr total between within within_1 within_2  
duplicates drop
sort statefip
save theil1993, replace

************
*** 1994 ***
************
use temporary, clear
keep if wrkyr==1994

levels statefip, local(state)
 levels wrkyr, local(time)
  foreach s of local state {
   foreach t of local time {
   quietly ineqdeco Y [aw = _perwt]          if statefip==`s' & wrkyr==`t', bygroup(group)
   quietly replace total    = r(ge1)         if statefip==`s' & wrkyr==`t'
   quietly replace between  = r(between_ge1) if statefip==`s' & wrkyr==`t'
   quietly replace within   = r(within_ge1)  if statefip==`s' & wrkyr==`t'
   quietly replace within_1 = r(ge1_1)       if statefip==`s' & wrkyr==`t'
   quietly replace within_2 = r(ge1_2)       if statefip==`s' & wrkyr==`t'
   display "Now running year " `t' " and state... " `s'
}
}
keep statefip wrkyr total between within within_1 within_2  
duplicates drop
sort statefip
save theil1994, replace

************
*** 1995 ***
************
use temporary, clear
keep if wrkyr==1995

levels statefip, local(state)
 levels wrkyr, local(time)
  foreach s of local state {
   foreach t of local time {
   quietly ineqdeco Y [aw = _perwt]          if statefip==`s' & wrkyr==`t', bygroup(group)
   quietly replace total    = r(ge1)         if statefip==`s' & wrkyr==`t'
   quietly replace between  = r(between_ge1) if statefip==`s' & wrkyr==`t'
   quietly replace within   = r(within_ge1)  if statefip==`s' & wrkyr==`t'
   quietly replace within_1 = r(ge1_1)       if statefip==`s' & wrkyr==`t'
   quietly replace within_2 = r(ge1_2)       if statefip==`s' & wrkyr==`t'
   display "Now running year " `t' " and state... " `s'
}
}
keep statefip wrkyr total between within within_1 within_2  
duplicates drop
sort statefip
save theil1995, replace

************
*** 1996 ***
************
use temporary, clear
keep if wrkyr==1996

levels statefip, local(state)
 levels wrkyr, local(time)
  foreach s of local state {
   foreach t of local time {
   quietly ineqdeco Y [aw = _perwt]          if statefip==`s' & wrkyr==`t', bygroup(group)
   quietly replace total    = r(ge1)         if statefip==`s' & wrkyr==`t'
   quietly replace between  = r(between_ge1) if statefip==`s' & wrkyr==`t'
   quietly replace within   = r(within_ge1)  if statefip==`s' & wrkyr==`t'
   quietly replace within_1 = r(ge1_1)       if statefip==`s' & wrkyr==`t'
   quietly replace within_2 = r(ge1_2)       if statefip==`s' & wrkyr==`t'
   display "Now running year " `t' " and state... " `s'
}
}
keep statefip wrkyr total between within within_1 within_2  
duplicates drop
sort statefip
save theil1996, replace

************
*** 1997 ***
************
use temporary, clear
keep if wrkyr==1997

levels statefip, local(state)
 levels wrkyr, local(time)
  foreach s of local state {
   foreach t of local time {
   quietly ineqdeco Y [aw = _perwt]          if statefip==`s' & wrkyr==`t', bygroup(group)
   quietly replace total    = r(ge1)         if statefip==`s' & wrkyr==`t'
   quietly replace between  = r(between_ge1) if statefip==`s' & wrkyr==`t'
   quietly replace within   = r(within_ge1)  if statefip==`s' & wrkyr==`t'
   quietly replace within_1 = r(ge1_1)       if statefip==`s' & wrkyr==`t'
   quietly replace within_2 = r(ge1_2)       if statefip==`s' & wrkyr==`t'
   display "Now running year " `t' " and state... " `s'
}
}
keep statefip wrkyr total between within within_1 within_2  
duplicates drop
sort statefip
save theil1997, replace

************
*** 1998 ***
************
use temporary, clear
keep if wrkyr==1998

levels statefip, local(state)
 levels wrkyr, local(time)
  foreach s of local state {
   foreach t of local time {
   quietly ineqdeco Y [aw = _perwt]          if statefip==`s' & wrkyr==`t', bygroup(group)
   quietly replace total    = r(ge1)         if statefip==`s' & wrkyr==`t'
   quietly replace between  = r(between_ge1) if statefip==`s' & wrkyr==`t'
   quietly replace within   = r(within_ge1)  if statefip==`s' & wrkyr==`t'
   quietly replace within_1 = r(ge1_1)       if statefip==`s' & wrkyr==`t'
   quietly replace within_2 = r(ge1_2)       if statefip==`s' & wrkyr==`t'
   display "Now running year " `t' " and state... " `s'
}
}
keep statefip wrkyr total between within within_1 within_2  
duplicates drop
sort statefip
save theil1998, replace

************
*** 1999 ***
************
use temporary, clear
keep if wrkyr==1999

levels statefip, local(state)
 levels wrkyr, local(time)
  foreach s of local state {
   foreach t of local time {
   quietly ineqdeco Y [aw = _perwt]          if statefip==`s' & wrkyr==`t', bygroup(group)
   quietly replace total    = r(ge1)         if statefip==`s' & wrkyr==`t'
   quietly replace between  = r(between_ge1) if statefip==`s' & wrkyr==`t'
   quietly replace within   = r(within_ge1)  if statefip==`s' & wrkyr==`t'
   quietly replace within_1 = r(ge1_1)       if statefip==`s' & wrkyr==`t'
   quietly replace within_2 = r(ge1_2)       if statefip==`s' & wrkyr==`t'
   display "Now running year " `t' " and state... " `s'
}
}
keep statefip wrkyr total between within within_1 within_2  
duplicates drop
sort statefip
save theil1999, replace

************
*** 2000 ***
************
use temporary, clear
keep if wrkyr==2000

levels statefip, local(state)
 levels wrkyr, local(time)
  foreach s of local state {
   foreach t of local time {
   quietly ineqdeco Y [aw = _perwt]          if statefip==`s' & wrkyr==`t', bygroup(group)
   quietly replace total    = r(ge1)         if statefip==`s' & wrkyr==`t'
   quietly replace between  = r(between_ge1) if statefip==`s' & wrkyr==`t'
   quietly replace within   = r(within_ge1)  if statefip==`s' & wrkyr==`t'
   quietly replace within_1 = r(ge1_1)       if statefip==`s' & wrkyr==`t'
   quietly replace within_2 = r(ge1_2)       if statefip==`s' & wrkyr==`t'
   display "Now running year " `t' " and state... " `s'
}
}
keep statefip wrkyr total between within within_1 within_2  
duplicates drop
sort statefip
save theil2000, replace

************
*** 2001 ***
************
use temporary, clear
keep if wrkyr==2001

levels statefip, local(state)
 levels wrkyr, local(time)
  foreach s of local state {
   foreach t of local time {
   quietly ineqdeco Y [aw = _perwt]          if statefip==`s' & wrkyr==`t', bygroup(group)
   quietly replace total    = r(ge1)         if statefip==`s' & wrkyr==`t'
   quietly replace between  = r(between_ge1) if statefip==`s' & wrkyr==`t'
   quietly replace within   = r(within_ge1)  if statefip==`s' & wrkyr==`t'
   quietly replace within_1 = r(ge1_1)       if statefip==`s' & wrkyr==`t'
   quietly replace within_2 = r(ge1_2)       if statefip==`s' & wrkyr==`t'
   display "Now running year " `t' " and state... " `s'
}
}
keep statefip wrkyr total between within within_1 within_2  
duplicates drop
sort statefip
save theil2001, replace

************
*** 2002 ***
************
use temporary, clear
keep if wrkyr==2002

levels statefip, local(state)
 levels wrkyr, local(time)
  foreach s of local state {
   foreach t of local time {
   quietly ineqdeco Y [aw = _perwt]          if statefip==`s' & wrkyr==`t', bygroup(group)
   quietly replace total    = r(ge1)         if statefip==`s' & wrkyr==`t'
   quietly replace between  = r(between_ge1) if statefip==`s' & wrkyr==`t'
   quietly replace within   = r(within_ge1)  if statefip==`s' & wrkyr==`t'
   quietly replace within_1 = r(ge1_1)       if statefip==`s' & wrkyr==`t'
   quietly replace within_2 = r(ge1_2)       if statefip==`s' & wrkyr==`t'
   display "Now running year " `t' " and state... " `s'
}
}
keep statefip wrkyr total between within within_1 within_2  
duplicates drop
sort statefip
save theil2002, replace

************
*** 2003 ***
************
use temporary, clear
keep if wrkyr==2003

levels statefip, local(state)
 levels wrkyr, local(time)
  foreach s of local state {
   foreach t of local time {
   quietly ineqdeco Y [aw = _perwt]          if statefip==`s' & wrkyr==`t', bygroup(group)
   quietly replace total    = r(ge1)         if statefip==`s' & wrkyr==`t'
   quietly replace between  = r(between_ge1) if statefip==`s' & wrkyr==`t'
   quietly replace within   = r(within_ge1)  if statefip==`s' & wrkyr==`t'
   quietly replace within_1 = r(ge1_1)       if statefip==`s' & wrkyr==`t'
   quietly replace within_2 = r(ge1_2)       if statefip==`s' & wrkyr==`t'
   display "Now running year " `t' " and state... " `s'
}
}
keep statefip wrkyr total between within within_1 within_2  
duplicates drop
sort statefip
save theil2003, replace

************
*** 2004 ***
************
use temporary, clear
keep if wrkyr==2004

levels statefip, local(state)
 levels wrkyr, local(time)
  foreach s of local state {
   foreach t of local time {
   quietly ineqdeco Y [aw = _perwt]          if statefip==`s' & wrkyr==`t', bygroup(group)
   quietly replace total    = r(ge1)         if statefip==`s' & wrkyr==`t'
   quietly replace between  = r(between_ge1) if statefip==`s' & wrkyr==`t'
   quietly replace within   = r(within_ge1)  if statefip==`s' & wrkyr==`t'
   quietly replace within_1 = r(ge1_1)       if statefip==`s' & wrkyr==`t'
   quietly replace within_2 = r(ge1_2)       if statefip==`s' & wrkyr==`t'
   display "Now running year " `t' " and state... " `s'
}
}
keep statefip wrkyr total between within within_1 within_2  
duplicates drop
sort statefip
save theil2004, replace

************
*** 2005 ***
************
use temporary, clear
keep if wrkyr==2005

levels statefip, local(state)
 levels wrkyr, local(time)
  foreach s of local state {
   foreach t of local time {
   quietly ineqdeco Y [aw = _perwt]          if statefip==`s' & wrkyr==`t', bygroup(group)
   quietly replace total    = r(ge1)         if statefip==`s' & wrkyr==`t'
   quietly replace between  = r(between_ge1) if statefip==`s' & wrkyr==`t'
   quietly replace within   = r(within_ge1)  if statefip==`s' & wrkyr==`t'
   quietly replace within_1 = r(ge1_1)       if statefip==`s' & wrkyr==`t'
   quietly replace within_2 = r(ge1_2)       if statefip==`s' & wrkyr==`t'
   display "Now running year " `t' " and state... " `s'
}
}
keep statefip wrkyr total between within within_1 within_2  
duplicates drop
sort statefip
save theil2005, replace

************
*** 2006 ***
************
use temporary, clear
keep if wrkyr==2006

levels statefip, local(state)
 levels wrkyr, local(time)
  foreach s of local state {
   foreach t of local time {
   quietly ineqdeco Y [aw = _perwt]          if statefip==`s' & wrkyr==`t', bygroup(group)
   quietly replace total    = r(ge1)         if statefip==`s' & wrkyr==`t'
   quietly replace between  = r(between_ge1) if statefip==`s' & wrkyr==`t'
   quietly replace within   = r(within_ge1)  if statefip==`s' & wrkyr==`t'
   quietly replace within_1 = r(ge1_1)       if statefip==`s' & wrkyr==`t'
   quietly replace within_2 = r(ge1_2)       if statefip==`s' & wrkyr==`t'
   display "Now running year " `t' " and state... " `s'
}
}
keep statefip wrkyr total between within within_1 within_2  
duplicates drop
sort statefip
save theil2006, replace

**********************************
*** POOLING ALL YEARS TOGETHER ***
**********************************
#delimit;
use theil1976, clear;
append using theil1977;
append using theil1978;
append using theil1979;
append using theil1980;
append using theil1981;
append using theil1982;
append using theil1983;
append using theil1984;
append using theil1985;
append using theil1986;
append using theil1987;
append using theil1988;
append using theil1989;
append using theil1990;
append using theil1991;
append using theil1992;
append using theil1993;
append using theil1994;
append using theil1995;
append using theil1996;
append using theil1997;
append using theil1998;
append using theil1999;
append using theil2000;
append using theil2001;
append using theil2002;
append using theil2003;
append using theil2004;
append using theil2005;
append using theil2006;
sort statefip wrkyr;
save Appendix_TableIXpanelA, replace;
erase theil1976.dta;
erase theil1977.dta;
erase theil1978.dta;
erase theil1979.dta;
erase theil1980.dta;
erase theil1981.dta;
erase theil1982.dta;
erase theil1983.dta;
erase theil1984.dta;
erase theil1985.dta;
erase theil1986.dta;
erase theil1987.dta;
erase theil1988.dta;
erase theil1989.dta;
erase theil1990.dta;
erase theil1991.dta;
erase theil1992.dta;
erase theil1993.dta;
erase theil1994.dta;
erase theil1995.dta;
erase theil1996.dta;
erase theil1997.dta;
erase theil1998.dta;
erase theil1999.dta;
erase theil2000.dta;
erase theil2001.dta;
erase theil2002.dta;
erase theil2003.dta;
erase theil2004.dta;
erase theil2005.dta;
erase theil2006.dta;



*******************************************;
*** CALCULATING THEIL INDEX FOR PANEL B ***;
*******************************************;
use "/home/alevkov/BeckLevineLevkov2010/data/micro_workfile.dta", clear;
keep if main_sample == 1;

generate ok=0;
replace  ok=1 if classwly==13 | classwly==14;
replace  ok=1 if classwly>=22 & classwly<=28;
keep if ok==1;

*** Group 1 -- men;
*** Group 2 -- women;
generate group=.;
replace  group=1 if _female==0;
replace  group=2 if _female==1;
drop if group==.;
tab group, missing;

keep statefip wrkyr _inctot_cpi_tr0199 _perwt serial group;

generate Y = _inctot_cpi_tr0199;

#delimit cr
generate total    = .
generate between  = .
generate within   = .
generate within_1 = .
generate within_2 = .

save temporary, replace

************
*** 1976 ***
************
use temporary, clear
keep if wrkyr==1976

levels statefip, local(state)
 levels wrkyr, local(time)
  foreach s of local state {
   foreach t of local time {
   quietly ineqdeco Y [aw = _perwt]          if statefip==`s' & wrkyr==`t', bygroup(group)
   quietly replace total    = r(ge1)         if statefip==`s' & wrkyr==`t'
   quietly replace between  = r(between_ge1) if statefip==`s' & wrkyr==`t'
   quietly replace within   = r(within_ge1)  if statefip==`s' & wrkyr==`t'
   quietly replace within_1 = r(ge1_1)       if statefip==`s' & wrkyr==`t'
   quietly replace within_2 = r(ge1_2)       if statefip==`s' & wrkyr==`t'
   display "Now running year " `t' " and state... " `s'
}
}
keep statefip wrkyr total between within within_1 within_2  
duplicates drop
sort statefip
save theil1976, replace

************
*** 1977 ***
************
use temporary, clear
keep if wrkyr==1977

levels statefip, local(state)
 levels wrkyr, local(time)
  foreach s of local state {
   foreach t of local time {
   quietly ineqdeco Y [aw = _perwt]          if statefip==`s' & wrkyr==`t', bygroup(group)
   quietly replace total    = r(ge1)         if statefip==`s' & wrkyr==`t'
   quietly replace between  = r(between_ge1) if statefip==`s' & wrkyr==`t'
   quietly replace within   = r(within_ge1)  if statefip==`s' & wrkyr==`t'
   quietly replace within_1 = r(ge1_1)       if statefip==`s' & wrkyr==`t'
   quietly replace within_2 = r(ge1_2)       if statefip==`s' & wrkyr==`t'
   display "Now running year " `t' " and state... " `s'
}
}
keep statefip wrkyr total between within within_1 within_2  
duplicates drop
sort statefip
save theil1977, replace

************
*** 1978 ***
************
use temporary, clear
keep if wrkyr==1978

levels statefip, local(state)
 levels wrkyr, local(time)
  foreach s of local state {
   foreach t of local time {
   quietly ineqdeco Y [aw = _perwt]          if statefip==`s' & wrkyr==`t', bygroup(group)
   quietly replace total    = r(ge1)         if statefip==`s' & wrkyr==`t'
   quietly replace between  = r(between_ge1) if statefip==`s' & wrkyr==`t'
   quietly replace within   = r(within_ge1)  if statefip==`s' & wrkyr==`t'
   quietly replace within_1 = r(ge1_1)       if statefip==`s' & wrkyr==`t'
   quietly replace within_2 = r(ge1_2)       if statefip==`s' & wrkyr==`t'
   display "Now running year " `t' " and state... " `s'
}
}
keep statefip wrkyr total between within within_1 within_2  
duplicates drop
sort statefip
save theil1978, replace

************
*** 1979 ***
************
use temporary, clear
keep if wrkyr==1979

levels statefip, local(state)
 levels wrkyr, local(time)
  foreach s of local state {
   foreach t of local time {
   quietly ineqdeco Y [aw = _perwt]          if statefip==`s' & wrkyr==`t', bygroup(group)
   quietly replace total    = r(ge1)         if statefip==`s' & wrkyr==`t'
   quietly replace between  = r(between_ge1) if statefip==`s' & wrkyr==`t'
   quietly replace within   = r(within_ge1)  if statefip==`s' & wrkyr==`t'
   quietly replace within_1 = r(ge1_1)       if statefip==`s' & wrkyr==`t'
   quietly replace within_2 = r(ge1_2)       if statefip==`s' & wrkyr==`t'
   display "Now running year " `t' " and state... " `s'
}
}
keep statefip wrkyr total between within within_1 within_2  
duplicates drop
sort statefip
save theil1979, replace

************
*** 1980 ***
************
use temporary, clear
keep if wrkyr==1980

levels statefip, local(state)
 levels wrkyr, local(time)
  foreach s of local state {
   foreach t of local time {
   quietly ineqdeco Y [aw = _perwt]          if statefip==`s' & wrkyr==`t', bygroup(group)
   quietly replace total    = r(ge1)         if statefip==`s' & wrkyr==`t'
   quietly replace between  = r(between_ge1) if statefip==`s' & wrkyr==`t'
   quietly replace within   = r(within_ge1)  if statefip==`s' & wrkyr==`t'
   quietly replace within_1 = r(ge1_1)       if statefip==`s' & wrkyr==`t'
   quietly replace within_2 = r(ge1_2)       if statefip==`s' & wrkyr==`t'
   display "Now running year " `t' " and state... " `s'
}
}
keep statefip wrkyr total between within within_1 within_2  
duplicates drop
sort statefip
save theil1980, replace


************
*** 1981 ***
************
use temporary, clear
keep if wrkyr==1981

levels statefip, local(state)
 levels wrkyr, local(time)
  foreach s of local state {
   foreach t of local time {
   quietly ineqdeco Y [aw = _perwt]          if statefip==`s' & wrkyr==`t', bygroup(group)
   quietly replace total    = r(ge1)         if statefip==`s' & wrkyr==`t'
   quietly replace between  = r(between_ge1) if statefip==`s' & wrkyr==`t'
   quietly replace within   = r(within_ge1)  if statefip==`s' & wrkyr==`t'
   quietly replace within_1 = r(ge1_1)       if statefip==`s' & wrkyr==`t'
   quietly replace within_2 = r(ge1_2)       if statefip==`s' & wrkyr==`t'
   display "Now running year " `t' " and state... " `s'
}
}
keep statefip wrkyr total between within within_1 within_2  
duplicates drop
sort statefip
save theil1981, replace

************
*** 1982 ***
************
use temporary, clear
keep if wrkyr==1982

levels statefip, local(state)
 levels wrkyr, local(time)
  foreach s of local state {
   foreach t of local time {
   quietly ineqdeco Y [aw = _perwt]          if statefip==`s' & wrkyr==`t', bygroup(group)
   quietly replace total    = r(ge1)         if statefip==`s' & wrkyr==`t'
   quietly replace between  = r(between_ge1) if statefip==`s' & wrkyr==`t'
   quietly replace within   = r(within_ge1)  if statefip==`s' & wrkyr==`t'
   quietly replace within_1 = r(ge1_1)       if statefip==`s' & wrkyr==`t'
   quietly replace within_2 = r(ge1_2)       if statefip==`s' & wrkyr==`t'
   display "Now running year " `t' " and state... " `s'
}
}
keep statefip wrkyr total between within within_1 within_2  
duplicates drop
sort statefip
save theil1982, replace

************
*** 1983 ***
************
use temporary, clear
keep if wrkyr==1983

levels statefip, local(state)
 levels wrkyr, local(time)
  foreach s of local state {
   foreach t of local time {
   quietly ineqdeco Y [aw = _perwt]          if statefip==`s' & wrkyr==`t', bygroup(group)
   quietly replace total    = r(ge1)         if statefip==`s' & wrkyr==`t'
   quietly replace between  = r(between_ge1) if statefip==`s' & wrkyr==`t'
   quietly replace within   = r(within_ge1)  if statefip==`s' & wrkyr==`t'
   quietly replace within_1 = r(ge1_1)       if statefip==`s' & wrkyr==`t'
   quietly replace within_2 = r(ge1_2)       if statefip==`s' & wrkyr==`t'
   display "Now running year " `t' " and state... " `s'
}
}
keep statefip wrkyr total between within within_1 within_2  
duplicates drop
sort statefip
save theil1983, replace

************
*** 1984 ***
************
use temporary, clear
keep if wrkyr==1984

levels statefip, local(state)
 levels wrkyr, local(time)
  foreach s of local state {
   foreach t of local time {
   quietly ineqdeco Y [aw = _perwt]          if statefip==`s' & wrkyr==`t', bygroup(group)
   quietly replace total    = r(ge1)         if statefip==`s' & wrkyr==`t'
   quietly replace between  = r(between_ge1) if statefip==`s' & wrkyr==`t'
   quietly replace within   = r(within_ge1)  if statefip==`s' & wrkyr==`t'
   quietly replace within_1 = r(ge1_1)       if statefip==`s' & wrkyr==`t'
   quietly replace within_2 = r(ge1_2)       if statefip==`s' & wrkyr==`t'
   display "Now running year " `t' " and state... " `s'
}
}
keep statefip wrkyr total between within within_1 within_2  
duplicates drop
sort statefip
save theil1984, replace

************
*** 1985 ***
************
use temporary, clear
keep if wrkyr==1985

levels statefip, local(state)
 levels wrkyr, local(time)
  foreach s of local state {
   foreach t of local time {
   quietly ineqdeco Y [aw = _perwt]          if statefip==`s' & wrkyr==`t', bygroup(group)
   quietly replace total    = r(ge1)         if statefip==`s' & wrkyr==`t'
   quietly replace between  = r(between_ge1) if statefip==`s' & wrkyr==`t'
   quietly replace within   = r(within_ge1)  if statefip==`s' & wrkyr==`t'
   quietly replace within_1 = r(ge1_1)       if statefip==`s' & wrkyr==`t'
   quietly replace within_2 = r(ge1_2)       if statefip==`s' & wrkyr==`t'
   display "Now running year " `t' " and state... " `s'
}
}
keep statefip wrkyr total between within within_1 within_2  
duplicates drop
sort statefip
save theil1985, replace

************
*** 1986 ***
************
use temporary, clear
keep if wrkyr==1986

levels statefip, local(state)
 levels wrkyr, local(time)
  foreach s of local state {
   foreach t of local time {
   quietly ineqdeco Y [aw = _perwt]          if statefip==`s' & wrkyr==`t', bygroup(group)
   quietly replace total    = r(ge1)         if statefip==`s' & wrkyr==`t'
   quietly replace between  = r(between_ge1) if statefip==`s' & wrkyr==`t'
   quietly replace within   = r(within_ge1)  if statefip==`s' & wrkyr==`t'
   quietly replace within_1 = r(ge1_1)       if statefip==`s' & wrkyr==`t'
   quietly replace within_2 = r(ge1_2)       if statefip==`s' & wrkyr==`t'
   display "Now running year " `t' " and state... " `s'
}
}
keep statefip wrkyr total between within within_1 within_2  
duplicates drop
sort statefip
save theil1986, replace

************
*** 1987 ***
************
use temporary, clear
keep if wrkyr==1987

levels statefip, local(state)
 levels wrkyr, local(time)
  foreach s of local state {
   foreach t of local time {
   quietly ineqdeco Y [aw = _perwt]          if statefip==`s' & wrkyr==`t', bygroup(group)
   quietly replace total    = r(ge1)         if statefip==`s' & wrkyr==`t'
   quietly replace between  = r(between_ge1) if statefip==`s' & wrkyr==`t'
   quietly replace within   = r(within_ge1)  if statefip==`s' & wrkyr==`t'
   quietly replace within_1 = r(ge1_1)       if statefip==`s' & wrkyr==`t'
   quietly replace within_2 = r(ge1_2)       if statefip==`s' & wrkyr==`t'
   display "Now running year " `t' " and state... " `s'
}
}
keep statefip wrkyr total between within within_1 within_2  
duplicates drop
sort statefip
save theil1987, replace

************
*** 1988 ***
************
use temporary, clear
keep if wrkyr==1988

levels statefip, local(state)
 levels wrkyr, local(time)
  foreach s of local state {
   foreach t of local time {
   quietly ineqdeco Y [aw = _perwt]          if statefip==`s' & wrkyr==`t', bygroup(group)
   quietly replace total    = r(ge1)         if statefip==`s' & wrkyr==`t'
   quietly replace between  = r(between_ge1) if statefip==`s' & wrkyr==`t'
   quietly replace within   = r(within_ge1)  if statefip==`s' & wrkyr==`t'
   quietly replace within_1 = r(ge1_1)       if statefip==`s' & wrkyr==`t'
   quietly replace within_2 = r(ge1_2)       if statefip==`s' & wrkyr==`t'
   display "Now running year " `t' " and state... " `s'
}
}
keep statefip wrkyr total between within within_1 within_2  
duplicates drop
sort statefip
save theil1988, replace

************
*** 1989 ***
************
use temporary, clear
keep if wrkyr==1989

levels statefip, local(state)
 levels wrkyr, local(time)
  foreach s of local state {
   foreach t of local time {
   quietly ineqdeco Y [aw = _perwt]          if statefip==`s' & wrkyr==`t', bygroup(group)
   quietly replace total    = r(ge1)         if statefip==`s' & wrkyr==`t'
   quietly replace between  = r(between_ge1) if statefip==`s' & wrkyr==`t'
   quietly replace within   = r(within_ge1)  if statefip==`s' & wrkyr==`t'
   quietly replace within_1 = r(ge1_1)       if statefip==`s' & wrkyr==`t'
   quietly replace within_2 = r(ge1_2)       if statefip==`s' & wrkyr==`t'
   display "Now running year " `t' " and state... " `s'
}
}
keep statefip wrkyr total between within within_1 within_2  
duplicates drop
sort statefip
save theil1989, replace

************
*** 1990 ***
************
use temporary, clear
keep if wrkyr==1990

levels statefip, local(state)
 levels wrkyr, local(time)
  foreach s of local state {
   foreach t of local time {
   quietly ineqdeco Y [aw = _perwt]          if statefip==`s' & wrkyr==`t', bygroup(group)
   quietly replace total    = r(ge1)         if statefip==`s' & wrkyr==`t'
   quietly replace between  = r(between_ge1) if statefip==`s' & wrkyr==`t'
   quietly replace within   = r(within_ge1)  if statefip==`s' & wrkyr==`t'
   quietly replace within_1 = r(ge1_1)       if statefip==`s' & wrkyr==`t'
   quietly replace within_2 = r(ge1_2)       if statefip==`s' & wrkyr==`t'
   display "Now running year " `t' " and state... " `s'
}
}
keep statefip wrkyr total between within within_1 within_2  
duplicates drop
sort statefip
save theil1990, replace

************
*** 1991 ***
************
use temporary, clear
keep if wrkyr==1991

levels statefip, local(state)
 levels wrkyr, local(time)
  foreach s of local state {
   foreach t of local time {
   quietly ineqdeco Y [aw = _perwt]          if statefip==`s' & wrkyr==`t', bygroup(group)
   quietly replace total    = r(ge1)         if statefip==`s' & wrkyr==`t'
   quietly replace between  = r(between_ge1) if statefip==`s' & wrkyr==`t'
   quietly replace within   = r(within_ge1)  if statefip==`s' & wrkyr==`t'
   quietly replace within_1 = r(ge1_1)       if statefip==`s' & wrkyr==`t'
   quietly replace within_2 = r(ge1_2)       if statefip==`s' & wrkyr==`t'
   display "Now running year " `t' " and state... " `s'
}
}
keep statefip wrkyr total between within within_1 within_2  
duplicates drop
sort statefip
save theil1991, replace

************
*** 1992 ***
************
use temporary, clear
keep if wrkyr==1992

levels statefip, local(state)
 levels wrkyr, local(time)
  foreach s of local state {
   foreach t of local time {
   quietly ineqdeco Y [aw = _perwt]          if statefip==`s' & wrkyr==`t', bygroup(group)
   quietly replace total    = r(ge1)         if statefip==`s' & wrkyr==`t'
   quietly replace between  = r(between_ge1) if statefip==`s' & wrkyr==`t'
   quietly replace within   = r(within_ge1)  if statefip==`s' & wrkyr==`t'
   quietly replace within_1 = r(ge1_1)       if statefip==`s' & wrkyr==`t'
   quietly replace within_2 = r(ge1_2)       if statefip==`s' & wrkyr==`t'
   display "Now running year " `t' " and state... " `s'
}
}
keep statefip wrkyr total between within within_1 within_2  
duplicates drop
sort statefip
save theil1992, replace

************
*** 1993 ***
************
use temporary, clear
keep if wrkyr==1993

levels statefip, local(state)
 levels wrkyr, local(time)
  foreach s of local state {
   foreach t of local time {
   quietly ineqdeco Y [aw = _perwt]          if statefip==`s' & wrkyr==`t', bygroup(group)
   quietly replace total    = r(ge1)         if statefip==`s' & wrkyr==`t'
   quietly replace between  = r(between_ge1) if statefip==`s' & wrkyr==`t'
   quietly replace within   = r(within_ge1)  if statefip==`s' & wrkyr==`t'
   quietly replace within_1 = r(ge1_1)       if statefip==`s' & wrkyr==`t'
   quietly replace within_2 = r(ge1_2)       if statefip==`s' & wrkyr==`t'
   display "Now running year " `t' " and state... " `s'
}
}
keep statefip wrkyr total between within within_1 within_2  
duplicates drop
sort statefip
save theil1993, replace

************
*** 1994 ***
************
use temporary, clear
keep if wrkyr==1994

levels statefip, local(state)
 levels wrkyr, local(time)
  foreach s of local state {
   foreach t of local time {
   quietly ineqdeco Y [aw = _perwt]          if statefip==`s' & wrkyr==`t', bygroup(group)
   quietly replace total    = r(ge1)         if statefip==`s' & wrkyr==`t'
   quietly replace between  = r(between_ge1) if statefip==`s' & wrkyr==`t'
   quietly replace within   = r(within_ge1)  if statefip==`s' & wrkyr==`t'
   quietly replace within_1 = r(ge1_1)       if statefip==`s' & wrkyr==`t'
   quietly replace within_2 = r(ge1_2)       if statefip==`s' & wrkyr==`t'
   display "Now running year " `t' " and state... " `s'
}
}
keep statefip wrkyr total between within within_1 within_2  
duplicates drop
sort statefip
save theil1994, replace

************
*** 1995 ***
************
use temporary, clear
keep if wrkyr==1995

levels statefip, local(state)
 levels wrkyr, local(time)
  foreach s of local state {
   foreach t of local time {
   quietly ineqdeco Y [aw = _perwt]          if statefip==`s' & wrkyr==`t', bygroup(group)
   quietly replace total    = r(ge1)         if statefip==`s' & wrkyr==`t'
   quietly replace between  = r(between_ge1) if statefip==`s' & wrkyr==`t'
   quietly replace within   = r(within_ge1)  if statefip==`s' & wrkyr==`t'
   quietly replace within_1 = r(ge1_1)       if statefip==`s' & wrkyr==`t'
   quietly replace within_2 = r(ge1_2)       if statefip==`s' & wrkyr==`t'
   display "Now running year " `t' " and state... " `s'
}
}
keep statefip wrkyr total between within within_1 within_2  
duplicates drop
sort statefip
save theil1995, replace

************
*** 1996 ***
************
use temporary, clear
keep if wrkyr==1996

levels statefip, local(state)
 levels wrkyr, local(time)
  foreach s of local state {
   foreach t of local time {
   quietly ineqdeco Y [aw = _perwt]          if statefip==`s' & wrkyr==`t', bygroup(group)
   quietly replace total    = r(ge1)         if statefip==`s' & wrkyr==`t'
   quietly replace between  = r(between_ge1) if statefip==`s' & wrkyr==`t'
   quietly replace within   = r(within_ge1)  if statefip==`s' & wrkyr==`t'
   quietly replace within_1 = r(ge1_1)       if statefip==`s' & wrkyr==`t'
   quietly replace within_2 = r(ge1_2)       if statefip==`s' & wrkyr==`t'
   display "Now running year " `t' " and state... " `s'
}
}
keep statefip wrkyr total between within within_1 within_2  
duplicates drop
sort statefip
save theil1996, replace

************
*** 1997 ***
************
use temporary, clear
keep if wrkyr==1997

levels statefip, local(state)
 levels wrkyr, local(time)
  foreach s of local state {
   foreach t of local time {
   quietly ineqdeco Y [aw = _perwt]          if statefip==`s' & wrkyr==`t', bygroup(group)
   quietly replace total    = r(ge1)         if statefip==`s' & wrkyr==`t'
   quietly replace between  = r(between_ge1) if statefip==`s' & wrkyr==`t'
   quietly replace within   = r(within_ge1)  if statefip==`s' & wrkyr==`t'
   quietly replace within_1 = r(ge1_1)       if statefip==`s' & wrkyr==`t'
   quietly replace within_2 = r(ge1_2)       if statefip==`s' & wrkyr==`t'
   display "Now running year " `t' " and state... " `s'
}
}
keep statefip wrkyr total between within within_1 within_2  
duplicates drop
sort statefip
save theil1997, replace

************
*** 1998 ***
************
use temporary, clear
keep if wrkyr==1998

levels statefip, local(state)
 levels wrkyr, local(time)
  foreach s of local state {
   foreach t of local time {
   quietly ineqdeco Y [aw = _perwt]          if statefip==`s' & wrkyr==`t', bygroup(group)
   quietly replace total    = r(ge1)         if statefip==`s' & wrkyr==`t'
   quietly replace between  = r(between_ge1) if statefip==`s' & wrkyr==`t'
   quietly replace within   = r(within_ge1)  if statefip==`s' & wrkyr==`t'
   quietly replace within_1 = r(ge1_1)       if statefip==`s' & wrkyr==`t'
   quietly replace within_2 = r(ge1_2)       if statefip==`s' & wrkyr==`t'
   display "Now running year " `t' " and state... " `s'
}
}
keep statefip wrkyr total between within within_1 within_2  
duplicates drop
sort statefip
save theil1998, replace

************
*** 1999 ***
************
use temporary, clear
keep if wrkyr==1999

levels statefip, local(state)
 levels wrkyr, local(time)
  foreach s of local state {
   foreach t of local time {
   quietly ineqdeco Y [aw = _perwt]          if statefip==`s' & wrkyr==`t', bygroup(group)
   quietly replace total    = r(ge1)         if statefip==`s' & wrkyr==`t'
   quietly replace between  = r(between_ge1) if statefip==`s' & wrkyr==`t'
   quietly replace within   = r(within_ge1)  if statefip==`s' & wrkyr==`t'
   quietly replace within_1 = r(ge1_1)       if statefip==`s' & wrkyr==`t'
   quietly replace within_2 = r(ge1_2)       if statefip==`s' & wrkyr==`t'
   display "Now running year " `t' " and state... " `s'
}
}
keep statefip wrkyr total between within within_1 within_2  
duplicates drop
sort statefip
save theil1999, replace

************
*** 2000 ***
************
use temporary, clear
keep if wrkyr==2000

levels statefip, local(state)
 levels wrkyr, local(time)
  foreach s of local state {
   foreach t of local time {
   quietly ineqdeco Y [aw = _perwt]          if statefip==`s' & wrkyr==`t', bygroup(group)
   quietly replace total    = r(ge1)         if statefip==`s' & wrkyr==`t'
   quietly replace between  = r(between_ge1) if statefip==`s' & wrkyr==`t'
   quietly replace within   = r(within_ge1)  if statefip==`s' & wrkyr==`t'
   quietly replace within_1 = r(ge1_1)       if statefip==`s' & wrkyr==`t'
   quietly replace within_2 = r(ge1_2)       if statefip==`s' & wrkyr==`t'
   display "Now running year " `t' " and state... " `s'
}
}
keep statefip wrkyr total between within within_1 within_2  
duplicates drop
sort statefip
save theil2000, replace

************
*** 2001 ***
************
use temporary, clear
keep if wrkyr==2001

levels statefip, local(state)
 levels wrkyr, local(time)
  foreach s of local state {
   foreach t of local time {
   quietly ineqdeco Y [aw = _perwt]          if statefip==`s' & wrkyr==`t', bygroup(group)
   quietly replace total    = r(ge1)         if statefip==`s' & wrkyr==`t'
   quietly replace between  = r(between_ge1) if statefip==`s' & wrkyr==`t'
   quietly replace within   = r(within_ge1)  if statefip==`s' & wrkyr==`t'
   quietly replace within_1 = r(ge1_1)       if statefip==`s' & wrkyr==`t'
   quietly replace within_2 = r(ge1_2)       if statefip==`s' & wrkyr==`t'
   display "Now running year " `t' " and state... " `s'
}
}
keep statefip wrkyr total between within within_1 within_2  
duplicates drop
sort statefip
save theil2001, replace

************
*** 2002 ***
************
use temporary, clear
keep if wrkyr==2002

levels statefip, local(state)
 levels wrkyr, local(time)
  foreach s of local state {
   foreach t of local time {
   quietly ineqdeco Y [aw = _perwt]          if statefip==`s' & wrkyr==`t', bygroup(group)
   quietly replace total    = r(ge1)         if statefip==`s' & wrkyr==`t'
   quietly replace between  = r(between_ge1) if statefip==`s' & wrkyr==`t'
   quietly replace within   = r(within_ge1)  if statefip==`s' & wrkyr==`t'
   quietly replace within_1 = r(ge1_1)       if statefip==`s' & wrkyr==`t'
   quietly replace within_2 = r(ge1_2)       if statefip==`s' & wrkyr==`t'
   display "Now running year " `t' " and state... " `s'
}
}
keep statefip wrkyr total between within within_1 within_2  
duplicates drop
sort statefip
save theil2002, replace

************
*** 2003 ***
************
use temporary, clear
keep if wrkyr==2003

levels statefip, local(state)
 levels wrkyr, local(time)
  foreach s of local state {
   foreach t of local time {
   quietly ineqdeco Y [aw = _perwt]          if statefip==`s' & wrkyr==`t', bygroup(group)
   quietly replace total    = r(ge1)         if statefip==`s' & wrkyr==`t'
   quietly replace between  = r(between_ge1) if statefip==`s' & wrkyr==`t'
   quietly replace within   = r(within_ge1)  if statefip==`s' & wrkyr==`t'
   quietly replace within_1 = r(ge1_1)       if statefip==`s' & wrkyr==`t'
   quietly replace within_2 = r(ge1_2)       if statefip==`s' & wrkyr==`t'
   display "Now running year " `t' " and state... " `s'
}
}
keep statefip wrkyr total between within within_1 within_2  
duplicates drop
sort statefip
save theil2003, replace

************
*** 2004 ***
************
use temporary, clear
keep if wrkyr==2004

levels statefip, local(state)
 levels wrkyr, local(time)
  foreach s of local state {
   foreach t of local time {
   quietly ineqdeco Y [aw = _perwt]          if statefip==`s' & wrkyr==`t', bygroup(group)
   quietly replace total    = r(ge1)         if statefip==`s' & wrkyr==`t'
   quietly replace between  = r(between_ge1) if statefip==`s' & wrkyr==`t'
   quietly replace within   = r(within_ge1)  if statefip==`s' & wrkyr==`t'
   quietly replace within_1 = r(ge1_1)       if statefip==`s' & wrkyr==`t'
   quietly replace within_2 = r(ge1_2)       if statefip==`s' & wrkyr==`t'
   display "Now running year " `t' " and state... " `s'
}
}
keep statefip wrkyr total between within within_1 within_2  
duplicates drop
sort statefip
save theil2004, replace

************
*** 2005 ***
************
use temporary, clear
keep if wrkyr==2005

levels statefip, local(state)
 levels wrkyr, local(time)
  foreach s of local state {
   foreach t of local time {
   quietly ineqdeco Y [aw = _perwt]          if statefip==`s' & wrkyr==`t', bygroup(group)
   quietly replace total    = r(ge1)         if statefip==`s' & wrkyr==`t'
   quietly replace between  = r(between_ge1) if statefip==`s' & wrkyr==`t'
   quietly replace within   = r(within_ge1)  if statefip==`s' & wrkyr==`t'
   quietly replace within_1 = r(ge1_1)       if statefip==`s' & wrkyr==`t'
   quietly replace within_2 = r(ge1_2)       if statefip==`s' & wrkyr==`t'
   display "Now running year " `t' " and state... " `s'
}
}
keep statefip wrkyr total between within within_1 within_2  
duplicates drop
sort statefip
save theil2005, replace

************
*** 2006 ***
************
use temporary, clear
keep if wrkyr==2006

levels statefip, local(state)
 levels wrkyr, local(time)
  foreach s of local state {
   foreach t of local time {
   quietly ineqdeco Y [aw = _perwt]          if statefip==`s' & wrkyr==`t', bygroup(group)
   quietly replace total    = r(ge1)         if statefip==`s' & wrkyr==`t'
   quietly replace between  = r(between_ge1) if statefip==`s' & wrkyr==`t'
   quietly replace within   = r(within_ge1)  if statefip==`s' & wrkyr==`t'
   quietly replace within_1 = r(ge1_1)       if statefip==`s' & wrkyr==`t'
   quietly replace within_2 = r(ge1_2)       if statefip==`s' & wrkyr==`t'
   display "Now running year " `t' " and state... " `s'
}
}
keep statefip wrkyr total between within within_1 within_2  
duplicates drop
sort statefip
save theil2006, replace

**********************************
*** POOLING ALL YEARS TOGETHER ***
**********************************
#delimit;
use theil1976, clear;
append using theil1977;
append using theil1978;
append using theil1979;
append using theil1980;
append using theil1981;
append using theil1982;
append using theil1983;
append using theil1984;
append using theil1985;
append using theil1986;
append using theil1987;
append using theil1988;
append using theil1989;
append using theil1990;
append using theil1991;
append using theil1992;
append using theil1993;
append using theil1994;
append using theil1995;
append using theil1996;
append using theil1997;
append using theil1998;
append using theil1999;
append using theil2000;
append using theil2001;
append using theil2002;
append using theil2003;
append using theil2004;
append using theil2005;
append using theil2006;
sort statefip wrkyr;
save Appendix_TableIXpanelB, replace;
erase theil1976.dta;
erase theil1977.dta;
erase theil1978.dta;
erase theil1979.dta;
erase theil1980.dta;
erase theil1981.dta;
erase theil1982.dta;
erase theil1983.dta;
erase theil1984.dta;
erase theil1985.dta;
erase theil1986.dta;
erase theil1987.dta;
erase theil1988.dta;
erase theil1989.dta;
erase theil1990.dta;
erase theil1991.dta;
erase theil1992.dta;
erase theil1993.dta;
erase theil1994.dta;
erase theil1995.dta;
erase theil1996.dta;
erase theil1997.dta;
erase theil1998.dta;
erase theil1999.dta;
erase theil2000.dta;
erase theil2001.dta;
erase theil2002.dta;
erase theil2003.dta;
erase theil2004.dta;
erase theil2005.dta;
erase theil2006.dta;


*******************************************************;
*** DECOMPOSING THE IMPACT OF DEREGULATION, PANEL A ***;
*******************************************************;
use "/home/alevkov/BeckLevineLevkov2010/data/macro_workfile.dta", clear;
sort statefip wrkyr;
merge statefip wrkyr using Appendix_TableIXpanelA;
drop _merge*;

drop if statefip==10;
drop if statefip==46;

tsset statefip wrkyr;

tabulate wrkyr, gen(wrkyr_dumm);

xtreg total _intra wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
estimates store m1, title(Total);

xtreg between _intra wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
estimates store m2, title(Between Groups);

xtreg within _intra wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
estimates store m3, title(Within Groups);

xtreg within_1 _intra wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
estimates store m4, title(Self Employed);

xtreg within_2 _intra wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
estimates store m5, title(Salaried);

estout m1 m2 m3 m4 m5 using Appendix_TableIX.txt, replace
keep(_intra)
cells(b(star fmt(4)) se(par) p(fmt(4) par({ }))) stats(r2 N, labels("R-squared" "Observations") fmt(2 0))
legend label collabel(none)
prehead("Decomposing the Impact of Deregulation on Income Inequality to Between- and Within-Groups")
posthead("Panel A: Decomposition by Ethnicity") prefoot("") 
postfoot("Note:")
starlevel(* 0.10 ** 0.05 *** 0.01) nolz nolegend;



*******************************************************;
*** DECOMPOSING THE IMPACT OF DEREGULATION, PANEL B ***;
*******************************************************;
use "/home/alevkov/BeckLevineLevkov2010/data/macro_workfile.dta", clear;
sort statefip wrkyr;
merge statefip wrkyr using Appendix_TableIXpanelB;
drop _merge*;

drop if statefip==10;
drop if statefip==46;

tsset statefip wrkyr;

tabulate wrkyr, gen(wrkyr_dumm);

xtreg total _intra wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
estimates store m1, title(Total);

xtreg between _intra wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
estimates store m2, title(Between Groups);

xtreg within _intra wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
estimates store m3, title(Within Groups);

xtreg within_1 _intra wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
estimates store m4, title(High School or Less);

xtreg within_2 _intra wrkyr_dumm*, fe i(statefip) robust cluster(statefip);
estimates store m5, title(Some College or More);

estout m1 m2 m3 m4 m5 using Appendix_TableIX.txt, append
keep(_intra)
cells(b(star fmt(4)) se(par) p(fmt(4) par({ }))) stats(r2 N, labels("R-squared" "Observations") fmt(2 0))
legend label collabel(none)
prehead("")
posthead("Panel B: Decomposition by Gender") prefoot("") 
postfoot("Note:")
starlevel(* 0.10 ** 0.05 *** 0.01) nolz nolegend;

erase temporary.dta;
log close;
