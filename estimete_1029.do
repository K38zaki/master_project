
**Data Cleaning
gen cate_change_salary = .
replace cate_change_salary = 1 if dummy_up_salary == 1
replace cate_change_salary = 2 if dummy_down_salary == 1
replace cate_change_salary = 0 if (dummy_down_salary == 0) & (dummy_up_salary == 0)

gen lnsalary_am_kokuji = ln(salary_am_kokuji)

gen ln_population = log(population)
gen ln_income_time_year = log(income_time_year)
gen ln_all_menseki = log(all_menseki)

gen salary_12month = 12 * salary_am_kokuji
gen ln_diff_salary = log(salary_12month) - log(income_time_year)
gen ratio_salary = salary_12month/income_time_year
gen persentage_salary = (salary_12month - income_time_year)/income_time_year

** Set as panel data 
tsset pres_pm_codes ele_t

* CompeRate

**log
xtreg compe_rate_adopt lnsalary_am_kokuji ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_time_year ln_all_menseki canlive_ratio_menseki sigaika_ratio_area cand_ratio_musyozoku_pre i.touitsu_ele_dummy i.expired_dummy i.nendo, fe vce(cluster pres_pm_codes) 

xtreg compe_rate_adopt lnsalary_am_kokuji ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_time_year ln_all_menseki canlive_ratio_menseki sigaika_ratio_area  i.touitsu_ele_dummy i.expired_dummy i.nendo, fe vce(cluster pres_pm_codes)

**with-lead
xtreg compe_rate_adopt lnsalary_am_kokuji F1.lnsalary_am_kokuji ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_time_year ln_all_menseki canlive_ratio_menseki sigaika_ratio_area cand_ratio_musyozoku_pre i.touitsu_ele_dummy i.expired_dummy i.nendo, fe vce(cluster pres_pm_codes) 

xtreg compe_rate_adopt lnsalary_am_kokuji F1.lnsalary_am_kokuji ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_time_year ln_all_menseki canlive_ratio_menseki sigaika_ratio_area i.touitsu_ele_dummy i.expired_dummy i.nendo, fe vce(cluster pres_pm_codes) 


**with-lag of dependent
xtreg compe_rate_adopt lnsalary_am_kokuji L1.compe_rate_adopt ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_time_year ln_all_menseki canlive_ratio_menseki sigaika_ratio_area cand_ratio_musyozoku_pre i.touitsu_ele_dummy i.expired_dummy i.nendo , fe vce(cluster pres_pm_codes) 

xtreg compe_rate_adopt lnsalary_am_kokuji L1.compe_rate_adopt ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_time_year ln_all_menseki canlive_ratio_menseki sigaika_ratio_area  i.touitsu_ele_dummy i.expired_dummy i.nendo, fe vce(cluster pres_pm_codes) 

**check of feedback

xtreg lnsalary_am_kokuji L1.compe_rate_adopt , fe vce(cluster pres_pm_codes)

xtreg lnsalary_am_kokuji L1.compe_rate_adopt ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_time_year ln_all_menseki canlive_ratio_menseki sigaika_ratio_area i.touitsu_ele_dummy i.expired_dummy i.nendo, fe vce(cluster pres_pm_codes)

**first differenced
reg D.compe_rate_adopt D.lnsalary_am_kokuji D.ln_population D.n_seats_adopt D.population_elderly75_ratio D.population_child15_ratio D.ln_income_time_year D.ln_all_menseki D.canlive_ratio_menseki D.sigaika_ratio_area D.cand_ratio_musyozoku_pre i.touitsu_ele_dummy i.expired_dummy i.nendo , nocons vce(cluster pres_pm_codes)

reg D.compe_rate_adopt D.lnsalary_am_kokuji D.ln_population D.n_seats_adopt D.population_elderly75_ratio D.population_child15_ratio D.ln_income_time_year D.ln_all_menseki D.canlive_ratio_menseki D.sigaika_ratio_area D.cand_ratio_musyozoku_pre i.touitsu_ele_dummy i.expired_dummy i.nendo , vce(cluster pres_pm_codes)

reg D.(compe_rate_adopt lnsalary_am_kokuji ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_time_year ln_all_menseki canlive_ratio_menseki sigaika_ratio_area i.touitsu_ele_dummy i.expired_dummy i.nendo),  vce(cluster pres_pm_codes)

reg D.compe_rate_adopt D.lnsalary_am_kokuji D.expired_dummy, nocons vce(cluster pres_pm_codes)

**make nendo dummies and take diffs

reg compe_rate_adopt lnsalary_am_kokuji

tabulate nendo, generate(nendo)

local nendos "nendo1 nendo2 nendo3 nendo4 nendo5 nendo6 nendo7 nendo8 nendo9 nendo10 nendo11 nendo12 nendo13 nendo14 nendo15"

reg D.(compe_rate_adopt lnsalary_am_kokuji ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_time_year ln_all_menseki canlive_ratio_menseki sigaika_ratio_area touitsu_ele_dummy expired_dummy nendo1 nendo2 nendo3 nendo4 nendo5 nendo6 nendo7 nendo8 nendo9 nendo10 nendo11 nendo12 nendo13 nendo14 nendo15), vce(cluster pres_pm_codes)

