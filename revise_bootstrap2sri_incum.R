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


# cluster bootstrap function

clusboot2sri <- function(formula, data, cluster, reps=1000){
  reg1 <- lm(formula, data)
  clusters <- names(table(cluster))
  sterrs <- matrix(NA, nrow=reps, ncol=length(coef(reg1)))
  for(i in 1:reps){
    index <- sample(1:length(clusters), length(clusters), replace=TRUE)
    aa <- clusters[index]
    bb <- table(aa)
    bootdat <- NULL
    for(j in 1:max(bb)){
      cc <- data[cluster %in% names(bb[bb %in% j]),]
      for(k in 1:j){
        bootdat <- rbind(bootdat, cc)
      }
    }
    sterrs[i,] <- coef(lm(formula, bootdat))
  }
  val <- cbind(coef(reg1),apply(sterrs,2,sd))
  colnames(val) <- c("Estimate","Std. Error")
  return(val)
}

rest_boot <- clusboot2sri(f_2stage_inc,data=df,cluster=df$pres_pm_codes,reps=100)

length(names(table(df$pres_pm_codes)))

index <-sample(1:1750,1750,replace=TRUE)
aa <- index
bb <- table(aa)
max(bb)
bb

df[df$pres_pm_codes %in% names(bb[bb %in% 1]),]
names(bb[bb %in% 1])

cluster <- df$pres_pm_codes
reg1 <- lm(f_2stage_inc, df)
clusters <- names(table(df$pres_pm_codes))
sterrs <- matrix(NA, nrow=100, ncol=length(coef(reg1)))
dim(sterrs)
index <- sample(1:length(clusters), length(clusters), replace=TRUE)
aa <- clusters[index]
bb <- table(aa)
bootdat <- NULL


aa

for(j in 1:max(bb)){
  cc <- df[cluster %in% names(bb[bb %in% j]),]
  for(k in 1:j){
    bootdat <- rbind(bootdat, cc)
  }
}
# cc <- df[cluster %in% names(bb[bb %in% 1]),]
# bootdat <- rbind(bootdat, cc)
dim(bootdat)
dim(df)
sterrs[1,] <- coef(lm(f_2stage_inc, bootdat))
sterrs

library(ClusterBootstrap)
test_cb <- clusbootglm(f_2stage_inc,df,clusterid=pres_pm_codes,
                       family = quasibinomial("probit"),B = 100)
for (i in 1:100){
print(dim(clusbootsample(test_cb,i)))
}

install.packages("boot")
library(boot)


i_frm <- glm(f_2stage_inc,data=df,family=quasibinomial("probit"))

library(fwildclusterboot)

i_ols <-  lm(f_2stage_inc,data=df)
margins(i_ols)
boot1 <- boottest(i_frm,
                  B = 200,
                  param = "factor(cate_change_salary)1",
                  clustid = "pres_pm_codes"
)
boot1

boot_algo2(preprocess2(i_ols))

library(multiwayvcov)
cluster.boot(i_ols, cluster=df$pres_pm_codes)

df$sample_inc %>% sum()
dat <- df[df$sample_inc_ols == 1,]
dat
clusters <- unique(dat$pres_pm_codes)

#これで行くしかない
units <- sample(clusters, size = length(clusters), replace=T)
df.bs <- sapply(units, function(x) which(dat[,"pres_pm_codes"]==x))
dat[unlist(df.bs),]
dat
units

boot_ols <- matrix(NA, nrow = 500, ncol = 2)
for(i in 1:500){
  # sample the clusters with replacement
  units <- sample(clusters, size = length(clusters), replace=T)
  # create bootstap sample with sapply
  df.bs <- sapply(units, function(x) which(dat[,"pres_pm_codes"]==x))
  df.bs <- dat[unlist(df.bs),]
  boot_ols[i,] <- coef(lm(f_2stage_inc,data = df.bs))[2:3]
  print(i)
}

colMeans(boot_ols)
sd(boot_ols[,2])
sd(boot_ols[,1])

#multicore;ダメ
library(snow)

cl <- makeCluster(10)

boot_ols <- matrix(NA, nrow = 500, ncol = 2)
for(i in 1:500){
  # sample the clusters with replacement
  units <- sample(clusters, size = length(clusters), replace=T)
  clusterExport(cl, c("dat", "units"))
  df.bs = clusterApply(cl, units, function(x) which(dat$pres_pm_codes == x))
  df.bs <- dat[unlist(df.bs),]
  boot_ols[i,] <- coef(lm(f_2stage_inc,data = df.bs))[2:3]
  print(i)
}
#fpml
boot_fpml <- matrix(NA, nrow = 500, ncol = 2)
for(i in 1:500){
  # sample the clusters with replacement
  units <- sample(clusters, size = length(clusters), replace=T)
  # create bootstap sample with sapply
  df.bs <- sapply(units, function(x) which(dat[,"pres_pm_codes"]==x))
  df.bs <- dat[unlist(df.bs),]
  res <- glm(f_2stage_inc,data=df.bs,family=quasibinomial("probit"))
  ms <- margins(res,variables ="cate_change_salary")
  boot_fpml[i,]<- summary(ms)[,2]
  print(i)
}

