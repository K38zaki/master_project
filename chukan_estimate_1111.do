sum cate_change_salary

** Set as panel data 
tsset pres_pm_codes ele_t

* CompeRate

**Pooled OLS
reg  compe_rate_adopt lnsalary_am_kokuji, vce(cluster pres_pm_codes)

outreg2 using myreg.xls, replace ctitle(OLS) addtext(Municipality FE, No, Nendo FE, No)

reg compe_rate_adopt lnsalary_am_kokuji ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_time_year ln_all_menseki canlive_ratio_menseki sigaika_ratio_area zaiseiryoku_index cand_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019, vce(cluster pres_pm_codes) 

outreg2 using myreg.xlsx, append ctitle(OLS)  addtext(Municipality FE, No, Nendo FE, No)

**FE
xtreg compe_rate_adopt lnsalary_am_kokuji i.nendo, fe vce(cluster pres_pm_codes) 

outreg2 using myreg.xls, append ctitle(FE) keep(lnsalary_am_kokuji) addtext(Municipality FE, Yes, Nendo FE, Yes)

xtreg compe_rate_adopt lnsalary_am_kokuji ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_time_year ln_all_menseki canlive_ratio_menseki sigaika_ratio_area zaiseiryoku_index cand_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 i.nendo, fe vce(cluster pres_pm_codes) 

outreg2 using myreg.xls, append ctitle(FE) keep(lnsalary_am_kokuji ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_time_year ln_all_menseki canlive_ratio_menseki sigaika_ratio_area zaiseiryoku_index cand_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019) addtext(Municipality FE, Yes, Nendo FE, Yes)

**FD
reg D.compe_rate_adopt D.lnsalary_am_kokuji, nocons cluster(pres_pm_codes)

outreg2 using myreg_fd.xls, replace ctitle(FD)

reg D.compe_rate_adopt D.lnsalary_am_kokuji D.(ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_time_year ln_all_menseki canlive_ratio_menseki sigaika_ratio_area zaiseiryoku_index cand_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 nendo1 nendo2 nendo3 nendo4 nendo5 nendo6 nendo7 nendo8 nendo9 nendo10 nendo11 nendo12 nendo13 nendo14 nendo15) , nocons cluster(pres_pm_codes)

outreg2 using myreg_fd.xls, append ctitle(FD) keep(D.lnsalary_am_kokuji D.ln_population D.n_seats_adopt D.population_elderly75_ratio D.population_child15_ratio D.ln_income_time_year D.ln_all_menseki D.canlive_ratio_menseki D.sigaika_ratio_area D.zaiseiryoku_index D.cand_ratio_musyozoku_pre D.expired_dummy D.touitsu_2007 D.touitsu_2011 D.touitsu_2015 D.touitsu_2019)

reg D.compe_rate_adopt D.lnsalary_am_kokuji D.(ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_time_year ln_all_menseki canlive_ratio_menseki sigaika_ratio_area zaiseiryoku_index cand_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 nendo1 nendo2 nendo3 nendo4 nendo5 nendo6 nendo7 nendo8 nendo9 nendo10 nendo11 nendo12 nendo13 nendo14 nendo15) , cluster(pres_pm_codes)

outreg2 using myreg_fd.xls, append ctitle(FD _cons) keep(D.lnsalary_am_kokuji D.ln_population D.n_seats_adopt D.population_elderly75_ratio D.population_child15_ratio D.ln_income_time_year D.ln_all_menseki D.canlive_ratio_menseki D.sigaika_ratio_area D.zaiseiryoku_index D.cand_ratio_musyozoku_pre D.expired_dummy D.touitsu_2007 D.touitsu_2011 D.touitsu_2015 D.touitsu_2019)

**FDIV
ivreg D.compe_rate_adopt (D.lnsalary_am_kokuji = L1.lnsalary_am_kokuji) D.(ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_time_year ln_all_menseki canlive_ratio_menseki sigaika_ratio_area zaiseiryoku_index cand_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 nendo1 nendo2 nendo3 nendo4 nendo5 nendo6 nendo7 nendo8 nendo9 nendo10 nendo11 nendo12 nendo13 nendo14 nendo15) , nocons cluster(pres_pm_codes) 

outreg2 using myreg_fd.xls, append ctitle(FDIV) keep(D.lnsalary_am_kokuji D.ln_population D.n_seats_adopt D.population_elderly75_ratio D.population_child15_ratio D.ln_income_time_year D.ln_all_menseki D.canlive_ratio_menseki D.sigaika_ratio_area D.zaiseiryoku_index D.cand_ratio_musyozoku_pre D.expired_dummy D.touitsu_2007 D.touitsu_2011 D.touitsu_2015 D.touitsu_2019)

