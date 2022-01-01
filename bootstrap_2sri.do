
** bootstrap; 2sri

reg lnsalary_am_kokuji ln_income_per ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type, vce(cluster pres_pm_codes)

ereturn matrix betas = e(b)

fracreg probit ratio_women_cand_adopt lnsalary_am_kokuji ln_income_per ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type, vce(cluster pres_pm_codes)

margins, at(expired_dummy = (0 1))
matrix list r(b)
scalar ex1 = r(b)[1,1]
di ex1
scalar ex2 = r(b)[1,2]
di ex2
di ex - ex2

matrix list e(b)
di _b[lnsalary_am_kokuji]

matrix b = e(b) 
ereturn post b 
matrix list b
di _b

margins, dydx(lnsalary_am_kokuji ln_income_per ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all)

di _b[lnsalary_am_kokuji]

matrix list e(b)
matrix list r(b)

matrix ame = r(b)

matrix list ame
drop ame


glm ratio_women_cand_adopt lnsalary_am_kokuji ln_income_per ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type, fa(bin) link(probit) cluster(pres_pm_codes)
**frac probit と同じ


ivregress 2sls ratio_women_cand_adopt (lnsalary_am_kokuji = ln_mean_prefbigtype_1yago) ln_income_per ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type, vce(cluster pres_pm_codes)

ivregress 2sls ratio_women_cand_adopt (lnsalary_am_kokuji = ln_mean_prefbigtype_1yago) ln_income_per ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all nendo2 nendo4-nendo14 i.pref_id i.muni_type, vce(cluster pres_pm_codes)

gen sample_women = 0
replace sample_women = 1 if e(sample) == 1


program drop women2sri

drop Xuhat

program women2sri, rclass
 

reg lnsalary_am_kokuji ln_income_per ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type, vce(cluster pres_pm_codes)

predict Xuhat, resid

fracreg probit ratio_women_cand_adopt lnsalary_am_kokuji Xuhat ln_income_per ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type, vce(cluster pres_pm_codes)

predict x1b1hat, xb
gen scale=normalden(x1b1hat)
gen pe1=scale*_b[lnsalary_am_kokuji]
summarize pe1
return scalar ape_ls=r(mean)
gen pe2=scale*_b[ln_income_per]
summarize pe2
return scalar ape_li=r(mean)
gen pe3=scale*_b[ln_population]
summarize pe3
return scalar ape_lp=r(mean)

*margins, dydx(lnsalary_am_kokuji Xuhat ln_income_per ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all)

*ereturn matrix ame = r(b)

drop Xuhat x1b1hat scale pe1 pe2 pe3

end


bootstrap r(ape_ls) r(ape_li) r(ape_lp), reps(10) seed (10101) cluster(pres_pm_codes): women2sri

drop Xuhat x1b1hat scale pe_*



program drop women2sri
program women2sri, rclass

capture drop Xuhat x1b1hat scale pe_*

reg lnsalary_am_kokuji ln_mean_prefbigtype_1yago ln_income_per ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all nendo2 nendo4-nendo14 i.pref_id i.muni_type, vce(cluster pres_pm_codes)

predict Xuhat, resid

fracreg probit ratio_women_cand_adopt lnsalary_am_kokuji Xuhat ln_income_per ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all nendo2 nendo4-nendo14 i.pref_id i.muni_type, vce(cluster pres_pm_codes)

predict x1b1hat, xb
gen scale=normalden(x1b1hat)

foreach x of varlist lnsalary_am_kokuji Xuhat{
	return scalar b_`x'= _b[`x']
	gen pe_`x'=scale*_b[`x']
	summarize pe_`x'
	return scalar ape_`x'= r(mean)
}

end

preserve
drop if sample_women == 0
bootstrap r(b_lnsalary_am_kokuji), reps(1000) seed (10101) cluster(pres_pm_codes) idcluster(new_id_ppm): women2sri
restore


program drop women2sri
program women2sri, rclass

capture drop Xuhat x1b1hat scale me_*

reg lnsalary_am_kokuji ln_mean_prefbigtype_1yago ln_income_per ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all nendo2 nendo4-nendo14 i.pref_id i.muni_type, vce(cluster pres_pm_codes)

predict Xuhat, resid

fracreg probit ratio_women_cand_adopt lnsalary_am_kokuji Xuhat ln_income_per ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all nendo2 nendo4-nendo14 i.pref_id i.muni_type, vce(cluster pres_pm_codes)

predict x1b1hat, xb
gen scale=normalden(x1b1hat)

foreach x of varlist lnsalary_am_kokuji Xuhat ln_income_per ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre ln_staff_all ln_salary_staff_all {
	return scalar b_`x'= _b[`x']
	gen me_`x'=scale*_b[`x']
	summarize me_`x'
	return scalar ame_`x'= r(mean)
}

foreach y of varlist expired_dummy touitsu_2011 touitsu_2015 touitsu_2019 {
	return scalar b_`y'= _b[`y']
	margins, at(`y' = (0 1))
	scalar yhat0_`y' = r(b)[1,1]
	scalar yhat1_`y' = r(b)[1,2]
	return scalar ame_`y'= yhat1_`y' - yhat0_`y'
}

end

estimates clear

preserve
drop if sample_women == 0
bootstrap r(b_lnsalary_am_kokuji) r(b_Xuhat) r(b_ln_income_per) r(b_n_seats_adopt) r(b_population_elderly75_ratio) r(b_population_child15_ratio) r(b_ln_all_menseki) r(b_canlive_ratio_menseki) r(b_sigaika_ratio_area) r(b_ln_zaiseiryoku) r(b_win_ratio_musyozoku_pre) r(b_expired_dummy) r(b_touitsu_2011) r(b_touitsu_2015) r(b_touitsu_2019) r(b_ln_staff_all) r(b_ln_salary_staff_all) r(ame_lnsalary_am_kokuji) r(ame_Xuhat) r(ame_ln_income_per) r(ame_n_seats_adopt) r(ame_population_elderly75_ratio) r(ame_population_child15_ratio) r(ame_ln_all_menseki) r(ame_canlive_ratio_menseki) r(ame_sigaika_ratio_area) r(ame_ln_zaiseiryoku) r(ame_win_ratio_musyozoku_pre) r(ame_expired_dummy) r(ame_touitsu_2011) r(ame_touitsu_2015) r(ame_touitsu_2019) r(ame_ln_staff_all) r(ame_ln_salary_staff_all) , reps(1000) seed (10101) cluster(pres_pm_codes) idcluster(new_id_ppm): women2sri
restore

estimates store res_women_2sri, title("2SRI_women")

estimates table res_women_2sri

esttab res_women_2sri


preserve
drop if sample_women == 0
bootstrap r(b_lnsalary_am_kokuji) r(b_Xuhat) r(ape_lnsalary_am_kokuji) r(ape_Xuhat), reps(10) seed (10101): women2sri
restore

tab nendo if sample_women == 1



**compe_rate

reg lnsalary_am_kokuji ln_mean_prefbigtype_1yago ln_income_per ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type if compe_rate_minus1_adj != 0, vce(cluster pres_pm_codes)

predict Xuhat, resid

poisson compe_rate_minus1_adj lnsalary_am_kokuji Xuhat ln_income_per ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type, vce(cluster pres_pm_codes)
replace sample_compe = 0
replace sample_compe = 1 if e(sample) == 1

drop Xuhat

program drop compe2sri
program compe2sri, rclass

capture drop Xuhat nhat me_*

reg lnsalary_am_kokuji ln_mean_prefbigtype_1yago ln_income_per ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type, vce(cluster pres_pm_codes)

predict Xuhat, resid

poisson compe_rate_minus1_adj lnsalary_am_kokuji Xuhat ln_income_per ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type, vce(cluster pres_pm_codes)

predict nhat, n

foreach x of varlist lnsalary_am_kokuji Xuhat ln_income_per ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre ln_staff_all ln_salary_staff_all {
	return scalar b_`x'= _b[`x']
	gen me_`x'= nhat*_b[`x']
	summarize me_`x'
	return scalar ame_`x'= r(mean)
}

