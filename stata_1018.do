tsset pres_pm_codes months_old

tab voting_rate_isna if voting_rate_isna > 100
replace voting_rate_isna = . if voting_rate_isna > 100

histogram voting_rate_isna

gen cate_change_salary = .
replace cate_change_salary = 1 if dummy_up_salary == 1
replace cate_change_salary = 2 if dummy_down_salary == 1
replace cate_change_salary = 0 if (dummy_down_salary == 0) & (dummy_up_salary == 0)

** COMPE RATIO

xtreg compe_ratio_isna salary_am_kokuji population population_elderly75_ratio population_child15_ratio income_per_syotokuwari all_menseki canlive_ratio_menseki i.year, fe vce(cluster pres_pm_codes)

xtreg compe_ratio_isna i.dummy_up_salary i.dummy_down_salary population population_elderly75_ratio population_child15_ratio income_per_syotokuwari all_menseki canlive_ratio_menseki i.year, fe vce(cluster pres_pm_codes)


xtreg compe_ratio_isna i.cate_change_salary i.cate_change_salary#c.abs_change_salary population population_elderly75_ratio population_child15_ratio income_per_syotokuwari all_menseki canlive_ratio_menseki i.year, fe vce(cluster pres_pm_codes)

xtreg compe_ratio_isna c.salary_am_kokuji i.cate_change_salary i.cate_change_salary#c.abs_change_salary population population_elderly75_ratio population_child15_ratio income_per_syotokuwari all_menseki canlive_ratio_menseki i.year, fe vce(cluster pres_pm_codes)

xtreg compe_ratio_isna  i.cate_change_salary#c.abs_change_salary population population_elderly75_ratio population_child15_ratio income_per_syotokuwari all_menseki canlive_ratio_menseki i.year, fe vce(cluster pres_pm_codes)

**VOTING RATIO

xtreg voting_rate_isna salary_am_kokuji population population_elderly75_ratio population_child15_ratio income_per_syotokuwari all_menseki canlive_ratio_menseki i.year, fe vce(cluster pres_pm_codes)

xtreg voting_rate_isna i.dummy_up_salary i.dummy_down_salary population population_elderly75_ratio population_child15_ratio income_per_syotokuwari all_menseki canlive_ratio_menseki i.year, fe vce(cluster pres_pm_codes)

xtreg voting_rate_isna i.cate_change_salary i.cate_change_salary#c.abs_change_salary population population_elderly75_ratio population_child15_ratio income_per_syotokuwari all_menseki canlive_ratio_menseki i.year, fe vce(cluster pres_pm_codes)

xtreg voting_rate_isna  i.cate_change_salary#c.abs_change_salary population population_elderly75_ratio population_child15_ratio income_per_syotokuwari all_menseki canlive_ratio_menseki i.year, fe vce(cluster pres_pm_codes)


