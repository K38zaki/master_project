# bootstrap

library(haven)
library(tidyverse)
library(estimatr)

install.packages("frm")
library(margins)
library(frm)
library(lmtest)
library(sandwich)

df <- read_dta("0606_data.dta")

dim(df)

f_2stage_inc <-  adjusted_ave_voteshare_inc ~ factor(cate_change_salary) +  ln_population + n_seats_adopt + population_elderly75_ratio + 
  population_child15_ratio + ln_income_per + ln_all_menseki + canlive_ratio_menseki + sigaika_ratio_area + ln_zaiseiryoku +
  win_ratio_musyozoku_pre + expired_dummy + touitsu_2011 + touitsu_2015 + touitsu_2019 + ln_staff_all + 
  ln_salary_staff_all + factor(nendo) + factor(pref_id) + factor(muni_type) + ratio_women_cand_adopt + 
  age_mean_cand + cand_ratio_musyozoku



i_ols <-  lm_robust(f_2stage_inc,data=df,se_type = "stata",clusters = pres_pm_codes)
summary(i_ols)

i_frm <- glm(f_2stage_inc,data=df,family=quasibinomial("probit"))
summary(i_frm)

summary(margins(i_frm,variables = "cate_change_salary",vcov=vcovCL(i_frm, cluster = df$pres_pm_codes),vce="delta"))

# 2sri 

