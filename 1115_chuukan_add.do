** Set as panel data 
tsset pres_pm_codes ele_t


** adjusted_ave_voteshare_inc

**Pooled OLS
reg adjusted_ave_voteshare_inc i.cate_change_salary, vce(cluster pres_pm_codes) 

outreg2 using myreg_inc.xml, replace ctitle(OLS) addtext(Municipality FE, No, Nendo FE, No)

reg adjusted_ave_voteshare_inc i.cate_change_salary ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_time_year ln_all_menseki canlive_ratio_menseki sigaika_ratio_area zaiseiryoku_index cand_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019, vce(cluster pres_pm_codes) 

outreg2 using myreg_inc.xml, append ctitle(OLS) addtext(Municipality FE, No, Nendo FE, No)

**FE
xtreg adjusted_ave_voteshare_inc i.cate_change_salary i.nendo, fe vce(cluster pres_pm_codes) 

outreg2 using myreg_inc.xml, append ctitle(FE) keep(i.cate_change_salary) addtext(Municipality FE, Yes, Nendo FE, Yes)

xtreg adjusted_ave_voteshare_inc i.cate_change_salary ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_time_year ln_all_menseki canlive_ratio_menseki sigaika_ratio_area zaiseiryoku_index cand_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 i.nendo, fe vce(cluster pres_pm_codes) 

outreg2 using myreg_inc.xml, append ctitle(FE) keep(i.cate_change_salary ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_time_year ln_all_menseki canlive_ratio_menseki sigaika_ratio_area zaiseiryoku_index cand_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019) addtext(Municipality FE, Yes, Nendo FE, Yes)

**FE interaction with absolute

xtreg adjusted_ave_voteshare_inc i.cate_change_salary i.cate_change_salary#c.abs_change_salary_am ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_time_year ln_all_menseki canlive_ratio_menseki sigaika_ratio_area zaiseiryoku_index cand_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 i.nendo, fe vce(cluster pres_pm_codes) 

