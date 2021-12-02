from numpy.core.fromnumeric import amax
import pandas as pd
import numpy as np
import datetime
import matplotlib.pyplot as plt
from dateutil.relativedelta import relativedelta
from pandas.core.tools.datetimes import to_datetime

md = pd.read_csv("master_datas/master_0520_1115.csv")

md.groupby("pres_pm_codes").count()["ymd"]

md.loc[(md["prefecture"] == "富山県")&(md["pres_pm_codes"] > 170000)] # なぜかおかしな市町村コードが存在
md.loc[(md["prefecture"] == "富山県")&(md["pres_pm_codes"] < 160000)]

codes = pd.read_csv("codes_municipality.csv",encoding="CP932")
codes.loc[codes["市区町村"].isnull(),"市区町村"] = codes["政令市･郡･支庁･振興局等"]

codes["pres_pm"] = codes["都道府県"] + codes["市区町村"]


codes_ku = pd.read_csv("codes_municipality_tokubetsuku.csv",encoding="CP932")
codes_ku["pres_pm"] = codes_ku["都道府県"] + codes_ku["市区町村"]

codes[codes["都道府県"] == "東京都"]
codes = pd.concat([codes,codes_ku],axis=0)

codes["pres_pm"].values

codes["pres_pm_codes"] = codes["標準地域コード"].astype("str")
codes = codes.reset_index(drop=True)
len(codes.loc[0,"pres_pm_codes"])
codes
codes["pres_pm_codes"] = [str(0) + codes.loc[i,"pres_pm_codes"] if len(codes.loc[i,"pres_pm_codes"]) == 4 else codes.loc[i,"pres_pm_codes"] for i in codes.index]
codes = codes.rename({"pres_pm_codes":"pm_codes_new"},axis=1)
codes
kari_m = pd.merge(md,codes.iloc[:,-2:],how="left",on="pres_pm")
kari_m[kari_m["pm_codes_new"].isnull()]["pres_pm"].unique()

codes.loc[(codes["pres_pm"] == '高知県檮原町'),"pres_pm"] = '高知県梼原町'
codes.loc[(codes["pres_pm"] == '岐阜県関ケ原町'),"pres_pm"] = '岐阜県関ヶ原町'
codes.loc[(codes["pres_pm"] == '千葉県鎌ケ谷市'),"pres_pm"] = '千葉県鎌ヶ谷市'
codes.loc[(codes["pres_pm"] == '千葉県袖ケ浦市'),"pres_pm"] = '千葉県袖ヶ浦市'

kari_m = pd.merge(md,codes.iloc[:,-2:],how="left",on="pres_pm")
kari_m[kari_m["pm_codes_new"].isnull()]["pres_pm"].unique()

## pd.DataFrame([[93670,"トチギケン","イワフネマチ","栃木県岩舟町"],[112267,"サイタマケン","ハトガヤシ","埼玉県鳩ヶ谷市"],
# [93211,"トチギケン","ニシカタマチ","栃木県西方町"],[324019,"シマネケン","ヒカワチョウ","島根県斐川町"],
# [34223,"イワテケン","フジサワチョウ","岩手県藤沢町"],[323047,"シマネケン","ヒガシイズモチョウ","島根県東出雲町"],
# [234818,"アイチケン","イッシキチョウ","愛知県一色町"],[234826,"アイチケン","キラチョウ","愛知県吉良町"],
# [234834,"アイチケン","ハズチョウ","愛知県幡豆町"]],columns=codes_p.columns)

kari_m[kari_m["pm_codes_new"] == "09367"]
kari_m[kari_m["pm_codes_new"] == "11226"]
kari_m[kari_m["pm_codes_new"] == "09321"]
kari_m[kari_m["pm_codes_new"] == "32401"]
kari_m[kari_m["pm_codes_new"] == "03422"]
kari_m[kari_m["pm_codes_new"] == "32304"]
kari_m[kari_m["pm_codes_new"] == "23481"]
kari_m[kari_m["pm_codes_new"] == "23482"]
kari_m[kari_m["pm_codes_new"] == "23483"] #全てゼロ　→　使ってOK

kari_m.loc[kari_m["pres_pm"] == "栃木県岩舟町","pm_codes_new"] = "09367"
kari_m.loc[kari_m["pres_pm"] == "埼玉県鳩ヶ谷市","pm_codes_new"] = "11226"
kari_m.loc[kari_m["pres_pm"] == "栃木県西方町","pm_codes_new"] = "09321"
kari_m.loc[kari_m["pres_pm"] == "島根県斐川町","pm_codes_new"] = "32401"
kari_m.loc[kari_m["pres_pm"] == "岩手県藤沢町","pm_codes_new"] = "03422"
kari_m.loc[kari_m["pres_pm"] == "島根県東出雲町","pm_codes_new"] = "32304"
kari_m.loc[kari_m["pres_pm"] == "愛知県一色町","pm_codes_new"] = "23481"
kari_m.loc[kari_m["pres_pm"] == "愛知県吉良町","pm_codes_new"] = "23482"
kari_m.loc[kari_m["pres_pm"] == "愛知県幡豆町","pm_codes_new"] = "23483"

kari_m[kari_m["pm_codes_new"].isnull()]["pres_pm"].unique()

kari_m["pres_pm_codes"] = kari_m["pm_codes_new"]

md = kari_m

md[md["prefecture"] == "愛知県"]["pres_pm_codes"]

md["pres_pm_codes"].unique().shape
md["pres_pm"].unique().shape
md
md[md["pres_pm"] == "北海道泊村"]
md = md[md["pres_pm_codes"] != "01696"]
md

