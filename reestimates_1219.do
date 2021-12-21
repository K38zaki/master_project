
**compe_rate
estimates clear
poisson compe_rate_minus1_adj lnsalary_am_kokuji ln_income_per ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type, vce(cluster pres_pm_codes)
eststo compepml: margins, dydx(*) post




**women 
fracreg probit ratio_women_cand_adopt lnsalary_am_kokuji ln_income_per ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type, vce(cluster pres_pm_codes)
eststo wompml: margins, dydx(*) post


esttab compepml wompml


esttab compepml wompml using "pml_compewom_1219.tex", replace ///
b(3) se(3) star(* 0.10 ** 0.05 *** 0.01) booktabs ///
drop(touitsu_2007 *.nendo *.pref_id *.muni_type) nogaps ///
stats(N, fmt(%9.0f) labels("観測数")) ///
label nolz varwidth(16) modelwidth(13) style(tex)  ///
title(被説明変数: ) coeflabels(lnsalary_am_kokuji "対数議員報酬額"  ///
ln_population "対数人口" n_seats_adopt "議席数" ///
population_elderly75_ratio "全人口に占める75歳以上の割合" population_child15_ratio "全人口に占める15歳未満の割合" ln_income_per "納税者1人あたり課税対象所得" ///
ln_all_menseki "対数面積" canlive_ratio_menseki "可住地面積割合" sigaika_ratio_area "市街化区域面積割合" ln_zaiseiryoku ///
"対数財政力指数" win_ratio_musyozoku_pre "前回当選者に占める無所属の割合" ln_staff_all "対数自治体職員数" expired_dummy ///
"任期満了ダミー"  touitsu_2011 "2011年統一選ダミー" touitsu_2015 "2015年統一選ダミー" touitsu_2019 "2019年統一選ダミー" ln_salary_staff_all "対数職員平均給与") ///
mlabels(, span prefix(\multicolumn{@span}{c}{) suffix(})) ///
prehead("\sisetup{table-space-text-post = \sym{***}}""\begin{tabular}{l*{@M}{llll}}""\toprule") posthead(\midrule) prefoot(\midrule) ///
postfoot("\bottomrule""\end{tabular}")

**jyorei; reestimates

estimates clear
regress teian_jyorei_4y lnsalary_am_kokuji ln_income_per ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type, vce(cluster pres_pm_codes)
estimates store r1, title("OLS")

regress teian_jyorei_4y lnsalary_am_kokuji ln_income_per ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type age_mean_wins ratio_women_wins_adopt win_ratio_musyozoku, vce(cluster pres_pm_codes)
estimates store r2, title("OLS")

poisson teian_jyorei_4y lnsalary_am_kokuji ln_income_per ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type, vce(cluster pres_pm_codes)
eststo ppml_not: margins, dydx(lnsalary_am_kokuji ln_income_per ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all) post

poisson teian_jyorei_4y lnsalary_am_kokuji ln_income_per ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type age_mean_wins ratio_women_wins_adopt win_ratio_musyozoku, vce(cluster pres_pm_codes)
eststo ppml_cont: margins, dydx(lnsalary_am_kokuji ln_income_per ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all age_mean_wins ratio_women_wins_adopt win_ratio_musyozoku) post

esttab r1 r2 ppml_not ppml_cont using "jyorei_tab_1219.tex", replace ///
b(3) se(3) star(* 0.10 ** 0.05 *** 0.01) booktabs ///
drop(touitsu_2007 *.nendo _cons *.pref_id *.muni_type ) nogaps ///
stats(year municipality N, fmt(%9.0f %9.0f %9.0f) labels("年度固定効果" "自治体固定効果" "観測数")) ///
label nolz varwidth(16) modelwidth(13) style(tex)  ///
title(被説明変数: 議員提案条例可決数(4年間)) coeflabels(lnsalary_am_kokuji "対数議員報酬額" ///
ln_population "対数人口" n_seats_adopt "議席数" L1.compe_rate_adopt "1議席あたり立候補人数 1期ラグ" ///
population_elderly75_ratio "全人口に占める75歳以上の割合" population_child15_ratio "全人口に占める15歳未満の割合" ln_income_per "納税者1人あたり課税対象所得" ///
ln_all_menseki "対数面積" canlive_ratio_menseki "可住地面積割合" sigaika_ratio_area "市街化区域面積割合" ln_zaiseiryoku ///
"対数財政力指数" win_ratio_musyozoku_pre "前回当選者に占める無所属の割合" ln_staff_all "対数自治体職員数" expired_dummy ///
"任期満了ダミー"  touitsu_2011 "2011年統一選ダミー" touitsu_2015 "2015年統一選ダミー" touitsu_2019 "2019年統一選ダミー" ln_salary_staff_all "対数職員平均給与" ///
age_mean_wins "当選者平均年齢" ratio_women_wins_adopt "当選者女性割合" win_ratio_musyozoku "当選者無所属割合" ) ///
mlabels(, span prefix(\multicolumn{@span}{c}{) suffix(})) ///
prehead("\begin{tabular}{l*{@M}{llll}}""\toprule") posthead(\midrule) prefoot(\midrule) ///
postfoot("\bottomrule""\end{tabular}""\end{center}""\end{table}""\end{document}")


