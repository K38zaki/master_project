library(haven)
library(tidyverse)
library(estimatr)

#install.packages("frm")
library(margins)
library(frm)
library(lmtest)
library(sandwich)

df <- read_dta("0606_data.dta")

do <- df[df$sample_voting_ols==1,]
dim(do)

f_o <- voting_rate_p ~ factor(cate_change_salary) + ln_population + n_seats_adopt + population_elderly75_ratio + 
  population_child15_ratio + ln_income_per + ln_all_menseki + canlive_ratio_menseki + sigaika_ratio_area + ln_zaiseiryoku +
  win_ratio_musyozoku_pre + expired_dummy + touitsu_2011 + touitsu_2015 + touitsu_2019 + ln_staff_all + 
  ln_salary_staff_all + factor(nendo) + factor(pref_id) + factor(muni_type) + compe_rate_adopt + ratio_women_cand_adopt + 
  age_mean_cand + cand_ratio_musyozoku

a_ols <-  lm_robust(f_o,data=do,se_type = "stata",clusters = pres_pm_codes)
summary(a_ols)


##2sri
dat <- df[df$sample_voting==1,]

f_1s1_v <-  dummy_up_salary_am ~ upratio + downratio +  ln_population + n_seats_adopt + population_elderly75_ratio + 
  population_child15_ratio + ln_income_per + ln_all_menseki + canlive_ratio_menseki + sigaika_ratio_area + ln_zaiseiryoku +
  win_ratio_musyozoku_pre + expired_dummy + touitsu_2011 + touitsu_2015 + touitsu_2019 + ln_staff_all + 
  ln_salary_staff_all + factor(nendo) + factor(pref_id) + factor(muni_type) + compe_rate_adopt + ratio_women_cand_adopt + 
  age_mean_cand + cand_ratio_musyozoku

# reg dummy_up_salary upratio downratio ln_population n_seats_adopt population_elderly75_ratio
# population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku 
# win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all 
# ln_salary_staff_all i.nendo i.pref_id i.muni_type compe_rate_adopt ratio_women_cand_adopt 
# age_mean_cand cand_ratio_musyozoku if voting_rate_p != ., vce(cluster pres_pm_codes)
# predict v_up_xu_hat_2, resid
# test upratio downratio

f_1s2_v <-  dummy_down_salary_am ~ upratio + downratio +  ln_population + n_seats_adopt + population_elderly75_ratio + 
  population_child15_ratio + ln_income_per + ln_all_menseki + canlive_ratio_menseki + sigaika_ratio_area + ln_zaiseiryoku +
  win_ratio_musyozoku_pre + expired_dummy + touitsu_2011 + touitsu_2015 + touitsu_2019 + ln_staff_all + 
  ln_salary_staff_all + factor(nendo) + factor(pref_id) + factor(muni_type) + compe_rate_adopt + ratio_women_cand_adopt + 
  age_mean_cand + cand_ratio_musyozoku

# reg dummy_down_salary upratio downratio ln_population n_seats_adopt population_elderly75_ratio 
# population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku
# win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all 
# ln_salary_staff_all i.nendo i.pref_id i.muni_type compe_rate_adopt ratio_women_cand_adopt 
# age_mean_cand cand_ratio_musyozoku if voting_rate_p != ., vce(cluster pres_pm_codes)
# predict v_down_xu_hat_2, resid
# test upratio downratio

f_2s_v <- voting_rate_p ~ factor(cate_change_salary) + resid1_v + resid2_v + ln_population + n_seats_adopt + population_elderly75_ratio + 
  population_child15_ratio + ln_income_per + ln_all_menseki + canlive_ratio_menseki + sigaika_ratio_area + ln_zaiseiryoku +
  win_ratio_musyozoku_pre + expired_dummy + touitsu_2011 + touitsu_2015 + touitsu_2019 + ln_staff_all + 
  ln_salary_staff_all + factor(nendo) + factor(pref_id) + factor(muni_type) + compe_rate_adopt + ratio_women_cand_adopt + 
  age_mean_cand + cand_ratio_musyozoku


# fracreg probit voting_rate_p i.cate_change_salary i_up_xu_hat_2 i_down_xu_hat_2 ln_population n_seats_adopt population_elderly75_ratio population_child15_ratio ln_income_per ln_all_menseki canlive_ratio_menseki sigaika_ratio_area ln_zaiseiryoku win_ratio_musyozoku_pre expired_dummy touitsu_2007 touitsu_2011 touitsu_2015 touitsu_2019 ln_staff_all ln_salary_staff_all i.nendo i.pref_id i.muni_type  compe_rate_adopt ratio_women_cand_adopt age_mean_cand cand_ratio_musyozoku, vce(cluster pres_pm_codes)
# eststo r_2sri,title("2SRI") :margins, dydx(*) post


dat$resid1_v <- lm(f_1s1_v,dat)$residuals
dat$resid2_v <- lm(f_1s2_v,dat)$residuals
res <- glm(f_2s_v,data=dat,family=quasibinomial("probit"))
ms <- margins(res,variables ="cate_change_salary",vcov=vcovCL(res, cluster = dat$pres_pm_codes),vce="delta")
summary(ms)

remove(ms)

clusters <- unique(dat$pres_pm_codes)

boot_2sri_v <- matrix(NA, nrow = 500, ncol = 2)
for(i in 1:500){
  # sample the clusters with replacement
  units <- sample(clusters, size = length(clusters), replace=T)
  # create bootstap sample with sapply
  df.bs <- sapply(units, function(x) which(dat[,"pres_pm_codes"]==x))
  df.bs <- dat[unlist(df.bs),]
  df.bs$resid1_v <- lm(f_1s1_v,df.bs)$residuals
  df.bs$resid2_v <- lm(f_1s2_v,df.bs)$residuals
  res <- glm(f_2s_v,data=df.bs,family=quasibinomial("probit"))
  ms <- margins(res,variables ="cate_change_salary")
  boot_2sri_v[i,]<- summary(ms)[,2]
  print(i)
}

colMeans(boot_2sri_v)
sd(boot_2sri_v[,1])
sd(boot_2sri_v[,2])

(1 - pnorm(0.0817/sd(boot_2sri_v[,1])))*2
(1 - pnorm(0.0852/sd(boot_2sri_v[,2])))*2

