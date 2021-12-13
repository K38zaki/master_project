xtset pres_pm_codes ele_t

sum compe_rate_adopt lnsalary_am_kokuji ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area zaiseiryoku_index win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all


**women_ratio_cand

gen women_cand_happen = .
replace women_cand_happen = 1 if ratio_women_cand_adopt > 0
replace women_cand_happen = 0 if ratio_women_cand_adopt == 0
replace women_cand_happen = . if ratio_women_cand_adopt == .

sum women_cand_happen ratio_women_cand_adopt

fracreg logit ratio_women_cand_adopt lnsalary_am_kokuji, vce(cluster pres_pm_codes)

fracreg logit ratio_women_cand_adopt lnsalary_am_kokuji ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all, vce(cluster pres_pm_codes)

fracreg logit ratio_women_cand_adopt lnsalary_am_kokuji ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all i.nendo i.pres_pm_codes, vce(cluster pres_pm_codes)

** woman gmm

xtabond2 ratio_women_cand_adopt lnsalary_am_kokuji i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all, gmm(lnsalary_am_kokuji,laglimits(1 2)) ivstyle(i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all) noleveleq robust twostep

xtabond2 ratio_women_cand_adopt lnsalary_am_kokuji i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all, gmm(lnsalary_am_kokuji) ivstyle(i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all) noleveleq robust twostep

xtabond2 ratio_women_cand_adopt lnsalary_am_kokuji i.nendo ln_population n_seats_adopt population_elderly75_ratio population_woman_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all, gmm(lnsalary_am_kokuji) ivstyle(i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all) noleveleq robust twostep

xtabond2 ratio_women_cand_adopt lnsalary_am_kokuji L1.ratio_women_cand i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all, gmm(lnsalary_am_kokuji L.ratio_women_cand_adopt,laglimits(1 2)) ivstyle(i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all) noleveleq robust twostep

xtabond2 ratio_women_cand_adopt lnsalary_am_kokuji L1.ratio_women_cand i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all, gmm(lnsalary_am_kokuji L.ratio_women_cand_adopt) ivstyle(i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all) noleveleq robust twostep

xtabond2 ratio_women_cand_adopt lnsalary_am_kokuji L1.ratio_women_cand i.nendo ln_population n_seats_adopt population_woman_ratio population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all, gmm(lnsalary_am_kokuji L.ratio_women_cand_adopt) ivstyle(i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all) noleveleq robust twostep

xtabond2 ratio_women_cand_adopt ln_diff_salary i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all, gmm(ln_diff_salary) ivstyle(i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all) noleveleq robust twostep

xtabond2 ratio_women_cand_adopt ln_diff_salary L1.ratio_women_cand i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all, gmm(ln_diff_salary L.ratio_women_cand_adopt) ivstyle(i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all) noleveleq robust twostep

xtabond2 ratio_women_cand_adopt ln_diff_salary L1.ratio_women_cand i.nendo ln_population n_seats_adopt population_woman_ratio population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all, gmm(ln_diff_salary L.ratio_women_cand_adopt) ivstyle(i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all) noleveleq robust twostep

xtabond2 ratio_women_cand_adopt lnsalary_am_kokuji i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all, gmm(lnsalary_am_kokuji) ivstyle(i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all) robust twostep

xtabond2 ratio_women_cand_adopt ln_diff_salary i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all, gmm(ln_diff_salary) ivstyle(i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all)  robust twostep

xtabond2 ratio_women_cand_adopt ln_diff_salary i.nendo ln_population n_seats_adopt population_woman_ratio population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all, gmm(ln_diff_salary) ivstyle(i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all)  robust twostep




xtabond2 ratio_women_cand_adopt ln_diff_salary L1.ratio_women_cand i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all, gmm(ln_diff_salary L.ratio_women_cand_adopt) ivstyle(i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all) robust twostep

xtabond2 ratio_women_cand_adopt lnsalary_am_kokuji L1.ratio_women_cand i.nendo ln_population n_seats_adopt population_woman_ratio population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all, gmm(lnsalary_am_kokuji L.ratio_women_cand_adopt) ivstyle(i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all) robust twostep