reg D.(compe_rate_adopt lnsalary_am_kokuji ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_time_year ln_all_menseki canlive_ratio_menseki sigaika_ratio_area touitsu_ele_dummy expired_dummy nendo1 nendo2 nendo3 nendo4 nendo5 nendo6 nendo7 nendo8 nendo9 nendo10 nendo11 nendo12 nendo13 nendo14 nendo15), nocons vce(cluster pres_pm_codes)

reg D.lnsalary_am_kokuji L1.lnsalary_am_kokuji D.(ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_time_year ln_all_menseki canlive_ratio_menseki sigaika_ratio_area  touitsu_ele_dummy expired_dummy nendo1 nendo2 nendo3 nendo4 nendo5 nendo6 nendo7 nendo8 nendo9 nendo10 nendo11 nendo12 nendo13 nendo14 nendo15), vce(cluster pres_pm_codes)

test L1.lnsalary_am_kokuji=0

ssc install ivreg2

** Simple First Differenenced
*differenced equation (no constant)
reg D.compe_rate_adopt D.lnsalary_am_kokuji D.(ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_time_year ln_all_menseki canlive_ratio_menseki sigaika_ratio_area cand_ratio_musyozoku_pre touitsu_ele_dummy expired_dummy nendo1 nendo2 nendo3 nendo4 nendo5 nendo6 nendo7 nendo8 nendo9 nendo10 nendo11 nendo12 nendo13 nendo14 nendo15) , nocons cluster(pres_pm_codes)

reg D.compe_rate_adopt D.lnsalary_am_kokuji D.(ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_time_year ln_all_menseki canlive_ratio_menseki sigaika_ratio_area cand_ratio_musyozoku_pre touitsu_ele_dummy expired_dummy nendo1 nendo2 nendo3 nendo4 nendo5 nendo6 nendo7 nendo8 nendo9 nendo10 nendo11 nendo12 nendo13 nendo14 nendo15) , cluster(pres_pm_codes)

** Anderson and Hsiao without lag of dependent
*differenced equation (no constant)

*first stage
reg D.lnsalary_am_kokuji L1.lnsalary_am_kokuji D.(ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_time_year ln_all_menseki canlive_ratio_menseki sigaika_ratio_area cand_ratio_musyozoku_pre touitsu_ele_dummy expired_dummy nendo1 nendo2 nendo3 nendo4 nendo5 nendo6 nendo7 nendo8 nendo9 nendo10 nendo11 nendo12 nendo13 nendo14 nendo15) , nocons cluster(pres_pm_codes)

test L1.lnsalary_am_kokuji=0

*iv
ivreg D.compe_rate_adopt (D.lnsalary_am_kokuji = L1.lnsalary_am_kokuji) D.(ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_time_year ln_all_menseki canlive_ratio_menseki sigaika_ratio_area cand_ratio_musyozoku_pre touitsu_ele_dummy expired_dummy nendo1 nendo2 nendo3 nendo4 nendo5 nendo6 nendo7 nendo8 nendo9 nendo10 nendo11 nendo12 nendo13 nendo14 nendo15) , nocons cluster(pres_pm_codes) 

*differenced equation with constant (constantの解釈不能 →　時間の経過に伴う伸び？)

*first stage
reg D.lnsalary_am_kokuji L1.lnsalary_am_kokuji D.(ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_time_year ln_all_menseki canlive_ratio_menseki sigaika_ratio_area cand_ratio_musyozoku_pre touitsu_ele_dummy expired_dummy nendo1 nendo2 nendo3 nendo4 nendo5 nendo6 nendo7 nendo8 nendo9 nendo10 nendo11 nendo12 nendo13 nendo14 nendo15) , cluster(pres_pm_codes)

test L1.lnsalary_am_kokuji=0

*iv
ivreg D.compe_rate_adopt (D.lnsalary_am_kokuji = L1.lnsalary_am_kokuji) D.(ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_time_year ln_all_menseki canlive_ratio_menseki sigaika_ratio_area cand_ratio_musyozoku_pre touitsu_ele_dummy expired_dummy nendo1 nendo2 nendo3 nendo4 nendo5 nendo6 nendo7 nendo8 nendo9 nendo10 nendo11 nendo12 nendo13 nendo14 nendo15) , cluster(pres_pm_codes)

** Anderson and Hsiao
*differenced equation (no constant)

*first stage
reg LD.compe_rate_adopt L2.compe_rate_adopt L1.lnsalary_am_kokuji D.(ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_time_year ln_all_menseki canlive_ratio_menseki sigaika_ratio_area cand_ratio_musyozoku_pre touitsu_ele_dummy expired_dummy nendo1 nendo2 nendo3 nendo4 nendo5 nendo6 nendo7 nendo8 nendo9 nendo10 nendo11 nendo12 nendo13 nendo14 nendo15) , nocons cluster(pres_pm_codes)
 
test L2.compe_rate_adopt = 0
test L1.lnsalary_am_kokuji = 0

