
gen ln_mean_preftype_1yago = log(mean_sala_preftype_1yago) 
gen ln_mean_prefbigtype_1yago = log(mean_sala_prefbigtype_1yago) 
gen ln_mean_pref_1yago = log(mean_sala_pref_1yago)

encode time_muni_kind, gen(muni_type)
encode pref_type, gen(pref_muni_type)
drop pref_muni_type*
gen ln_salary_staff_all = log(salary_staff_all)

xtset pres_pm_codes ele_t

hist ln_mean_preftype_1yago
hist ln_mean_ruiji_1yago
hist ln_mean_prefbigtype_1yago


estimates clear

regress compe_rate_adopt lnsalary_am_kokuji ln_income_per ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type, vce(cluster pres_pm_codes)
estimates store r1, title("OLS")
estadd local municipality "No": r1
estadd local year "Yes": r1


ivregress 2sls compe_rate_adopt (lnsalary_am_kokuji = ln_mean_prefbigtype_1yago) ln_income_per ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type, vce(cluster pres_pm_codes)
estat first
** 検定おっけ、10%有意
estimates store r2, title("2SLS")
estadd local municipality "No": r2
estadd local year "Yes": r2


**ppml
drop compe_xu_hat
reg lnsalary_am_kokuji ln_mean_prefbigtype_1yago ln_income_per ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type if compe_rate_minus1_adj != ., vce(cluster pres_pm_codes)
test ln_mean_prefbigtype_1yago
predict compe_xu_hat, resid

poisson compe_rate_minus1_adj lnsalary_am_kokuji compe_xu_hat ln_income_per ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type, vce(cluster pres_pm_codes)
** 来た、５％有意
margins, dydx(lnsalary_am_kokuji)
estimates store r3, title("2SRI")
estadd local municipality "No": r3
estadd local year "Yes": r3


drop xt_compe_xu_hat
xtreg lnsalary_am_kokuji ln_mean_prefbigtype_1yago ln_income_per ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo if compe_rate_minus1_adj != ., fe vce(cluster pres_pm_codes)
test ln_mean_prefbigtype_1yago
predict xt_compe_xu_hat, e

xtpoisson compe_rate_minus1_adj lnsalary_am_kokuji xt_compe_xu_hat ln_income_per ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type, fe vce(robust)
** 推定不可

**