plt.scatter(pd.to_datetime(md[md["prefecture"] == "長野県"]["ymd"],format="%Y%m%d"),md[md["prefecture"] == "長野県"]["pres_pm_codes"])
md[md["prefecture"] == "東京都"]["pres_pm_codes"].unique()

## 提案条例数追加

md.groupby("pres_pm_codes").first()[md.groupby("pres_pm_codes").count()["ele_ID"] == 1]["pres_pm"]

md = md.iloc[:,1:].reset_index(drop=True)

jyorei = pd.read_csv("jyorei_teian_pdfs/jyorei_list_09_17.csv")
jyorei = jyorei.iloc[:,1:]

j12_a = jyorei[jyorei["jyorei_nendo"] >= 2012]
j12_b = jyorei[jyorei["jyorei_nendo"] < 2012]

j12_a["議決年月日"].str.split(".",expand = True)[2].unique()
a_gappi = j12_a["議決年月日"].str.split(".",expand = True).iloc[:,1:]
a_gappi.columns = ["month","day"]
a_gappi = a_gappi.astype("int64")
j12_a = pd.concat([j12_a,a_gappi],axis=1)

j12_a[j12_a["day"].isnull()]

j12_b["議決年月日"].str.split(expand = True)[2].unique()
b_gappi = j12_b["議決年月日"].str.split(expand = True).iloc[:,1:]
b_gappi = b_gappi.astype("int64")
b_gappi.columns = ["month","day"]
j12_b = pd.concat([j12_b,b_gappi],axis=1)

j12_b[j12_b["month"].isnull()]

j_d = pd.concat([j12_a,j12_b],axis=0)
j_d["year"] = j_d["jyorei_year"]
j_d["ymd"] = pd.to_datetime(j_d[["year","month","day"]]) 

j_d["time_pm"].unique()
j_d["pres_pm"] = j_d["time_pm"]

j_d.loc[j_d["time_pm"] == "兵庫県篠山市","pres_pm"] = "兵庫県丹波篠山市"
j_d.loc[j_d["time_pm"] == "福岡県那珂川町"]
j_d.loc[j_d["time_pm"] == "宮城県富谷町"]
j_d.loc[j_d["time_pm"] == "岩手県滝沢村"]
j_d.loc[j_d["time_pm"] == "千葉県大網白里町"]
j_d.loc[j_d["time_pm"] == "埼玉県白岡町"]
j_d.loc[j_d["time_pm"] == "愛知県長久手町"]
j_d.loc[j_d["time_pm"] == "石川県野々市町"]
j_d.loc[j_d["time_pm"] == "愛知県三好町"]

md_0917 =  md.loc[(md["nendo"] > 2008)&(md["nendo"] < 2018)]
for_j = md_0917[["ele_ID","prefecture_x","municipality_x","ymd","year","month","day","kokuji_dt","time_pm","pres_pm","disappear_dummy"]]

for_j[for_j["pres_pm"].str.contains("ケ")]

j_d["time_pm"] = j_d["time_pm"].str.replace("ケ","ヶ").str.replace("茨城県龍ヶ崎市","茨城県龍ケ崎市").str.replace("岩手県金ヶ崎町","岩手県金ケ崎町")
j_d["pres_pm"] = j_d["pres_pm"].str.replace("ケ","ヶ").str.replace("茨城県龍ヶ崎市","茨城県龍ケ崎市").str.replace("岩手県金ヶ崎町","岩手県金ケ崎町")

for_j = for_j[for_j["disappear_dummy"] == 0]
for_j = for_j.drop("disappear_dummy",axis=1)

for_j = pd.concat([for_j,for_j.groupby("pres_pm").shift(-1)["kokuji_dt"].rename("kokuji_f1")],axis=1)

for_j_4y = for_j[for_j["kokuji_f1"].isnull()==False]

for_j_4y["kokuji_dt"] = pd.to_datetime(for_j_4y["kokuji_dt"])
for_j_4y["kokuji_f1"] = pd.to_datetime(for_j_4y["kokuji_f1"])

(for_j_4y["kokuji_dt"] - for_j_4y["kokuji_f1"])

for_j_4y = for_j_4y[(for_j_4y["kokuji_f1"] - for_j_4y["kokuji_dt"]) > datetime.timedelta(days=365*4-29)]
#4年の任期選挙のみ

for_j_4y["count_jyorei"] = np.nan
for i in for_j_4y.index:
    p_pm = for_j_4y.loc[i,"pres_pm"]
    start_dt = for_j_4y.loc[i,"kokuji_dt"]
    end_dt = for_j_4y.loc[i,"kokuji_f1"]

    count_jyorei = j_d.loc[(j_d["pres_pm"] == p_pm)&(j_d["ymd"] > start_dt)&(j_d["ymd"] < end_dt)].shape[0]
    for_j_4y.loc[i,"count_jyorei"] = count_jyorei

md["teian_jyorei_4y"] = np.nan

for_j_4y
kari_m = pd.merge(md,for_j_4y[["ele_ID","count_jyorei"]],how="left",on="ele_ID")

kari_m[kari_m["count_jyorei"].isnull() == False] #OK

kari_m = kari_m.drop("teian_jyorei_4y",axis=1)
kari_m = kari_m.rename({"count_jyorei":"teian_jyorei_4y"},axis=1)
md = kari_m

md.to_csv("master_datas/master_0520_1121_v1.csv")

