**inc up feiv

xtreg adjusted_ave_voteshare_inc dummy_up_salary ln_income_per ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all nendo1-nendo15 ratio_women_cand_adopt age_mean_cand cand_ratio_musyozoku, fe cluster(pres_pm_codes)

xtivreg2 adjusted_ave_voteshare_inc (dummy_up_salary = upratio) ln_income_per ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all nendo1-nendo15 ratio_women_cand_adopt age_mean_cand cand_ratio_musyozoku, fe cluster(pres_pm_codes)
estimates store r1, title("FEIV")


esttab r1 using "feiv_incup.tex", replace ///
b(3) se(3) star(* 0.10 ** 0.05 *** 0.01) booktabs ///
drop(touitsu_2007 nendo* ) nogaps ///
stats(year municipality N, fmt(%9.0f %9.0f %9.0f) labels("年度固定効果" "自治体固定効果" "観測数")) ///
label nolz varwidth(16) modelwidth(13) style(tex)  ///
title(被説明変数: 調整済み現職) coeflabels(lnsalary_am_kokuji "対数議員報酬額" wom_xu_hat "第1段階残差" ///
ln_population "対数人口" n_seats_adopt "議席数" L1.compe_rate_adopt "1議席あたり立候補人数 1期ラグ" ///
population_elderly75_ratio "75歳以上の割合" population_child15_ratio "15歳未満の割合" ln_income_per "課税対象所得" ///
ln_all_menseki "対数面積" canlive_ratio_menseki "可住地面積割合" sigaika_ratio_area "市街化区域面積割合" ln_zaiseiryoku ///
"対数財政力指数" win_ratio_musyozoku_pre "前回当選者無所属" ln_staff_all "対数自治体職員数" expired_dummy ///
"任期満了ダミー"  touitsu_2011 "2011年統一選ダミー" touitsu_2015 "2015年統一選ダミー" touitsu_2019 "2019年統一選ダミー" ln_salary_staff_all "対数職員平均給与" ///
age_mean_wins "当選者平均年齢" ratio_women_wins_adopt "当選者女性割合" win_ratio_musyozoku "当選者無所属割合" ) ///
mlabels(, span prefix(\multicolumn{@span}{c}{) suffix(})) ///
prehead("\documentclass[10pt]{jsarticle}" "\pagestyle{empty}" "\usepackage{booktabs}""\usepackage{siunitx}""\usepackage{lscape}" ///
"\usepackage[margin=20truemm]{geometry}""\sisetup{input-symbols = ()}""\begin{document}""\begin{table}\caption{@title}" ///
"\def\sym#1{\ifmmode^{#1}\else\(^{#1}\)\fi}""\begin{center}" ///
"\sisetup{table-space-text-post = \sym{***}}""\begin{tabular}{l*{@M}{llll}}""\toprule") posthead(\midrule) prefoot(\midrule) ///
postfoot("\bottomrule""\end{tabular}""\end{center}""\end{table}""\end{document}")

xtivreg2 adjusted_ave_voteshare_inc (dummy_down_salary = downratio) ln_income_per ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all nendo1-nendo15 ratio_women_cand_adopt age_mean_cand cand_ratio_musyozoku, fe cluster(pres_pm_codes)
estimates store r2, title("FEIV")


esttab r2 using "feiv_incdown.tex", replace ///
b(3) se(3) star(* 0.10 ** 0.05 *** 0.01) booktabs ///
drop(touitsu_2007 nendo* ) nogaps ///
stats(year municipality N, fmt(%9.0f %9.0f %9.0f) labels("年度固定効果" "自治体固定効果" "観測数")) ///
label nolz varwidth(16) modelwidth(13) style(tex)  ///
title(被説明変数: 調整済み現職) coeflabels(dummy_down_salary "報酬減額ダミー" wom_xu_hat "第1段階残差" ///
ln_population "対数人口" n_seats_adopt "議席数" L1.compe_rate_adopt "1議席あたり立候補人数 1期ラグ" ///
population_elderly75_ratio "75歳以上の割合" population_child15_ratio "15歳未満の割合" ln_income_per "課税対象所得" ///
ln_all_menseki "対数面積" canlive_ratio_menseki "可住地面積割合" sigaika_ratio_area "市街化区域面積割合" ln_zaiseiryoku ///
"対数財政力指数" win_ratio_musyozoku_pre "前回当選者無所属" ln_staff_all "対数自治体職員数" expired_dummy ///
"任期満了ダミー"  touitsu_2011 "2011年統一選ダミー" touitsu_2015 "2015年統一選ダミー" touitsu_2019 "2019年統一選ダミー" ln_salary_staff_all "対数職員平均給与" ///
age_mean_wins "当選者平均年齢" ratio_women_wins_adopt "当選者女性割合" win_ratio_musyozoku "当選者無所属割合" ) ///
mlabels(, span prefix(\multicolumn{@span}{c}{) suffix(})) ///
prehead("\documentclass[10pt]{jsarticle}" "\pagestyle{empty}" "\usepackage{booktabs}""\usepackage{siunitx}""\usepackage{lscape}" ///
"\usepackage[margin=20truemm]{geometry}""\sisetup{input-symbols = ()}""\begin{document}""\begin{table}\caption{@title}" ///
"\def\sym#1{\ifmmode^{#1}\else\(^{#1}\)\fi}""\begin{center}" ///
"\sisetup{table-space-text-post = \sym{***}}""\begin{tabular}{l*{@M}{llll}}""\toprule") posthead(\midrule) prefoot(\midrule) ///
postfoot("\bottomrule""\end{tabular}""\end{center}""\end{table}""\end{document}")