* 2sls
ivregress 2sls teian_jyorei_4y (lnsalary_am_kokuji = ln_mean_ruiji_1yago) ln_income_per ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type, vce(cluster pres_pm_codes)
estat first
**検定おっけ、有意でない


ivreg2 teian_jyorei_4y (c.lnsalary_am_kokuji##c.lnsalary_am_kokuji = c.ln_mean_ruiji_1yago##c.ln_mean_ruiji_1yago) ln_income_per ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type, cluster(pres_pm_codes)
estat first
margins, dydx(lnsalary_am_kokuji) at(lnsalary_am_kokuji = (6.5 (0.5) 9.5))
**検定アカン、有意でない

**ppml
drop jyo_xu_hat
reg lnsalary_am_kokuji ln_mean_prefbigtype_1yago ln_income_per ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type if teian_jyorei_4y != ., vce(cluster pres_pm_codes)
test ln_mean_prefbigtype_1yago
predict jyo_xu_hat_1, resid

reg lnsalary_am_kokuji ln_mean_prefbigtype_1yago ln_income_per ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type age_mean_wins ratio_women_wins_adopt win_ratio_musyozoku if teian_jyorei_4y != ., vce(cluster pres_pm_codes)
test ln_mean_prefbigtype_1yago
predict jyo_xu_hat_2, resid

poisson teian_jyorei_4y lnsalary_am_kokuji jyo_xu_hat_1 ln_income_per ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type, vce(cluster pres_pm_codes)
estimates store r4, title("PPML")
estadd local municipality "No": r4
estadd local year "Yes": r4

poisson teian_jyorei_4y lnsalary_am_kokuji jyo_xu_hat_2 ln_income_per ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type age_mean_wins ratio_women_wins_adopt win_ratio_musyozoku, vce(cluster pres_pm_codes)
estimates store r5, title("PPML")
estadd local municipality "No": r5
estadd local year "Yes": r5

esttab r1 r2 r3 r4 r5 r6 using "jyorei_iv_1213.tex", replace ///
b(3) se(3) star(* 0.10 ** 0.05 *** 0.01) booktabs ///
drop(touitsu_2007 *.nendo _cons *.pref_id *.muni_type ) nogaps ///
stats(year municipality N, fmt(%9.0f %9.0f %9.0f) labels("年度固定効果" "自治体固定効果" "観測数")) ///
label nolz varwidth(16) modelwidth(13) style(tex)  ///
title(被説明変数: 議員提案条例可決数(4年間)) coeflabels(lnsalary_am_kokuji "対数議員報酬額" wom_xu_hat "第1段階残差" ///
ln_population "対数人口" n_seats_adopt "議席数" L1.compe_rate_adopt "1議席あたり立候補人数 1期ラグ" ///
population_elderly75_ratio "全人口に占める75歳以上の割合" population_child15_ratio "全人口に占める15歳未満の割合" ln_income_per "納税者1人あたり課税対象所得" ///
ln_all_menseki "対数面積" canlive_ratio_menseki "可住地面積割合" sigaika_ratio_area "市街化区域面積割合" ln_zaiseiryoku ///
"対数財政力指数" win_ratio_musyozoku_pre "前回当選者に占める無所属の割合" ln_staff_all "対数自治体職員数" expired_dummy ///
"任期満了ダミー"  touitsu_2011 "2011年統一選ダミー" touitsu_2015 "2015年統一選ダミー" touitsu_2019 "2019年統一選ダミー" ln_salary_staff_all "対数職員平均給与" ///
age_mean_wins "当選者平均年齢" ratio_women_wins_adopt "当選者女性割合" win_ratio_musyozoku "当選者無所属割合" ) ///
mlabels(, span prefix(\multicolumn{@span}{c}{) suffix(})) ///
prehead("\documentclass[10pt]{jsarticle}" "\pagestyle{empty}" "\usepackage{booktabs}""\usepackage{siunitx}""\usepackage{lscape}" ///
"\usepackage[margin=20truemm]{geometry}""\sisetup{input-symbols = ()}""\begin{document}""\begin{table}\caption{@title}" ///
"\def\sym#1{\ifmmode^{#1}\else\(^{#1}\)\fi}""\begin{center}" ///
"\sisetup{table-space-text-post = \sym{***}}""\begin{tabular}{l*{@M}{llll}}""\toprule") posthead(\midrule) prefoot(\midrule) ///
postfoot("\bottomrule""\end{tabular}""\end{center}""\end{table}""\end{document}")



