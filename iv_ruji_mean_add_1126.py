import pandas as pd
import numpy as np
import datetime
import matplotlib.pyplot as plt
from dateutil.relativedelta import relativedelta

md = pd.read_csv("master_datas/master_0520_1121_v1.csv",index_col=0)

md[md["nendo"] > 2005]["ruiji_dantai"].unique()

md.loc[(md["nendo"] > 2005)&(md["ruiji_dantai"].isnull())]

tab_ruiji = md["ruiji_dantai"].value_counts()

md["time_muni_kind"] = [md.loc[i,"time_pm"][-1] for i in md.index]

md[(md["nendo"] > 2005)&(md["time_muni_kind"] == "市")]["ruiji_dantai"].value_counts()


## 人口のみを基準とした類似団体
### 市
md["ruiji_jinko"] = None

san_shi = md[(md["ruiji_dantai"].str.contains("I") == True)&(md["ruiji_dantai"].str.contains("II") == False)&(md["ruiji_dantai"].str.contains("III") == False)&(md["ruiji_dantai"].str.contains("IV") == False)&(md["time_muni_kind"] == "市")]["ruiji_dantai"]
big_shi = md[(md["ruiji_dantai"].str.contains("Ⅰ") == True)&(md["time_muni_kind"] == "市")]["ruiji_dantai"]

md.loc[(md["ruiji_dantai"].str.contains("III") == True)&(md["time_muni_kind"] == "市"),"ruiji_jinko"] = "city_3"
md.loc[(md["ruiji_dantai"].str.contains("Ⅲ") == True)&(md["time_muni_kind"] == "市"),"ruiji_jinko"] = "city_3"

md.loc[(md["ruiji_dantai"].str.contains("IV") == True)&(md["time_muni_kind"] == "市"),"ruiji_jinko"] = "city_4"
md.loc[(md["ruiji_dantai"].str.contains("Ⅳ") == True)&(md["time_muni_kind"] == "市"),"ruiji_jinko"] = "city_4"

md.loc[(md["ruiji_dantai"].str.contains("II") == True)&(md["ruiji_dantai"].str.contains("III") == False)&(md["time_muni_kind"] == "市"),"ruiji_jinko"] = "city_2"
md.loc[(md["ruiji_dantai"].str.contains("Ⅱ") == True)&(md["time_muni_kind"] == "市"),"ruiji_jinko"] = "city_2"

md.loc[(md["ruiji_dantai"].str.contains("I") == True)&(md["ruiji_dantai"].str.contains("II") == False)&(md["ruiji_dantai"].str.contains("III") == False)&(md["ruiji_dantai"].str.contains("IV") == False)&(md["time_muni_kind"] == "市"),"ruiji_jinko"] = "city_1"
md.loc[(md["ruiji_dantai"].str.contains("Ⅰ") == True)&(md["time_muni_kind"] == "市"),"ruiji_jinko"] = "city_1"

md.loc[(md["ruiji_dantai"] == "政令指定都市")&(md["time_muni_kind"] == "市"),"ruiji_jinko"] = "city_seirei"
md.loc[(md["ruiji_dantai"] == "中核市")&(md["time_muni_kind"] == "市"),"ruiji_jinko"] = "city_chukaku"
md.loc[(md["ruiji_dantai"] == "施行時特例市")&(md["time_muni_kind"] == "市"),"ruiji_jinko"] = "city_sekojitokurei"
md.loc[(md["ruiji_dantai"] == "特例市")&(md["time_muni_kind"] == "市"),"ruiji_jinko"] = "city_tokurei"

### 町村
san_shi = md[(md["ruiji_dantai"].str.contains("I") == True)&(md["ruiji_dantai"].str.contains("II") == False)&(md["ruiji_dantai"].str.contains("III") == False)&(md["ruiji_dantai"].str.contains("IV") == False)&(md["time_muni_kind"].isin(["町","村"]))]["ruiji_dantai"]
big_shi = md[(md["ruiji_dantai"].str.contains("Ⅰ") == True)&(md["time_muni_kind"].isin(["町","村"]))]["ruiji_dantai"]

