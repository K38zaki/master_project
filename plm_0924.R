library(tidyverse)
library(estimatr)
df <- read.csv("master_datas/master_2005_0924.csv",fileEncoding = "utf-8")
df_1 <- df[,1:61]
df_2 <- df[,2375:length(colnames(df))]
df <- cbind(df_1,df_2)

df <- df[!is.na(df$compe_rate_data),]
df <-df[!is.na(df$salary_assembly_member),]
df <- df[!df$compe_rate_data == Inf,]

summary(df)
library(plm)
df$pref_muni <- factor(df$pref_muni)
df$year <- factor(df$year)
df$prefecture <- factor(df$prefecture)
lsdv = lm(formula=log(compe_rate_data)~log(salary_assembly_member) + log(salary_assembly_member)*2+n_wins_data+population+pref_muni+year,data=df)
plot(df$salary_assembly_member,df$compe_rate_data,)
summary(lsdv)
abline(lsdv)
df$prefecture
df$municipality

plot(df$)
df %>% mutate(., no = row_number()) %>% group_by(., pref_muni, year) %>% filter(., n() > 1)