## 1年単位のデータセットに
#2009年以降に選挙実施分
for_j["ele_dt"] = pd.to_datetime(for_j["ymd"],format="%Y%m%d")
for_j["ele_1y"] = np.nan
for_j["ele_2y"] = np.nan
for_j["ele_3y"] = np.nan
for i in list(for_j.index):
    for_j.loc[i,"ele_1y"] = for_j.loc[i,"ele_dt"] + relativedelta(years=1)
    for_j.loc[i,"ele_2y"] = for_j.loc[i,"ele_dt"] + relativedelta(years=2)
    for_j.loc[i,"ele_3y"] = for_j.loc[i,"ele_dt"] + relativedelta(years=3)

start_dates = for_j[["ele_dt","ele_1y","ele_2y","ele_3y"]].stack().reset_index(level=1)

for_1y = pd.concat([start_dates,for_j],axis=1)

for_1y = for_1y.rename({0:"start_date"},axis=1)

j_d.jyorei_nendo.unique()

for_j_1y = for_1y[for_1y["start_date"] < datetime.datetime(year=2017,month=4,day=2)]
#2018年4月1日以降が期間に含まれる場合は削除

for_j_1y["kokuji_f1"] = pd.to_datetime(for_j_1y["kokuji_f1"])
for_j_1y
for_j_1y = for_j_1y[((for_j_1y["kokuji_f1"] - for_j_1y["start_date"]) < datetime.timedelta(days = 334)) == False] 
#対象期間が11カ月以内の観測値を削除(次の選挙の告示まで11か月無い or そもそももう次の任期に入ってしまっている)

for_j_1y.insert(2,"end_date",np.nan)
for_j_1y["start_date"]
for_j_1y = for_j_1y.reset_index()
for_j_1y = for_j_1y.rename({"index":"ori_id"},axis=1)
for i in for_j_1y.index:
    for_j_1y.loc[i,"end_date"] = for_j_1y.loc[i,"start_date"] + relativedelta(years=1)
for_j_1y["end_date"] = pd.to_datetime(for_j_1y["end_date"])
for_j_1y
for_j_1y.loc[for_j_1y["end_date"] > for_j_1y["kokuji_f1"],"end_date"] = for_j_1y["kokuji_f1"]
for_j_1y[for_j_1y["end_date"] == for_j_1y["kokuji_f1"]]

j_d

for_j_1y["count_jyorei"] = np.nan
for i in for_j_1y.index:
    p_pm = for_j_1y.loc[i,"pres_pm"]
    start_dt = for_j_1y.loc[i,"start_date"]
    end_dt = for_j_1y.loc[i,"end_date"]

    count_jyorei = j_d.loc[(j_d["pres_pm"] == p_pm)&(j_d["ymd"] > start_dt)&(j_d["ymd"] <= end_dt)].shape[0]
    for_j_1y.loc[i,"count_jyorei"] = count_jyorei

md.iloc[:,2370:2406].columns
s_kokuji = md[["ele_ID","salary_am_kokuji","salary_ch_kokuji","salary_vc_kokuji","salary_mayor_kokuji","salary_vice_mayor_kokuji"]]

kari_1y = pd.merge(for_j_1y,s_kokuji,how="left",on="ele_ID")
kari_1y[kari_1y["salary_am_kokuji"].isnull()]

for_j_1y = kari_1y



salary = pd.read_csv("salaries_all.csv",index_col=0)

salary_0918 = salary[(salary["nendo"] > 2008)&(salary["nendo"] < 2019)]
salary_0918.groupby("pref_muni").count()[salary_0918.groupby("pref_muni").count()["name_1"] < 10].index
salary_0918["pres_pm"] = salary_0918["pref_muni"]

salary_0918.loc[salary_0918["pref_muni"] == '千葉県大網白里町',"pres_pm"] = '千葉県大網白里市'
salary_0918.loc[salary_0918["pref_muni"] == '埼玉県白岡町',"pres_pm"] = '埼玉県白岡市'
salary_0918.loc[salary_0918["pref_muni"] == '岩手県滝沢村',"pres_pm"] = '岩手県滝沢市'
salary_0918.loc[salary_0918["pref_muni"] == '愛知県三好町',"pres_pm"] = '愛知県みよし市'
salary_0918.loc[salary_0918["pref_muni"] == '愛知県長久手町',"pres_pm"] = '愛知県長久手市'
salary_0918.loc[salary_0918["pref_muni"] == '石川県野々市町',"pres_pm"] = '石川県野々市市'

ss_next = salary_0918.groupby("pres_pm").shift(-1)[["salary_mayor","salary_assembly_member","mayor_sala_apply_ymd","assembly_sala_apply_ymd"]]

ss_next.columns = ["salary_mayor_f1","salary_am_f1","mayor_apply_f1","am_apply_f1"]

salary_0918 = pd.concat([salary_0918,ss_next],axis=1)

for_j_1y["year"] = for_j_1y["start_date"].dt.year
for_j_1y["nendo"] = for_j_1y["year"]
for_j_1y.loc[for_j_1y["month"] < 4,"nendo"] = for_j_1y["year"] - 1
for_j_1y

kari_1y = pd.merge(for_j_1y,salary_0918,how="left",on=["pres_pm","nendo"])
salary_0918
kari_1y[kari_1y["name_1"].isnull()]

salary_0918.loc[salary_0918["pref_muni"] == '福岡県那珂川町',"pres_pm"] = "福岡県那珂川市"
kari_1y = pd.merge(for_j_1y,salary_0918,how="left",on=["pres_pm","nendo"])
kari_1y[kari_1y["name_1"].isnull()].values #福岡県糸島市のみ（2010）
kari_1y[kari_1y["salary_assembly_member"].isnull()]

am_apply = kari_1y["am_apply_f1"].str.split(".",expand=True)
am_apply = am_apply.astype("float64")
am_apply[0] = am_apply[0] + 1988