md.loc[(md["ruiji_dantai"].str.contains("I") == True)&(md["ruiji_dantai"].str.contains("II") == False)&(md["ruiji_dantai"].str.contains("III") == False)&(md["ruiji_dantai"].str.contains("IV") == False)&(md["time_muni_kind"].isin(["町","村"])),"ruiji_jinko"] = "choson_1"
md.loc[(md["ruiji_dantai"].str.contains("Ⅰ") == True)&(md["time_muni_kind"].isin(["町","村"])),"ruiji_jinko"] = "choson_1"

san_shi = md[(md["ruiji_dantai"].str.contains("II") == True)&(md["ruiji_dantai"].str.contains("III") == False)&(md["time_muni_kind"].isin(["町","村"]))]["ruiji_dantai"]
big_shi = md[(md["ruiji_dantai"].str.contains("Ⅱ") == True)&(md["time_muni_kind"].isin(["町","村"]))]["ruiji_dantai"]

md.loc[(md["ruiji_dantai"].str.contains("II") == True)&(md["ruiji_dantai"].str.contains("III") == False)&(md["time_muni_kind"].isin(["町","村"])),"ruiji_jinko"] = "choson_2"
md.loc[(md["ruiji_dantai"].str.contains("Ⅱ") == True)&(md["time_muni_kind"].isin(["町","村"])),"ruiji_jinko"] = "choson_2"

san_shi = md[((md["ruiji_dantai"].str.contains("III") == True)|(md["ruiji_dantai"].str.contains("Ⅲ") == True))&(md["time_muni_kind"].isin(["町","村"]))] ["ruiji_dantai"]

md.loc[((md["ruiji_dantai"].str.contains("III") == True)|(md["ruiji_dantai"].str.contains("Ⅲ") == True))&(md["time_muni_kind"].isin(["町","村"])),"ruiji_jinko"] = "choson_3"

san_shi = md[((md["ruiji_dantai"].str.contains("IV") == True)|(md["ruiji_dantai"].str.contains("Ⅳ") == True))&(md["time_muni_kind"].isin(["町","村"]))]["ruiji_dantai"]

md.loc[((md["ruiji_dantai"].str.contains("IV") == True)|(md["ruiji_dantai"].str.contains("Ⅳ") == True))&(md["time_muni_kind"].isin(["町","村"])),"ruiji_jinko"] = "choson_4"

san_shi = md[(((md["ruiji_dantai"].str.contains("V") == True)&(md["ruiji_dantai"].str.contains("IV") == False))|(md["ruiji_dantai"].str.contains("Ⅴ") == True))&(md["time_muni_kind"].isin(["町","村"]))]["ruiji_dantai"]

md.loc[(((md["ruiji_dantai"].str.contains("V") == True)&(md["ruiji_dantai"].str.contains("IV") == False))|(md["ruiji_dantai"].str.contains("Ⅴ") == True))&(md["time_muni_kind"].isin(["町","村"])),"ruiji_jinko"] = "choson_5"

## 区

md.loc[(md["time_muni_kind"] == "区")&(md["ruiji_dantai"] == "特別区"),"ruiji_jinko"] = "ku_special"

## check
md.loc[(md["time_muni_kind"] == "市"),"ruiji_dantai"].unique()
md.loc[(md["time_muni_kind"] == "市"),"ruiji_jinko"].unique()

md.loc[(md["time_muni_kind"] == "町"),"ruiji_dantai"].unique()
md.loc[(md["time_muni_kind"] == "町"),"ruiji_jinko"].unique()

md.loc[(md["time_muni_kind"] == "村"),"ruiji_dantai"].unique()
md.loc[(md["time_muni_kind"] == "村"),"ruiji_jinko"].unique()

md.loc[(md["time_muni_kind"] == "区"),"ruiji_dantai"].unique()
md.loc[(md["time_muni_kind"] == "区"),"ruiji_jinko"].unique()

md[(md["ruiji_jinko"].isnull())&(md["nendo"] > 2005)] #震災の影響だけ,17 cases

