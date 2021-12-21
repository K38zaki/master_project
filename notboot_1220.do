reg lnsalary_am_kokuji ln_mean_prefbigtype_1yago ln_income_per ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku i.expired_dummy i.touitsu_2011 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type age_mean_wins ratio_women_wins_adopt win_ratio_musyozoku if teian_jyorei_4y != ., vce(cluster pres_pm_codes)

predict Xuhat, resid

poisson teian_jyorei_4y lnsalary_am_kokuji Xuhat ln_income_per ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku i.expired_dummy i.touitsu_2011 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type age_mean_wins ratio_women_wins_adopt win_ratio_musyozoku, vce(cluster pres_pm_codes)

eststo m1: margins, dydx(lnsalary_am_kokuji Xuhat ln_income_per ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku i.expired_dummy touitsu_2011 ln_staff_all ln_salary_staff_all age_mean_wins ratio_women_wins_adopt win_ratio_musyozoku) post

esttab m1 using "teian_cont_notboot_2sri.tex", replace ///
star(* 0.10 ** 0.05 *** 0.01) booktabs ///
label b(3) se(3) stats(N, fmt(%9.0f) labels("観測数")) ///
nolz varwidth(16) modelwidth(13) style(tex)

drop Xuhat
reg lnsalary_am_kokuji ln_mean_prefbigtype_1yago ln_income_per ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type compe_rate_adopt if dummy_forfeit_deposit != . , vce(cluster pres_pm_codes)
test  ln_mean_prefbigtype_1yago

predict Xuhat, resid

probit dummy_forfeit_deposit lnsalary_am_kokuji Xuhat ln_income_per ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type compe_rate_adopt, vce(cluster pres_pm_codes)
eststo m2 :margins, dydx(lnsalary_am_kokuji ln_income_per ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all compe_rate_adopt) post

esttab m2 using "depo_notboot_2sri.tex", replace ///
star(* 0.10 ** 0.05 *** 0.01) booktabs ///
label b(3) se(3) stats(N, fmt(%9.0f) labels("観測数")) ///
nolz varwidth(16) modelwidth(13) style(tex)


ivreg2 voting_rate_p (dummy_up_salary_am dummy_down_salary_am = upratio downratio) ln_income_per ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type compe_rate_adopt ratio_women_cand_adopt age_mean_cand cand_ratio_musyozoku, cluster(pres_pm_codes)
estat first

ivreg2 voting_rate_p (dummy_up_salary_am  = upratio) ln_income_per ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type compe_rate_adopt ratio_women_cand_adopt age_mean_cand cand_ratio_musyozoku, cluster(pres_pm_codes)

ivregress 2sls voting_rate_p (dummy_up_salary_am  = upratio) ln_income_per ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type compe_rate_adopt ratio_women_cand_adopt age_mean_cand cand_ratio_musyozoku, vce(cluster pres_pm_codes)
estat first

ivreg2 voting_rate_p (dummy_down_salary_am  = downratio) ln_income_per ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type compe_rate_adopt ratio_women_cand_adopt age_mean_cand cand_ratio_musyozoku, cluster(pres_pm_codes)
