
estimates clear
**compe
regress compe_rate_adopt c.lnsalary_am_kokuji##c.ln_population ln_income_per n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type, vce(cluster pres_pm_codes)

poisson compe_rate_minus1_adj c.lnsalary_am_kokuji##c.ln_population ln_income_per n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type, vce(cluster pres_pm_codes)
estimates store r1, title("compe PPML")
margins, dydx(lnsalary_am_kokuji) at(ln_population = (5 (0.5) 15))

xtabond2 compe_rate_adopt c.lnsalary_am_kokuji##c.ln_population L1.compe_rate_adopt i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all, gmm(ln_mean_prefbigtype_1yago c.ln_mean_prefbigtype_1yago#c.ln_population L.compe_rate_adopt) ivstyle(i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all) noleveleq robust twostep

xtabond2 compe_rate_adopt c.lnsalary_am_kokuji##c.ln_population L1.compe_rate_adopt i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all, gmm(ln_mean_prefbigtype_1yago c.ln_mean_prefbigtype_1yago#c.ln_population L.compe_rate_adopt) ivstyle(i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all) robust twostep

margins, dydx(lnsalary_am_kokuji) at(ln_population = (5 (0.5) 15))

**novote
regress no_voting_ratio_win c.lnsalary_am_kokuji##c.ln_population ln_income_per n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type, vce(cluster pres_pm_codes)