am_apply.columns = ["year","month","day"]
kari_1y["am_apply_f1_dt"] = pd.to_datetime(am_apply)

may_apply = kari_1y["mayor_apply_f1"].str.split(".",expand=True)
may_apply = may_apply.astype("float64")
may_apply[0] = may_apply[0] + 1988

may_apply.columns = ["year","month","day"]
kari_1y["may_apply_f1_dt"] = pd.to_datetime(may_apply)

## 議員報酬額の年度途中の変更
kari_1y["salary_am_start"] = kari_1y["salary_assembly_member"]
kari_1y["kokuji_dt"] = pd.to_datetime(kari_1y["kokuji_dt"])
kari_1y["nendo_start"] = pd.to_datetime((kari_1y["nendo"].astype("str"))+"04",format="%Y%m")

kari_1y.loc[(kari_1y["salary_assembly_member"] != kari_1y["salary_am_f1"])&(kari_1y["am_apply_f1_dt"] <= kari_1y["kokuji_dt"])&(kari_1y["am_apply_f1_dt"] > kari_1y["nendo_start"])]
#翌年度4月1日までに変更している、かつ、選挙が変更日より早い、かつ、変更日がその年度の4月1日以降　→　変更(17 cases)
kari_1y.loc[(kari_1y["salary_assembly_member"] != kari_1y["salary_am_f1"])&(kari_1y["am_apply_f1_dt"] <= kari_1y["kokuji_dt"])&(kari_1y["am_apply_f1_dt"] > kari_1y["nendo_start"]),"salary_am_start"] = kari_1y["salary_am_f1"]

kari_1y

#首長報酬額の年度途中の変更
kari_1y["salary_mayor_start"] = kari_1y["salary_mayor"]


kari_1y.loc[(kari_1y["salary_mayor"] != kari_1y["salary_mayor_f1"])&(kari_1y["may_apply_f1_dt"] <= kari_1y["kokuji_dt"])&(kari_1y["may_apply_f1_dt"] > kari_1y["nendo_start"])]
#翌年度と異なる、かつ、選挙が変更日より早い、かつ、変更日がその年度の4月1日以降　→　変更(17 cases)
kari_1y.loc[(kari_1y["salary_mayor"] != kari_1y["salary_mayor_f1"])&(kari_1y["may_apply_f1_dt"] <= kari_1y["kokuji_dt"])&(kari_1y["may_apply_f1_dt"] > kari_1y["nendo_start"]),"salary_mayor_start"] = kari_1y["salary_mayor_f1"]

kari_1y.to_csv("jyorei_master/jyorei_0917_1121_first.csv")

#2008年以前に選挙実施分
md_p = md[["ele_ID","prefecture_x","municipality_x","ymd","year","month","day","kokuji_dt","time_pm","pres_pm","disappear_dummy","nendo"]]
md_p = md_p[md_p["disappear_dummy"] == 0]
md_p = md_p.drop("disappear_dummy",axis=1)

md_p = pd.concat([md_p,md_p.groupby("pres_pm").shift(-1)["kokuji_dt"].rename("kokuji_f1")],axis=1)

for_b = md_p[md_p["nendo"] < 2009]
for_b
for_b["kokuji_dt"] = pd.to_datetime(for_b["kokuji_dt"])
for_b["kokuji_f1"] = pd.to_datetime(for_b["kokuji_f1"])

for_b = for_b[for_b["kokuji_f1"] > datetime.datetime(year=2010,month=3,day=30)]

for_b.to_csv("jyorei_master/before_2009_tochu_1121.csv")

md[md["pres_pm"] == "宮崎県日南市"]


##分析用切り出し・1122
md = pd.read_csv("master_datas/master_0520_1121_v1.csv",index_col=0)
md.columns[:51]
md.columns[2363:]
f_h = md.iloc[:,:51]
s_h = md.iloc[:,2363:]
ana = pd.concat([f_h,s_h],axis=1)
ana.to_csv("for_analysis/for_analysis_1122.csv")

##1124 

for_b = pd.read_csv("jyorei_master/before_2009_tochu_1121.csv",index_col=0)
for_b["kokuji_dt"] = pd.to_datetime(for_b["kokuji_dt"])
for_b["kokuji_f1"] = pd.to_datetime(for_b["kokuji_f1"])

for_b["kokuji_dt"]
for_b["kokuji_dt"] - for_b["kokuji_f1"]
for_b[for_b["kokuji_f1"] - for_b["kokuji_dt"] > datetime.timedelta(days=365*4 + 31)]
#香川県東かがわ市、愛知県弥富市　→　欠損選挙あり

for_b["ele_dt"] = pd.to_datetime(for_b["ymd"],format="%Y%m%d")
for_b["ele_1y"] = np.nan
for_b["ele_2y"] = np.nan
for_b["ele_3y"] = np.nan
for i in list(for_b.index):
    for_b.loc[i,"ele_1y"] = for_b.loc[i,"ele_dt"] + relativedelta(years=1)
    for_b.loc[i,"ele_2y"] = for_b.loc[i,"ele_dt"] + relativedelta(years=2)
    for_b.loc[i,"ele_3y"] = for_b.loc[i,"ele_dt"] + relativedelta(years=3)

start_dates = for_b[["ele_dt","ele_1y","ele_2y","ele_3y"]].stack().reset_index(level=1)

for_1y = pd.concat([start_dates,for_b],axis=1)

for_1y = for_1y.rename({0:"start_date"},axis=1)


for_j_1y = for_1y[for_1y["start_date"] >= datetime.datetime(year=2009,month=4,day=1)]
#2009年4月1日以降に始まる期のみ