** squared

xtset pres_pm_codes ele_t

xtabond2 ratio_women_cand_adopt c.lnsalary_am_kokuji##c.lnsalary_am_kokuji i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all, gmm(lnsalary_am_kokuji c.lnsalary_am_kokuji#c.lnsalary_am_kokuji) ivstyle(i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all) noleveleq robust twostep
margins, dydx(lnsalary_am_kokuji) at(lnsalary_am_kokuji = (6.5 7 7.5 8 8.5 9))
marginsplot

xtabond2 ratio_women_cand_adopt c.lnsalary_am_kokuji##c.lnsalary_am_kokuji L1.ratio_women_cand_adopt i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all, gmm(lnsalary_am_kokuji c.lnsalary_am_kokuji#c.lnsalary_am_kokuji L.ratio_women_cand_adopt) ivstyle(i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all) noleveleq robust twostep
margins, dydx(lnsalary_am_kokuji) at(lnsalary_am_kokuji = (6.5 7 7.5 8 8.5 9))
marginsplot

xtabond2 ratio_women_cand_adopt c.ln_diff_salary##c.ln_diff_salary i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all, gmm(ln_diff_salary c.ln_diff_salary#c.ln_diff_salary) ivstyle(i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all) noleveleq robust twostep
margins, dydx(ln_diff_salary) at(ln_diff_salary = (0.5 1 1.5 2 2.5 3 3.5))

xtabond2 ratio_women_cand_adopt c.ln_diff_salary##c.ln_diff_salary L1.ratio_women_cand_adopt i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all, gmm(ln_diff_salary c.ln_diff_salary#c.ln_diff_salary L.ratio_women_cand_adopt) ivstyle(i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all) noleveleq robust twostep
margins, dydx(ln_diff_salary) at(ln_diff_salary = (0.5 1 1.5 2 2.5 3 3.5))

xtabond2 ratio_women_cand_adopt c.lnsalary_am_kokuji##c.lnsalary_am_kokuji L1.ratio_women_cand_adopt i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all, gmm(lnsalary_am_kokuji c.lnsalary_am_kokuji#c.lnsalary_am_kokuji L.ratio_women_cand_adopt) ivstyle(i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all) robust twostep
margins, dydx(lnsalary_am_kokuji) at(lnsalary_am_kokuji = (6.5 7 7.5 8 8.5 9))
marginsplot

*全体的にない



**women_ratio two_part part 1

estimates clear

xtreg ratio_women_cand_adopt lnsalary_am_kokuji i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku ln_staff_all win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 if ratio_women_cand_adopt > 0, fe vce(cluster pres_pm_codes)
estimates store r1, title("FE")
estadd local municipality "Yes": r1
estadd local year "Yes": r1

xtreg ratio_women_cand_adopt ln_diff_salary i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku ln_staff_all win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 if ratio_women_cand_adopt > 0, fe vce(cluster pres_pm_codes)
estimates store r2, title("FE")
estadd local municipality "Yes": r2
estadd local year "Yes": r2

xtabond2 ratio_women_cand_adopt lnsalary_am_kokuji i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku ln_staff_all win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 if ratio_women_cand_adopt > 0, gmm(lnsalary_am_kokuji) ivstyle(i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all) noleveleq robust twostep
estimates store r3, title("diff GMM")
estadd local municipality "Yes": r3
estadd local year "Yes": r3

xtabond2 ratio_women_cand_adopt lnsalary_am_kokuji L1.ratio_women_cand i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku ln_staff_all win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 if ratio_women_cand_adopt > 0, gmm(lnsalary_am_kokuji L.ratio_women_cand_adopt) ivstyle(i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all) noleveleq robust twostep
estimates store r4, title("diff GMM")
estadd local municipality "Yes": r4
estadd local year "Yes": r4

