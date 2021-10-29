** data cleaning

tab voting_rate_isna if voting_rate_isna > 100
replace voting_rate_isna = . if voting_rate_isna > 100

histogram voting_rate_isna

gen cate_change_salary = .
replace cate_change_salary = 1 if dummy_up_salary == 1
replace cate_change_salary = 2 if dummy_down_salary == 1
replace cate_change_salary = 0 if (dummy_down_salary == 0) & (dummy_up_salary == 0)

gen lnsalary_am_kokuji = ln(salary_am_kokuji)


** get recognized as panel

tsset pres_pm_codes months_old
xtsum salary_am_kokuji
xtsum lnsalary_am_kokuji
xtsum ratio_salary
xtsum ln_diff_salary



** Compe Rate

histogram compe_rate_adopt

*pooled ols
reg compe_rate_adopt salary_am_kokuji, vce(cluster pres_pm_codes)
reg compe_rate_adopt salary_am_kokuji i.nendo , vce(cluster pres_pm_codes)
reg compe_rate_adopt salary_am_kokuji population i.nendo , vce(cluster pres_pm_codes)
reg compe_rate_adopt salary_am_kokuji population income_time_year i.nendo , vce(cluster pres_pm_codes)
reg compe_rate_adopt salary_am_kokuji population income_time_year n_seats_adopt i.nendo , vce(cluster pres_pm_codes)
reg compe_rate_adopt salary_am_kokuji population income_time_year population_elderly75_ratio n_seats_adopt i.nendo , vce(cluster pres_pm_codes)
reg compe_rate_adopt salary_am_kokuji population income_time_year population_elderly75_ratio all_menseki n_seats_adopt i.nendo , vce(cluster pres_pm_codes)
reg compe_rate_adopt salary_am_kokuji population income_time_year population_elderly75_ratio all_menseki population_child15_ratio n_seats_adopt i.nendo , vce(cluster pres_pm_codes)
reg compe_rate_adopt salary_am_kokuji population income_time_year population_elderly75_ratio all_menseki population_child15_ratio n_seats_adopt cand_ratio_musyozoku_pre i.nendo , vce(cluster pres_pm_codes)

reg compe_rate_adopt salary_am_kokuji population n_seats_adopt population_elderly75_ratio population_child15_ratio income_time_year all_menseki canlive_ratio_menseki sigaika_ratio_area cand_ratio_musyozoku_pre i.touitsu_ele_dummy i.expired_dummy i.nendo, vce(cluster pres_pm_codes)

xtreg compe_rate_adopt salary_am_kokuji i.nendo , fe vce(cluster pres_pm_codes)

reg compe_rate_adopt salary_am_kokuji,robust

gen salary_12month = 12 * salary_am_kokuji
gen ln_diff_salary = log(salary_12month) - log(income_time_year)
gen ratio_salary = salary_12month/income_time_year
gen persentage_salary = (salary_12month - income_time_year)/income_time_year

xtreg compe_rate_adopt persentage_salary ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_time_year ln_all_menseki canlive_ratio_menseki sigaika_ratio_area cand_ratio_musyozoku_pre i.touitsu_ele_dummy i.expired_dummy i.nendo, fe vce(cluster pres_pm_codes)

xtreg compe_rate_adopt ln_diff_salary ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_time_year ln_all_menseki canlive_ratio_menseki sigaika_ratio_area cand_ratio_musyozoku_pre i.touitsu_ele_dummy i.expired_dummy i.nendo, fe vce(cluster pres_pm_codes)

xtreg compe_rate_adopt ratio_salary ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area cand_ratio_musyozoku_pre i.touitsu_ele_dummy i.expired_dummy i.nendo, fe vce(cluster pres_pm_codes)

xtreg compe_rate_adopt ln_diff_salary population n_seats_adopt population_elderly75_ratio population_child15_ratio income_time_year all_menseki canlive_ratio_menseki sigaika_ratio_area cand_ratio_musyozoku_pre i.touitsu_ele_dummy i.expired_dummy i.nendo, fe vce(cluster pres_pm_codes)