for_j_1y

for_j_1y = for_j_1y[((for_j_1y["kokuji_f1"] - for_j_1y["start_date"]) < datetime.timedelta(days = 334)) == False]
#対象期間が11カ月以内の観測値を削除(次の選挙の告示まで11か月無い or そもそももう次の任期に入ってしまっている)

for_j_1y

for_j_1y.insert(2,"end_date",np.nan)
for_j_1y["start_date"]
for_j_1y = for_j_1y.reset_index()
for_j_1y = for_j_1y.rename({"index":"ori_id"},axis=1)
for i in for_j_1y.index:
    for_j_1y.loc[i,"end_date"] = for_j_1y.loc[i,"start_date"] + relativedelta(years=1)
for_j_1y["end_date"] = pd.to_datetime(for_j_1y["end_date"])
for_j_1y
for_j_1y.loc[for_j_1y["end_date"] > for_j_1y["kokuji_f1"],"end_date"] = for_j_1y["kokuji_f1"]
for_j_1y[for_j_1y["end_date"] == for_j_1y["kokuji_f1"]]


j_d.jyorei_nendo.unique()
j_d

for_j_1y

for_j_1y["count_jyorei"] = np.nan
for i in for_j_1y.index:
    p_pm = for_j_1y.loc[i,"pres_pm"]
    start_dt = for_j_1y.loc[i,"start_date"]
    end_dt = for_j_1y.loc[i,"end_date"]

    count_jyorei = j_d.loc[(j_d["pres_pm"] == p_pm)&(j_d["ymd"] > start_dt)&(j_d["ymd"] <= end_dt)].shape[0]
    for_j_1y.loc[i,"count_jyorei"] = count_jyorei

for_j_1y["count_jyorei"].describe()

md = pd.read_csv("master_datas/master_0520_1121_v1.csv",index_col=0)
md.iloc[:,2370:2406].columns
s_kokuji = md[["ele_ID","salary_am_kokuji","salary_ch_kokuji","salary_vc_kokuji","salary_mayor_kokuji","salary_vice_mayor_kokuji"]]

kari_1y = pd.merge(for_j_1y,s_kokuji,how="left",on="ele_ID")
kari_1y[kari_1y["salary_am_kokuji"].isnull()]

for_j_1y = kari_1y


salary = pd.read_csv("salaries_all.csv",index_col=0)

salary_0918 = salary[(salary["nendo"] > 2008)&(salary["nendo"] < 2019)]
salary_0918.groupby("pref_muni").count()[salary_0918.groupby("pref_muni").count()["name_1"] < 10].index
salary_0918["pres_pm"] = salary_0918["pref_muni"]

salary_0918.loc[salary_0918["pref_muni"] == '千葉県大網白里町',"pres_pm"] = '千葉県大網白里市'
salary_0918.loc[salary_0918["pref_muni"] == '埼玉県白岡町',"pres_pm"] = '埼玉県白岡市'
salary_0918.loc[salary_0918["pref_muni"] == '岩手県滝沢村',"pres_pm"] = '岩手県滝沢市'
salary_0918.loc[salary_0918["pref_muni"] == '愛知県三好町',"pres_pm"] = '愛知県みよし市'
salary_0918.loc[salary_0918["pref_muni"] == '愛知県長久手町',"pres_pm"] = '愛知県長久手市'
salary_0918.loc[salary_0918["pref_muni"] == '石川県野々市町',"pres_pm"] = '石川県野々市市'

ss_next = salary_0918.groupby("pres_pm").shift(-1)[["salary_mayor","salary_assembly_member","mayor_sala_apply_ymd","assembly_sala_apply_ymd"]]

salary_0918["nendo"].unique()
ss_next.columns = ["salary_mayor_f1","salary_am_f1","mayor_apply_f1","am_apply_f1"]

salary_0918 = pd.concat([salary_0918,ss_next],axis=1)
salary_0918

for_j_1y["year"] = for_j_1y["start_date"].dt.year
for_j_1y["nendo"] = for_j_1y["year"]
for_j_1y.loc[for_j_1y["month"] < 4,"nendo"] = for_j_1y["year"] - 1
for_j_1y["start_date"].unique()

kari_1y = pd.merge(for_j_1y,salary_0918,how="left",on=["pres_pm","nendo"])
salary_0918
kari_1y[kari_1y["name_1"].isnull()]

salary_0918.loc[salary_0918["pref_muni"] == '福岡県那珂川町',"pres_pm"] = "福岡県那珂川市"
kari_1y = pd.merge(for_j_1y,salary_0918,how="left",on=["pres_pm","nendo"])
kari_1y[kari_1y["name_1"].isnull()].values #なし
kari_1y[kari_1y["salary_assembly_member"].isnull()] #矢祭町のみ

am_apply = kari_1y["am_apply_f1"].str.split(".",expand=True)
am_apply = am_apply.astype("float64")
am_apply[0] = am_apply[0] + 1988

am_apply.columns = ["year","month","day"]
kari_1y["am_apply_f1_dt"] = pd.to_datetime(am_apply)

may_apply = kari_1y["mayor_apply_f1"].str.split(".",expand=True)
may_apply = may_apply.astype("float64")
may_apply[0] = may_apply[0] + 1988

may_apply.columns = ["year","month","day"]
kari_1y["may_apply_f1_dt"] = pd.to_datetime(may_apply)

## 議員報酬額の年度途中の変更
kari_1y["salary_am_start"] = kari_1y["salary_assembly_member"]
kari_1y["kokuji_dt"] = pd.to_datetime(kari_1y["kokuji_dt"])
kari_1y["kokuji_dt"]
kari_1y["nendo_start"] = pd.to_datetime((kari_1y["nendo"].astype("str"))+"04",format="%Y%m")
kari_1y["nendo_start"]