xtabond2 ratio_women_cand_adopt ln_diff_salary i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku ln_staff_all win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 if ratio_women_cand_adopt > 0, gmm(ln_diff_salary) ivstyle(i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all) noleveleq robust twostep
estimates store r5, title("diff GMM")
estadd local municipality "Yes": r5
estadd local year "Yes": r5

xtabond2 ratio_women_cand_adopt ln_diff_salary L1.ratio_women_cand i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku ln_staff_all expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 if ratio_women_cand_adopt > 0, gmm(ln_diff_salary L.ratio_women_cand_adopt) ivstyle(i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all) noleveleq robust twostep
estimates store r6, title("diff GMM")
estadd local municipality "Yes": r6
estadd local year "Yes": r6

esttab r1 r2 r3 r4 r5 r6 using "woman_ex0.tex", replace ///
b(3) se(3) star(* 0.10 ** 0.05 *** 0.01) booktabs ///
drop(*.nendo _cons) nogaps ///
stats(year municipality N, fmt(%9.0f %9.0f %9.3f %9.0f) labels("年度固定効果" "自治体固定効果" "観測数")) ///
label nolz varwidth(16) modelwidth(13) style(tex)  ///
title(被説明変数: 立候補者女性割合(0を除外)) coeflabels(lnsalary_am_kokuji "対数議員報酬額" ln_diff_salary "報酬額対数差分" L.ratio_women_cand ///
"立候補者女性割合_1期ラグ" ln_population "対数人口" n_seats_adopt "議席数" ///
population_elderly75_ratio "全人口に占める75歳以上の割合" population_child15_ratio "全人口に占める15歳未満の割合" ln_income_per "納税者1人あたり課税対象所得" ///
ln_all_menseki "対数面積" canlive_ratio_menseki "可住地面積割合" sigaika_ratio_area "市街化区域面積割合" ln_zaiseiryoku ///
"対数財政力指数" win_ratio_musyozoku_pre "前回当選者に占める無所属の割合" ln_staff_all "対数自治体職員数" expired_dummy ///
"任期満了ダミー" touitsu_2011 "2011年統一選ダミー" touitsu_2015 "2015年統一選ダミー" touitsu_2019 "2019年統一選ダミー") ///
order(lnsalary_am_kokuji ln_diff_salary L1.ratio_women_cand) ///
mlabels(, span prefix(\multicolumn{@span}{c}{) suffix(})) ///
prehead("\documentclass[10pt]{jsarticle}" "\pagestyle{empty}" "\usepackage{booktabs}""\usepackage{siunitx}""\usepackage{lscape}" ///
"\usepackage[margin=20truemm]{geometry}""\sisetup{input-symbols = ()}""\begin{document}""\begin{table}\caption{@title}" ///
"\def\sym#1{\ifmmode^{#1}\else\(^{#1}\)\fi}""\begin{center}" ///
"\sisetup{table-space-text-post = \sym{***}}""\begin{tabular}{l*{@M}{llll}}""\toprule") posthead(\midrule) prefoot(\midrule) ///
postfoot("\bottomrule""\end{tabular}""\end{center}""\end{table}""\end{document}")

**women_ratio two_part part 2

probit women_cand_happen lnsalary_am_kokuji, vce(cluster pres_pm_codes)

probit women_cand_happen lnsalary_am_kokuji i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku ln_staff_all win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019, vce(cluster pres_pm_codes)

probit women_cand_happen lnsalary_am_kokuji ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku ln_staff_all win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 i.pref_id i.muni_type i.nendo, vce(cluster pres_pm_codes) nolog 

margins, dydx(lnsalary_am_kokuji)

estimates clear

xtreg women_cand_happen lnsalary_am_kokuji i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku ln_staff_all win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019, fe vce(cluster pres_pm_codes)
estimates store r1, title("FE")
estadd local municipality "Yes": r1
estadd local year "Yes": r1

xtreg women_cand_happen ln_diff_salary i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku ln_staff_all win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019, fe vce(cluster pres_pm_codes)
estimates store r2, title("FE")
estadd local municipality "Yes": r2
estadd local year "Yes": r2