ivreg2 no_voting_ratio_win (lnsalary_am_kokuji c.lnsalary_am_kokuji#c.ln_population = ln_mean_prefbigtype_1yago c.ln_mean_prefbigtype_1yago#c.ln_population) ln_income_per ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type, cluster(pres_pm_codes)
margins, dydx(lnsalary_am_kokuji) at(ln_population = (5 (0.5) 15))

**women

regress ratio_women_cand_adopt c.lnsalary_am_kokuji##c.ln_population ln_income_per n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type, vce(cluster pres_pm_codes)

ivreg2 ratio_women_cand_adopt (c.lnsalary_am_kokuji c.lnsalary_am_kokuji#c.ln_population = c.ln_mean_prefbigtype_1yago c.ln_mean_prefbigtype_1yago#c.ln_population) ln_income_per n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type, cluster(pres_pm_codes)
margins, dydx(lnsalary_am_kokuji) at(ln_population = (5 (0.5) 15))

fracreg probit ratio_women_cand_adopt c.lnsalary_am_kokuji##c.ln_population ln_income_per n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type, vce(cluster pres_pm_codes)
estimates store r2, title("women FML")
margins, dydx(lnsalary_am_kokuji) at(ln_population = (5 (0.5) 15))

xtabond2 ratio_women_cand_adopt c.lnsalary_am_kokuji##c.ln_population L1.ratio_women_cand_adopt i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all, gmm(ln_mean_prefbigtype_1yago c.ln_mean_prefbigtype_1yago#c.ln_population L.ratio_women_cand_adopt) ivstyle(i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all) noleveleq robust twostep

xtabond2 ratio_women_cand_adopt c.lnsalary_am_kokuji##c.ln_population L1.ratio_women_cand_adopt i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all, gmm(ln_mean_prefbigtype_1yago c.ln_mean_prefbigtype_1yago#c.ln_population L.ratio_women_cand_adopt) ivstyle(i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all) robust twostep

**age

regress age_mean_cand c.lnsalary_am_kokuji##c.ln_population ln_income_per n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type, vce(cluster pres_pm_codes)
estimates store r3, title("age OLS")

ivreg2 age_mean_cand (lnsalary_am_kokuji c.lnsalary_am_kokuji#c.ln_population = ln_mean_prefbigtype_1yago c.ln_mean_prefbigtype_1yago#c.ln_population) ln_income_per ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type, cluster(pres_pm_codes)
estimates store r4, title("age 2SLS")
eststo m4 :margins, dydx(lnsalary_am_kokuji) at(ln_population = (5 (0.5) 15)) post

xtabond2 age_mean_cand c.lnsalary_am_kokuji##c.ln_population L1.age_mean_cand i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all, gmm(ln_mean_prefbigtype_1yago c.ln_mean_prefbigtype_1yago#c.ln_population L.age_mean_cand) ivstyle(i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all) noleveleq robust twostep
margins, dydx(lnsalary_am_kokuji) at(ln_population = (5 (0.5) 15))

xtabond2 ratio_women_cand_adopt c.lnsalary_am_kokuji##c.ln_population L1.ratio_women_cand_adopt i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all, gmm(ln_mean_prefbigtype_1yago c.ln_mean_prefbigtype_1yago#c.ln_population L.age_mean_cand) ivstyle(i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all) robust twostep

**deposit

probit dummy_forfeit_deposit c.lnsalary_am_kokuji##c.ln_population ln_income_per n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type compe_rate_adopt, vce(cluster pres_pm_codes)
estimates store r5, title("depo Probit")

ivreg2 dummy_forfeit_deposit (lnsalary_am_kokuji c.lnsalary_am_kokuji#c.ln_population = ln_mean_prefbigtype_1yago c.ln_mean_prefbigtype_1yago#c.ln_population) ln_income_per ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type compe_rate_adopt, cluster(pres_pm_codes)
estimates store r6, title("depo 2SLS")

esttab r1 r2 r3 r4 r5 r6 using "interaction_first_tab.tex", replace ///
b(3) se(3) star(* 0.10 ** 0.05 *** 0.01) booktabs ///
keep(lnsalary_am_kokuji c.lnsalary_am_kokuji#c.ln_population ln_population) nogaps ///
stats(year municipality N, fmt(%9.0f %9.0f %9.0f) labels("年度固定効果" "自治体固定効果" "観測数")) ///
label nolz varwidth(16) modelwidth(13) style(tex)  ///
title(対数人口との交差項) coeflabels(lnsalary_am_kokuji "対数議員報酬額" c.lnsalary_am_kokuji#c.ln_population "対数議員報酬額 $\times$ 対数人口" ln_population "対数人口") ///
mlabels(, span prefix(\multicolumn{@span}{c}{) suffix(})) ///
prehead("\sisetup{table-space-text-post = \sym{***}}""\begin{tabular}{l*{@M}{llll}}""\toprule") posthead(\midrule) prefoot(\midrule) ///
postfoot("\bottomrule""\end{tabular}")

esttab m4, b(3) ci(3) star(* 0.10 ** 0.05 *** 0.01)

*** voting

estimates clear
xtreg voting_rate_p dummy_up_salary_am##c.ln_population ln_income_per n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo compe_rate_adopt ratio_women_cand_adopt age_mean_cand cand_ratio_musyozoku, fe vce(cluster pres_pm_codes)
estimates store r1, title("votup")

xtreg voting_rate_p dummy_up_salary_am##c.ln_population##c.ln_population ln_income_per n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo compe_rate_adopt ratio_women_cand_adopt age_mean_cand cand_ratio_musyozoku, fe vce(cluster pres_pm_codes)
estimates store r2, title("votup")

xtreg voting_rate_p dummy_down_salary_am##c.ln_population ln_income_per n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo compe_rate_adopt ratio_women_cand_adopt age_mean_cand cand_ratio_musyozoku, fe vce(cluster pres_pm_codes)
estimates store r3, title("votdown")

xtreg voting_rate_p dummy_down_salary_am##c.ln_population##c.ln_population ln_income_per n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo compe_rate_adopt ratio_women_cand_adopt age_mean_cand cand_ratio_musyozoku, fe vce(cluster pres_pm_codes)
estimates store r4, title("votdown")

esttab r1 r2 r3 r4 using "interaction_voting_fe.tex", replace ///
b(3) se(3) star(* 0.10 ** 0.05 *** 0.01) booktabs ///
keep(1.dummy_up_salary_am 1.dummy_up_salary_am#c.ln_population 1.dummy_up_salary_am#c.ln_population#c.ln_population ln_population c.ln_population#c.ln_population ///
1.dummy_down_salary_am 1.dummy_down_salary_am#c.ln_population 1.dummy_down_salary_am#c.ln_population#c.ln_population) nogaps ///
stats(N, fmt(%9.0f) labels("観測数")) ///
label nolz varwidth(16) modelwidth(13) style(tex)  ///
title(対数人口との交差項) coeflabels(1.dummy_up_salary_am "増額ダミー" 1.dummy_up_salary_am#c.ln_population "増額ダミー $\times$ 対数人口" ///
c.lnsalary_am_kokuji#c.ln_population#c.ln_population "増額ダミー $\times$ 対数人口2乗" 1.dummy_down_salary_am "減額ダミー" 1.dummy_down_salary_am#c.ln_population ///
 "減額ダミー $\times$ 対数人口"1.dummy_down_salary_am#c.ln_population#c.ln_population "減額ダミー $\times$ 対数人口2乗" ln_population "対数人口" ///
c.ln_population#c.ln_population "対数人口2乗") ///
mlabels(, span prefix(\multicolumn{@span}{c}{) suffix(})) ///
prehead("\sisetup{table-space-text-post = \sym{***}}""\begin{tabular}{l*{@M}{llll}}""\toprule") posthead(\midrule) prefoot(\midrule) ///
postfoot("\bottomrule""\end{tabular}")


xtabond2 voting_rate_p dummy_up_salary_am##c.ln_population L1.voting_rate_p ln_income_per i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku ln_staff_all ln_salary_staff_all compe_rate_adopt age_mean_cand ratio_women_cand_adopt cand_ratio_musyozoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019, gmm(upratio c.upratio#c.ln_population L.voting_rate_p) ivstyle(i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku compe_rate_adopt age_mean_cand win_ratio_musyozoku_pre ratio_women_cand_adopt cand_ratio_musyozoku expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all) noleveleq twostep robust

xtabond2 voting_rate_p dummy_down_salary_am##c.ln_population L1.voting_rate_p ln_income_per i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku ln_staff_all ln_salary_staff_all compe_rate_adopt age_mean_cand ratio_women_cand_adopt cand_ratio_musyozoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019, gmm(downratio c.downratio#c.ln_population L.voting_rate_p) ivstyle(i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku compe_rate_adopt age_mean_cand win_ratio_musyozoku_pre ratio_women_cand_adopt cand_ratio_musyozoku expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all) noleveleq twostep robust
margins, dydx(dummy_down_salary_am) at(ln_population = (5 (0.5) 15))

xtabond2 voting_rate_p dummy_up_salary_am##c.ln_population##c.ln_population L1.voting_rate_p ln_income_per i.nendo n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku ln_staff_all ln_salary_staff_all compe_rate_adopt age_mean_cand ratio_women_cand_adopt cand_ratio_musyozoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019, gmm(upratio c.upratio#c.ln_population c.upratio#c.ln_population#c.ln_population L.voting_rate_p) ivstyle(i.nendo ln_population c.ln_population#c.ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku compe_rate_adopt age_mean_cand win_ratio_musyozoku_pre ratio_women_cand_adopt cand_ratio_musyozoku expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all) noleveleq twostep robust
margins, dydx(dummy_up_salary_am) at(ln_population = (5 (0.5) 15))

xtabond2 voting_rate_p dummy_down_salary_am##c.ln_population##c.ln_population L1.voting_rate_p ln_income_per i.nendo n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku ln_staff_all ln_salary_staff_all compe_rate_adopt age_mean_cand ratio_women_cand_adopt cand_ratio_musyozoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019, gmm(downratio c.downratio#c.ln_population c.downratio#c.ln_population#c.ln_population L.voting_rate_p) ivstyle(i.nendo ln_population c.ln_population#c.ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku compe_rate_adopt age_mean_cand win_ratio_musyozoku_pre ratio_women_cand_adopt cand_ratio_musyozoku expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all) noleveleq twostep robust
margins, dydx(dummy_down_salary_am) at(ln_population = (5 (0.5) 15))

**incumbent

estimates clear

xtreg adjusted_ave_voteshare_inc dummy_up_salary##c.ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo ratio_women_cand_adopt age_mean_cand cand_ratio_musyozoku, fe vce(cluster pres_pm_codes)
estimates store r1, title("incup")

xtreg adjusted_ave_voteshare_inc dummy_up_salary##c.ln_population##c.ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo  ratio_women_cand_adopt age_mean_cand cand_ratio_musyozoku, fe vce(cluster pres_pm_codes)
estimates store r2, title("incup")

xtreg adjusted_ave_voteshare_inc dummy_down_salary##c.ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo  ratio_women_cand_adopt age_mean_cand cand_ratio_musyozoku, fe vce(cluster pres_pm_codes)
estimates store r3, title("incdown")

xtreg adjusted_ave_voteshare_inc dummy_down_salary##c.ln_population##c.ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo ratio_women_cand_adopt age_mean_cand cand_ratio_musyozoku, fe vce(cluster pres_pm_codes)
estimates store r4, title("incdown")



esttab r1 r2 r3 r4 using "interaction_incum_fe.tex", replace ///
b(3) se(3) star(* 0.10 ** 0.05 *** 0.01) booktabs ///
keep(1.dummy_up_salary_am 1.dummy_up_salary_am#c.ln_population 1.dummy_up_salary_am#c.ln_population#c.ln_population ln_population c.ln_population#c.ln_population ///
1.dummy_down_salary_am 1.dummy_down_salary_am#c.ln_population 1.dummy_down_salary_am#c.ln_population#c.ln_population) nogaps ///
stats(N, fmt(%9.0f) labels("観測数")) ///
label nolz varwidth(16) modelwidth(13) style(tex)  ///
title(対数人口との交差項) coeflabels(1.dummy_up_salary_am "増額ダミー" 1.dummy_up_salary_am#c.ln_population "増額ダミー $\times$ 対数人口" ///
1.dummy_up_salary_am#c.ln_population#c.ln_population "増額ダミー $\times$ 対数人口2乗" 1.dummy_down_salary_am "減額ダミー" 1.dummy_down_salary_am#c.ln_population ///
"減額ダミー $\times$ 対数人口"1.dummy_down_salary_am#c.ln_population#c.ln_population "減額ダミー $\times$ 対数人口2乗" ln_population "対数人口" ///
c.ln_population#c.ln_population "対数人口2乗") ///
mlabels(, span prefix(\multicolumn{@span}{c}{) suffix(})) ///
prehead("\sisetup{table-space-text-post = \sym{***}}""\begin{tabular}{l*{@M}{llll}}""\toprule") posthead(\midrule) prefoot(\midrule) ///
postfoot("\bottomrule""\end{tabular}")


**jyorei_4y
poisson teian_jyorei_4y c.lnsalary_am_kokuji##c.ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo , vce(cluster pres_pm_codes)
estimates store r4, title("incdown")


poisson teian_jyorei_4y c.lnsalary_am_kokuji##c.ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo win_ratio_musyozoku age_mean_wins ratio_women_wins_adopt, vce(cluster pres_pm_codes)

reg lnsalary_am_kokuji c.ln_mean_prefbigtype_1yago##c.ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo win_ratio_musyozoku age_mean_wins ratio_women_wins_adopt if teian_jyorei_4y != ., vce(cluster pres_pm_codes)

predict xu_hat_jy1, resid

reg lnsala_int_lnpopu c.ln_mean_prefbigtype_1yago##c.ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo win_ratio_musyozoku age_mean_wins ratio_women_wins_adopt if teian_jyorei_4y != . ,vce(cluster pres_pm_codes)

predict xu_hat_jy2, resid

poisson teian_jyorei_4y xu_hat_jy1 xu_hat_jy2 c.lnsalary_am_kokuji##c.ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo win_ratio_musyozoku age_mean_wins ratio_women_wins_adopt, vce(cluster pres_pm_codes)

margins, dydx(lnsalary_am_kokuji) at(ln_population = (5 (0.5) 15))



