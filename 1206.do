
**投票率
voting_rate_isna
replace voting_rate_isna = . if voting_rate_isna == 100

gen ln_abs_change_salary = log(abs_change_salary_am)

gen muni_type_id = 1
replace muni_type_id = 2 if muni_type == 1
replace muni_type_id = 3 if muni_type == 4
replace muni_type_id = 4 if muni_type == 3

tab muni_type_id

list ele_id if muni_type == .

sum voting_rate_isna, detail
list ele_id voting_rate_isna if voting_rate_isna < 30 
replace voting_rate_isna = . if voting_rate_isna < 20

list ele_id voting_rate_isna if (voting_rate_isna > 97)&(voting_rate_isna != .)
replace voting_rate_isna = . if voting_rate_isna == 100



sum voting_rate_isna
hist voting_rate_isna

sum ln_population, detail
mean ln_population

gen small_popu_5per = 0
replace small_popu_5per = 1 if ln_population <= 7.77191
replace small_popu_5per = . if ln_population == .

gen large_popu_5per = 0
replace large_popu_5per = 1 if ln_population >= 12.58265 
replace large_popu_5per = . if ln_population == .

gen cate_popu_5per = 0
replace cate_popu_5per = 1 if large_popu_5per == 1 
replace cate_popu_5per = 2 if small_popu_5per == 1
replace cate_popu_5per = . if ln_population == .

tab cate_change_salary

reg voting_rate_isna i.cate_change_salary, vce(cluster pres_pm_codes)
reg voting_rate_isna dummy_up_salary, vce(cluster pres_pm_codes)
reg voting_rate_isna dummy_down_salary, vce(cluster pres_pm_codes)

reg voting_rate_isna lnsalary_am_kokuji, vce(cluster pres_pm_codes)
reg voting_rate_isna ln_diff_salary, vce(cluster pres_pm_codes)

reg voting_rate_isna lnsalary_am_kokuji ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku ln_staff_all win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019, vce(cluster pres_pm_codes)
**1%有意

reg voting_rate_isna i.cate_change_salary ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku ln_staff_all win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019, vce(cluster pres_pm_codes)
**減額有意

reg voting_rate_isna dummy_up_salary ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku ln_staff_all win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019, vce(cluster pres_pm_codes)

reg voting_rate_isna dummy_down_salary ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku ln_staff_all win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019, vce(cluster pres_pm_codes)
**1%有意

xtreg voting_rate_isna i.cate_change_salary i.nendo, vce(cluster pres_pm_codes)
*増額プラス有意
xtreg voting_rate_isna dummy_up_salary i.nendo, fe vce(cluster pres_pm_codes)
*プラス有意
xtreg voting_rate_isna dummy_down_salary i.nendo, fe vce(cluster pres_pm_codes)
*点推定マイナス

xtreg voting_rate_isna lnsalary_am_kokuji i.nendo, fe vce(cluster pres_pm_codes)
*マイナス有意
xtreg voting_rate_isna ln_diff_salary i.nendo, fe vce(cluster pres_pm_codes)
*マイナス有意（ギリ）

xtreg voting_rate_isna dummy_down_salary ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku ln_staff_all win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 i.nendo, fe vce(cluster pres_pm_codes)

xtreg voting_rate_isna dummy_up_salary ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku ln_staff_all win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 i.nendo, fe vce(cluster pres_pm_codes)
*増額プラス有意

xtreg voting_rate_isna i.cate_change_salary ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku ln_staff_all win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 i.nendo, fe vce(cluster pres_pm_codes)
*増額プラス有意

xtreg voting_rate_isna i.cate_change_salary ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku ln_staff_all win_ratio_musyozoku_pre expired_dummy age_mean_cand cand_ratio_musyozoku compe_rate_adopt ratio_women_cand_adopt touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 i.nendo, fe vce(cluster pres_pm_codes)
*増額プラス有意

xtreg voting_rate_isna lnsalary_am_kokuji ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku ln_staff_all win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 i.nendo, fe vce(cluster pres_pm_codes)
*有意性消える

xtreg voting_rate_isna lnsalary_am_kokuji ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku ln_staff_all win_ratio_musyozoku_pre expired_dummy age_mean_cand cand_ratio_musyozoku compe_rate_adopt ratio_women_cand_adopt touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 i.nendo, fe vce(cluster pres_pm_codes)
*有意性消える

xtreg voting_rate_isna c.lnsalary_am_kokuji##c.lnsalary_am_kokuji ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku ln_staff_all win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 i.nendo, fe vce(cluster pres_pm_codes)
margins, dydx(lnsalary_am_kokuji) at(lnsalary_am_kokuji = (6.5 7 7.5 8 8.5 9))
*給料低いところが効く

xtreg voting_rate_isna c.lnsalary_am_kokuji##c.lnsalary_am_kokuji ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku ln_staff_all win_ratio_musyozoku_pre age_mean_cand cand_ratio_musyozoku compe_rate_adopt ratio_women_cand_adopt expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 i.nendo, fe vce(cluster pres_pm_codes)
margins, dydx(lnsalary_am_kokuji) at(lnsalary_am_kokuji = (6.5 7 7.5 8 8.5 9))
*給料高いところが効く

xtreg voting_rate_isna c.lnsalary_am_kokuji##c.ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku ln_staff_all win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 i.nendo, fe vce(cluster pres_pm_codes)
margins, dydx(lnsalary_am_kokuji) at(ln_population = (6 7 8 9 10 11 12 13 14 15))
*有意、人口少ないところで利く

xtreg voting_rate_isna c.ln_diff_salary##c.ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku ln_staff_all win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 i.nendo, fe vce(cluster pres_pm_codes)
margins, dydx(ln_diff_salary) at(ln_population = (6 7 8 9 10 11 12 13 14 15))
*有意、人口少ないところで利く

xtreg voting_rate_isna c.ln_diff_salary##c.ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku ln_staff_all win_ratio_musyozoku_pre win_ratio_musyozoku_pre age_mean_cand cand_ratio_musyozoku compe_rate_adopt ratio_women_cand_adopt expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 i.nendo, fe vce(cluster pres_pm_codes)
margins, dydx(ln_diff_salary) at(ln_population = (6 7 8 9 10 11 12 13 14 15))
*利かない

xtreg voting_rate_isna c.lnsalary_am_kokuji##i.cate_change_salary c.ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku ln_staff_all win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 i.nendo, fe vce(cluster pres_pm_codes)
margins, dydx(i.cate_change_salary) at(lnsalary_am_kokuji = (6.5 7 7.5 8 8.5 9))
*増額が効く(給料高いところ)

xtreg voting_rate_isna c.lnsalary_am_kokuji##i.cate_change_salary c.ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku ln_staff_all win_ratio_musyozoku_pre age_mean_cand cand_ratio_musyozoku compe_rate_adopt ratio_women_cand_adopt expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 i.nendo, fe vce(cluster pres_pm_codes)
margins, dydx(i.cate_change_salary) at(lnsalary_am_kokuji = (6.5 7 7.5 8 8.5 9))
*増額が効く(給料高いところ)

xtreg voting_rate_isna i.cate_change_salary##c.ln_population c.lnsalary_am_kokuji n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku ln_staff_all win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 i.nendo, fe vce(cluster pres_pm_codes)
margins, dydx(i.cate_change_salary) at(ln_population = (6 7 8 9 10 11 12 13 14 15))
*増額が効く(人口多いところ)

xtreg voting_rate_isna i.cate_change_salary##c.ln_population c.lnsalary_am_kokuji n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku ln_staff_all win_ratio_musyozoku_pre age_mean_cand cand_ratio_musyozoku compe_rate_adopt ratio_women_cand_adopt expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 i.nendo, fe vce(cluster pres_pm_codes)
margins, dydx(i.cate_change_salary) at(ln_population = (6 7 8 9 10 11 12 13 14 15))
*増額が効く(人口多いところ)

xtreg voting_rate_isna i.cate_change_salary##c.ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku ln_staff_all win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 i.nendo, fe vce(cluster pres_pm_codes)
margins, dydx(i.cate_change_salary) at(ln_population = (6 7 8 9 10 11 12 13 14 15))
*増額が効く(人口多いところ)

xtreg voting_rate_isna i.cate_change_salary##c.ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku ln_staff_all win_ratio_musyozoku_pre age_mean_cand cand_ratio_musyozoku compe_rate_adopt ratio_women_cand_adopt expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 i.nendo, fe vce(cluster pres_pm_codes)
margins, dydx(i.cate_change_salary) at(ln_population = (6 7 8 9 10 11 12 13 14 15))
*増額が効く(人口多いところ)

xtreg voting_rate_isna i.cate_change_salary##c.ln_population##c.ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku ln_staff_all win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 i.nendo, fe vce(cluster pres_pm_codes)
margins, dydx(i.cate_change_salary) at(ln_population = (6 7 8 9 10 11 12 13 14 15))
*増額が効く(人口多いところ)

xtreg voting_rate_isna i.cate_change_salary##c.ln_population##c.ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku ln_staff_all win_ratio_musyozoku_pre age_mean_cand cand_ratio_musyozoku compe_rate_adopt ratio_women_cand_adopt expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 i.nendo, fe vce(cluster pres_pm_codes)
margins, dydx(i.cate_change_salary) at(ln_population = (6 7 8 9 10 11 12 13 14 15))
*増額が効く(人口多いところ)

xtreg voting_rate_isna i.cate_change_salary i.cate_change_salary#c.abs_change_salary n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku ln_staff_all win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 i.nendo, fe vce(cluster pres_pm_codes)
margins, dydx(i.cate_change_salary) at(ln_population = (6 7 8 9 10 11 12 13 14 15))

xtreg voting_rate_isna i.cate_change_salary i.cate_change_salary#c.abs_change_salary ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku ln_staff_all win_ratio_musyozoku_pre  age_mean_cand cand_ratio_musyozoku compe_rate_adopt ratio_women_cand_adopt expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 i.nendo, fe vce(cluster pres_pm_codes)