foreach y of varlist expired_dummy touitsu_2011 touitsu_2015 touitsu_2019 {
	return scalar b_`y'= _b[`y']
	margins, at(`y' = (0 1))
	scalar yhat0_`y' = r(b)[1,1]
	scalar yhat1_`y' = r(b)[1,2]
	return scalar ame_`y'= yhat1_`y' - yhat0_`y'
}

end

estimates drop res_compe_2sri
estimates title

preserve
drop if sample_compe == 0
bootstrap r(b_lnsalary_am_kokuji) r(b_Xuhat) r(b_ln_income_per) r(b_n_seats_adopt) r(b_population_elderly75_ratio) r(b_population_child15_ratio) r(b_ln_all_menseki) r(b_canlive_ratio_menseki) r(b_sigaika_ratio_area) r(b_ln_zaiseiryoku) r(b_win_ratio_musyozoku_pre) r(b_expired_dummy) r(b_touitsu_2011) r(b_touitsu_2015) r(b_touitsu_2019) r(b_ln_staff_all) r(b_ln_salary_staff_all) r(ame_lnsalary_am_kokuji) r(ame_Xuhat) r(ame_ln_income_per) r(ame_n_seats_adopt) r(ame_population_elderly75_ratio) r(ame_population_child15_ratio) r(ame_ln_all_menseki) r(ame_canlive_ratio_menseki) r(ame_sigaika_ratio_area) r(ame_ln_zaiseiryoku) r(ame_win_ratio_musyozoku_pre) r(ame_expired_dummy) r(ame_touitsu_2011) r(ame_touitsu_2015) r(ame_touitsu_2019) r(ame_ln_staff_all) r(ame_ln_salary_staff_all) , reps(1000) seed (10101) cluster(pres_pm_codes) idcluster(new_id_ppm): compe2sri
restore
estimates store res_compe_2sri, title("2SRI_compe")

**result
esttab res_compe_2sri res_women_2sri using "compe_women_2sri_1216.tex", replace ///
star(* 0.10 ** 0.05 *** 0.01) booktabs ///
label b(3) se(3) stats(N, fmt(%9.0f) labels("観測数")) ///
nolz varwidth(16) modelwidth(13) style(tex)




**jyorei_not_control
drop Xuhat

reg lnsalary_am_kokuji ln_mean_prefbigtype_1yago ln_income_per ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type if teian_jyorei_4y != ., vce(cluster pres_pm_codes)

predict Xuhat, resid

poisson teian_jyorei_4y lnsalary_am_kokuji Xuhat ln_income_per ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type, vce(cluster pres_pm_codes)

gen sample_teian = 0
replace sample_teian = 1 if e(sample) == 1
margins, dydx(lnsalary_am_kokuji Xuhat)

di r(b)[1,1]
matrix b = r(b)
ereturn post b 
di _b[lnsalary_am_kokuji]


program drop jyoreinot2sri
drop Xuhat 

program jyoreinot2sri, rclass

capture drop Xuhat nhat me_*

reg lnsalary_am_kokuji ln_mean_prefbigtype_1yago ln_income_per ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku expired_dummy touitsu_2011 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type, vce(cluster pres_pm_codes)

predict Xuhat, resid

poisson teian_jyorei_4y lnsalary_am_kokuji Xuhat ln_income_per ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku expired_dummy touitsu_2011 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type, vce(cluster pres_pm_codes)

predict nhat, n

foreach x of varlist lnsalary_am_kokuji Xuhat ln_income_per ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku ln_staff_all ln_salary_staff_all {
	return scalar b_`x'= _b[`x']
	gen me_`x'=nhat*_b[`x']
	summarize me_`x'
	return scalar ame_`x'= r(mean)
}

