xtset pres_pm_codes ele_t

ssc install ivreg2h

gen women = ratio_women_cand_adopt
gen lnsala = lnsalary_am_kokuji
gen lnzaisei = ln_zaiseiryoku
gen lnpopu = ln_population 
gen nseats = n_seats_adopt
gen r75 = population_elderly75_ratio
gen r15 = population_child15_ratio 
gen lninc = ln_income_per
gen lnmenseki = ln_all_menseki
gen canlive = canlive_ratio_menseki
gen sigaika = sigaika_ratio_area
gen wrmusyo_p = win_ratio_musyozoku_pre
gen expired = expired_dummy
gen t2007 = touitsu_2007  
gen t2011 = touitsu_2011
gen t2015 = touitsu_2015
gen t2019 = touitsu_2019

ivreg2h ratio_women_cand_adopt lnsalary_am_kokuji ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all

ivreg2h ratio_women_cand_adopt n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all (lnsalary_am_kokuji =), small robust

ivreg2h ratio_women_cand_adopt ln_zaiseiryoku (lnsalary_am_kokuji =), small robust

ivreg2h women lnzaisei nendo* (lnsala=),small robust

ivreg2h women lnzaisei lnpopu nseats r75 r15 lninc lnmenseki canlive sigaika wrmusyo_p expired t2007 t2011 t2015 t2019 (lnsala = ), small robust

ivreg2h women lnzaisei lnpopu nseats r75 r15 lninc lnmenseki canlive sigaika wrmusyo_p expired t2007 t2011 t2015 t2019 nendo* (lnsala = ), small robust

rename nendo Nendo

sum lnsalary_am_kokuji
xtsum lnsalary_am_kokuji

**女性

sort pres_pm_codes
egen tmean_lnsalary=mean(lnsalary_am_kokuji), by(pres_pm_codes)

*preserve 
*collapse (mean) nendo*, by(pres_pm_codes)
*table nendo*, by(pres_pm_codes)
*restore