## 類似団体の境界で不連続があるか
md["ln_salary_am_kokuji"] = np.log(md["salary_am_kokuji"])
md["ln_popu"] = np.log(md["population"])
md[md["time_muni_kind"] == "市"].plot(kind="scatter",y="ln_salary_am_kokuji",x="ln_popu")
np.log(150000)

plt.scatter(md[md["time_muni_kind"] == "市"]["ln_popu"],md[md["time_muni_kind"] == "市"]["ln_salary_am_kokuji"])

plt.scatter(md[md["time_muni_kind"] == "市"]["ln_popu"],md[md["time_muni_kind"] == "市"]["ln_salary_am_kokuji"])
plt.xlim([np.log(145000),np.log(155000)])
plt.plot([np.log(150000),np.log(150000)],[7.50,9.25],color="orange")

plt.scatter(md[md["time_muni_kind"] == "市"]["ln_popu"],md[md["time_muni_kind"] == "市"]["ln_salary_am_kokuji"])
plt.xlim([np.log(95000),np.log(105000)])
plt.plot([np.log(100000),np.log(100000)],[7.50,9.25],color="orange")

plt.scatter(md[md["time_muni_kind"] == "市"]["ln_popu"],md[md["time_muni_kind"] == "市"]["ln_salary_am_kokuji"])
plt.xlim([np.log(45000),np.log(55000)])
plt.plot([np.log(50000),np.log(50000)],[7.50,9.25],color="orange")

plt.scatter(md[md["time_muni_kind"].isin(["町","村"])]["ln_popu"],md[md["time_muni_kind"].isin(["町","村"])]["ln_salary_am_kokuji"])

plt.scatter(md[md["time_muni_kind"].isin(["町","村"])]["ln_popu"],md[md["time_muni_kind"].isin(["町","村"])]["ln_salary_am_kokuji"])
plt.xlim([np.log(17500),np.log(22500)])
plt.plot([np.log(20000),np.log(20000)],[7.5,8.25],color="orange")

plt.scatter(md[md["time_muni_kind"].isin(["町","村"])]["ln_popu"],md[md["time_muni_kind"].isin(["町","村"])]["ln_salary_am_kokuji"])
plt.xlim([np.log(12500),np.log(17500)])
plt.plot([np.log(15000),np.log(15000)],[7.5,8.25],color="orange")

plt.scatter(md[md["time_muni_kind"].isin(["町","村"])]["ln_popu"],md[md["time_muni_kind"].isin(["町","村"])]["ln_salary_am_kokuji"])
plt.xlim([np.log(7500),np.log(12500)])
plt.plot([np.log(10000),np.log(10000)],[7.5,8.25],color="orange")

plt.scatter(md[md["time_muni_kind"].isin(["町","村"])]["ln_popu"],md[md["time_muni_kind"].isin(["町","村"])]["ln_salary_am_kokuji"])
plt.xlim([np.log(4000),np.log(6000)])
plt.plot([np.log(5000),np.log(5000)],[7.5,8.25],color="orange")

## 変数作成
salary = pd.read_csv("salaries_all.csv",index_col=0)

salary["pres_pm"] = salary["pref_muni"]

salary.loc[salary["pref_muni"] == '千葉県大網白里町',"pres_pm"] = '千葉県大網白里市'
salary.loc[salary["pref_muni"] == '埼玉県白岡町',"pres_pm"] = '埼玉県白岡市'
salary.loc[salary["pref_muni"] == '岩手県滝沢村',"pres_pm"] = '岩手県滝沢市'
salary.loc[salary["pref_muni"] == '愛知県三好町',"pres_pm"] = '愛知県みよし市'
salary.loc[salary["pref_muni"] == '愛知県長久手町',"pres_pm"] = '愛知県長久手市'
salary.loc[salary["pref_muni"] == '石川県野々市町',"pres_pm"] = '石川県野々市市'
salary.loc[salary["pref_muni"] == '福岡県那珂川町',"pres_pm"] = '福岡県那珂川市'

salary.loc[salary["pref_muni"] == '茨城県水海道市',"pres_pm"] = '茨城県常総市'
salary.loc[salary["pref_muni"] == '和歌山県岩出町',"pres_pm"] = '和歌山県岩出市'