foreach y of varlist expired_dummy touitsu_2011 {
	return scalar b_`y'= _b[`y']
	margins, at(`y' = (0 1))
	scalar yhat0_`y' = r(b)[1,1]
	scalar yhat1_`y' = r(b)[1,2]
	return scalar ame_`y'= yhat1_`y' - yhat0_`y'
}

end

preserve
drop if sample_teian == 0
bootstrap r(b_lnsalary_am_kokuji) r(b_Xuhat) r(b_ln_income_per) r(b_n_seats_adopt) r(b_population_elderly75_ratio) r(b_population_child15_ratio) r(b_ln_all_menseki) r(b_canlive_ratio_menseki) r(b_sigaika_ratio_area) r(b_ln_zaiseiryoku) r(b_expired_dummy) r(b_touitsu_2011) r(b_ln_staff_all) r(b_ln_salary_staff_all) r(ame_lnsalary_am_kokuji) r(ame_Xuhat) r(ame_ln_income_per) r(ame_n_seats_adopt) r(ame_population_elderly75_ratio) r(ame_population_child15_ratio) r(ame_ln_all_menseki) r(ame_canlive_ratio_menseki) r(ame_sigaika_ratio_area) r(ame_ln_zaiseiryoku) r(ame_expired_dummy) r(ame_touitsu_2011) r(ame_ln_staff_all) r(ame_ln_salary_staff_all) , reps(1000) seed (567) cluster(pres_pm_codes) idcluster(new_id_ppm): jyoreinot2sri
restore
estimates store res_not_jyorei_2sri, title("2SRI_not_jyorei")


*** jyorei control

drop Xuhat

reg lnsalary_am_kokuji ln_mean_prefbigtype_1yago ln_income_per ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type age_mean_wins ratio_women_wins_adopt win_ratio_musyozoku if teian_jyorei_4y != ., vce(cluster pres_pm_codes)

predict Xuhat, resid

poisson teian_jyorei_4y lnsalary_am_kokuji Xuhat ln_income_per ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type age_mean_wins ratio_women_wins_adopt win_ratio_musyozoku, vce(cluster pres_pm_codes)

gen sample_teian_cont = 0
replace sample_teian_cont = 1 if e(sample) == 1
margins, dydx(lnsalary_am_kokuji Xuhat)

drop Xuhat 
program jyoreicont2sri, rclass

capture drop Xuhat nhat me_*

reg lnsalary_am_kokuji ln_mean_prefbigtype_1yago ln_income_per ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku expired_dummy touitsu_2011 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type age_mean_wins ratio_women_wins_adopt win_ratio_musyozoku, vce(cluster pres_pm_codes)

predict Xuhat, resid

poisson teian_jyorei_4y lnsalary_am_kokuji Xuhat ln_income_per ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku expired_dummy touitsu_2011 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type age_mean_wins ratio_women_wins_adopt win_ratio_musyozoku, vce(cluster pres_pm_codes)

predict nhat, n

foreach x of varlist lnsalary_am_kokuji Xuhat ln_income_per ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku ln_staff_all ln_salary_staff_all age_mean_wins ratio_women_wins_adopt win_ratio_musyozoku {
	return scalar b_`x'= _b[`x']
	gen me_`x'=nhat*_b[`x']
	summarize me_`x'
	return scalar ame_`x'= r(mean)
}

foreach y of varlist expired_dummy touitsu_2011 {
	return scalar b_`y'= _b[`y']
	margins, at(`y' = (0 1))
	scalar yhat0_`y' = r(b)[1,1]
	scalar yhat1_`y' = r(b)[1,2]
	return scalar ame_`y'= yhat1_`y' - yhat0_`y'
}

end

preserve
drop if sample_teian_cont == 0
bootstrap r(b_lnsalary_am_kokuji) r(b_Xuhat) r(b_ln_income_per) r(b_n_seats_adopt) r(b_population_elderly75_ratio) r(b_population_child15_ratio) r(b_ln_all_menseki) r(b_canlive_ratio_menseki) r(b_sigaika_ratio_area) r(b_ln_zaiseiryoku) r(b_expired_dummy) r(b_touitsu_2011) r(b_ln_staff_all) r(b_ln_salary_staff_all) r(b_age_mean_wins) r(b_ratio_women_wins_adopt) r(b_win_ratio_musyozoku) r(ame_lnsalary_am_kokuji) r(ame_Xuhat) r(ame_ln_income_per) r(ame_n_seats_adopt) r(ame_population_elderly75_ratio) r(ame_population_child15_ratio) r(ame_ln_all_menseki) r(ame_canlive_ratio_menseki) r(ame_sigaika_ratio_area) r(ame_ln_zaiseiryoku) r(ame_expired_dummy) r(ame_touitsu_2011) r(ame_ln_staff_all) r(ame_ln_salary_staff_all) r(ame_age_mean_wins) r(ame_ratio_women_wins_adopt) r(ame_win_ratio_musyozoku), reps(1000) seed (10101) cluster(pres_pm_codes) idcluster(new_id_ppm): jyoreicont2sri
restore
estimates store res_cont_jyorei_2sri, title("2SRI_cont_jyorei")

** votingrate
drop Xuhat
reg dummy_up_salary upratio ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type compe_rate_adopt ratio_women_cand_adopt age_mean_cand cand_ratio_musyozoku if voting_rate_p != ., vce(cluster pres_pm_codes)
predict up_hat, xb
gen Xuhat = dummy_up_salary - up_hat 

fracreg probit voting_rate_p dummy_up_salary Xuhat ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type compe_rate_adopt ratio_women_cand_adopt age_mean_cand cand_ratio_musyozoku, vce(cluster pres_pm_codes)
gen sample_voting = 0
replace sample_voting = 1 if e(sample) == 1


reg dummy_down_salary downratio ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type compe_rate_adopt ratio_women_cand_adopt age_mean_cand cand_ratio_musyozoku if voting_rate_p != ., vce(cluster pres_pm_codes)

fracreg probit voting_rate_p dummy_down_salary Xuhat ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type compe_rate_adopt ratio_women_cand_adopt age_mean_cand cand_ratio_musyozoku, vce(cluster pres_pm_codes)

capture drop uphat Xuhat
program drop votingup2sri
program drop votingdown2sri

program votingup2sri, rclass

capture drop Xuhat up_hat x1b1hat scale me_*

reg dummy_up_salary upratio ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type compe_rate_adopt ratio_women_cand_adopt age_mean_cand cand_ratio_musyozoku, vce(cluster pres_pm_codes)

predict up_hat, xb
gen Xuhat = dummy_up_salary_am - up_hat 

fracreg probit voting_rate_p dummy_up_salary_am Xuhat ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type compe_rate_adopt ratio_women_cand_adopt age_mean_cand cand_ratio_musyozoku, vce(cluster pres_pm_codes)

predict x1b1hat, xb
gen scale=normalden(x1b1hat)

foreach x of varlist Xuhat ln_income_per ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre ln_staff_all ln_salary_staff_all compe_rate_adopt ratio_women_cand_adopt age_mean_cand cand_ratio_musyozoku {
	return scalar b_`x'= _b[`x']
	gen me_`x'=scale*_b[`x']
	summarize me_`x'
	return scalar ame_`x'= r(mean)
}

foreach y of varlist dummy_up_salary_am expired_dummy touitsu_2011 touitsu_2015 touitsu_2019 {
	return scalar b_`y'= _b[`y']
	margins, at(`y' = (0 1))
	scalar yhat0_`y' = r(b)[1,1]
	scalar yhat1_`y' = r(b)[1,2]
	return scalar ame_`y'= yhat1_`y' - yhat0_`y'
}

end

program votingdown2sri, rclass

capture drop Xuhat down_hat x1b1hat scale me_*

reg dummy_down_salary downratio ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type compe_rate_adopt ratio_women_cand_adopt age_mean_cand cand_ratio_musyozoku, vce(cluster pres_pm_codes)

predict down_hat, xb
gen Xuhat = dummy_down_salary_am - down_hat 

fracreg probit voting_rate_p dummy_down_salary_am Xuhat ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type compe_rate_adopt ratio_women_cand_adopt age_mean_cand cand_ratio_musyozoku, vce(cluster pres_pm_codes)

predict x1b1hat, xb
gen scale=normalden(x1b1hat)

foreach x of varlist Xuhat ln_income_per ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre ln_staff_all ln_salary_staff_all compe_rate_adopt ratio_women_cand_adopt age_mean_cand cand_ratio_musyozoku {
	return scalar b_`x'= _b[`x']
	gen me_`x'=scale*_b[`x']
	summarize me_`x'
	return scalar ame_`x'= r(mean)
}