kari_1y.loc[(kari_1y["salary_assembly_member"] != kari_1y["salary_am_f1"])&(kari_1y["am_apply_f1_dt"] <= kari_1y["start_date"])&(kari_1y["am_apply_f1_dt"] > kari_1y["nendo_start"])]
#翌年度4月1日までに変更している、かつ、Start datesが変更日より早い、かつ、変更日がその年度の4月1日以降　→　変更(19 cases)
kari_1y.loc[(kari_1y["salary_assembly_member"] != kari_1y["salary_am_f1"])&(kari_1y["am_apply_f1_dt"] <= kari_1y["start_date"])&(kari_1y["am_apply_f1_dt"] > kari_1y["nendo_start"]),"salary_am_start"] = kari_1y["salary_am_f1"]

kari_1y

#首長報酬額の年度途中の変更
kari_1y["salary_mayor_start"] = kari_1y["salary_mayor"]


kari_1y.loc[(kari_1y["salary_mayor"] != kari_1y["salary_mayor_f1"])&(kari_1y["may_apply_f1_dt"] <= kari_1y["start_date"])&(kari_1y["may_apply_f1_dt"] > kari_1y["nendo_start"])]
#翌年度と異なる、かつ、選挙が変更日より早い、かつ、変更日がその年度の4月1日以降　→　変更(62 cases)
kari_1y.loc[(kari_1y["salary_mayor"] != kari_1y["salary_mayor_f1"])&(kari_1y["may_apply_f1_dt"] <= kari_1y["start_date"])&(kari_1y["may_apply_f1_dt"] > kari_1y["nendo_start"]),"salary_mayor_start"] = kari_1y["salary_mayor_f1"]

kari_1y.to_csv("jyorei_master/jyorei_0917_1124_before.csv")

## after 2009 修正

kari_1y
## 議員報酬額の年度途中の変更
kari_1y["salary_am_start"] = kari_1y["salary_assembly_member"]
kari_1y["kokuji_dt"] = pd.to_datetime(kari_1y["kokuji_dt"])
kari_1y["nendo_start"] = pd.to_datetime((kari_1y["nendo"].astype("str"))+"04",format="%Y%m")

kari_1y.loc[(kari_1y["salary_assembly_member"] != kari_1y["salary_am_f1"])&(kari_1y["am_apply_f1_dt"] <= kari_1y["start_date"])&(kari_1y["am_apply_f1_dt"] > kari_1y["nendo_start"])]
#翌年度4月1日までに変更している、かつ、Start Dateが変更日より早い、かつ、変更日がその年度の4月1日以降　→　変更(46 cases)
kari_1y.loc[(kari_1y["salary_assembly_member"] != kari_1y["salary_am_f1"])&(kari_1y["am_apply_f1_dt"] <= kari_1y["start_date"])&(kari_1y["am_apply_f1_dt"] > kari_1y["nendo_start"]),"salary_am_start"] = kari_1y["salary_am_f1"]


#首長報酬額の年度途中の変更
kari_1y["salary_mayor_start"] = kari_1y["salary_mayor"]


kari_1y.loc[(kari_1y["salary_mayor"] != kari_1y["salary_mayor_f1"])&(kari_1y["may_apply_f1_dt"] <= kari_1y["start_date"])&(kari_1y["may_apply_f1_dt"] > kari_1y["nendo_start"])]
#翌年度と異なる、かつ、sdが変更日より早い、かつ、変更日がその年度の4月1日以降　→　変更(152 cases)
kari_1y.loc[(kari_1y["salary_mayor"] != kari_1y["salary_mayor_f1"])&(kari_1y["may_apply_f1_dt"] <= kari_1y["start_date"])&(kari_1y["may_apply_f1_dt"] > kari_1y["nendo_start"]),"salary_mayor_start"] = kari_1y["salary_mayor_f1"]

kari_1y.to_csv("jyorei_master/jyorei_0917_1124_after.csv")


## joint before and after 

after_09 = kari_1y
before_09 = pd.read_csv("jyorei_master/jyorei_0917_1124_before.csv",index_col=0)

before_09.shape[1]
after_09.shape[1]

all_j = pd.concat([before_09,after_09],axis=0).reset_index(drop=True)

all_j["nendo"].unique()

all_j.plot(kind="scatter",x="salary_am_start",y="count_jyorei")
all_j["start_date"] = pd.to_datetime(all_j["start_date"])
all_j["start_date"].dt.month.hist()

##合併年の情報（吸収合併のみのはず）

gappei_l = pd.read_excel("gappei_list.xls",index_col=0)

g_09 = gappei_l[gappei_l["合併期日"] > pd.to_datetime("20090331",format="%Y%m%d")]

g_09["pres_pm"] = g_09["都道府県"] + g_09["名称"]
g_09["合併期日"] = pd.to_datetime(g_09["合併期日"])
g_09["nendo"] = g_09["合併期日"].dt.year
g_09.loc[g_09["合併期日"].dt.month < 4,"nendo"] = g_09["合併期日"].dt.year - 1
g_09

f_gap = g_09[["合併期日","合併\nの\n方式","関係市町村","pres_pm","nendo"]]
f_gap.columns = ["gappei_dt","gappei_way","absorbed_pm","pres_pm","nendo"]

kari_j = pd.merge(all_j,f_gap,how="left",on=["nendo","pres_pm"])
kari_j[kari_j["gappei_way"].isnull()==False]