reg D.lnsalary_am_kokuji L2.compe_rate_adopt L1.lnsalary_am_kokuji D.(ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_time_year ln_all_menseki canlive_ratio_menseki sigaika_ratio_area cand_ratio_musyozoku_pre touitsu_ele_dummy expired_dummy nendo1 nendo2 nendo3 nendo4 nendo5 nendo6 nendo7 nendo8 nendo9 nendo10 nendo11 nendo12 nendo13 nendo14 nendo15) , nocons cluster(pres_pm_codes)

test L2.compe_rate_adopt = 0
test L1.lnsalary_am_kokuji = 0

*iv
ivreg D.compe_rate_adopt (LD.compe_rate_adopt D.lnsalary_am_kokuji = L2.compe_rate_adopt L1.lnsalary_am_kokuji) D.(ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_time_year ln_all_menseki canlive_ratio_menseki sigaika_ratio_area cand_ratio_musyozoku_pre touitsu_ele_dummy expired_dummy nendo1 nendo2 nendo3 nendo4 nendo5 nendo6 nendo7 nendo8 nendo9 nendo10 nendo11 nendo12 nendo13 nendo14 nendo15) , nocons cluster(pres_pm_codes)

*differenced equation with constant

*first stage
reg LD.compe_rate_adopt L2.compe_rate_adopt L1.lnsalary_am_kokuji D.(ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_time_year ln_all_menseki canlive_ratio_menseki sigaika_ratio_area cand_ratio_musyozoku_pre touitsu_ele_dummy expired_dummy nendo1 nendo2 nendo3 nendo4 nendo5 nendo6 nendo7 nendo8 nendo9 nendo10 nendo11 nendo12 nendo13 nendo14 nendo15) , cluster(pres_pm_codes)
 
test L2.compe_rate_adopt = 0
test L1.lnsalary_am_kokuji = 0

reg D.lnsalary_am_kokuji L2.compe_rate_adopt L1.lnsalary_am_kokuji D.(ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_time_year ln_all_menseki canlive_ratio_menseki sigaika_ratio_area cand_ratio_musyozoku_pre touitsu_ele_dummy expired_dummy nendo1 nendo2 nendo3 nendo4 nendo5 nendo6 nendo7 nendo8 nendo9 nendo10 nendo11 nendo12 nendo13 nendo14 nendo15) , cluster(pres_pm_codes)

test L2.compe_rate_adopt = 0
test L1.lnsalary_am_kokuji = 0

*iv
ivreg D.compe_rate_adopt (LD.compe_rate_adopt D.lnsalary_am_kokuji = L2.compe_rate_adopt L1.lnsalary_am_kokuji) D.(ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_time_year ln_all_menseki canlive_ratio_menseki sigaika_ratio_area cand_ratio_musyozoku_pre touitsu_ele_dummy expired_dummy nendo1 nendo2 nendo3 nendo4 nendo5 nendo6 nendo7 nendo8 nendo9 nendo10 nendo11 nendo12 nendo13 nendo14 nendo15) , cluster(pres_pm_codes)



**2007 touitsu_ele_dummy

gen touitsu_2007 = 0
replace touitsu_2007 = 1 if ((touitsu_ele_dummy == 1)&(nendo == 2007))

gen touitsu_2011 = 0
replace touitsu_2011 = 1 if ((touitsu_ele_dummy == 1)&(nendo == 2011))

gen touitsu_2015 = 0
replace touitsu_2015 = 1 if ((touitsu_ele_dummy == 1)&(nendo == 2015))

gen touitsu_2019 = 0
replace touitsu_2019 = 1 if ((touitsu_ele_dummy == 1)&(nendo == 2019))

ivreg D.compe_rate_adopt (LD.compe_rate_adopt D.lnsalary_am_kokuji = L2.compe_rate_adopt L1.lnsalary_am_kokuji) D.(ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_time_year ln_all_menseki canlive_ratio_menseki sigaika_ratio_area cand_ratio_musyozoku_pre  expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 nendo1 nendo2 nendo3 nendo4 nendo5 nendo6 nendo7 nendo8 nendo9 nendo10 nendo11 nendo12 nendo13 nendo14 nendo15) ,nocons cluster(pres_pm_codes)

ivreg D.compe_rate_adopt (LD.compe_rate_adopt D.lnsalary_am_kokuji = L2.compe_rate_adopt L1.lnsalary_am_kokuji) D.(ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_time_year ln_all_menseki canlive_ratio_menseki sigaika_ratio_area cand_ratio_musyozoku_pre  expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 nendo1 nendo2 nendo3 nendo4 nendo5 nendo6 nendo7 nendo8 nendo9 nendo10 nendo11 nendo12 nendo13 nendo14 nendo15) ,cluster(pres_pm_codes)


 


**level
xtreg compe_rate_adopt salary_am_kokuji ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_time_year ln_all_menseki canlive_ratio_menseki sigaika_ratio_area cand_ratio_musyozoku_pre i.touitsu_ele_dummy i.expired_dummy i.nendo, fe vce(cluster pres_pm_codes) 