ivreg D.compe_rate_adopt (D.lnsalary_am_kokuji = L1.lnsalary_am_kokuji) D.(ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_time_year ln_all_menseki canlive_ratio_menseki sigaika_ratio_area zaiseiryoku_index cand_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 nendo1 nendo2 nendo3 nendo4 nendo5 nendo6 nendo7 nendo8 nendo9 nendo10 nendo11 nendo12 nendo13 nendo14 nendo15) , cluster(pres_pm_codes) 

outreg2 using myreg_fd.xls, append ctitle(FDIV _cons) keep(D.lnsalary_am_kokuji D.ln_population D.n_seats_adopt D.population_elderly75_ratio D.population_child15_ratio D.ln_income_time_year D.ln_all_menseki D.canlive_ratio_menseki D.sigaika_ratio_area D.zaiseiryoku_index D.cand_ratio_musyozoku_pre D.expired_dummy D.touitsu_2007 D.touitsu_2011 D.touitsu_2015 D.touitsu_2019)

**FDIV lag dep
ivreg D.compe_rate_adopt (LD.compe_rate_adopt D.lnsalary_am_kokuji = L2.compe_rate_adopt L1.lnsalary_am_kokuji) D.(ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_time_year ln_all_menseki canlive_ratio_menseki sigaika_ratio_area zaiseiryoku_index cand_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 nendo1 nendo2 nendo3 nendo4 nendo5 nendo6 nendo7 nendo8 nendo9 nendo10 nendo11 nendo12 nendo13 nendo14 nendo15) , nocons cluster(pres_pm_codes)

outreg2 using myreg_fd.xls, append ctitle(FDIV lag_dep) keep(LD.compe_rate_adopt D.lnsalary_am_kokuji D.ln_population D.n_seats_adopt D.population_elderly75_ratio D.population_child15_ratio D.ln_income_time_year D.ln_all_menseki D.canlive_ratio_menseki D.sigaika_ratio_area D.zaiseiryoku_index D.cand_ratio_musyozoku_pre D.expired_dummy D.touitsu_2007 D.touitsu_2011 D.touitsu_2015 D.touitsu_2019)

ivreg D.compe_rate_adopt (LD.compe_rate_adopt D.lnsalary_am_kokuji = L2.compe_rate_adopt L1.lnsalary_am_kokuji) D.(ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_time_year ln_all_menseki canlive_ratio_menseki sigaika_ratio_area zaiseiryoku_index cand_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 nendo1 nendo2 nendo3 nendo4 nendo5 nendo6 nendo7 nendo8 nendo9 nendo10 nendo11 nendo12 nendo13 nendo14 nendo15) , cluster(pres_pm_codes)

outreg2 using myreg_fd.xls, append ctitle(FDIV lag_dep _cons) keep(LD.compe_rate_adopt D.lnsalary_am_kokuji D.ln_population D.n_seats_adopt D.population_elderly75_ratio D.population_child15_ratio D.ln_income_time_year D.ln_all_menseki D.canlive_ratio_menseki D.sigaika_ratio_area D.zaiseiryoku_index D.cand_ratio_musyozoku_pre D.expired_dummy D.touitsu_2007 D.touitsu_2011 D.touitsu_2015 D.touitsu_2019)

* ratio_women_cand_adopt

**Pooled OLS
reg  ratio_women_cand_adopt lnsalary_am_kokuji, vce(cluster pres_pm_codes)

outreg2 using myreg_wo.xls, replace ctitle(OLS) addtext(Municipality FE, No, Nendo FE, No)

reg ratio_women_cand_adopt lnsalary_am_kokuji ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_time_year ln_all_menseki canlive_ratio_menseki sigaika_ratio_area zaiseiryoku_index cand_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019, vce(cluster pres_pm_codes) 

outreg2 using myreg_wo.xlsx, append ctitle(OLS)  addtext(Municipality FE, No, Nendo FE, No)

**FE
xtreg ratio_women_cand_adopt lnsalary_am_kokuji i.nendo, fe vce(cluster pres_pm_codes) 

outreg2 using myreg_wo.xls, append ctitle(FE) keep(lnsalary_am_kokuji) addtext(Municipality FE, Yes, Nendo FE, Yes)

xtreg ratio_women_cand_adopt lnsalary_am_kokuji ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_time_year ln_all_menseki canlive_ratio_menseki sigaika_ratio_area zaiseiryoku_index cand_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 i.nendo, fe vce(cluster pres_pm_codes) 

outreg2 using myreg_wo.xls, append ctitle(FE) keep(lnsalary_am_kokuji ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_time_year ln_all_menseki canlive_ratio_menseki sigaika_ratio_area zaiseiryoku_index cand_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019) addtext(Municipality FE, Yes, Nendo FE, Yes)

**FD
reg D.ratio_women_cand_adopt D.lnsalary_am_kokuji, nocons cluster(pres_pm_codes)

outreg2 using myreg_wo_fd.xls, replace ctitle(FD)