colMeans(boot_fpml,)
sd(boot_fpml[1:50,2])
sd(boot_ols[1:50,1])

res <- glm(f_2stage_inc,data=dat,family=quasibinomial("probit"))
ame <- margins(res,variables ="cate_change_salary")
ame

#fpml
boot_fpml <- matrix(NA, nrow = 500, ncol = 2)
for(i in 1:500){
  # sample the clusters with replacement
  units <- sample(clusters, size = length(clusters), replace=T)
  # create bootstap sample with sapply
  df.bs <- sapply(units, function(x) which(dat[,"pres_pm_codes"]==x))
  df.bs <- dat[unlist(df.bs),]
  res <- glm(f_2stage_inc,data=df.bs,family=quasibinomial("probit"))
  ms <- margins(res,variables ="cate_change_salary")
  boot_fpml[i,]<- summary(ms)[,2]
  print(i)
}

##2sri
dat <- df[df$sample_2sri_inc==1,]

f_1s1_i <-  dummy_up_salary_am ~ upratio + downratio +  ln_population + n_seats_adopt + population_elderly75_ratio + 
  population_child15_ratio + ln_income_per + ln_all_menseki + canlive_ratio_menseki + sigaika_ratio_area + ln_zaiseiryoku +
  win_ratio_musyozoku_pre + expired_dummy + touitsu_2011 + touitsu_2015 + touitsu_2019 + ln_staff_all + 
  ln_salary_staff_all + factor(nendo) + factor(pref_id) + factor(muni_type) + ratio_women_cand_adopt + 
  age_mean_cand + cand_ratio_musyozoku

f_1s2_i <-  dummy_down_salary_am ~ upratio + downratio +  ln_population + n_seats_adopt + population_elderly75_ratio + 
  population_child15_ratio + ln_income_per + ln_all_menseki + canlive_ratio_menseki + sigaika_ratio_area + ln_zaiseiryoku +
  win_ratio_musyozoku_pre + expired_dummy + touitsu_2011 + touitsu_2015 + touitsu_2019 + ln_staff_all + 
  ln_salary_staff_all + factor(nendo) + factor(pref_id) + factor(muni_type) + ratio_women_cand_adopt + 
  age_mean_cand + cand_ratio_musyozoku

f_2s_i <- adjusted_ave_voteshare_inc ~ factor(cate_change_salary) +  resid1_i + resid2_i + ln_population + n_seats_adopt + population_elderly75_ratio + 
  population_child15_ratio + ln_income_per + ln_all_menseki + canlive_ratio_menseki + sigaika_ratio_area + ln_zaiseiryoku +
  win_ratio_musyozoku_pre + expired_dummy + touitsu_2011 + touitsu_2015 + touitsu_2019 + ln_staff_all + 
  ln_salary_staff_all + factor(nendo) + factor(pref_id) + factor(muni_type) + ratio_women_cand_adopt + 
  age_mean_cand + cand_ratio_musyozoku


dat$resid1_i <- lm(f_1s1_i,dat)$residuals
dat$resid2_i <- lm(f_1s2_i,dat)$residuals
res <- glm(f_2s_i,data=dat,family=quasibinomial("probit"))
ms <- margins(res,variables ="cate_change_salary",vcov=vcovCL(res, cluster = dat$pres_pm_codes),vce="delta")
summary(ms)

remove(ms)

boot_2sri <- matrix(NA, nrow = 500, ncol = 2)
for(i in 1:500){
  # sample the clusters with replacement
  units <- sample(clusters, size = length(clusters), replace=T)
  # create bootstap sample with sapply
  df.bs <- sapply(units, function(x) which(dat[,"pres_pm_codes"]==x))
  df.bs <- dat[unlist(df.bs),]
  df.bs$resid1_i <- lm(f_1s1_i,df.bs)$residuals
  df.bs$resid2_i <- lm(f_1s2_i,df.bs)$residuals
  res <- glm(f_2s_i,data=df.bs,family=quasibinomial("probit"))
  ms <- margins(res,variables ="cate_change_salary")
  boot_2sri[i,]<- summary(ms)[,2]
  print(i)
}



colMeans(boot_2sri)
sd(boot_2sri[,2])
sd(boot_2sri[,1])
hist(boot_2sri[,2])



## not clustered
nrow(dat)
for(i in 1:1000){
  # sample the clusters with replacement
  units <- sample(index(dat), size = nrow(dat), replace=T)
  # create bootstap sample with sapply
  df.bs <- df[units,]
  boot.res1[i] <- coef(lm(f_2stage_inc,data = df.bs))[1]
  print(i)
}
sd(boot.res1)
mean(boot.res1)
summary(i_ols)
coef(lm(f_2stage_inc,data = df.bs))[1]
lm(f_2stage_inc,data = dat)
boot.res1