net install fhetprob, from(http://www.richard-bluhm.com/stata/)

fhetprob ratio_women_cand_adopt lnsalary_am_kokuji, het(lnsalary_am_kokuji)


fhetprob ratio_women_cand_adopt lnsalary_am_kokuji tmean_lnsalary, het(lnsalary_am_kokuji)
margins
margins, dydx(lnsalary_am_kokuji)

lnsalary_am_kokuji ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all i.nendo

sort pres_pm_codes
egen tmean_lnpopu=mean(ln_population), by(pres_pm_codes)
egen tmean_nseats=mean(n_seats_adopt), by(pres_pm_codes)
egen tmean_75ratio=mean(population_elderly75_ratio), by(pres_pm_codes)
egen tmean_15ratio=mean(population_child15_ratio), by(pres_pm_codes)
egen tmean_lnincome=mean(ln_income_per), by(pres_pm_codes)
egen tmean_lnmenseki=mean(ln_all_menseki), by(pres_pm_codes)
egen tmean_canlive=mean(canlive_ratio_menseki), by(pres_pm_codes)
egen tmean_sigaika=mean(sigaika_ratio_area), by(pres_pm_codes)
egen tmean_lnzaisei=mean(ln_zaiseiryoku), by(pres_pm_codes)
egen tmean_wmusyo_p=mean(win_ratio_musyozoku_pre), by(pres_pm_codes)
egen tmean_lnstaff=mean(ln_staff_all), by(pres_pm_codes)
egen tmean_expired=mean(expired_dummy), by(pres_pm_codes)

egen tmean_t2007=mean(touitsu_2007), by(pres_pm_codes)
egen tmean_t2011=mean(touitsu_2011), by(pres_pm_codes)
egen tmean_t2015=mean(touitsu_2015), by(pres_pm_codes)
egen tmean_t2019=mean(touitsu_2019), by(pres_pm_codes)

egen tmean_nendo1= mean(nendo1), by(pres_pm_codes)
egen tmean_nendo2= mean(nendo2), by(pres_pm_codes)
egen tmean_nendo3= mean(nendo3), by(pres_pm_codes)
egen tmean_nendo4= mean(nendo4), by(pres_pm_codes)
egen tmean_nendo5= mean(nendo5), by(pres_pm_codes)
egen tmean_nendo6= mean(nendo6), by(pres_pm_codes)
egen tmean_nendo7= mean(nendo7), by(pres_pm_codes)
egen tmean_nendo8= mean(nendo8) , by(pres_pm_codes)
egen tmean_nendo9= mean(nendo9), by(pres_pm_codes)
egen tmean_nendo10= mean(nendo10), by(pres_pm_codes)
egen tmean_nendo11= mean(nendo11), by(pres_pm_codes)
egen tmean_nendo12= mean(nendo12), by(pres_pm_codes)
egen tmean_nendo13= mean(nendo13), by(pres_pm_codes)
egen tmean_nendo14= mean(nendo14), by(pres_pm_codes)
egen tmean_nendo15= mean(nendo15), by(pres_pm_codes)

fhetprob ratio_women_cand_adopt lnsalary_am_kokuji ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all i.nendo tmean_*, het(lnsalary_am_kokuji)

tab ele_t if e(sample)==1

egen tobs = count(ele_id) if e(sample)==1, by(pres_pm_codes)
tab tobs

list ele_id if tobs == 4
list ele_id if (e(sample)==1)&(pres_pm=="鹿児島県阿久根市")

list ele_id if tobs == 1
list ele_id if (e(sample)==1)&(pres_pm=="北海道恵庭市")
** 問題なさそう

rename tobs tobs_women
tab tobs_women

fhetprob ratio_women_cand_adopt lnsalary_am_kokuji ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all i.nendo i.tobs_women tmean_*, het(i.tobs_women)

margins if e(sample) == 1, dydx(lnsalary_am_kokuji) 

egen lnsalary_sq2_wtm = mean(lnsalary_am_kokuji*lnsalary_am_kokuji) if e(sample) == 1, by(pres_pm_codes)
egen w_tmean_lnsalary=mean(lnsalary_am_kokuji) if e(sample) == 1, by(pres_pm_codes)
egen w_tmean_lnpopu=mean(ln_population) if e(sample) == 1, by(pres_pm_codes)
egen w_tmean_nseats=mean(n_seats_adopt) if e(sample) == 1, by(pres_pm_codes)
egen w_tmean_75ratio=mean(population_elderly75_ratio) if e(sample) == 1, by(pres_pm_codes)
egen w_tmean_15ratio=mean(population_child15_ratio) if e(sample) == 1, by(pres_pm_codes)
egen w_tmean_lnincome=mean(ln_income_per) if e(sample) == 1, by(pres_pm_codes)
egen w_tmean_lnmenseki=mean(ln_all_menseki) if e(sample) == 1, by(pres_pm_codes)
egen w_tmean_canlive=mean(canlive_ratio_menseki) if e(sample) == 1, by(pres_pm_codes)
egen w_tmean_sigaika=mean(sigaika_ratio_area) if e(sample) == 1, by(pres_pm_codes)
egen w_tmean_lnzaisei=mean(ln_zaiseiryoku) if e(sample) == 1, by(pres_pm_codes)
egen w_tmean_wmusyo_p=mean(win_ratio_musyozoku_pre) if e(sample) == 1, by(pres_pm_codes)
egen w_tmean_lnstaff=mean(ln_staff_all) if e(sample) == 1, by(pres_pm_codes)
egen w_tmean_expired=mean(expired_dummy) if e(sample) == 1, by(pres_pm_codes)

egen w_tmean_t2007=mean(touitsu_2007) if e(sample) == 1, by(pres_pm_codes)
egen w_tmean_t2011=mean(touitsu_2011) if e(sample) == 1, by(pres_pm_codes)
egen w_tmean_t2015=mean(touitsu_2015) if e(sample) == 1, by(pres_pm_codes)
egen w_tmean_t2019=mean(touitsu_2019) if e(sample) == 1, by(pres_pm_codes)

egen w_tmean_nendo1= mean(nendo1) if e(sample) == 1, by(pres_pm_codes)
egen w_tmean_nendo2= mean(nendo2) if e(sample) == 1, by(pres_pm_codes)
egen w_tmean_nendo3= mean(nendo3) if e(sample) == 1, by(pres_pm_codes)
egen w_tmean_nendo4= mean(nendo4) if e(sample) == 1, by(pres_pm_codes)
egen w_tmean_nendo5= mean(nendo5) if e(sample) == 1, by(pres_pm_codes)
egen w_tmean_nendo6= mean(nendo6) if e(sample) == 1, by(pres_pm_codes)
egen w_tmean_nendo7= mean(nendo7) if e(sample) == 1, by(pres_pm_codes)
egen w_tmean_nendo8= mean(nendo8) if e(sample) == 1, by(pres_pm_codes)
egen w_tmean_nendo9= mean(nendo9) if e(sample) == 1, by(pres_pm_codes)
egen w_tmean_nendo10= mean(nendo10) if e(sample) == 1, by(pres_pm_codes)
egen w_tmean_nendo11= mean(nendo11) if e(sample) == 1, by(pres_pm_codes)
egen w_tmean_nendo12= mean(nendo12) if e(sample) == 1, by(pres_pm_codes)
egen w_tmean_nendo13= mean(nendo13) if e(sample) == 1, by(pres_pm_codes)
egen w_tmean_nendo14= mean(nendo14) if e(sample) == 1, by(pres_pm_codes)
egen w_tmean_nendo15= mean(nendo15) if e(sample) == 1, by(pres_pm_codes)


estimates clear
** pooled
fracreg probit ratio_women_cand_adopt lnsalary_am_kokuji ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all

estimates store r1, title("FQML")
estadd local municipality "No": r1
estadd local year "No": r1

margins if e(sample) == 1, dydx(lnsalary_am_kokuji) 

fracreg probit ratio_women_cand_adopt c.lnsalary_am_kokuji##c.lnsalary_am_kokuji ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all

margins if e(sample) == 1, dydx(lnsalary_am_kokuji)

estimates store r6, title("FQML")
estadd local municipality "No": r6
estadd local year "No": r6

margins if e(sample) == 1, dydx(lnsalary_am_kokuji) at(lnsalary_am_kokuji = (6.5 7 7.5 8 8.5 9))
marginsplot




** correlated re, balanced assumption
program women_boot, rclass

glm ratio_women_cand_adopt c.lnsalary_am_kokuji##c.lnsalary_am_kokuji ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all i.nendo i.tobs_women w_tmean_* lnsalary_sq2_wtm, fa(bin) link(probit) cluster(pres_pm_codes)

predict x1b1hat, xb
gen scale=normalden(x1b1hat)
gen pe1=scale*(_b[lnsalary_am_kokuji] + 2*lnsalary_am_kokuji*_b[c.lnsalary_am_kokuji#c.lnsalary_am_kokuji])
summarize pe1
return scalar ape1=r(mean)

drop x1b1hat scale pe1
end

glm ratio_women_cand_adopt lnsalary_am_kokuji ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all i.nendo i.tobs_women w_tmean_*, fa(bin) link(probit) cluster(pres_pm_codes)
estimates store r2, title("FQMLCR")
estadd local municipality "Yes": r2
estadd local year "Yes": r2

glm ratio_women_cand_adopt c.lnsalary_am_kokuji##c.lnsalary_am_kokuji ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all i.nendo i.tobs_women w_tmean_*, fa(bin) link(probit) cluster(pres_pm_codes)



glm ratio_women_cand_adopt c.lnsalary_am_kokuji##c.lnsalary_am_kokuji ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all i.nendo i.tobs_women w_tmean_* lnsalary_sq2_wtm, fa(bin) link(probit) cluster(pres_pm_codes)
estimates store r5, title("FQMLCR")
estadd local municipality "Yes": r5
estadd local year "Yes": r5
**消えた

*Bootstrapped SE within districts
bootstrap r(ape1), reps(500) seed(123) cluster(pres_pm_codes) : women_boot

program drop  women_boot


**correlated re
fhetprob ratio_women_cand_adopt lnsalary_am_kokuji ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all i.nendo i.tobs_women w_tmean_*, het(i.tobs_women)
estimates store r3, title("FQMLH")
estadd local municipality "Yes": r3
estadd local year "Yes": r3
margins if e(sample) == 1, dydx(lnsalary_am_kokuji)

fhetprob ratio_women_cand_adopt c.lnsalary_am_kokuji##c.lnsalary_am_kokuji ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all i.nendo i.tobs_women w_tmean_*, het(i.tobs_women)


fhetprob ratio_women_cand_adopt c.lnsalary_am_kokuji##c.lnsalary_am_kokuji ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all i.nendo i.tobs_women w_tmean_* lnsalary_sq2_wtm, het(i.tobs_women)
estimates store r4, title("FQMLH")
estadd local municipality "Yes": r4
estadd local year "Yes": r4
margins if e(sample) == 1, dydx(lnsalary_am_kokuji)

margins if e(sample) == 1, dydx(lnsalary_am_kokuji) at(lnsalary_am_kokuji = (6.5 7 7.5 8 8.5 9))


margins if e(sample) == 1, dydx(lnsalary_am_kokuji) at(lnsalary_am_kokuji = (6.5 7 7.5 8 8.5 9))
marginsplot

fhetprob ratio_women_cand_adopt lnsalary_am_kokuji ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all, het(lnsalary_am_kokuji)



esttab r1 r2 r3 r6 r5 r4 using "women_frac_rev.tex", replace ///
b(3) se(3) star(* 0.10 ** 0.05 *** 0.01) booktabs ///
drop(touitsu_2007 _cons *.nendo *.tobs_women w_tmean_*) nogaps ///
stats(year municipality N, fmt(%9.0f %9.0f %9.0f) labels("年度固定効果" "自治体固定効果" "観測数")) ///
label nolz varwidth(16) modelwidth(13) style(tex)  ///
title(被説明変数: 立候補者女性割合) coeflabels(lnsalary_am_kokuji "対数議員報酬額"　lnsalary_am_kokuji#lnsalary_am_kokuji "対数議員報酬額 2乗" /// 
ln_population "対数人口" n_seats_adopt "議席数" population_elderly75_ratio "全人口に占める75歳以上の割合" population_child15_ratio "全人口に占める15歳未満の割合"  ///
ln_income_per "納税者1人あたり課税対象所得" ln_all_menseki "対数面積" canlive_ratio_menseki "可住地面積割合" sigaika_ratio_area "市街化区域面積割合" ln_zaiseiryoku ///
"対数財政力指数" win_ratio_musyozoku_pre "前回当選者に占める無所属の割合" ln_staff_all "対数自治体職員数" ///
age_mean_cand "立候補者平均年齢" cand_ratio_musyozoku "立候補者無所属割合"ratio_women_cand_adopt "立候補者女性割合" compe_rate_adopt "1議席あたり立候補者数" touitsu_2011 "2011年統一選ダミー" touitsu_2015 "2015年統一選ダミー" touitsu_2019 "2019年統一選ダミー" expired_dummy "任期満了ダミー") ///
order(lnsalary_am_kokuji lnsalary_am_kokuji#lnsalary_am_kokuji) ///
mlabels(, span prefix(\multicolumn{@span}{c}{) suffix(})) ///
prehead("\documentclass[11pt]{jsarticle}" "\pagestyle{empty}" "\usepackage{booktabs}""\usepackage{siunitx}""\usepackage{lscape}" ///
"\usepackage[margin=20truemm]{geometry}""\sisetup{input-symbols = ()}""\begin{document}""\begin{table}\caption{@title}" ///
"\def\sym#1{\ifmmode^{#1}\else\(^{#1}\)\fi}""\begin{center}" ///
"\sisetup{table-space-text-post = \sym{***}}""\begin{tabular}{l*{@M}{llll}}""\toprule") posthead(\midrule) prefoot(\midrule) ///
postfoot("\bottomrule""\end{tabular}""\end{center}""\end{table}""\end{document}")

**投票率

*not include
xtreg voting_rate_isna lnsalary_am_kokuji ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku ln_staff_all win_ratio_musyozoku_pre age_mean_cand cand_ratio_musyozoku compe_rate_adopt ratio_women_cand_adopt expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019, fe vce(cluster pres_pm_codes)

fhetprob voting_rate_isna lnsalary_am_kokuji i.cate_change_salary ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all i.nendo tmean_*, het(lnsalary_am_kokuji)
*not concave

gen voting_rate_p = voting_rate_isna*0.01
sum voting_rate_p

fracreg probit voting_rate_p lnsalary_am_kokuji i.cate_change_salary ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all i.nendo , vce(cluster pres_pm_codes)
*レベルに対してプラス

fhetprob voting_rate_p lnsalary_am_kokuji i.cate_change_salary ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all i.nendo tmean_*, het(lnsalary_am_kokuji)
*消えた

egen tobs_vot = count(ele_id) if e(sample)==1, by(pres_pm_codes)
tab tobs_vot

tab tobs_vot tobs_women

count voting_rate_p if e(sample)==1

sort pres_pm_codes
egen v_tmean_lnsalary=mean(lnsalary_am_kokuji) if e(sample) == 1, by(pres_pm_codes)
egen v_tmean_upsalary=mean(dummy_up_salary) if e(sample) == 1, by(pres_pm_codes)
egen v_tmean_dnsalary=mean(dummy_down_salary) if e(sample) == 1, by(pres_pm_codes)
egen v_tmean_lnpopu=mean(ln_population) if e(sample) == 1, by(pres_pm_codes)
egen v_tmean_nseats=mean(n_seats_adopt) if e(sample) == 1, by(pres_pm_codes)
egen v_tmean_75ratio=mean(population_elderly75_ratio) if e(sample) == 1, by(pres_pm_codes)
egen v_tmean_15ratio=mean(population_child15_ratio) if e(sample) == 1, by(pres_pm_codes)
egen v_tmean_lnincome=mean(ln_income_per) if e(sample) == 1, by(pres_pm_codes)
egen v_tmean_lnmenseki=mean(ln_all_menseki) if e(sample) == 1, by(pres_pm_codes)
egen v_tmean_canlive=mean(canlive_ratio_menseki) if e(sample) == 1, by(pres_pm_codes)
egen v_tmean_sigaika=mean(sigaika_ratio_area) if e(sample) == 1, by(pres_pm_codes)
egen v_tmean_lnzaisei=mean(ln_zaiseiryoku) if e(sample) == 1, by(pres_pm_codes)
egen v_tmean_wmusyo_p=mean(win_ratio_musyozoku_pre) if e(sample) == 1, by(pres_pm_codes)
egen v_tmean_lnstaff=mean(ln_staff_all) if e(sample) == 1, by(pres_pm_codes)
egen v_tmean_expired=mean(expired_dummy) if e(sample) == 1, by(pres_pm_codes)

egen v_tmean_t2007=mean(touitsu_2007) if e(sample) == 1, by(pres_pm_codes)
egen v_tmean_t2011=mean(touitsu_2011) if e(sample) == 1, by(pres_pm_codes)
egen v_tmean_t2015=mean(touitsu_2015) if e(sample) == 1, by(pres_pm_codes)
egen v_tmean_t2019=mean(touitsu_2019) if e(sample) == 1, by(pres_pm_codes)

egen v_tmean_nendo1= mean(nendo1) if e(sample) == 1, by(pres_pm_codes)
egen v_tmean_nendo2= mean(nendo2) if e(sample) == 1, by(pres_pm_codes)
egen v_tmean_nendo3= mean(nendo3) if e(sample) == 1, by(pres_pm_codes)
egen v_tmean_nendo4= mean(nendo4) if e(sample) == 1, by(pres_pm_codes)
egen v_tmean_nendo5= mean(nendo5) if e(sample) == 1, by(pres_pm_codes)
egen v_tmean_nendo6= mean(nendo6) if e(sample) == 1, by(pres_pm_codes)
egen v_tmean_nendo7= mean(nendo7) if e(sample) == 1, by(pres_pm_codes)
egen v_tmean_nendo8= mean(nendo8) if e(sample) == 1, by(pres_pm_codes)
egen v_tmean_nendo9= mean(nendo9) if e(sample) == 1, by(pres_pm_codes)
egen v_tmean_nendo10= mean(nendo10) if e(sample) == 1, by(pres_pm_codes)
egen v_tmean_nendo11= mean(nendo11) if e(sample) == 1, by(pres_pm_codes)
egen v_tmean_nendo12= mean(nendo12) if e(sample) == 1, by(pres_pm_codes)
egen v_tmean_nendo13= mean(nendo13) if e(sample) == 1, by(pres_pm_codes)
egen v_tmean_nendo14= mean(nendo14) if e(sample) == 1, by(pres_pm_codes)
egen v_tmean_nendo15= mean(nendo15) if e(sample) == 1, by(pres_pm_codes)

egen up_pop_vtm = mean(dummy_up_salary*ln_population) if e(sample) == 1, by(pres_pm_codes)	
egen dn_pop_vtm = mean(dummy_down_salary*ln_population) if e(sample) == 1, by(pres_pm_codes)	
egen up_popsq_vtm = mean(dummy_up_salary*ln_population*ln_population) if e(sample) == 1, by(pres_pm_codes)	
egen dn_popsq_vtm = mean(dummy_down_salary*ln_population*ln_population) if e(sample) == 1, by(pres_pm_codes)
egen popsq_vtm = mean(ln_population*ln_population) if e(sample) == 1, by(pres_pm_codes)	

egen sala_popu_vtm = mean(lnsalary_am_kokuji*ln_population) if e(sample) == 1, by(pres_pm_codes)
egen sala_popusq_vtm = mean(lnsalary_am_kokuji*ln_population*ln_population) if e(sample) == 1, by(pres_pm_codes)
egen salasq_vtm = mean(lnsalary_am_kokuji*lnsalary_am_kokuji) if e(sample) == 1, by(pres_pm_codes)
	

fhetprob voting_rate_p lnsalary_am_kokuji i.cate_change_salary ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all i.tobs_vot v_tmean_*, het(i.tobs_vot)
margins, dydx(lnsalary_am_kokuji i.cate_change_salary)
*増額有意プラス

fhetprob voting_rate_p lnsalary_am_kokuji i.cate_change_salary##c.ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all i.tobs_vot v_tmean_* up_pop_vtm dn_pop_vtm, het(i.tobs_vot)
margins, dydx(i.cate_change_salary) at(ln_population = (6 7 8 9 10 11 12 13 14 15))
marginsplot

fhetprob voting_rate_p lnsalary_am_kokuji i.cate_change_salary##c.ln_population##c.ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all i.tobs_vot v_tmean_* *_vtm, het(i.tobs_vot)
margins if e(sample) == 1, dydx(i.cate_change_salary) at(ln_population = (6 7 8 9 10 11 12 13 14 15))
marginsplot

fhetprob voting_rate_p c.lnsalary_am_kokuji##c.ln_population##c.ln_population i.cate_change_salary n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all i.tobs_vot v_tmean_* sala_popu_vtm sala_popusq_vtm popsq_vtm, het(i.tobs_vot)
margins if e(sample) == 1, dydx(lnsalary_am_kokuji) at(ln_population = (6 7 8 9 10 11 12 13 14 15))

fhetprob voting_rate_p c.lnsalary_am_kokuji##c.lnsalary_am_kokuji i.cate_change_salary n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all i.tobs_vot v_tmean_* salasq_vtm , het(i.tobs_vot)
margins if e(sample) == 1, dydx(lnsalary_am_kokuji) at(lnsalary_am_kokuji = (6.5 7 7.5 8 8.5 9))

*include

fhetprob voting_rate_isna lnsalary_am_kokuji i.cate_change_salary ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all i.nendo tmean_*, het(lnsalary_am_kokuji)
*not concave

gen voting_rate_p = voting_rate_isna*0.01
sum voting_rate_p

fracreg probit voting_rate_p lnsalary_am_kokuji i.cate_change_salary ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all i.nendo , vce(cluster pres_pm_codes)
*レベルに対してプラス

fhetprob voting_rate_p lnsalary_am_kokuji i.cate_change_salary ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre compe_rate_adopt age_mean_cand ratio_women_cand_adopt cand_ratio_musyozoku expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all i.nendo tmean_*, het(lnsalary_am_kokuji)
*消えた

egen tobs_vot2 = count(ele_id) if e(sample)==1, by(pres_pm_codes)
tab tobs_vot2

tab tobs_vot2 tobs_women


sort pres_pm_codes
egen v2_tmean_lnsalary=mean(lnsalary_am_kokuji) if e(sample) == 1, by(pres_pm_codes)
egen v2_tmean_upsalary=mean(dummy_up_salary) if e(sample) == 1, by(pres_pm_codes)
egen v2_tmean_dnsalary=mean(dummy_down_salary) if e(sample) == 1, by(pres_pm_codes)
egen v2_tmean_lnpopu=mean(ln_population) if e(sample) == 1, by(pres_pm_codes)
egen v2_tmean_nseats=mean(n_seats_adopt) if e(sample) == 1, by(pres_pm_codes)
egen v2_tmean_75ratio=mean(population_elderly75_ratio) if e(sample) == 1, by(pres_pm_codes)
egen v2_tmean_15ratio=mean(population_child15_ratio) if e(sample) == 1, by(pres_pm_codes)
egen v2_tmean_lnincome=mean(ln_income_per) if e(sample) == 1, by(pres_pm_codes)
egen v2_tmean_lnmenseki=mean(ln_all_menseki) if e(sample) == 1, by(pres_pm_codes)
egen v2_tmean_canlive=mean(canlive_ratio_menseki) if e(sample) == 1, by(pres_pm_codes)
egen v2_tmean_sigaika=mean(sigaika_ratio_area) if e(sample) == 1, by(pres_pm_codes)
egen v2_tmean_lnzaisei=mean(ln_zaiseiryoku) if e(sample) == 1, by(pres_pm_codes)
egen v2_tmean_wmusyo_p=mean(win_ratio_musyozoku_pre) if e(sample) == 1, by(pres_pm_codes)
egen v2_tmean_lnstaff=mean(ln_staff_all) if e(sample) == 1, by(pres_pm_codes)
egen v2_tmean_expired=mean(expired_dummy) if e(sample) == 1, by(pres_pm_codes)

egen v2_tmean_t2007=mean(touitsu_2007) if e(sample) == 1, by(pres_pm_codes)
egen v2_tmean_t2011=mean(touitsu_2011) if e(sample) == 1, by(pres_pm_codes)
egen v2_tmean_t2015=mean(touitsu_2015) if e(sample) == 1, by(pres_pm_codes)
egen v2_tmean_t2019=mean(touitsu_2019) if e(sample) == 1, by(pres_pm_codes)

egen v2_tmean_nendo1= mean(nendo1) if e(sample) == 1, by(pres_pm_codes)
egen v2_tmean_nendo2= mean(nendo2) if e(sample) == 1, by(pres_pm_codes)
egen v2_tmean_nendo3= mean(nendo3) if e(sample) == 1, by(pres_pm_codes)
egen v2_tmean_nendo4= mean(nendo4) if e(sample) == 1, by(pres_pm_codes)
egen v2_tmean_nendo5= mean(nendo5) if e(sample) == 1, by(pres_pm_codes)
egen v2_tmean_nendo6= mean(nendo6) if e(sample) == 1, by(pres_pm_codes)
egen v2_tmean_nendo7= mean(nendo7) if e(sample) == 1, by(pres_pm_codes)
egen v2_tmean_nendo8= mean(nendo8) if e(sample) == 1, by(pres_pm_codes)
egen v2_tmean_nendo9= mean(nendo9) if e(sample) == 1, by(pres_pm_codes)
egen v2_tmean_nendo10= mean(nendo10) if e(sample) == 1, by(pres_pm_codes)
egen v2_tmean_nendo11= mean(nendo11) if e(sample) == 1, by(pres_pm_codes)
egen v2_tmean_nendo12= mean(nendo12) if e(sample) == 1, by(pres_pm_codes)
egen v2_tmean_nendo13= mean(nendo13) if e(sample) == 1, by(pres_pm_codes)
egen v2_tmean_nendo14= mean(nendo14) if e(sample) == 1, by(pres_pm_codes)
egen v2_tmean_nendo15= mean(nendo15) if e(sample) == 1, by(pres_pm_codes)

*compe_rate_adopt age_mean_cand ratio_women_cand_adopt cand_ratio_musyozoku
egen v2_tmean_compe=mean(compe_rate_adopt) if e(sample) == 1, by(pres_pm_codes)
egen v2_tmean_agemc=mean(age_mean_cand) if e(sample) == 1, by(pres_pm_codes)
egen v2_tmean_womc=mean(ratio_women_cand_adopt) if e(sample) == 1, by(pres_pm_codes)
egen v2_tmean_cmusyo_p=mean(cand_ratio_musyozoku) if e(sample) == 1, by(pres_pm_codes)

egen up_pop_v2tm = mean(dummy_up_salary*ln_population) if e(sample) == 1, by(pres_pm_codes)	
egen dn_pop_v2tm = mean(dummy_down_salary*ln_population) if e(sample) == 1, by(pres_pm_codes)	
egen up_popsq_v2tm = mean(dummy_up_salary*ln_population*ln_population) if e(sample) == 1, by(pres_pm_codes)	
egen dn_popsq_v2tm = mean(dummy_down_salary*ln_population*ln_population) if e(sample) == 1, by(pres_pm_codes)
egen popsq_v2tm = mean(ln_population*ln_population) if e(sample) == 1, by(pres_pm_codes)	

egen sala_popu_v2tm = mean(lnsalary_am_kokuji*ln_population) if e(sample) == 1, by(pres_pm_codes)
egen sala_popusq_v2tm = mean(lnsalary_am_kokuji*ln_population*ln_population) if e(sample) == 1, by(pres_pm_codes)
egen salasq_v2tm = mean(lnsalary_am_kokuji*lnsalary_am_kokuji) if e(sample) == 1, by(pres_pm_codes)
	

fhetprob voting_rate_p lnsalary_am_kokuji i.cate_change_salary ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre compe_rate_adopt age_mean_cand ratio_women_cand_adopt cand_ratio_musyozoku expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all i.tobs_vot2 v2_tmean_*, het(i.tobs_vot2)
margins, dydx(lnsalary_am_kokuji i.cate_change_salary)
*増額有意プラス

fhetprob voting_rate_p lnsalary_am_kokuji i.cate_change_salary##c.ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre compe_rate_adopt age_mean_cand ratio_women_cand_adopt cand_ratio_musyozoku expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all i.tobs_vot2 v2_tmean_* up_pop_v2tm dn_pop_v2tm, het(i.tobs_vot2)
margins, dydx(i.cate_change_salary) at(ln_population = (6 7 8 9 10 11 12 13 14 15))
marginsplot

fhetprob voting_rate_p lnsalary_am_kokuji i.cate_change_salary##c.ln_population##c.ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre compe_rate_adopt age_mean_cand ratio_women_cand_adopt cand_ratio_musyozoku expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all i.tobs_vot2 v2_tmean_* *_v2tm, het(i.tobs_vot2)
margins if e(sample) == 1, dydx(i.cate_change_salary) at(ln_population = (6 7 8 9 10 11 12 13 14 15))
marginsplot

fhetprob voting_rate_p c.lnsalary_am_kokuji##c.ln_population##c.ln_population i.cate_change_salary n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre compe_rate_adopt age_mean_cand ratio_women_cand_adopt cand_ratio_musyozoku expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all i.tobs_vot v_tmean_* sala_popu_vtm sala_popusq_vtm popsq_vtm, het(i.tobs_vot)
margins if e(sample) == 1, dydx(lnsalary_am_kokuji) at(ln_population = (6 7 8 9 10 11 12 13 14 15))

fhetprob voting_rate_p c.lnsalary_am_kokuji##c.lnsalary_am_kokuji i.cate_change_salary n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all i.tobs_vot v_tmean_* salasq_vtm , het(i.tobs_vot)
margins if e(sample) == 1, dydx(lnsalary_am_kokuji) at(lnsalary_am_kokuji = (6.5 7 7.5 8 8.5 9))


**result
estimates clear

fracreg probit voting_rate_p lnsalary_am_kokuji i.cate_change_salary ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all , vce(cluster pres_pm_codes)
estimates store r1, title("FQML")
estadd local municipality "No": r1
estadd local year "No": r1

fracreg probit voting_rate_p lnsalary_am_kokuji i.cate_change_salary ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all compe_rate_adopt age_mean_cand ratio_women_cand_adopt cand_ratio_musyozoku, vce(cluster pres_pm_codes)
estimates store r2, title("FQML")
estadd local municipality "No": r2
estadd local year "No": r2
margins, dydx(lnsalary_am_kokuji i.cate_change_salary)

fhetprob voting_rate_p lnsalary_am_kokuji i.cate_change_salary ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all i.tobs_vot v_tmean_*, het(i.tobs_vot)
estimates store r3, title("FQMLCRH")
estadd local municipality "YES": r3
estadd local year "Yes": r3

fhetprob voting_rate_p lnsalary_am_kokuji i.cate_change_salary ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre compe_rate_adopt age_mean_cand ratio_women_cand_adopt cand_ratio_musyozoku expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all i.tobs_vot2 v2_tmean_*, het(i.tobs_vot2)
estimates store r4, title("FQMLCRH")
estadd local municipality "Yes": r4
estadd local year "Yes": r4
margins, dydx(lnsalary_am_kokuji i.cate_change_salary)

glm voting_rate_p lnsalary_am_kokuji i.cate_change_salary ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre compe_rate_adopt age_mean_cand ratio_women_cand_adopt cand_ratio_musyozoku expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all i.nendo v2_tmean_*, fa(bin) link(probit) cluster(pres_pm_codes)

fhetprob voting_rate_p lnsalary_am_kokuji i.cate_change_salary##c.ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre compe_rate_adopt age_mean_cand ratio_women_cand_adopt cand_ratio_musyozoku expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all i.tobs_vot2 v2_tmean_* up_pop_v2tm dn_pop_v2tm, het(i.tobs_vot2)
estimates store r5, title("FQMLCRH")
estadd local municipality "Yes": r5
estadd local year "Yes": r5
margins, dydx(lnsalary_am_kokuji i.cate_change_salary)

fhetprob voting_rate_p lnsalary_am_kokuji i.cate_change_salary##c.ln_population##c.ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre compe_rate_adopt age_mean_cand ratio_women_cand_adopt cand_ratio_musyozoku expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all i.tobs_vot2 v2_tmean_* up_pop_v2tm dn_pop_v2tm dn_popsq_v2tm up_popsq_v2tm popsq_v2tm, het(i.tobs_vot2)
estimates store r6, title("FQMLCRH")
estadd local municipality "Yes": r6
estadd local year "Yes": r6
margins, dydx(i.cate_change_salary) at(ln_population = (6 7 8 9 10 11 12 13 14 15))

esttab r1 r2 r3 r4 r5 r6 using "voting_frac.tex", replace ///
b(3) se(3) star(* 0.10 ** 0.05 *** 0.01) booktabs ///
drop(touitsu_2007 _cons v2_tmean_* v_tmean_* *_v2tm *.tobs_vot *tobs_vot2) nogaps ///
stats(year municipality N, fmt(%9.0f %9.0f %9.0f) labels("年度固定効果" "自治体固定効果" "観測数")) ///
label nolz varwidth(16) modelwidth(13) style(tex)  ///
title(被説明変数: 投票率) coeflabels(lnsalary_am_kokuji "対数議員報酬額" 1.cate_change_salary "増額ダミー" 2.cate_change_salary "減額ダミー" /// 
ln_population "対数人口" n_seats_adopt "議席数" population_elderly75_ratio "全人口に占める75歳以上の割合" population_child15_ratio "全人口に占める15歳未満の割合"  ///
ln_income_per "納税者1人あたり課税対象所得" ln_all_menseki "対数面積" canlive_ratio_menseki "可住地面積割合" sigaika_ratio_area "市街化区域面積割合" ln_zaiseiryoku ///
"対数財政力指数" win_ratio_musyozoku_pre "前回当選者に占める無所属の割合" ln_staff_all "対数自治体職員数" ///
age_mean_cand "立候補者平均年齢" cand_ratio_musyozoku "立候補者無所属割合" ratio_women_cand_adopt "立候補者女性割合" compe_rate_adopt "1議席あたり立候補者数" touitsu_2011 "2011年統一選ダミー" touitsu_2015 "2015年統一選ダミー" touitsu_2019 "2019年統一選ダミー" expired_dummy "任期満了ダミー" ///
1.cate_change_salary#c.ln_population "増額ダミー \times 対数人口" 2.cate_change_salary#c.ln_population "減額ダミー \times 対数人口" ///
1.cate_change_salary#c.ln_population#c.ln_population "増額ダミー \times 対数人口2乗" 2.cate_change_salary#c.ln_population#c.ln_population ///
"減額ダミー \times 対数人口2乗" c.ln_population#c.ln_population "対数人口2乗") ///
order(lnsalary_am_kokuji 1.cate_change_salary 2.cate_change_salary) ///
mlabels(, span prefix(\multicolumn{@span}{c}{) suffix(})) ///
prehead("\documentclass[11pt]{jsarticle}" "\pagestyle{empty}" "\usepackage{booktabs}""\usepackage{siunitx}""\usepackage{lscape}" ///
"\usepackage[margin=20truemm]{geometry}""\sisetup{input-symbols = ()}""\begin{document}""\begin{table}\caption{@title}" ///
"\def\sym#1{\ifmmode^{#1}\else\(^{#1}\)\fi}""\begin{center}" ///
"\sisetup{table-space-text-post = \sym{***}}""\begin{tabular}{l*{@M}{llll}}""\toprule") posthead(\midrule) prefoot(\midrule) ///
postfoot("\bottomrule""\end{tabular}""\end{center}""\end{table}""\end{document}")

**gmm

estimates clear

xtabond2 voting_rate_isna lnsalary_am_kokuji i.cate_change_salary L1.voting_rate_isna ln_income_per i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku ln_staff_all compe_rate_adopt age_mean_cand ratio_women_cand_adopt cand_ratio_musyozoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019, gmm(i.cate_change_salary lnsalary_am_kokuji L.voting_rate_isna) ivstyle(i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku compe_rate_adopt age_mean_cand win_ratio_musyozoku_pre ratio_women_cand_adopt cand_ratio_musyozoku expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all) noleveleq twostep robust
estimates store r1, title("diff GMM")
estadd local municipality "Yes": r1
estadd local year "Yes": r1

xtabond2 voting_rate_isna lnsalary_am_kokuji i.cate_change_salary##c.ln_population L1.voting_rate_isna ln_income_per i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku ln_staff_all compe_rate_adopt age_mean_cand ratio_women_cand_adopt cand_ratio_musyozoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019, gmm(i.cate_change_salary lnsalary_am_kokuji i.cate_change_salary#c.ln_population L.voting_rate_isna) ivstyle(i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku compe_rate_adopt age_mean_cand win_ratio_musyozoku_pre ratio_women_cand_adopt cand_ratio_musyozoku expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all) noleveleq twostep robust
estimates store r2, title("diff GMM")
estadd local municipality "Yes": r2
estadd local year "Yes": r2

xtabond2 voting_rate_isna lnsalary_am_kokuji i.cate_change_salary##c.ln_population##c.ln_population L1.voting_rate_isna ln_income_per i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku ln_staff_all compe_rate_adopt age_mean_cand ratio_women_cand_adopt cand_ratio_musyozoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019, gmm(i.cate_change_salary lnsalary_am_kokuji i.cate_change_salary#c.ln_population i.cate_change_salary#c.ln_population#c.ln_population L.voting_rate_isna) ivstyle(i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku compe_rate_adopt age_mean_cand win_ratio_musyozoku_pre ratio_women_cand_adopt cand_ratio_musyozoku expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all) noleveleq twostep robust
estimates store r3, title("diff GMM")
estadd local municipality "Yes": r3
estadd local year "Yes": r3

xtabond2 voting_rate_isna lnsalary_am_kokuji i.cate_change_salary L1.voting_rate_isna ln_income_per i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku ln_staff_all compe_rate_adopt age_mean_cand ratio_women_cand_adopt cand_ratio_musyozoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019, gmm(i.cate_change_salary lnsalary_am_kokuji L.voting_rate_isna) ivstyle(i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku compe_rate_adopt age_mean_cand win_ratio_musyozoku_pre ratio_women_cand_adopt cand_ratio_musyozoku expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all) twostep robust
estimates store r4, title("sys GMM")
estadd local municipality "Yes": r4
estadd local year "Yes": r4

xtabond2 voting_rate_isna lnsalary_am_kokuji i.cate_change_salary##c.ln_population L1.voting_rate_isna ln_income_per i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku ln_staff_all compe_rate_adopt age_mean_cand ratio_women_cand_adopt cand_ratio_musyozoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019, gmm(i.cate_change_salary lnsalary_am_kokuji i.cate_change_salary#c.ln_population L.voting_rate_isna) ivstyle(i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku compe_rate_adopt age_mean_cand win_ratio_musyozoku_pre ratio_women_cand_adopt cand_ratio_musyozoku expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all) twostep robust
estimates store r5, title("sys GMM")
estadd local municipality "Yes": r5
estadd local year "Yes": r5

xtabond2 voting_rate_isna lnsalary_am_kokuji i.cate_change_salary##c.ln_population##c.ln_population L1.voting_rate_isna ln_income_per i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku ln_staff_all compe_rate_adopt age_mean_cand ratio_women_cand_adopt cand_ratio_musyozoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019, gmm(i.cate_change_salary lnsalary_am_kokuji i.cate_change_salary#c.ln_population i.cate_change_salary#c.ln_population#c.ln_population L.voting_rate_isna) ivstyle(i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku compe_rate_adopt age_mean_cand win_ratio_musyozoku_pre ratio_women_cand_adopt cand_ratio_musyozoku expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all) twostep robust
estimates store r6, title("sys GMM")
estadd local municipality "Yes": r6
estadd local year "Yes": r6

esttab r1 r2 r3 r4 r5 r6 using "voting_gmm.tex", replace ///
b(3) se(3) star(* 0.10 ** 0.05 *** 0.01) booktabs ///
drop( _cons *.nendo) nogaps ///
stats(year municipality N, fmt(%9.0f %9.0f %9.0f) labels("年度固定効果" "自治体固定効果" "観測数")) ///
label nolz varwidth(16) modelwidth(13) style(tex)  ///
title(被説明変数: 投票率(%)) coeflabels(lnsalary_am_kokuji "対数議員報酬額" 1.cate_change_salary "増額ダミー" 2.cate_change_salary "減額ダミー" /// 
ln_population "対数人口" n_seats_adopt "議席数" population_elderly75_ratio "全人口に占める75歳以上の割合" population_child15_ratio "全人口に占める15歳未満の割合"  ///
ln_income_per "納税者1人あたり課税対象所得" ln_all_menseki "対数面積" canlive_ratio_menseki "可住地面積割合" sigaika_ratio_area "市街化区域面積割合" ln_zaiseiryoku ///
"対数財政力指数" win_ratio_musyozoku_pre "前回当選者に占める無所属の割合" ln_staff_all "対数自治体職員数" ///
age_mean_cand "立候補者平均年齢" cand_ratio_musyozoku "立候補者無所属割合" ratio_women_cand_adopt "立候補者女性割合" compe_rate_adopt "1議席あたり立候補者数" touitsu_2011 "2011年統一選ダミー" touitsu_2015 "2015年統一選ダミー" touitsu_2019 "2019年統一選ダミー" expired_dummy "任期満了ダミー" ///
1.cate_change_salary#c.ln_population "増額ダミー $\times$ 対数人口" 2.cate_change_salary#c.ln_population "減額ダミー $\times$ 対数人口" ///
1.cate_change_salary#c.ln_population#c.ln_population "増額ダミー $\times$ 対数人口2乗" 2.cate_change_salary#c.ln_population#c.ln_population ///
"減額ダミー \times 対数人口2乗" c.ln_population#c.ln_population "対数人口2乗" L.voting_rate_isna "投票率_1期ラグ") ///
order(lnsalary_am_kokuji 1.cate_change_salary 2.cate_change_salary) ///
mlabels(, span prefix(\multicolumn{@span}{c}{) suffix(})) ///
prehead("\documentclass[8pt]{jsarticle}" "\pagestyle{empty}" "\usepackage{booktabs}""\usepackage{siunitx}""\usepackage{lscape}" ///
"\usepackage[margin=20truemm]{geometry}""\sisetup{input-symbols = ()}""\begin{document}""\begin{table}\caption{@title}" ///
"\def\sym#1{\ifmmode^{#1}\else\(^{#1}\)\fi}""\begin{center}" ///
"\sisetup{table-space-text-post = \sym{***}}""\begin{tabular}{l*{@M}{llll}}""\toprule") posthead(\midrule) prefoot(\midrule) ///
postfoot("\bottomrule""\end{tabular}""\end{center}""\end{table}""\end{document}")





**adjusted_inc_voteshare
compe_rate_adopt age_mean_cand ratio_women_cand_adopt cand_ratio_musyozoku

*not include
fracreg probit adjusted_ave_voteshare_inc lnsalary_am_kokuji i.cate_change_salary ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all i.nendo , vce(cluster pres_pm_codes)
margins if e(sample) == 1, dydx(lnsalary_am_kokuji)
*レベルに対してプラス

fhetprob adjusted_ave_voteshare_inc lnsalary_am_kokuji i.cate_change_salary ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all i.nendo tmean_* , het(lnsalary_am_kokuji)

egen tobs_inc = count(ele_id) if e(sample)==1, by(pres_pm_codes)
tab tobs_inc

tab tobs_vot tobs_inc


sort pres_pm_codes
egen i_tmean_lnsalary=mean(lnsalary_am_kokuji) if e(sample) == 1, by(pres_pm_codes)
egen i_tmean_upsalary=mean(dummy_up_salary) if e(sample) == 1, by(pres_pm_codes)
egen i_tmean_dnsalary=mean(dummy_down_salary) if e(sample) == 1, by(pres_pm_codes)
egen i_tmean_lnpopu=mean(ln_population) if e(sample) == 1, by(pres_pm_codes)
egen i_tmean_nseats=mean(n_seats_adopt) if e(sample) == 1, by(pres_pm_codes)
egen i_tmean_75ratio=mean(population_elderly75_ratio) if e(sample) == 1, by(pres_pm_codes)
egen i_tmean_15ratio=mean(population_child15_ratio) if e(sample) == 1, by(pres_pm_codes)
egen i_tmean_lnincome=mean(ln_income_per) if e(sample) == 1, by(pres_pm_codes)
egen i_tmean_lnmenseki=mean(ln_all_menseki) if e(sample) == 1, by(pres_pm_codes)
egen i_tmean_canlive=mean(canlive_ratio_menseki) if e(sample) == 1, by(pres_pm_codes)
egen i_tmean_sigaika=mean(sigaika_ratio_area) if e(sample) == 1, by(pres_pm_codes)
egen i_tmean_lnzaisei=mean(ln_zaiseiryoku) if e(sample) == 1, by(pres_pm_codes)
egen i_tmean_wmusyo_p=mean(win_ratio_musyozoku_pre) if e(sample) == 1, by(pres_pm_codes)
egen i_tmean_lnstaff=mean(ln_staff_all) if e(sample) == 1, by(pres_pm_codes)
egen i_tmean_expired=mean(expired_dummy) if e(sample) == 1, by(pres_pm_codes)

egen i_tmean_t2007=mean(touitsu_2007) if e(sample) == 1, by(pres_pm_codes)
egen i_tmean_t2011=mean(touitsu_2011) if e(sample) == 1, by(pres_pm_codes)
egen i_tmean_t2015=mean(touitsu_2015) if e(sample) == 1, by(pres_pm_codes)
egen i_tmean_t2019=mean(touitsu_2019) if e(sample) == 1, by(pres_pm_codes)

egen i_tmean_nendo1= mean(nendo1) if e(sample) == 1, by(pres_pm_codes)
egen i_tmean_nendo2= mean(nendo2) if e(sample) == 1, by(pres_pm_codes)
egen i_tmean_nendo3= mean(nendo3) if e(sample) == 1, by(pres_pm_codes)
egen i_tmean_nendo4= mean(nendo4) if e(sample) == 1, by(pres_pm_codes)
egen i_tmean_nendo5= mean(nendo5) if e(sample) == 1, by(pres_pm_codes)
egen i_tmean_nendo6= mean(nendo6) if e(sample) == 1, by(pres_pm_codes)
egen i_tmean_nendo7= mean(nendo7) if e(sample) == 1, by(pres_pm_codes)
egen i_tmean_nendo8= mean(nendo8) if e(sample) == 1, by(pres_pm_codes)
egen i_tmean_nendo9= mean(nendo9) if e(sample) == 1, by(pres_pm_codes)
egen i_tmean_nendo10= mean(nendo10) if e(sample) == 1, by(pres_pm_codes)
egen i_tmean_nendo11= mean(nendo11) if e(sample) == 1, by(pres_pm_codes)
egen i_tmean_nendo12= mean(nendo12) if e(sample) == 1, by(pres_pm_codes)
egen i_tmean_nendo13= mean(nendo13) if e(sample) == 1, by(pres_pm_codes)
egen i_tmean_nendo14= mean(nendo14) if e(sample) == 1, by(pres_pm_codes)
egen i_tmean_nendo15= mean(nendo15) if e(sample) == 1, by(pres_pm_codes)

egen up_pop_itm = mean(dummy_up_salary*ln_population) if e(sample) == 1, by(pres_pm_codes)	
egen dn_pop_itm = mean(dummy_down_salary*ln_population) if e(sample) == 1, by(pres_pm_codes)	
egen up_popsq_itm = mean(dummy_up_salary*ln_population*ln_population) if e(sample) == 1, by(pres_pm_codes)	
egen dn_popsq_itm = mean(dummy_down_salary*ln_population*ln_population) if e(sample) == 1, by(pres_pm_codes)
egen popsq_itm = mean(ln_population*ln_population) if e(sample) == 1, by(pres_pm_codes)	

egen sala_popu_itm = mean(lnsalary_am_kokuji*ln_population) if e(sample) == 1, by(pres_pm_codes)
egen sala_popusq_itm = mean(lnsalary_am_kokuji*ln_population*ln_population) if e(sample) == 1, by(pres_pm_codes)
egen salasq_itm = mean(lnsalary_am_kokuji*lnsalary_am_kokuji) if e(sample) == 1, by(pres_pm_codes)

fhetprob adjusted_ave_voteshare_inc lnsalary_am_kokuji i.cate_change_salary ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all i.tobs_inc i_tmean_*, het(i.tobs_inc)
margins, dydx(lnsalary_am_kokuji i.cate_change_salary)

fhetprob adjusted_ave_voteshare_inc lnsalary_am_kokuji i.cate_change_salary##c.ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all i.tobs_inc i_tmean_* up_pop_itm dn_pop_itm, het(i.tobs_inc)
margins, dydx(i.cate_change_salary) at(ln_population = (6 7 8 9 10 11 12 13 14 15))

fhetprob adjusted_ave_voteshare_inc lnsalary_am_kokuji i.cate_change_salary##c.ln_population##c.ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all i.tobs_inc i_tmean_* *_itm, het(i.tobs_inc)
margins if e(sample) == 1, dydx(i.cate_change_salary) at(ln_population = (6 7 8 9 10 11 12 13 14 15))
marginsplot

fhetprob voting_rate_p c.lnsalary_am_kokuji##c.ln_population##c.ln_population i.cate_change_salary n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all i.tobs_inc i_tmean_* sala_popu_itm sala_popusq_itm popsq_itm, het(i.tobs_inc)
margins if e(sample) == 1, dydx(lnsalary_am_kokuji) at(ln_population = (6 7 8 9 10 11 12 13 14 15))

fhetprob voting_rate_p c.lnsalary_am_kokuji##c.lnsalary_am_kokuji i.cate_change_salary n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all i.tobs_inc i_tmean_* salasq_itm , het(i.tobs_inc)
margins if e(sample) == 1, dydx(lnsalary_am_kokuji) at(lnsalary_am_kokuji = (6.5 7 7.5 8 8.5 9))

*include
fracreg probit adjusted_ave_voteshare_inc lnsalary_am_kokuji i.cate_change_salary ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre compe_rate_adopt age_mean_cand ratio_women_cand_adopt cand_ratio_musyozoku expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all i.nendo , vce(cluster pres_pm_codes)
margins, dydx(lnsalary_am_kokuji i.cate_change_salary)

fhetprob adjusted_ave_voteshare_inc lnsalary_am_kokuji i.cate_change_salary ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre compe_rate_adopt age_mean_cand ratio_women_cand_adopt cand_ratio_musyozoku expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all i.nendo tmean_* , het(lnsalary_am_kokuji)
margins, dydx(lnsalary_am_kokuji i.cate_change_salary)

egen tobs_inc2 = count(ele_id) if e(sample)==1, by(pres_pm_codes)
tab tobs_inc2

tab tobs_vot tobs_inc2

sort pres_pm_codes
egen i2_tmean_lnsalary=mean(lnsalary_am_kokuji) if e(sample) == 1, by(pres_pm_codes)
egen i2_tmean_upsalary=mean(dummy_up_salary) if e(sample) == 1, by(pres_pm_codes)
egen i2_tmean_dnsalary=mean(dummy_down_salary) if e(sample) == 1, by(pres_pm_codes)
egen i2_tmean_lnpopu=mean(ln_population) if e(sample) == 1, by(pres_pm_codes)
egen i2_tmean_nseats=mean(n_seats_adopt) if e(sample) == 1, by(pres_pm_codes)
egen i2_tmean_75ratio=mean(population_elderly75_ratio) if e(sample) == 1, by(pres_pm_codes)
egen i2_tmean_15ratio=mean(population_child15_ratio) if e(sample) == 1, by(pres_pm_codes)
egen i2_tmean_lnincome=mean(ln_income_per) if e(sample) == 1, by(pres_pm_codes)
egen i2_tmean_lnmenseki=mean(ln_all_menseki) if e(sample) == 1, by(pres_pm_codes)
egen i2_tmean_canlive=mean(canlive_ratio_menseki) if e(sample) == 1, by(pres_pm_codes)
egen i2_tmean_sigaika=mean(sigaika_ratio_area) if e(sample) == 1, by(pres_pm_codes)
egen i2_tmean_lnzaisei=mean(ln_zaiseiryoku) if e(sample) == 1, by(pres_pm_codes)
egen i2_tmean_wmusyo_p=mean(win_ratio_musyozoku_pre) if e(sample) == 1, by(pres_pm_codes)
egen i2_tmean_lnstaff=mean(ln_staff_all) if e(sample) == 1, by(pres_pm_codes)
egen i2_tmean_expired=mean(expired_dummy) if e(sample) == 1, by(pres_pm_codes)

egen i2_tmean_t2007=mean(touitsu_2007) if e(sample) == 1, by(pres_pm_codes)
egen i2_tmean_t2011=mean(touitsu_2011) if e(sample) == 1, by(pres_pm_codes)
egen i2_tmean_t2015=mean(touitsu_2015) if e(sample) == 1, by(pres_pm_codes)
egen i2_tmean_t2019=mean(touitsu_2019) if e(sample) == 1, by(pres_pm_codes)

egen i2_tmean_nendo1= mean(nendo1) if e(sample) == 1, by(pres_pm_codes)
egen i2_tmean_nendo2= mean(nendo2) if e(sample) == 1, by(pres_pm_codes)
egen i2_tmean_nendo3= mean(nendo3) if e(sample) == 1, by(pres_pm_codes)
egen i2_tmean_nendo4= mean(nendo4) if e(sample) == 1, by(pres_pm_codes)
egen i2_tmean_nendo5= mean(nendo5) if e(sample) == 1, by(pres_pm_codes)
egen i2_tmean_nendo6= mean(nendo6) if e(sample) == 1, by(pres_pm_codes)
egen i2_tmean_nendo7= mean(nendo7) if e(sample) == 1, by(pres_pm_codes)
egen i2_tmean_nendo8= mean(nendo8) if e(sample) == 1, by(pres_pm_codes)
egen i2_tmean_nendo9= mean(nendo9) if e(sample) == 1, by(pres_pm_codes)
egen i2_tmean_nendo10= mean(nendo10) if e(sample) == 1, by(pres_pm_codes)
egen i2_tmean_nendo11= mean(nendo11) if e(sample) == 1, by(pres_pm_codes)
egen i2_tmean_nendo12= mean(nendo12) if e(sample) == 1, by(pres_pm_codes)
egen i2_tmean_nendo13= mean(nendo13) if e(sample) == 1, by(pres_pm_codes)
egen i2_tmean_nendo14= mean(nendo14) if e(sample) == 1, by(pres_pm_codes)
egen i2_tmean_nendo15= mean(nendo15) if e(sample) == 1, by(pres_pm_codes)

*compe_rate_adopt age_mean_cand ratio_women_cand_adopt cand_ratio_musyozoku
egen i2_tmean_compe=mean(compe_rate_adopt) if e(sample) == 1, by(pres_pm_codes)
egen i2_tmean_agemc=mean(age_mean_cand) if e(sample) == 1, by(pres_pm_codes)
egen i2_tmean_womc=mean(ratio_women_cand_adopt) if e(sample) == 1, by(pres_pm_codes)
egen i2_tmean_cmusyo_p=mean(cand_ratio_musyozoku) if e(sample) == 1, by(pres_pm_codes)

egen up_pop_i2tm = mean(dummy_up_salary*ln_population) if e(sample) == 1, by(pres_pm_codes)	
egen dn_pop_i2tm = mean(dummy_down_salary*ln_population) if e(sample) == 1, by(pres_pm_codes)	
egen up_popsq_i2tm = mean(dummy_up_salary*ln_population*ln_population) if e(sample) == 1, by(pres_pm_codes)	
egen dn_popsq_i2tm = mean(dummy_down_salary*ln_population*ln_population) if e(sample) == 1, by(pres_pm_codes)
egen popsq_i2tm = mean(ln_population*ln_population) if e(sample) == 1, by(pres_pm_codes)	

egen sala_popu_i2tm = mean(lnsalary_am_kokuji*ln_population) if e(sample) == 1, by(pres_pm_codes)
egen sala_popusq_i2tm = mean(lnsalary_am_kokuji*ln_population*ln_population) if e(sample) == 1, by(pres_pm_codes)
egen salasq_i2tm = mean(lnsalary_am_kokuji*lnsalary_am_kokuji) if e(sample) == 1, by(pres_pm_codes)

fhetprob adjusted_ave_voteshare_inc lnsalary_am_kokuji i.cate_change_salary ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre compe_rate_adopt age_mean_cand ratio_women_cand_adopt cand_ratio_musyozoku expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all i.tobs_inc2 i2_tmean_*, het(i.tobs_inc2)
margins, dydx(lnsalary_am_kokuji i.cate_change_salary)

fhetprob adjusted_ave_voteshare_inc lnsalary_am_kokuji i.cate_change_salary##c.ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre compe_rate_adopt age_mean_cand ratio_women_cand_adopt cand_ratio_musyozoku expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all i.tobs_inc2 i2_tmean_* up_pop_i2tm dn_pop_i2tm, het(i.tobs_inc2)
margins, dydx(i.cate_change_salary) at(ln_population = (6 7 8 9 10 11 12 13 14 15))

fhetprob adjusted_ave_voteshare_inc lnsalary_am_kokuji i.cate_change_salary##c.ln_population##c.ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre compe_rate_adopt age_mean_cand ratio_women_cand_adopt cand_ratio_musyozoku expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all i.tobs_inc2 i2_tmean_* up_pop_i2tm dn_pop_i2tm up_popsq_i2tm dn_popsq_i2tm popsq_i2tm, het(i.tobs_inc2)
margins if e(sample) == 1, dydx(i.cate_change_salary) at(ln_population = (6 7 8 9 10 11 12 13 14 15))
marginsplot

fhetprob adjusted_ave_voteshare_inc c.lnsalary_am_kokuji##c.ln_population##c.ln_population i.cate_change_salary n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre compe_rate_adopt age_mean_cand ratio_women_cand_adopt cand_ratio_musyozoku expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all i.tobs_inc2 i2_tmean_* sala_popu_itm sala_popusq_itm popsq_itm, het(i.tobs_inc2)
margins if e(sample) == 1, dydx(lnsalary_am_kokuji) at(ln_population = (6 7 8 9 10 11 12 13 14 15))

fhetprob adjusted_ave_voteshare_inc c.lnsalary_am_kokuji##c.lnsalary_am_kokuji i.cate_change_salary n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre win_ratio_musyozoku_pre compe_rate_adopt age_mean_cand ratio_women_cand_adopt cand_ratio_musyozoku expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all i.tobs_inc2 i2_tmean_* salasq_itm , het(i.tobs_inc2)
margins if e(sample) == 1, dydx(lnsalary_am_kokuji) at(lnsalary_am_kokuji = (6.5 7 7.5 8 8.5 9))

**result
estimates clear

fracreg probit adjusted_ave_voteshare_inc lnsalary_am_kokuji i.cate_change_salary ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all , vce(cluster pres_pm_codes)
estimates store r1, title("FQML")
estadd local municipality "No": r1
estadd local year "No": r1

fracreg probit adjusted_ave_voteshare_inc lnsalary_am_kokuji i.cate_change_salary ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all compe_rate_adopt age_mean_cand ratio_women_cand_adopt cand_ratio_musyozoku, vce(cluster pres_pm_codes)
estimates store r2, title("FQML")
estadd local municipality "No": r2
estadd local year "No": r2
*margins, dydx(lnsalary_am_kokuji i.cate_change_salary)

fhetprob adjusted_ave_voteshare_inc lnsalary_am_kokuji i.cate_change_salary ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all i.tobs_inc i_tmean_*, het(i.tobs_inc)
estimates store r3, title("FQMLCRH")
estadd local municipality "YES": r3
estadd local year "Yes": r3

fhetprob adjusted_ave_voteshare_inc lnsalary_am_kokuji i.cate_change_salary ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre compe_rate_adopt age_mean_cand ratio_women_cand_adopt cand_ratio_musyozoku expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all i.tobs_inc2 i2_tmean_*, het(i.tobs_inc2)
estimates store r4, title("FQMLCRH")
estadd local municipality "Yes": r4
estadd local year "Yes": r4
*margins, dydx(lnsalary_am_kokuji i.cate_change_salary)

*glm voting_rate_p lnsalary_am_kokuji i.cate_change_salary ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre compe_rate_adopt age_mean_cand ratio_women_cand_adopt cand_ratio_musyozoku expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all i.nendo v2_tmean_*, fa(bin) link(probit) cluster(pres_pm_codes)

fhetprob adjusted_ave_voteshare_inc lnsalary_am_kokuji i.cate_change_salary##c.ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre compe_rate_adopt age_mean_cand ratio_women_cand_adopt cand_ratio_musyozoku expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all i.tobs_inc2 i2_tmean_* up_pop_i2tm dn_pop_i2tm, het(i.tobs_inc2)
estimates store r5, title("FQMLCRH")
estadd local municipality "Yes": r5
estadd local year "Yes": r5
*margins, dydx(lnsalary_am_kokuji i.cate_change_salary)

fhetprob adjusted_ave_voteshare_inc lnsalary_am_kokuji i.cate_change_salary##c.ln_population##c.ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre compe_rate_adopt age_mean_cand ratio_women_cand_adopt cand_ratio_musyozoku expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all i.tobs_inc2 i2_tmean_* up_pop_i2tm dn_pop_i2tm dn_popsq_i2tm up_popsq_i2tm popsq_i2tm, het(i.tobs_inc2)
estimates store r6, title("FQMLCRH")
estadd local municipality "Yes": r6
estadd local year "Yes": r6
*margins, dydx(i.cate_change_salary) at(ln_population = (6 7 8 9 10 11 12 13 14 15))

esttab r1 r2 r3 r4 r5 r6 using "inc_frac.tex", replace ///
b(3) se(3) star(* 0.10 ** 0.05 *** 0.01) booktabs ///
drop(touitsu_2007 _cons i2_tmean_* i_tmean_* *_i2tm *.tobs_inc *tobs_inc2) nogaps ///
stats(year municipality N, fmt(%9.0f %9.0f %9.0f) labels("年度ダミー" "上記変数の時間平均" "観測数")) ///
label nolz varwidth(16) modelwidth(13) style(tex)  ///
title(被説明変数: 調整済み現職1人当たり得票率) coeflabels(lnsalary_am_kokuji "対数議員報酬額" 1.cate_change_salary "増額ダミー" 2.cate_change_salary "減額ダミー" /// 
ln_population "対数人口" n_seats_adopt "議席数" population_elderly75_ratio "全人口に占める75歳以上の割合" population_child15_ratio "全人口に占める15歳未満の割合"  ///
ln_income_per "納税者1人あたり課税対象所得" ln_all_menseki "対数面積" canlive_ratio_menseki "可住地面積割合" sigaika_ratio_area "市街化区域面積割合" ln_zaiseiryoku ///
"対数財政力指数" win_ratio_musyozoku_pre "前回当選者に占める無所属の割合" ln_staff_all "対数自治体職員数" ///
age_mean_cand "立候補者平均年齢" cand_ratio_musyozoku "立候補者無所属割合" ratio_women_cand_adopt "立候補者女性割合" compe_rate_adopt "1議席あたり立候補者数" touitsu_2011 "2011年統一選ダミー" touitsu_2015 "2015年統一選ダミー" touitsu_2019 "2019年統一選ダミー" expired_dummy "任期満了ダミー" ///
1.cate_change_salary#c.ln_population "増額ダミー $\times$ 対数人口" 2.cate_change_salary#c.ln_population "減額ダミー $\times$ 対数人口" ///
1.cate_change_salary#c.ln_population#c.ln_population "増額ダミー $\times$ 対数人口2乗" 2.cate_change_salary#c.ln_population#c.ln_population ///
"減額ダミー $\times$ 対数人口2乗" c.ln_population#c.ln_population "対数人口2乗") ///
order(lnsalary_am_kokuji 1.cate_change_salary 2.cate_change_salary) ///
mlabels(, span prefix(\multicolumn{@span}{c}{) suffix(})) ///
prehead("\documentclass[8pt]{jsarticle}" "\pagestyle{empty}" "\usepackage{booktabs}""\usepackage{siunitx}""\usepackage{lscape}" ///
"\usepackage[margin=20truemm]{geometry}""\sisetup{input-symbols = ()}""\begin{document}""\begin{table}\caption{@title}" ///
"\def\sym#1{\ifmmode^{#1}\else\(^{#1}\)\fi}""\begin{center}" ///
"\sisetup{table-space-text-post = \sym{***}}""\begin{tabular}{l*{@M}{llll}}""\toprule") posthead(\midrule) prefoot(\midrule) ///
postfoot("\bottomrule""\end{tabular}""\end{center}""\end{table}""\end{document}")

**gmm

estimates clear

xtabond2 adjusted_ave_voteshare_inc lnsalary_am_kokuji i.cate_change_salary L1.adjusted_ave_voteshare_inc ln_income_per i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku ln_staff_all compe_rate_adopt age_mean_cand ratio_women_cand_adopt cand_ratio_musyozoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019, gmm(i.cate_change_salary lnsalary_am_kokuji L.adjusted_ave_voteshare_inc) ivstyle(i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku compe_rate_adopt age_mean_cand win_ratio_musyozoku_pre ratio_women_cand_adopt cand_ratio_musyozoku expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all) noleveleq twostep robust
estimates store r1, title("diff GMM")
estadd local municipality "Yes": r1
estadd local year "Yes": r1

xtabond2 adjusted_ave_voteshare_inc lnsalary_am_kokuji i.cate_change_salary ln_income_per i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku ln_staff_all win_ratio_musyozoku_pre  compe_rate_adopt age_mean_cand ratio_women_cand_adopt cand_ratio_musyozoku expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019, gmm(i.cate_change_salary lnsalary_am_kokuji ) ivstyle(i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre compe_rate_adopt age_mean_cand ratio_women_cand_adopt cand_ratio_musyozoku expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all) noleveleq twostep robust

xtabond2 adjusted_ave_voteshare_inc lnsalary_am_kokuji i.cate_change_salary##c.ln_population L1.adjusted_ave_voteshare_inc ln_income_per i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku ln_staff_all compe_rate_adopt age_mean_cand ratio_women_cand_adopt cand_ratio_musyozoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019, gmm(i.cate_change_salary lnsalary_am_kokuji i.cate_change_salary#c.ln_population L.voting_rate_isna) ivstyle(i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku compe_rate_adopt age_mean_cand win_ratio_musyozoku_pre ratio_women_cand_adopt cand_ratio_musyozoku expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all) noleveleq twostep robust
estimates store r2, title("diff GMM")
estadd local municipality "Yes": r2
estadd local year "Yes": r2

xtabond2 adjusted_ave_voteshare_inc lnsalary_am_kokuji i.cate_change_salary##c.ln_population##c.ln_population L1.adjusted_ave_voteshare_inc ln_income_per i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku ln_staff_all compe_rate_adopt age_mean_cand ratio_women_cand_adopt cand_ratio_musyozoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019, gmm(i.cate_change_salary lnsalary_am_kokuji i.cate_change_salary#c.ln_population i.cate_change_salary#c.ln_population#c.ln_population L.adjusted_ave_voteshare_inc) ivstyle(i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku compe_rate_adopt age_mean_cand win_ratio_musyozoku_pre ratio_women_cand_adopt cand_ratio_musyozoku expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all) noleveleq twostep robust
estimates store r3, title("diff GMM")
estadd local municipality "Yes": r3
estadd local year "Yes": r3

xtabond2 adjusted_ave_voteshare_inc lnsalary_am_kokuji i.cate_change_salary L1.adjusted_ave_voteshare_inc ln_income_per i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku ln_staff_all compe_rate_adopt age_mean_cand ratio_women_cand_adopt cand_ratio_musyozoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019, gmm(i.cate_change_salary lnsalary_am_kokuji L.adjusted_ave_voteshare_inc) ivstyle(i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku compe_rate_adopt age_mean_cand win_ratio_musyozoku_pre ratio_women_cand_adopt cand_ratio_musyozoku expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all) twostep robust
estimates store r4, title("sys GMM")
estadd local municipality "Yes": r4
estadd local year "Yes": r4

xtabond2 adjusted_ave_voteshare_inc lnsalary_am_kokuji i.cate_change_salary##c.ln_population L1.adjusted_ave_voteshare_inc ln_income_per i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku ln_staff_all compe_rate_adopt age_mean_cand ratio_women_cand_adopt cand_ratio_musyozoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019, gmm(i.cate_change_salary lnsalary_am_kokuji i.cate_change_salary#c.ln_population L.adjusted_ave_voteshare_inc) ivstyle(i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku compe_rate_adopt age_mean_cand win_ratio_musyozoku_pre ratio_women_cand_adopt cand_ratio_musyozoku expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all) twostep robust
estimates store r5, title("sys GMM")
estadd local municipality "Yes": r5
estadd local year "Yes": r5

xtabond2 adjusted_ave_voteshare_inc lnsalary_am_kokuji i.cate_change_salary##c.ln_population##c.ln_population L1.adjusted_ave_voteshare_inc ln_income_per i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku ln_staff_all compe_rate_adopt age_mean_cand ratio_women_cand_adopt cand_ratio_musyozoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019, gmm(i.cate_change_salary lnsalary_am_kokuji i.cate_change_salary#c.ln_population i.cate_change_salary#c.ln_population#c.ln_population L.adjusted_ave_voteshare_inc) ivstyle(i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku compe_rate_adopt age_mean_cand win_ratio_musyozoku_pre ratio_women_cand_adopt cand_ratio_musyozoku expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all) twostep robust
estimates store r6, title("sys GMM")
estadd local municipality "Yes": r6
estadd local year "Yes": r6

esttab r1 r2 r3 r4 r5 r6 using "inc_gmm.tex", replace ///
b(3) se(3) star(* 0.10 ** 0.05 *** 0.01) booktabs ///
drop( _cons *.nendo) nogaps ///
stats(year municipality N, fmt(%9.0f %9.0f %9.0f) labels("年度固定効果" "自治体固定効果" "観測数")) ///
label nolz varwidth(16) modelwidth(13) style(tex)  ///
title(被説明変数: 投票率(%)) coeflabels(lnsalary_am_kokuji "対数議員報酬額" 1.cate_change_salary "増額ダミー" 2.cate_change_salary "減額ダミー" /// 
ln_population "対数人口" n_seats_adopt "議席数" population_elderly75_ratio "全人口に占める75歳以上の割合" population_child15_ratio "全人口に占める15歳未満の割合"  ///
ln_income_per "納税者1人あたり課税対象所得" ln_all_menseki "対数面積" canlive_ratio_menseki "可住地面積割合" sigaika_ratio_area "市街化区域面積割合" ln_zaiseiryoku ///
"対数財政力指数" win_ratio_musyozoku_pre "前回当選者に占める無所属の割合" ln_staff_all "対数自治体職員数" ///
age_mean_cand "立候補者平均年齢" cand_ratio_musyozoku "立候補者無所属割合" ratio_women_cand_adopt "立候補者女性割合" compe_rate_adopt "1議席あたり立候補者数" touitsu_2011 "2011年統一選ダミー" touitsu_2015 "2015年統一選ダミー" touitsu_2019 "2019年統一選ダミー" expired_dummy "任期満了ダミー" ///
1.cate_change_salary#c.ln_population "増額ダミー $\times$ 対数人口" 2.cate_change_salary#c.ln_population "減額ダミー $\times$ 対数人口" ///
1.cate_change_salary#c.ln_population#c.ln_population "増額ダミー $\times$ 対数人口2乗" 2.cate_change_salary#c.ln_population#c.ln_population ///
"減額ダミー \times 対数人口2乗" c.ln_population#c.ln_population "対数人口2乗" L.voting_rate_isna "投票率_1期ラグ") ///
order(lnsalary_am_kokuji 1.cate_change_salary 2.cate_change_salary) ///
mlabels(, span prefix(\multicolumn{@span}{c}{) suffix(})) ///
prehead("\documentclass[8pt]{jsarticle}" "\pagestyle{empty}" "\usepackage{booktabs}""\usepackage{siunitx}""\usepackage{lscape}" ///
"\usepackage[margin=20truemm]{geometry}""\sisetup{input-symbols = ()}""\begin{document}""\begin{table}\caption{@title}" ///
"\def\sym#1{\ifmmode^{#1}\else\(^{#1}\)\fi}""\begin{center}" ///
"\sisetup{table-space-text-post = \sym{***}}""\begin{tabular}{l*{@M}{llll}}""\toprule") posthead(\midrule) prefoot(\midrule) ///
postfoot("\bottomrule""\end{tabular}""\end{center}""\end{table}""\end{document}")





