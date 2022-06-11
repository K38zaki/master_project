

reg lnsalary_am_kokuji c.ln_mean_prefbigtype_1yago##c.ln_population ln_income_per n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type if compe_rate_minus1_adj != ., vce(cluster pres_pm_codes)

predict Xuhat1, resid

gen lnsala_int_lnpopu = lnsalary_am_kokuji*ln_population
reg lnsala_int_lnpopu c.ln_mean_prefbigtype_1yago##c.ln_population ln_income_per n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type if compe_rate_minus1_adj != ., vce(cluster pres_pm_codes)

predict Xuhat2, resid

poisson compe_rate_minus1_adj c.lnsalary_am_kokuji##c.ln_population Xuhat1 Xuhat2 ln_income_per n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type, vce(cluster pres_pm_codes)

margins, dydx(lnsalary_am_kokuji) at(ln_population = (5 (0.5) 15))

forvalues k = 1/21 {
	di r(b)[1,`k']
}

drop Xuhat1 Xuhat2
program drop compe2sri_int

program compe2sri_int, rclass

capture drop Xuhat1 Xuhat2

reg lnsalary_am_kokuji c.ln_mean_prefbigtype_1yago##c.ln_population ln_income_per n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type, vce(cluster pres_pm_codes)

predict Xuhat1, resid

reg lnsala_int_lnpopu c.ln_mean_prefbigtype_1yago##c.ln_population ln_income_per n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type, vce(cluster pres_pm_codes)

predict Xuhat2, resid

poisson compe_rate_minus1_adj c.lnsalary_am_kokuji##c.ln_population Xuhat1 Xuhat2 ln_income_per n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type, vce(cluster pres_pm_codes)

return scalar b_sala = _b[lnsalary_am_kokuji]
return scalar b_int = _b[c.lnsalary_am_kokuji#c.ln_population]
return scalar b_popu = _b[ln_population]

margins, dydx(lnsalary_am_kokuji) at(ln_population = (5 (0.5) 15))

forvalues k = 1/21 {
	return scalar ame_`k' = r(b)[1,`k']
}

end


preserve
drop if sample_compe == 0
bootstrap r(b_sala) r(b_int) r(b_popu) r(ame_1) r(ame_2) r(ame_3) r(ame_4) r(ame_5) r(ame_6) r(ame_7) r(ame_8) r(ame_9) r(ame_10) r(ame_11) r(ame_12) r(ame_13) r(ame_14) r(ame_15) r(ame_16) r(ame_17) r(ame_18) r(ame_19) r(ame_20) r(ame_21), reps(1000) seed (10101) cluster(pres_pm_codes) idcluster(new_id_ppm): compe2sri_int
restore
estimates store int_compe_2sri, title("2SRI_compe_int")

esttab int_compe_2sri using "compe_int_2sri_se.tex", replace ///
star(* 0.10 ** 0.05 *** 0.01) booktabs ///
label b(3) se(3) stats(N, fmt(%9.0f) labels("観測数")) ///
nolz varwidth(16) modelwidth(13) style(tex)

esttab int_compe_2sri using "compe_int_2sri_ci.tex", replace ///
star(* 0.10 ** 0.05 *** 0.01) booktabs ///
label b(3) ci(3) stats(N, fmt(%9.0f) labels("観測数")) ///
nolz varwidth(16) modelwidth(13) style(tex)

reg lnsalary_am_kokuji c.ln_mean_prefbigtype_1yago##c.ln_population ln_income_per n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type if ratio_women_cand_adopt != ., vce(cluster pres_pm_codes)

test c.ln_mean_prefbigtype_1yago#c.ln_population c.ln_mean_prefbigtype_1yago

reg lnsala_int_lnpopu c.ln_mean_prefbigtype_1yago##c.ln_population ln_income_per n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type if ratio_women_cand_adopt != ., vce(cluster pres_pm_codes)


program women2sri_int, rclass

capture drop Xuhat1 Xuhat2

reg lnsalary_am_kokuji c.ln_mean_prefbigtype_1yago##c.ln_population ln_income_per n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type, vce(cluster pres_pm_codes)

predict Xuhat1, resid

reg lnsala_int_lnpopu c.ln_mean_prefbigtype_1yago##c.ln_population ln_income_per n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type, vce(cluster pres_pm_codes)

predict Xuhat2, resid

