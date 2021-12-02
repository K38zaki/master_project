tsset pres_pm_codes year

**touitsu_ele_dummy each

gen touitsu_2007 = 0
replace touitsu_2007 = 1 if ((touitsu_ele_dummy == 1)&(kokuji_nendo == 2007))

gen touitsu_2011 = 0
replace touitsu_2011 = 1 if ((touitsu_ele_dummy == 1)&(kokuji_nendo == 2011))

gen touitsu_2015 = 0
replace touitsu_2015 = 1 if ((touitsu_ele_dummy == 1)&(kokuji_nendo == 2015))

gen touitsu_2019 = 0
replace touitsu_2019 = 1 if ((touitsu_ele_dummy == 1)&(kokuji_nendo == 2019))

**nendo_dummies
tabulate nendo, generate(nendo)

* log etc
gen lnsalary_am_kokuji = ln(salary_am_kokuji)
gen lnsalary_am_start = ln(salary_am_start)
gen losalary_am_start = log(salary_am_start)

gen ln_population = log(population)
gen ln_income_per = log(income_per_syotokuwari)
gen ln_all_menseki = log(all_menseki)

gen salary_12month = 12 * salary_am_kokuji
gen ln_diff_salary = log(salary_12month) - log(income_per_syotokuwari)
gen ratio_salary = salary_12month/income_per_syotokuwari
gen persentage_salary = (salary_12month - income_per_syotokuwari)/income_per_syotokuwari

gen compe_rate_minus1 = compe_rate_adopt - 1

gen compe_rate_minus1_adj = compe_rate_minus1

replace compe_rate_minus1_adj = 0 if compe_rate_minus1_adj < 0

gen dummy_jyorei = .
replace dummy_jyorei = 0 if count_jyorei == 0
replace dummy_jyorei = 1 if count_jyorei > 0

gen sigaika_ratio_area = sigaika_area / all_menseki
replace sigaika_ratio_area = 1 if sigaika_ratio_area > 1


hist count_jyorei

sum lnsalary_am_start ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki zaiseiryoku_index sigaika_ratio_area win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 n_staff_all

* jyorei

** poisson
poisson count_jyorei lnsalary_am_start, vce(robust)

poisson count_jyorei lnsalary_am_start ln_population, vce(robust)
poisson count_jyorei lnsalary_am_kokuji ln_population, vce(robust)
poisson count_jyorei lnsalary_am_kokuji lnsalary_am_start ln_population, vce(robust)

poisson count_jyorei lnsalary_am_start ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area zaiseiryoku_index win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 n_staff_all, vce(robust)

poisson count_jyorei lnsalary_am_kokuji lnsalary_am_start ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area zaiseiryoku_index win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 n_staff_all, vce(robust)

xtpoisson count_jyorei lnsalary_am_start  i.nendo, fe vce(robust)
xtpoisson count_jyorei lnsalary_am_kokuji i.nendo, fe vce(robust)
xtpoisson count_jyorei lnsalary_am_start lnsalary_am_kokuji i.nendo, fe vce(robust)
xtpoisson count_jyorei lnsalary_am_start ln_population i.nendo, fe vce(robust)

xtpoisson count_jyorei lnsalary_am_start ln_population n_seats_adopt i.nendo, fe vce(robust)
xtpoisson count_jyorei lnsalary_am_start ln_population n_seats_adopt population_elderly75_ratio i.nendo, fe vce(robust)
xtpoisson count_jyorei lnsalary_am_start ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio i.nendo, fe vce(robust)
xtpoisson count_jyorei lnsalary_am_start ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per i.nendo, fe vce(robust)
xtpoisson count_jyorei lnsalary_am_start ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki　i.nendo, fe vce(robust) 
** 上はダメ

xtpoisson count_jyorei lnsalary_am_start ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per canlive_ratio_menseki  i.nendo, fe vce(robust)
xtpoisson count_jyorei lnsalary_am_start ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per canlive_ratio_menseki  sigaika_ratio_area i.nendo, fe vce(robust)
xtpoisson count_jyorei lnsalary_am_start ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per canlive_ratio_menseki  sigaika_ratio_area zaiseiryoku_index i.nendo, fe vce(robust)
xtpoisson count_jyorei lnsalary_am_start ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per canlive_ratio_menseki  sigaika_ratio_area zaiseiryoku_index win_ratio_musyozoku_pre i.nendo, fe vce(robust)
**ここで符号が変化
xtpoisson count_jyorei lnsalary_am_start ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per canlive_ratio_menseki  sigaika_ratio_area zaiseiryoku_index win_ratio_musyozoku_pre n_staff_all i.nendo, fe vce(robust)
xtpoisson count_jyorei lnsalary_am_start ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per canlive_ratio_menseki  sigaika_ratio_area zaiseiryoku_index win_ratio_musyozoku_pre n_staff_all expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 i.nendo, fe vce(robust)

** そもそも全て0の



xtpoisson count_jyorei lnsalary_am_start ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per canlive_ratio_menseki sigaika_ratio_area zaiseiryoku_index win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 n_staff_all, fe vce(robust) 


xtpoisson count_jyorei lnsalary_am_start ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per canlive_ratio_menseki sigaika_ratio_area zaiseiryoku_index win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 i.nendo n_staff_all, fe vce(robust) 