xtivreg  voting_rate_p (dummy_up_salary = upratio) ln_income_per ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo compe_rate_adopt ratio_women_cand_adopt age_mean_cand cand_ratio_musyozoku, fe vce(cluster pres_pm_codes)

xtivreg2 voting_rate_p (dummy_up_salary = upratio) ln_income_per ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo compe_rate_adopt ratio_women_cand_adopt age_mean_cand cand_ratio_musyozoku, fe vce(cluster pres_pm_codes)

xtivreg2 voting_rate_p (dummy_up_salary = upratio) ln_income_per ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all nendo1-nendo15 compe_rate_adopt ratio_women_cand_adopt age_mean_cand cand_ratio_musyozoku, fe cluster(pres_pm_codes)
estimates store r3, title("FEIV")

esttab r3 using "feiv_votup.tex", replace ///
b(3) se(3) star(* 0.10 ** 0.05 *** 0.01) booktabs ///
drop(touitsu_2007 nendo* ) nogaps ///
stats(year municipality N, fmt(%9.0f %9.0f %9.0f) labels("年度固定効果" "自治体固定効果" "観測数")) ///
label nolz varwidth(16) modelwidth(13) style(tex)  ///
title(被説明変数: 調整済み現職) coeflabels(dummy_up_salary "報酬増額ダミー" ///
ln_population "対数人口" n_seats_adopt "議席数" L1.compe_rate_adopt "1議席あたり立候補人数 1期ラグ" ///
population_elderly75_ratio "75歳以上の割合" population_child15_ratio "15歳未満の割合" ln_income_per "課税対象所得" ///
ln_all_menseki "対数面積" canlive_ratio_menseki "可住地面積割合" sigaika_ratio_area "市街化区域面積割合" ln_zaiseiryoku ///
"対数財政力指数" win_ratio_musyozoku_pre "前回当選者無所属" ln_staff_all "対数自治体職員数" expired_dummy ///
"任期満了ダミー"  touitsu_2011 "2011年統一選ダミー" touitsu_2015 "2015年統一選ダミー" touitsu_2019 "2019年統一選ダミー" ln_salary_staff_all "対数職員平均給与" ///
age_mean_cand "立候補者平均年齢" ratio_women_cand_adopt "立候補者女性割合" cand_ratio_musyozoku "立候補者無所属割合" ) ///
mlabels(, span prefix(\multicolumn{@span}{c}{) suffix(})) ///
prehead("\documentclass[10pt]{jsarticle}" "\pagestyle{empty}" "\usepackage{booktabs}""\usepackage{siunitx}""\usepackage{lscape}" ///
"\usepackage[margin=20truemm]{geometry}""\sisetup{input-symbols = ()}""\begin{document}""\begin{table}\caption{@title}" ///
"\def\sym#1{\ifmmode^{#1}\else\(^{#1}\)\fi}""\begin{center}" ///
"\sisetup{table-space-text-post = \sym{***}}""\begin{tabular}{l*{@M}{llll}}""\toprule") posthead(\midrule) prefoot(\midrule) ///
postfoot("\bottomrule""\end{tabular}""\end{center}""\end{table}""\end{document}")

xtivreg2 voting_rate_p (dummy_down_salary = downratio) ln_income_per ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all nendo1-nendo15 compe_rate_adopt ratio_women_cand_adopt age_mean_cand cand_ratio_musyozoku, fe cluster(pres_pm_codes)
estimates store r4, title("FEIV")