foreach y of varlist dummy_down_salary_am expired_dummy touitsu_2011 touitsu_2015 touitsu_2019 {
	return scalar b_`y'= _b[`y']
	margins, at(`y' = (0 1))
	scalar yhat0_`y' = r(b)[1,1]
	scalar yhat1_`y' = r(b)[1,2]
	return scalar ame_`y'= yhat1_`y' - yhat0_`y'
}

end


preserve
drop if sample_voting == 0
bootstrap r(b_dummy_up_salary_am) r(b_Xuhat) r(b_ln_income_per) r(b_n_seats_adopt) r(b_population_elderly75_ratio) r(b_population_child15_ratio) r(b_ln_all_menseki) r(b_canlive_ratio_menseki) r(b_sigaika_ratio_area) r(b_ln_zaiseiryoku) r(b_win_ratio_musyozoku_pre) r(b_expired_dummy) r(b_touitsu_2011) r(b_touitsu_2015) r(b_touitsu_2019) r(b_ln_staff_all) r(b_ln_salary_staff_all) r(b_compe_rate_adopt) r(b_age_mean_cand) r(b_ratio_women_cand_adopt) r(b_cand_ratio_musyozoku) r(ame_dummy_up_salary_am) r(ame_Xuhat) r(ame_ln_income_per) r(ame_n_seats_adopt) r(ame_population_elderly75_ratio) r(ame_population_child15_ratio) r(ame_ln_all_menseki) r(ame_canlive_ratio_menseki) r(ame_sigaika_ratio_area) r(ame_ln_zaiseiryoku) r(ame_win_ratio_musyozoku_pre) r(ame_expired_dummy) r(ame_touitsu_2011) r(ame_touitsu_2015) r(ame_touitsu_2019) r(ame_ln_staff_all) r(ame_ln_salary_staff_all) r(ame_compe_rate_adopt) r(ame_age_mean_cand) r(ame_ratio_women_cand_adopt) r(ame_cand_ratio_musyozoku), reps(1000) seed (10101) cluster(pres_pm_codes) idcluster(new_id_ppm): votingup2sri
estimates store res_up_voting_2sri, title("2SRI_up_voting")

drop Xuhat


preserve
drop if sample_voting == 0
bootstrap r(b_dummy_down_salary_am) r(b_Xuhat) r(b_ln_income_per) r(b_n_seats_adopt) r(b_population_elderly75_ratio) r(b_population_child15_ratio) r(b_ln_all_menseki) r(b_canlive_ratio_menseki) r(b_sigaika_ratio_area) r(b_ln_zaiseiryoku) r(b_win_ratio_musyozoku_pre) r(b_expired_dummy) r(b_touitsu_2011) r(b_touitsu_2015) r(b_touitsu_2019) r(b_ln_staff_all) r(b_ln_salary_staff_all) r(b_compe_rate_adopt) r(b_age_mean_cand) r(b_ratio_women_cand_adopt) r(b_cand_ratio_musyozoku) r(ame_dummy_down_salary_am) r(ame_Xuhat) r(ame_ln_income_per) r(ame_n_seats_adopt) r(ame_population_elderly75_ratio) r(ame_population_child15_ratio) r(ame_ln_all_menseki) r(ame_canlive_ratio_menseki) r(ame_sigaika_ratio_area) r(ame_ln_zaiseiryoku) r(ame_win_ratio_musyozoku_pre) r(ame_expired_dummy) r(ame_touitsu_2011) r(ame_touitsu_2015) r(ame_touitsu_2019) r(ame_ln_staff_all) r(ame_ln_salary_staff_all) r(ame_compe_rate_adopt) r(ame_age_mean_cand) r(ame_ratio_women_cand_adopt) r(ame_cand_ratio_musyozoku), reps(1000) seed (10101) cluster(pres_pm_codes) idcluster(new_id_ppm): votingdown2sri
estimates store res_down_voting_2sri, title("2SRI_dn_voting")

restore

**result
esttab res_up_voting_2sri res_down_voting_2sri using "voting_updown_2sri_1216.tex", replace ///
star(* 0.10 ** 0.05 *** 0.01) booktabs ///
label b(3) se(3) stats(N, fmt(%9.0f) labels("観測数")) ///
nolz varwidth(16) modelwidth(13) style(tex)

** incumbent voteshare


reg dummy_up_salary upratio ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type ratio_women_cand_adopt age_mean_cand cand_ratio_musyozoku if adjusted_ave_voteshare_inc != ., vce(cluster pres_pm_codes)
predict Xuhat, resid
test upratio

fracreg probit adjusted_ave_voteshare_inc dummy_up_salary Xuhat ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type  ratio_women_cand_adopt age_mean_cand cand_ratio_musyozoku, vce(cluster pres_pm_codes)

drop Xuhat

reg dummy_down_salary downratio ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type ratio_women_cand_adopt age_mean_cand cand_ratio_musyozoku if adjusted_ave_voteshare_inc != ., vce(cluster pres_pm_codes)
predict Xuhat, resid
test downratio

fracreg probit adjusted_ave_voteshare_inc dummy_down_salary Xuhat ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type  ratio_women_cand_adopt age_mean_cand cand_ratio_musyozoku, vce(cluster pres_pm_codes)

gen sample_inc = 0
replace sample_inc = 1 if e(sample) == 1

drop Xuhat

program drop incup2sri incdown2sri
program incup2sri, rclass

capture drop Xuhat x1b1hat scale me_*

reg dummy_up_salary upratio ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type ratio_women_cand_adopt age_mean_cand cand_ratio_musyozoku, vce(cluster pres_pm_codes)

predict Xuhat, resid

fracreg probit adjusted_ave_voteshare_inc dummy_up_salary Xuhat ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type ratio_women_cand_adopt age_mean_cand cand_ratio_musyozoku, vce(cluster pres_pm_codes)

predict x1b1hat, xb
gen scale=normalden(x1b1hat)

foreach x of varlist Xuhat ln_income_per ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre ln_staff_all ln_salary_staff_all ratio_women_cand_adopt age_mean_cand cand_ratio_musyozoku {
	return scalar b_`x'= _b[`x']
	gen me_`x'=scale*_b[`x']
	summarize me_`x'
	return scalar ame_`x'= r(mean)
}