#ダブりチェック
kari_j.groupby(["pres_pm","nendo"]).count()[kari_j.groupby(["pres_pm","nendo"]).count()["start_date"] > 1]["start_date"]
kari_j[kari_j["pres_pm"] == "兵庫県赤穂市"] # 選挙のギリギリ年度繰り上がりが原因
kari_j[kari_j["pres_pm"] == "北海道日高町"] # 同上
kari_j[kari_j["pres_pm"] == "熊本県熊本市"] # 謎 →　合併が2回カウントになっていた、同日なので1回分削除
kari_j[kari_j["pres_pm"] == "長崎県諫早市"] # 選挙のギリギリ年度繰り上がりが原因


kari_j.loc[1599].values == kari_j.loc[1600].values
kari_j = kari_j.drop(1600,axis=0)


## merge with jinko

jinko = pd.read_csv("jinko_all.csv",index_col=0)
jinko
jinko["jinko_year"]
all_j["jinko_year"] = all_j["year"]
kari_j = pd.merge(all_j,jinko,how="left",on=["time_pm","jinko_year"])
kari_j[kari_j["population"].isnull()][["time_pm","jinko_year"]]

jinko["pres_pm"] = jinko["time_pm"]
jinko.loc[jinko["time_pm"] == '千葉県大網白里町',"pres_pm"] = '千葉県大網白里市'
jinko.loc[jinko["time_pm"] == '埼玉県白岡町',"pres_pm"] = '埼玉県白岡市'
jinko.loc[jinko["time_pm"] == '岩手県滝沢村',"pres_pm"] = '岩手県滝沢市'
jinko.loc[jinko["time_pm"] == '愛知県三好町',"pres_pm"] = '愛知県みよし市'
jinko.loc[jinko["time_pm"] == '愛知県長久手町',"pres_pm"] = '愛知県長久手市'
jinko.loc[jinko["time_pm"] == '石川県野々市町',"pres_pm"] = '石川県野々市市'
jinko.loc[jinko["time_pm"] == '千葉県大網白里町',"pres_pm"] = '千葉県大網白里市'

jinko.loc[jinko["time_pm"] == '宮城県富谷町',"pres_pm"] = '宮城県富谷市'
jinko.loc[jinko["time_pm"] == '兵庫県篠山市',"pres_pm"] = '兵庫県丹波篠山市'
jinko.loc[jinko["time_pm"] == '福岡県那珂川町',"pres_pm"] = '福岡県那珂川市'

jinko.to_csv("jinko_all.csv")


#合併、チェック
kari_j[kari_j["gappei_way"].isnull()==False][["pres_pm","start_date","jinko_year","gappei_dt"]]
#合併年に問題となるところ（合併後にStart Dateで、両方の期日が年内 or　両方の期日が年明け ）→翌年のデータを使う
kari_j[(kari_j["gappei_way"].isnull()==False)&(kari_j["start_date"] > kari_j["gappei_dt"])&(kari_j["gappei_dt"].dt.year == kari_j["start_date"].dt.year)&(kari_j["gappei_dt"].dt.is_year_start == False)][["pres_pm","start_date","jinko_year","gappei_dt"]]
## 4 cases
kari_j.loc[(kari_j["gappei_way"].isnull()==False)&(kari_j["start_date"] > kari_j["gappei_dt"])&(kari_j["gappei_dt"].dt.year == kari_j["start_date"].dt.year)&(kari_j["gappei_dt"].dt.is_year_start == False),"jinko_year"] = kari_j["year"] + 1

#合併翌年に問題となるところ（Start Date が該当年、合併が翌年）→　翌年に関してはその翌年のデータを使う
kari_j[(kari_j["gappei_way"].isnull()==False)&(kari_j["start_date"] < kari_j["gappei_dt"])&(kari_j["gappei_dt"].dt.year != kari_j["start_date"].dt.year)&(kari_j["gappei_dt"].dt.is_year_start == False)][["pres_pm","start_date","jinko_year","gappei_dt"]]
kari_j = kari_j.reset_index(drop=True)

corrs = kari_j[(kari_j["gappei_way"].isnull()==False)&(kari_j["start_date"] < kari_j["gappei_dt"])&(kari_j["gappei_dt"].dt.year != kari_j["start_date"].dt.year)&(kari_j["gappei_dt"].dt.is_year_start == False)][["pres_pm","start_date","year","gappei_dt"]]
## 17 cases
for i in corrs.index:
    kari_j.loc[((kari_j["pres_pm"] == corrs.loc[i,"pres_pm"])&(kari_j["year"] == corrs.loc[i,"year"] + 1)),"jinko_year"] = kari_j["year"] + 1

jinko

#merge with jinko
kari_j2 = pd.merge(kari_j,jinko,how="left",on=["pres_pm","jinko_year"])
kari_j2[kari_j2["population"].isnull()][["pres_pm","jinko_year"]]

kari_j = kari_j2
# OK

## income 
income = pd.read_csv("income_all.csv",index_col=0)
income

kari_j["income_nendo"] = kari_j["year"] + 1
kari_j[(kari_j["gappei_way"].isnull()==False)][["pres_pm","start_date","income_nendo","gappei_dt"]]

kari_j2 = pd.merge(kari_j,income,how="left",on=["pres_pm","income_nendo"])
kari_j2[kari_j2["taxed_income"].isnull()]

kari_j = kari_j2



## menseki 
menseki = pd.read_csv("menseki_all.csv",index_col=0)
menseki

