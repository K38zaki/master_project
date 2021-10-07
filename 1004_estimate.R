library(tidyverse)
library(lmtest)
library(sandwich)
library(estimatr)
library(plm)
library(data.table)

df <- fread("master_datas/analysis_1004.csv", stringsAsFactors=TRUE, encoding="UTF-8", sep=",")


df$year
pdata.frame(df,index=c("pres_pm","kokuji_ym"))
df = df[!is.na(df$compe_ratio_isna),]
df = df[!is.na(df$salary_am_kokuji),]
fe_sr = plm(compe_ratio_isna ~ salary_am_kokuji, data=df, model="within")
lsdv = lm(compe_ratio_isna ~ salary_am_kokuji + factor(pres_pm) + factor(nendo), data=df)
summary(lsdv)
plot(df$salary_am_kokuji,df$compe_ratio_isna)
abline(lsdv)
coeftest(lsdv, vcov = vcovHC, cluster = ~factor(pres_pm))
colnames(df)
lsdv = lm(compe_ratio_isna ~ salary_am_kokuji + population + population_elderly75_ratio + population_prodage_ratio + factor(pres_pm) + factor(nendo), data=df)

lsdv_dummy = lm(compe_ratio_isna ~ I(dummy_up_salary_am) + population + population_elderly75_ratio + population_prodage_ratio + factor(pres_pm) + factor(nendo), data=df)

lsdv_dummy = lm(compe_ratio_isna ~ I(dummy_up_salary_am) + I(dummy_up_salary_am):abs_change_salary_am + I(dummy_down_salary_am) + I(dummy_down_salary_am):abs_change_salary_am + population + population_elderly75_ratio + population_prodage_ratio + factor(pres_pm) + factor(nendo), data=df)
summary(lsdv_dummy)

lsdv_dummy = lm(compe_ratio_isna ~ I(dummy_up_salary_am) + I(dummy_down_salary_am) + population + population_elderly75_ratio + population_prodage_ratio + factor(pres_pm) + factor(nendo), data=df)
summary(lsdv_dummy)

