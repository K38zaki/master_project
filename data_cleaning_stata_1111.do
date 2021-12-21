**touitsu_ele_dummy each

gen touitsu_2007 = 0
replace touitsu_2007 = 1 if ((touitsu_ele_dummy == 1)&(nendo == 2007))

gen touitsu_2011 = 0
replace touitsu_2011 = 1 if ((touitsu_ele_dummy == 1)&(nendo == 2011))

gen touitsu_2015 = 0
replace touitsu_2015 = 1 if ((touitsu_ele_dummy == 1)&(nendo == 2015))

gen touitsu_2019 = 0
replace touitsu_2019 = 1 if ((touitsu_ele_dummy == 1)&(nendo == 2019))

**nendo_dummies
tabulate nendo, generate(nendo)

**others 
gen cate_change_salary = .
replace cate_change_salary = 1 if dummy_up_salary == 1
replace cate_change_salary = 2 if dummy_down_salary == 1
replace cate_change_salary = 0 if (dummy_down_salary == 0) & (dummy_up_salary == 0)

gen lnsalary_am_kokuji = ln(salary_am_kokuji)

gen ln_population = log(population)
*gen ln_income_time_year = log(income_time_year)
gen ln_income_per = log(income_per_syotokuwari_time)
gen ln_all_menseki = log(all_menseki)

gen salary_12month = 12 * salary_am_kokuji
*gen ln_diff_salary = log(salary_12month) - log(income_time_year)
gen ln_diff_salary = log(salary_12month) - log(income_per_syotokuwari_time)
*gen ratio_salary = salary_12month/income_time_year
*gen persentage_salary = (salary_12month - income_time_year)/income_time_year

gen compe_rate_minus1 = compe_rate_adopt - 1

gen compe_rate_minus1_adj = compe_rate_minus1

replace compe_rate_minus1_adj = 0 if compe_rate_minus1_adj < 0

xtset pres_pm_codes ele_t