menseki["pres_pm"] = menseki["time_pm"]
menseki.loc[menseki["time_pm"] == '千葉県大網白里町',"pres_pm"] = '千葉県大網白里市'
menseki.loc[menseki["time_pm"] == '埼玉県白岡町',"pres_pm"] = '埼玉県白岡市'
menseki.loc[menseki["time_pm"] == '岩手県滝沢村',"pres_pm"] = '岩手県滝沢市'
menseki.loc[menseki["time_pm"] == '愛知県三好町',"pres_pm"] = '愛知県みよし市'
menseki.loc[menseki["time_pm"] == '愛知県長久手町',"pres_pm"] = '愛知県長久手市'
menseki.loc[menseki["time_pm"] == '石川県野々市町',"pres_pm"] = '石川県野々市市'
menseki.loc[menseki["time_pm"] == '千葉県大網白里町',"pres_pm"] = '千葉県大網白里市'

menseki.loc[menseki["time_pm"] == '宮城県富谷町',"pres_pm"] = '宮城県富谷市'
menseki.loc[menseki["time_pm"] == '兵庫県篠山市',"pres_pm"] = '兵庫県丹波篠山市'
menseki.loc[menseki["time_pm"] == '福岡県那珂川町',"pres_pm"] = '福岡県那珂川市'

kari_j["menseki_nendo"] = kari_j["nendo"]
kari_j2 = pd.merge(kari_j,menseki,how="left",on=["pres_pm","menseki_nendo"])
kari_j2[kari_j2["all_menseki"].isnull()] #福岡県糸島市　→　妥当

menseki.to_csv("menseki_all.csv")

## area

kari_j = kari_j2
area = pd.read_csv("area_all.csv",index_col=0)

area["pres_pm"] = area["time_pm"]
area.loc[area["time_pm"] == '千葉県大網白里町',"pres_pm"] = '千葉県大網白里市'
area.loc[area["time_pm"] == '埼玉県白岡町',"pres_pm"] = '埼玉県白岡市'
area.loc[area["time_pm"] == '岩手県滝沢村',"pres_pm"] = '岩手県滝沢市'
area.loc[area["time_pm"] == '愛知県三好町',"pres_pm"] = '愛知県みよし市'
area.loc[area["time_pm"] == '愛知県長久手町',"pres_pm"] = '愛知県長久手市'
area.loc[area["time_pm"] == '石川県野々市町',"pres_pm"] = '石川県野々市市'
area.loc[area["time_pm"] == '千葉県大網白里町',"pres_pm"] = '千葉県大網白里市'

area.loc[area["time_pm"] == '宮城県富谷町',"pres_pm"] = '宮城県富谷市'
area.loc[area["time_pm"] == '兵庫県篠山市',"pres_pm"] = '兵庫県丹波篠山市'
area.loc[area["time_pm"] == '福岡県那珂川町',"pres_pm"] = '福岡県那珂川市'

kari_j["area_nendo"] = kari_j["nendo"]
kari_j2 = pd.merge(kari_j,area,how="left",on=["pres_pm","area_nendo"])
kari_j2[kari_j2["area_name"].isnull()] #問題なし

area.to_csv("area_all.csv")

kari_j = kari_j2

#財政力
zaisei = pd.read_csv("zaisei_all.csv",index_col=0)
zaisei

zaisei["pres_pm"] = zaisei["time_pm"]
zaisei.loc[zaisei["time_pm"] == '千葉県大網白里町',"pres_pm"] = '千葉県大網白里市'
zaisei.loc[zaisei["time_pm"] == '埼玉県白岡町',"pres_pm"] = '埼玉県白岡市'
zaisei.loc[zaisei["time_pm"] == '岩手県滝沢村',"pres_pm"] = '岩手県滝沢市'
zaisei.loc[zaisei["time_pm"] == '愛知県三好町',"pres_pm"] = '愛知県みよし市'
zaisei.loc[zaisei["time_pm"] == '愛知県長久手町',"pres_pm"] = '愛知県長久手市'
zaisei.loc[zaisei["time_pm"] == '石川県野々市町',"pres_pm"] = '石川県野々市市'
zaisei.loc[zaisei["time_pm"] == '千葉県大網白里町',"pres_pm"] = '千葉県大網白里市'

zaisei.loc[zaisei["time_pm"] == '宮城県富谷町',"pres_pm"] = '宮城県富谷市'
zaisei.loc[zaisei["time_pm"] == '兵庫県篠山市',"pres_pm"] = '兵庫県丹波篠山市'
zaisei.loc[zaisei["time_pm"] == '福岡県那珂川町',"pres_pm"] = '福岡県那珂川市'

kari_j["zaisei_nendo"] = kari_j["nendo"]
kari_j2 = pd.merge(kari_j,zaisei,how="left",on=["pres_pm","zaisei_nendo"])
kari_j2[kari_j2["zaiseiryoku_index"].isnull()] #問題なし

zaisei.to_csv("zaisei_all.csv")

kari_j = kari_j2

kari_j.to_csv("jyorei_master/jyorei_0918_1124.csv")
## 合併年は取り除く（今後）


# Merge with senkyo 
md = pd.read_csv("master_datas/master_0520_1121_v1.csv",index_col=0) 

md.columns[:52]
md.columns[2557:].values

md_f = md.iloc[:,:52]
md_s = md.iloc[:,2557:]

md_part = pd.concat([md_f,md_s],axis=1)

kari_j2 = pd.merge(kari_j,md_part,how="left",on="ele_ID")

kari_j2.to_csv("jyorei_master/jyorei_0918_1125.csv")

##menseki


kari_j2 = pd.merge(kari_j2,md[["ele_ID","pres_pm_codes"]],how="left",on="ele_ID")

kari_j[kari_j["pres_pm"] == "熊本県熊本市"]