*level
xtreg compe_rate_adopt salary_am_kokuji population n_seats_adopt population_elderly75_ratio population_child15_ratio income_time_year all_menseki canlive_ratio_menseki sigaika_ratio_area cand_ratio_musyozoku_pre i.touitsu_ele_dummy i.expired_dummy i.nendo, fe vce(cluster pres_pm_codes)

*level squared
xtreg compe_rate_adopt c.salary_am_kokuji c.salary_am_kokuji#c.salary_am_kokuji population n_seats_adopt population_elderly75_ratio population_child15_ratio income_time_year all_menseki canlive_ratio_menseki sigaika_ratio_area cand_ratio_musyozoku_pre i.touitsu_ele_dummy i.expired_dummy i.nendo, fe vce(cluster pres_pm_codes)

margins, at (c.salary_am_kokuji = (1000 1500 2000 2500 3000 3500 4000 4500 5000 5500))
marginsplot

reg compe_rate_adopt lnsalary_am_kokuji population n_seats_adopt population_elderly75_ratio population_child15_ratio income_time_year all_menseki canlive_ratio_menseki sigaika_ratio_area cand_ratio_musyozoku_pre i.touitsu_ele_dummy i.expired_dummy i.nendo, vce(cluster pres_pm_codes)

gen ln_population = log(population)
gen ln_income_time_year = log(income_time_year)
gen ln_all_menseki = log(all_menseki)




*log
reg compe_rate_adopt lnsalary_am_kokuji ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_time_year ln_all_menseki canlive_ratio_menseki sigaika_ratio_area cand_ratio_musyozoku_pre i.touitsu_ele_dummy i.expired_dummy i.nendo, vce(cluster pres_pm_codes)

xtreg compe_rate_adopt lnsalary_am_kokuji ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_time_year ln_all_menseki canlive_ratio_menseki sigaika_ratio_area cand_ratio_musyozoku_pre i.touitsu_ele_dummy i.expired_dummy i.nendo, fe vce(cluster pres_pm_codes)

xtreg compe_rate_adopt lnsalary_am_kokuji F48.lnsalary_am_kokuji ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_time_year ln_all_menseki canlive_ratio_menseki sigaika_ratio_area cand_ratio_musyozoku_pre i.touitsu_ele_dummy i.expired_dummy i.nendo, fe vce(cluster pres_pm_codes)

gen ln_salary_am_pre = log(salary_am_pre)

xtreg compe_rate_adopt lnsalary_am_kokuji ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_time_year ln_all_menseki canlive_ratio_menseki sigaika_ratio_area cand_ratio_musyozoku_pre i.touitsu_ele_dummy i.expired_dummy i.nendo if salary_am_kokuji < 6500, fe vce(cluster pres_pm_codes) 

xtreg compe_rate_adopt lnsalary_am_kokuji ln_salary_am_pre ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_time_year ln_all_menseki canlive_ratio_menseki sigaika_ratio_area cand_ratio_musyozoku_pre i.touitsu_ele_dummy i.expired_dummy i.nendo, fe vce(cluster pres_pm_codes)

xtreg compe_rate_adopt lnsalary_am_kokuji ln_salary_am_pre ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_time_year ln_all_menseki canlive_ratio_menseki sigaika_ratio_area cand_ratio_musyozoku_pre i.touitsu_ele_dummy i.expired_dummy i.nendo, fd vce(cluster pres_pm_codes)


xtreg compe_rate_adopt lnsalary_am_kokuji ln_salary_am_pre ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_time_year ln_all_menseki canlive_ratio_menseki sigaika_ratio_area cand_ratio_musyozoku_pre i.touitsu_ele_dummy i.expired_dummy i.nendo, fe vce(cluster pres_pm_codes)

xtreg compe_rate_adopt lnsalary_am_kokuji L48.lnsalary_am_kokuji ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_time_year ln_all_menseki canlive_ratio_menseki sigaika_ratio_area cand_ratio_musyozoku_pre i.touitsu_ele_dummy i.expired_dummy i.nendo, fe vce(cluster pres_pm_codes)


xtreg compe_rate_adopt lnsalary_am_kokuji L48.compe_rate_adopt ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_time_year ln_all_menseki canlive_ratio_menseki sigaika_ratio_area cand_ratio_musyozoku_pre i.touitsu_ele_dummy i.expired_dummy i.nendo, fe vce(cluster pres_pm_codes) 