foreach y of varlist dummy_up_salary_am expired_dummy touitsu_2011 touitsu_2015 touitsu_2019 {
	return scalar b_`y'= _b[`y']
	margins, at(`y' = (0 1))
	scalar yhat0_`y' = r(b)[1,1]
	scalar yhat1_`y' = r(b)[1,2]
	return scalar ame_`y'= yhat1_`y' - yhat0_`y'
}

end

program incdown2sri, rclass

capture drop Xuhat x1b1hat scale me_*

reg dummy_down_salary downratio ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type ratio_women_cand_adopt age_mean_cand cand_ratio_musyozoku, vce(cluster pres_pm_codes)

predict Xuhat, resid

fracreg probit adjusted_ave_voteshare_inc dummy_down_salary Xuhat ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type ratio_women_cand_adopt age_mean_cand cand_ratio_musyozoku, vce(cluster pres_pm_codes)

predict x1b1hat, xb
gen scale=normalden(x1b1hat)

foreach x of varlist Xuhat ln_income_per ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre ln_staff_all ln_salary_staff_all ratio_women_cand_adopt age_mean_cand cand_ratio_musyozoku {
	return scalar b_`x'= _b[`x']
	gen me_`x'=scale*_b[`x']
	summarize me_`x'
	return scalar ame_`x'= r(mean)
}