xtreg voting_rate_isna i.cate_change_salary i.cate_change_salary##i.cate_popu_5per ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku ln_staff_all win_ratio_musyozoku_pre  age_mean_cand cand_ratio_musyozoku compe_rate_adopt ratio_women_cand_adopt expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 i.nendo, fe vce(cluster pres_pm_codes)
margins, dydx(i.cate_change_salary) at(cate_popu_5per = (0 1 2))

** result
estimates clear

reg voting_rate_isna i.cate_change_salary, vce(cluster pres_pm_codes)
estimates store r1, title("OLS")
estadd local municipality "No": r1
estadd local year "No": r1

reg voting_rate_isna lnsalary_am_kokuji, vce(cluster pres_pm_codes)
estimates store r2, title("OLS")
estadd local municipality "No": r2
estadd local year "No": r2

reg voting_rate_isna i.cate_change_salary ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku ln_staff_all win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019, vce(cluster pres_pm_codes)
estimates store r4, title("OLS")
estadd local municipality "No": r4
estadd local year "No": r4

reg voting_rate_isna lnsalary_am_kokuji ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku ln_staff_all win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019, vce(cluster pres_pm_codes)
estimates store r5, title("OLS")
estadd local municipality "No": r5
estadd local year "No": r5

reg voting_rate_isna i.cate_change_salary lnsalary_am_kokuji ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku ln_staff_all win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019, vce(cluster pres_pm_codes)
estimates store r6, title("OLS")
estadd local municipality "No": r6
estadd local year "No": r6

reg voting_rate_isna i.cate_change_salary lnsalary_am_kokuji ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku ln_staff_all win_ratio_musyozoku_pre age_mean_cand cand_ratio_musyozoku compe_rate_adopt ratio_women_cand_adopt expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019, vce(cluster pres_pm_codes)
estimates store r7, title("OLS")
estadd local municipality "No": r7
estadd local year "No": r7

esttab r1 r2 r4 r5 r6 r7 using "voting_rate_ols.tex", replace ///
b(3) se(3) star(* 0.10 ** 0.05 *** 0.01) booktabs ///
drop(touitsu_2007 _cons) nogaps ///
stats(year municipality N, fmt(%9.0f %9.0f %9.0f) labels("年度固定効果" "自治体固定効果" "観測数")) ///
label nolz varwidth(16) modelwidth(13) style(tex)  ///
title(被説明変数: 投票率(％)) coeflabels(lnsalary_am_kokuji "対数議員報酬額" 1.cate_change_salary "増額ダミー" 2.cate_change_salary "減額ダミー" /// 
ln_population "対数人口" n_seats_adopt "議席数" population_elderly75_ratio "全人口に占める75歳以上の割合" population_child15_ratio "全人口に占める15歳未満の割合"  ///
ln_income_per "納税者1人あたり課税対象所得" ln_all_menseki "対数面積" canlive_ratio_menseki "可住地面積割合" sigaika_ratio_area "市街化区域面積割合" ln_zaiseiryoku ///
"対数財政力指数" win_ratio_musyozoku_pre "前回当選者に占める無所属の割合" ln_staff_all "対数自治体職員数" ///
age_mean_cand "立候補者平均年齢" cand_ratio_musyozoku "立候補者無所属割合"ratio_women_cand_adopt "立候補者女性割合" compe_rate_adopt "1議席あたり立候補者数" touitsu_2011 "2011年統一選ダミー" touitsu_2015 "2015年統一選ダミー" touitsu_2019 "2019年統一選ダミー" expired_dummy "任期満了ダミー") ///
order(lnsalary_am_kokuji 1.cate_change_salary 2.cate_change_salary) ///
mlabels(, span prefix(\multicolumn{@span}{c}{) suffix(})) ///
prehead("\documentclass[11pt]{jsarticle}" "\pagestyle{empty}" "\usepackage{booktabs}""\usepackage{siunitx}""\usepackage{lscape}" ///
"\usepackage[margin=20truemm]{geometry}""\sisetup{input-symbols = ()}""\begin{document}""\begin{table}\caption{@title}" ///
"\def\sym#1{\ifmmode^{#1}\else\(^{#1}\)\fi}""\begin{center}" ///
"\sisetup{table-space-text-post = \sym{***}}""\begin{tabular}{l*{@M}{llll}}""\toprule") posthead(\midrule) prefoot(\midrule) ///
postfoot("\bottomrule""\end{tabular}""\end{center}""\end{table}""\end{document}")



reg voting_rate_isna i.cate_change_salary##c.lnsalary_am_kokuji ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku ln_staff_all win_ratio_musyozoku_pre age_mean_cand cand_ratio_musyozoku compe_rate_adopt ratio_women_cand_adopt expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019, vce(cluster pres_pm_codes)



* FE
estimates clear

xtreg voting_rate_isna i.cate_change_salary, fe vce(cluster pres_pm_codes)
estimates store r1, title("FE")
estadd local municipality "Yes": r1
estadd local year "Yes": r1

xtreg voting_rate_isna lnsalary_am_kokuji, fe vce(cluster pres_pm_codes)
estimates store r2, title("FE")
estadd local municipality "Yes": r2
estadd local year "Yes": r2

xtreg voting_rate_isna i.cate_change_salary ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku ln_staff_all win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019, fe vce(cluster pres_pm_codes)
estimates store r4, title("FE")
estadd local municipality "Yes": r4
estadd local year "Yes": r4

xtreg voting_rate_isna lnsalary_am_kokuji ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku ln_staff_all win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019, fe vce(cluster pres_pm_codes)
estimates store r5, title("FE")
estadd local municipality "Yes": r5
estadd local year "Yes": r5

xtreg voting_rate_isna i.cate_change_salary lnsalary_am_kokuji ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku ln_staff_all win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019, fe vce(cluster pres_pm_codes)
estimates store r6, title("FE")
estadd local municipality "Yes": r6
estadd local year "Yes": r6

xtreg voting_rate_isna i.cate_change_salary lnsalary_am_kokuji ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku ln_staff_all win_ratio_musyozoku_pre age_mean_cand cand_ratio_musyozoku compe_rate_adopt ratio_women_cand_adopt expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019, fe  vce(cluster pres_pm_codes)
estimates store r7, title("FE")
estadd local municipality "Yes": r7
estadd local year "Yes": r7

esttab r1 r2 r4 r5 r6 r7 using "voting_rate_fe.tex", replace ///
b(3) se(3) star(* 0.10 ** 0.05 *** 0.01) booktabs ///
drop(touitsu_2007 _cons) nogaps ///
stats(year municipality N, fmt(%9.0f %9.0f %9.0f) labels("年度固定効果" "自治体固定効果" "観測数")) ///
label nolz varwidth(16) modelwidth(13) style(tex)  ///
title(被説明変数: 投票率(％)) coeflabels(lnsalary_am_kokuji "対数議員報酬額" 1.cate_change_salary "増額ダミー" 2.cate_change_salary "減額ダミー" /// 
ln_population "対数人口" n_seats_adopt "議席数" population_elderly75_ratio "全人口に占める75歳以上の割合" population_child15_ratio "全人口に占める15歳未満の割合"  ///
ln_income_per "納税者1人あたり課税対象所得" ln_all_menseki "対数面積" canlive_ratio_menseki "可住地面積割合" sigaika_ratio_area "市街化区域面積割合" ln_zaiseiryoku ///
"対数財政力指数" win_ratio_musyozoku_pre "前回当選者に占める無所属の割合" ln_staff_all "対数自治体職員数" ///
age_mean_cand "立候補者平均年齢" cand_ratio_musyozoku "立候補者無所属割合"ratio_women_cand_adopt "立候補者女性割合" compe_rate_adopt "1議席あたり立候補者数" touitsu_2011 "2011年統一選ダミー" touitsu_2015 "2015年統一選ダミー" touitsu_2019 "2019年統一選ダミー" expired_dummy "任期満了ダミー") ///
order(lnsalary_am_kokuji 1.cate_change_salary 2.cate_change_salary) ///
mlabels(, span prefix(\multicolumn{@span}{c}{) suffix(})) ///
prehead("\documentclass[11pt]{jsarticle}" "\pagestyle{empty}" "\usepackage{booktabs}""\usepackage{siunitx}""\usepackage{lscape}" ///
"\usepackage[margin=20truemm]{geometry}""\sisetup{input-symbols = ()}""\begin{document}""\begin{table}\caption{@title}" ///
"\def\sym#1{\ifmmode^{#1}\else\(^{#1}\)\fi}""\begin{center}" ///
"\sisetup{table-space-text-post = \sym{***}}""\begin{tabular}{l*{@M}{llll}}""\toprule") posthead(\midrule) prefoot(\midrule) ///
postfoot("\bottomrule""\end{tabular}""\end{center}""\end{table}""\end{document}")


estimates clear

xtreg voting_rate_isna i.cate_change_salary##c.lnsalary_am_kokuji ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku ln_staff_all win_ratio_musyozoku_pre age_mean_cand cand_ratio_musyozoku compe_rate_adopt ratio_women_cand_adopt expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019, fe vce(cluster pres_pm_codes)
estimates store r1, title("FE")
estadd local municipality "Yes": r1
estadd local year "Yes": r1

margins, dydx(i.cate_change_salary) at(lnsalary_am_kokuji = (6.5 7 7.5 8 8.5 9))
marginsplot

xtreg voting_rate_isna i.cate_change_salary##c.ln_population c.lnsalary_am_kokuji n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku ln_staff_all win_ratio_musyozoku_pre age_mean_cand cand_ratio_musyozoku compe_rate_adopt ratio_women_cand_adopt expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019, fe vce(cluster pres_pm_codes)
estimates store r2, title("FE")
estadd local municipality "Yes": r2
estadd local year "Yes": r2