reg lnsalary_am_kokuji L48.compe_rate_adopt population

reg compe_rate_adopt L48.compe_rate_adopt

xtreg lnsalary_am_kokuji L48.compe_rate_adopt, fe vce(cluster pres_pm_codes)

xtreg lnsalary_am_kokuji L48.compe_rate_adopt ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_time_year ln_all_menseki canlive_ratio_menseki sigaika_ratio_area cand_ratio_musyozoku_pre i.touitsu_ele_dummy i.expired_dummy i.nendo, fe vce(cluster pres_pm_codes)

xtreg lnsalary_am_kokuji L48.compe_rate_adopt ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_time_year ln_all_menseki canlive_ratio_menseki sigaika_ratio_area cand_ratio_musyozoku_pre i.touitsu_ele_dummy i.expired_dummy i.nendo, fe vce(cluster pres_pm_codes)

reg dummy_up_salary L48.compe_rate_adopt 



xtsum lnsalary_am_kokuji compe_rate_adopt



xtreg compe_rate_adopt lnsalary_am_kokuji population n_seats_adopt population_elderly75_ratio population_child15_ratio income_time_year all_menseki canlive_ratio_menseki sigaika_ratio_area cand_ratio_musyozoku_pre i.touitsu_ele_dummy i.expired_dummy i.nendo, fe vce(cluster pres_pm_codes)

* up - down dummy
xtreg compe_rate_adopt i.dummy_up_salary i.dummy_down_salary ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_time_year ln_all_menseki canlive_ratio_menseki sigaika_ratio_area cand_ratio_musyozoku_pre i.touitsu_ele_dummy i.expired_dummy i.nendo, fe vce(cluster pres_pm_codes)

* dummy and change
gen ln_abs_change_salary = log(abs_change_salary)
xtreg compe_rate_adopt i.cate_change_salary i.cate_change_salary#c.ln_abs_change_salary ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio income_time_year ln_all_menseki canlive_ratio_menseki sigaika_ratio_area cand_ratio_musyozoku_pre i.touitsu_ele_dummy i.expired_dummy i.nendo, fe vce(cluster pres_pm_codes)

* change 
xtreg compe_rate_adopt i.cate_change_salary#c.abs_change_salary population n_seats_adopt population_elderly75_ratio population_child15_ratio income_time_year all_menseki canlive_ratio_menseki sigaika_ratio_area cand_ratio_musyozoku_pre i.touitsu_ele_dummy i.expired_dummy i.nendo, fe vce(cluster pres_pm_codes)

* level and change
xtreg compe_rate_adopt salary_am_kokuji i.cate_change_salary#c.abs_change_salary population n_seats_adopt population_elderly75_ratio population_child15_ratio income_time_year all_menseki canlive_ratio_menseki sigaika_ratio_area cand_ratio_musyozoku_pre i.touitsu_ele_dummy i.expired_dummy i.nendo, fe vce(cluster pres_pm_codes)

* interaction with ratio_musyozoku: level
xtreg compe_rate_adopt c.salary_am_kokuji c.salary_am_kokuji#c.cand_ratio_musyozoku_pre population n_seats_adopt population_elderly75_ratio population_child15_ratio income_time_year all_menseki canlive_ratio_menseki sigaika_ratio_area cand_ratio_musyozoku_pre i.touitsu_ele_dummy i.expired_dummy i.nendo, fe vce(cluster pres_pm_codes)

** No Voting Occur

* level
xtreg no_voting_ratio_win salary_am_kokuji population n_seats_adopt population_elderly75_ratio population_child15_ratio income_time_year all_menseki canlive_ratio_menseki sigaika_ratio_area cand_ratio_musyozoku_pre i.touitsu_ele_dummy i.expired_dummy i.nendo, fe vce(cluster pres_pm_codes)

* log
xtreg no_voting_ratio_win lnsalary_am_kokuji population n_seats_adopt population_elderly75_ratio population_child15_ratio income_time_year all_menseki canlive_ratio_menseki sigaika_ratio_area cand_ratio_musyozoku_pre i.touitsu_ele_dummy i.expired_dummy i.nendo, fe vce(cluster pres_pm_codes)