reg D.ratio_women_cand_adopt D.lnsalary_am_kokuji D.(ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_time_year ln_all_menseki canlive_ratio_menseki sigaika_ratio_area zaiseiryoku_index cand_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 nendo1 nendo2 nendo3 nendo4 nendo5 nendo6 nendo7 nendo8 nendo9 nendo10 nendo11 nendo12 nendo13 nendo14 nendo15) , nocons cluster(pres_pm_codes)

outreg2 using myreg_wo_fd.xls, append ctitle(FD) keep(D.lnsalary_am_kokuji D.ln_population D.n_seats_adopt D.population_elderly75_ratio D.population_child15_ratio D.ln_income_time_year D.ln_all_menseki D.canlive_ratio_menseki D.sigaika_ratio_area D.zaiseiryoku_index D.cand_ratio_musyozoku_pre D.expired_dummy D.touitsu_2007 D.touitsu_2011 D.touitsu_2015 D.touitsu_2019)

reg D.ratio_women_cand_adopt D.lnsalary_am_kokuji D.(ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_time_year ln_all_menseki canlive_ratio_menseki sigaika_ratio_area zaiseiryoku_index cand_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 nendo1 nendo2 nendo3 nendo4 nendo5 nendo6 nendo7 nendo8 nendo9 nendo10 nendo11 nendo12 nendo13 nendo14 nendo15) , cluster(pres_pm_codes)

outreg2 using myreg_wo_fd.xls, append ctitle(FD _cons) keep(D.lnsalary_am_kokuji D.ln_population D.n_seats_adopt D.population_elderly75_ratio D.population_child15_ratio D.ln_income_time_year D.ln_all_menseki D.canlive_ratio_menseki D.sigaika_ratio_area D.zaiseiryoku_index D.cand_ratio_musyozoku_pre D.expired_dummy D.touitsu_2007 D.touitsu_2011 D.touitsu_2015 D.touitsu_2019)

**FDIV
ivreg D.ratio_women_cand_adopt (D.lnsalary_am_kokuji = L1.lnsalary_am_kokuji) D.(ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_time_year ln_all_menseki canlive_ratio_menseki sigaika_ratio_area zaiseiryoku_index cand_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 nendo1 nendo2 nendo3 nendo4 nendo5 nendo6 nendo7 nendo8 nendo9 nendo10 nendo11 nendo12 nendo13 nendo14 nendo15) , nocons cluster(pres_pm_codes) 

outreg2 using myreg_wo_fd.xls, append ctitle(FDIV) keep(D.lnsalary_am_kokuji D.ln_population D.n_seats_adopt D.population_elderly75_ratio D.population_child15_ratio D.ln_income_time_year D.ln_all_menseki D.canlive_ratio_menseki D.sigaika_ratio_area D.zaiseiryoku_index D.cand_ratio_musyozoku_pre D.expired_dummy D.touitsu_2007 D.touitsu_2011 D.touitsu_2015 D.touitsu_2019)

ivreg D.ratio_women_cand_adopt (D.lnsalary_am_kokuji = L1.lnsalary_am_kokuji) D.(ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_time_year ln_all_menseki canlive_ratio_menseki sigaika_ratio_area zaiseiryoku_index cand_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 nendo1 nendo2 nendo3 nendo4 nendo5 nendo6 nendo7 nendo8 nendo9 nendo10 nendo11 nendo12 nendo13 nendo14 nendo15) , cluster(pres_pm_codes) 

outreg2 using myreg_wo_fd.xls, append ctitle(FDIV _cons) keep(D.lnsalary_am_kokuji D.ln_population D.n_seats_adopt D.population_elderly75_ratio D.population_child15_ratio D.ln_income_time_year D.ln_all_menseki D.canlive_ratio_menseki D.sigaika_ratio_area D.zaiseiryoku_index D.cand_ratio_musyozoku_pre D.expired_dummy D.touitsu_2007 D.touitsu_2011 D.touitsu_2015 D.touitsu_2019)

**FDIV lag dep
ivreg D.ratio_women_cand_adopt (LD.ratio_women_cand_adopt D.lnsalary_am_kokuji = L2.ratio_women_cand_adopt L1.lnsalary_am_kokuji) D.(ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_time_year ln_all_menseki canlive_ratio_menseki sigaika_ratio_area zaiseiryoku_index cand_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 nendo1 nendo2 nendo3 nendo4 nendo5 nendo6 nendo7 nendo8 nendo9 nendo10 nendo11 nendo12 nendo13 nendo14 nendo15) , nocons cluster(pres_pm_codes)

outreg2 using myreg_wo_fd.xls, append ctitle(FDIV lag_dep) keep(LD.ratio_women_cand_adopt D.lnsalary_am_kokuji D.ln_population D.n_seats_adopt D.population_elderly75_ratio D.population_child15_ratio D.ln_income_time_year D.ln_all_menseki D.canlive_ratio_menseki D.sigaika_ratio_area D.zaiseiryoku_index D.cand_ratio_musyozoku_pre D.expired_dummy D.touitsu_2007 D.touitsu_2011 D.touitsu_2015 D.touitsu_2019)