margins, dydx(i.cate_change_salary) at(ln_population = (6 7 8 9 10 11 12 13 14 15))
marginsplot

xtreg voting_rate_isna i.cate_change_salary##c.ln_population##c.ln_population c.lnsalary_am_kokuji n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku ln_staff_all win_ratio_musyozoku_pre age_mean_cand cand_ratio_musyozoku compe_rate_adopt ratio_women_cand_adopt expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019, fe vce(cluster pres_pm_codes)
estimates store r3, title("FE")
estadd local municipality "Yes": r3
estadd local year "Yes": r3

margins, dydx(i.cate_change_salary) at(ln_population = (6 7 8 9 10 11 12 13 14 15))
marginsplot

xtreg voting_rate_isna i.cate_change_salary##i.cate_popu_5per c.lnsalary_am_kokuji n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku ln_staff_all win_ratio_musyozoku_pre age_mean_cand cand_ratio_musyozoku compe_rate_adopt ratio_women_cand_adopt expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019, fe vce(cluster pres_pm_codes)
estimates store r4, title("FE")
estadd local municipality "Yes": r4
estadd local year "Yes": r4

margins, dydx(i.cate_change_salary) at(cate_popu_5per = (1 0 2))
marginsplot

xtreg voting_rate_isna i.cate_change_salary##i.muni_type_id c.lnsalary_am_kokuji n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku ln_staff_all win_ratio_musyozoku_pre age_mean_cand cand_ratio_musyozoku compe_rate_adopt ratio_women_cand_adopt expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019, fe vce(cluster pres_pm_codes)
estimates store r6, title("FE")
estadd local municipality "Yes": r6
estadd local year "Yes": r6

margins, dydx(i.cate_change_salary) at(muni_type_id = (1 2 3 4))
marginsplot

xtreg voting_rate_isna i.cate_change_salary##c.L1.teian_jyorei_4y c.lnsalary_am_kokuji n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku ln_staff_all win_ratio_musyozoku_pre age_mean_cand cand_ratio_musyozoku compe_rate_adopt ratio_women_cand_adopt expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 i.pref_id i.muni_type_id, vce(cluster pres_pm_codes)
estimates store r5, title("OLS")
estadd local municipality "Yes": r5
estadd local year "Yes": r5

margins, dydx(i.cate_change_salary) at(L1.teian_jyorei_4y = (0 1 2 3 4 5 6 7 8 9 10))
marginsplot

esttab r1 r2 r3 r4 r6 r5 using "voting_rate_int.tex", replace ///
b(3) se(3) star(* 0.10 ** 0.05 *** 0.01) booktabs ///
drop(touitsu_2007 _cons) nogaps ///
stats(year municipality N, fmt(%9.0f %9.0f %9.0f) labels("年度固定効果" "自治体固定効果" "観測数")) ///
label nolz varwidth(16) modelwidth(13) style(tex)  ///
title(被説明変数: 投票率(％)) coeflabels(lnsalary_am_kokuji "対数議員報酬額" 1.cate_change_salary "増額ダミー" 2.cate_change_salary "減額ダミー" /// 
ln_population "対数人口" n_seats_adopt "議席数" population_elderly75_ratio "全人口に占める75歳以上の割合" population_child15_ratio "全人口に占める15歳未満の割合"  ///
ln_income_per "納税者1人あたり課税対象所得" ln_all_menseki "対数面積" canlive_ratio_menseki "可住地面積割合" sigaika_ratio_area "市街化区域面積割合" ln_zaiseiryoku ///
"対数財政力指数" win_ratio_musyozoku_pre "前回当選者に占める無所属の割合" ln_staff_all "対数自治体職員数" ///
age_mean_cand "立候補者平均年齢" cand_ratio_musyozoku "立候補者無所属割合"ratio_women_cand_adopt "立候補者女性割合" compe_rate_adopt "1議席あたり立候補者数" touitsu_2011 "2011年統一選ダミー" touitsu_2015 "2015年統一選ダミー" touitsu_2019 "2019年統一選ダミー" expired_dummy "任期満了ダミー") ///
order(lnsalary_am_kokuji 1.cate_change_salary 2.cate_change_salary) ///
mlabels(, span prefix(\multicolumn{@span}{c}{) suffix(})) ///
prehead("\documentclass[11pt]{jsarticle}" "\pagestyle{empty}" "\usepackage{booktabs}""\usepackage{siunitx}""\usepackage{lscape}" ///
"\usepackage[margin=20truemm]{geometry}""\sisetup{input-symbols = ()}""\begin{document}""\begin{table}\caption{@title}" ///
"\def\sym#1{\ifmmode^{#1}\else\(^{#1}\)\fi}""\begin{center}" ///
"\sisetup{table-space-text-post = \sym{***}}""\begin{tabular}{l*{@M}{llll}}""\toprule") posthead(\midrule) prefoot(\midrule) ///
postfoot("\bottomrule""\end{tabular}""\end{center}""\end{table}""\end{document}")


xtreg voting_rate_isna c.lnsalary_am_kokuji##c.lnsalary_am_kokuji ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku ln_staff_all win_ratio_musyozoku_pre age_mean_cand cand_ratio_musyozoku compe_rate_adopt ratio_women_cand_adopt expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019, fe vce(cluster pres_pm_codes)

** average_vote_share

reg adjusted_ave_voteshare_inc i.cate_change_salary, vce(cluster pres_pm_codes)
estimates store r1, title("OLS")
estadd local municipality "No": r1
estadd local year "No": r1

reg adjusted_ave_voteshare_inc lnsalary_am_kokuji, vce(cluster pres_pm_codes)
estimates store r2, title("OLS")
estadd local municipality "No": r2
estadd local year "No": r2

reg adjusted_ave_voteshare_inc i.cate_change_salary ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku ln_staff_all win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019, vce(cluster pres_pm_codes)
estimates store r4, title("OLS")
estadd local municipality "No": r4
estadd local year "No": r4

reg adjusted_ave_voteshare_inc ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku ln_staff_all win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019, vce(cluster pres_pm_codes)
estimates store r5, title("OLS")
estadd local municipality "No": r5
estadd local year "No": r5

reg adjusted_ave_voteshare_inc i.cate_change_salary lnsalary_am_kokuji ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku ln_staff_all win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019, vce(cluster pres_pm_codes)
estimates store r6, title("OLS")
estadd local municipality "No": r6
estadd local year "No": r6

reg adjusted_ave_voteshare_inc i.cate_change_salary lnsalary_am_kokuji ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku ln_staff_all win_ratio_musyozoku_pre age_mean_cand cand_ratio_musyozoku compe_rate_adopt ratio_women_cand_adopt expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019, vce(cluster pres_pm_codes)
estimates store r7, title("OLS")
estadd local municipality "No": r7
estadd local year "No": r7

esttab r1 r2 r4 r5 r6 r7 using "adjinc_ols.tex", replace ///
b(3) se(3) star(* 0.10 ** 0.05 *** 0.01) booktabs ///
drop(touitsu_2007 _cons) nogaps ///
stats(year municipality N, fmt(%9.0f %9.0f %9.0f) labels("年度固定効果" "自治体固定効果" "観測数")) ///
label nolz varwidth(16) modelwidth(13) style(tex)  ///
title(被説明変数: 調整済み現職1人当たり得票率) coeflabels(lnsalary_am_kokuji "対数議員報酬額" 1.cate_change_salary "増額ダミー" 2.cate_change_salary "減額ダミー" /// 
ln_population "対数人口" n_seats_adopt "議席数" population_elderly75_ratio "全人口に占める75歳以上の割合" population_child15_ratio "全人口に占める15歳未満の割合"  ///
ln_income_per "納税者1人あたり課税対象所得" ln_all_menseki "対数面積" canlive_ratio_menseki "可住地面積割合" sigaika_ratio_area "市街化区域面積割合" ln_zaiseiryoku ///
"対数財政力指数" win_ratio_musyozoku_pre "前回当選者に占める無所属の割合" ln_staff_all "対数自治体職員数" ///
age_mean_cand "立候補者平均年齢" cand_ratio_musyozoku "立候補者無所属割合"ratio_women_cand_adopt "立候補者女性割合" compe_rate_adopt "1議席あたり立候補者数" touitsu_2011 "2011年統一選ダミー" touitsu_2015 "2015年統一選ダミー" touitsu_2019 "2019年統一選ダミー" expired_dummy "任期満了ダミー") ///
order(lnsalary_am_kokuji 1.cate_change_salary 2.cate_change_salary) ///
mlabels(, span prefix(\multicolumn{@span}{c}{) suffix(})) ///
prehead("\documentclass[11pt]{jsarticle}" "\pagestyle{empty}" "\usepackage{booktabs}""\usepackage{siunitx}""\usepackage{lscape}" ///
"\usepackage[margin=20truemm]{geometry}""\sisetup{input-symbols = ()}""\begin{document}""\begin{table}\caption{@title}" ///
"\def\sym#1{\ifmmode^{#1}\else\(^{#1}\)\fi}""\begin{center}" ///
"\sisetup{table-space-text-post = \sym{***}}""\begin{tabular}{l*{@M}{llll}}""\toprule") posthead(\midrule) prefoot(\midrule) ///
postfoot("\bottomrule""\end{tabular}""\end{center}""\end{table}""\end{document}")


*FE
estimates clear

xtreg adjusted_ave_voteshare_inc i.cate_change_salary, fe vce(cluster pres_pm_codes)
estimates store r1, title("FE")
estadd local municipality "Yes": r1
estadd local year "Yes": r1

xtreg adjusted_ave_voteshare_inc lnsalary_am_kokuji, fe vce(cluster pres_pm_codes)
estimates store r2, title("FE")
estadd local municipality "Yes": r2
estadd local year "Yes": r2