* up - down dummy
xtreg no_voting_ratio_win i.dummy_up_salary i.dummy_down_salary population n_seats_adopt population_elderly75_ratio population_child15_ratio income_time_year all_menseki canlive_ratio_menseki sigaika_ratio_area cand_ratio_musyozoku_pre i.touitsu_ele_dummy i.expired_dummy i.nendo, fe vce(cluster pres_pm_codes)

* dummy and change
xtreg no_voting_ratio_win i.cate_change_salary i.cate_change_salary#c.abs_change_salary population n_seats_adopt population_elderly75_ratio population_child15_ratio income_time_year all_menseki canlive_ratio_menseki sigaika_ratio_area cand_ratio_musyozoku_pre i.touitsu_ele_dummy i.expired_dummy i.nendo, fe vce(cluster pres_pm_codes)

* dummy and change
xtreg no_voting_ratio_win i.cate_change_salary i.cate_change_salary#c.abs_change_salary population n_seats_adopt population_elderly75_ratio population_child15_ratio income_time_year all_menseki canlive_ratio_menseki sigaika_ratio_area cand_ratio_musyozoku_pre i.touitsu_ele_dummy i.expired_dummy i.nendo, fe vce(cluster pres_pm_codes)

* change 
xtreg no_voting_ratio_win i.cate_change_salary#c.abs_change_salary population n_seats_adopt population_elderly75_ratio population_child15_ratio income_time_year all_menseki canlive_ratio_menseki sigaika_ratio_area cand_ratio_musyozoku_pre i.touitsu_ele_dummy i.expired_dummy i.nendo, fe vce(cluster pres_pm_codes) 


* level and change
xtreg no_voting_ratio_win salary_am_kokuji i.cate_change_salary#c.abs_change_salary population n_seats_adopt population_elderly75_ratio population_child15_ratio income_time_year all_menseki canlive_ratio_menseki sigaika_ratio_area cand_ratio_musyozoku_pre i.touitsu_ele_dummy i.expired_dummy i.nendo, fe vce(cluster pres_pm_codes)

* interaction with ratio_musyozoku: level
xtreg no_voting_ratio_win c.salary_am_kokuji c.salary_am_kokuji#c.cand_ratio_musyozoku_pre population n_seats_adopt population_elderly75_ratio population_child15_ratio income_time_year all_menseki canlive_ratio_menseki sigaika_ratio_area cand_ratio_musyozoku_pre i.touitsu_ele_dummy i.expired_dummy i.nendo, fe vce(cluster pres_pm_codes)
** やや仮説と整合的 **


** Women Cand Ratio

*level
xtreg ratio_women_cand_adopt salary_am_kokuji population n_seats_adopt population_elderly75_ratio population_child15_ratio income_time_year all_menseki canlive_ratio_menseki sigaika_ratio_area cand_ratio_musyozoku_pre i.touitsu_ele_dummy i.expired_dummy i.nendo, fe vce(cluster pres_pm_codes)

*level squared
xtreg ratio_women_cand_adopt c.salary_am_kokuji c.salary_am_kokuji#c.salary_am_kokuji population n_seats_adopt population_elderly75_ratio population_child15_ratio income_time_year all_menseki canlive_ratio_menseki sigaika_ratio_area cand_ratio_musyozoku_pre i.touitsu_ele_dummy i.expired_dummy i.nendo, fe vce(cluster pres_pm_codes)

*log
xtreg ratio_women_cand_adopt lnsalary_am_kokuji population n_seats_adopt population_elderly75_ratio population_child15_ratio income_time_year all_menseki canlive_ratio_menseki sigaika_ratio_area cand_ratio_musyozoku_pre i.touitsu_ele_dummy i.expired_dummy i.nendo, fe vce(cluster pres_pm_codes)

* up - down dummy
xtreg ratio_women_cand_adopt  i.dummy_up_salary i.dummy_down_salary population n_seats_adopt population_elderly75_ratio population_child15_ratio income_time_year all_menseki canlive_ratio_menseki sigaika_ratio_area cand_ratio_musyozoku_pre i.touitsu_ele_dummy i.expired_dummy i.nendo, fe vce(cluster pres_pm_codes)

