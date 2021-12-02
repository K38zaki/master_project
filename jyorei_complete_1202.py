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