xtabond2 women_cand_happen lnsalary_am_kokuji i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku ln_staff_all win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019, gmm(lnsalary_am_kokuji) ivstyle(i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all) noleveleq robust twostep
estimates store r3, title("diff GMM")
estadd local municipality "Yes": r3
estadd local year "Yes": r3

xtabond2 women_cand_happen lnsalary_am_kokuji L1.women_cand_happen i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku ln_staff_all win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019, gmm(lnsalary_am_kokuji L.women_cand_happen) ivstyle(i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all) noleveleq robust twostep
estimates store r4, title("diff GMM")
estadd local municipality "Yes": r4
estadd local year "Yes": r4

xtabond2 women_cand_happen ln_diff_salary i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku ln_staff_all win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 , gmm(ln_diff_salary) ivstyle(i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all) noleveleq robust twostep
estimates store r5, title("diff GMM")
estadd local municipality "Yes": r5
estadd local year "Yes": r5

xtabond2 women_cand_happen ln_diff_salary i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku ln_staff_all win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 , gmm(ln_diff_salary,laglimits(1 2)) ivstyle(i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all) noleveleq robust twostep

xtabond2 women_cand_happen ln_diff_salary L1.women_cand_happen i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku ln_staff_all win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019, gmm(ln_diff_salary L.women_cand_happen) ivstyle(i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all) noleveleq robust twostep
estimates store r6, title("diff GMM")
estadd local municipality "Yes": r6
estadd local year "Yes": r6

xtabond2 women_cand_happen ln_diff_salary L1.women_cand_happen i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku ln_staff_all win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019, gmm(ln_diff_salary L.women_cand_happen,laglimits(1 2)) ivstyle(i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all) noleveleq robust twostep

esttab r1 r2 r3 r4 r5 r6 using "woman_0to1.tex", replace ///
b(3) se(3) star(* 0.10 ** 0.05 *** 0.01) booktabs ///
drop(touitsu_2007 *.nendo _cons) nogaps ///
stats(year municipality N, fmt(%9.0f %9.0f %9.0f) labels("年度固定効果" "自治体固定効果" "観測数")) ///
label nolz varwidth(16) modelwidth(13) style(tex)  ///
title(被説明変数: 女性立候補者ありダミー) coeflabels(lnsalary_am_kokuji "対数議員報酬額" ln_diff_salary "報酬額対数差分" L.women_cand_happen ///
"女性立候補者ありダミー_1期ラグ" ln_population "対数人口" n_seats_adopt "議席数" ///
population_elderly75_ratio "全人口に占める75歳以上の割合" population_child15_ratio "全人口に占める15歳未満の割合" ln_income_per "納税者1人あたり課税対象所得" ///
ln_all_menseki "対数面積" canlive_ratio_menseki "可住地面積割合" sigaika_ratio_area "市街化区域面積割合" ln_zaiseiryoku ///
"対数財政力指数" win_ratio_musyozoku_pre "前回当選者に占める無所属の割合" ln_staff_all "対数自治体職員数" expired_dummy ///
"任期満了ダミー" touitsu_2011 "2011年統一選ダミー" touitsu_2015 "2015年統一選ダミー" touitsu_2019 "2019年統一選ダミー") ///
order(lnsalary_am_kokuji ln_diff_salary L.women_cand_happen) ///
mlabels(, span prefix(\multicolumn{@span}{c}{) suffix(})) ///
prehead("\documentclass[10pt]{jsarticle}" "\pagestyle{empty}" "\usepackage{booktabs}""\usepackage{siunitx}""\usepackage{lscape}" ///
"\usepackage[margin=20truemm]{geometry}""\sisetup{input-symbols = ()}""\begin{document}""\begin{table}\caption{@title}" ///
"\def\sym#1{\ifmmode^{#1}\else\(^{#1}\)\fi}""\begin{center}" ///
"\sisetup{table-space-text-post = \sym{***}}""\begin{tabular}{l*{@M}{llll}}""\toprule") posthead(\midrule) prefoot(\midrule) ///
postfoot("\bottomrule""\end{tabular}""\end{center}""\end{table}""\end{document}")