foreach y of varlist dummy_down_salary_am expired_dummy touitsu_2011 touitsu_2015 touitsu_2019 {
	return scalar b_`y'= _b[`y']
	margins, at(`y' = (0 1))
	scalar yhat0_`y' = r(b)[1,1]
	scalar yhat1_`y' = r(b)[1,2]
	return scalar ame_`y'= yhat1_`y' - yhat0_`y'
}

end

preserve
drop if sample_inc == 0

bootstrap r(b_dummy_up_salary_am) r(b_Xuhat) r(b_ln_income_per) r(b_n_seats_adopt) r(b_population_elderly75_ratio) r(b_population_child15_ratio) r(b_ln_all_menseki) r(b_canlive_ratio_menseki) r(b_sigaika_ratio_area) r(b_ln_zaiseiryoku) r(b_win_ratio_musyozoku_pre) r(b_expired_dummy) r(b_touitsu_2011) r(b_touitsu_2015) r(b_touitsu_2019) r(b_ln_staff_all) r(b_ln_salary_staff_all) r(b_age_mean_cand) r(b_ratio_women_cand_adopt) r(b_cand_ratio_musyozoku) r(ame_dummy_up_salary_am) r(ame_Xuhat) r(ame_ln_income_per) r(ame_n_seats_adopt) r(ame_population_elderly75_ratio) r(ame_population_child15_ratio) r(ame_ln_all_menseki) r(ame_canlive_ratio_menseki) r(ame_sigaika_ratio_area) r(ame_ln_zaiseiryoku) r(ame_win_ratio_musyozoku_pre) r(ame_expired_dummy) r(ame_touitsu_2011) r(ame_touitsu_2015) r(ame_touitsu_2019) r(ame_ln_staff_all) r(ame_ln_salary_staff_all) r(ame_age_mean_cand) r(ame_ratio_women_cand_adopt) r(ame_cand_ratio_musyozoku), reps(1000) seed (10101) cluster(pres_pm_codes) idcluster(new_id_ppm): incup2sri
estimates store res_up_inc_2sri, title("2SRI_up_inc")

drop Xuhat

drop x1b1hat scale me_*

preserve
drop if sample_inc == 0
bootstrap r(b_dummy_down_salary_am) r(b_Xuhat) r(b_ln_income_per) r(b_n_seats_adopt) r(b_population_elderly75_ratio) r(b_population_child15_ratio) r(b_ln_all_menseki) r(b_canlive_ratio_menseki) r(b_sigaika_ratio_area) r(b_ln_zaiseiryoku) r(b_win_ratio_musyozoku_pre) r(b_expired_dummy) r(b_touitsu_2011) r(b_touitsu_2015) r(b_touitsu_2019) r(b_ln_staff_all) r(b_ln_salary_staff_all) r(b_age_mean_cand) r(b_ratio_women_cand_adopt) r(b_cand_ratio_musyozoku) r(ame_dummy_down_salary_am) r(ame_Xuhat) r(ame_ln_income_per) r(ame_n_seats_adopt) r(ame_population_elderly75_ratio) r(ame_population_child15_ratio) r(ame_ln_all_menseki) r(ame_canlive_ratio_menseki) r(ame_sigaika_ratio_area) r(ame_ln_zaiseiryoku) r(ame_win_ratio_musyozoku_pre) r(ame_expired_dummy) r(ame_touitsu_2011) r(ame_touitsu_2015) r(ame_touitsu_2019) r(ame_ln_staff_all) r(ame_ln_salary_staff_all) r(ame_age_mean_cand) r(ame_ratio_women_cand_adopt) r(ame_cand_ratio_musyozoku), reps(1000) seed (10101) cluster(pres_pm_codes) idcluster(new_id_ppm): incdown2sri
estimates store res_down_inc_2sri, title("2SRI_dn_inc")

restore

esttab res_up_inc_2sri res_down_inc_2sri using "inc_updown_2sri_1216.tex", replace ///
star(* 0.10 ** 0.05 *** 0.01) booktabs ///
label b(3) se(3) stats(N, fmt(%9.0f) labels("観測数")) ///
nolz varwidth(16) modelwidth(13) style(tex)

**interaction

program drop votingup2sri_int
program votingup2sri_int, rclass

capture drop Xuhat Xuhat2

reg dummy_up_salary c.upratio##c.ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type compe_rate_adopt ratio_women_cand_adopt age_mean_cand cand_ratio_musyozoku, vce(cluster pres_pm_codes)

predict Xuhat, resid

fracreg probit voting_rate_p dummy_up_salary_am##c.ln_population Xuhat n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type compe_rate_adopt ratio_women_cand_adopt age_mean_cand cand_ratio_musyozoku, vce(cluster pres_pm_codes)

return scalar b_dummy = _b[1.dummy_up_salary_am]
return scalar b_int = _b[1.dummy_up_salary_am#c.ln_population]
return scalar b_popu = _b[ln_population]


reg dummy_up_salary_am c.upratio##c.ln_population##c.ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type compe_rate_adopt ratio_women_cand_adopt age_mean_cand cand_ratio_musyozoku, vce(cluster pres_pm_codes)

predict Xuhat2, resid 

fracreg probit voting_rate_p dummy_up_salary_am##c.ln_population##c.ln_population Xuhat2 n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type compe_rate_adopt ratio_women_cand_adopt age_mean_cand cand_ratio_musyozoku, vce(cluster pres_pm_codes)

return scalar b2_dummy = _b[1.dummy_up_salary_am]
return scalar b2_int = _b[1.dummy_up_salary_am#c.ln_population]
return scalar b2_intsq = _b[1.dummy_up_salary_am#c.ln_population#c.ln_population]
return scalar b2_popu = _b[ln_population]
return scalar b2_popusq = _b[c.ln_population#c.ln_population]
end

program drop votingdown2sri_int
program votingdown2sri_int, rclass

capture drop Xuhat Xuhat2

reg dummy_down_salary c.downratio##c.ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type compe_rate_adopt ratio_women_cand_adopt age_mean_cand cand_ratio_musyozoku, vce(cluster pres_pm_codes)

predict Xuhat, resid 

fracreg probit voting_rate_p dummy_down_salary_am##c.ln_population Xuhat n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type compe_rate_adopt ratio_women_cand_adopt age_mean_cand cand_ratio_musyozoku, vce(cluster pres_pm_codes)

return scalar b_dummy = _b[1.dummy_down_salary_am]
return scalar b_int = _b[1.dummy_down_salary_am#c.ln_population]
return scalar b_popu = _b[ln_population]


reg dummy_down_salary c.downratio##c.ln_population##c.ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type compe_rate_adopt ratio_women_cand_adopt age_mean_cand cand_ratio_musyozoku, vce(cluster pres_pm_codes)

predict Xuhat2, resid 

fracreg probit voting_rate_p dummy_down_salary_am##c.ln_population##c.ln_population Xuhat2 n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type compe_rate_adopt ratio_women_cand_adopt age_mean_cand cand_ratio_musyozoku, vce(cluster pres_pm_codes)

return scalar b2_dummy = _b[1.dummy_down_salary_am]
return scalar b2_int = _b[1.dummy_down_salary_am#c.ln_population]
return scalar b2_intsq = _b[1.dummy_down_salary_am#c.ln_population#c.ln_population]
return scalar b2_popu = _b[ln_population]
return scalar b2_popusq = _b[c.ln_population#c.ln_population]

end

preserve
drop if sample_voting == 0
bootstrap r(b_dummy) r(b_int) r(b_popu) r(b2_dummy) r(b2_int) r(b2_intsq) r(b2_popu) r(b2_popusq) , reps(1000) seed (10101) cluster(pres_pm_codes) idcluster(new_id_ppm): votingup2sri_int
estimates store up_vot_2sri_int, title("2SRI_votup_inter")
restore

preserve
drop if sample_voting == 0
bootstrap r(b_dummy) r(b_int) r(b_popu) r(b2_dummy) r(b2_int) r(b2_intsq) r(b2_popu) r(b2_popusq) , reps(1000) seed (10101) cluster(pres_pm_codes) idcluster(new_id_ppm): votingdown2sri_int
estimates store down_vot_2sri_int, title("2SRI_votdown_inter")
restore

**result
esttab up_vot_2sri_int down_vot_2sri_int using "voting_int_2sri.tex", replace ///
star(* 0.10 ** 0.05 *** 0.01) booktabs ///
label b(3) se(3) stats(N, fmt(%9.0f) labels("観測数")) ///
nolz varwidth(16) modelwidth(13) style(tex)


program drop incup2sri_int
program incup2sri_int, rclass

capture drop Xuhat Xuhat2

reg dummy_up_salary c.upratio##c.ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type ratio_women_cand_adopt age_mean_cand cand_ratio_musyozoku, vce(cluster pres_pm_codes)

predict Xuhat, resid

fracreg probit adjusted_ave_voteshare_inc dummy_up_salary_am##c.ln_population Xuhat n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type ratio_women_cand_adopt age_mean_cand cand_ratio_musyozoku, vce(cluster pres_pm_codes)

return scalar b_dummy = _b[1.dummy_up_salary_am]
return scalar b_int = _b[1.dummy_up_salary_am#c.ln_population]
return scalar b_popu = _b[ln_population]


reg dummy_up_salary_am c.upratio##c.ln_population##c.ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type ratio_women_cand_adopt age_mean_cand cand_ratio_musyozoku, vce(cluster pres_pm_codes)

predict Xuhat2, resid 

fracreg probit adjusted_ave_voteshare_inc  dummy_up_salary_am##c.ln_population##c.ln_population Xuhat2 n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type ratio_women_cand_adopt age_mean_cand cand_ratio_musyozoku, vce(cluster pres_pm_codes)

return scalar b2_dummy = _b[1.dummy_up_salary_am]
return scalar b2_int = _b[1.dummy_up_salary_am#c.ln_population]
return scalar b2_intsq = _b[1.dummy_up_salary_am#c.ln_population#c.ln_population]
return scalar b2_popu = _b[ln_population]
return scalar b2_popusq = _b[c.ln_population#c.ln_population]
end

program drop votingdown2sri_int
program incdown2sri_int, rclass

capture drop Xuhat Xuhat2

reg dummy_down_salary c.downratio##c.ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_typ ratio_women_cand_adopt age_mean_cand cand_ratio_musyozoku, vce(cluster pres_pm_codes)

predict Xuhat, resid 

fracreg probit adjusted_ave_voteshare_inc dummy_down_salary_am##c.ln_population Xuhat n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_typ ratio_women_cand_adopt age_mean_cand cand_ratio_musyozoku, vce(cluster pres_pm_codes)

return scalar b_dummy = _b[1.dummy_down_salary_am]
return scalar b_int = _b[1.dummy_down_salary_am#c.ln_population]
return scalar b_popu = _b[ln_population]


reg dummy_down_salary c.downratio##c.ln_population##c.ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type ratio_women_cand_adopt age_mean_cand cand_ratio_musyozoku, vce(cluster pres_pm_codes)

predict Xuhat2, resid 

fracreg probit adjusted_ave_voteshare_inc dummy_down_salary_am##c.ln_population##c.ln_population Xuhat2 n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type ratio_women_cand_adopt age_mean_cand cand_ratio_musyozoku, vce(cluster pres_pm_codes)

return scalar b2_dummy = _b[1.dummy_down_salary_am]
return scalar b2_int = _b[1.dummy_down_salary_am#c.ln_population]
return scalar b2_intsq = _b[1.dummy_down_salary_am#c.ln_population#c.ln_population]
return scalar b2_popu = _b[ln_population]
return scalar b2_popusq = _b[c.ln_population#c.ln_population]

end

preserve
drop if sample_inc == 0
bootstrap r(b_dummy) r(b_int) r(b_popu) r(b2_dummy) r(b2_int) r(b2_intsq) r(b2_popu) r(b2_popusq) , reps(1000) seed (10101) cluster(pres_pm_codes) idcluster(new_id_ppm): incup2sri_int
estimates store up_inc_2sri_int, title("2SRI_incup_inter")
restore

preserve
drop if sample_inc == 0
bootstrap r(b_dummy) r(b_int) r(b_popu) r(b2_dummy) r(b2_int) r(b2_intsq) r(b2_popu) r(b2_popusq) , reps(1000) seed (10101) cluster(pres_pm_codes) idcluster(new_id_ppm): incdown2sri_int
estimates store down_inc_2sri_int, title("2SRI_incdown_inter")
restore

**result
esttab up_inc_2sri_int down_inc_2sri_int using "incum_int_2sri.tex", replace ///
star(* 0.10 ** 0.05 *** 0.01) booktabs ///
label b(3) se(3) stats(N, fmt(%9.0f) labels("観測数")) ///
nolz varwidth(16) modelwidth(13) style(tex)


** incumbent ln_population
program drop incup2sri incdown2sri
program incup2sri_lnp, rclass

capture drop Xuhat x1b1hat scale me_*

reg dummy_up_salary upratio ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type ratio_women_cand_adopt age_mean_cand cand_ratio_musyozoku, vce(cluster pres_pm_codes)

predict Xuhat, resid

fracreg probit adjusted_ave_voteshare_inc dummy_up_salary Xuhat ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type ratio_women_cand_adopt age_mean_cand cand_ratio_musyozoku, vce(cluster pres_pm_codes)

predict x1b1hat, xb
gen scale=normalden(x1b1hat)

foreach x of varlist Xuhat ln_income_per ln_population {
	return scalar b_`x'= _b[`x']
	gen me_`x'=scale*_b[`x']
	summarize me_`x'
	return scalar ame_`x'= r(mean)
}