salary["time_pm"] = salary["pref_muni"]
salary.loc[salary["pref_muni"] == '兵庫県丹波篠山市',"time_pm"] = salary["prefecture"] + salary["name_1"]
salary.loc[salary["pref_muni"] == '宮城県富谷市',"time_pm"] = salary["prefecture"] + salary["name_1"]

salary.loc[salary["pref_muni"] == '兵庫県丹波篠山市',"time_pm"]
salary.loc[salary["pref_muni"] == '宮城県富谷市',"time_pm"]

salary["time_muni_kind"] = [salary.loc[i,"time_pm"][-1] for i in salary.index]
salary

## 人口のみを基準とした類似団体; salary

salary[(salary["nendo"] > 2005)&(salary["time_muni_kind"] == "市")]["ruiji_dantai"].value_counts()
### 市
salary["ruiji_jinko"] = None

san_shi = salary[(salary["ruiji_dantai"].str.contains("I") == True)&(salary["ruiji_dantai"].str.contains("II") == False)&(salary["ruiji_dantai"].str.contains("III") == False)&(salary["ruiji_dantai"].str.contains("IV") == False)&(salary["time_muni_kind"] == "市")]["ruiji_dantai"]
big_shi = salary[(salary["ruiji_dantai"].str.contains("Ⅰ") == True)&(salary["time_muni_kind"] == "市")]["ruiji_dantai"]

salary.loc[(salary["ruiji_dantai"].str.contains("III") == True)&(salary["time_muni_kind"] == "市"),"ruiji_jinko"] = "city_3"
salary.loc[(salary["ruiji_dantai"].str.contains("Ⅲ") == True)&(salary["time_muni_kind"] == "市"),"ruiji_jinko"] = "city_3"

salary.loc[(salary["ruiji_dantai"].str.contains("IV") == True)&(salary["time_muni_kind"] == "市"),"ruiji_jinko"] = "city_4"
salary.loc[(salary["ruiji_dantai"].str.contains("Ⅳ") == True)&(salary["time_muni_kind"] == "市"),"ruiji_jinko"] = "city_4"

salary.loc[(salary["ruiji_dantai"].str.contains("II") == True)&(salary["ruiji_dantai"].str.contains("III") == False)&(salary["time_muni_kind"] == "市"),"ruiji_jinko"] = "city_2"
salary.loc[(salary["ruiji_dantai"].str.contains("Ⅱ") == True)&(salary["time_muni_kind"] == "市"),"ruiji_jinko"] = "city_2"

salary.loc[(salary["ruiji_dantai"].str.contains("I") == True)&(salary["ruiji_dantai"].str.contains("II") == False)&(salary["ruiji_dantai"].str.contains("III") == False)&(salary["ruiji_dantai"].str.contains("IV") == False)&(salary["time_muni_kind"] == "市"),"ruiji_jinko"] = "city_1"
salary.loc[(salary["ruiji_dantai"].str.contains("Ⅰ") == True)&(salary["time_muni_kind"] == "市"),"ruiji_jinko"] = "city_1"

salary.loc[(salary["ruiji_dantai"] == "政令指定都市")&(salary["time_muni_kind"] == "市"),"ruiji_jinko"] = "city_seirei"
salary.loc[(salary["ruiji_dantai"] == "中核市")&(salary["time_muni_kind"] == "市"),"ruiji_jinko"] = "city_chukaku"
salary.loc[(salary["ruiji_dantai"] == "施行時特例市")&(salary["time_muni_kind"] == "市"),"ruiji_jinko"] = "city_sekojitokurei"
salary.loc[(salary["ruiji_dantai"] == "特例市")&(salary["time_muni_kind"] == "市"),"ruiji_jinko"] = "city_tokurei"

### 町村
san_shi = salary[(salary["ruiji_dantai"].str.contains("I") == True)&(salary["ruiji_dantai"].str.contains("II") == False)&(salary["ruiji_dantai"].str.contains("III") == False)&(salary["ruiji_dantai"].str.contains("IV") == False)&(salary["time_muni_kind"].isin(["町","村"]))]["ruiji_dantai"]
big_shi = salary[(salary["ruiji_dantai"].str.contains("Ⅰ") == True)&(salary["time_muni_kind"].isin(["町","村"]))]["ruiji_dantai"]