**age_mean_cand

reg age_mean_cand lnsalary_am_kokuji, vce(cluster pres_pm_codes)
estimates store r1, title("OLS")
estadd local municipality "No": r1
estadd local year "No": r1

reg age_mean_cand lnsalary_am_kokuji ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area zaiseiryoku_index ln_staff_all win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019, vce(cluster pres_pm_codes)
estimates store r2, title("OLS")
estadd local municipality "No": r2
estadd local year "No": r2

xtreg age_mean_cand lnsalary_am_kokuji, fe vce(cluster pres_pm_codes)
estimates store r3, title("FE")
estadd local municipality "Yes": r3
estadd local year "No": r3

xtreg age_mean_cand lnsalary_am_kokuji i.nendo, fe vce(cluster pres_pm_codes)
estimates store r4, title("FE")
estadd local municipality "Yes": r4
estadd local year "Yes": r4

xtreg age_mean_cand lnsalary_am_kokuji ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area zaiseiryoku_index ln_staff_all win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 i.nendo, fe vce(cluster pres_pm_codes)
estimates store r5, title("FE")
estadd local municipality "Yes": r5
estadd local year "Yes": r5

esttab r1 r2 r3 r4 r5 using "age_fe.tex", replace ///
b(3) se(3) star(* 0.10 ** 0.05 *** 0.01) booktabs ///
drop(touitsu_2007 *.nendo _cons) nogaps ///
stats(year municipality N, fmt(%9.0f %9.0f %9.0f) labels("年度固定効果" "自治体固定効果" "観測数")) ///
label nolz varwidth(16) modelwidth(13) style(tex)  ///
title(被説明変数: 立候補者平均年齢) coeflabels(lnsalary_am_kokuji "対数議員報酬額" ///
ln_population "対数人口" n_seats_adopt "議席数" ///
population_elderly75_ratio "全人口に占める75歳以上の割合" population_child15_ratio "全人口に占める15歳未満の割合" ln_income_per "納税者1人あたり課税対象所得" ///
ln_all_menseki "対数面積" canlive_ratio_menseki "可住地面積割合" sigaika_ratio_area "市街化区域面積割合" ln_zaiseiryoku ///
"対数財政力指数" win_ratio_musyozoku_pre "前回当選者に占める無所属の割合" ln_staff_all "対数自治体職員数" expired_dummy ///
"任期満了ダミー" touitsu_2011 "2011年統一選ダミー" touitsu_2015 "2015年統一選ダミー" touitsu_2019 "2019年統一選ダミー") ///
order(lnsalary_am_kokuji) ///
mlabels(, span prefix(\multicolumn{@span}{c}{) suffix(})) ///
prehead("\documentclass[10pt]{jsarticle}" "\pagestyle{empty}" "\usepackage{booktabs}""\usepackage{siunitx}""\usepackage{lscape}" ///
"\usepackage[margin=20truemm]{geometry}""\sisetup{input-symbols = ()}""\begin{document}""\begin{table}\caption{@title}" ///
"\def\sym#1{\ifmmode^{#1}\else\(^{#1}\)\fi}""\begin{center}" ///
"\sisetup{table-space-text-post = \sym{***}}""\begin{tabular}{l*{@M}{llll}}""\toprule") posthead(\midrule) prefoot(\midrule) ///
postfoot("\bottomrule""\end{tabular}""\end{center}""\end{table}""\end{document}")

* diff GMM
estimates clear

xtabond2 age_mean_cand lnsalary_am_kokuji i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku ln_staff_all win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019, gmm(lnsalary_am_kokuji) ivstyle(i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all) noleveleq robust twostep
*プラス有意;検定アカン

xtabond2 age_mean_cand lnsalary_am_kokuji i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku ln_staff_all win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019, gmm(lnsalary_am_kokuji, laglimits(1 2)) ivstyle(i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all) noleveleq robust twostep
*プラス有意;検定アカン

xtabond2 age_mean_cand ln_diff_salary i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku ln_staff_all win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019, gmm(ln_diff_salary) ivstyle(i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all) noleveleq robust twostep
*プラス有意;検定アカン