xtreg adjusted_ave_voteshare_inc i.cate_change_salary ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku ln_staff_all win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019, fe vce(cluster pres_pm_codes)
estimates store r4, title("FE")
estadd local municipality "Yes": r4
estadd local year "Yes": r4

xtreg adjusted_ave_voteshare_inc lnsalary_am_kokuji ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku ln_staff_all win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019, fe vce(cluster pres_pm_codes)
estimates store r5, title("FE")
estadd local municipality "Yes": r5
estadd local year "Yes": r5

xtreg adjusted_ave_voteshare_inc i.cate_change_salary lnsalary_am_kokuji ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku ln_staff_all win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019, fe vce(cluster pres_pm_codes)
estimates store r6, title("FE")
estadd local municipality "Yes": r6
estadd local year "Yes": r6

xtreg adjusted_ave_voteshare_inc i.cate_change_salary lnsalary_am_kokuji ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku ln_staff_all win_ratio_musyozoku_pre age_mean_cand cand_ratio_musyozoku compe_rate_adopt ratio_women_cand_adopt expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019, fe  vce(cluster pres_pm_codes)
estimates store r7, title("FE")
estadd local municipality "Yes": r7
estadd local year "Yes": r7

esttab r1 r2 r4 r5 r6 r7 using "adjinc_fe.tex", replace ///
b(3) se(3) star(* 0.10 ** 0.05 *** 0.01) booktabs ///
drop(touitsu_2007 0.cate_change_salary _cons) nogaps ///
stats(year municipality N, fmt(%9.0f %9.0f %9.0f) labels("年度固定効果" "自治体固定効果" "観測数")) ///
label nolz varwidth(16) modelwidth(13) style(tex)  ///
title(被説明変数: 投票率(％)) coeflabels(lnsalary_am_kokuji "対数議員報酬額" 1.cate_change_salary "増額ダミー" 2.cate_change_salary "減額ダミー" /// 
ln_population "対数人口" n_seats_adopt "議席数" population_elderly75_ratio "全人口に占める75歳以上の割合" population_child15_ratio "全人口に占める15歳未満の割合"  ///
ln_income_per "納税者1人あたり課税対象所得" ln_all_menseki "対数面積" canlive_ratio_menseki "可住地面積割合" sigaika_ratio_area "市街化区域面積割合" ln_zaiseiryoku ///
"対数財政力指数" win_ratio_musyozoku_pre "前回当選者に占める無所属の割合" ln_staff_all "対数自治体職員数" ///
age_mean_cand "立候補者平均年齢" cand_ratio_musyozoku "立候補者無所属割合"ratio_women_cand_adopt "立候補者女性割合" compe_rate_adopt "1議席あたり立候補者数" touitsu_2011 "2011年統一選ダミー" touitsu_2015 "2015年統一選ダミー" touitsu_2019 "2019年統一選ダミー" expired_dummy "任期満了ダミー") ///
order(lnsalary_am_kokuji 1.cate_change_salary 2.cate_change_salary) ///
mlabels(, span prefix(\multicolumn{@span}{c}{) suffix(})) ///
prehead("\documentclass[11pt]{jsarticle}" "\pagestyle{empty}" "\usepackage{booktabs}""\usepackage{siunitx}""\usepackage{lscape}" ///
"\usepackage[margin=20truemm]{geometry}""\sisetup{input-symbols = ()}""\begin{document}""\begin{table}\caption{@title}" ///
"\def\sym#1{\ifmmode^{#1}\else\(^{#1}\)\fi}""\begin{center}" ///
"\sisetup{table-space-text-post = \sym{***}}""\begin{tabular}{l*{@M}{llll}}""\toprule") posthead(\midrule) prefoot(\midrule) ///
postfoot("\bottomrule""\end{tabular}""\end{center}""\end{table}""\end{document}")

* Intaraction
estimates clear

xtreg adjusted_ave_voteshare_inc i.cate_change_salary##c.lnsalary_am_kokuji ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku ln_staff_all win_ratio_musyozoku_pre age_mean_cand cand_ratio_musyozoku compe_rate_adopt ratio_women_cand_adopt expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019, fe vce(cluster pres_pm_codes)
estimates store r1, title("FE")
estadd local municipality "Yes": r1
estadd local year "Yes": r1

margins, dydx(i.cate_change_salary) at(lnsalary_am_kokuji = (6.5 7 7.5 8 8.5 9))
marginsplot

xtreg adjusted_ave_voteshare_inc i.cate_change_salary##c.ln_population c.lnsalary_am_kokuji n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku ln_staff_all win_ratio_musyozoku_pre age_mean_cand cand_ratio_musyozoku compe_rate_adopt ratio_women_cand_adopt expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019, fe vce(cluster pres_pm_codes)
estimates store r2, title("FE")
estadd local municipality "Yes": r2
estadd local year "Yes": r2

margins, dydx(i.cate_change_salary) at(ln_population = (6 7 8 9 10 11 12 13 14 15))
marginsplot

xtreg adjusted_ave_voteshare_inc i.cate_change_salary##c.ln_population##c.ln_population c.lnsalary_am_kokuji n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku ln_staff_all win_ratio_musyozoku_pre age_mean_cand cand_ratio_musyozoku compe_rate_adopt ratio_women_cand_adopt expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019, fe vce(cluster pres_pm_codes)
estimates store r3, title("FE")
estadd local municipality "Yes": r3
estadd local year "Yes": r3

margins, dydx(i.cate_change_salary) at(ln_population = (6 7 8 9 10 11 12 13 14 15))
marginsplot

xtreg adjusted_ave_voteshare_inc i.cate_change_salary##i.cate_popu_5per c.lnsalary_am_kokuji n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku ln_staff_all win_ratio_musyozoku_pre age_mean_cand cand_ratio_musyozoku compe_rate_adopt ratio_women_cand_adopt expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019, fe vce(cluster pres_pm_codes)
estimates store r4, title("FE")
estadd local municipality "Yes": r4
estadd local year "Yes": r4

margins, dydx(i.cate_change_salary) at(cate_popu_5per = (1 0 2))
marginsplot

xtreg adjusted_ave_voteshare_inc i.cate_change_salary##i.muni_type_id c.lnsalary_am_kokuji n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku ln_staff_all win_ratio_musyozoku_pre age_mean_cand cand_ratio_musyozoku compe_rate_adopt ratio_women_cand_adopt expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019, fe vce(cluster pres_pm_codes)
estimates store r6, title("FE")
estadd local municipality "Yes": r6
estadd local year "Yes": r6

margins, dydx(i.cate_change_salary) at(muni_type_id = (1 2 3 4))
marginsplot

xtreg adjusted_ave_voteshare_inc i.cate_change_salary##c.L1.teian_jyorei_4y c.lnsalary_am_kokuji n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku ln_staff_all win_ratio_musyozoku_pre  expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 i.pref_id i.muni_type_id, fe vce(cluster pres_pm_codes)
estimates store r5, title("OLS")
estadd local municipality "Yes": r5
estadd local year "Yes": r5

margins, dydx(i.cate_change_salary) at(L1.teian_jyorei_4y = (0 1 2 3 4 5 6 7 8 9 10))
marginsplot

esttab r1 r2 r3 r4 r6 r5 using "adjinc_int.tex", replace ///
b(3) se(3) star(* 0.10 ** 0.05 *** 0.01) booktabs ///
drop(touitsu_2007 _cons *.pref_id) nogaps ///
stats(year municipality N, fmt(%9.0f %9.0f %9.0f) labels("年度固定効果" "自治体固定効果" "観測数")) ///
label nolz varwidth(16) modelwidth(13) style(tex)  ///
title(被説明変数: 投票率(％)) coeflabels(lnsalary_am_kokuji "対数議員報酬額" 1.cate_change_salary "増額ダミー" 2.cate_change_salary "減額ダミー" /// 
ln_population "対数人口" n_seats_adopt "議席数" population_elderly75_ratio "全人口に占める75歳以上の割合" population_child15_ratio "全人口に占める15歳未満の割合"  ///
ln_income_per "納税者1人あたり課税対象所得" ln_all_menseki "対数面積" canlive_ratio_menseki "可住地面積割合" sigaika_ratio_area "市街化区域面積割合" ln_zaiseiryoku ///
"対数財政力指数" win_ratio_musyozoku_pre "前回当選者に占める無所属の割合" ln_staff_all "対数自治体職員数" ///
age_mean_cand "立候補者平均年齢" cand_ratio_musyozoku "立候補者無所属割合"ratio_women_cand_adopt "立候補者女性割合" compe_rate_adopt "1議席あたり立候補者数" touitsu_2011 "2011年統一選ダミー" touitsu_2015 "2015年統一選ダミー" touitsu_2019 "2019年統一選ダミー" expired_dummy "任期満了ダミー") ///
order(lnsalary_am_kokuji 1.cate_change_salary 2.cate_change_salary) ///
mlabels(, span prefix(\multicolumn{@span}{c}{) suffix(})) ///
prehead("\documentclass[11pt]{jsarticle}" "\pagestyle{empty}" "\usepackage{booktabs}""\usepackage{siunitx}""\usepackage{lscape}" ///
"\usepackage[margin=20truemm]{geometry}""\sisetup{input-symbols = ()}""\begin{document}""\begin{table}\caption{@title}" ///
"\def\sym#1{\ifmmode^{#1}\else\(^{#1}\)\fi}""\begin{center}" ///
"\sisetup{table-space-text-post = \sym{***}}""\begin{tabular}{l*{@M}{llll}}""\toprule") posthead(\midrule) prefoot(\midrule) ///
postfoot("\bottomrule""\end{tabular}""\end{center}""\end{table}""\end{document}")


** 1207

** squared
xtreg adjusted_ave_voteshare_inc c.lnsalary_am_kokuji##c.lnsalary_am_kokuji n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku ln_staff_all win_ratio_musyozoku_pre  expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019, fe vce(cluster pres_pm_codes)