salary.loc[(salary["ruiji_dantai"].str.contains("I") == True)&(salary["ruiji_dantai"].str.contains("II") == False)&(salary["ruiji_dantai"].str.contains("III") == False)&(salary["ruiji_dantai"].str.contains("IV") == False)&(salary["time_muni_kind"].isin(["町","村"])),"ruiji_jinko"] = "choson_1"
salary.loc[(salary["ruiji_dantai"].str.contains("Ⅰ") == True)&(salary["time_muni_kind"].isin(["町","村"])),"ruiji_jinko"] = "choson_1"

san_shi = salary[(salary["ruiji_dantai"].str.contains("II") == True)&(salary["ruiji_dantai"].str.contains("III") == False)&(salary["time_muni_kind"].isin(["町","村"]))]["ruiji_dantai"]
big_shi = salary[(salary["ruiji_dantai"].str.contains("Ⅱ") == True)&(salary["time_muni_kind"].isin(["町","村"]))]["ruiji_dantai"]

salary.loc[(salary["ruiji_dantai"].str.contains("II") == True)&(salary["ruiji_dantai"].str.contains("III") == False)&(salary["time_muni_kind"].isin(["町","村"])),"ruiji_jinko"] = "choson_2"
salary.loc[(salary["ruiji_dantai"].str.contains("Ⅱ") == True)&(salary["time_muni_kind"].isin(["町","村"])),"ruiji_jinko"] = "choson_2"

san_shi = salary[((salary["ruiji_dantai"].str.contains("III") == True)|(salary["ruiji_dantai"].str.contains("Ⅲ") == True))&(salary["time_muni_kind"].isin(["町","村"]))] ["ruiji_dantai"]

salary.loc[((salary["ruiji_dantai"].str.contains("III") == True)|(salary["ruiji_dantai"].str.contains("Ⅲ") == True))&(salary["time_muni_kind"].isin(["町","村"])),"ruiji_jinko"] = "choson_3"

san_shi = salary[((salary["ruiji_dantai"].str.contains("IV") == True)|(salary["ruiji_dantai"].str.contains("Ⅳ") == True))&(salary["time_muni_kind"].isin(["町","村"]))]["ruiji_dantai"]

salary.loc[((salary["ruiji_dantai"].str.contains("IV") == True)|(salary["ruiji_dantai"].str.contains("Ⅳ") == True))&(salary["time_muni_kind"].isin(["町","村"])),"ruiji_jinko"] = "choson_4"

san_shi = salary[(((salary["ruiji_dantai"].str.contains("V") == True)&(salary["ruiji_dantai"].str.contains("IV") == False))|(salary["ruiji_dantai"].str.contains("Ⅴ") == True))&(salary["time_muni_kind"].isin(["町","村"]))]["ruiji_dantai"]

salary.loc[(((salary["ruiji_dantai"].str.contains("V") == True)&(salary["ruiji_dantai"].str.contains("IV") == False))|(salary["ruiji_dantai"].str.contains("Ⅴ") == True))&(salary["time_muni_kind"].isin(["町","村"])),"ruiji_jinko"] = "choson_5"

## 区

salary.loc[(salary["time_muni_kind"] == "区")&(salary["ruiji_dantai"] == "特別区"),"ruiji_jinko"] = "ku_special"

s_r = salary[["time_muni_kind","ruiji_dantai","ruiji_jinko"]]


salary.to_csv("salaries_all.csv")


md[md["nendo"] > 2006].index


md["mean_salary_ruiji_1yago"] = np.nan

for idx in md[md["nendo"] > 2006].index:
    ruiji = md.loc[idx,"ruiji_jinko"]
    nendo = md.loc[idx,"nendo"]
    p_pm = md.loc[idx,"pres_pm"]

    md.loc[idx,"mean_salary_ruiji_1yago"] =salary[(salary["ruiji_jinko"] == ruiji)&(salary["nendo"] == nendo-1)&(salary["pres_pm"] != p_pm)]["salary_assembly_member"].mean()