ivreg D.ratio_women_cand_adopt (LD.ratio_women_cand_adopt D.lnsalary_am_kokuji = L2.ratio_women_cand_adopt L1.lnsalary_am_kokuji) D.(ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_time_year ln_all_menseki canlive_ratio_menseki sigaika_ratio_area zaiseiryoku_index cand_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 nendo1 nendo2 nendo3 nendo4 nendo5 nendo6 nendo7 nendo8 nendo9 nendo10 nendo11 nendo12 nendo13 nendo14 nendo15) , cluster(pres_pm_codes)

outreg2 using myreg_wo_fd.xls, append ctitle(FDIV lag_dep _cons) keep(LD.ratio_women_cand_adopt D.lnsalary_am_kokuji D.ln_population D.n_seats_adopt D.population_elderly75_ratio D.population_child15_ratio D.ln_income_time_year D.ln_all_menseki D.canlive_ratio_menseki D.sigaika_ratio_area D.zaiseiryoku_index D.cand_ratio_musyozoku_pre D.expired_dummy D.touitsu_2007 D.touitsu_2011 D.touitsu_2015 D.touitsu_2019)


* age_mean_cand

**Pooled OLS
reg  age_mean_cand lnsalary_am_kokuji, vce(cluster pres_pm_codes)

outreg2 using myreg_age.xls, replace ctitle(OLS) addtext(Municipality FE, No, Nendo FE, No)

reg age_mean_cand lnsalary_am_kokuji ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_time_year ln_all_menseki canlive_ratio_menseki sigaika_ratio_area zaiseiryoku_index cand_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019, vce(cluster pres_pm_codes) 

outreg2 using myreg_age.xls, append ctitle(OLS)  addtext(Municipality FE, No, Nendo FE, No)

**FE
xtreg age_mean_cand lnsalary_am_kokuji i.nendo, fe vce(cluster pres_pm_codes) 

outreg2 using myreg_age.xls, append ctitle(FE) keep(lnsalary_am_kokuji) addtext(Municipality FE, Yes, Nendo FE, Yes)

xtreg age_mean_cand lnsalary_am_kokuji ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_time_year ln_all_menseki canlive_ratio_menseki sigaika_ratio_area zaiseiryoku_index cand_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 i.nendo, fe vce(cluster pres_pm_codes) 

outreg2 using myreg_age.xls, append ctitle(FE) keep(lnsalary_am_kokuji ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_time_year ln_all_menseki canlive_ratio_menseki sigaika_ratio_area zaiseiryoku_index cand_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019) addtext(Municipality FE, Yes, Nendo FE, Yes)

**FD
reg D.age_mean_cand D.lnsalary_am_kokuji, nocons cluster(pres_pm_codes)

outreg2 using myreg_age_fd.xls, replace ctitle(FD)

reg D.age_mean_cand D.lnsalary_am_kokuji D.(ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_time_year ln_all_menseki canlive_ratio_menseki sigaika_ratio_area zaiseiryoku_index cand_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 nendo1 nendo2 nendo3 nendo4 nendo5 nendo6 nendo7 nendo8 nendo9 nendo10 nendo11 nendo12 nendo13 nendo14 nendo15) , nocons cluster(pres_pm_codes)

outreg2 using myreg_age_fd.xls, append ctitle(FD) keep(D.lnsalary_am_kokuji D.ln_population D.n_seats_adopt D.population_elderly75_ratio D.population_child15_ratio D.ln_income_time_year D.ln_all_menseki D.canlive_ratio_menseki D.sigaika_ratio_area D.zaiseiryoku_index D.cand_ratio_musyozoku_pre D.expired_dummy D.touitsu_2007 D.touitsu_2011 D.touitsu_2015 D.touitsu_2019)

reg D.age_mean_cand D.lnsalary_am_kokuji D.(ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_time_year ln_all_menseki canlive_ratio_menseki sigaika_ratio_area zaiseiryoku_index cand_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 nendo1 nendo2 nendo3 nendo4 nendo5 nendo6 nendo7 nendo8 nendo9 nendo10 nendo11 nendo12 nendo13 nendo14 nendo15) , cluster(pres_pm_codes)

outreg2 using myreg_age_fd.xls, append ctitle(FD _cons) keep(D.lnsalary_am_kokuji D.ln_population D.n_seats_adopt D.population_elderly75_ratio D.population_child15_ratio D.ln_income_time_year D.ln_all_menseki D.canlive_ratio_menseki D.sigaika_ratio_area D.zaiseiryoku_index D.cand_ratio_musyozoku_pre D.expired_dummy D.touitsu_2007 D.touitsu_2011 D.touitsu_2015 D.touitsu_2019)