xtabond2 age_mean_cand ln_diff_salary i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku ln_staff_all win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019, gmm(ln_diff_salary, laglimits(1 2)) ivstyle(i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all) noleveleq robust twostep
*プラス有意; セーフ

xtabond2 age_mean_cand lnsalary_am_kokuji L1.age_mean_cand i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku ln_staff_all win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019, gmm(lnsalary_am_kokuji L.age_mean_cand) ivstyle(i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all) noleveleq robust twostep
*点推定プラス
estimates store r1, title("diff GMM")
estadd local municipality "Yes": r1
estadd local year "Yes": r1

xtabond2 age_mean_cand ln_diff_salary L1.age_mean_cand i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku ln_staff_all win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019, gmm(ln_diff_salary L.age_mean_cand) ivstyle(i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all) noleveleq robust twostep
*点推定プラス; なさそう
estimates store r2, title("diff GMM")
estadd local municipality "Yes": r2
estadd local year "Yes": r2

** squared
xtabond2 age_mean_cand c.lnsalary_am_kokuji##c.lnsalary_am_kokuji L1.age_mean_cand i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku ln_staff_all win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019, gmm(lnsalary_am_kokuji c.lnsalary_am_kokuji#c.lnsalary_am_kokuji L.age_mean_cand) ivstyle(i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all) noleveleq robust twostep
margins, dydx(lnsalary_am_kokuji) at(lnsalary_am_kokuji = (6.5 7 7.5 8 8.5 9))

xtabond2 age_mean_cand c.ln_diff_salary##c.ln_diff_salary L1.age_mean_cand i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku ln_staff_all win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019, gmm(ln_diff_salary c.ln_diff_salary#c.ln_diff_salary L.age_mean_cand) ivstyle(i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all) noleveleq robust twostep
margins, dydx(ln_diff_salary) at(ln_diff_salary = (0.5 1 1.5 2 2.5 3 3.5))
*有意でない

* sys GMM

xtabond2 age_mean_cand lnsalary_am_kokuji i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku ln_staff_all win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019, gmm(lnsalary_am_kokuji) ivstyle(i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all) robust twostep
*点推定プラス
estimates store r3, title("sys GMM")
estadd local municipality "Yes": r3
estadd local year "Yes": r3

xtabond2 age_mean_cand ln_diff_salary i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku ln_staff_all win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019, gmm(ln_diff_salary) ivstyle(i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all) robust twostep
*点推定プラス;検定アカン

xtabond2 age_mean_cand lnsalary_am_kokuji L1.age_mean_cand i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku ln_staff_all win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019, gmm(lnsalary_am_kokuji L.age_mean_cand) ivstyle(i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all) robust twostep
*点推定プラス
estimates store r4, title("sys GMM")
estadd local municipality "Yes": r4
estadd local year "Yes": r4

xtabond2 age_mean_cand ln_diff_salary L1.age_mean_cand i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku ln_staff_all win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019, gmm(ln_diff_salary L.age_mean_cand) ivstyle(i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all) robust twostep
*点推定プラス
estimates store r5, title("sys GMM")
estadd local municipality "Yes": r5
estadd local year "Yes": r5