* dummy and change
xtreg ratio_women_cand_adopt  i.cate_change_salary i.cate_change_salary#c.abs_change_salary population n_seats_adopt population_elderly75_ratio population_child15_ratio income_time_year all_menseki canlive_ratio_menseki sigaika_ratio_area cand_ratio_musyozoku_pre i.touitsu_ele_dummy i.expired_dummy i.nendo, fe vce(cluster pres_pm_codes)

* change 
xtreg ratio_women_cand_adopt  i.cate_change_salary#c.abs_change_salary population n_seats_adopt population_elderly75_ratio population_child15_ratio income_time_year all_menseki canlive_ratio_menseki sigaika_ratio_area cand_ratio_musyozoku_pre i.touitsu_ele_dummy i.expired_dummy i.nendo, fe vce(cluster pres_pm_codes)

* level and change
xtreg ratio_women_cand_adopt salary_am_kokuji i.cate_change_salary#c.abs_change_salary population n_seats_adopt population_elderly75_ratio population_child15_ratio income_time_year all_menseki canlive_ratio_menseki sigaika_ratio_area cand_ratio_musyozoku_pre i.touitsu_ele_dummy i.expired_dummy i.nendo, fe vce(cluster pres_pm_codes)

** Mean of Age of Cand

*level
xtreg age_mean_cand_adopt salary_am_kokuji population n_seats_adopt population_elderly75_ratio population_child15_ratio income_time_year all_menseki canlive_ratio_menseki sigaika_ratio_area cand_ratio_musyozoku_pre i.touitsu_ele_dummy i.expired_dummy i.nendo, fe vce(cluster pres_pm_codes)

*level squared
xtreg age_mean_cand_adopt c.salary_am_kokuji c.salary_am_kokuji#c.salary_am_kokuji population n_seats_adopt population_elderly75_ratio population_child15_ratio income_time_year all_menseki canlive_ratio_menseki sigaika_ratio_area cand_ratio_musyozoku_pre i.touitsu_ele_dummy i.expired_dummy i.nendo, fe vce(cluster pres_pm_codes)

*log
xtreg age_mean_cand_adopt lnsalary_am_kokuji population n_seats_adopt population_elderly75_ratio population_child15_ratio income_time_year all_menseki canlive_ratio_menseki sigaika_ratio_area cand_ratio_musyozoku_pre i.touitsu_ele_dummy i.expired_dummy i.nendo, fe vce(cluster pres_pm_codes)

* up - down dummy
xtreg age_mean_cand_adopt i.dummy_up_salary i.dummy_down_salary population n_seats_adopt population_elderly75_ratio population_child15_ratio income_time_year all_menseki canlive_ratio_menseki sigaika_ratio_area cand_ratio_musyozoku_pre i.touitsu_ele_dummy i.expired_dummy i.nendo, fe vce(cluster pres_pm_codes)

* dummy and change
xtreg age_mean_cand_adopt i.cate_change_salary i.cate_change_salary#c.abs_change_salary population n_seats_adopt population_elderly75_ratio population_child15_ratio income_time_year all_menseki canlive_ratio_menseki sigaika_ratio_area cand_ratio_musyozoku_pre i.touitsu_ele_dummy i.expired_dummy i.nendo, fe vce(cluster pres_pm_codes)

* change 
xtreg age_mean_cand_adopt  i.cate_change_salary#c.abs_change_salary population n_seats_adopt	 population_elderly75_ratio population_child15_ratio income_time_year all_menseki canlive_ratio_menseki sigaika_ratio_area cand_ratio_musyozoku_pre i.touitsu_ele_dummy i.expired_dummy i.nendo, fe vce(cluster pres_pm_codes)

* level and change
xtreg age_mean_cand_adopt salary_am_kokuji i.cate_change_salary#c.abs_change_salary population n_seats_adopt population_elderly75_ratio population_child15_ratio income_time_year all_menseki canlive_ratio_menseki sigaika_ratio_area cand_ratio_musyozoku_pre i.touitsu_ele_dummy i.expired_dummy i.nendo, fe vce(cluster pres_pm_codes)

 
 
** Voting Rate