outreg2 using myreg_inc.xml, append ctitle(FE) keep(i.cate_change_salary i.cate_change_salary#c.abs_change_salary_am ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_time_year ln_all_menseki canlive_ratio_menseki sigaika_ratio_area zaiseiryoku_index cand_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019) addtext(Municipality FE, Yes, Nendo FE, Yes)

**FE interaction with ln_population

xtreg adjusted_ave_voteshare_inc i.cate_change_salary i.cate_change_salary#c.ln_population ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_time_year ln_all_menseki canlive_ratio_menseki sigaika_ratio_area zaiseiryoku_index cand_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 i.nendo, fe vce(cluster pres_pm_codes) 

outreg2 using myreg_inc.xml, append ctitle(FE) keep(i.cate_change_salary i.cate_change_salary#c.ln_population ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_time_year ln_all_menseki canlive_ratio_menseki sigaika_ratio_area zaiseiryoku_index cand_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019) addtext(Municipality FE, Yes, Nendo FE, Yes)

xtreg adjusted_ave_voteshare_inc i.cate_change_salary i.cate_change_salary#c.ln_population i.cate_change_salary#c.ln_population#c.ln_population ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_time_year ln_all_menseki canlive_ratio_menseki sigaika_ratio_area zaiseiryoku_index cand_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 i.nendo, fe vce(cluster pres_pm_codes) 

outreg2 using myreg_inc.xml, append ctitle(FE) keep(i.cate_change_salary i.cate_change_salary#c.ln_population i.cate_change_salary#c.ln_population#c.ln_population ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_time_year ln_all_menseki canlive_ratio_menseki sigaika_ratio_area zaiseiryoku_index cand_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019) addtext(Municipality FE, Yes, Nendo FE, Yes)

margins, dydx(i.cate_change_salary) at(ln_population = (5 6 7 8 9 10 11 12 13 14 15))
marginsplot



**no_voting_ratio_win

**Pooled OLS
reg no_voting_ratio_win lnsalary_am_kokuji, vce(cluster pres_pm_codes)

outreg2 using myreg_novote.xml, replace ctitle(OLS) addtext(Municipality FE, No, Nendo FE, No)

reg no_voting_ratio_win lnsalary_am_kokuji ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_time_year ln_all_menseki canlive_ratio_menseki sigaika_ratio_area zaiseiryoku_index cand_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019, vce(cluster pres_pm_codes) 

outreg2 using myreg_novote.xml, append ctitle(OLS)  addtext(Municipality FE, No, Nendo FE, No)

**FE
xtreg no_voting_ratio_win lnsalary_am_kokuji i.nendo, fe vce(cluster pres_pm_codes) 

outreg2 using myreg_novote.xml, append ctitle(FE) keep(lnsalary_am_kokuji) addtext(Municipality FE, Yes, Nendo FE, Yes)

xtreg no_voting_ratio_win lnsalary_am_kokuji ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_time_year ln_all_menseki canlive_ratio_menseki sigaika_ratio_area zaiseiryoku_index cand_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 i.nendo, fe vce(cluster pres_pm_codes) 

outreg2 using myreg_novote.xml, append ctitle(FE) keep(lnsalary_am_kokuji ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_time_year ln_all_menseki canlive_ratio_menseki sigaika_ratio_area zaiseiryoku_index cand_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019) addtext(Municipality FE, Yes, Nendo FE, Yes)

**FD
reg D.no_voting_ratio_win D.lnsalary_am_kokuji, nocons cluster(pres_pm_codes)

outreg2 using myreg_novote_fd.xml, replace ctitle(FD)

reg D.no_voting_ratio_win D.lnsalary_am_kokuji D.(ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_time_year ln_all_menseki canlive_ratio_menseki sigaika_ratio_area zaiseiryoku_index cand_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 nendo1 nendo2 nendo3 nendo4 nendo5 nendo6 nendo7 nendo8 nendo9 nendo10 nendo11 nendo12 nendo13 nendo14 nendo15) , nocons cluster(pres_pm_codes)

outreg2 using myreg_novote_fd.xml, append ctitle(FD) keep(D.lnsalary_am_kokuji D.ln_population D.n_seats_adopt D.population_elderly75_ratio D.population_child15_ratio D.ln_income_time_year D.ln_all_menseki D.canlive_ratio_menseki D.sigaika_ratio_area D.zaiseiryoku_index D.cand_ratio_musyozoku_pre D.expired_dummy D.touitsu_2007 D.touitsu_2011 D.touitsu_2015 D.touitsu_2019)

reg D.no_voting_ratio_win D.lnsalary_am_kokuji D.(ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_time_year ln_all_menseki canlive_ratio_menseki sigaika_ratio_area zaiseiryoku_index cand_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 nendo1 nendo2 nendo3 nendo4 nendo5 nendo6 nendo7 nendo8 nendo9 nendo10 nendo11 nendo12 nendo13 nendo14 nendo15) , cluster(pres_pm_codes)

outreg2 using myreg_novote_fd.xml, append ctitle(FD _cons) keep(D.lnsalary_am_kokuji D.ln_population D.n_seats_adopt D.population_elderly75_ratio D.population_child15_ratio D.ln_income_time_year D.ln_all_menseki D.canlive_ratio_menseki D.sigaika_ratio_area D.zaiseiryoku_index D.cand_ratio_musyozoku_pre D.expired_dummy D.touitsu_2007 D.touitsu_2011 D.touitsu_2015 D.touitsu_2019)

**FDIV
ivreg D.no_voting_ratio_win (D.lnsalary_am_kokuji = L1.lnsalary_am_kokuji) D.(ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_time_year ln_all_menseki canlive_ratio_menseki sigaika_ratio_area zaiseiryoku_index cand_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 nendo1 nendo2 nendo3 nendo4 nendo5 nendo6 nendo7 nendo8 nendo9 nendo10 nendo11 nendo12 nendo13 nendo14 nendo15) , nocons cluster(pres_pm_codes) 

outreg2 using myreg_novote_fd.xml, append ctitle(FDIV) keep(D.lnsalary_am_kokuji D.ln_population D.n_seats_adopt D.population_elderly75_ratio D.population_child15_ratio D.ln_income_time_year D.ln_all_menseki D.canlive_ratio_menseki D.sigaika_ratio_area D.zaiseiryoku_index D.cand_ratio_musyozoku_pre D.expired_dummy D.touitsu_2007 D.touitsu_2011 D.touitsu_2015 D.touitsu_2019)

ivreg D.no_voting_ratio_win (D.lnsalary_am_kokuji = L1.lnsalary_am_kokuji) D.(ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_time_year ln_all_menseki canlive_ratio_menseki sigaika_ratio_area zaiseiryoku_index cand_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 nendo1 nendo2 nendo3 nendo4 nendo5 nendo6 nendo7 nendo8 nendo9 nendo10 nendo11 nendo12 nendo13 nendo14 nendo15) , cluster(pres_pm_codes) 

outreg2 using myreg_novote_fd.xml, append ctitle(FDIV _cons) keep(D.lnsalary_am_kokuji D.ln_population D.n_seats_adopt D.population_elderly75_ratio D.population_child15_ratio D.ln_income_time_year D.ln_all_menseki D.canlive_ratio_menseki D.sigaika_ratio_area D.zaiseiryoku_index D.cand_ratio_musyozoku_pre D.expired_dummy D.touitsu_2007 D.touitsu_2011 D.touitsu_2015 D.touitsu_2019)

**FDIV lag dep
ivreg D.no_voting_ratio_win (LD.no_voting_ratio_win D.lnsalary_am_kokuji = L2.no_voting_ratio_win L1.lnsalary_am_kokuji) D.(ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_time_year ln_all_menseki canlive_ratio_menseki sigaika_ratio_area zaiseiryoku_index cand_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 nendo1 nendo2 nendo3 nendo4 nendo5 nendo6 nendo7 nendo8 nendo9 nendo10 nendo11 nendo12 nendo13 nendo14 nendo15) , nocons cluster(pres_pm_codes)

outreg2 using myreg_novote_fd.xml, append ctitle(FDIV lag_dep) keep(LD.no_voting_ratio_win D.lnsalary_am_kokuji D.ln_population D.n_seats_adopt D.population_elderly75_ratio D.population_child15_ratio D.ln_income_time_year D.ln_all_menseki D.canlive_ratio_menseki D.sigaika_ratio_area D.zaiseiryoku_index D.cand_ratio_musyozoku_pre D.expired_dummy D.touitsu_2007 D.touitsu_2011 D.touitsu_2015 D.touitsu_2019)

ivreg D.no_voting_ratio_win (LD.no_voting_ratio_win D.lnsalary_am_kokuji = L2.no_voting_ratio_win L1.lnsalary_am_kokuji) D.(ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_time_year ln_all_menseki canlive_ratio_menseki sigaika_ratio_area zaiseiryoku_index cand_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 nendo1 nendo2 nendo3 nendo4 nendo5 nendo6 nendo7 nendo8 nendo9 nendo10 nendo11 nendo12 nendo13 nendo14 nendo15) , cluster(pres_pm_codes)

outreg2 using myreg_novote_fd.xml, append ctitle(FDIV lag_dep _cons) keep(LD.no_voting_ratio_win D.lnsalary_am_kokuji D.ln_population D.n_seats_adopt D.population_elderly75_ratio D.population_child15_ratio D.ln_income_time_year D.ln_all_menseki D.canlive_ratio_menseki D.sigaika_ratio_area D.zaiseiryoku_index D.cand_ratio_musyozoku_pre D.expired_dummy D.touitsu_2007 D.touitsu_2011 D.touitsu_2015 D.touitsu_2019)


* ratio_forfeit_deposit

**Pooled OLS
reg  ratio_forfeit_deposit lnsalary_am_kokuji, vce(cluster pres_pm_codes)

outreg2 using myreg_deposit.xml, replace ctitle(OLS) addtext(Municipality FE, No, Nendo FE, No)

reg ratio_forfeit_deposit lnsalary_am_kokuji ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_time_year ln_all_menseki canlive_ratio_menseki sigaika_ratio_area zaiseiryoku_index cand_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019, vce(cluster pres_pm_codes) 

outreg2 using myreg_deposit.xml, append ctitle(OLS)  addtext(Municipality FE, No, Nendo FE, No)

**FE
xtreg ratio_forfeit_deposit lnsalary_am_kokuji i.nendo, fe vce(cluster pres_pm_codes) 

outreg2 using myreg_deposit.xml, append ctitle(FE) keep(lnsalary_am_kokuji) addtext(Municipality FE, Yes, Nendo FE, Yes)

xtreg ratio_forfeit_deposit lnsalary_am_kokuji ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_time_year ln_all_menseki canlive_ratio_menseki sigaika_ratio_area zaiseiryoku_index cand_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 i.nendo, fe vce(cluster pres_pm_codes) 

outreg2 using myreg_deposit.xml, append ctitle(FE) keep(lnsalary_am_kokuji ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_time_year ln_all_menseki canlive_ratio_menseki sigaika_ratio_area zaiseiryoku_index cand_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019) addtext(Municipality FE, Yes, Nendo FE, Yes)

**FD
reg D.ratio_forfeit_deposit D.lnsalary_am_kokuji, nocons cluster(pres_pm_codes)

outreg2 using myreg_deposit_fd.xml, replace ctitle(FD)

reg D.ratio_forfeit_deposit D.lnsalary_am_kokuji D.(ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_time_year ln_all_menseki canlive_ratio_menseki sigaika_ratio_area zaiseiryoku_index cand_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 nendo1 nendo2 nendo3 nendo4 nendo5 nendo6 nendo7 nendo8 nendo9 nendo10 nendo11 nendo12 nendo13 nendo14 nendo15) , nocons cluster(pres_pm_codes)

outreg2 using myreg_deposit_fd.xml, append ctitle(FD) keep(D.lnsalary_am_kokuji D.ln_population D.n_seats_adopt D.population_elderly75_ratio D.population_child15_ratio D.ln_income_time_year D.ln_all_menseki D.canlive_ratio_menseki D.sigaika_ratio_area D.zaiseiryoku_index D.cand_ratio_musyozoku_pre D.expired_dummy D.touitsu_2007 D.touitsu_2011 D.touitsu_2015 D.touitsu_2019)

reg D.ratio_forfeit_deposit D.lnsalary_am_kokuji D.(ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_time_year ln_all_menseki canlive_ratio_menseki sigaika_ratio_area zaiseiryoku_index cand_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 nendo1 nendo2 nendo3 nendo4 nendo5 nendo6 nendo7 nendo8 nendo9 nendo10 nendo11 nendo12 nendo13 nendo14 nendo15) , cluster(pres_pm_codes)

outreg2 using myreg_deposit_fd.xml, append ctitle(FD _cons) keep(D.lnsalary_am_kokuji D.ln_population D.n_seats_adopt D.population_elderly75_ratio D.population_child15_ratio D.ln_income_time_year D.ln_all_menseki D.canlive_ratio_menseki D.sigaika_ratio_area D.zaiseiryoku_index D.cand_ratio_musyozoku_pre D.expired_dummy D.touitsu_2007 D.touitsu_2011 D.touitsu_2015 D.touitsu_2019)

**FDIV
ivreg D.ratio_forfeit_deposit (D.lnsalary_am_kokuji = L1.lnsalary_am_kokuji) D.(ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_time_year ln_all_menseki canlive_ratio_menseki sigaika_ratio_area zaiseiryoku_index cand_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 nendo1 nendo2 nendo3 nendo4 nendo5 nendo6 nendo7 nendo8 nendo9 nendo10 nendo11 nendo12 nendo13 nendo14 nendo15) , nocons cluster(pres_pm_codes) 

outreg2 using myreg_deposit_fd.xml, append ctitle(FDIV) keep(D.lnsalary_am_kokuji D.ln_population D.n_seats_adopt D.population_elderly75_ratio D.population_child15_ratio D.ln_income_time_year D.ln_all_menseki D.canlive_ratio_menseki D.sigaika_ratio_area D.zaiseiryoku_index D.cand_ratio_musyozoku_pre D.expired_dummy D.touitsu_2007 D.touitsu_2011 D.touitsu_2015 D.touitsu_2019)

ivreg D.ratio_forfeit_deposit (D.lnsalary_am_kokuji = L1.lnsalary_am_kokuji) D.(ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_time_year ln_all_menseki canlive_ratio_menseki sigaika_ratio_area zaiseiryoku_index cand_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 nendo1 nendo2 nendo3 nendo4 nendo5 nendo6 nendo7 nendo8 nendo9 nendo10 nendo11 nendo12 nendo13 nendo14 nendo15) , cluster(pres_pm_codes) 

outreg2 using myreg_deposit_fd.xml, append ctitle(FDIV _cons) keep(D.lnsalary_am_kokuji D.ln_population D.n_seats_adopt D.population_elderly75_ratio D.population_child15_ratio D.ln_income_time_year D.ln_all_menseki D.canlive_ratio_menseki D.sigaika_ratio_area D.zaiseiryoku_index D.cand_ratio_musyozoku_pre D.expired_dummy D.touitsu_2007 D.touitsu_2011 D.touitsu_2015 D.touitsu_2019)

**FDIV lag dep
ivreg D.ratio_forfeit_deposit (LD.ratio_forfeit_deposit D.lnsalary_am_kokuji = L2.ratio_forfeit_deposit L1.lnsalary_am_kokuji) D.(ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_time_year ln_all_menseki canlive_ratio_menseki sigaika_ratio_area zaiseiryoku_index cand_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 nendo1 nendo2 nendo3 nendo4 nendo5 nendo6 nendo7 nendo8 nendo9 nendo10 nendo11 nendo12 nendo13 nendo14 nendo15) , nocons cluster(pres_pm_codes)

outreg2 using myreg_deposit_fd.xml, append ctitle(FDIV lag_dep) keep(LD.ratio_forfeit_deposit D.lnsalary_am_kokuji D.ln_population D.n_seats_adopt D.population_elderly75_ratio D.population_child15_ratio D.ln_income_time_year D.ln_all_menseki D.canlive_ratio_menseki D.sigaika_ratio_area D.zaiseiryoku_index D.cand_ratio_musyozoku_pre D.expired_dummy D.touitsu_2007 D.touitsu_2011 D.touitsu_2015 D.touitsu_2019)

ivreg D.ratio_forfeit_deposit (LD.ratio_forfeit_deposit D.lnsalary_am_kokuji = L2.ratio_forfeit_deposit L1.lnsalary_am_kokuji) D.(ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_time_year ln_all_menseki canlive_ratio_menseki sigaika_ratio_area zaiseiryoku_index cand_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 nendo1 nendo2 nendo3 nendo4 nendo5 nendo6 nendo7 nendo8 nendo9 nendo10 nendo11 nendo12 nendo13 nendo14 nendo15) , cluster(pres_pm_codes)

outreg2 using myreg_deposit_fd.xml, append ctitle(FDIV lag_dep _cons) keep(LD.ratio_forfeit_deposit D.lnsalary_am_kokuji D.ln_population D.n_seats_adopt D.population_elderly75_ratio D.population_child15_ratio D.ln_income_time_year D.ln_all_menseki D.canlive_ratio_menseki D.sigaika_ratio_area D.zaiseiryoku_index D.cand_ratio_musyozoku_pre D.expired_dummy D.touitsu_2007 D.touitsu_2011 D.touitsu_2015 D.touitsu_2019)

** first stages

**compe_rate_adopt
*fdiv
reg D.lnsalary_am_kokuji L1.lnsalary_am_kokuji D.(ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_time_year ln_all_menseki canlive_ratio_menseki sigaika_ratio_area zaiseiryoku_index cand_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 nendo1 nendo2 nendo3 nendo4 nendo5 nendo6 nendo7 nendo8 nendo9 nendo10 nendo11 nendo12 nendo13 nendo14 nendo15) , nocons cluster(pres_pm_codes)

test L1.lnsalary_am_kokuji  = 0

** fdiv cons
reg D.lnsalary_am_kokuji L1.lnsalary_am_kokuji D.(ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_time_year ln_all_menseki canlive_ratio_menseki sigaika_ratio_area zaiseiryoku_index cand_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 nendo1 nendo2 nendo3 nendo4 nendo5 nendo6 nendo7 nendo8 nendo9 nendo10 nendo11 nendo12 nendo13 nendo14 nendo15) , cluster(pres_pm_codes) 

test L1.lnsalary_am_kokuji  = 0


** lag
reg LD.compe_rate_adopt L2.compe_rate_adopt L1.lnsalary_am_kokuji D.(ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_time_year ln_all_menseki canlive_ratio_menseki sigaika_ratio_area zaiseiryoku_index cand_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 nendo1 nendo2 nendo3 nendo4 nendo5 nendo6 nendo7 nendo8 nendo9 nendo10 nendo11 nendo12 nendo13 nendo14 nendo15) , nocons cluster(pres_pm_codes)

test (L2.compe_rate_adopt = 0)  (L1.lnsalary_am_kokuji = 0)

reg D.lnsalary_am_kokuji L2.compe_rate_adopt L1.lnsalary_am_kokuji D.(ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_time_year ln_all_menseki canlive_ratio_menseki sigaika_ratio_area zaiseiryoku_index cand_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 nendo1 nendo2 nendo3 nendo4 nendo5 nendo6 nendo7 nendo8 nendo9 nendo10 nendo11 nendo12 nendo13 nendo14 nendo15) , nocons cluster(pres_pm_codes)

test (L2.compe_rate_adopt = 0)  (L1.lnsalary_am_kokuji = 0)

** lag cons
reg LD.compe_rate_adopt L2.compe_rate_adopt L1.lnsalary_am_kokuji D.(ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_time_year ln_all_menseki canlive_ratio_menseki sigaika_ratio_area zaiseiryoku_index cand_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 nendo1 nendo2 nendo3 nendo4 nendo5 nendo6 nendo7 nendo8 nendo9 nendo10 nendo11 nendo12 nendo13 nendo14 nendo15) , cluster(pres_pm_codes)

test (L2.compe_rate_adopt = 0)  (L1.lnsalary_am_kokuji = 0)

reg D.lnsalary_am_kokuji L2.compe_rate_adopt L1.lnsalary_am_kokuji D.(ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_time_year ln_all_menseki canlive_ratio_menseki sigaika_ratio_area zaiseiryoku_index cand_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 nendo1 nendo2 nendo3 nendo4 nendo5 nendo6 nendo7 nendo8 nendo9 nendo10 nendo11 nendo12 nendo13 nendo14 nendo15) ,  cluster(pres_pm_codes)

test (L2.compe_rate_adopt = 0)  (L1.lnsalary_am_kokuji = 0)

**ratio_women_cand_adopt
*fdiv
reg D.lnsalary_am_kokuji L1.lnsalary_am_kokuji D.(ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_time_year ln_all_menseki canlive_ratio_menseki sigaika_ratio_area zaiseiryoku_index cand_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 nendo1 nendo2 nendo3 nendo4 nendo5 nendo6 nendo7 nendo8 nendo9 nendo10 nendo11 nendo12 nendo13 nendo14 nendo15) , nocons cluster(pres_pm_codes)

test L1.lnsalary_am_kokuji  = 0

** fdiv cons
reg D.lnsalary_am_kokuji L1.lnsalary_am_kokuji D.(ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_time_year ln_all_menseki canlive_ratio_menseki sigaika_ratio_area zaiseiryoku_index cand_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 nendo1 nendo2 nendo3 nendo4 nendo5 nendo6 nendo7 nendo8 nendo9 nendo10 nendo11 nendo12 nendo13 nendo14 nendo15) , cluster(pres_pm_codes) 

test L1.lnsalary_am_kokuji  = 0

** lag
reg LD.ratio_women_cand_adopt L2.ratio_women_cand_adopt L1.lnsalary_am_kokuji D.(ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_time_year ln_all_menseki canlive_ratio_menseki sigaika_ratio_area zaiseiryoku_index cand_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 nendo1 nendo2 nendo3 nendo4 nendo5 nendo6 nendo7 nendo8 nendo9 nendo10 nendo11 nendo12 nendo13 nendo14 nendo15) , nocons cluster(pres_pm_codes)

test (L2.ratio_women_cand_adopt = 0)  (L1.lnsalary_am_kokuji = 0)

reg D.lnsalary_am_kokuji L2.ratio_women_cand_adopt L1.lnsalary_am_kokuji D.(ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_time_year ln_all_menseki canlive_ratio_menseki sigaika_ratio_area zaiseiryoku_index cand_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 nendo1 nendo2 nendo3 nendo4 nendo5 nendo6 nendo7 nendo8 nendo9 nendo10 nendo11 nendo12 nendo13 nendo14 nendo15) , nocons cluster(pres_pm_codes)

test (L2.ratio_women_cand_adopt = 0)  (L1.lnsalary_am_kokuji = 0)

** lag cons
reg LD.ratio_women_cand_adopt L2.ratio_women_cand_adopt L1.lnsalary_am_kokuji D.(ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_time_year ln_all_menseki canlive_ratio_menseki sigaika_ratio_area zaiseiryoku_index cand_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 nendo1 nendo2 nendo3 nendo4 nendo5 nendo6 nendo7 nendo8 nendo9 nendo10 nendo11 nendo12 nendo13 nendo14 nendo15) , cluster(pres_pm_codes)

test (L2.ratio_women_cand_adopt = 0)  (L1.lnsalary_am_kokuji = 0)

reg D.lnsalary_am_kokuji L2.ratio_women_cand_adopt L1.lnsalary_am_kokuji D.(ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_time_year ln_all_menseki canlive_ratio_menseki sigaika_ratio_area zaiseiryoku_index cand_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 nendo1 nendo2 nendo3 nendo4 nendo5 nendo6 nendo7 nendo8 nendo9 nendo10 nendo11 nendo12 nendo13 nendo14 nendo15) ,  cluster(pres_pm_codes)

test (L2.ratio_women_cand_adopt = 0)  (L1.lnsalary_am_kokuji = 0)

**age_mean_cand
*fdiv
reg D.lnsalary_am_kokuji L1.lnsalary_am_kokuji D.(ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_time_year ln_all_menseki canlive_ratio_menseki sigaika_ratio_area zaiseiryoku_index cand_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 nendo1 nendo2 nendo3 nendo4 nendo5 nendo6 nendo7 nendo8 nendo9 nendo10 nendo11 nendo12 nendo13 nendo14 nendo15) , nocons cluster(pres_pm_codes)

test L1.lnsalary_am_kokuji  = 0

** fdiv cons
reg D.lnsalary_am_kokuji L1.lnsalary_am_kokuji D.(ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_time_year ln_all_menseki canlive_ratio_menseki sigaika_ratio_area zaiseiryoku_index cand_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 nendo1 nendo2 nendo3 nendo4 nendo5 nendo6 nendo7 nendo8 nendo9 nendo10 nendo11 nendo12 nendo13 nendo14 nendo15) , cluster(pres_pm_codes) 

test L1.lnsalary_am_kokuji  = 0

** lag
reg LD.age_mean_cand L2.age_mean_cand L1.lnsalary_am_kokuji D.(ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_time_year ln_all_menseki canlive_ratio_menseki sigaika_ratio_area zaiseiryoku_index cand_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 nendo1 nendo2 nendo3 nendo4 nendo5 nendo6 nendo7 nendo8 nendo9 nendo10 nendo11 nendo12 nendo13 nendo14 nendo15) , nocons cluster(pres_pm_codes)

test (L2.age_mean_cand = 0)  (L1.lnsalary_am_kokuji = 0)

reg D.lnsalary_am_kokuji L2.age_mean_cand L1.lnsalary_am_kokuji D.(ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_time_year ln_all_menseki canlive_ratio_menseki sigaika_ratio_area zaiseiryoku_index cand_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 nendo1 nendo2 nendo3 nendo4 nendo5 nendo6 nendo7 nendo8 nendo9 nendo10 nendo11 nendo12 nendo13 nendo14 nendo15) , nocons cluster(pres_pm_codes)

test (L2.age_mean_cand = 0)  (L1.lnsalary_am_kokuji = 0)

** lag cons
reg LD.age_mean_cand L2.age_mean_cand L1.lnsalary_am_kokuji D.(ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_time_year ln_all_menseki canlive_ratio_menseki sigaika_ratio_area zaiseiryoku_index cand_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 nendo1 nendo2 nendo3 nendo4 nendo5 nendo6 nendo7 nendo8 nendo9 nendo10 nendo11 nendo12 nendo13 nendo14 nendo15) , cluster(pres_pm_codes)

test (L2.age_mean_cand = 0)  (L1.lnsalary_am_kokuji = 0)

reg D.lnsalary_am_kokuji L2.age_mean_cand L1.lnsalary_am_kokuji D.(ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_time_year ln_all_menseki canlive_ratio_menseki sigaika_ratio_area zaiseiryoku_index cand_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 nendo1 nendo2 nendo3 nendo4 nendo5 nendo6 nendo7 nendo8 nendo9 nendo10 nendo11 nendo12 nendo13 nendo14 nendo15) ,  cluster(pres_pm_codes)

test (L2.age_mean_cand = 0)  (L1.lnsalary_am_kokuji = 0)

**no_voting_ratio_win
*fdiv
reg D.lnsalary_am_kokuji L1.lnsalary_am_kokuji D.(ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_time_year ln_all_menseki canlive_ratio_menseki sigaika_ratio_area zaiseiryoku_index cand_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 nendo1 nendo2 nendo3 nendo4 nendo5 nendo6 nendo7 nendo8 nendo9 nendo10 nendo11 nendo12 nendo13 nendo14 nendo15) , nocons cluster(pres_pm_codes)

test L1.lnsalary_am_kokuji  = 0

** fdiv cons
reg D.lnsalary_am_kokuji L1.lnsalary_am_kokuji D.(ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_time_year ln_all_menseki canlive_ratio_menseki sigaika_ratio_area zaiseiryoku_index cand_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 nendo1 nendo2 nendo3 nendo4 nendo5 nendo6 nendo7 nendo8 nendo9 nendo10 nendo11 nendo12 nendo13 nendo14 nendo15) , cluster(pres_pm_codes) 

test L1.lnsalary_am_kokuji  = 0

** lag
reg LD.no_voting_ratio_win L2.no_voting_ratio_win L1.lnsalary_am_kokuji D.(ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_time_year ln_all_menseki canlive_ratio_menseki sigaika_ratio_area zaiseiryoku_index cand_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 nendo1 nendo2 nendo3 nendo4 nendo5 nendo6 nendo7 nendo8 nendo9 nendo10 nendo11 nendo12 nendo13 nendo14 nendo15) , nocons cluster(pres_pm_codes)

test (L2.no_voting_ratio_win = 0)  (L1.lnsalary_am_kokuji = 0)

reg D.lnsalary_am_kokuji L2.no_voting_ratio_win L1.lnsalary_am_kokuji D.(ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_time_year ln_all_menseki canlive_ratio_menseki sigaika_ratio_area zaiseiryoku_index cand_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 nendo1 nendo2 nendo3 nendo4 nendo5 nendo6 nendo7 nendo8 nendo9 nendo10 nendo11 nendo12 nendo13 nendo14 nendo15) , nocons cluster(pres_pm_codes)

test (L2.no_voting_ratio_win = 0)  (L1.lnsalary_am_kokuji = 0)

** lag cons
reg LD.no_voting_ratio_win L2.no_voting_ratio_win L1.lnsalary_am_kokuji D.(ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_time_year ln_all_menseki canlive_ratio_menseki sigaika_ratio_area zaiseiryoku_index cand_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 nendo1 nendo2 nendo3 nendo4 nendo5 nendo6 nendo7 nendo8 nendo9 nendo10 nendo11 nendo12 nendo13 nendo14 nendo15) , cluster(pres_pm_codes)

test (L2.no_voting_ratio_win = 0)  (L1.lnsalary_am_kokuji = 0)

reg D.lnsalary_am_kokuji L2.no_voting_ratio_win L1.lnsalary_am_kokuji D.(ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_time_year ln_all_menseki canlive_ratio_menseki sigaika_ratio_area zaiseiryoku_index cand_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 nendo1 nendo2 nendo3 nendo4 nendo5 nendo6 nendo7 nendo8 nendo9 nendo10 nendo11 nendo12 nendo13 nendo14 nendo15) ,  cluster(pres_pm_codes)

test (L2.no_voting_ratio_win = 0)  (L1.lnsalary_am_kokuji = 0)


**ratio_forfeit_deposit
*fdiv
reg D.lnsalary_am_kokuji L1.lnsalary_am_kokuji D.(ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_time_year ln_all_menseki canlive_ratio_menseki sigaika_ratio_area zaiseiryoku_index cand_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 nendo1 nendo2 nendo3 nendo4 nendo5 nendo6 nendo7 nendo8 nendo9 nendo10 nendo11 nendo12 nendo13 nendo14 nendo15) , nocons cluster(pres_pm_codes)

test L1.lnsalary_am_kokuji  = 0

** fdiv cons
reg D.lnsalary_am_kokuji L1.lnsalary_am_kokuji D.(ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_time_year ln_all_menseki canlive_ratio_menseki sigaika_ratio_area zaiseiryoku_index cand_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 nendo1 nendo2 nendo3 nendo4 nendo5 nendo6 nendo7 nendo8 nendo9 nendo10 nendo11 nendo12 nendo13 nendo14 nendo15) , cluster(pres_pm_codes) 

test L1.lnsalary_am_kokuji  = 0

** lag
reg LD.ratio_forfeit_deposit L2.ratio_forfeit_deposit L1.lnsalary_am_kokuji D.(ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_time_year ln_all_menseki canlive_ratio_menseki sigaika_ratio_area zaiseiryoku_index cand_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 nendo1 nendo2 nendo3 nendo4 nendo5 nendo6 nendo7 nendo8 nendo9 nendo10 nendo11 nendo12 nendo13 nendo14 nendo15) , nocons cluster(pres_pm_codes)

test (L2.ratio_forfeit_deposit = 0)  (L1.lnsalary_am_kokuji = 0)

reg D.lnsalary_am_kokuji L2.ratio_forfeit_deposit L1.lnsalary_am_kokuji D.(ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_time_year ln_all_menseki canlive_ratio_menseki sigaika_ratio_area zaiseiryoku_index cand_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 nendo1 nendo2 nendo3 nendo4 nendo5 nendo6 nendo7 nendo8 nendo9 nendo10 nendo11 nendo12 nendo13 nendo14 nendo15) , nocons cluster(pres_pm_codes)

test (L2.ratio_forfeit_deposit = 0)  (L1.lnsalary_am_kokuji = 0)

** lag cons
reg LD.ratio_forfeit_deposit L2.ratio_forfeit_deposit L1.lnsalary_am_kokuji D.(ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_time_year ln_all_menseki canlive_ratio_menseki sigaika_ratio_area zaiseiryoku_index cand_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 nendo1 nendo2 nendo3 nendo4 nendo5 nendo6 nendo7 nendo8 nendo9 nendo10 nendo11 nendo12 nendo13 nendo14 nendo15) , cluster(pres_pm_codes)

test (L2.ratio_forfeit_deposit = 0)  (L1.lnsalary_am_kokuji = 0)

reg D.lnsalary_am_kokuji L2.ratio_forfeit_deposit L1.lnsalary_am_kokuji D.(ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_time_year ln_all_menseki canlive_ratio_menseki sigaika_ratio_area zaiseiryoku_index cand_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 nendo1 nendo2 nendo3 nendo4 nendo5 nendo6 nendo7 nendo8 nendo9 nendo10 nendo11 nendo12 nendo13 nendo14 nendo15) ,  cluster(pres_pm_codes)

test (L2.ratio_forfeit_deposit = 0)  (L1.lnsalary_am_kokuji = 0)

** First Stage ("2sls")

**compe_rate_adopt
**FDIV
ivregress 2sls D.compe_rate_adopt (D.lnsalary_am_kokuji = L1.lnsalary_am_kokuji) D.(ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_time_year ln_all_menseki canlive_ratio_menseki sigaika_ratio_area zaiseiryoku_index cand_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 nendo1 nendo2 nendo3 nendo4 nendo5 nendo6 nendo7 nendo8 nendo9 nendo10 nendo11 nendo12 nendo13 nendo14 nendo15) , nocons cluster(pres_pm_codes) 

estat firststage

**FDIV cons
ivregress 2sls D.compe_rate_adopt (D.lnsalary_am_kokuji = L1.lnsalary_am_kokuji) D.(ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_time_year ln_all_menseki canlive_ratio_menseki sigaika_ratio_area zaiseiryoku_index cand_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 nendo1 nendo2 nendo3 nendo4 nendo5 nendo6 nendo7 nendo8 nendo9 nendo10 nendo11 nendo12 nendo13 nendo14 nendo15) , cluster(pres_pm_codes) 

estat firststage

**FDIV lag dep
ivregress 2sls D.compe_rate_adopt (LD.compe_rate_adopt D.lnsalary_am_kokuji = L2.compe_rate_adopt L1.lnsalary_am_kokuji) D.(ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_time_year ln_all_menseki canlive_ratio_menseki sigaika_ratio_area zaiseiryoku_index cand_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 nendo1 nendo2 nendo3 nendo4 nendo5 nendo6 nendo7 nendo8 nendo9 nendo10 nendo11 nendo12 nendo13 nendo14 nendo15) , nocons cluster(pres_pm_codes)

estat firststage

**FDIV lag dep cons
ivregress 2sls D.compe_rate_adopt (LD.compe_rate_adopt D.lnsalary_am_kokuji = L2.compe_rate_adopt L1.lnsalary_am_kokuji) D.(ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_time_year ln_all_menseki canlive_ratio_menseki sigaika_ratio_area zaiseiryoku_index cand_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 nendo1 nendo2 nendo3 nendo4 nendo5 nendo6 nendo7 nendo8 nendo9 nendo10 nendo11 nendo12 nendo13 nendo14 nendo15) , cluster(pres_pm_codes) 

estat firststage

**ratio_women_cand_adopt
**FDIV
ivregress 2sls D.ratio_women_cand_adopt (D.lnsalary_am_kokuji = L1.lnsalary_am_kokuji) D.(ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_time_year ln_all_menseki canlive_ratio_menseki sigaika_ratio_area zaiseiryoku_index cand_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 nendo1 nendo2 nendo3 nendo4 nendo5 nendo6 nendo7 nendo8 nendo9 nendo10 nendo11 nendo12 nendo13 nendo14 nendo15) , nocons cluster(pres_pm_codes) 

estat firststage

**FDIV cons
ivregress 2sls D.ratio_women_cand_adopt (D.lnsalary_am_kokuji = L1.lnsalary_am_kokuji) D.(ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_time_year ln_all_menseki canlive_ratio_menseki sigaika_ratio_area zaiseiryoku_index cand_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 nendo1 nendo2 nendo3 nendo4 nendo5 nendo6 nendo7 nendo8 nendo9 nendo10 nendo11 nendo12 nendo13 nendo14 nendo15) , cluster(pres_pm_codes) 

estat firststage

**FDIV lag dep
ivregress 2sls D.ratio_women_cand_adopt (LD.ratio_women_cand_adopt D.lnsalary_am_kokuji = L2.ratio_women_cand_adopt L1.lnsalary_am_kokuji) D.(ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_time_year ln_all_menseki canlive_ratio_menseki sigaika_ratio_area zaiseiryoku_index cand_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 nendo1 nendo2 nendo3 nendo4 nendo5 nendo6 nendo7 nendo8 nendo9 nendo10 nendo11 nendo12 nendo13 nendo14 nendo15) , nocons cluster(pres_pm_codes)

estat firststage

**FDIV lag dep cons
ivregress 2sls D.ratio_women_cand_adopt (LD.ratio_women_cand_adopt D.lnsalary_am_kokuji = L2.ratio_women_cand_adopt L1.lnsalary_am_kokuji) D.(ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_time_year ln_all_menseki canlive_ratio_menseki sigaika_ratio_area zaiseiryoku_index cand_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 nendo1 nendo2 nendo3 nendo4 nendo5 nendo6 nendo7 nendo8 nendo9 nendo10 nendo11 nendo12 nendo13 nendo14 nendo15) , cluster(pres_pm_codes)

estat firststage

**age_mean_cand
**FDIV
ivregress 2sls D.age_mean_cand (D.lnsalary_am_kokuji = L1.lnsalary_am_kokuji) D.(ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_time_year ln_all_menseki canlive_ratio_menseki sigaika_ratio_area zaiseiryoku_index cand_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 nendo1 nendo2 nendo3 nendo4 nendo5 nendo6 nendo7 nendo8 nendo9 nendo10 nendo11 nendo12 nendo13 nendo14 nendo15) , nocons cluster(pres_pm_codes)

estat firststage

**FDIV cons
ivregress 2sls D.age_mean_cand (D.lnsalary_am_kokuji = L1.lnsalary_am_kokuji) D.(ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_time_year ln_all_menseki canlive_ratio_menseki sigaika_ratio_area zaiseiryoku_index cand_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 nendo1 nendo2 nendo3 nendo4 nendo5 nendo6 nendo7 nendo8 nendo9 nendo10 nendo11 nendo12 nendo13 nendo14 nendo15) , cluster(pres_pm_codes) 

estat firststage

**FDIV lag dep
ivregress 2sls D.age_mean_cand (LD.age_mean_cand D.lnsalary_am_kokuji = L2.age_mean_cand L1.lnsalary_am_kokuji) D.(ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_time_year ln_all_menseki canlive_ratio_menseki sigaika_ratio_area zaiseiryoku_index cand_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 nendo1 nendo2 nendo3 nendo4 nendo5 nendo6 nendo7 nendo8 nendo9 nendo10 nendo11 nendo12 nendo13 nendo14 nendo15) , nocons cluster(pres_pm_codes) 

estat firststage

**FDIV lag dep cons
ivregress 2sls D.age_mean_cand (LD.age_mean_cand D.lnsalary_am_kokuji = L2.age_mean_cand L1.lnsalary_am_kokuji) D.(ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_time_year ln_all_menseki canlive_ratio_menseki sigaika_ratio_area zaiseiryoku_index cand_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 nendo1 nendo2 nendo3 nendo4 nendo5 nendo6 nendo7 nendo8 nendo9 nendo10 nendo11 nendo12 nendo13 nendo14 nendo15) , cluster(pres_pm_codes) 

estat firststage

**no_voting_ratio_win
**FDIV
ivregress 2sls D.no_voting_ratio_win (D.lnsalary_am_kokuji = L1.lnsalary_am_kokuji) D.(ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_time_year ln_all_menseki canlive_ratio_menseki sigaika_ratio_area zaiseiryoku_index cand_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 nendo1 nendo2 nendo3 nendo4 nendo5 nendo6 nendo7 nendo8 nendo9 nendo10 nendo11 nendo12 nendo13 nendo14 nendo15) , nocons cluster(pres_pm_codes) 

estat firststage

**FDIV cons
ivregress 2sls D.no_voting_ratio_win (D.lnsalary_am_kokuji = L1.lnsalary_am_kokuji) D.(ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_time_year ln_all_menseki canlive_ratio_menseki sigaika_ratio_area zaiseiryoku_index cand_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 nendo1 nendo2 nendo3 nendo4 nendo5 nendo6 nendo7 nendo8 nendo9 nendo10 nendo11 nendo12 nendo13 nendo14 nendo15) , cluster(pres_pm_codes) 

estat firststage

**FDIV lag dep
ivregress 2sls D.no_voting_ratio_win (LD.no_voting_ratio_win D.lnsalary_am_kokuji = L2.no_voting_ratio_win L1.lnsalary_am_kokuji) D.(ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_time_year ln_all_menseki canlive_ratio_menseki sigaika_ratio_area zaiseiryoku_index cand_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 nendo1 nendo2 nendo3 nendo4 nendo5 nendo6 nendo7 nendo8 nendo9 nendo10 nendo11 nendo12 nendo13 nendo14 nendo15) , nocons cluster(pres_pm_codes) 

estat firststage

**FDIV lag dep cons
ivregress 2sls D.no_voting_ratio_win (LD.no_voting_ratio_win D.lnsalary_am_kokuji = L2.no_voting_ratio_win L1.lnsalary_am_kokuji) D.(ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_time_year ln_all_menseki canlive_ratio_menseki sigaika_ratio_area zaiseiryoku_index cand_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 nendo1 nendo2 nendo3 nendo4 nendo5 nendo6 nendo7 nendo8 nendo9 nendo10 nendo11 nendo12 nendo13 nendo14 nendo15) , cluster(pres_pm_codes)

estat firststage

**ratio_forfeit_deposit
**FDIV
ivregress 2sls D.ratio_forfeit_deposit (D.lnsalary_am_kokuji = L1.lnsalary_am_kokuji) D.(ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_time_year ln_all_menseki canlive_ratio_menseki sigaika_ratio_area zaiseiryoku_index cand_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 nendo1 nendo2 nendo3 nendo4 nendo5 nendo6 nendo7 nendo8 nendo9 nendo10 nendo11 nendo12 nendo13 nendo14 nendo15) , nocons cluster(pres_pm_codes) 

estat firststage

**FDIV cons
ivregress 2sls D.ratio_forfeit_deposit (D.lnsalary_am_kokuji = L1.lnsalary_am_kokuji) D.(ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_time_year ln_all_menseki canlive_ratio_menseki sigaika_ratio_area zaiseiryoku_index cand_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 nendo1 nendo2 nendo3 nendo4 nendo5 nendo6 nendo7 nendo8 nendo9 nendo10 nendo11 nendo12 nendo13 nendo14 nendo15) , cluster(pres_pm_codes) 

estat firststage

**FDIV lag dep
ivregress 2sls D.ratio_forfeit_deposit (LD.ratio_forfeit_deposit D.lnsalary_am_kokuji = L2.ratio_forfeit_deposit L1.lnsalary_am_kokuji) D.(ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_time_year ln_all_menseki canlive_ratio_menseki sigaika_ratio_area zaiseiryoku_index cand_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 nendo1 nendo2 nendo3 nendo4 nendo5 nendo6 nendo7 nendo8 nendo9 nendo10 nendo11 nendo12 nendo13 nendo14 nendo15) , nocons cluster(pres_pm_codes) 

estat firststage

**FDIV lag dep cons
ivregress 2sls D.ratio_forfeit_deposit (LD.ratio_forfeit_deposit D.lnsalary_am_kokuji = L2.ratio_forfeit_deposit L1.lnsalary_am_kokuji) D.(ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_time_year ln_all_menseki canlive_ratio_menseki sigaika_ratio_area zaiseiryoku_index cand_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 nendo1 nendo2 nendo3 nendo4 nendo5 nendo6 nendo7 nendo8 nendo9 nendo10 nendo11 nendo12 nendo13 nendo14 nendo15) , cluster(pres_pm_codes) 

estat firststage






 