esttab r1 r2 r3 r4 r5 using "age_gmm.tex", replace ///
b(3) se(3) star(* 0.10 ** 0.05 *** 0.01) booktabs ///
drop(*.nendo _cons) nogaps ///
stats(year municipality N, fmt(%9.0f %9.0f %9.0f) labels("年度固定効果" "自治体固定効果" "観測数")) ///
label nolz varwidth(16) modelwidth(13) style(tex)  ///
title(被説明変数: 立候補者平均年齢) coeflabels(lnsalary_am_kokuji "対数議員報酬額" ln_diff_salary "報酬額対数差分" L.age_mean_cand "立候補者平均年齢_1期ラグ"  ///
ln_population "対数人口" n_seats_adopt "議席数" ///
population_elderly75_ratio "全人口に占める75歳以上の割合" population_child15_ratio "全人口に占める15歳未満の割合" ln_income_per "納税者1人あたり課税対象所得" ///
ln_all_menseki "対数面積" canlive_ratio_menseki "可住地面積割合" sigaika_ratio_area "市街化区域面積割合" ln_zaiseiryoku ///
"対数財政力指数" win_ratio_musyozoku_pre "前回当選者に占める無所属の割合" ln_staff_all "対数自治体職員数" expired_dummy ///
"任期満了ダミー" touitsu_2011 "2011年統一選ダミー" touitsu_2015 "2015年統一選ダミー" touitsu_2019 "2019年統一選ダミー") ///
order(lnsalary_am_kokuji ln_diff_salary L.age_mean_cand) ///
mlabels(, span prefix(\multicolumn{@span}{c}{) suffix(})) ///
prehead("\documentclass[10pt]{jsarticle}" "\pagestyle{empty}" "\usepackage{booktabs}""\usepackage{siunitx}""\usepackage{lscape}" ///
"\usepackage[margin=20truemm]{geometry}""\sisetup{input-symbols = ()}""\begin{document}""\begin{table}\caption{@title}" ///
"\def\sym#1{\ifmmode^{#1}\else\(^{#1}\)\fi}""\begin{center}" ///
"\sisetup{table-space-text-post = \sym{***}}""\begin{tabular}{l*{@M}{llll}}""\toprule") posthead(\midrule) prefoot(\midrule) ///
postfoot("\bottomrule""\end{tabular}""\end{center}""\end{table}""\end{document}")

**squared

xtabond2 age_mean_cand c.lnsalary_am_kokuji##c.lnsalary_am_kokuji L1.age_mean_cand i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku ln_staff_all win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019, gmm(lnsalary_am_kokuji c.lnsalary_am_kokuji#c.lnsalary_am_kokuji L.age_mean_cand) ivstyle(i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all) robust twostep
estimates store r1, title("sys GMM")
estadd local municipality "Yes": r1
estadd local year "Yes": r1
margins, at(lnsalary_am_kokuji = (6.5 7 7.5 8 8.5 9))
marginsplot
margins, dydx(lnsalary_am_kokuji) at(lnsalary_am_kokuji = (6.5 7 7.5 8 8.5 9))
marginsplot
**なんか知らんけど有意


xtreg age_mean_cand c.lnsalary_am_kokuji##c.lnsalary_am_kokuji i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku ln_staff_all win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019, fe vce(cluster pres_pm_codes)
estimates store r2, title("FE")
estadd local municipality "Yes": r2
estadd local year "Yes": r2
margins, at(lnsalary_am_kokuji = (6.5 7 7.5 8 8.5 9))
marginsplot
margins, dydx( lnsalary_am_kokuji) at(lnsalary_am_kokuji = (6.5 7 7.5 8 8.5 9))
marginsplot

xtabond2 age_mean_cand c.lnsalary_am_kokuji##c.lnsalary_am_kokuji L1.age_mean_cand i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku ln_staff_all win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019, gmm(lnsalary_am_kokuji c.lnsalary_am_kokuji#c.lnsalary_am_kokuji L.age_mean_cand) ivstyle(i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all) noleveleq robust twostep
estimates store r3, title("diff GMM")
estadd local municipality "Yes": r3
estadd local year "Yes": r3
margins, at(lnsalary_am_kokuji = (6.5 7 7.5 8 8.5 9))
marginsplot
margins, dydx(lnsalary_am_kokuji) at(lnsalary_am_kokuji = (6.5 7 7.5 8 8.5 9))
marginsplot
**有意でない


**interaction
xtabond2 age_mean_cand c.lnsalary_am_kokuji##c.win_ratio_musyozoku_pre L1.age_mean_cand i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku ln_staff_all expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019, gmm(lnsalary_am_kokuji c.lnsalary_am_kokuji#c.win_ratio_musyozoku_pre L.age_mean_cand) ivstyle(i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all) robust twostep
estimates store r4, title("sys GMM")
estadd local municipality "Yes": r4
estadd local year "Yes": r4
margins, dydx(lnsalary_am_kokuji) at(win_ratio_musyozoku_pre = (0 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1))
marginsplot

