

* adj_voteshare_inc
* with categorical up - down
** OLS
reg adjusted_ave_voteshare_inc i.cate_change_salary ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type compe_rate_adopt ratio_women_cand_adopt age_mean_cand cand_ratio_musyozoku, vce(cluster pres_pm_codes)
estimates store r_ols, title("OLS")
** → ミス

reg adjusted_ave_voteshare_inc i.cate_change_salary ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type ratio_women_cand_adopt age_mean_cand cand_ratio_musyozoku, vce(cluster pres_pm_codes)

** FPML
fracreg probit adjusted_ave_voteshare_inc i.cate_change_salary ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type ratio_women_cand_adopt age_mean_cand cand_ratio_musyozoku, vce(cluster pres_pm_codes)
eststo r_fpml :margins, dydx(*) post


** 2SLS
ivreg2 adjusted_ave_voteshare_inc (ib(0).cate_change_salary = upratio downratio) ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type ratio_women_cand_adopt age_mean_cand cand_ratio_musyozoku, cluster(pres_pm_codes)
estimates store r_2sls, title("2SLS")
* 検定アウトであり、不適切


** 2SRI
capture drop i_up_xu_hat_2 i_down_xu_hat_2
reg dummy_up_salary upratio downratio ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type ratio_women_cand_adopt age_mean_cand cand_ratio_musyozoku if adjusted_ave_voteshare_inc != ., vce(cluster pres_pm_codes)
predict i_up_xu_hat_2, resid
test upratio downratio

reg dummy_down_salary upratio downratio ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type ratio_women_cand_adopt age_mean_cand cand_ratio_musyozoku if adjusted_ave_voteshare_inc != ., vce(cluster pres_pm_codes)
predict i_down_xu_hat_2, resid
test upratio downratio


fracreg probit adjusted_ave_voteshare_inc i.cate_change_salary i_up_xu_hat_2 i_down_xu_hat_2 ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type  ratio_women_cand_adopt age_mean_cand cand_ratio_musyozoku, vce(cluster pres_pm_codes)
*gen sample_2sri_inc = 0 
*replace sample_2sri_inc = 1 if e(sample) == 1
eststo r_2sri :margins, dydx(*) post


**FE
xtreg adjusted_ave_voteshare_inc i.cate_change_salary ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo ratio_women_cand_adopt age_mean_cand cand_ratio_musyozoku, fe vce(cluster pres_pm_codes)
eststo r_fe :margins, dydx(*) post

**FEIV
xtivreg adjusted_ave_voteshare_inc (dummy_up_salary dummy_down_salary = upratio downratio) ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo ratio_women_cand_adopt age_mean_cand cand_ratio_musyozoku, fe vce(cluster pres_pm_codes)
eststo r_feiv :margins, dydx(*) post

xtivreg2 adjusted_ave_voteshare_inc (dummy_up_salary dummy_down_salary = upratio downratio) ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all nendo1-nendo15 ratio_women_cand_adopt age_mean_cand cand_ratio_musyozoku, fe cluster(pres_pm_codes)

xtivreg adjusted_ave_voteshare_inc (dummy_up_salary = upratio) ln_income_per ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo ratio_women_cand_adopt age_mean_cand cand_ratio_musyozoku, fe vce(cluster pres_pm_codes)

esttab r_ols r_fpml r_2sls r_2sri r_fe r_feiv using "incupdown_0604.tex", replace ///
b(3) se(3) star(* 0.10 ** 0.05 *** 0.01) booktabs ///
drop(touitsu_2007 *.nendo _cons *.pref_id *.muni_type) nogaps ///
stats(N, fmt(%9.0f) labels("観測数")) ///
label nolz varwidth(16) modelwidth(13) style(tex)  ///
title(被説明変数: 調整済み現職1人あたり得票率) ///
mlabels(, span prefix(\multicolumn{@span}{c}{) suffix(})) ///
prehead("\sisetup{table-space-text-post = \sym{***}}""\begin{tabular}{l*{@M}{llll}}""\toprule") posthead(\midrule) prefoot(\midrule) ///
postfoot("\bottomrule""\end{tabular}")





* voting_rate_p
* with categorical

**OLS
reg voting_rate_p i.cate_change_salary ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type compe_rate_adopt ratio_women_cand_adopt age_mean_cand cand_ratio_musyozoku, vce(cluster pres_pm_codes)
estimates store r_ols, title("OLS")

** FPML
fracreg probit voting_rate_p i.cate_change_salary ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type compe_rate_adopt ratio_women_cand_adopt age_mean_cand cand_ratio_musyozoku, vce(cluster pres_pm_codes)
eststo r_fpml,title("FPML") :margins, dydx(*) post

** 2SLS
ivreg2 voting_rate_p (i.cate_change_salary = upratio downratio) ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type compe_rate_adopt ratio_women_cand_adopt age_mean_cand cand_ratio_musyozoku, cluster(pres_pm_codes)
estimates store r_2sls, title("2SLS")
* 検定アウトであり、不適切


** 2SRI
capture drop v_up_xu_hat_2 v_down_xu_hat_2
reg dummy_up_salary upratio downratio ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type compe_rate_adopt ratio_women_cand_adopt age_mean_cand cand_ratio_musyozoku if voting_rate_p != ., vce(cluster pres_pm_codes)
predict v_up_xu_hat_2, resid
test upratio downratio

