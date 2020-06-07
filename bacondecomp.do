```stata
clear

use "~/castle.dta"
set more off
*Summary
** generate state population weight
xtset sid year
bys sid: egen popwt=mean(population) 


*OLS fixeffects
global region r20001-r20104  //region-quarter fixed effects
global demo blackm_15_24 whitem_15_24 blackm_25_44 whitem_25_44 
global spending l_exp_subsidy l_exp_pubwelfare
global xvar l_police unemployrt poverty l_income l_prisoner l_lagprisoner $demo $spending
eststo: xtreg l_larceny $law i.year [aweight=popwt],fe vce(cluster sid)
eststo: xtreg l_larceny $law i.year $region [aweight=popwt],fe vce(cluster sid)
eststo: xtreg l_larceny $law i.year $region $xvar [aweight=popwt],fe vce(cluster sid)

*Bacon
bacondecomp l_larceny post l_pop l_income [aweight=popwt], stub(Bacon_) robust gropt(title("TEST GRAPH FOR BACONDECOMP") legend(pos(3) col(1))) mcolors(green)
bacondecomp l_larceny post, ddetail
```