fracreg probit ratio_women_cand_adopt c.lnsalary_am_kokuji##c.ln_population Xuhat1 Xuhat2 ln_income_per n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type, vce(cluster pres_pm_codes)

return scalar b_sala = _b[lnsalary_am_kokuji]
return scalar b_int = _b[c.lnsalary_am_kokuji#c.ln_population]
return scalar b_popu = _b[ln_population]

margins, dydx(lnsalary_am_kokuji) at(ln_population = (5 (0.5) 15))

forvalues k = 1/21 {
	return scalar ame_`k' = r(b)[1,`k']
}

end

preserve
drop if sample_women == 0
bootstrap r(b_sala) r(b_int) r(b_popu) r(ame_1) r(ame_2) r(ame_3) r(ame_4) r(ame_5) r(ame_6) r(ame_7) r(ame_8) r(ame_9) r(ame_10) r(ame_11) r(ame_12) r(ame_13) r(ame_14) r(ame_15) r(ame_16) r(ame_17) r(ame_18) r(ame_19) r(ame_20) r(ame_21), reps(500) seed (10101) cluster(pres_pm_codes) idcluster(new_id_ppm): women2sri_int
restore
estimates store int_women_2sri, title("2SRI_women_int")

preserve
drop if sample_women == 0
bootstrap r(b_sala) r(b_int) r(b_popu) r(ame_1) r(ame_2) r(ame_3) r(ame_4) r(ame_5) r(ame_6) r(ame_7) r(ame_8) r(ame_9) r(ame_10) r(ame_11) r(ame_12) r(ame_13) r(ame_14) r(ame_15) r(ame_16) r(ame_17) r(ame_18) r(ame_19) r(ame_20) r(ame_21), reps(589) seed (3175) cluster(pres_pm_codes) idcluster(new_id_ppm): women2sri_int
restore
estimates store int_women_2sri, title("2SRI_women_int")


esttab int_women_2sri using "women_int_2sri_se2.tex", replace ///
star(* 0.10 ** 0.05 *** 0.01) booktabs ///
label b(3) se(3) stats(N, fmt(%9.0f) labels("観測数")) ///
nolz varwidth(16) modelwidth(13) style(tex)

esttab int_women_2sri using "women_int_2sri_ci2.tex", replace ///
star(* 0.10 ** 0.05 *** 0.01) booktabs ///
label b(3) ci(3) stats(N, fmt(%9.0f) labels("観測数")) ///
nolz varwidth(16) modelwidth(13) style(tex)

**interaction dummy_updown_salary

gen upsala_lnpopu = dummy_up_salary_am*ln_population
gen upsala_lnpopu_sq = dummy_up_salary_am*ln_population*ln_population
gen downsala_lnpopu = dummy_down_salary_am*ln_population
gen downsala_lnpopu_sq = dummy_down_salary_am*ln_population*ln_population


reg dummy_up_salary_am c.upratio##c.ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type compe_rate_adopt ratio_women_cand_adopt age_mean_cand cand_ratio_musyozoku if voting_rate_p != ., vce(cluster pres_pm_codes)

test c.upratio#c.ln_population upratio

reg upsala_lnpopu c.upratio##c.ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type compe_rate_adopt ratio_women_cand_adopt age_mean_cand cand_ratio_musyozoku if voting_rate_p != ., vce(cluster pres_pm_codes)

test c.upratio#c.ln_population upratio

reg dummy_up_salary_am c.upratio##c.ln_population##c.ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type compe_rate_adopt ratio_women_cand_adopt age_mean_cand cand_ratio_musyozoku if voting_rate_p != ., vce(cluster pres_pm_codes)

test c.upratio#c.ln_population#c.ln_population c.upratio#c.ln_population upratio

reg upsala_lnpopu c.upratio##c.ln_population##c.ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type compe_rate_adopt ratio_women_cand_adopt age_mean_cand cand_ratio_musyozoku if voting_rate_p != ., vce(cluster pres_pm_codes)

test c.upratio#c.ln_population#c.ln_population c.upratio#c.ln_population upratio

reg upsala_lnpopu_sq c.upratio##c.ln_population##c.ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type compe_rate_adopt ratio_women_cand_adopt age_mean_cand cand_ratio_musyozoku if voting_rate_p != ., vce(cluster pres_pm_codes)

test c.upratio#c.ln_population#c.ln_population c.upratio#c.ln_population upratio



program drop votingup2sri_int
program votingup2sri_int, rclass

capture drop Xuhat11 Xuhat12 Xuhat21 Xuhat22 Xuhat23

reg dummy_up_salary_am c.upratio##c.ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type compe_rate_adopt ratio_women_cand_adopt age_mean_cand cand_ratio_musyozoku, vce(cluster pres_pm_codes)

predict Xuhat11, resid

reg upsala_lnpopu c.upratio##c.ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type compe_rate_adopt ratio_women_cand_adopt age_mean_cand cand_ratio_musyozoku, vce(cluster pres_pm_codes)

predict Xuhat12, resid

fracreg probit voting_rate_p dummy_up_salary_am##c.ln_population Xuhat11 Xuhat12 n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type compe_rate_adopt ratio_women_cand_adopt age_mean_cand cand_ratio_musyozoku, vce(cluster pres_pm_codes)

return scalar b_dummy = _b[1.dummy_up_salary_am]
return scalar b_int = _b[1.dummy_up_salary_am#c.ln_population]
return scalar b_popu = _b[ln_population]


reg dummy_up_salary_am c.upratio##c.ln_population##c.ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type compe_rate_adopt ratio_women_cand_adopt age_mean_cand cand_ratio_musyozoku, vce(cluster pres_pm_codes)

predict Xuhat21, resid 

reg upsala_lnpopu c.upratio##c.ln_population##c.ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type compe_rate_adopt ratio_women_cand_adopt age_mean_cand cand_ratio_musyozoku, vce(cluster pres_pm_codes)

predict Xuhat22, resid 


reg upsala_lnpopu_sq c.upratio##c.ln_population##c.ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type compe_rate_adopt ratio_women_cand_adopt age_mean_cand cand_ratio_musyozoku, vce(cluster pres_pm_codes)

predict Xuhat23, resid 

fracreg probit voting_rate_p dummy_up_salary_am##c.ln_population##c.ln_population Xuhat21 Xuhat22 Xuhat23 n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type compe_rate_adopt ratio_women_cand_adopt age_mean_cand cand_ratio_musyozoku, vce(cluster pres_pm_codes)

return scalar b2_dummy = _b[1.dummy_up_salary_am]
return scalar b2_int = _b[1.dummy_up_salary_am#c.ln_population]
return scalar b2_intsq = _b[1.dummy_up_salary_am#c.ln_population#c.ln_population]
return scalar b2_popu = _b[ln_population]
return scalar b2_popusq = _b[c.ln_population#c.ln_population]
end


reg dummy_down_salary_am c.downratio##c.ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type compe_rate_adopt ratio_women_cand_adopt age_mean_cand cand_ratio_musyozoku if voting_rate_p != ., vce(cluster pres_pm_codes)

test c.downratio#c.ln_population downratio

reg downsala_lnpopu c.downratio##c.ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type compe_rate_adopt ratio_women_cand_adopt age_mean_cand cand_ratio_musyozoku if voting_rate_p != ., vce(cluster pres_pm_codes)

test c.downratio#c.ln_population downratio

reg dummy_down_salary_am c.downratio##c.ln_population##c.ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type compe_rate_adopt ratio_women_cand_adopt age_mean_cand cand_ratio_musyozoku if voting_rate_p != ., vce(cluster pres_pm_codes)

test c.downratio#c.ln_population c.downratio#c.ln_population#c.ln_population downratio

reg downsala_lnpopu c.downratio##c.ln_population##c.ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type compe_rate_adopt ratio_women_cand_adopt age_mean_cand cand_ratio_musyozoku if voting_rate_p != ., vce(cluster pres_pm_codes)

test c.downratio#c.ln_population c.downratio#c.ln_population#c.ln_population  downratio

reg downsala_lnpopu_sq c.downratio##c.ln_population##c.ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type compe_rate_adopt ratio_women_cand_adopt age_mean_cand cand_ratio_musyozoku if voting_rate_p != ., vce(cluster pres_pm_codes)

test c.downratio#c.ln_population c.downratio#c.ln_population#c.ln_population downratio



program drop votingdown2sri_int
program votingdown2sri_int, rclass

capture drop Xuhat11 Xuhat12 Xuhat21 Xuhat22 Xuhat23

reg dummy_down_salary_am c.downratio##c.ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type compe_rate_adopt ratio_women_cand_adopt age_mean_cand cand_ratio_musyozoku, vce(cluster pres_pm_codes)

predict Xuhat11, resid

reg downsala_lnpopu c.downratio##c.ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type compe_rate_adopt ratio_women_cand_adopt age_mean_cand cand_ratio_musyozoku, vce(cluster pres_pm_codes)

predict Xuhat12, resid  

fracreg probit voting_rate_p dummy_down_salary_am##c.ln_population Xuhat11 Xuhat12 n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type compe_rate_adopt ratio_women_cand_adopt age_mean_cand cand_ratio_musyozoku, vce(cluster pres_pm_codes)

return scalar b_dummy = _b[1.dummy_down_salary_am]
return scalar b_int = _b[1.dummy_down_salary_am#c.ln_population]
return scalar b_popu = _b[ln_population]


reg dummy_down_salary_am c.downratio##c.ln_population##c.ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type compe_rate_adopt ratio_women_cand_adopt age_mean_cand cand_ratio_musyozoku, vce(cluster pres_pm_codes)

predict Xuhat21, resid 

reg downsala_lnpopu c.downratio##c.ln_population##c.ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type compe_rate_adopt ratio_women_cand_adopt age_mean_cand cand_ratio_musyozoku, vce(cluster pres_pm_codes)

predict Xuhat22, resid

reg downsala_lnpopu_sq c.downratio##c.ln_population##c.ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type compe_rate_adopt ratio_women_cand_adopt age_mean_cand cand_ratio_musyozoku, vce(cluster pres_pm_codes)

predict Xuhat23, resid

fracreg probit voting_rate_p dummy_down_salary_am##c.ln_population##c.ln_population Xuhat21 Xuhat22 Xuhat23 n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type compe_rate_adopt ratio_women_cand_adopt age_mean_cand cand_ratio_musyozoku, vce(cluster pres_pm_codes)

return scalar b2_dummy = _b[1.dummy_down_salary_am]
return scalar b2_int = _b[1.dummy_down_salary_am#c.ln_population]
return scalar b2_intsq = _b[1.dummy_down_salary_am#c.ln_population#c.ln_population]
return scalar b2_popu = _b[ln_population]
return scalar b2_popusq = _b[c.ln_population#c.ln_population]

end

preserve
drop if sample_voting == 0
bootstrap r(b_dummy) r(b_int) r(b_popu) r(b2_dummy) r(b2_int) r(b2_intsq) r(b2_popu) r(b2_popusq) , reps(500) seed (10101) cluster(pres_pm_codes) idcluster(new_id_ppm): votingup2sri_int
estimates store up_vot_2sri_int, title("2SRI_votup_inter")
restore

preserve
drop if sample_voting == 0
bootstrap r(b_dummy) r(b_int) r(b_popu) r(b2_dummy) r(b2_int) r(b2_intsq) r(b2_popu) r(b2_popusq) , reps(500) seed (10101) cluster(pres_pm_codes) idcluster(new_id_ppm): votingdown2sri_int
estimates store down_vot_2sri_int, title("2SRI_votdown_inter")
restore

**result
esttab up_vot_2sri_int down_vot_2sri_int using "voting_int_2sri_rev.tex", replace ///
star(* 0.10 ** 0.05 *** 0.01) booktabs ///
label b(3) se(3) stats(N, fmt(%9.0f) labels("観測数")) ///
nolz varwidth(16) modelwidth(13) style(tex)

reg dummy_up_salary c.upratio##c.ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type ratio_women_cand_adopt age_mean_cand cand_ratio_musyozoku if adjusted_ave_voteshare_inc != ., vce(cluster pres_pm_codes)

test upratio c.upratio#c.ln_population

reg upsala_lnpopu c.upratio##c.ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type ratio_women_cand_adopt age_mean_cand cand_ratio_musyozoku if adjusted_ave_voteshare_inc != ., vce(cluster pres_pm_codes)

test upratio c.upratio#c.ln_population

reg dummy_up_salary_am c.upratio##c.ln_population##c.ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type ratio_women_cand_adopt age_mean_cand cand_ratio_musyozoku if adjusted_ave_voteshare_inc != . , vce(cluster pres_pm_codes)

test upratio c.upratio#c.ln_population c.upratio#c.ln_population#c.ln_population  

reg upsala_lnpopu c.upratio##c.ln_population##c.ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type ratio_women_cand_adopt age_mean_cand cand_ratio_musyozoku if adjusted_ave_voteshare_inc != ., vce(cluster pres_pm_codes)

test upratio c.upratio#c.ln_population c.upratio#c.ln_population#c.ln_population 

reg upsala_lnpopu_sq c.upratio##c.ln_population##c.ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type ratio_women_cand_adopt age_mean_cand cand_ratio_musyozoku if adjusted_ave_voteshare_inc != ., vce(cluster pres_pm_codes)

test upratio c.upratio#c.ln_population c.upratio#c.ln_population#c.ln_population   


program incup2sri_int, rclass

capture drop Xuhat11 Xuhat12 Xuhat21 Xuhat22 Xuhat23

reg dummy_up_salary c.upratio##c.ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type ratio_women_cand_adopt age_mean_cand cand_ratio_musyozoku, vce(cluster pres_pm_codes)

predict Xuhat11, resid

reg upsala_lnpopu c.upratio##c.ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type ratio_women_cand_adopt age_mean_cand cand_ratio_musyozoku, vce(cluster pres_pm_codes)

predict Xuhat12, resid

fracreg probit adjusted_ave_voteshare_inc dummy_up_salary_am##c.ln_population Xuhat11 Xuhat12 n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type ratio_women_cand_adopt age_mean_cand cand_ratio_musyozoku, vce(cluster pres_pm_codes)

return scalar b_dummy = _b[1.dummy_up_salary_am]
return scalar b_int = _b[1.dummy_up_salary_am#c.ln_population]
return scalar b_popu = _b[ln_population]


reg dummy_up_salary_am c.upratio##c.ln_population##c.ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type ratio_women_cand_adopt age_mean_cand cand_ratio_musyozoku, vce(cluster pres_pm_codes)

predict Xuhat21, resid 

reg upsala_lnpopu c.upratio##c.ln_population##c.ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type ratio_women_cand_adopt age_mean_cand cand_ratio_musyozoku, vce(cluster pres_pm_codes)

predict Xuhat22, resid 

reg upsala_lnpopu_sq c.upratio##c.ln_population##c.ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type ratio_women_cand_adopt age_mean_cand cand_ratio_musyozoku, vce(cluster pres_pm_codes)

predict Xuhat23, resid 

fracreg probit adjusted_ave_voteshare_inc  dummy_up_salary_am##c.ln_population##c.ln_population Xuhat21 Xuhat22 Xuhat23 n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type ratio_women_cand_adopt age_mean_cand cand_ratio_musyozoku, vce(cluster pres_pm_codes)

return scalar b2_dummy = _b[1.dummy_up_salary_am]
return scalar b2_int = _b[1.dummy_up_salary_am#c.ln_population]
return scalar b2_intsq = _b[1.dummy_up_salary_am#c.ln_population#c.ln_population]
return scalar b2_popu = _b[ln_population]
return scalar b2_popusq = _b[c.ln_population#c.ln_population]
end


reg dummy_down_salary c.downratio##c.ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type ratio_women_cand_adopt age_mean_cand cand_ratio_musyozoku if adjusted_ave_voteshare_inc != ., vce(cluster pres_pm_codes)

test downratio c.downratio#c.ln_population

reg downsala_lnpopu c.downratio##c.ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type ratio_women_cand_adopt age_mean_cand cand_ratio_musyozoku if adjusted_ave_voteshare_inc != ., vce(cluster pres_pm_codes)

test downratio c.downratio#c.ln_population

reg dummy_down_salary_am c.downratio##c.ln_population##c.ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type ratio_women_cand_adopt age_mean_cand cand_ratio_musyozoku if adjusted_ave_voteshare_inc != . , vce(cluster pres_pm_codes)

test downratio c.downratio#c.ln_population c.downratio#c.ln_population#c.ln_population  

reg downsala_lnpopu c.downratio##c.ln_population##c.ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type ratio_women_cand_adopt age_mean_cand cand_ratio_musyozoku if adjusted_ave_voteshare_inc != ., vce(cluster pres_pm_codes)

test downratio c.downratio#c.ln_population c.downratio#c.ln_population#c.ln_population 

reg downsala_lnpopu_sq c.downratio##c.ln_population##c.ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type ratio_women_cand_adopt age_mean_cand cand_ratio_musyozoku if adjusted_ave_voteshare_inc != ., vce(cluster pres_pm_codes)

test downratio c.downratio#c.ln_population c.downratio#c.ln_population#c.ln_population   


program incdown2sri_int, rclass

capture drop Xuhat11 Xuhat12 Xuhat21 Xuhat22 Xuhat23

reg dummy_down_salary c.downratio##c.ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_typ ratio_women_cand_adopt age_mean_cand cand_ratio_musyozoku, vce(cluster pres_pm_codes)

predict Xuhat11, resid 

reg downsala_lnpopu c.downratio##c.ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_typ ratio_women_cand_adopt age_mean_cand cand_ratio_musyozoku, vce(cluster pres_pm_codes)

predict Xuhat12, resid 

fracreg probit adjusted_ave_voteshare_inc dummy_down_salary_am##c.ln_population Xuhat11 Xuhat12 n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_typ ratio_women_cand_adopt age_mean_cand cand_ratio_musyozoku, vce(cluster pres_pm_codes)

return scalar b_dummy = _b[1.dummy_down_salary_am]
return scalar b_int = _b[1.dummy_down_salary_am#c.ln_population]
return scalar b_popu = _b[ln_population]


reg dummy_down_salary c.downratio##c.ln_population##c.ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type ratio_women_cand_adopt age_mean_cand cand_ratio_musyozoku, vce(cluster pres_pm_codes)

predict Xuhat21, resid 

reg downsala_lnpopu c.downratio##c.ln_population##c.ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type ratio_women_cand_adopt age_mean_cand cand_ratio_musyozoku, vce(cluster pres_pm_codes)

predict Xuhat22, resid 

reg downsala_lnpopu_sq c.downratio##c.ln_population##c.ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type ratio_women_cand_adopt age_mean_cand cand_ratio_musyozoku, vce(cluster pres_pm_codes)

predict Xuhat23, resid 

fracreg probit adjusted_ave_voteshare_inc dummy_down_salary_am##c.ln_population##c.ln_population Xuhat21 Xuhat22 Xuhat23 n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type ratio_women_cand_adopt age_mean_cand cand_ratio_musyozoku, vce(cluster pres_pm_codes)

return scalar b2_dummy = _b[1.dummy_down_salary_am]
return scalar b2_int = _b[1.dummy_down_salary_am#c.ln_population]
return scalar b2_intsq = _b[1.dummy_down_salary_am#c.ln_population#c.ln_population]
return scalar b2_popu = _b[ln_population]
return scalar b2_popusq = _b[c.ln_population#c.ln_population]

end

preserve
drop if sample_inc == 0
bootstrap r(b_dummy) r(b_int) r(b_popu) r(b2_dummy) r(b2_int) r(b2_intsq) r(b2_popu) r(b2_popusq) , reps(500) seed (10101) cluster(pres_pm_codes) idcluster(new_id_ppm): incup2sri_int
estimates store up_inc_2sri_int, title("2SRI_incup_inter")
restore

preserve
drop if sample_inc == 0
bootstrap r(b_dummy) r(b_int) r(b_popu) r(b2_dummy) r(b2_int) r(b2_intsq) r(b2_popu) r(b2_popusq) , reps(500) seed (10101) cluster(pres_pm_codes) idcluster(new_id_ppm): incdown2sri_int
estimates store down_inc_2sri_int, title("2SRI_incdown_inter")
restore





**result
esttab up_inc_2sri_int down_inc_2sri_int using "incum_int_2sri_rev.tex", replace ///
star(* 0.10 ** 0.05 *** 0.01) booktabs ///
label b(3) se(3) stats(N, fmt(%9.0f) labels("観測数")) ///
nolz varwidth(16) modelwidth(13) style(tex)


**500に調整

preserve
drop if sample_inc == 0
bootstrap r(b_dummy) r(b_int) r(b_popu) r(b2_dummy) r(b2_int) r(b2_intsq) r(b2_popu) r(b2_popusq) , reps(600) seed (10101) cluster(pres_pm_codes) idcluster(new_id_ppm): incup2sri_int
estimates store up_inc_2sri_int, title("2SRI_incup_inter2")
restore

preserve
drop if sample_inc == 0
bootstrap r(b_dummy) r(b_int) r(b_popu) r(b2_dummy) r(b2_int) r(b2_intsq) r(b2_popu) r(b2_popusq) , reps(600) seed (10101) cluster(pres_pm_codes) idcluster(new_id_ppm): incdown2sri_int
estimates store down_inc_2sri_int, title("2SRI_incdown_inter2")
restore


esttab up_inc_2sri_int down_inc_2sri_int using "incum_int_2sri_rev.tex", replace ///
star(* 0.10 ** 0.05 *** 0.01) booktabs ///
label b(3) se(3) stats(N, fmt(%9.0f) labels("観測数")) ///
nolz varwidth(16) modelwidth(13) style(tex)


preserve
drop if sample_voting == 0
bootstrap r(b_dummy) r(b_int) r(b_popu) r(b2_dummy) r(b2_int) r(b2_intsq) r(b2_popu) r(b2_popusq) , reps(600) seed (10101) cluster(pres_pm_codes) idcluster(new_id_ppm): votingup2sri_int
estimates store up_vot_2sri_int, title("2SRI_votup_inter")
restore

preserve
drop if sample_voting == 0
bootstrap r(b_dummy) r(b_int) r(b_popu) r(b2_dummy) r(b2_int) r(b2_intsq) r(b2_popu) r(b2_popusq) , reps(600) seed (10101) cluster(pres_pm_codes) idcluster(new_id_ppm): votingdown2sri_int
estimates store down_vot_2sri_int, title("2SRI_votdown_inter")
restore


esttab up_vot_2sri_int down_vot_2sri_int using "voting_int_2sri_rev.tex", replace ///
star(* 0.10 ** 0.05 *** 0.01) booktabs ///
label b(3) se(3) stats(N, fmt(%9.0f) labels("観測数")) ///
nolz varwidth(16) modelwidth(13) style(tex)










**唯一出た vote_down 1乗

reg dummy_down_salary_am c.downratio##c.ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type compe_rate_adopt ratio_women_cand_adopt age_mean_cand cand_ratio_musyozoku, vce(cluster pres_pm_codes)

predict Xuhat11, resid

reg downsala_lnpopu c.downratio##c.ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type compe_rate_adopt ratio_women_cand_adopt age_mean_cand cand_ratio_musyozoku, vce(cluster pres_pm_codes)

predict Xuhat12, resid  

fracreg probit voting_rate_p i.dummy_down_salary_am##c.ln_population Xuhat11 Xuhat12 n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type compe_rate_adopt ratio_women_cand_adopt age_mean_cand cand_ratio_musyozoku, vce(cluster pres_pm_codes)

margins, dydx(dummy_down_salary_am) at(ln_population = (5 (0.5) 15))

program votingdown2sri_ame, rclass

capture drop Xuhat11 Xuhat12

reg dummy_down_salary_am c.downratio##c.ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type compe_rate_adopt ratio_women_cand_adopt age_mean_cand cand_ratio_musyozoku, vce(cluster pres_pm_codes)

predict Xuhat11, resid

reg downsala_lnpopu c.downratio##c.ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type compe_rate_adopt ratio_women_cand_adopt age_mean_cand cand_ratio_musyozoku, vce(cluster pres_pm_codes)

predict Xuhat12, resid  

fracreg probit voting_rate_p i.dummy_down_salary_am##c.ln_population Xuhat11 Xuhat12 n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type compe_rate_adopt ratio_women_cand_adopt age_mean_cand cand_ratio_musyozoku, vce(cluster pres_pm_codes)

margins, dydx(dummy_down_salary_am) at(ln_population = (5 (0.5) 15))

forvalues k = 22/42 {
	return scalar ame_`k' = r(b)[1,`k']
}

end

preserve
drop if sample_inc == 0
bootstrap r(ame_22) r(ame_23) r(ame_24) r(ame_25) r(ame_26) r(ame_27) r(ame_28) r(ame_29) r(ame_30) r(ame_31) r(ame_32) r(ame_33) r(ame_34) r(ame_35) r(ame_36) r(ame_37) r(ame_38) r(ame_39) r(ame_40) r(ame_41) r(ame_42), reps(500) seed (10101) cluster(pres_pm_codes) idcluster(new_id_ppm): votingdown2sri_ame
restore
estimates store down_vote_2sri_ame, title("2SRI_votdown_inter_ame")

esttab down_vote_2sri_ame using "down_vote_int_2sri_ame.tex", replace ///
star(* 0.10 ** 0.05 *** 0.01) booktabs ///
label b(3) se(3) stats(N, fmt(%9.0f) labels("観測数")) ///
nolz varwidth(16) modelwidth(13) style(tex)
