library(tidyverse)

df <- read.csv("merged_since_2005.csv", fileEncoding = "utf-8")

df <- df[!is.na(df$compe_rate_data),]
df <-df[!is.na(df$salary_assembly_member),]

df <- subset(df, select = c("ele_ymd","compe_rate_data","salary_assembly_member"))
hist(df$compe_rate_data)
hist(df$salary_assembly_member)
plot(df$salary_assembly_member,df$compe_rate_data)]

df <- df[!df$compe_rate_data == Inf,]
ols <- lm(compe_rate_data~salary_assembly_member,data=df)
summary(ols)

log_lin <- lm(compe_rate_data~log(salary_assembly_member),data=df)
summary(log_lin)
plot(log(df$salary_assembly_member),df$compe_rate_data)
abline(log_lin)