**FDIV
ivreg D.age_mean_cand (D.lnsalary_am_kokuji = L1.lnsalary_am_kokuji) D.(ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_time_year ln_all_menseki canlive_ratio_menseki sigaika_ratio_area zaiseiryoku_index cand_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 nendo1 nendo2 nendo3 nendo4 nendo5 nendo6 nendo7 nendo8 nendo9 nendo10 nendo11 nendo12 nendo13 nendo14 nendo15) , nocons cluster(pres_pm_codes) 

outreg2 using myreg_age_fd.xls, append ctitle(FDIV) keep(D.lnsalary_am_kokuji D.ln_population D.n_seats_adopt D.population_elderly75_ratio D.population_child15_ratio D.ln_income_time_year D.ln_all_menseki D.canlive_ratio_menseki D.sigaika_ratio_area D.zaiseiryoku_index D.cand_ratio_musyozoku_pre D.expired_dummy D.touitsu_2007 D.touitsu_2011 D.touitsu_2015 D.touitsu_2019)

ivreg D.age_mean_cand (D.lnsalary_am_kokuji = L1.lnsalary_am_kokuji) D.(ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_time_year ln_all_menseki canlive_ratio_menseki sigaika_ratio_area zaiseiryoku_index cand_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 nendo1 nendo2 nendo3 nendo4 nendo5 nendo6 nendo7 nendo8 nendo9 nendo10 nendo11 nendo12 nendo13 nendo14 nendo15) , cluster(pres_pm_codes) 

outreg2 using myreg_age_fd.xls, append ctitle(FDIV _cons) keep(D.lnsalary_am_kokuji D.ln_population D.n_seats_adopt D.population_elderly75_ratio D.population_child15_ratio D.ln_income_time_year D.ln_all_menseki D.canlive_ratio_menseki D.sigaika_ratio_area D.zaiseiryoku_index D.cand_ratio_musyozoku_pre D.expired_dummy D.touitsu_2007 D.touitsu_2011 D.touitsu_2015 D.touitsu_2019)

**FDIV lag dep
ivreg D.age_mean_cand (LD.age_mean_cand D.lnsalary_am_kokuji = L2.age_mean_cand L1.lnsalary_am_kokuji) D.(ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_time_year ln_all_menseki canlive_ratio_menseki sigaika_ratio_area zaiseiryoku_index cand_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 nendo1 nendo2 nendo3 nendo4 nendo5 nendo6 nendo7 nendo8 nendo9 nendo10 nendo11 nendo12 nendo13 nendo14 nendo15) , nocons cluster(pres_pm_codes)

outreg2 using myreg_age_fd.xls, append ctitle(FDIV lag_dep) keep(LD.age_mean_cand D.lnsalary_am_kokuji D.ln_population D.n_seats_adopt D.population_elderly75_ratio D.population_child15_ratio D.ln_income_time_year D.ln_all_menseki D.canlive_ratio_menseki D.sigaika_ratio_area D.zaiseiryoku_index D.cand_ratio_musyozoku_pre D.expired_dummy D.touitsu_2007 D.touitsu_2011 D.touitsu_2015 D.touitsu_2019)

ivreg D.age_mean_cand (LD.age_mean_cand D.lnsalary_am_kokuji = L2.age_mean_cand L1.lnsalary_am_kokuji) D.(ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_time_year ln_all_menseki canlive_ratio_menseki sigaika_ratio_area zaiseiryoku_index cand_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 nendo1 nendo2 nendo3 nendo4 nendo5 nendo6 nendo7 nendo8 nendo9 nendo10 nendo11 nendo12 nendo13 nendo14 nendo15) , cluster(pres_pm_codes)

outreg2 using myreg_age_fd.xls, append ctitle(FDIV lag_dep _cons) keep(LD.age_mean_cand D.lnsalary_am_kokuji D.ln_population D.n_seats_adopt D.population_elderly75_ratio D.population_child15_ratio D.ln_income_time_year D.ln_all_menseki D.canlive_ratio_menseki D.sigaika_ratio_area D.zaiseiryoku_index D.cand_ratio_musyozoku_pre D.expired_dummy D.touitsu_2007 D.touitsu_2011 D.touitsu_2015 D.touitsu_2019)

** adjusted_ave_voteshere_inc

**Pooled OLS
reg adjusted_ave_voteshere_inc i.cate_change_salary, vce(cluster pres_pm_codes) 

outreg2 using myreg_inc.xls, replace ctitle(OLS) addtext(Municipality FE, No, Nendo FE, No)

reg adjusted_ave_voteshere_inc i.cate_change_salary ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_time_year ln_all_menseki canlive_ratio_menseki sigaika_ratio_area zaiseiryoku_index cand_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019, vce(cluster pres_pm_codes) 

outreg2 using myreg_inc.xls, append ctitle(OLS) addtext(Municipality FE, No, Nendo FE, No)