esttab r4 using "feiv_votdown.tex", replace ///
b(3) se(3) star(* 0.10 ** 0.05 *** 0.01) booktabs ///
drop(touitsu_2007 nendo* ) nogaps ///
stats(year municipality N, fmt(%9.0f %9.0f %9.0f) labels("年度固定効果" "自治体固定効果" "観測数")) ///
label nolz varwidth(16) modelwidth(13) style(tex)  ///
title(被説明変数: 調整済み現職) coeflabels(dummy_up_salary "報酬増額ダミー" ///
ln_population "対数人口" n_seats_adopt "議席数" L1.compe_rate_adopt "1議席あたり立候補人数 1期ラグ" ///
population_elderly75_ratio "75歳以上の割合" population_child15_ratio "15歳未満の割合" ln_income_per "課税対象所得" ///
ln_all_menseki "対数面積" canlive_ratio_menseki "可住地面積割合" sigaika_ratio_area "市街化区域面積割合" ln_zaiseiryoku ///
"対数財政力指数" win_ratio_musyozoku_pre "前回当選者無所属" ln_staff_all "対数自治体職員数" expired_dummy ///
"任期満了ダミー"  touitsu_2011 "2011年統一選ダミー" touitsu_2015 "2015年統一選ダミー" touitsu_2019 "2019年統一選ダミー" ln_salary_staff_all "対数職員平均給与" ///
age_mean_cand "立候補者平均年齢" ratio_women_cand_adopt "立候補者女性割合" cand_ratio_musyozoku "立候補者無所属割合" ) ///
mlabels(, span prefix(\multicolumn{@span}{c}{) suffix(})) ///
prehead("\documentclass[10pt]{jsarticle}" "\pagestyle{empty}" "\usepackage{booktabs}""\usepackage{siunitx}""\usepackage{lscape}" ///
"\usepackage[margin=20truemm]{geometry}""\sisetup{input-symbols = ()}""\begin{document}""\begin{table}\caption{@title}" ///
"\def\sym#1{\ifmmode^{#1}\else\(^{#1}\)\fi}""\begin{center}" ///
"\sisetup{table-space-text-post = \sym{***}}""\begin{tabular}{l*{@M}{llll}}""\toprule") posthead(\midrule) prefoot(\midrule) ///
postfoot("\bottomrule""\end{tabular}""\end{center}""\end{table}""\end{document}")


** interaction incumbent

ivregress 2sls adjusted_ave_voteshare_inc (dummy_up_salary dummy_up_salary#c.ln_population =  upratio c.upratio#c.ln_population)  ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all nendo1-nendo15 ratio_women_cand_adopt age_mean_cand cand_ratio_musyozoku i.pres_pm_codes, vce(cluster pres_pm_codes)
estimates store r1, title("incup")

xtreg adjusted_ave_voteshare_inc (dummy_up_salary c.dummy_up_salary#c.ln_population c.dummy_up_salary#c.ln_population#c.ln_population = upratio c.upratio#c.ln_population c.upratio#c.ln_population#c.ln_population) c.ln_population##c.ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo  ratio_women_cand_adopt age_mean_cand cand_ratio_musyozoku, fe cluster(pres_pm_codes)
estimates store r2, title("incup")

xtreg adjusted_ave_voteshare_inc dummy_down_salary##c.ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo  ratio_women_cand_adopt age_mean_cand cand_ratio_musyozoku, fe vce(cluster pres_pm_codes)
estimates store r3, title("incdown")

xtreg adjusted_ave_voteshare_inc dummy_down_salary##c.ln_population##c.ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo ratio_women_cand_adopt age_mean_cand cand_ratio_musyozoku, fe vce(cluster pres_pm_codes)
estimates store r4, title("incdown")


esttab r1 r2 r3 r4 using "interaction_inc_feiv.tex", replace ///
b(3) se(3) star(* 0.10 ** 0.05 *** 0.01) booktabs ///
keep(1.dummy_up_salary_am 1.dummy_up_salary_am#c.ln_population 1.dummy_up_salary_am#c.ln_population#c.ln_population ln_population c.ln_population#c.ln_population ///
1.dummy_down_salary_am 1.dummy_down_salary_am#c.ln_population 1.dummy_down_salary_am#c.ln_population#c.ln_population) nogaps ///
stats(N, fmt(%9.0f) labels("観測数")) ///
label nolz varwidth(16) modelwidth(13) style(tex)  ///
title(対数人口との交差項) coeflabels(1.dummy_up_salary_am "増額ダミー" 1.dummy_up_salary_am#c.ln_population "増額ダミー $\times$ 対数人口" ///
1.dummy_up_salary_am#c.ln_population#c.ln_population "増額ダミー $\times$ 対数人口2乗" 1.dummy_down_salary_am "減額ダミー" 1.dummy_down_salary_am#c.ln_population ///
"減額ダミー $\times$ 対数人口"1.dummy_down_salary_am#c.ln_population#c.ln_population "減額ダミー $\times$ 対数人口2乗" ln_population "対数人口" ///
c.ln_population#c.ln_population "対数人口2乗") ///
mlabels(, span prefix(\multicolumn{@span}{c}{) suffix(})) ///
prehead("\sisetup{table-space-text-post = \sym{***}}""\begin{tabular}{l*{@M}{llll}}""\toprule") posthead(\midrule) prefoot(\midrule) ///
postfoot("\bottomrule""\end{tabular}")