xtreg adjusted_ave_voteshare_inc c.lnsalary_am_kokuji##c.lnsalary_am_kokuji i.cate_change_salary n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku ln_staff_all win_ratio_musyozoku_pre  expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019, fe vce(cluster pres_pm_codes)

** diff GMM

xtreg adjusted_ave_voteshare_inc i.cate_change_salary lnsalary_am_kokuji ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku ln_staff_all win_ratio_musyozoku_pre age_mean_cand cand_ratio_musyozoku compe_rate_adopt ratio_women_cand_adopt expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019, fe  vce(cluster pres_pm_codes)

xtabond2 adjusted_ave_voteshare_inc i.cate_change_salary ln_income_per i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku ln_staff_all compe_rate_adopt age_mean_cand ratio_women_cand_adopt cand_ratio_musyozoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019, gmm(i.cate_change_salary) ivstyle(i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku compe_rate_adopt age_mean_cand win_ratio_musyozoku_pre ratio_women_cand_adopt cand_ratio_musyozoku expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all) noleveleq twostep robust

xtabond2 adjusted_ave_voteshare_inc i.cate_change_salary lnsalary_am_kokuji ln_income_per i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku ln_staff_all compe_rate_adopt age_mean_cand ratio_women_cand_adopt cand_ratio_musyozoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019, gmm(i.cate_change_salary lnsalary_am_kokuji) ivstyle(i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku compe_rate_adopt age_mean_cand win_ratio_musyozoku_pre ratio_women_cand_adopt cand_ratio_musyozoku expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all) noleveleq twostep robust

xtabond2 adjusted_ave_voteshare_inc lnsalary_am_kokuji ln_income_per i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku ln_staff_all compe_rate_adopt age_mean_cand ratio_women_cand_adopt cand_ratio_musyozoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019, gmm( lnsalary_am_kokuji) ivstyle(i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku compe_rate_adopt age_mean_cand win_ratio_musyozoku_pre ratio_women_cand_adopt cand_ratio_musyozoku expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all) noleveleq twostep robust

xtabond2 adjusted_ave_voteshare_inc i.cate_change_salary lnsalary_am_kokuji L1.adjusted_ave_voteshare_inc ln_income_per i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku ln_staff_all compe_rate_adopt age_mean_cand ratio_women_cand_adopt cand_ratio_musyozoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019, gmm(i.cate_change_salary lnsalary_am_kokuji L.adjusted_ave_voteshare_inc) ivstyle(i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku compe_rate_adopt age_mean_cand win_ratio_musyozoku_pre ratio_women_cand_adopt cand_ratio_musyozoku expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all) noleveleq twostep robust
*レベル、減額マイナス有意,10%
margins, at(lnsalary_am_kokuji = (6.5 7 7.5 8 8.5 9))

xtabond2 adjusted_ave_voteshare_inc lnsalary_am_kokuji L1.adjusted_ave_voteshare_inc ln_income_per i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku ln_staff_all compe_rate_adopt age_mean_cand ratio_women_cand_adopt cand_ratio_musyozoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019, gmm( lnsalary_am_kokuji L.adjusted_ave_voteshare_inc) ivstyle(i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku compe_rate_adopt age_mean_cand win_ratio_musyozoku_pre ratio_women_cand_adopt cand_ratio_musyozoku expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all) noleveleq twostep robust
**レベルマイナス有意

xtabond2 adjusted_ave_voteshare_inc i.cate_change_salary L1.adjusted_ave_voteshare_inc ln_income_per i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku ln_staff_all compe_rate_adopt age_mean_cand ratio_women_cand_adopt cand_ratio_musyozoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019, gmm(i.cate_change_salary L.adjusted_ave_voteshare_inc) ivstyle(i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku compe_rate_adopt age_mean_cand win_ratio_musyozoku_pre ratio_women_cand_adopt cand_ratio_musyozoku expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all) noleveleq twostep robust

* interact with change
xtabond2 adjusted_ave_voteshare_inc i.cate_change_salary i.cate_change_salary#c.abs_change_salary L1.adjusted_ave_voteshare_inc ln_income_per i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku ln_staff_all compe_rate_adopt age_mean_cand ratio_women_cand_adopt cand_ratio_musyozoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019, gmm(i.cate_change_salary i.cate_change_salary#c.abs_change_salary L.adjusted_ave_voteshare_inc) ivstyle(i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku compe_rate_adopt age_mean_cand win_ratio_musyozoku_pre ratio_women_cand_adopt cand_ratio_musyozoku expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all) noleveleq twostep robust
**減額幅大きいと、得票率下がる

xtabond2 adjusted_ave_voteshare_inc i.cate_change_salary i.cate_change_salary#c.abs_change_salary L1.adjusted_ave_voteshare_inc lnsalary_am_kokuji ln_income_per i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku ln_staff_all compe_rate_adopt age_mean_cand ratio_women_cand_adopt cand_ratio_musyozoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019, gmm(i.cate_change_salary lnsalary_am_kokuji i.cate_change_salary#c.abs_change_salary L.adjusted_ave_voteshare_inc) ivstyle(i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku compe_rate_adopt age_mean_cand win_ratio_musyozoku_pre ratio_women_cand_adopt cand_ratio_musyozoku expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all) noleveleq twostep robust
**減額幅大きいと、得票率下がる10%

xtabond2 adjusted_ave_voteshare_inc change_salary_am L1.adjusted_ave_voteshare_inc lnsalary_am_kokuji ln_income_per i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku ln_staff_all compe_rate_adopt age_mean_cand ratio_women_cand_adopt cand_ratio_musyozoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019, gmm( change_salary_am L.adjusted_ave_voteshare_inc) ivstyle(i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku compe_rate_adopt age_mean_cand win_ratio_musyozoku_pre ratio_women_cand_adopt cand_ratio_musyozoku expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all) noleveleq twostep robust

*:squared
xtabond2 adjusted_ave_voteshare_inc c.lnsalary_am_kokuji##c.lnsalary_am_kokuji L1.adjusted_ave_voteshare_inc ln_income_per i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku ln_staff_all compe_rate_adopt age_mean_cand ratio_women_cand_adopt cand_ratio_musyozoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019, gmm(c.lnsalary_am_kokuji##c.lnsalary_am_kokuji L.adjusted_ave_voteshare_inc) ivstyle(i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku compe_rate_adopt age_mean_cand win_ratio_musyozoku_pre ratio_women_cand_adopt cand_ratio_musyozoku expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all) noleveleq twostep robust
*無い

xtabond2 adjusted_ave_voteshare_inc c.lnsalary_am_kokuji##c.lnsalary_am_kokuji i.cate_change_salary L1.adjusted_ave_voteshare_inc ln_income_per i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku ln_staff_all compe_rate_adopt age_mean_cand ratio_women_cand_adopt cand_ratio_musyozoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019, gmm(c.lnsalary_am_kokuji##c.lnsalary_am_kokuji i.cate_change_salary L.adjusted_ave_voteshare_inc) ivstyle(i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku compe_rate_adopt age_mean_cand win_ratio_musyozoku_pre ratio_women_cand_adopt cand_ratio_musyozoku expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all) noleveleq twostep robust
*無い

**interact with population

xtabond2 adjusted_ave_voteshare_inc c.lnsalary_am_kokuji##c.ln_population i.cate_change_salary L1.adjusted_ave_voteshare_inc ln_income_per i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku ln_staff_all compe_rate_adopt age_mean_cand ratio_women_cand_adopt cand_ratio_musyozoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019, gmm(c.lnsalary_am_kokuji##c.ln_population  i.cate_change_salary L.adjusted_ave_voteshare_inc) ivstyle(i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku compe_rate_adopt age_mean_cand win_ratio_musyozoku_pre ratio_women_cand_adopt cand_ratio_musyozoku expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all) noleveleq twostep robust
*無い

xtabond2 adjusted_ave_voteshare_inc c.lnsalary_am_kokuji i.cate_change_salary##c.ln_population L1.adjusted_ave_voteshare_inc ln_income_per i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku ln_staff_all compe_rate_adopt age_mean_cand ratio_women_cand_adopt cand_ratio_musyozoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019, gmm(c.lnsalary_am_kokuji i.cate_change_salary##c.ln_population L.adjusted_ave_voteshare_inc) ivstyle(i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku compe_rate_adopt age_mean_cand win_ratio_musyozoku_pre ratio_women_cand_adopt cand_ratio_musyozoku expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all) noleveleq twostep robust
*無い

xtabond2 adjusted_ave_voteshare_inc c.lnsalary_am_kokuji i.cate_change_salary##c.ln_population##c.ln_population L1.adjusted_ave_voteshare_inc ln_income_per i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku ln_staff_all compe_rate_adopt age_mean_cand ratio_women_cand_adopt cand_ratio_musyozoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019, gmm(c.lnsalary_am_kokuji i.cate_change_salary##c.ln_population##c.ln_population L.adjusted_ave_voteshare_inc) ivstyle(i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku compe_rate_adopt age_mean_cand win_ratio_musyozoku_pre ratio_women_cand_adopt cand_ratio_musyozoku expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all) noleveleq twostep robust
*無い

xtabond2 adjusted_ave_voteshare_inc c.lnsalary_am_kokuji##c.ln_population##c.ln_population i.cate_change_salary L1.adjusted_ave_voteshare_inc ln_income_per i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku ln_staff_all compe_rate_adopt age_mean_cand ratio_women_cand_adopt cand_ratio_musyozoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019, gmm(c.lnsalary_am_kokuji##c.ln_population##c.ln_population  i.cate_change_salary L.adjusted_ave_voteshare_inc) ivstyle(i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku compe_rate_adopt age_mean_cand win_ratio_musyozoku_pre ratio_women_cand_adopt cand_ratio_musyozoku expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all) noleveleq twostep robust
**ある,両端でプラス
margins, dydx(lnsalary_am_kokuji) at(ln_population = (6 7 8 9 10 11 12 13 14 15))