*level
xtreg voting_rate_isna salary_am_kokuji population n_seats_adopt population_elderly75_ratio population_child15_ratio income_time_year all_menseki canlive_ratio_menseki sigaika_ratio_area cand_ratio_musyozoku_pre i.touitsu_ele_dummy i.expired_dummy i.nendo, fe vce(cluster pres_pm_codes)

*log
xtreg voting_rate_isna lnsalary_am_kokuji population n_seats_adopt population_elderly75_ratio population_child15_ratio income_time_year all_menseki canlive_ratio_menseki sigaika_ratio_area cand_ratio_musyozoku_pre i.touitsu_ele_dummy i.expired_dummy i.nendo, fe vce(cluster pres_pm_codes)

*level squared
xtreg voting_rate_isna c.salary_am_kokuji c.salary_am_kokuji#c.salary_am_kokuji population n_seats_adopt population_elderly75_ratio population_child15_ratio income_time_year all_menseki canlive_ratio_menseki sigaika_ratio_area cand_ratio_musyozoku_pre i.touitsu_ele_dummy i.expired_dummy i.nendo, fe vce(cluster pres_pm_codes)

* up - down dummy
xtreg voting_rate_isna i.dummy_up_salary i.dummy_down_salary population n_seats_adopt population_elderly75_ratio population_child15_ratio income_time_year all_menseki canlive_ratio_menseki sigaika_ratio_area cand_ratio_musyozoku_pre i.touitsu_ele_dummy i.expired_dummy i.nendo, fe vce(cluster pres_pm_codes)

* dummy and change
xtreg voting_rate_isna i.cate_change_salary i.cate_change_salary#c.abs_change_salary population n_seats_adopt population_elderly75_ratio population_child15_ratio income_time_year all_menseki canlive_ratio_menseki sigaika_ratio_area cand_ratio_musyozoku_pre i.touitsu_ele_dummy i.expired_dummy i.nendo, fe vce(cluster pres_pm_codes)

* change 
xtreg voting_rate_isna i.cate_change_salary#c.abs_change_salary population n_seats_adopt population_elderly75_ratio population_child15_ratio income_time_year all_menseki canlive_ratio_menseki sigaika_ratio_area cand_ratio_musyozoku_pre i.touitsu_ele_dummy i.expired_dummy i.nendo, fe vce(cluster pres_pm_codes)

* level and change
xtreg voting_rate_isna salary_am_kokuji i.cate_change_salary#c.abs_change_salary population n_seats_adopt population_elderly75_ratio population_child15_ratio income_time_year all_menseki canlive_ratio_menseki sigaika_ratio_area cand_ratio_musyozoku_pre i.touitsu_ele_dummy i.expired_dummy i.nendo, fe vce(cluster pres_pm_codes)

** Adjusted Average Vote Share of Incumbent

*level
xtreg adjusted_ave_voteshere_inc salary_am_kokuji population n_seats_adopt population_elderly75_ratio population_child15_ratio income_time_year all_menseki canlive_ratio_menseki sigaika_ratio_area cand_ratio_musyozoku_pre i.touitsu_ele_dummy i.expired_dummy i.nendo, fe vce(cluster pres_pm_codes)

*log
xtreg adjusted_ave_voteshere_inc lnsalary_am_kokuji population n_seats_adopt population_elderly75_ratio population_child15_ratio income_time_year all_menseki canlive_ratio_menseki sigaika_ratio_area cand_ratio_musyozoku_pre i.touitsu_ele_dummy i.expired_dummy i.nendo, fe vce(cluster pres_pm_codes)

*level squared
xtreg adjusted_ave_voteshere_inc c.salary_am_kokuji c.salary_am_kokuji#c.salary_am_kokuji population n_seats_adopt population_elderly75_ratio population_child15_ratio income_time_year all_menseki canlive_ratio_menseki sigaika_ratio_area cand_ratio_musyozoku_pre i.touitsu_ele_dummy i.expired_dummy i.nendo, fe vce(cluster pres_pm_codes)

* up - down dummy
xtreg adjusted_ave_voteshere_inc i.dummy_up_salary i.dummy_down_salary population n_seats_adopt population_elderly75_ratio population_child15_ratio income_time_year all_menseki canlive_ratio_menseki sigaika_ratio_area cand_ratio_musyozoku_pre i.touitsu_ele_dummy i.expired_dummy i.nendo, fe vce(cluster pres_pm_codes)