xtreg age_mean_cand c.lnsalary_am_kokuji##c.win_ratio_musyozoku_pre i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku ln_staff_all expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019, fe vce(cluster pres_pm_codes)
estimates store r5, title("FE")
estadd local municipality "Yes": r5
estadd local year "Yes": r5
margins, dydx(lnsalary_am_kokuji) at(win_ratio_musyozoku_pre = (0 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1))
marginsplot

xtabond2 age_mean_cand c.lnsalary_am_kokuji##c.win_ratio_musyozoku_pre L1.age_mean_cand i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku ln_staff_all expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019, gmm(lnsalary_am_kokuji c.lnsalary_am_kokuji#c.win_ratio_musyozoku_pre L.age_mean_cand) ivstyle(i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all) noleveleq robust twostep
estimates store r6, title("diff GMM")
estadd local municipality "Yes": r6
estadd local year "Yes": r6
margins, dydx(lnsalary_am_kokuji) at(win_ratio_musyozoku_pre = (0 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1))
marginsplot

esttab r2 r3 r1 r5 r6 r4 using "age_sqared_intr.tex", replace ///
b(3) se(3) star(* 0.10 ** 0.05 *** 0.01) booktabs ///
drop(touitsu_2007 *.nendo _cons) nogaps ///
stats(year municipality N, fmt(%9.0f %9.0f %9.0f) labels("年度固定効果" "自治体固定効果" "観測数")) ///
label nolz varwidth(16) modelwidth(13) style(tex)  ///
title(被説明変数: 立候補者平均年齢) coeflabels(lnsalary_am_kokuji "対数議員報酬額" ln_diff_salary "報酬額対数差分" L.age_mean_cand "立候補者平均年齢_1期ラグ"  ///
c.lnsalary_am_kokuji#c.win_ratio_musyozoku_pre "対数議員報酬額 x 前回当選者に占める無所属の割合" c.lnsalary_am_kokuji#c.lnsalary_am_kokuji ///
"対数議員報酬額 2乗" ln_population "対数人口" n_seats_adopt "議席数" ///
population_elderly75_ratio "全人口に占める75歳以上の割合" population_child15_ratio "全人口に占める15歳未満の割合" ln_income_per "納税者1人あたり課税対象所得" ///
ln_all_menseki "対数面積" canlive_ratio_menseki "可住地面積割合" sigaika_ratio_area "市街化区域面積割合" ln_zaiseiryoku ///
"対数財政力指数" win_ratio_musyozoku_pre "前回当選者に占める無所属の割合" ln_staff_all "対数自治体職員数" expired_dummy ///
"任期満了ダミー" touitsu_2011 "2011年統一選ダミー" touitsu_2015 "2015年統一選ダミー" touitsu_2019 "2019年統一選ダミー") ///
order(lnsalary_am_kokuji ln_diff_salary c.lnsalary_am_kokuji#c.lnsalary_am_kokuji c.lnsalary_am_kokuji#c.win_ratio_musyozoku_pre L.age_mean_cand) ///
mlabels(, span prefix(\multicolumn{@span}{c}{) suffix(})) ///
prehead("\documentclass[10pt]{jsarticle}" "\pagestyle{empty}" "\usepackage{booktabs}""\usepackage{siunitx}""\usepackage{lscape}" ///
"\usepackage[margin=20truemm]{geometry}""\sisetup{input-symbols = ()}""\begin{document}""\begin{table}\caption{@title}" ///
"\def\sym#1{\ifmmode^{#1}\else\(^{#1}\)\fi}""\begin{center}" ///
"\sisetup{table-space-text-post = \sym{***}}""\begin{tabular}{l*{@M}{llll}}""\toprule") posthead(\midrule) prefoot(\midrule) ///
postfoot("\bottomrule""\end{tabular}""\end{center}""\end{table}""\end{document}")