end

program incdown2sri_lnp, rclass

capture drop Xuhat x1b1hat scale me_*

reg dummy_down_salary downratio ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type ratio_women_cand_adopt age_mean_cand cand_ratio_musyozoku, vce(cluster pres_pm_codes)

predict Xuhat, resid

fracreg probit adjusted_ave_voteshare_inc dummy_down_salary Xuhat ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type ratio_women_cand_adopt age_mean_cand cand_ratio_musyozoku, vce(cluster pres_pm_codes)

predict x1b1hat, xb
gen scale=normalden(x1b1hat)

foreach x of varlist Xuhat ln_income_per ln_population {
	return scalar b_`x'= _b[`x']
	gen me_`x'=scale*_b[`x']
	summarize me_`x'
	return scalar ame_`x'= r(mean)
}


end

preserve
drop if sample_inc == 0
bootstrap r(b_Xuhat) r(b_ln_income_per) r(b_ln_population) r(ame_Xuhat) r(ame_ln_income_per) r(ame_ln_population), reps(1000) seed (10101) cluster(pres_pm_codes) idcluster(new_id_ppm): incup2sri_lnp
estimates store res_incup_2sri_lnp, title("2SRI_up_inc_p")
restore

preserve
drop if sample_inc == 0
bootstrap r(b_Xuhat) r(b_ln_income_per) r(b_ln_population) r(ame_Xuhat) r(ame_ln_income_per) r(ame_ln_population), reps(1000) seed (10101) cluster(pres_pm_codes) idcluster(new_id_ppm): incdown2sri_lnp
estimates store res_incdown_2sri_lnp, title("2SRI_down_inc_p")
restore

**result
esttab res_incup_2sri_lnp res_incdown_2sri_lnp using "incum_popu_2sri.tex", replace ///
star(* 0.10 ** 0.05 *** 0.01) booktabs ///
label b(3) se(3) stats(N, fmt(%9.0f) labels("観測数")) ///
nolz varwidth(16) modelwidth(13) style(tex)


**novoting

reg lnsalary_am_kokuji ln_mean_prefbigtype_1yago ln_income_per ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type if no_voting_ratio_win != ., vce(cluster pres_pm_codes)

predict Xuhat, resid

fracreg probit no_voting_ratio_win lnsalary_am_kokuji Xuhat ln_income_per ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type, vce(cluster pres_pm_codes)

gen sample_novote = 0
replace sample_novote = 1 if e(sample) == 1

drop Xuhat

program novote_2sri, rclass

capture drop Xuhat x1b1hat scale me_*

reg lnsalary_am_kokuji ln_mean_prefbigtype_1yago ln_income_per ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type, vce(cluster pres_pm_codes)

predict Xuhat, resid

fracreg probit no_voting_ratio_win lnsalary_am_kokuji Xuhat ln_income_per ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type, vce(cluster pres_pm_codes)

predict x1b1hat, xb
gen scale=normalden(x1b1hat)

foreach x of varlist lnsalary_am_kokuji Xuhat ln_income_per ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre ln_staff_all ln_salary_staff_all {
	return scalar b_`x'= _b[`x']
	gen me_`x'=scale*_b[`x']
	summarize me_`x'
	return scalar ame_`x'= r(mean)
}

foreach y of varlist expired_dummy touitsu_2011 touitsu_2015 touitsu_2019 {
	return scalar b_`y'= _b[`y']
	margins, at(`y' = (0 1))
	scalar yhat0_`y' = r(b)[1,1]
	scalar yhat1_`y' = r(b)[1,2]
	return scalar ame_`y'= yhat1_`y' - yhat0_`y'
}


end

preserve
drop if sample_novote == 0
bootstrap r(b_lnsalary_am_kokuji) r(b_Xuhat) r(b_ln_income_per) r(b_n_seats_adopt) r(b_population_elderly75_ratio) r(b_population_child15_ratio) r(b_ln_all_menseki) r(b_canlive_ratio_menseki) r(b_sigaika_ratio_area) r(b_ln_zaiseiryoku) r(b_win_ratio_musyozoku_pre) r(b_expired_dummy) r(b_touitsu_2011) r(b_touitsu_2015) r(b_touitsu_2019) r(b_ln_staff_all) r(b_ln_salary_staff_all) r(ame_lnsalary_am_kokuji) r(ame_Xuhat) r(ame_ln_income_per) r(ame_n_seats_adopt) r(ame_population_elderly75_ratio) r(ame_population_child15_ratio) r(ame_ln_all_menseki) r(ame_canlive_ratio_menseki) r(ame_sigaika_ratio_area) r(ame_ln_zaiseiryoku) r(ame_win_ratio_musyozoku_pre) r(ame_expired_dummy) r(ame_touitsu_2011) r(ame_touitsu_2015) r(ame_touitsu_2019) r(ame_ln_staff_all) r(ame_ln_salary_staff_all) , reps(1000) seed (10100) cluster(pres_pm_codes) idcluster(new_id_ppm): novote_2sri
restore
estimates store res_novote_2sri, title("2SRI_novote")

program drop novote_2sri
program novote_2sri, rclass

capture drop Xuhat x1b1hat scale me_*

reg lnsalary_am_kokuji ln_mean_prefbigtype_1yago ln_income_per ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type, vce(cluster pres_pm_codes)

predict Xuhat, resid

fracreg probit no_voting_ratio_win lnsalary_am_kokuji Xuhat ln_income_per ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type, vce(cluster pres_pm_codes)

predict x1b1hat, xb
gen scale=normalden(x1b1hat)

foreach x of varlist lnsalary_am_kokuji Xuhat ln_income_per ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre ln_staff_all ln_salary_staff_all {
	gen me_`x'=scale*_b[`x']
	summarize me_`x'
	return scalar ame_`x'= r(mean)
}

