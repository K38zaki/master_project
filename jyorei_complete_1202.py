import pandas as pd
import numpy as np
import datetime
import matplotlib.pyplot as plt
from dateutil.relativedelta import relativedelta

jm = pd.read_csv("jyorei_master/jyorei_0918_1125.csv",index_col=1)

jm.columns

# 合併年の削除処理
jm[jm["gappei_way"].isnull()==False][["pres_pm","start_date","jinko_year","gappei_dt"]]

jm["gappei_dt"] = pd.to_datetime(jm["gappei_dt"])

jm["start_date"] = pd.to_datetime(jm["start_date"])

jm[(jm["gappei_way"].isnull()==False)&(jm["gappei_dt"].dt.month.isin([4,5,6]))][["pres_pm","start_date","nendo","gappei_dt"]]
## 所得に関して、前年度に影響があるところ
## 人口に関しては、前年度・翌年度には問題なし

## 合併年の条例数を削除
jm.loc[(jm["gappei_way"].isnull()==False),"count_jyorei"] = np.nan

## 所得に関して、前年度に影響があるところの条例数を削除
jm.index = jm["Unnamed: 0"]
jm = jm.reset_index(drop=True)
jm = jm.drop("Unnamed: 0",axis=1)

jm[(jm["gappei_way"].isnull()==False)&(jm["gappei_dt"].dt.month.isin([4,5,6]))][["pres_pm","start_date","nendo","gappei_dt"]]

jm.loc[(jm["pres_pm"] == "愛知県西尾市")&(jm["nendo"] == 2010),"count_jyorei"] = np.nan
jm.loc[(jm["pres_pm"] == "栃木県栃木市")&(jm["nendo"] == 2013),"count_jyorei"] = np.nan

## time_index

jm["pres_pm_codes"]
jm["year_x"]

jm.groupby(["pres_pm_codes","year_x"]).count()[jm.groupby(["pres_pm_codes","year_x"]).count()["start_date"] > 1] #北海道泊村のみ

s_omit = jm[(jm["pres_pm_codes"] == 1403)&(jm["population"] == 0)].index
jm
jm = jm.drop(s_omit,axis=0)
jm = jm.rename({"year_x":"year"},axis=1) 
jm.groupby(["pres_pm_codes","year"]).count()[jm.groupby(["pres_pm_codes","year"]).count()["start_date"] > 1] ## OK

jm["count_jyorei"].hist()
jm["count_jyorei"].describe()

jm.to_csv("jyorei_master/jyorei_0918_1202.csv")

jm["kokuji_dt"] = pd.to_datetime(jm["kokuji_dt"])
jm[["ele_ID","kokuji_dt"]]
jm["kokuji_nendo"] = jm["kokuji_dt"].dt.year
jm.loc[jm["kokuji_dt"].dt.month < 4, "kokuji_nendo"] = jm["kokuji_dt"].dt.year - 1

jm[["ele_ID","kokuji_dt","kokuji_nendo"]]
jm.to_csv("jyorei_master/jyorei_0918_1202_v2.csv")

## 操作変数; 前年の類似団体平均給与

md = pd.read_csv("jyorei_master/jyorei_0918_1202_v2.csv",index_col=0)
md["ruiji_dantai"].unique()
md["time_muni_kind"] = [md.loc[i,"time_pm"][-1] for i in md.index]
md["time_muni_kind"].unique()

## 人口のみを基準とした類似団体
### 市
md["ruiji_jinko"] = None

san_shi = md[(md["ruiji_dantai"].str.contains("I") == True)&(md["ruiji_dantai"].str.contains("II") == False)&(md["ruiji_dantai"].str.contains("III") == False)&(md["ruiji_dantai"].str.contains("IV") == False)&(md["time_muni_kind"] == "市")]["ruiji_dantai"]
big_shi = md[(md["ruiji_dantai"].str.contains("Ⅰ") == True)&(md["time_muni_kind"] == "市")]["ruiji_dantai"]

md.loc[(md["ruiji_dantai"].str.contains("Ⅲ") == True)&(md["time_muni_kind"] == "市"),"ruiji_jinko"] = "city_3"

md.loc[(md["ruiji_dantai"].str.contains("Ⅳ") == True)&(md["time_muni_kind"] == "市"),"ruiji_jinko"] = "city_4"

