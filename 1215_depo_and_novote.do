hist ratio_forfeit_deposit
sum ratio_forfeit_deposit, detail

gen dummy_forfeit_deposit = 0
replace dummy_forfeit_deposit = 1 if ratio_forfeit_deposit > 0
replace dummy_forfeit_deposit = . if ratio_forfeit_deposit == .

sum dummy_forfeit_deposit ratio_forfeit_deposit

reg dummy_forfeit_deposit lnsalary_am_kokuji ln_income_per ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type compe_rate_adopt, vce(cluster pres_pm_codes)


probit dummy_forfeit_deposit lnsalary_am_kokuji ln_income_per ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type compe_rate_adopt, vce(cluster pres_pm_codes)
margins, dydx(lnsalary_am_kokuji ln_income_per ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all compe_rate_adopt)

ivreg2 dummy_forfeit_deposit (lnsalary_am_kokuji = ln_mean_prefbigtype_1yago) ln_income_per ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type compe_rate_adopt, cluster(pres_pm_codes)

ivreg2 dummy_forfeit_deposit (lnsalary_am_kokuji = ln_mean_prefbigtype_1yago) ln_income_per ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type compe_rate_adopt ratio_women_cand_adopt age_mean_cand cand_ratio_musyozoku, cluster(pres_pm_codes)

xtreg dummy_forfeit_deposit lnsalary_am_kokuji ln_income_per ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo compe_rate_adopt, fe vce(cluster pres_pm_codes)

ivreg2 D.dummy_forfeit_deposit (D.lnsalary_am_kokuji = L.ln_mean_prefbigtype_1yago) D.(ln_income_per ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all nendo1-nendo15 compe_rate_adopt), cluster(pres_pm_codes)
**検定はクリア

ivreg2 D.dummy_forfeit_deposit (D.lnsalary_am_kokuji DL.dummy_forfeit_deposit = L1.ln_mean_prefbigtype_1yago L2.dummy_forfeit_deposit) D.(ln_income_per ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all nendo1-nendo15 compe_rate_adopt), cluster(pres_pm_codes)

xtabond2 dummy_forfeit_deposit lnsalary_am_kokuji L1.dummy_forfeit_deposit i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all compe_rate_adopt, gmm(ln_mean_prefbigtype_1yago L.dummy_forfeit_deposit) ivstyle(i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all compe_rate_adopt) noleveleq robust twostep
**検定アカン

xtabond2 dummy_forfeit_deposit lnsalary_am_kokuji i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all compe_rate_adopt, gmm(ln_mean_prefbigtype_1yago) ivstyle(i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all compe_rate_adopt) noleveleq robust twostep
**検定セーフ

xtabond2 dummy_forfeit_deposit lnsalary_am_kokuji L1.dummy_forfeit_deposit i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all compe_rate_adopt, gmm(ln_mean_prefbigtype_1yago L.dummy_forfeit_deposit) ivstyle(i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all compe_rate_adopt) robust twostep
**検定セーフ

xtabond2 dummy_forfeit_deposit lnsalary_am_kokuji i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all compe_rate_adopt, gmm(ln_mean_prefbigtype_1yago) ivstyle(i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all compe_rate_adopt) robust twostep
**検定セーフ


**2sri
drop dep_xu_hat
probit dummy_forfeit_deposit lnsalary_am_kokuji ln_income_per ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type compe_rate_adopt, vce(cluster pres_pm_codes)

reg lnsalary_am_kokuji ln_mean_prefbigtype_1yago ln_income_per ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type compe_rate_adopt if e(sample) == 1, vce(cluster pres_pm_codes)
test ln_mean_prefbigtype_1yago 
predict dep_xu_hat, resid

probit dummy_forfeit_deposit lnsalary_am_kokuji dep_xu_hat ln_income_per ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type compe_rate_adopt, vce(cluster pres_pm_codes)
**有意性なし

** interaction