**FE
xtreg adjusted_ave_voteshere_inc i.cate_change_salary i.nendo, fe vce(cluster pres_pm_codes) 

outreg2 using myreg_inc.xls, append ctitle(FE) keep(i.cate_change_salary) addtext(Municipality FE, Yes, Nendo FE, Yes)

xtreg adjusted_ave_voteshere_inc i.cate_change_salary ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_time_year ln_all_menseki canlive_ratio_menseki sigaika_ratio_area zaiseiryoku_index cand_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 i.nendo, fe vce(cluster pres_pm_codes) 

outreg2 using myreg_inc.xls, append ctitle(FE) keep(i.cate_change_salary ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_time_year ln_all_menseki canlive_ratio_menseki sigaika_ratio_area zaiseiryoku_index cand_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019) addtext(Municipality FE, Yes, Nendo FE, Yes)

**FE interaction with absolute

xtreg adjusted_ave_voteshere_inc i.cate_change_salary i.cate_change_salary#c.abs_change_salary_am ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_time_year ln_all_menseki canlive_ratio_menseki sigaika_ratio_area zaiseiryoku_index cand_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 i.nendo, fe vce(cluster pres_pm_codes) 

outreg2 using myreg_inc.xls, append ctitle(FE) keep(i.cate_change_salary i.cate_change_salary#c.abs_change_salary_am ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_time_year ln_all_menseki canlive_ratio_menseki sigaika_ratio_area zaiseiryoku_index cand_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019) addtext(Municipality FE, Yes, Nendo FE, Yes)

**FE interaction with ln_population

xtreg adjusted_ave_voteshere_inc i.cate_change_salary i.cate_change_salary#c.ln_population ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_time_year ln_all_menseki canlive_ratio_menseki sigaika_ratio_area zaiseiryoku_index cand_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 i.nendo, fe vce(cluster pres_pm_codes) 

outreg2 using myreg_inc.xls, append ctitle(FE) keep(i.cate_change_salary i.cate_change_salary#c.ln_population ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_time_year ln_all_menseki canlive_ratio_menseki sigaika_ratio_area zaiseiryoku_index cand_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019) addtext(Municipality FE, Yes, Nendo FE, Yes)

xtreg adjusted_ave_voteshere_inc i.cate_change_salary i.cate_change_salary#c.ln_population i.cate_change_salary#c.ln_population#c.ln_population ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_time_year ln_all_menseki canlive_ratio_menseki sigaika_ratio_area zaiseiryoku_index cand_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 i.nendo, fe vce(cluster pres_pm_codes) 

outreg2 using myreg_inc.xls, append ctitle(FE) keep(i.cate_change_salary i.cate_change_salary#c.ln_population i.cate_change_salary#c.ln_population#c.ln_population ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_time_year ln_all_menseki canlive_ratio_menseki sigaika_ratio_area zaiseiryoku_index cand_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019) addtext(Municipality FE, Yes, Nendo FE, Yes)

margins, dydx(i.cate_change_salary) at(ln_population = (5 6 7 8 9 10 11 12 13 14 15))
marginsplot

** voting_rate_isna

**Pooled OLS
reg voting_rate_isna i.cate_change_salary, vce(cluster pres_pm_codes) 

outreg2 using myreg_vote.xls, replace ctitle(OLS) addtext(Municipality FE, No, Nendo FE, No)

reg voting_rate_isna i.cate_change_salary ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_time_year ln_all_menseki canlive_ratio_menseki sigaika_ratio_area zaiseiryoku_index cand_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019, vce(cluster pres_pm_codes) 

outreg2 using myreg_vote.xls, append ctitle(OLS) addtext(Municipality FE, No, Nendo FE, No)

**FE
xtreg voting_rate_isna i.cate_change_salary i.nendo, fe vce(cluster pres_pm_codes) 

outreg2 using myreg_vote.xls, append ctitle(FE) keep(i.cate_change_salary) addtext(Municipality FE, Yes, Nendo FE, Yes)

xtreg voting_rate_isna i.cate_change_salary ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_time_year ln_all_menseki canlive_ratio_menseki sigaika_ratio_area zaiseiryoku_index cand_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 i.nendo, fe vce(cluster pres_pm_codes) 

outreg2 using myreg_vote.xls, append ctitle(FE) keep(i.cate_change_salary ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_time_year ln_all_menseki canlive_ratio_menseki sigaika_ratio_area zaiseiryoku_index cand_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019) addtext(Municipality FE, Yes, Nendo FE, Yes)

**FE interaction with absolute

xtreg voting_rate_isna i.cate_change_salary i.cate_change_salary#c.abs_change_salary_am ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_time_year ln_all_menseki canlive_ratio_menseki sigaika_ratio_area zaiseiryoku_index cand_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 i.nendo, fe vce(cluster pres_pm_codes) 

outreg2 using myreg_vote.xls, append ctitle(FE) keep(i.cate_change_salary i.cate_change_salary#c.abs_change_salary_am ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_time_year ln_all_menseki canlive_ratio_menseki sigaika_ratio_area zaiseiryoku_index cand_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019) addtext(Municipality FE, Yes, Nendo FE, Yes)

**FE interaction with ln_population

xtreg voting_rate_isna i.cate_change_salary i.cate_change_salary#c.ln_population ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_time_year ln_all_menseki canlive_ratio_menseki sigaika_ratio_area zaiseiryoku_index cand_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 i.nendo, fe vce(cluster pres_pm_codes) 

outreg2 using myreg_vote.xls, append ctitle(FE) keep(i.cate_change_salary i.cate_change_salary#c.ln_population ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_time_year ln_all_menseki canlive_ratio_menseki sigaika_ratio_area zaiseiryoku_index cand_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019) addtext(Municipality FE, Yes, Nendo FE, Yes)

xtreg voting_rate_isna i.cate_change_salary i.cate_change_salary#c.ln_population i.cate_change_salary#c.ln_population#c.ln_population c.ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_time_year ln_all_menseki canlive_ratio_menseki sigaika_ratio_area zaiseiryoku_index cand_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 i.nendo, fe vce(cluster pres_pm_codes) 

outreg2 using myreg_vote.xls, append ctitle(FE) keep(i.cate_change_salary i.cate_change_salary#c.ln_population i.cate_change_salary#c.ln_population#c.ln_population c.ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_time_year ln_all_menseki canlive_ratio_menseki sigaika_ratio_area zaiseiryoku_index cand_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019) addtext(Municipality FE, Yes, Nendo FE, Yes)

margins, dydx(i.cate_change_salary) at(ln_population = (5 6 7 8 9 10 11 12 13 14 15))
marginsplot

**no_voting_ratio_win

**Pooled OLS
reg no_voting_ratio_win lnsalary_am_kokuji, vce(cluster pres_pm_codes)

outreg2 using myreg_novote.xls, replace ctitle(OLS) addtext(Municipality FE, No, Nendo FE, No)

reg no_voting_ratio_win lnsalary_am_kokuji ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_time_year ln_all_menseki canlive_ratio_menseki sigaika_ratio_area zaiseiryoku_index cand_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019, vce(cluster pres_pm_codes) 

outreg2 using myreg_novote.xls, append ctitle(OLS)  addtext(Municipality FE, No, Nendo FE, No)

**FE
xtreg no_voting_ratio_win lnsalary_am_kokuji i.nendo, fe vce(cluster pres_pm_codes) 

outreg2 using myreg_novote.xls, append ctitle(FE) keep(lnsalary_am_kokuji) addtext(Municipality FE, Yes, Nendo FE, Yes)

xtreg no_voting_ratio_win lnsalary_am_kokuji ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_time_year ln_all_menseki canlive_ratio_menseki sigaika_ratio_area zaiseiryoku_index cand_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 i.nendo, fe vce(cluster pres_pm_codes) 

outreg2 using myreg_novote.xls, append ctitle(FE) keep(lnsalary_am_kokuji ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_time_year ln_all_menseki canlive_ratio_menseki sigaika_ratio_area zaiseiryoku_index cand_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019) addtext(Municipality FE, Yes, Nendo FE, Yes)

**FD
reg D.no_voting_ratio_win D.lnsalary_am_kokuji, nocons cluster(pres_pm_codes)

outreg2 using myreg_novote_fd.xls, replace ctitle(FD)

reg D.no_voting_ratio_win D.lnsalary_am_kokuji D.(ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_time_year ln_all_menseki canlive_ratio_menseki sigaika_ratio_area zaiseiryoku_index cand_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 nendo1 nendo2 nendo3 nendo4 nendo5 nendo6 nendo7 nendo8 nendo9 nendo10 nendo11 nendo12 nendo13 nendo14 nendo15) , nocons cluster(pres_pm_codes)

outreg2 using myreg_novote_fd.xls, append ctitle(FD) keep(D.lnsalary_am_kokuji D.ln_population D.n_seats_adopt D.population_elderly75_ratio D.population_child15_ratio D.ln_income_time_year D.ln_all_menseki D.canlive_ratio_menseki D.sigaika_ratio_area D.zaiseiryoku_index D.cand_ratio_musyozoku_pre D.expired_dummy D.touitsu_2007 D.touitsu_2011 D.touitsu_2015 D.touitsu_2019)

reg D.no_voting_ratio_win D.lnsalary_am_kokuji D.(ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_time_year ln_all_menseki canlive_ratio_menseki sigaika_ratio_area zaiseiryoku_index cand_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 nendo1 nendo2 nendo3 nendo4 nendo5 nendo6 nendo7 nendo8 nendo9 nendo10 nendo11 nendo12 nendo13 nendo14 nendo15) , cluster(pres_pm_codes)

outreg2 using myreg_novote_fd.xls, append ctitle(FD _cons) keep(D.lnsalary_am_kokuji D.ln_population D.n_seats_adopt D.population_elderly75_ratio D.population_child15_ratio D.ln_income_time_year D.ln_all_menseki D.canlive_ratio_menseki D.sigaika_ratio_area D.zaiseiryoku_index D.cand_ratio_musyozoku_pre D.expired_dummy D.touitsu_2007 D.touitsu_2011 D.touitsu_2015 D.touitsu_2019)

**FDIV
ivreg D.no_voting_ratio_win (D.lnsalary_am_kokuji = L1.lnsalary_am_kokuji) D.(ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_time_year ln_all_menseki canlive_ratio_menseki sigaika_ratio_area zaiseiryoku_index cand_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 nendo1 nendo2 nendo3 nendo4 nendo5 nendo6 nendo7 nendo8 nendo9 nendo10 nendo11 nendo12 nendo13 nendo14 nendo15) , nocons cluster(pres_pm_codes) 

outreg2 using myreg_novote_fd.xls, append ctitle(FDIV) keep(D.lnsalary_am_kokuji D.ln_population D.n_seats_adopt D.population_elderly75_ratio D.population_child15_ratio D.ln_income_time_year D.ln_all_menseki D.canlive_ratio_menseki D.sigaika_ratio_area D.zaiseiryoku_index D.cand_ratio_musyozoku_pre D.expired_dummy D.touitsu_2007 D.touitsu_2011 D.touitsu_2015 D.touitsu_2019)

ivreg D.no_voting_ratio_win (D.lnsalary_am_kokuji = L1.lnsalary_am_kokuji) D.(ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_time_year ln_all_menseki canlive_ratio_menseki sigaika_ratio_area zaiseiryoku_index cand_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 nendo1 nendo2 nendo3 nendo4 nendo5 nendo6 nendo7 nendo8 nendo9 nendo10 nendo11 nendo12 nendo13 nendo14 nendo15) , cluster(pres_pm_codes) 

outreg2 using myreg_novote_fd.xls, append ctitle(FDIV _cons) keep(D.lnsalary_am_kokuji D.ln_population D.n_seats_adopt D.population_elderly75_ratio D.population_child15_ratio D.ln_income_time_year D.ln_all_menseki D.canlive_ratio_menseki D.sigaika_ratio_area D.zaiseiryoku_index D.cand_ratio_musyozoku_pre D.expired_dummy D.touitsu_2007 D.touitsu_2011 D.touitsu_2015 D.touitsu_2019)

**FDIV lag dep
ivreg D.no_voting_ratio_win (LD.no_voting_ratio_win D.lnsalary_am_kokuji = L2.no_voting_ratio_win L1.lnsalary_am_kokuji) D.(ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_time_year ln_all_menseki canlive_ratio_menseki sigaika_ratio_area zaiseiryoku_index cand_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 nendo1 nendo2 nendo3 nendo4 nendo5 nendo6 nendo7 nendo8 nendo9 nendo10 nendo11 nendo12 nendo13 nendo14 nendo15) , nocons cluster(pres_pm_codes)

outreg2 using myreg_novote_fd.xls, append ctitle(FDIV lag_dep) keep(LD.no_voting_ratio_win D.lnsalary_am_kokuji D.ln_population D.n_seats_adopt D.population_elderly75_ratio D.population_child15_ratio D.ln_income_time_year D.ln_all_menseki D.canlive_ratio_menseki D.sigaika_ratio_area D.zaiseiryoku_index D.cand_ratio_musyozoku_pre D.expired_dummy D.touitsu_2007 D.touitsu_2011 D.touitsu_2015 D.touitsu_2019)

ivreg D.no_voting_ratio_win (LD.no_voting_ratio_win D.lnsalary_am_kokuji = L2.no_voting_ratio_win L1.lnsalary_am_kokuji) D.(ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_time_year ln_all_menseki canlive_ratio_menseki sigaika_ratio_area zaiseiryoku_index cand_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 nendo1 nendo2 nendo3 nendo4 nendo5 nendo6 nendo7 nendo8 nendo9 nendo10 nendo11 nendo12 nendo13 nendo14 nendo15) , cluster(pres_pm_codes)

outreg2 using myreg_novote_fd.xls, append ctitle(FDIV lag_dep _cons) keep(LD.no_voting_ratio_win D.lnsalary_am_kokuji D.ln_population D.n_seats_adopt D.population_elderly75_ratio D.population_child15_ratio D.ln_income_time_year D.ln_all_menseki D.canlive_ratio_menseki D.sigaika_ratio_area D.zaiseiryoku_index D.cand_ratio_musyozoku_pre D.expired_dummy D.touitsu_2007 D.touitsu_2011 D.touitsu_2015 D.touitsu_2019)