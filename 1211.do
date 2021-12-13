xtset pres_pm_codes ele_t

encode ruiji_jinko, gen(ruiji_jinko_codes)

gen ln_salary_staff_all = log(salary_staff_all)

tabstat ln_mean_ruiji_1yago, by(ruiji_jinko_codes)

di log(5000)
scatter ln_salary_am_kokuji ln_population if (ruiji_jinko_codes == 1)|(ruiji_jinko_codes == 2), xline(8.5171932, lcolor(green))

di log(10000)
scatter ln_salary_am_kokuji ln_population if (ruiji_jinko_codes == 2)|(ruiji_jinko_codes == 3), xline(9.2103404, lcolor(green))

di log(15000)
scatter ln_salary_am_kokuji ln_population if (ruiji_jinko_codes == 3)|(ruiji_jinko_codes == 4), xline(9.6158055, lcolor(green))

di log(20000)
scatter ln_salary_am_kokuji ln_population if (ruiji_jinko_codes == 4)|(ruiji_jinko_codes == 5), xline(9.9034876, lcolor(green))

di log(50000)
scatter ln_salary_am_kokuji ln_population if (ruiji_jinko_codes == 6)|(ruiji_jinko_codes == 7), xline(10.819778, lcolor(green))

di log(100000)
scatter ln_salary_am_kokuji ln_population if (ruiji_jinko_codes == 7)|(ruiji_jinko_codes == 8), xline(11.512925, lcolor(green))

di log(150000)
scatter ln_salary_am_kokuji ln_population if (ruiji_jinko_codes == 8)|(ruiji_jinko_codes == 9), xline(11.918391, lcolor(green))


*test
gen choson1 = (ruiji_jinko_codes == 1)

reg ln_salary_am_kokuji i.ruiji_jinko_codes ln_population, vce(cluster pres_pm_codes)
reg ln_salary_am_kokuji i.ruiji_jinko_codes##c.ln_population, vce(cluster pres_pm_codes)
reg ln_salary_am_kokuji i.ruiji_jinko_codes##c.ln_population, vce(cluster pres_pm_codes)

ivregress 2sls compe_rate_adopt (ln_salary_am_kokuji = ln_mean_ruiji_1yago) ln_income_per ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all, vce(cluster pres_pm_codes)

ivregress 2sls compe_rate_adopt (ln_salary_am_kokuji = i.ruiji_jinko_codes) ln_income_per ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all, vce(cluster pres_pm_codes)

ivregress 2sls D.compe_rate_adopt (D.ln_salary_am_kokuji  = D.ln_mean_ruiji_1yago) D.(ln_income_per ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all), vce(cluster pres_pm_codes)
**でない