ivreg2 dummy_forfeit_deposit (lnsalary_am_kokuji c.lnsalary_am_kokuji#c.ln_population = ln_mean_prefbigtype_1yago c.ln_mean_prefbigtype_1yago#c.ln_population) ln_income_per ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type compe_rate_adopt, cluster(pres_pm_codes)
margins, dydx(lnsalary_am_kokuji) at(ln_population  = (5 (1) 15))
margins, dydx(lnsalary_am_kokuji)
return list
ereturn list
matrix list r(b)
di e(N)

**ない


**no voting

hist no_voting_ratio_districts
hist no_voting_ratio_win

reg no_voting_ratio_win lnsalary_am_kokuji ln_income_per ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type, vce(cluster pres_pm_codes)

fracreg probit no_voting_ratio_win lnsalary_am_kokuji ln_income_per ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type, vce(cluster pres_pm_codes)

margins, dydx(lnsalary_am_kokuji)

xtreg no_voting_ratio_win lnsalary_am_kokuji ln_income_per ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo, vce(cluster pres_pm_codes)

xtreg no_voting_ratio_win lnsalary_am_kokuji ln_income_per ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo, vce(cluster pres_pm_codes)

ivreg2 no_voting_ratio_win (lnsalary_am_kokuji = ln_mean_prefbigtype_1yago) ln_income_per ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type, cluster(pres_pm_codes)
**有意性消える

xtabond2 no_voting_ratio_win lnsalary_am_kokuji L1.no_voting_ratio_win i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all, gmm(ln_mean_prefbigtype_1yago L.no_voting_ratio_win) ivstyle(i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all) noleveleq robust twostep

margins, at(lnsalary_am_kokuji = (6.5(0.5)9.5))
**検定セーフ、有意でない

xtabond2 no_voting_ratio_win lnsalary_am_kokuji L1.no_voting_ratio_win i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all, gmm(ln_mean_prefbigtype_1yago L.no_voting_ratio_win) ivstyle(i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all) robust twostep
**検定びみょい

margins, at(lnsalary_am_kokuji = (6.5(0.5)9.5))

xtabond2 no_voting_ratio_win lnsalary_am_kokuji i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all, gmm(ln_mean_prefbigtype_1yago) ivstyle(i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all) noleveleq robust twostep
**検定セーフ

xtabond2 no_voting_ratio_win lnsalary_am_kokuji i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all, gmm(ln_mean_prefbigtype_1yago) ivstyle(i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all) robust twostep
**検定びみょい

** 2sri
fracreg probit no_voting_ratio_win lnsalary_am_kokuji ln_income_per ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type, vce(cluster pres_pm_codes)

reg lnsalary_am_kokuji ln_mean_prefbigtype_1yago ln_income_per ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type if e(sample) == 1, vce(cluster pres_pm_codes)
test ln_mean_prefbigtype_1yago 
predict nv_xu_hat, resid

fracreg probit no_voting_ratio_win lnsalary_am_kokuji nv_xu_hat ln_income_per ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type, vce(cluster pres_pm_codes)
**有意でない

** result; deposit
estimates clear

reg dummy_forfeit_deposit lnsalary_am_kokuji ln_income_per ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type compe_rate_adopt, vce(cluster pres_pm_codes)
estimates store r1, title("OLS")

probit dummy_forfeit_deposit lnsalary_am_kokuji ln_income_per ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type compe_rate_adopt, vce(cluster pres_pm_codes)
eststo r2 :margins, dydx(*) post

ivreg2 dummy_forfeit_deposit (lnsalary_am_kokuji = ln_mean_prefbigtype_1yago) ln_income_per ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type compe_rate_adopt, cluster(pres_pm_codes)
estimates store r3, title("2SLS")

xtabond2 dummy_forfeit_deposit lnsalary_am_kokuji i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all compe_rate_adopt, gmm(ln_mean_prefbigtype_1yago) ivstyle(i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all compe_rate_adopt) noleveleq robust twostep
estimates store r4, title("diff GMM")

xtabond2 dummy_forfeit_deposit lnsalary_am_kokuji i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all compe_rate_adopt, gmm(ln_mean_prefbigtype_1yago) ivstyle(i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all compe_rate_adopt) robust twostep
estimates store r5, title("sys GMM")

esttab r1 r2 r3 r4 r5 using "depo_tab_1219.tex", replace ///
b(3) se(3) star(* 0.10 ** 0.05 *** 0.01) booktabs ///
drop(touitsu_2007 *.nendo _cons *.pref_id *.muni_type) nogaps ///
stats(N, fmt(%9.0f) labels("観測数")) ///
label nolz varwidth(16) modelwidth(13) style(tex)  ///
title(被説明変数: 供託金没収ライン未到達発生) coeflabels(lnsalary_am_kokuji "対数議員報酬額" wom_xu_hat "第1段階残差" ///
ln_population "対数人口" n_seats_adopt "議席数" compe_rate_adopt "1議席あたり立候補人数" ///
population_elderly75_ratio "全人口に占める75歳以上の割合" population_child15_ratio "全人口に占める15歳未満の割合" ln_income_per "納税者1人あたり課税対象所得" ///
ln_all_menseki "対数面積" canlive_ratio_menseki "可住地面積割合" sigaika_ratio_area "市街化区域面積割合" ln_zaiseiryoku ///
"対数財政力指数" win_ratio_musyozoku_pre "前回当選者に占める無所属の割合" ln_staff_all "対数自治体職員数" expired_dummy ///
"任期満了ダミー"  touitsu_2011 "2011年統一選ダミー" touitsu_2015 "2015年統一選ダミー" touitsu_2019 "2019年統一選ダミー" ln_salary_staff_all "対数職員平均給与") ///
mlabels(, span prefix(\multicolumn{@span}{c}{) suffix(})) ///
prehead("\sisetup{table-space-text-post = \sym{***}}""\begin{tabular}{l*{@M}{llll}}""\toprule") posthead(\midrule) prefoot(\midrule) ///
postfoot("\bottomrule""\end{tabular}")

第1段階 F統計量 &                   &                         &         68.551       &                        &                         \\
AR(2)検定 p値 　  &                   &                         &                         &        0.317         &       0.317          \\
Hansen検定 p値　 &                   &                         &                         &        0.251         &       0.648          \\

**result; novote

estimates clear

reg no_voting_ratio_win lnsalary_am_kokuji ln_income_per ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type, vce(cluster pres_pm_codes)
estimates store r1, title("OLS")

fracreg probit no_voting_ratio_win lnsalary_am_kokuji ln_income_per ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type, vce(cluster pres_pm_codes)

eststo r2 :margins, dydx(lnsalary_am_kokuji ln_income_per ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all) post

ivreg2 no_voting_ratio_win (lnsalary_am_kokuji = ln_mean_prefbigtype_1yago) ln_income_per ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type, cluster(pres_pm_codes)
**有意性消える
estimates store r3, title("2SLS")

xtabond2 no_voting_ratio_win lnsalary_am_kokuji L1.no_voting_ratio_win i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all, gmm(ln_mean_prefbigtype_1yago L.no_voting_ratio_win) ivstyle(i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all) noleveleq robust twostep
estimates store r4, title("diff GMM")

esttab r1 r2 r3 r4 using "novote_tab_1219.tex", replace ///
b(3) se(3) star(* 0.10 ** 0.05 *** 0.01) booktabs ///
drop(touitsu_2007 *.nendo _cons *.pref_id *.muni_type) nogaps ///
stats(N, fmt(%9.0f) labels("観測数")) ///
label nolz varwidth(16) modelwidth(13) style(tex)  ///
title(被説明変数: 無投票当選者割合) coeflabels(lnsalary_am_kokuji "対数議員報酬額"  ///
ln_population "対数人口" n_seats_adopt "議席数" L1.no_voting_ratio_win "無投票当選者割合 1期ラグ" ///
population_elderly75_ratio "全人口に占める75歳以上の割合" population_child15_ratio "全人口に占める15歳未満の割合" ln_income_per "納税者1人あたり課税対象所得" ///
ln_all_menseki "対数面積" canlive_ratio_menseki "可住地面積割合" sigaika_ratio_area "市街化区域面積割合" ln_zaiseiryoku ///
"対数財政力指数" win_ratio_musyozoku_pre "前回当選者に占める無所属の割合" ln_staff_all "対数自治体職員数" expired_dummy ///
"任期満了ダミー"  touitsu_2011 "2011年統一選ダミー" touitsu_2015 "2015年統一選ダミー" touitsu_2019 "2019年統一選ダミー" ln_salary_staff_all "対数職員平均給与") ///
mlabels(, span prefix(\multicolumn{@span}{c}{) suffix(})) ///
prehead("\sisetup{table-space-text-post = \sym{***}}""\begin{tabular}{l*{@M}{llll}}""\toprule") posthead(\midrule) prefoot(\midrule) ///
postfoot("\bottomrule""\end{tabular}")

第1段階 F統計量　&                  &                         &         63.500      &                         \\
AR(2)検定 p値　　 &                  &                          &                        &         0.477        \\
Hansen検定 p値   &                  &                          &                        &         0.514       \\