reg dummy_down_salary upratio downratio ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type compe_rate_adopt ratio_women_cand_adopt age_mean_cand cand_ratio_musyozoku if voting_rate_p != ., vce(cluster pres_pm_codes)
predict v_down_xu_hat_2, resid
test upratio downratio

fracreg probit voting_rate_p i.cate_change_salary i_up_xu_hat_2 i_down_xu_hat_2 ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type  compe_rate_adopt ratio_women_cand_adopt age_mean_cand cand_ratio_musyozoku, vce(cluster pres_pm_codes)
eststo r_2sri,title("2SRI") :margins, dydx(*) post


** FE
xtreg voting_rate_p i.cate_change_salary ln_income_per ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo compe_rate_adopt ratio_women_cand_adopt age_mean_cand cand_ratio_musyozoku, fe vce(cluster pres_pm_codes)
estimates store r_fe, title("FE")

**FEIV
xtivreg voting_rate_p (dummy_up_salary dummy_down_salary = upratio downratio) ln_income_per ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo compe_rate_adopt ratio_women_cand_adopt age_mean_cand cand_ratio_musyozoku, fe vce(cluster pres_pm_codes)
estimates store r_feiv, title("FEIV")

xtivreg voting_rate_p (dummy_up_salary = upratio) ln_income_per ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo compe_rate_adopt ratio_women_cand_adopt age_mean_cand cand_ratio_musyozoku, fe vce(cluster pres_pm_codes)


esttab r_ols r_fpml r_2sls r_2sri r_fe r_feiv using "voteupdown_0604.tex", replace ///
b(3) se(3) star(* 0.10 ** 0.05 *** 0.01) booktabs ///
drop(touitsu_2007 *.nendo _cons *.pref_id *.muni_type) nogaps ///
stats(N, fmt(%9.0f) labels("観測数")) ///
label nolz varwidth(16) modelwidth(13) style(tex)  ///
title(被説明変数: 投票率) ///
mlabels(, span prefix(\multicolumn{@span}{c}{) suffix(})) ///
prehead("\sisetup{table-space-text-post = \sym{***}}""\begin{tabular}{l*{@M}{llll}}""\toprule") posthead(\midrule) prefoot(\midrule) ///
postfoot("\bottomrule""\end{tabular}")


* 2sri bootstrap
** incumbent
program drop incupdown2sri
program incupdown2sri, rclass

capture drop i_up_xu_hat_2 i_down_xu_hat_2 x1b1hat scale me_*

reg dummy_up_salary upratio downratio ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type ratio_women_cand_adopt age_mean_cand cand_ratio_musyozoku, vce(cluster pres_pm_codes)
predict i_up_xu_hat_2, resid

reg dummy_down_salary upratio downratio ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type ratio_women_cand_adopt age_mean_cand cand_ratio_musyozoku, vce(cluster pres_pm_codes)
predict i_down_xu_hat_2, resid

fracreg probit adjusted_ave_voteshare_inc i.cate_change_salary i_up_xu_hat_2 i_down_xu_hat_2 ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type  ratio_women_cand_adopt age_mean_cand cand_ratio_musyozoku, vce(cluster pres_pm_codes)

margins, dydx(1.cate_change_salary 2.cate_change_salary)
scalar ame_up = r(b)[1,2]
scalar ame_down = r(b)[1,3]

end

drop i_up_xu_hat_2 i_down_xu_hat_2
preserve
drop if sample_2sri_inc == 0
bootstrap ame_up ame_down, reps(1000) seed (5788) cluster(pres_pm_codes) idcluster(new_id_ppm) : incupdown2sri
estimates store res_incupdown2sri, title("2SRI_inc_updown")
restore

preserve
drop if sample_2sri_inc == 0
bootstrap ame_up ame_down, reps(1000) seed (5788) : incupdown2sri
estimates store res_incupdown2sri, title("2SRI_inc_updown")
restore

preserve
drop if sample_inc == 0
bootstrap r(b_Xuhat) r(b_ln_income_per) r(b_ln_population) r(ame_Xuhat) r(ame_ln_income_per) r(ame_ln_population), reps(1000) seed (10101) cluster(pres_pm_codes) idcluster(new_id_ppm): incdown2sri_lnp
estimates store res_incdown_2sri_lnp, title("2SRI_down_inc_p")
restore


** test

preserve
drop if sample_2sri_inc == 0
reg dummy_up_salary upratio downratio ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type ratio_women_cand_adopt age_mean_cand cand_ratio_musyozoku, vce(cluster pres_pm_codes)
predict i_up_xu_hat_2, resid

reg dummy_down_salary upratio downratio ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type ratio_women_cand_adopt age_mean_cand cand_ratio_musyozoku, vce(cluster pres_pm_codes)
predict i_down_xu_hat_2, resid

fracreg probit adjusted_ave_voteshare_inc i.cate_change_salary i_up_xu_hat_2 i_down_xu_hat_2 ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type  ratio_women_cand_adopt age_mean_cand cand_ratio_musyozoku, vce(cluster pres_pm_codes)

margins, dydx(1.cate_change_salary 2.cate_change_salary)
scalar ame_up = r(b)[1,2]
scalar ame_down = r(b)[1,3]





