library(estimatr)
library(haven)
library(Rcpp)
#install.packages("readr")
#install.packages('Rcpp')
#update.packages()
library(readr)
getwd()
md <- read_csv("../data_1229ver.csv")
colnames(md)

md$pres_pm
md$ele_id[is.na(md$lnsalary_am_kokuji)]
md$ele_id[is.na(md$compe_rate_adopt)]


ad <- md[!is.na(md$compe_rate_adopt),]
ad[is.na(ad$lnsalary_am_kokuji),]
nrow(ad)
simple <- lm(ad$compe_rate_adopt ~ ad$lnsalary_am_kokuji)
summary(simple)

simple_ols <- lm_robust(ad$compe_rate_adopt ~ ad$lnsalary_am_kokuji, clusters = ad$pres_pm_codes,se_type = "CR0")

x <- rnorm(n=100)
y <- 2 + 3*x + rnorm(n=100,sd=0.5)
kd = data.frame(y,x)
ncol(kd)
colnames(kd)
k_ols <- lm_robust(y ~ x, data=kd)
k_nrob <- lm(y ~ x, data=kd)
summary(k_nrob)

kd <- cbind(kd,rep(c(1,2),50))
colnames(kd) <- c("x","y","cl")

k_clrob <- lm_robust(y ~ x, data=kd,se_type = "CR0",clusters = cl)
a_clrob <- lm_robust(compe_rate_adopt ~ lnsalary_am_kokuji, data=ad, se_type = "CR0",clusters = pres_pm_codes)
summary(a_clrob)
form <- y ~ x
form_ols <-  compe_rate_adopt ~ lnsalary_am_kokuji + ln_income_per + ln_population + n_seats_adopt + population_elderly75_ratio + 
  population_child15_ratio + ln_all_menseki + canlive_ratio_menseki + sigaika_ratio_area + ln_zaiseiryoku +
  win_ratio_musyozoku_pre + expired_dummy + touitsu_2011 + touitsu_2015 + touitsu_2019 + ln_staff_all + 
  ln_salary_staff_all + factor(nendo) + factor(pref_id) + factor(muni_type)

form_ppml <-  compe_rate_minus1_adj ~ lnsalary_am_kokuji + ln_income_per + ln_population + n_seats_adopt + population_elderly75_ratio + 
  population_child15_ratio + ln_all_menseki + canlive_ratio_menseki + sigaika_ratio_area + ln_zaiseiryoku +
  win_ratio_musyozoku_pre + expired_dummy + touitsu_2011 + touitsu_2015 + touitsu_2019 + ln_staff_all + 
  ln_salary_staff_all + factor(nendo) + factor(pref_id) + factor(muni_type)

form_2sls <-  compe_rate_adopt ~ lnsalary_am_kokuji + ln_income_per + ln_population + n_seats_adopt + population_elderly75_ratio + 
  population_child15_ratio + ln_all_menseki + canlive_ratio_menseki + sigaika_ratio_area + ln_zaiseiryoku +
  win_ratio_musyozoku_pre + expired_dummy + touitsu_2011 + touitsu_2015 + touitsu_2019 + ln_staff_all + 
  ln_salary_staff_all + factor(nendo) + factor(pref_id) + factor(muni_type) | ln_mean_prefbigtype_1yago + 
  ln_income_per + ln_population + n_seats_adopt + population_elderly75_ratio + 
  population_child15_ratio + ln_all_menseki + canlive_ratio_menseki + sigaika_ratio_area + ln_zaiseiryoku +
  win_ratio_musyozoku_pre + expired_dummy + touitsu_2011 + touitsu_2015 + touitsu_2019 + ln_staff_all + 
  ln_salary_staff_all + factor(nendo) + factor(pref_id) + factor(muni_type)

form_fe <- compe_rate_adopt ~ lnsalary_am_kokuji + ln_income_per + ln_population + n_seats_adopt + population_elderly75_ratio + 
  population_child15_ratio + ln_all_menseki + canlive_ratio_menseki + sigaika_ratio_area + ln_zaiseiryoku +
  win_ratio_musyozoku_pre + expired_dummy + touitsu_2011 + touitsu_2015 + touitsu_2019 + ln_staff_all + 
  ln_salary_staff_all + factor(nendo)