xtabond2 adjusted_ave_voteshare_inc c.lnsalary_am_kokuji##i.cate_popu_5per i.cate_change_salary L1.adjusted_ave_voteshare_inc ln_income_per i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku ln_staff_all compe_rate_adopt age_mean_cand ratio_women_cand_adopt cand_ratio_musyozoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019, gmm(c.lnsalary_am_kokuji c.lnsalary_am_kokuji#i.cate_popu_5per i.cate_change_salary L.adjusted_ave_voteshare_inc) ivstyle(i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku compe_rate_adopt age_mean_cand win_ratio_musyozoku_pre ratio_women_cand_adopt cand_ratio_musyozoku expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all) noleveleq twostep robust
margins, dydx(lnsalary_am_kokuji) at(cate_popu_5per = (0 1 2))


**sys GMM
xtabond2 adjusted_ave_voteshare_inc i.cate_change_salary ln_income_per i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku ln_staff_all compe_rate_adopt age_mean_cand ratio_women_cand_adopt cand_ratio_musyozoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019, gmm(i.cate_change_salary) ivstyle(i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku compe_rate_adopt age_mean_cand win_ratio_musyozoku_pre ratio_women_cand_adopt cand_ratio_musyozoku expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all) twostep robust

xtabond2 adjusted_ave_voteshare_inc i.cate_change_salary lnsalary_am_kokuji ln_income_per i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku ln_staff_all compe_rate_adopt age_mean_cand ratio_women_cand_adopt cand_ratio_musyozoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019, gmm(i.cate_change_salary lnsalary_am_kokuji) ivstyle(i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku compe_rate_adopt age_mean_cand win_ratio_musyozoku_pre ratio_women_cand_adopt cand_ratio_musyozoku expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all) twostep robust

xtabond2 adjusted_ave_voteshare_inc lnsalary_am_kokuji ln_income_per i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku ln_staff_all compe_rate_adopt age_mean_cand ratio_women_cand_adopt cand_ratio_musyozoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019, gmm( lnsalary_am_kokuji) ivstyle(i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku compe_rate_adopt age_mean_cand win_ratio_musyozoku_pre ratio_women_cand_adopt cand_ratio_musyozoku expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all) twostep robust

xtabond2 adjusted_ave_voteshare_inc i.cate_change_salary lnsalary_am_kokuji L1.adjusted_ave_voteshare_inc ln_income_per i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku ln_staff_all compe_rate_adopt age_mean_cand ratio_women_cand_adopt cand_ratio_musyozoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019, gmm(i.cate_change_salary lnsalary_am_kokuji L.adjusted_ave_voteshare_inc) ivstyle(i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku compe_rate_adopt age_mean_cand win_ratio_musyozoku_pre ratio_women_cand_adopt cand_ratio_musyozoku expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all) twostep robust

xtabond2 adjusted_ave_voteshare_inc i.cate_change_salary L1.adjusted_ave_voteshare_inc ln_income_per i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku ln_staff_all compe_rate_adopt age_mean_cand ratio_women_cand_adopt cand_ratio_musyozoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019, gmm(i.cate_change_salary L.adjusted_ave_voteshare_inc) ivstyle(i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku compe_rate_adopt age_mean_cand win_ratio_musyozoku_pre ratio_women_cand_adopt cand_ratio_musyozoku expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all) twostep robust

xtabond2 adjusted_ave_voteshare_inc lnsalary_am_kokuji L1.adjusted_ave_voteshare_inc ln_income_per i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku ln_staff_all compe_rate_adopt age_mean_cand ratio_women_cand_adopt cand_ratio_musyozoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019, gmm( lnsalary_am_kokuji L.adjusted_ave_voteshare_inc) ivstyle(i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku compe_rate_adopt age_mean_cand win_ratio_musyozoku_pre ratio_women_cand_adopt cand_ratio_musyozoku expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all) twostep robust

xtabond2 adjusted_ave_voteshare_inc i.cate_change_salary i.cate_change_salary#c.abs_change_salary L1.adjusted_ave_voteshare_inc ln_income_per i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku ln_staff_all compe_rate_adopt age_mean_cand ratio_women_cand_adopt cand_ratio_musyozoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019, gmm(i.cate_change_salary i.cate_change_salary#c.abs_change_salary L.adjusted_ave_voteshare_inc) ivstyle(i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku compe_rate_adopt age_mean_cand win_ratio_musyozoku_pre ratio_women_cand_adopt cand_ratio_musyozoku expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all)  twostep robust

xtabond2 adjusted_ave_voteshare_inc i.cate_change_salary i.cate_change_salary#c.abs_change_salary L1.adjusted_ave_voteshare_inc lnsalary_am_kokuji ln_income_per i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku ln_staff_all compe_rate_adopt age_mean_cand ratio_women_cand_adopt cand_ratio_musyozoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019, gmm(i.cate_change_salary lnsalary_am_kokuji i.cate_change_salary#c.abs_change_salary L.adjusted_ave_voteshare_inc) ivstyle(i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku compe_rate_adopt age_mean_cand win_ratio_musyozoku_pre ratio_women_cand_adopt cand_ratio_musyozoku expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all) twostep robust
**減額幅大きいと、得票率下がる10%

xtabond2 adjusted_ave_voteshare_inc change_salary_am L1.adjusted_ave_voteshare_inc lnsalary_am_kokuji ln_income_per i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku ln_staff_all compe_rate_adopt age_mean_cand ratio_women_cand_adopt cand_ratio_musyozoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019, gmm( change_salary_am L.adjusted_ave_voteshare_inc) ivstyle(i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku compe_rate_adopt age_mean_cand win_ratio_musyozoku_pre ratio_women_cand_adopt cand_ratio_musyozoku expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all) twostep robust
**チェンジ幅上がると、得票率上がる。

** 1207

** 供託金没収ライン

sum ratio_forfeit_deposit

gen forfeit_deposit_happen = .
replace forfeit_deposit_happen = 0 if ratio_forfeit_deposit == 0
replace forfeit_deposit_happen = 1 if ratio_forfeit_deposit > 0
replace forfeit_deposit_happen = . if ratio_forfeit_deposit == .

sum forfeit_deposit_happen

reg forfeit_deposit_happen lnsalary_am_kokuji, vce(cluster pres_pm_codes)
**点推定マイナス

reg forfeit_deposit_happen lnsalary_am_kokuji ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku ln_staff_all win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019, vce(cluster pres_pm_codes)
**点推定マイナス

reg forfeit_deposit_happen lnsalary_am_kokuji ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku ln_staff_all win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 i.pref_id i.muni_type, vce(cluster pres_pm_codes)
**プラス有意; 無い方が良い

logit forfeit_deposit_happen lnsalary_am_kokuji ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku ln_staff_all win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 , vce(cluster pres_pm_codes)
**点推定マイナス

xtreg forfeit_deposit_happen lnsalary_am_kokuji ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku ln_staff_all win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019, fe vce(cluster pres_pm_codes)
*点推定マイナス

xtreg forfeit_deposit_happen lnsalary_am_kokuji ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku ln_staff_all win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 i.nendo, fe vce(cluster pres_pm_codes)
***点推定マイナス

xtlogit forfeit_deposit_happen lnsalary_am_kokuji ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku ln_staff_all win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019, fe 
***点推定マイナス


xtlogit forfeit_deposit_happen lnsalary_am_kokuji ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku ln_staff_all win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 i.nendo, fe 
***点推定マイナス

corr forfeit_deposit_happen compe_rate_adopt

reg forfeit_deposit_happen lnsalary_am_kokuji ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku ln_staff_all win_ratio_musyozoku_pre compe_rate_adopt expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019, vce(cluster pres_pm_codes)
*マイナス有意

xtreg forfeit_deposit_happen lnsalary_am_kokuji ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku ln_staff_all win_ratio_musyozoku_pre compe_rate_adopt age_mean_cand ratio_women_cand_adopt cand_ratio_musyozoku expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 i.nendo, fe vce(cluster pres_pm_codes)
*点推定マイナス


hist forfeit_deposit_happen

xtreg forfeit_deposit_happen lnsalary_am_kokuji ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku ln_staff_all win_ratio_musyozoku_pre compe_rate_adopt age_mean_cand ratio_women_cand_adopt cand_ratio_musyozoku expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 i.nendo, fe vce(cluster pres_pm_codes)
*点推定マイナス 

xtreg forfeit_deposit_happen c.lnsalary_am_kokuji##c.lnsalary_am_kokuji ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku ln_staff_all win_ratio_musyozoku_pre compe_rate_adopt age_mean_cand ratio_women_cand_adopt cand_ratio_musyozoku expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 i.nendo, fe vce(cluster pres_pm_codes)
margins, dydx(lnsalary_am_kokuji) at(lnsalary_am_kokuji = (6.5 7 7.5 8 8.5 9))
margins, at(lnsalary_am_kokuji = (6.5 7 7.5 8 8.5 9))

xtabond2 forfeit_deposit_happen c.lnsalary_am_kokuji ln_population ln_income_per i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku ln_staff_all compe_rate_adopt age_mean_cand ratio_women_cand_adopt cand_ratio_musyozoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019, gmm(c.lnsalary_am_kokuji) ivstyle(i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku compe_rate_adopt age_mean_cand win_ratio_musyozoku_pre ratio_women_cand_adopt cand_ratio_musyozoku expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all) noleveleq robust