md[(md["nendo"] > 2006)&(md["mean_salary_ruiji_1yago"].isnull())]

md.to_csv("master_datas/master_0520_1126_v1.csv")

md["kokuji_f1"] = pd.to_datetime(md.groupby("pres_pm_codes").shift(-1)["kokuji_dt"])

md["kokuji_dt"] = pd.to_datetime(md["kokuji_dt"])

md[(md["kokuji_f1"] - md["kokuji_dt"]) > datetime.timedelta(days = 365*4+90)]
md[md["pres_pm"] == "京都府舞鶴市"]["kokuji_dt"].dt.year
md.loc[md["kokuji_dt"].dt.year != md["year"],"kokuji_dt"] = pd.to_datetime(md["ymd"],format="%Y%m%d") - datetime.timedelta(days = 7)

md["kokuji_f1"] = md.groupby("pres_pm_codes").shift(-1)["kokuji_dt"]

md[(md["kokuji_f1"] - md["kokuji_dt"]) > datetime.timedelta(days = 365*4+90)]

## 弥富市、東かがわ市のみ

md[md["pres_pm"] == "愛知県弥富市"][["ymd","dummy_up_salary_am"]]
md.columns.to_list().index("dummy_up_salary_am")
md.columns[2411:2425]

md[md["pres_pm"] == "愛知県弥富市"][["ymd",'kokuji_ymd_pre', 'salary_am_pre', 'pre_pm','change_salary_am', 'abs_change_salary_am', 'dummy_change_salary_am','dummy_up_salary_am', 'dummy_down_salary_am']]

md.loc[(md["pres_pm"] == "愛知県弥富市")&(md["nendo"] == 2015),'kokuji_ymd_pre':'dummy_down_salary_am']
md.loc[(md["pres_pm"] == "香川県東かがわ市")&(md["nendo"] == 2015),'kokuji_ymd_pre':'dummy_down_salary_am']

##前回選挙の情報を修正
md[(md["time_pm"] != md['pre_pm']) & (md["ele_t"] != 1) ]

md['kokuji_ymd_pre'] = md.groupby("pres_pm_codes").shift(1)["kokuji_dt"]
md['salary_am_pre'] = md.groupby("pres_pm_codes").shift(1)["salary_assembly_member"]
md['change_salary_am'] = md["salary_assembly_member"] - md['salary_am_pre'] 
md['abs_change_salary_am'] = abs(md['change_salary_am'])
md['dummy_change_salary_am'] = np.nan
md.loc[(md['change_salary_am'] != 0)&(md['change_salary_am'].isnull() == False),'dummy_change_salary_am'] = 1
md.loc[(md['change_salary_am'] == 0)&(md['change_salary_am'].isnull() == False),'dummy_change_salary_am'] = 0

md['dummy_up_salary_am'] = np.nan
md.loc[(md['change_salary_am'] > 0)&(md['change_salary_am'].isnull() == False),'dummy_up_salary_am'] = 1
md.loc[(md['change_salary_am'] <= 0)&(md['change_salary_am'].isnull() == False),'dummy_up_salary_am'] = 0

md['dummy_down_salary_am'] = np.nan
md.loc[(md['change_salary_am'] < 0)&(md['change_salary_am'].isnull() == False),'dummy_down_salary_am'] = 1
md.loc[(md['change_salary_am'] >= 0)&(md['change_salary_am'].isnull() == False),'dummy_down_salary_am'] = 0

(md['dummy_down_salary_am'] == 1).sum()
(md['dummy_up_salary_am'] == 1).sum()
(md['dummy_change_salary_am'] == 1).sum()

md.loc[(md["pres_pm"] == "愛知県弥富市")&(md["nendo"] == 2015),'kokuji_ymd_pre':'dummy_down_salary_am'] = np.nan
md.loc[(md["pres_pm"] == "香川県東かがわ市")&(md["nendo"] == 2015),'kokuji_ymd_pre':'dummy_down_salary_am'] = np.nan

