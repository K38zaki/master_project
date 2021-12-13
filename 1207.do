
rename Nendo nendo
** 減額に対しての反応
xtreg compe_rate_adopt c.lnsalary_am_kokuji i.cate_change_salary ln_population ln_income_per i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku ln_staff_all win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019,fe vce(cluster pres_pm_codes)
**ない

xtreg compe_rate_adopt i.cate_change_salary ln_population ln_income_per i.Nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku ln_staff_all win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019,fe vce(cluster pres_pm_codes)

xtreg ratio_women_cand_adopt i.cate_change_salary ln_population ln_income_per i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku ln_staff_all win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019,fe vce(cluster pres_pm_codes)

xtreg ratio_women_cand_adopt c.lnsalary_am_kokuji i.cate_change_salary ln_population ln_income_per i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku ln_staff_all win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019,fe vce(cluster pres_pm_codes)

xtreg age_mean_cand i.cate_change_salary ln_population ln_income_per i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku ln_staff_all win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019,fe vce(cluster pres_pm_codes)

xtreg age_mean_cand c.lnsalary_am_kokuji i.cate_change_salary ln_population ln_income_per i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku ln_staff_all win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019,fe vce(cluster pres_pm_codes)

reg age_mean_cand c.lnsalary_am_kokuji ln_population ln_income_per i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku ln_staff_all win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 i.pref_id i.muni_type ,vce(cluster pres_pm_codes)

reg ratio_women_cand_adopt c.lnsalary_am_kokuji ln_population ln_income_per i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku ln_staff_all win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 i.pref_id i.muni_type ,vce(cluster pres_pm_codes)

reg compe_rate_adopt c.lnsalary_am_kokuji ln_population ln_income_per i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku ln_staff_all win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 i.pref_id i.muni_type ,vce(cluster pres_pm_codes)

xtabond2 compe_rate_adopt lnsalary_am_kokuji i.cate_change_salary L1.compe_rate_adopt i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all, gmm(lnsalary_am_kokuji i.cate_change_salary L.compe_rate_adopt) ivstyle(i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all) noleveleq robust twostep
*減額で増える、レベルで増える

xtabond2 compe_rate_adopt lnsalary_am_kokuji i.cate_change_salary L1.compe_rate_adopt i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all, gmm(lnsalary_am_kokuji i.cate_change_salary L.compe_rate_adopt) ivstyle(i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all) robust twostep
*減額で増える

xtreg compe_rate_adopt c.lnsalary_am_kokuji##i.dummy_down_salary ln_population ln_income_per i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku ln_staff_all win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019,fe vce(cluster pres_pm_codes)

margins, dydx(dummy_down_salary) at(lnsalary_am_kokuji = (6.5 7 7.5 8 8.5 9))

xtreg compe_rate_adopt c.lnsalary_am_kokuji c.ln_population##i.dummy_down_salary ln_income_per i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku ln_staff_all win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019,fe vce(cluster pres_pm_codes)

margins, dydx(dummy_down_salary) at(ln_population = (6 7 8 9 10 11 12 13 14 15))


**人口に対しての反応(2乗項との比較) →　人口に対して説明しやすい？
xtreg compe_rate_adopt c.lnsalary_am_kokuji##c.ln_population ln_income_per i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku ln_staff_all win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019,fe vce(cluster pres_pm_codes)

margins, dydx(lnsalary_am_kokuji) at(ln_population = (5 6 7 8 9 10 11 12 13 14 15))

xtreg compe_rate_adopt c.lnsalary_am_kokuji##c.lnsalary_am_kokuji ln_income_per i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku ln_staff_all win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019,fe vce(cluster pres_pm_codes)

margins, at(lnsalary_am_kokuji = (6.5 7 7.5 8 8.5 9))
margins, dydx(lnsalary_am_kokuji) at(lnsalary_am_kokuji = (6.5 7 7.5 8 8.5 9))

xtabond2 compe_rate_adopt c.lnsalary_am_kokuji##c.ln_population ln_income_per i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku ln_staff_all win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019, gmm(c.lnsalary_am_kokuji c.lnsalary_am_kokuji#c.ln_population) ivstyle(i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all) noleveleq robust twostep 

margins, dydx(lnsalary_am_kokuji) at(ln_population = (5 6 7 8 9 10 11 12 13 14 15))
margins, e at(lnsalary_am_kokuji = (6.5 7 7.5 8 8.5 9)) 
marginsplot 

xtabond2 compe_rate_adopt c.lnsalary_am_kokuji##c.lnsalary_am_kokuji ln_income_per i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku ln_staff_all win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019, gmm(c.lnsalary_am_kokuji c.lnsalary_am_kokuji#c.lnsalary_am_kokuji) ivstyle(i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all) robust twostep 
margins, dydx(lnsalary_am_kokuji) at(ln_population = (5 6 7 8 9 10 11 12 13 14 15))
margins, predict() at(lnsalary_am_kokuji = (6.5 7 7.5 8 8.5 9)) 
marginsplot

xtabond2 compe_rate_adopt c.lnsalary_am_kokuji##c.lnsalary_am_kokuji L1.compe_rate_adopt ln_income_per i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku ln_staff_all win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019, gmm(c.lnsalary_am_kokuji c.lnsalary_am_kokuji#c.lnsalary_am_kokuji L.compe_rate_adopt) ivstyle(i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all) robust twostep 
margins, dydx(lnsalary_am_kokuji) at(lnsalary_am_kokuji = (6.5 7 7.5 8 8.5 9))
margins, predict() at(lnsalary_am_kokuji = (6.5 7 7.5 8 8.5 9)) 
marginsplot

drop pred_compe_ab_l
predict pred_compe_ab_l, xb
sum pred_compe_ab_l
scatter compe_rate_adopt pred_compe_ab_l

xtabond2 compe_rate_adopt c.lnsalary_am_kokuji##c.lnsalary_am_kokuji L1.compe_rate_adopt ln_income_per i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku ln_staff_all win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019, gmm(c.lnsalary_am_kokuji c.lnsalary_am_kokuji#c.lnsalary_am_kokuji L.compe_rate_adopt) ivstyle(i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all) noleveleq robust twostep 

drop pred_compe_ab_l
predict pred_compe_ab_l, xb
hist pred_compe_ab_l
scatter compe_rate_adopt pred_compe_ab_l

margins, predict() at(lnsalary_am_kokuji = (6.5 7 7.5 8 8.5 9)) 
marginsplot

xtabond2 compe_rate_adopt c.lnsalary_am_kokuji ln_income_per L1.compe_rate_adopt i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku ln_staff_all win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ele_t, gmm(c.lnsalary_am_kokuji L.compe_rate_adopt) ivstyle(i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ele_t) noleveleq robust twostep 
margins, dydx(lnsalary_am_kokuji) at(ln_population = (5 6 7 8 9 10 11 12 13 14 15))



drop pred_compe_ab_l
predict pred_compe_ab_l, xb
sum pred_compe_ab_l
scatter compe_rate_adopt pred_compe_ab_l

margins, at(lnsalary_am_kokuji = (6.5 7 7.5 8 8.5 9))
marginsplot

** noleveleq のとき　margins が奇妙