ivreg2 compe_rate_adopt (lnsalary_am_kokuji c.lnsalary_am_kokuji#c.ln_population = ln_mean_prefbigtype_1yago c.ln_mean_prefbigtype_1yago#c.ln_population) ln_income_per ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type, cluster(pres_pm_codes)
margins, dydx(lnsalary_am_kokuji) at(ln_population  = (5 (1) 15))
** 検定おっけ、人口多いほど大きくなる

ivreg2 compe_rate_adopt (c.lnsalary_am_kokuji##c.lnsalary_am_kokuji = c.ln_mean_prefbigtype_1yago##c.ln_mean_prefbigtype_1yago) ln_income_per ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type, cluster(pres_pm_codes)
margins, dydx(lnsalary_am_kokuji) at(lnsalary_am_kokuji = (6.5 (0.5) 9.5))
marginsplot
*かぶってる

ivregress 2sls D.compe_rate_adopt (D.lnsalary_am_kokuji = D.ln_mean_prefbigtype_1yago) D.(ln_income_per ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all nendo1-nendo15), nocons vce(cluster pres_pm_codes)
estat first 
*検定アカン

ivregress 2sls D.compe_rate_adopt (D.lnsalary_am_kokuji = L1.ln_mean_prefbigtype_1yago) D.(ln_income_per ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all nendo1-nendo15), vce(cluster pres_pm_codes)
estat first 

xtivreg compe_rate_adopt (lnsalary_am_kokuji = ln_mean_prefbigtype_1yago) ln_income_per ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all , vce(cluster pres_pm_codes)

ivregress 2sls D.compe_rate_adopt (D.lnsalary_am_kokuji = ln_mean_prefbigtype_1yago) D.(ln_income_per ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all nendo1-nendo15), nocons vce(cluster pres_pm_codes)
estat first 
*検定セーフ、有意にならず
estimates store r4, title("FDIV")
estadd local municipality "Yes": r4
estadd local year "Yes": r4

ivregress 2sls D.compe_rate_adopt (D.lnsalary_am_kokuji = L1.ln_mean_prefbigtype_1yago) D.(ln_income_per ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all nendo1-nendo15), nocons vce(cluster pres_pm_codes)
estat first 


xtabond2 compe_rate_adopt lnsalary_am_kokuji i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all, gmm(ln_mean_prefbigtype_1yago) ivstyle(i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all) noleveleq robust twostep
*有意、けど係数大きすぎる
margins, at(lnsalary_am_kokuji = (6.5 (0.5) 9.5))


xtabond2 compe_rate_adopt lnsalary_am_kokuji i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all, gmm(ln_mean_prefbigtype_1yago lnsalary_am_kokuji) ivstyle(i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all) noleveleq robust twostep
*検定アカン


xtabond2 compe_rate_adopt lnsalary_am_kokuji L1.compe_rate_adopt i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all, gmm(ln_mean_prefbigtype_1yago L.compe_rate_adopt) ivstyle(i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all) noleveleq robust twostep


xtabond2 compe_rate_adopt lnsalary_am_kokuji L1.compe_rate_adopt i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all, gmm(ln_mean_prefbigtype_1yago L.compe_rate_adopt) ivstyle(i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all) noleveleq robust twostep
*有意、けど係数大きすぎる
estimates store r5, title("diff GMM")
estadd local municipality "Yes": r5
estadd local year "Yes": r5

xtabond2 compe_rate_adopt lnsalary_am_kokuji L1.compe_rate_adopt i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all, gmm(lnsalary_am_kokuji ln_mean_prefbigtype_1yago L.compe_rate_adopt) ivstyle(i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all) noleveleq robust twostep
**有意ならず

xtabond2 compe_rate_adopt lnsalary_am_kokuji L1.compe_rate_adopt i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all, gmm(ln_mean_prefbigtype_1yago L.compe_rate_adopt) ivstyle(i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all) robust twostep
*10有意、けど係数大きすぎる
estimates store r6, title("sys GMM")
estadd local municipality "Yes": r6
estadd local year "Yes": r6

xtabond2 compe_rate_adopt lnsalary_am_kokuji L1.compe_rate_adopt i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all, gmm(lnsalary_am_kokuji ln_mean_prefbigtype_1yago L.compe_rate_adopt) ivstyle(i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all) robust twostep
**有意ならず


xtabond2 compe_rate_adopt c.lnsalary_am_kokuji##c.lnsalary_am_kokuji L1.compe_rate_adopt i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all, gmm(c.ln_mean_prefbigtype_1yago##c.ln_mean_prefbigtype_1yago L.compe_rate_adopt) ivstyle(i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all) noleveleq robust twostep


ivregress 2sls compe_rate_adopt (ln_salary_am_kokuji = ln_mean_prefbigtype_1yago) ln_income_per ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all i.nendo i.pref_muni_type, vce(cluster pres_pm_codes)
estat first
** 検定おっけ、有意ならず

ivregress 2sls compe_rate_adopt (ln_salary_am_kokuji = ln_mean_prefbigtype_1yago) ln_income_per c.ln_population##c.ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type, vce(cluster pres_pm_codes)
estat first
** 検定おっけ、10%有意

ivregress 2sls compe_rate_adopt (ln_salary_am_kokuji = ln_mean_prefbigtype_1yago) ln_income_per c.ln_population c.ln_population#i.pref_id n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type, vce(cluster pres_pm_codes)
estat first
** 検定ぎり、有意ならず

ivreg2 compe_rate_adopt (c.ln_salary_am_kokuji##c.ln_salary_am_kokuji = c.ln_mean_prefbigtype_1yago##c.ln_mean_prefbigtype_1yago ) ln_income_per c.ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type, cluster(pres_pm_codes)
margins, dydx(ln_salary_am_kokuji) at(ln_salary_am_kokuji = (6.5 (0.5) 9.5))
marginsplot
** 検定おっけ、有意ならず

ivregress 2sls compe_rate_adopt (ln_salary_am_kokuji = ln_mean_preftype_1yago) ln_income_per ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type, vce(cluster pres_pm_codes)
estat first
** 検定おっけ、有意ならず

ivregress 2sls compe_rate_adopt (ln_salary_am_kokuji = ln_mean_pref_1yago) ln_income_per ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type, vce(cluster pres_pm_codes)
estat first
** 検定おっけ、有意ならず


esttab r1 r2 r3 r4 r5 r6 using "compe_iv_1213.tex", replace ///
b(3) se(3) star(* 0.10 ** 0.05 *** 0.01) booktabs ///
drop(touitsu_2007 *.nendo _cons i.pref_id i.muni_type) nogaps ///
stats(year municipality N, fmt(%9.0f %9.0f %9.0f) labels("年度固定効果" "自治体固定効果" "観測数")) ///
label nolz varwidth(16) modelwidth(13) style(tex)  ///
title(被説明変数: 1議席あたり立候補人数) coeflabels(lnsalary_am_kokuji "対数議員報酬額" compe_xu_hat "第1段階残差" ///
ln_population "対数人口" n_seats_adopt "議席数" L1.compe_rate_adopt "1議席あたり立候補人数_1期ラグ" ///
population_elderly75_ratio "全人口に占める75歳以上の割合" population_child15_ratio "全人口に占める15歳未満の割合" ln_income_per "納税者1人あたり課税対象所得" ///
ln_all_menseki "対数面積" canlive_ratio_menseki "可住地面積割合" sigaika_ratio_area "市街化区域面積割合" ln_zaiseiryoku ///
"対数財政力指数" win_ratio_musyozoku_pre "前回当選者に占める無所属の割合" ln_staff_all "対数自治体職員数" expired_dummy ///
"任期満了ダミー"  touitsu_2011 "2011年統一選ダミー" touitsu_2015 "2015年統一選ダミー" touitsu_2019 "2019年統一選ダミー" ln_salary_staff_all "対数職員平均給与") ///
order(lnsalary_am_kokuji L1.compe_rate_adopt　compe_xu_hat) ///
mlabels(, span prefix(\multicolumn{@span}{c}{) suffix(})) ///
prehead("\documentclass[10pt]{jsarticle}" "\pagestyle{empty}" "\usepackage{booktabs}""\usepackage{siunitx}""\usepackage{lscape}" ///
"\usepackage[margin=20truemm]{geometry}""\sisetup{input-symbols = ()}""\begin{document}""\begin{table}\caption{@title}" ///
"\def\sym#1{\ifmmode^{#1}\else\(^{#1}\)\fi}""\begin{center}" ///
"\sisetup{table-space-text-post = \sym{***}}""\begin{tabular}{l*{@M}{llll}}""\toprule") posthead(\midrule) prefoot(\midrule) ///
postfoot("\bottomrule""\end{tabular}""\end{center}""\end{table}""\end{document}")

**ratio_women_compe

estimates clear

regress ratio_women_cand_adopt ln_salary_am_kokuji ln_income_per ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type, vce(cluster pres_pm_codes)
estimates store r1, title("OLS")
estadd local municipality "No": r1
estadd local year "Yes": r1


ivregress 2sls ratio_women_cand_adopt (ln_salary_am_kokuji = ln_mean_prefbigtype_1yago) ln_income_per ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type, vce(cluster pres_pm_codes)
estat first
estimates store r2, title("2SLS")
estadd local municipality "No": r2
estadd local year "Yes": r2
** 検定おっけ、有意ならず

**ppml
drop wom_xu_hat
reg lnsalary_am_kokuji ln_mean_prefbigtype_1yago ln_income_per ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type if ratio_women_cand_adopt != ., vce(cluster pres_pm_codes)
test ln_mean_prefbigtype_1yago
predict wom_xu_hat, resid

glm ratio_women_cand_adopt lnsalary_am_kokuji wom_xu_hat ln_income_per ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type, fa(bin) link(probit) cluster(pres_pm_codes)
estimates store r3, title("2SRIf")
estadd local municipality "No": r3
estadd local year "Yes": r3
** ない

**


ivregress 2sls ratio_women_cand_adopt (ln_salary_am_kokuji = ln_mean_prefbigtype_1yago) ln_income_per c.ln_population##c.ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type, vce(cluster pres_pm_codes)
estat first
** 検定おっけ、有意ならず

ivreg2 ratio_women_cand_adopt (ln_salary_am_kokuji c.ln_salary_am_kokuji#c.ln_population = ln_mean_prefbigtype_1yago c.ln_mean_prefbigtype_1yago#c.ln_population) ln_income_per ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type, cluster(pres_pm_codes)
margins, dydx(ln_salary_am_kokuji) at(ln_population  = (5 (1) 15))
marginsplot
** 検定おっけ、有意ならず

ivreg2 ratio_women_cand_adopt (c.ln_salary_am_kokuji##c.ln_salary_am_kokuji = c.ln_mean_prefbigtype_1yago##c.ln_mean_prefbigtype_1yago) ln_income_per ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type, cluster(pres_pm_codes)
margins, dydx(ln_salary_am_kokuji) at(ln_salary_am_kokuji = (6.5 (0.5) 9.5))
** 検定おっけ、有意ならず

ivregress 2sls D.ratio_women_cand_adopt (D.ln_salary_am_kokuji = ln_mean_prefbigtype_1yago) D.(ln_income_per ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all nendo1-nendo15), nocons vce(cluster pres_pm_codes)
estat first
estimates store r4, title("FDIV")
estadd local municipality "Yes": r4
estadd local year "Yes": r4
** 検定おっけ、有意ならず 

ivreg2 D.ratio_women_cand_adopt (D.ln_salary_am_kokuji D.c.ln_salary_am_kokuji##D.c.ln_salary_am_kokuji = c.ln_mean_prefbigtype_1yago##c.ln_mean_prefbigtype_1yago) D.(ln_income_per ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all nendo1-nendo15), nocons cluster(pres_pm_codes)
estat first
** 検定アカン

xtabond2 ratio_women_cand_adopt lnsalary_am_kokuji i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all, gmm(ln_mean_prefbigtype_1yago) ivstyle(i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all) noleveleq robust twostep
*有意ならず

xtabond2 ratio_women_cand_adopt lnsalary_am_kokuji L1.ratio_women_cand_adopt i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all, gmm(ln_mean_prefbigtype_1yago L.ratio_women_cand_adopt) ivstyle(i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all) noleveleq robust twostep
estimates store r5, title("diff GMM")
estadd local municipality "Yes": r5
estadd local year "Yes": r5
*有意ならず

xtabond2 ratio_women_cand_adopt lnsalary_am_kokuji L1.ratio_women_cand_adopt i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all, gmm(ln_mean_prefbigtype_1yago L.ratio_women_cand_adopt) ivstyle(i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all) robust twostep
*マイナス10%有意
estimates store r6, title("sys GMM")
estadd local municipality "Yes": r6
estadd local year "Yes": r6

xtabond2 ratio_women_cand_adopt c.lnsalary_am_kokuji##c.lnsalary_am_kokuji L1.ratio_women_cand_adopt i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all, gmm(c.ln_mean_prefbigtype_1yago##c.ln_mean_prefbigtype_1yago L.ratio_women_cand_adopt) ivstyle(i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all) noleveleq robust twostep
*有意ならず

xtabond2 ratio_women_cand_adopt c.lnsalary_am_kokuji##c.lnsalary_am_kokuji L1.ratio_women_cand_adopt i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all, gmm(c.ln_mean_prefbigtype_1yago##c.ln_mean_prefbigtype_1yago L.ratio_women_cand_adopt) ivstyle(i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all) robust twostep
*有意ならず



esttab r1 r2 r3 r4 r5 r6 using "women_iv_1213.tex", replace ///
b(3) se(3) star(* 0.10 ** 0.05 *** 0.01) booktabs ///
drop(touitsu_2007 *.nendo _cons *.pref_id *.muni_type D.nendo*) nogaps ///
stats(year municipality N, fmt(%9.0f %9.0f %9.0f) labels("年度固定効果" "自治体固定効果" "観測数")) ///
label nolz varwidth(16) modelwidth(13) style(tex)  ///
title(被説明変数: 1議席あたり立候補人数) coeflabels(lnsalary_am_kokuji "対数議員報酬額" wom_xu_hat "第1段階残差" ///
ln_population "対数人口" n_seats_adopt "議席数" L1.compe_rate_adopt "1議席あたり立候補人数 1期ラグ" ///
population_elderly75_ratio "全人口に占める75歳以上の割合" population_child15_ratio "全人口に占める15歳未満の割合" ln_income_per "納税者1人あたり課税対象所得" ///
ln_all_menseki "対数面積" canlive_ratio_menseki "可住地面積割合" sigaika_ratio_area "市街化区域面積割合" ln_zaiseiryoku ///
"対数財政力指数" win_ratio_musyozoku_pre "前回当選者に占める無所属の割合" ln_staff_all "対数自治体職員数" expired_dummy ///
"任期満了ダミー"  touitsu_2011 "2011年統一選ダミー" touitsu_2015 "2015年統一選ダミー" touitsu_2019 "2019年統一選ダミー" ln_salary_staff_all "対数職員平均給与" ///
D.lnsalary_am_kokuji "対数議員報酬額" ///
LD.compe_rate_adopt "1議席あたり立候補人数 1期ラグ" D.ln_population "対数人口" D.n_seats_adopt "議席数" ///
D.population_elderly75_ratio "全人口に占める75歳以上の割合" D.population_child15_ratio "全人口に占める15歳未満の割合" D.ln_income_per "納税者1人あたり課税対象所得" ///
D.ln_all_menseki "対数面積" D.canlive_ratio_menseki "可住地面積割合" D.sigaika_ratio_area "市街化区域面積割合" D.ln_zaiseiryoku ///
"対数財政力指数" D.win_ratio_musyozoku_pre "前回当選者に占める無所属の割合" D.ln_staff_all "対数自治体職員数" D.expired_dummy ///
"任期満了ダミー"  D.touitsu_2011 "2011年統一選ダミー" D.touitsu_2015 "2015年統一選ダミー" D.touitsu_2019 "2019年統一選ダミー" D.ln_salary_staff_all "対数職員平均給与") ///
mlabels(, span prefix(\multicolumn{@span}{c}{) suffix(})) ///
prehead("\documentclass[10pt]{jsarticle}" "\pagestyle{empty}" "\usepackage{booktabs}""\usepackage{siunitx}""\usepackage{lscape}" ///
"\usepackage[margin=20truemm]{geometry}""\sisetup{input-symbols = ()}""\begin{document}""\begin{table}\caption{@title}" ///
"\def\sym#1{\ifmmode^{#1}\else\(^{#1}\)\fi}""\begin{center}" ///
"\sisetup{table-space-text-post = \sym{***}}""\begin{tabular}{l*{@M}{llll}}""\toprule") posthead(\midrule) prefoot(\midrule) ///
postfoot("\bottomrule""\end{tabular}""\end{center}""\end{table}""\end{document}")


**age_mean_cand
estimates clear

regress age_mean_cand ln_salary_am_kokuji ln_income_per ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type, vce(cluster pres_pm_codes)
estimates store r1, title("OLS")
estadd local municipality "No": r1
estadd local year "Yes": r1

xtreg age_mean_cand ln_salary_am_kokuji ln_income_per ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo, fe vce(cluster pres_pm_codes)

ivregress 2sls age_mean_cand (ln_salary_am_kokuji = ln_mean_prefbigtype_1yago) ln_income_per ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type, vce(cluster pres_pm_codes)
estimates store r2, title("2SLS")
estadd local municipality "No": r2
estadd local year "Yes": r2
estat first
** 検定おっけ、マイナス有意1

ivregress 2sls age_mean_cand (ln_salary_am_kokuji = ln_mean_prefbigtype_1yago) ln_income_per c.ln_population##c.ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type, vce(cluster pres_pm_codes)
estat first
** 検定おっけ、有意

ivreg2 age_mean_cand (ln_salary_am_kokuji c.ln_salary_am_kokuji#c.ln_population = ln_mean_prefbigtype_1yago c.ln_mean_prefbigtype_1yago#c.ln_population) ln_income_per ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type, cluster(pres_pm_codes)
margins, dydx(ln_salary_am_kokuji) at(ln_population  = (5 (1) 15))
marginsplot
** 検定おっけ、人口多いほど効果大きい

ivreg2 age_mean_cand  (c.ln_salary_am_kokuji##c.ln_salary_am_kokuji = c.ln_mean_prefbigtype_1yago##c.ln_mean_prefbigtype_1yago) ln_income_per ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type, cluster(pres_pm_codes)
margins, dydx(ln_salary_am_kokuji) at(ln_salary_am_kokuji = (6.5 (0.5) 9.5))
** 検定おっけ、給料高いと効果大きい

ivregress 2sls D.age_mean_cand (D.ln_salary_am_kokuji = ln_mean_prefbigtype_1yago) D.(ln_income_per ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all nendo1-nendo15), nocons vce(cluster pres_pm_codes)
estat first
** 検定アカン 

ivreg2 D.age_mean_cand (D.ln_salary_am_kokuji D.c.ln_salary_am_kokuji##D.c.ln_salary_am_kokuji = c.ln_mean_prefbigtype_1yago##c.ln_mean_prefbigtype_1yago) D.(ln_income_per ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all nendo1-nendo15), nocons cluster(pres_pm_codes)
estat first
** 検定アカン

xtabond2 age_mean_cand lnsalary_am_kokuji i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all, gmm(ln_mean_prefbigtype_1yago) ivstyle(i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all) noleveleq robust twostep
*プラス有意、報告しない

xtabond2 age_mean_cand lnsalary_am_kokuji L1.age_mean_cand i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all, gmm(ln_mean_prefbigtype_1yago L.age_mean_cand) ivstyle(i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all) noleveleq robust twostep
*有意ならず
estimates store r3, title("diff GMM")
estadd local municipality "Yes": r3
estadd local year "Yes": r3

xtabond2 age_mean_cand lnsalary_am_kokuji L1.age_mean_cand i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all, gmm(ln_mean_prefbigtype_1yago L.age_mean_cand) ivstyle(i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all) robust twostep
*マイナス有意
estimates store r4, title("sys GMM")
estadd local municipality "Yes": r4
estadd local year "Yes": r4

xtabond2 age_mean_cand c.lnsalary_am_kokuji##c.lnsalary_am_kokuji L1.age_mean_cand i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all, gmm(c.ln_mean_prefbigtype_1yago##c.ln_mean_prefbigtype_1yago L.age_mean_cand) ivstyle(i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all) noleveleq robust twostep
*とんでもない数字

xtabond2 age_mean_cand c.lnsalary_am_kokuji##c.lnsalary_am_kokuji L1.compe_rate_adopt i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all, gmm(c.ln_mean_prefbigtype_1yago##c.ln_mean_prefbigtype_1yago L.age_mean_cand) ivstyle(i.nendo ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all) robust twostep
*検定アカン

esttab r1 r2 r3 r4 using "age_iv_1213.tex", replace ///
b(3) se(3) star(* 0.10 ** 0.05 *** 0.01) booktabs ///
drop(touitsu_2007 *.nendo _cons *.pref_id *.muni_type ) nogaps ///
stats(year municipality N, fmt(%9.0f %9.0f %9.0f) labels("年度固定効果" "自治体固定効果" "観測数")) ///
label nolz varwidth(16) modelwidth(13) style(tex)  ///
title(被説明変数: 1議席あたり立候補人数) coeflabels(lnsalary_am_kokuji "対数議員報酬額" wom_xu_hat "第1段階残差" ///
ln_population "対数人口" n_seats_adopt "議席数" L1.compe_rate_adopt "1議席あたり立候補人数 1期ラグ" ///
population_elderly75_ratio "全人口に占める75歳以上の割合" population_child15_ratio "全人口に占める15歳未満の割合" ln_income_per "納税者1人あたり課税対象所得" ///
ln_all_menseki "対数面積" canlive_ratio_menseki "可住地面積割合" sigaika_ratio_area "市街化区域面積割合" ln_zaiseiryoku ///
"対数財政力指数" win_ratio_musyozoku_pre "前回当選者に占める無所属の割合" ln_staff_all "対数自治体職員数" expired_dummy ///
"任期満了ダミー"  touitsu_2011 "2011年統一選ダミー" touitsu_2015 "2015年統一選ダミー" touitsu_2019 "2019年統一選ダミー" ln_salary_staff_all "対数職員平均給与") ///
mlabels(, span prefix(\multicolumn{@span}{c}{) suffix(})) ///
prehead("\documentclass[10pt]{jsarticle}" "\pagestyle{empty}" "\usepackage{booktabs}""\usepackage{siunitx}""\usepackage{lscape}" ///
"\usepackage[margin=20truemm]{geometry}""\sisetup{input-symbols = ()}""\begin{document}""\begin{table}\caption{@title}" ///
"\def\sym#1{\ifmmode^{#1}\else\(^{#1}\)\fi}""\begin{center}" ///
"\sisetup{table-space-text-post = \sym{***}}""\begin{tabular}{l*{@M}{llll}}""\toprule") posthead(\midrule) prefoot(\midrule) ///
postfoot("\bottomrule""\end{tabular}""\end{center}""\end{table}""\end{document}")

**jyorei
estimates clear
regress teian_jyorei_4y lnsalary_am_kokuji ln_income_per ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type, vce(cluster pres_pm_codes)
estimates store r1, title("OLS")
estadd local municipality "No": r1
estadd local year "Yes": r1

poisson teian_jyorei_4y lnsalary_am_kokuji ln_income_per ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type, vce(cluster pres_pm_codes)
estimates store r2, title("PPML")
estadd local municipality "No": r2
estadd local year "Yes": r2

poisson teian_jyorei_4y lnsalary_am_kokuji ln_income_per ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type age_mean_wins ratio_women_wins_adopt win_ratio_musyozoku, vce(cluster pres_pm_codes)
estimates store r3, title("PPML")
estadd local municipality "No": r3
estadd local year "Yes": r3

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

esttab r1 r2 r3 r4 r5 using "jyorei_iv_1213.tex", replace ///
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

ivregress 2sls D.teian_jyorei_4y (D.lnsalary_am_kokuji = ln_mean_ruiji_1yago) D.(ln_income_per ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all nendo1-nendo15) , vce(cluster pres_pm_codes)
estat first
*検定アカン