form_gmm <- compe_rate_adopt ~ lnsalary_am_kokuji + lag(compe_rate_adopt,1) + ln_income_per + ln_population +
  n_seats_adopt + population_elderly75_ratio + population_child15_ratio + ln_all_menseki + canlive_ratio_menseki + 
  sigaika_ratio_area + ln_zaiseiryoku + win_ratio_musyozoku_pre + expired_dummy + touitsu_2011 + touitsu_2015 + 
  touitsu_2019 + ln_staff_all + ln_salary_staff_all + nendo2 + nendo4 + nendo5 + nendo6 + nendo7 + nendo8 + nendo9 +
  nendo10  + nendo12 + nendo13 + nendo14 + nendo15 | lag(ln_mean_prefbigtype_1yago,0:4) + lag(compe_rate_adopt,2:4)|
  ln_income_per + ln_population + n_seats_adopt + population_elderly75_ratio + population_child15_ratio + ln_all_menseki + canlive_ratio_menseki + 
  sigaika_ratio_area + ln_zaiseiryoku + win_ratio_musyozoku_pre + expired_dummy + touitsu_2011 + touitsu_2015 + 
  touitsu_2019 + ln_staff_all + ln_salary_staff_all + nendo2 + nendo4 + nendo5 + nendo6 + nendo7 + nendo8 + nendo9 +
  nendo10 + nendo12 + nendo13 + nendo14 + nendo15

f_g <- compe_rate_adopt ~ lnsalary_am_kokuji + lag(compe_rate_adopt,1) + ln_income_per + ln_population + 
  n_seats_adopt + population_elderly75_ratio + population_child15_ratio + ln_all_menseki + canlive_ratio_menseki + 
  sigaika_ratio_area + ln_zaiseiryoku + win_ratio_musyozoku_pre + expired_dummy + touitsu_2011 + touitsu_2015 + 
  touitsu_2019 + ln_staff_all + ln_salary_staff_all | lag(compe_rate_adopt,2:4) +  ln_mean_prefbigtype_1yago


a_ols <-  lm_robust(form_ols,data=ad,se_type = "stata",clusters = pres_pm_codes)
summary(a_ols)

a_ols <-  lm_robust(form_ols,data=ad,se_type = "CR0",clusters = pres_pm_codes)
summary(a_ols)

library(lmtest)
library(sandwich)
a_nor <- lm(form_ols,data=ad) 
summary(a_nor)
coeftest(a_nor,vcovCL(a_nor, cluster = ad$pres_pm_codes))

#
a_ppml <- glm(form_ppml, family=poisson(link="log"),data = ad)
summary(a_ppml)

coeftest(a_ppml,vcovCL(a_ppml, cluster = ad$pres_pm_codes))

library(margins)
library(mfx)
summary(margins(a_ppml))
summary(margins(a_ppml,variables = "lnsalary_am_kokuji"))
summary(margins(a_ppml,variables = "lnsalary_am_kokuji",vcov=vcovCL(a_ppml, cluster = ad$pres_pm_codes),vce="delta")) #ok!
# 上手くいかない: poissonmfx(form_ppml, data=ad, atmean = FALSE, robust = TRUE,clustervar1 = pres_pm_codes)

a_2sls <-  iv_robust(form_2sls,data=ad,se_type = "stata",clusters = pres_pm_codes)
summary(a_2sls)

library(plm)
a_fe <- plm(form_fe,data=ad,index = c("pres_pm_codes","ele_t"),model="within")
summary(a_fe)

pad <- pdata.frame(ad,index = c("pres_pm_codes", "ele_t"))

a_gmm <- pgmm(form_gmm,data=pad,effect ="individual",model = "twostep",transformation = "d")
summary(a_gmm)
a_sgmm <- pgmm(form_gmm,data=pad,effect ="individual",model = "twostep",transformation = "ld")
summary(a_sgmm)
## stata と一致しない