md.loc[(md["pres_pm"] == "愛知県弥富市")&(md["nendo"] == 2015),'kokuji_ymd_pre':'dummy_down_salary_am']
md.loc[(md["pres_pm"] == "香川県東かがわ市")&(md["nendo"] == 2015),'kokuji_ymd_pre':'dummy_down_salary_am']

md.to_csv("master_datas/master_0520_1126_v2.csv")

##1127
md = pd.read_csv("master_datas/master_0520_1126_v2.csv",index_col=0)

md["cand_ratio_musyozoku_pre"] = md.groupby("pres_pm_codes").shift(1)["cand_ratio_musyozoku"]
md["win_ratio_musyozoku_pre"] = md.groupby("pres_pm_codes").shift(1)["win_ratio_musyozoku"]

md.loc[(md["pres_pm"] == "愛知県弥富市")&(md["nendo"] == 2015),["cand_ratio_musyozoku_pre","win_ratio_musyozoku_pre"]] = np.nan
md.loc[(md["pres_pm"] == "香川県東かがわ市")&(md["nendo"] == 2015),["cand_ratio_musyozoku_pre","win_ratio_musyozoku_pre"]] = np.nan

md.loc[(md["pres_pm"] == "愛知県弥富市"),"ele_t"] = [1,3,4]
md.loc[(md["pres_pm"] == "香川県東かがわ市"),"ele_t"] = [1,3,4]

md.to_csv("master_datas/master_0520_1128_v1.csv")

first = md.loc[:,md.columns[:51]]
second = md.loc[:,md.columns[2363:]]

ana = pd.concat([first,second],axis=1)
ana = ana[ana["nendo"] != 2020]
ana.to_csv("for_analysis/for_analysis_1128.csv")


## 無所属を除く多数会派
col_wins_df = pd.DataFrame([list(md.columns),["当選者数" in i for i in md.columns],["所属" in i for i in md.columns]]).T
col_cand_df = pd.DataFrame([list(md.columns),["立候補者数" in i for i in md.columns],["所属" in i for i in md.columns]]).T

win_party = md[["ele_ID"]+list(col_wins_df[(col_wins_df[1])][0].values)]
win_party
win_p_nan = win_party[(win_party.isnull() == False).iloc[:,1:].sum(axis=1) == 0]
win_p_ari = win_party[(win_party.isnull() == False).iloc[:,1:].sum(axis=1) != 0]

win_p_ari = win_p_ari[win_p_ari['当選者数_\u3000'].isnull()]


win_p_ari[win_p_ari.sum(axis=1).isnull()]
win_p_ari[win_p_ari.sum(axis=1) == 0] #合計当選者数nanはなし,0は3つあり
win_p_ari["win_party_sum"] = win_p_ari.sum(axis=1)
win_p_ari["majority"] = win_p_ari.iloc[:,1:-1].idxmax(axis=1)

win_p_ari["majority"] = win_p_ari["majority"].str.replace("当選者数_","")

win_p_ari.groupby("majority").count()["ele_ID"]


win_p_ari.iloc[0,1:-2].sort_values(ascending=False).head(2) #0行目、2番目に当選者が多い会派
win_p_ari["second"] = [win_p_ari.iloc[i,1:-2].sort_values(ascending=False).index[1] for i in range(win_p_ari.shape[0])]

win_p_ari["num_win_party"] =(win_p_ari.isnull() == False).sum(axis=1)
win_p_ari[win_p_ari["num_win_party"] == 5]
win_p_ari.loc[19][win_p_ari.loc[19].isnull()==False]

win_p_ari["num_win_party"] = (win_p_ari.iloc[:,1:-4].isnull() == False).sum(axis=1)
win_p_ari[win_p_ari["num_win_party"] == 3]
win_p_ari.iloc[:,1:-4].loc[6881][win_p_ari.iloc[:,1:-4].loc[6881].isnull()==False]

#そもそも無所属割合が異様に高いので無意味かも　→とりあえず保留

win_p_ari["second"] = win_p_ari["second"].str.replace("当選者数_","")

win_p_ari[win_p_ari["majority"] == win_p_ari["second"]]