foreach y of varlist expired_dummy touitsu_2011 touitsu_2015 touitsu_2019 {
	margins, at(`y' = (0 1))
	scalar yhat0_`y' = r(b)[1,1]
	scalar yhat1_`y' = r(b)[1,2]
	return scalar ame_`y'= yhat1_`y' - yhat0_`y'
}


end

preserve
drop if sample_novote == 0
bootstrap r(ame_lnsalary_am_kokuji) r(ame_Xuhat) r(ame_ln_income_per) r(ame_ln_population) r(ame_n_seats_adopt) r(ame_population_elderly75_ratio) r(ame_population_child15_ratio) r(ame_ln_all_menseki) r(ame_canlive_ratio_menseki) r(ame_sigaika_ratio_area) r(ame_ln_zaiseiryoku) r(ame_win_ratio_musyozoku_pre) r(ame_expired_dummy) r(ame_touitsu_2011) r(ame_touitsu_2015) r(ame_touitsu_2019) r(ame_ln_staff_all) r(ame_ln_salary_staff_all) , reps(1000) seed (8767) cluster(pres_pm_codes) idcluster(new_id_ppm): novote_2sri
restore
estimates store res_novote_2sri, title("2SRI_novote")

esttab res_novote_2sri using "novote_2sri.tex", replace ///
star(* 0.10 ** 0.05 *** 0.01) booktabs ///
label b(3) se(3) stats(N, fmt(%9.0f) labels("観測数")) ///
nolz varwidth(16) modelwidth(13) style(tex)

**jyoreinot

poisson teian_jyorei_4y lnsalary_am_kokuji ln_income_per ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku i.expired_dummy i.touitsu_2011 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type, vce(cluster pres_pm_codes)
margins, dydx(lnsalary_am_kokuji ln_income_per ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku expired_dummy touitsu_2011 ln_staff_all ln_salary_staff_all)
forvalues k = 1/16 {
	di r(b)[1,`k']
}

program drop jyoreinot2sri
drop Xuhat 

program jyoreinot2sri, rclass

capture drop Xuhat

reg lnsalary_am_kokuji ln_mean_prefbigtype_1yago ln_income_per ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku i.expired_dummy i.touitsu_2011 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type, vce(cluster pres_pm_codes)

predict Xuhat, resid

poisson teian_jyorei_4y lnsalary_am_kokuji Xuhat ln_income_per ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku i.expired_dummy i.touitsu_2011 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type, vce(cluster pres_pm_codes)

margins, dydx(lnsalary_am_kokuji Xuhat ln_income_per ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku expired_dummy touitsu_2011 ln_staff_all ln_salary_staff_all)

forvalues k = 1/17 {
	return scalar ame_`k' = r(b)[1,`k']
}

end

program drop jyoreicont2sri
program jyoreicont2sri, rclass

capture drop Xuhat

reg lnsalary_am_kokuji ln_mean_prefbigtype_1yago ln_income_per ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku i.expired_dummy i.touitsu_2011 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type age_mean_wins ratio_women_wins_adopt win_ratio_musyozoku, vce(cluster pres_pm_codes)

predict Xuhat, resid

poisson teian_jyorei_4y lnsalary_am_kokuji Xuhat ln_income_per ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku i.expired_dummy i.touitsu_2011 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type age_mean_wins ratio_women_wins_adopt win_ratio_musyozoku, vce(cluster pres_pm_codes)

margins, dydx(lnsalary_am_kokuji Xuhat ln_income_per ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku i.expired_dummy touitsu_2011 ln_staff_all ln_salary_staff_all age_mean_wins ratio_women_wins_adopt win_ratio_musyozoku)

forvalues k = 1/20 {
	return scalar ame_`k' = r(b)[1,`k']
}

end



preserve
drop if sample_teian == 0
bootstrap r(ame_1) r(ame_2) r(ame_3) r(ame_4) r(ame_5) r(ame_6) r(ame_7) r(ame_8) r(ame_9) r(ame_10) r(ame_11) r(ame_12) r(ame_13) r(ame_14) r(ame_15) r(ame_16) r(ame_17) , reps(589) seed (8767) cluster(pres_pm_codes) idcluster(new_id_ppm): jyoreinot2sri
restore
estimates store res_not_jyorei_2sri, title("2SRI_not_jyorei")

esttab res_not_jyorei_2sri using "jyoreinot_2sri.tex", replace ///
star(* 0.10 ** 0.05 *** 0.01) booktabs ///
label b(3) se(3) stats(N, fmt(%9.0f) labels("観測数")) ///
nolz varwidth(16) modelwidth(13) style(tex)


preserve
drop if sample_teian_cont == 0
bootstrap r(ame_1) r(ame_2) r(ame_3) r(ame_4) r(ame_5) r(ame_6) r(ame_7) r(ame_8) r(ame_9) r(ame_10) r(ame_11) r(ame_12) r(ame_13) r(ame_14) r(ame_15) r(ame_16) r(ame_17) r(ame_18) r(ame_19) r(ame_20), reps(589) seed (3189) cluster(pres_pm_codes) idcluster(new_id_ppm): jyoreicont2sri
restore
estimates store res_cont_jyorei_2sri, title("2SRI_cont_jyorei")

esttab res_cont_jyorei_2sri using "jyoreicont_2sri.tex", replace ///
star(* 0.10 ** 0.05 *** 0.01) booktabs ///
label b(3) se(3) stats(N, fmt(%9.0f) labels("観測数")) ///
nolz varwidth(16) modelwidth(13) style(tex)