md.loc[(md["ruiji_dantai"].str.contains("Ⅱ") == True)&(md["time_muni_kind"] == "市"),"ruiji_jinko"] = "city_2"

md.loc[(md["ruiji_dantai"].str.contains("Ⅰ") == True)&(md["time_muni_kind"] == "市"),"ruiji_jinko"] = "city_1"

md.loc[(md["ruiji_dantai"] == "政令指定都市")&(md["time_muni_kind"] == "市"),"ruiji_jinko"] = "city_seirei"
md.loc[(md["ruiji_dantai"] == "中核市")&(md["time_muni_kind"] == "市"),"ruiji_jinko"] = "city_chukaku"
md.loc[(md["ruiji_dantai"] == "施行時特例市")&(md["time_muni_kind"] == "市"),"ruiji_jinko"] = "city_sekojitokurei"
md.loc[(md["ruiji_dantai"] == "特例市")&(md["time_muni_kind"] == "市"),"ruiji_jinko"] = "city_tokurei"

### 町村
san_shi = md[(md["ruiji_dantai"].str.contains("I") == True)&(md["ruiji_dantai"].str.contains("II") == False)&(md["ruiji_dantai"].str.contains("III") == False)&(md["ruiji_dantai"].str.contains("IV") == False)&(md["time_muni_kind"].isin(["町","村"]))]["ruiji_dantai"]
big_shi = md[(md["ruiji_dantai"].str.contains("Ⅰ") == True)&(md["time_muni_kind"].isin(["町","村"]))]["ruiji_dantai"]

md.loc[(md["ruiji_dantai"].str.contains("Ⅰ") == True)&(md["time_muni_kind"].isin(["町","村"])),"ruiji_jinko"] = "choson_1"

md.loc[(md["ruiji_dantai"].str.contains("Ⅱ") == True)&(md["time_muni_kind"].isin(["町","村"])),"ruiji_jinko"] = "choson_2"

md.loc[(md["ruiji_dantai"].str.contains("Ⅲ") == True)&(md["time_muni_kind"].isin(["町","村"])),"ruiji_jinko"] = "choson_3"

md.loc[(md["ruiji_dantai"].str.contains("Ⅳ") == True)&(md["time_muni_kind"].isin(["町","村"])),"ruiji_jinko"] = "choson_4"

md.loc[(md["ruiji_dantai"].str.contains("Ⅴ") == True)&(md["time_muni_kind"].isin(["町","村"])),"ruiji_jinko"] = "choson_5"

## 区

md.loc[(md["time_muni_kind"] == "区")&(md["ruiji_dantai"] == "特別区"),"ruiji_jinko"] = "ku_special"

md[md["ruiji_jinko"].isnull()] #震災関連、合併直後

md[md["time_muni_kind"].isin(["町","村"])]["ruiji_jinko"].unique()
md[md["time_muni_kind"]== "市"]["ruiji_jinko"].unique()
md[md["time_muni_kind"]== "区"]["ruiji_jinko"].unique()

salary = pd.read_csv("salaries_all.csv",index_col=0)
salary

md["mean_salary_ruiji_1yago"] = np.nan
md["mean_salary_ruiji_1yago_kokuji"] = np.nan


for idx in md.index:
    ruiji = md.loc[idx,"ruiji_jinko"]
    nendo = md.loc[idx,"nendo"]
    p_pm = md.loc[idx,"pres_pm"]

    md.loc[idx,"mean_salary_ruiji_1yago"] = salary[(salary["ruiji_jinko"] == ruiji)&(salary["nendo"] == nendo-1)&(salary["pres_pm"] != p_pm)]["salary_assembly_member"].mean()

for idx in md.index:
    ruiji = md.loc[idx,"ruiji_jinko"]
    nendo = md.loc[idx,"kokuji_nendo"]
    p_pm = md.loc[idx,"pres_pm"]

    md.loc[idx,"mean_salary_ruiji_1yago_kokuji"] = salary[(salary["ruiji_jinko"] == ruiji)&(salary["nendo"] == nendo-1)&(salary["pres_pm"] != p_pm)]["salary_assembly_member"].mean()

md.to_csv("jyorei_master/jyorei_0918_1202_v3.csv")

md[["prefecture_x_x","pref_id"]]