xtabond2 forfeit_deposit_happen c.lnsalary_am_kokuji##c.lnsalary_am_kokuji ln_population ln_income_per i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku ln_staff_all compe_rate_adopt age_mean_cand ratio_women_cand_adopt cand_ratio_musyozoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019, gmm(c.lnsalary_am_kokuji c.lnsalary_am_kokuji#c.lnsalary_am_kokuji) ivstyle(i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku compe_rate_adopt age_mean_cand win_ratio_musyozoku_pre ratio_women_cand_adopt cand_ratio_musyozoku expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all) noleveleq robust
margins, dydx(lnsalary_am_kokuji) at(lnsalary_am_kokuji = (6.5 7 7.5 8 8.5 9))
margins, at(lnsalary_am_kokuji = (6.5 7 7.5 8 8.5 9))

xtabond2 forfeit_deposit_happen c.lnsalary_am_kokuji ln_population ln_income_per i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku ln_staff_all compe_rate_adopt age_mean_cand ratio_women_cand_adopt cand_ratio_musyozoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019, gmm(c.lnsalary_am_kokuji) ivstyle(i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku compe_rate_adopt age_mean_cand win_ratio_musyozoku_pre ratio_women_cand_adopt cand_ratio_musyozoku expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all) nolevel robust

drop forfeit_xb
predict forfeit_xb, xb
hist forfeit_xb

xtabond2 forfeit_deposit_happen c.lnsalary_am_kokuji L1.forfeit_deposit_happen ln_population ln_income_per i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku ln_staff_all compe_rate_adopt age_mean_cand ratio_women_cand_adopt cand_ratio_musyozoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019, gmm(c.lnsalary_am_kokuji L.forfeit_deposit_happen) ivstyle(i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku compe_rate_adopt age_mean_cand win_ratio_musyozoku_pre ratio_women_cand_adopt cand_ratio_musyozoku expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all) noleveleq robust twostep

xtabond2 forfeit_deposit_happen c.lnsalary_am_kokuji##c.ln_population L1.forfeit_deposit_happen ln_income_per i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku ln_staff_all compe_rate_adopt age_mean_cand ratio_women_cand_adopt cand_ratio_musyozoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019, gmm(c.lnsalary_am_kokuji c.lnsalary_am_kokuji#c.ln_population L.forfeit_deposit_happen) ivstyle(i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku compe_rate_adopt age_mean_cand win_ratio_musyozoku_pre ratio_women_cand_adopt cand_ratio_musyozoku expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all) noleveleq robust

margins, dydx(lnsalary_am_kokuji) at(ln_population = (6 7 8 9 10 11 12 13 14 15))

drop forfeit_xb
predict forfeit_xb, xb
hist forfeit_xb
corr forfeit_deposit_happen forfeit_xb

xtabond2 forfeit_deposit_happen c.lnsalary_am_kokuji##c.lnsalary_am_kokuji L1.forfeit_deposit_happen ln_income_per i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku ln_staff_all compe_rate_adopt age_mean_cand ratio_women_cand_adopt cand_ratio_musyozoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019, gmm(c.lnsalary_am_kokuji c.lnsalary_am_kokuji#c.lnsalary_am_kokuji L.forfeit_deposit_happen) ivstyle(i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku compe_rate_adopt age_mean_cand win_ratio_musyozoku_pre ratio_women_cand_adopt cand_ratio_musyozoku expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all) noleveleq robust
return list

margins, dydx(lnsalary_am_kokuji) at(lnsalary_am_kokuji = (6.5 7 7.5 8 8.5 9))
margins, at(lnsalary_am_kokuji = (6.5 7 7.5 8 8.5 9))



**System GMM
xtabond2 forfeit_deposit_happen c.lnsalary_am_kokuji ln_population ln_income_per i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku ln_staff_all compe_rate_adopt age_mean_cand ratio_women_cand_adopt cand_ratio_musyozoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019, gmm(c.lnsalary_am_kokuji) ivstyle(i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku compe_rate_adopt age_mean_cand win_ratio_musyozoku_pre ratio_women_cand_adopt cand_ratio_musyozoku expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all) robust
margins, dydx(lnsalary_am_kokuji) at(lnsalary_am_kokuji = (6.5 7 7.5 8 8.5 9))
margins, at(lnsalary_am_kokuji = (6.5 7 7.5 8 8.5 9))

xtabond2 forfeit_deposit_happen c.lnsalary_am_kokuji##c.lnsalary_am_kokuji ln_population ln_income_per i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku ln_staff_all compe_rate_adopt age_mean_cand ratio_women_cand_adopt cand_ratio_musyozoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019, gmm(c.lnsalary_am_kokuji c.lnsalary_am_kokuji#c.lnsalary_am_kokuji) ivstyle(i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku compe_rate_adopt age_mean_cand win_ratio_musyozoku_pre ratio_women_cand_adopt cand_ratio_musyozoku expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all) robust
margins, dydx(lnsalary_am_kokuji) at(lnsalary_am_kokuji = (6.5 7 7.5 8 8.5 9))
margins, at(lnsalary_am_kokuji = (6.5 7 7.5 8 8.5 9))

xtabond2 forfeit_deposit_happen c.lnsalary_am_kokuji##c.lnsalary_am_kokuji ln_population ln_income_per i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku ln_staff_all compe_rate_adopt age_mean_cand ratio_women_cand_adopt cand_ratio_musyozoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019, gmm(c.lnsalary_am_kokuji c.lnsalary_am_kokuji#c.lnsalary_am_kokuji) ivstyle(i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku compe_rate_adopt age_mean_cand win_ratio_musyozoku_pre ratio_women_cand_adopt cand_ratio_musyozoku expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all) robust
margins, dydx(lnsalary_am_kokuji) at(lnsalary_am_kokuji = (6.5 7 7.5 8 8.5 9))
margins, at(lnsalary_am_kokuji = (6.5 7 7.5 8 8.5 9))

xtabond2 forfeit_deposit_happen c.lnsalary_am_kokuji##c.lnsalary_am_kokuji ln_population ln_income_per i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku ln_staff_all compe_rate_adopt age_mean_cand ratio_women_cand_adopt cand_ratio_musyozoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019, gmm(c.lnsalary_am_kokuji c.lnsalary_am_kokuji#c.lnsalary_am_kokuji) ivstyle(i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku compe_rate_adopt age_mean_cand win_ratio_musyozoku_pre ratio_women_cand_adopt cand_ratio_musyozoku expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all) robust
margins, dydx(lnsalary_am_kokuji) at(lnsalary_am_kokuji = (6.5 7 7.5 8 8.5 9))
margins, at(lnsalary_am_kokuji = (6.5 7 7.5 8 8.5 9))

xtabond2 forfeit_deposit_happen c.lnsalary_am_kokuji##c.ln_population ln_income_per i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku ln_staff_all compe_rate_adopt age_mean_cand ratio_women_cand_adopt cand_ratio_musyozoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019, gmm(c.lnsalary_am_kokuji c.lnsalary_am_kokuji#c.lnsalary_am_kokuji) ivstyle(i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku compe_rate_adopt age_mean_cand win_ratio_musyozoku_pre ratio_women_cand_adopt cand_ratio_musyozoku expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all) robust
margins, dydx(lnsalary_am_kokuji) at(lnsalary_am_kokuji = (6.5 7 7.5 8 8.5 9))
margins, at(lnsalary_am_kokuji = (6.5 7 7.5 8 8.5 9))

*** result 普通
estimates clear

reg forfeit_deposit_happen lnsalary_am_kokuji, vce(cluster pres_pm_codes)
estimates store r1, title("OLS")
estadd local municipality "No": r1
estadd local year "No": r1

reg forfeit_deposit_happen lnsalary_am_kokuji c.ln_population ln_income_per i.nendo n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku ln_staff_all compe_rate_adopt age_mean_cand ratio_women_cand_adopt cand_ratio_musyozoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019, vce(cluster pres_pm_codes)
estimates store r2, title("OLS")
estadd local municipality "No": r2
estadd local year "No": r2

xtreg forfeit_deposit_happen lnsalary_am_kokuji, fe vce(cluster pres_pm_codes)
estimates store r3, title("FE")
estadd local municipality "Yes": r3
estadd local year "Yes": r3

xtreg forfeit_deposit_happen lnsalary_am_kokuji c.ln_population ln_income_per i.nendo n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku ln_staff_all compe_rate_adopt age_mean_cand ratio_women_cand_adopt cand_ratio_musyozoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019, fe vce(cluster pres_pm_codes)
estimates store r4, title("FE")
estadd local municipality "Yes": r4
estadd local year "Yes": r4


xtabond2 forfeit_deposit_happen c.lnsalary_am_kokuji L1.forfeit_deposit_happen ln_income_per i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku ln_staff_all compe_rate_adopt age_mean_cand ratio_women_cand_adopt cand_ratio_musyozoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019, gmm(c.lnsalary_am_kokuji L.forfeit_deposit_happen) ivstyle(i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku compe_rate_adopt age_mean_cand win_ratio_musyozoku_pre ratio_women_cand_adopt cand_ratio_musyozoku expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all) noleveleq twostep robust
estimates store r5, title("diff GMM")
estadd local municipality "Yes": r5
estadd local year "Yes": r5


xtabond2 forfeit_deposit_happen c.lnsalary_am_kokuji L1.forfeit_deposit_happen ln_income_per i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku ln_staff_all compe_rate_adopt age_mean_cand ratio_women_cand_adopt cand_ratio_musyozoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019, gmm(c.lnsalary_am_kokuji L.forfeit_deposit_happen) ivstyle(i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku compe_rate_adopt age_mean_cand win_ratio_musyozoku_pre ratio_women_cand_adopt cand_ratio_musyozoku expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all) twostep robust
estimates store r6, title("sys GMM")
estadd local municipality "Yes": r6
estadd local year "Yes": r6