* dummy and change
xtreg adjusted_ave_voteshere_inc i.cate_change_salary i.cate_change_salary#c.abs_change_salary population n_seats_adopt　population_elderly75_ratio population_child15_ratio income_time_year all_menseki canlive_ratio_menseki sigaika_ratio_area cand_ratio_musyozoku_pre i.touitsu_ele_dummy i.expired_dummy i.nendo, fe vce(cluster pres_pm_codes)

* change 
xtreg adjusted_ave_voteshere_inc i.cate_change_salary#c.abs_change_salary population n_seats_adopt population_elderly75_ratio population_child15_ratio income_time_year all_menseki canlive_ratio_menseki sigaika_ratio_area cand_ratio_musyozoku_pre i.touitsu_ele_dummy i.expired_dummy i.nendo, fe vce(cluster pres_pm_codes)

* level and change
xtreg adjusted_ave_voteshere_inc i.cate_change_salary#c.abs_change_salary population n_seats_adopt population_elderly75_ratio population_child15_ratio income_time_year all_menseki canlive_ratio_menseki sigaika_ratio_area cand_ratio_musyozoku_pre i.touitsu_ele_dummy i.expired_dummy i.nendo, fe vce(cluster pres_pm_codes)

** Intarction with Population

*level : 
xtreg voting_rate_isna c.salary_am_kokuji c.salary_am_kokuji#c.population c.population n_seats_adopt population_elderly75_ratio population_child15_ratio income_time_year all_menseki canlive_ratio_menseki sigaika_ratio_area cand_ratio_musyozoku_pre i.touitsu_ele_dummy i.expired_dummy i.nendo, fe vce(cluster pres_pm_codes)

xtreg adjusted_ave_voteshere_inc c.salary_am_kokuji c.salary_am_kokuji#c.population c.population n_seats_adopt population_elderly75_ratio population_child15_ratio income_time_year all_menseki canlive_ratio_menseki sigaika_ratio_area cand_ratio_musyozoku_pre i.touitsu_ele_dummy i.expired_dummy i.nendo, fe vce(cluster pres_pm_codes)

* up - down dummy
xtreg voting_rate_isna i.cate_change_salary i.cate_change_salary#c.population c.population n_seats_adopt population_elderly75_ratio population_child15_ratio income_time_year all_menseki canlive_ratio_menseki sigaika_ratio_area cand_ratio_musyozoku_pre i.touitsu_ele_dummy i.expired_dummy i.nendo, fe vce(cluster pres_pm_codes)

xtreg adjusted_ave_voteshere_inc i.cate_change_salary i.cate_change_salary#c.population c.population n_seats_adopt population_elderly75_ratio population_child15_ratio income_time_year all_menseki canlive_ratio_menseki sigaika_ratio_area cand_ratio_musyozoku_pre i.touitsu_ele_dummy i.expired_dummy i.nendo, fe vce(cluster pres_pm_codes)

* up - down dummy squared population
xtreg adjusted_ave_voteshere_inc i.cate_change_salary i.cate_change_salary#c.population i.cate_change_salary#c.population#c.population c.population  c.population#c.population n_seats_adopt population_elderly75_ratio population_child15_ratio income_time_year all_menseki canlive_ratio_menseki sigaika_ratio_area cand_ratio_musyozoku_pre i.touitsu_ele_dummy i.expired_dummy i.nendo, fe vce(cluster pres_pm_codes)

* change 
xtreg no_voting_ratio_win i.cate_change_salary#c.abs_change_salary i.cate_change_salary#c.abs_change_salary#c.population c.population n_seats_adopt population_elderly75_ratio population_child15_ratio income_time_year all_menseki canlive_ratio_menseki sigaika_ratio_area cand_ratio_musyozoku_pre i.touitsu_ele_dummy i.expired_dummy i.nendo, fe vce(cluster pres_pm_codes)

twoway (scatter change_salary_am voting_rate_isna)
twoway (scatter compe_rate_adopt salary_am_kokuji)
twoway (scatter compe_rate_adopt ratio_salary)
twoway (scatter adjusted_ave_voteshere_inc change_salary_am)