ivregress 2sls compe_rate_adopt (ln_salary_am_kokuji c.ln_salary_am_kokuji##c.ln_salary_am_kokuji = ln_mean_ruiji_1yago c.ln_mean_ruiji_1yago##c.ln_mean_ruiji_1yago) ln_income_per ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all, vce(cluster pres_pm_codes)

ivreg2 compe_rate_adopt (ln_salary_am_kokuji c.ln_salary_am_kokuji##c.ln_salary_am_kokuji = ln_mean_ruiji_1yago c.ln_mean_ruiji_1yago##c.ln_mean_ruiji_1yago) ln_income_per ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all, cluster(pres_pm_codes)
margins, dydx(ln_salary_am_kokuji) at(ln_salary_am_kokuji = (6.5 (0.5) 9.5))
marginsplot

ivreg2 compe_rate_adopt (ln_salary_am_kokuji c.ln_salary_am_kokuji##c.ln_salary_am_kokuji = ln_mean_ruiji_1yago c.ln_mean_ruiji_1yago##c.ln_mean_ruiji_1yago) ln_income_per ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all i.nendo i.pref_id i.muni_type, cluster(pres_pm_codes)
*ほぼない
margins, dydx(ln_salary_am_kokuji) at(ln_salary_am_kokuji = (6.5 (0.5) 9.5))
marginsplot

ivreg2 compe_rate_adopt (ln_salary_am_kokuji = ln_mean_ruiji_1yago) ln_income_per ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all i.nendo i.pref_id i.muni_type, cluster(pres_pm_codes)
*プラス10％有意
margins, dydx(ln_salary_am_kokuji) at(ln_salary_am_kokuji = (6.5 (0.5) 9.5))
marginsplot

ivreg2 compe_rate_adopt (ln_salary_am_kokuji = i.ruiji_jinko_codes) ln_income_per ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all i.nendo i.pref_id i.muni_type, cluster(pres_pm_codes)
*プラス1％有意
margins, dydx(ln_salary_am_kokuji) at(ln_salary_am_kokuji = (6.5 (0.5) 9.5))
marginsplot

ivregress 2sls compe_rate_adopt (ln_salary_am_kokuji = i.ruiji_jinko_codes) ln_income_per ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type, vce(cluster pres_pm_codes) first

ivregress 2sls ln_income_per (ln_salary_am_kokuji = i.ruiji_jinko_codes) ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type, vce(cluster pres_pm_codes) first

regress compe_rate_adopt ln_salary_am_kokuji ln_income_per ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all i.nendo i.pref_id i.muni_type, vce(cluster pres_pm_codes)
** OLSはdown-ward bias していた?

ivregress 2sls compe_rate_adopt (ln_salary_am_kokuji = ln_mean_ruiji_1yago) ln_income_per ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all i.nendo i.pref_id i.muni_type, vce(cluster pres_pm_codes) first
**有意性は弱い 
estat first


ivregress 2sls compe_rate_adopt (ln_salary_am_kokuji = ln_mean_ruiji_1yago) ln_income_per ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type, vce(cluster pres_pm_codes) first


xtivreg compe_rate_adopt (ln_salary_am_kokuji = ln_mean_ruiji_1yago) ln_income_per ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all nendo1-nendo15, nocons fd vce(cluster pres_pm_codes)
**点推定マイナス

xtivreg compe_rate_adopt (ln_salary_am_kokuji = ln_mean_ruiji_1yago) ln_income_per ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all nendo1-nendo15, nocons fd vce(cluster pres_pm_codes)
**点推定マイナス

xtivreg compe_rate_adopt (ln_salary_am_kokuji = ln_mean_ruiji_1yago) ln_income_per ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all nendo1-nendo15, fe vce(cluster pres_pm_codes)
**点推定マイナス

ivregress 2sls compe_rate_adopt (ln_salary_am_kokuji = ln_mean_ruiji_1yago) ln_income_per c.ln_population##c.ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all nendo1-nendo15, first vce(cluster pres_pm_codes)
**点推定マイナス

ivregress 2sls compe_rate_adopt (ln_salary_am_kokuji = i.ruiji_jinko_codes) ln_income_per c.ln_population##c.ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all nendo1-nendo15, first vce(cluster pres_pm_codes)
**点推定マイナス

ivregress 2sls compe_rate_adopt (ln_salary_am_kokuji = i.ruiji_jinko_codes) ln_income_per c.ln_population c.ln_population#i.ruiji_jinko_codes n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all nendo1-nendo15, first vce(cluster pres_pm_codes)

ivregress 2sls compe_rate_adopt (ln_salary_am_kokuji = i.ruiji_jinko_codes) ln_income_per c.ln_population c.ln_population#i.ruiji_jinko_codes n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all nendo1-nendo15, first vce(cluster pres_pm_codes)

xtivreg compe_rate_adopt (ln_salary_am_kokuji = ln_mean_ruiji_1yago) ln_income_per ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all nendo1-nendo15, fd vce(cluster pres_pm_codes)



regress compe_rate_adopt ln_salary_am_kokuji ln_income_per ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all i.nendo i.pref_id i.muni_type, vce(cluster pres_pm_codes)
** OLSはdown-ward bias していた?



ivreg2 compe_rate_adopt (ln_salary_am_kokuji = i.ruiji_jinko_codes) ln_income_per c.ln_population c.ln_population#i.ruiji_jinko_codes n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all i.nendo i.pref_id i.muni_type, cluster(pres_pm_codes)
*ない
margins, dydx(ln_salary_am_kokuji) at(ln_salary_am_kokuji = (6.5 (0.5) 9.5))
marginsplot

ivreg2 compe_rate_adopt (ln_salary_am_kokuji c.ln_salary_am_kokuji##c.ln_salary_am_kokuji = i.ruiji_jinko_codes) ln_income_per ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all i.nendo i.pref_id i.muni_type, cluster(pres_pm_codes)
margins, dydx(ln_salary_am_kokuji) at(ln_salary_am_kokuji = (6.5 (0.5) 9.5))
marginsplot

xtreg compe_rate_adopt c.ln_salary_am_kokuji##c.ln_salary_am_kokuji ln_income_per ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all i.nendo, fe vce(cluster pres_pm_codes)
margins, dydx(ln_salary_am_kokuji) at(ln_salary_am_kokuji = (6.5 (0.5) 9.5))
marginsplot

ivregress 2sls compe_rate_adopt (ln_salary_am_kokuji c.ln_salary_am_kokuji#c.ln_salary_am_kokuji = i.ruiji_jinko_codes) ln_income_per ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all, vce(cluster pres_pm_codes)

ivregress 2sls D.compe_rate_adopt (D.ln_salary_am_kokuji D.(c.ln_salary_am_kokuji##c.ln_salary_am_kokuji) = D.(ln_mean_ruiji_1yago c.ln_mean_ruiji_1yago##c.ln_mean_ruiji_1yago)) D.(ln_income_per ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all), vce(cluster pres_pm_codes)
** 出ない

ivregress 2sls D.compe_rate_adopt (D.ln_salary_am_kokuji D.(c.ln_salary_am_kokuji##c.ln_salary_am_kokuji) = ln_mean_ruiji_1yago c.ln_mean_ruiji_1yago##c.ln_mean_ruiji_1yago) D.(ln_income_per ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all), vce(cluster pres_pm_codes)
**出ない

ivregress 2sls D.compe_rate_adopt (D.ln_salary_am_kokuji D.(c.ln_salary_am_kokuji##c.ln_salary_am_kokuji) = i.ruiji_jinko_codes) D.(ln_income_per ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all), vce(cluster pres_pm_codes)
*無い


ivregress 2sls compe_rate_adopt (ln_salary_am_kokuji = ln_mean_ruiji_1yago) ln_income_per ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all i.pref_id i.muni_type, vce(cluster pres_pm_codes) 



ivregress 2sls compe_rate_adopt (ln_salary_am_kokuji = ln_mean_ruiji_1yago) ln_income_per ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all i.pref_id i.muni_type , vce(cluster pres_pm_codes) 

ivregress 2sls ratio_women_cand_adopt (ln_salary_am_kokuji = ln_mean_ruiji_1yago) ln_income_per ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all i.pref_id i.muni_type, vce(cluster pres_pm_codes) 
** プラス10%有意  

ivregress 2sls ratio_women_cand_adopt (ln_salary_am_kokuji = i.ruiji_jinko_codes) ln_income_per ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all i.pref_id i.muni_type, vce(cluster pres_pm_codes) 
** マイナス10%有意  

ivregress 2sls age_mean_cand (ln_salary_am_kokuji = i.ruiji_jinko_codes) ln_income_per ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all i.pref_id i.muni_type, vce(cluster pres_pm_codes) 
** マイナス1%有意  

ivregress 2sls age_mean_cand (ln_salary_am_kokuji = i.ruiji_jinko_codes) ln_income_per ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all i.pref_id i.muni_type, vce(cluster pres_pm_codes)

ivregress 2sls age_mean_cand (ln_salary_am_kokuji = i.ruiji_jinko_codes) ln_income_per ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all i.pref_id i.muni_type, vce(cluster pres_pm_codes)  

ivregress 2sls age_mean_cand (ln_salary_am_kokuji = i.ruiji_jinko_codes) ln_income_per ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all i.pref_id i.muni_type i.nendo, vce(cluster pres_pm_codes)  


xtivreg age_mean_cand (ln_salary_am_kokuji = i.ruiji_jinko_codes) ln_income_per ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all i.pref_id i.muni_type, fe vce(cluster pres_pm_codes)

xtivreg age_mean_cand (ln_salary_am_kokuji = i.ruiji_jinko_codes) ln_income_per ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all i.pref_id i.muni_type, fe vce(cluster pres_pm_codes)

ivregress 2sls D.age_mean_cand (D.ln_salary_am_kokuji = i.ruiji_jinko_codes) D.(ln_income_per ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all), vce(cluster pres_pm_codes)
estat first
**検定アカン

ivregress 2sls D.age_mean_cand (D.ln_salary_am_kokuji = ln_mean_ruiji_1yago) D.(ln_income_per ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all), vce(cluster pres_pm_codes)
estat first
**検定アカン

ivregress 2sls D.age_mean_cand (D.ln_salary_am_kokuji = ln_mean_ruiji_1yago) D.(ln_income_per ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all), vce(cluster pres_pm_codes)
estat first
**検定アカン

***
ivregress 2sls compe_rate_adopt (ln_salary_am_kokuji = ln_mean_ruiji_1yago) ln_income_per ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type, vce(cluster pres_pm_codes)

estat first

ivregress 2sls compe_rate_adopt (ln_salary_am_kokuji = ln_mean_ruiji_1yago) ln_income_per c.ln_population ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type if ruiji_jinko_codes <= 9, vce(cluster pres_pm_codes)
**特別市、中核市を除く
estat first
**検定びみょい

ivregress 2sls compe_rate_adopt (ln_salary_am_kokuji = ln_mean_ruiji_1yago) ln_income_per c.ln_population##c.ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type, vce(cluster pres_pm_codes)
estat first
**検定びみょい

ivregress 2sls compe_rate_adopt (ln_salary_am_kokuji = ln_mean_ruiji_1yago) ln_income_per c.ln_population##c.ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type if ruiji_jinko_codes <= 9, vce(cluster pres_pm_codes)
estat first
**検定びみょい

ivregress 2sls compe_rate_adopt (ln_salary_am_kokuji = ln_mean_ruiji_1yago) ln_income_per c.ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type, vce(cluster pres_pm_codes)
estat first

ivregress 2sls compe_rate_adopt (ln_salary_am_kokuji = i.ruiji_jinko_codes) ln_income_per ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type, vce(cluster pres_pm_codes)
estat first
*きれいに出た

ivregress 2sls compe_rate_adopt (ln_salary_am_kokuji = i.ruiji_jinko_codes) ln_income_per ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type if ruiji_jinko_codes <= 9, vce(cluster pres_pm_codes)
estat first
*きれいに出た

xtivreg compe_rate_adopt (ln_salary_am_kokuji = i.ruiji_jinko_codes) ln_income_per c.ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type if ruiji_jinko_codes <= 9, fe vce(cluster pres_pm_codes)
estat first

xtivreg compe_rate_adopt (ln_salary_am_kokuji = i.ruiji_jinko_codes) ln_income_per c.ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type, fe vce(cluster pres_pm_codes)
estat first

ivregress 2sls compe_rate_adopt (ln_salary_am_kokuji = i.ruiji_jinko_codes) ln_income_per c.ln_population##c.ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type, vce(cluster pres_pm_codes)
estat first
**検定びみょい

ivregress 2sls compe_rate_adopt (ln_salary_am_kokuji = i.ruiji_jinko_codes) ln_income_per c.ln_population c.ln_population#c.ln_population c.ln_population#i.ruiji_jinko_codes c.ln_population#c.ln_population#i.ruiji_jinko_codes n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type, vce(cluster pres_pm_codes)
estat first
**検定アウト

ivregress 2sls compe_rate_adopt (ln_salary_am_kokuji = i.ruiji_jinko_codes) ln_income_per c.ln_population c.ln_population#c.ln_population c.ln_population#i.ruiji_jinko_codes c.ln_population#c.ln_population#i.ruiji_jinko_codes n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type if ruiji_jinko_codes <= 9, vce(cluster pres_pm_codes)
estat first
**検定アウト

ivregress 2sls compe_rate_adopt (ln_salary_am_kokuji = i.ruiji_jinko_codes) ln_income_per c.ln_population##c.ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type if ruiji_jinko_codes <= 9, vce(cluster pres_pm_codes)
estat first
**検定びみょい

ivregress 2sls compe_rate_adopt (ln_salary_am_kokuji = i.ruiji_jinko_codes) ln_income_per c.ln_population c.ln_population#i.ruiji_jinko_codes n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type, vce(cluster pres_pm_codes)
estat first
**検定びみょい

ivregress 2sls compe_rate_adopt (ln_salary_am_kokuji = i.ruiji_jinko_codes) ln_income_per c.ln_population c.ln_population#i.ruiji_jinko_codes n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type if ruiji_jinko_codes <= 9, vce(cluster pres_pm_codes)
estat first
**検定びみょい

ivreg2 compe_rate_adopt (c.ln_salary_am_kokuji##c.ln_salary_am_kokuji  = i.ruiji_jinko_codes) ln_income_per c.ln_population c.ln_population#i.ruiji_jinko_codes n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type if ruiji_jinko_codes <= 9, cluster(pres_pm_codes)
estat first
margins, dydx(ln_salary_am_kokuji) at(ln_salary_am_kokuji = (6.5 (0.5) 9.5))
marginsplot
**検定びみょい

** 人口の関数形を変えると不連続ジャンプは消える　→　操作変数は妥当でない可能性

ivreg2 compe_rate_adopt (c.ln_salary_am_kokuji##c.ln_salary_am_kokuji  = i.ruiji_jinko_codes) ln_income_per c.ln_population c.ln_population#i.ruiji_jinko_codes n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type, cluster(pres_pm_codes)
margins, dydx(ln_salary_am_kokuji) at(ln_salary_am_kokuji = (6.5 (0.5) 9.5))
marginsplot
**検定びみょい,序盤マイナス有意

** ppml,2sri
drop xu_hat_frd
reg ln_salary_am_kokuji i.ruiji_jinko_codes ln_income_per ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type, vce(cluster pres_pm_codes)
test 2.ruiji_jinko_codes 3.ruiji_jinko_codes 4.ruiji_jinko_codes 5.ruiji_jinko_codes 6.ruiji_jinko_codes 7.ruiji_jinko_codes 8.ruiji_jinko_codes 9.ruiji_jinko_codes 10.ruiji_jinko_codes 11.ruiji_jinko_codes 12.ruiji_jinko_codes 13.ruiji_jinko_codes 14.ruiji_jinko_codes
predict xu_hat_frd, resid

poisson compe_rate_minus1_adj ln_salary_am_kokuji xu_hat_frd ln_income_per ln_population  n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type, vce(cluster pres_pm_codes)

reg ln_salary_am_kokuji i.ruiji_jinko_codes ln_income_per ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type if ruiji_jinko_codes <= 9, vce(cluster pres_pm_codes)
predict xu_hat_frd_if, resid
test 2.ruiji_jinko_codes 3.ruiji_jinko_codes 4.ruiji_jinko_codes 5.ruiji_jinko_codes 6.ruiji_jinko_codes 7.ruiji_jinko_codes 8.ruiji_jinko_codes 9.ruiji_jinko_codes

poisson compe_rate_minus1_adj ln_salary_am_kokuji xu_hat_frd_if ln_income_per ln_population  n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type if ruiji_jinko_codes <= 9, vce(cluster pres_pm_codes)

*ratio_women_cand_adopt
ivregress 2sls ratio_women_cand_adopt (ln_salary_am_kokuji = i.ruiji_jinko_codes) ln_income_per ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type, vce(cluster pres_pm_codes)
estat first
**マイナス有意

ivregress 2sls ratio_women_cand_adopt (ln_salary_am_kokuji = i.ruiji_jinko_codes) ln_income_per ln_population c.ln_population#i.ruiji_jinko_codes n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type, vce(cluster pres_pm_codes)
estat first
**検定アカン

ivregress 2sls ratio_women_cand_adopt (ln_salary_am_kokuji = i.ruiji_jinko_codes) ln_income_per ln_population c.ln_population#i.ruiji_jinko_codes n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type if ruiji_jinko_codes <= 9, vce(cluster pres_pm_codes)
estat first
**検定アカン

ivregress 2sls ratio_women_cand_adopt (ln_salary_am_kokuji = i.ruiji_jinko_codes) ln_income_per ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type if ruiji_jinko_codes <= 9, vce(cluster pres_pm_codes)
estat first
**マイナス有意

ivregress 2sls ratio_women_cand_adopt (ln_salary_am_kokuji = ln_mean_ruiji_1yago) ln_income_per ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type, vce(cluster pres_pm_codes)
estat first
**点推定プラス

ivregress 2sls ratio_women_cand_adopt (ln_salary_am_kokuji = ln_mean_ruiji_1yago) ln_income_per ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type, vce(cluster pres_pm_codes)
estat first

**fraction, 2sri
reg ln_salary_am_kokuji i.ruiji_jinko_codes ln_income_per ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type, vce(cluster pres_pm_codes)
test 2.ruiji_jinko_codes 3.ruiji_jinko_codes 4.ruiji_jinko_codes 5.ruiji_jinko_codes 6.ruiji_jinko_codes 7.ruiji_jinko_codes 8.ruiji_jinko_codes 9.ruiji_jinko_codes 10.ruiji_jinko_codes 11.ruiji_jinko_codes 12.ruiji_jinko_codes 13.ruiji_jinko_codes 14.ruiji_jinko_codes
predict wom_uhat_frd, resid

reg ln_salary_am_kokuji i.ruiji_jinko_codes ln_income_per c.ln_population c.ln_population#i.ruiji_jinko_codes  n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type, vce(cluster pres_pm_codes)
test 2.ruiji_jinko_codes 3.ruiji_jinko_codes 4.ruiji_jinko_codes 5.ruiji_jinko_codes 6.ruiji_jinko_codes 7.ruiji_jinko_codes 8.ruiji_jinko_codes 9.ruiji_jinko_codes 10.ruiji_jinko_codes 11.ruiji_jinko_codes 12.ruiji_jinko_codes 13.ruiji_jinko_codes 14.ruiji_jinko_codes


glm ratio_women_cand_adopt ln_salary_am_kokuji wom_uhat_frd ln_income_per ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type, fa(bin) link(probit) cluster(pres_pm_codes)
**マイナス有意

reg ln_salary_am_kokuji i.ruiji_jinko_codes ln_income_per ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type if ruiji_jinko_codes <= 9, vce(cluster pres_pm_codes)
predict wom_uhat_frd_if, resid


glm ratio_women_cand_adopt ln_salary_am_kokuji wom_uhat_frd_if ln_income_per ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type if ruiji_jinko_codes <= 9, fa(bin) link(probit) cluster(pres_pm_codes)
**マイナス有意


*age_mean_cand
ivregress 2sls age_mean_cand (ln_salary_am_kokuji = i.ruiji_jinko_codes) ln_income_per ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type, vce(cluster pres_pm_codes)
estat first

ivregress 2sls age_mean_cand (ln_salary_am_kokuji = i.ruiji_jinko_codes) ln_income_per ln_population c.ln_population#i.ruiji_jinko_codes n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type, vce(cluster pres_pm_codes)
estat first

ivregress 2sls age_mean_cand (ln_salary_am_kokuji = i.ruiji_jinko_codes) ln_income_per ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type if ruiji_jinko_codes <= 9, vce(cluster pres_pm_codes)
estat first

ivregress 2sls age_mean_cand (ln_salary_am_kokuji = ln_mean_ruiji_1yago) ln_income_per ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type, vce(cluster pres_pm_codes)
estat first

ivregress 2sls age_mean_cand (ln_salary_am_kokuji = ln_mean_ruiji_1yago) ln_income_per ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type if ruiji_jinko_codes <= 9, vce(cluster pres_pm_codes)
estat first
*検定びみょい

**teian jyorei
ivregress 2sls teian_jyorei_4y (ln_salary_am_kokuji = ln_mean_ruiji_1yago) ln_income_per ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type, vce(cluster pres_pm_codes)
estat first

ivregress 2sls teian_jyorei_4y (ln_salary_am_kokuji = ln_mean_ruiji_1yago) ln_income_per ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type if ruiji_jinko_codes <= 9, vce(cluster pres_pm_codes)
estat first
**検定アカン

ivregress 2sls teian_jyorei_4y (ln_salary_am_kokuji = i.ruiji_jinko_codes) ln_income_per ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type, vce(cluster pres_pm_codes)
estat first

ivregress 2sls teian_jyorei_4y (ln_salary_am_kokuji = i.ruiji_jinko_codes) ln_income_per ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type if ruiji_jinko_codes <= 9, vce(cluster pres_pm_codes)
estat first

ivregress 2sls teian_jyorei_4y (ln_salary_am_kokuji = i.ruiji_jinko_codes) ln_income_per ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type, vce(cluster pres_pm_codes)
estat first

ivregress 2sls teian_jyorei_4y (ln_salary_am_kokuji = i.ruiji_jinko_codes) ln_income_per ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type if ruiji_jinko_codes <= 9, vce(cluster pres_pm_codes)
estat first

**ppml
reg ln_salary_am_kokuji i.ruiji_jinko_codes ln_income_per ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type if teian_jyorei_4y != ., vce(cluster pres_pm_codes)
test 2.ruiji_jinko_codes 3.ruiji_jinko_codes 4.ruiji_jinko_codes 5.ruiji_jinko_codes 6.ruiji_jinko_codes 7.ruiji_jinko_codes 8.ruiji_jinko_codes 9.ruiji_jinko_codes 10.ruiji_jinko_codes 11.ruiji_jinko_codes 13.ruiji_jinko_codes 14.ruiji_jinko_codes
predict jyo_uhat_frd, resid

poisson teian_jyorei_4y ln_salary_am_kokuji jyo_uhat_frd ln_income_per ln_population  n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type, vce(cluster pres_pm_codes)

reg ln_salary_am_kokuji i.ruiji_jinko_codes ln_income_per ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type if (teian_jyorei_4y != .)&(ruiji_jinko_codes <= 9), vce(cluster pres_pm_codes)
test 2.ruiji_jinko_codes 3.ruiji_jinko_codes 4.ruiji_jinko_codes 5.ruiji_jinko_codes 6.ruiji_jinko_codes 7.ruiji_jinko_codes 8.ruiji_jinko_codes 9.ruiji_jinko_codes 
predict jyo_uhat_frd_if, resid

poisson teian_jyorei_4y ln_salary_am_kokuji jyo_uhat_frd_if ln_income_per ln_population  n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type if ruiji_jinko_codes <= 9, vce(cluster pres_pm_codes)

