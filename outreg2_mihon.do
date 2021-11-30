
ssc install outreg2
* 最初だけ

**Pooled OLS
reg ratio_women_cand_adopt lnsalary_am_kokuji, vce(cluster pres_pm_codes)

outreg2 using myreg_wo.xls, replace ctitle(OLS) addtext(Municipality FE, No, Nendo FE, No)

* using の後に保存するファイル名(myreg_wo.xls)
* replace は、エクセルを新しく作る　or 完全に作り直す　
*　ctitle() は、モデル名（列名の上に書くモデル名）、今回は OLS
* addtext()　は推定結果以外に表に含めたい文字、今回は　Municipality FE,　Nendo FE という行を追加して、OLSの列に両方とも　No　を入れてる


** Fixed Effect
xtreg ratio_women_cand_adopt lnsalary_am_kokuji i.nendo, fe vce(cluster pres_pm_codes) 

outreg2 using myreg_wo.xls, append ctitle(FE) keep(lnsalary_am_kokuji) addtext(Municipality FE, Yes, Nendo FE, Yes)

* append は、エクセルに新しい列を追加する
* ctitle() は、モデル名（列名の上に書くモデル名）、今回は FE
* keep() は、表に含めたい変数、今回は　lnsalary_am_kokuji　のみ、　nendo は含めない
* addtext()　で　Municipality FE,　Nendo FE の行、FEの列に両方とも　YES　を入れてる

xtreg ratio_women_cand_adopt lnsalary_am_kokuji ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_time_year ln_all_menseki canlive_ratio_menseki sigaika_ratio_area zaiseiryoku_index cand_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 i.nendo, fe vce(cluster pres_pm_codes) 

outreg2 using myreg_wo.xls, append ctitle(FE) keep(lnsalary_am_kokuji ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_time_year ln_all_menseki canlive_ratio_menseki sigaika_ratio_area zaiseiryoku_index cand_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019) addtext(Municipality FE, Yes, Nendo FE, Yes)

* 変数多い場合