esttab r1 r2 r3 r4 r5 r6 using "forfeit_deposit.tex", replace ///
b(3) se(3) star(* 0.10 ** 0.05 *** 0.01) booktabs ///
drop(touitsu_2007 _cons *.nendo) nogaps ///
stats(year municipality N, fmt(%9.0f %9.0f %9.0f) labels("年度固定効果" "自治体固定効果" "観測数")) ///
label nolz varwidth(16) modelwidth(13) style(tex)  ///
title(被説明変数: 供託金没収ライン未到達者の有無) coeflabels(lnsalary_am_kokuji "対数議員報酬額" L.forfeit_deposit_happen "供託金没収ライン未到達者の有無_1期ラグ" /// 
ln_population "対数人口" n_seats_adopt "議席数" population_elderly75_ratio "全人口に占める75歳以上の割合" population_child15_ratio "全人口に占める15歳未満の割合" ///
ln_income_per "納税者1人あたり課税対象所得" ln_all_menseki "対数面積" canlive_ratio_menseki "可住地面積割合" sigaika_ratio_area "市街化区域面積割合" ln_zaiseiryoku ///
"対数財政力指数" win_ratio_musyozoku_pre "前回当選者に占める無所属の割合" ln_staff_all "対数自治体職員数" ///
age_mean_cand "立候補者平均年齢" cand_ratio_musyozoku "立候補者無所属割合"ratio_women_cand_adopt "立候補者女性割合" compe_rate_adopt "1議席あたり立候補者数" touitsu_2011 "2011年統一選ダミー" touitsu_2015 "2015年統一選ダミー" touitsu_2019 "2019年統一選ダミー" expired_dummy "任期満了ダミー") ///
order(lnsalary_am_kokuji L.forfeit_deposit_happen) ///
mlabels(, span prefix(\multicolumn{@span}{c}{) suffix(})) ///
prehead("\documentclass[11pt]{jsarticle}" "\pagestyle{empty}" "\usepackage{booktabs}""\usepackage{siunitx}""\usepackage{lscape}" ///
"\usepackage[margin=20truemm]{geometry}""\sisetup{input-symbols = ()}""\begin{document}""\begin{table}\caption{@title}" ///
"\def\sym#1{\ifmmode^{#1}\else\(^{#1}\)\fi}""\begin{center}" ///
"\sisetup{table-space-text-post = \sym{***}}""\begin{tabular}{l*{@M}{llll}}""\toprule") posthead(\midrule) prefoot(\midrule) ///
postfoot("\bottomrule""\end{tabular}""\end{center}""\end{table}""\end{document}")


xtabond2 compe_rate_adopt c.lnsalary_am_kokuji L1.compe_rate_adopt ln_income_per i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku ln_staff_all win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019, gmm(c.lnsalary_am_kokuji c.lnsalary_am_kokuji#c.lnsalary_am_kokuji L.compe_rate_adopt) ivstyle(i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku  win_ratio_musyozoku_pre  expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all) noleveleq twostep robust

xtabond2 compe_rate_adopt c.lnsalary_am_kokuji L1.compe_rate_adopt ln_income_per i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku ln_staff_all win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ele_t, gmm(c.lnsalary_am_kokuji c.lnsalary_am_kokuji#c.lnsalary_am_kokuji L.compe_rate_adopt) ivstyle(i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku  win_ratio_musyozoku_pre  expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ele_t) noleveleq twostep robust
margins, at(lnsalary_am_kokuji = (6.5 7 7.5 8 8.5 9))

*** result squared
estimates clear

reg forfeit_deposit_happen c.lnsalary_am_kokuji##c.lnsalary_am_kokuji c.ln_population ln_income_per i.nendo n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku ln_staff_all compe_rate_adopt age_mean_cand ratio_women_cand_adopt cand_ratio_musyozoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019, vce(cluster pres_pm_codes)
estimates store r1, title("OLS")
estadd local municipality "No": r1
estadd local year "No": r1

xtreg forfeit_deposit_happen c.lnsalary_am_kokuji##c.lnsalary_am_kokuji c.ln_population ln_income_per i.nendo n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku ln_staff_all compe_rate_adopt age_mean_cand ratio_women_cand_adopt cand_ratio_musyozoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019, fe vce(cluster pres_pm_codes)
estimates store r2, title("FE")
estadd local municipality "Yes": r2
estadd local year "Yes": r2

xtabond2 forfeit_deposit_happen c.lnsalary_am_kokuji##c.lnsalary_am_kokuji L1.forfeit_deposit_happen ln_income_per i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku ln_staff_all compe_rate_adopt age_mean_cand ratio_women_cand_adopt cand_ratio_musyozoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019, gmm(c.lnsalary_am_kokuji c.lnsalary_am_kokuji#c.lnsalary_am_kokuji L.forfeit_deposit_happen) ivstyle(i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku compe_rate_adopt age_mean_cand win_ratio_musyozoku_pre ratio_women_cand_adopt cand_ratio_musyozoku expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all) noleveleq twostep robust
estimates store r3, title("diff GMM")
estadd local municipality "Yes": r3
estadd local year "Yes": r3


xtabond2 forfeit_deposit_happen c.lnsalary_am_kokuji##c.lnsalary_am_kokuji L1.forfeit_deposit_happen ln_income_per i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku ln_staff_all compe_rate_adopt age_mean_cand ratio_women_cand_adopt cand_ratio_musyozoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019, gmm(c.lnsalary_am_kokuji c.lnsalary_am_kokuji#c.lnsalary_am_kokuji L.forfeit_deposit_happen) ivstyle(i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku compe_rate_adopt age_mean_cand win_ratio_musyozoku_pre ratio_women_cand_adopt cand_ratio_musyozoku expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all) twostep robust
estimates store r4, title("sys GMM")
estadd local municipality "Yes": r4
estadd local year "Yes": r4

xtabond2 forfeit_deposit_happen c.lnsalary_am_kokuji##c.ln_population L1.forfeit_deposit_happen ln_income_per i.nendo n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku ln_staff_all compe_rate_adopt age_mean_cand ratio_women_cand_adopt cand_ratio_musyozoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019, gmm(c.lnsalary_am_kokuji c.lnsalary_am_kokuji#c.ln_population L.forfeit_deposit_happen) ivstyle(i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku compe_rate_adopt age_mean_cand win_ratio_musyozoku_pre ratio_women_cand_adopt cand_ratio_musyozoku expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all) noleveleq twostep robust
estimates store r5, title("diff GMM")
estadd local municipality "Yes": r5
estadd local year "Yes": r5

xtabond2 forfeit_deposit_happen c.lnsalary_am_kokuji##c.ln_population L1.forfeit_deposit_happen ln_income_per i.nendo n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku ln_staff_all compe_rate_adopt age_mean_cand ratio_women_cand_adopt cand_ratio_musyozoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019, gmm(c.lnsalary_am_kokuji c.lnsalary_am_kokuji#c.ln_population L.forfeit_deposit_happen) ivstyle(i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku compe_rate_adopt age_mean_cand win_ratio_musyozoku_pre ratio_women_cand_adopt cand_ratio_musyozoku expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all) twostep robust
estimates store r6, title("sys GMM")
estadd local municipality "Yes": r6
estadd local year "Yes": r6



esttab r1 r2 r3 r4 r5 r6 using "forfeit_deposit_squared.tex", replace ///
b(3) se(3) star(* 0.10 ** 0.05 *** 0.01) booktabs ///
drop(touitsu_2007 _cons *.nendo) nogaps ///
stats(year municipality N, fmt(%9.0f %9.0f %9.0f) labels("年度固定効果" "自治体固定効果" "観測数")) ///
label nolz varwidth(16) modelwidth(13) style(tex)  ///
title(被説明変数: 供託金没収ライン未到達者の有無) coeflabels(lnsalary_am_kokuji "対数議員報酬額" c.lnsalary_am_kokuji#c.lnsalary_am_kokuji "対数議員報酬額 2乗" ///
c.lnsalary_am_kokuji#c.ln_population "対数議員報酬額　\times 対数人口" L.forfeit_deposit_happen "供託金没収ライン未到達者の有無_1期ラグ" /// 
ln_population "対数人口" n_seats_adopt "議席数" population_elderly75_ratio "全人口に占める75歳以上の割合" population_child15_ratio "全人口に占める15歳未満の割合" ///
ln_income_per "納税者1人あたり課税対象所得" ln_all_menseki "対数面積" canlive_ratio_menseki "可住地面積割合" sigaika_ratio_area "市街化区域面積割合" ln_zaiseiryoku ///
"対数財政力指数" win_ratio_musyozoku_pre "前回当選者に占める無所属の割合" ln_staff_all "対数自治体職員数" ///
age_mean_cand "立候補者平均年齢" cand_ratio_musyozoku "立候補者無所属割合"ratio_women_cand_adopt "立候補者女性割合" compe_rate_adopt "1議席あたり立候補者数" touitsu_2011 "2011年統一選ダミー" touitsu_2015 "2015年統一選ダミー" touitsu_2019 "2019年統一選ダミー" expired_dummy "任期満了ダミー") ///
order(lnsalary_am_kokuji c.lnsalary_am_kokuji#c.lnsalary_am_kokuji c.lnsalary_am_kokuji#c.ln_population L.forfeit_deposit_happen) ///
mlabels(, span prefix(\multicolumn{@span}{c}{) suffix(})) ///
prehead("\documentclass[11pt]{jsarticle}" "\pagestyle{empty}" "\usepackage{booktabs}""\usepackage{siunitx}""\usepackage{lscape}" ///
"\usepackage[margin=20truemm]{geometry}""\sisetup{input-symbols = ()}""\begin{document}""\begin{table}\caption{@title}" ///
"\def\sym#1{\ifmmode^{#1}\else\(^{#1}\)\fi}""\begin{center}" ///
"\sisetup{table-space-text-post = \sym{***}}""\begin{tabular}{l*{@M}{llll}}""\toprule") posthead(\midrule) prefoot(\midrule) ///
postfoot("\bottomrule""\end{tabular}""\end{center}""\end{table}""\end{document}")













