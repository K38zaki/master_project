import numpy as np
from numpy.core.numeric import array_equiv
import pandas as pd
import datetime
import camelot
from pandas.io.formats.format import formatters_type

nj_1215 = pd.read_csv("jyorei_teian_pdfs/num_jyorei_12_15.csv",index_col=0)
nj_1215.groupby("time_pm").first()
nj_1215.groupby("time_pm").nth(3)


#2016,17
dfs = camelot.read_pdf("jyorei_teian_pdfs/16_17.pdf", pages='1-end', split_text=True, encoding="shift-jis")
dfs[10].df
type(dfs[10])
len(dfs)

jyorei_16_17 = pd.concat([dfs[i].df for i in range(10,16)],axis=0)
jyorei_16_17.columns = jyorei_16_17.iloc[0]
jyorei_16_17 = jyorei_16_17.iloc[1:]
jyorei_16_17.sort_values("議決年月日")

jyorei_16_17 = jyorei_16_17[jyorei_16_17["議決年月日"] != "議決年月日"]
jyorei_16_17 = jyorei_16_17.reset_index(drop=True)
jyorei_16_17

sum_16_17 = jyorei_16_17.iloc[-1]
jyorei_16_17 = jyorei_16_17.iloc[:-1]
#16-17 計151団体190件　原案可決185件修正可決5件

jyorei_16_17["和暦年"] = [jyorei_16_17.loc[i, "議決年月日"][1:jyorei_16_17.loc[i, "議決年月日"].find(".")] for i in jyorei_16_17.index]
jyorei_16_17["和暦月"] = [jyorei_16_17.loc[i, "議決年月日"][jyorei_16_17.loc[i, "議決年月日"].find(".")+1:jyorei_16_17.loc[i, "議決年月日"].rfind(".")] for i in jyorei_16_17.index]

jyorei_16_17["和暦年"].unique()
jyorei_16_17["和暦月"].unique()

jyorei_16_17["和暦年"] = jyorei_16_17["和暦年"].astype("int64")
jyorei_16_17["和暦月"] = jyorei_16_17["和暦月"].astype("int64")

jyorei_16_17.loc[jyorei_16_17["和暦月"] < 4, "jyorei_nendo"] = 1988 + jyorei_16_17["和暦年"] - 1
jyorei_16_17.loc[jyorei_16_17["和暦月"] >= 4, "jyorei_nendo"] = 1988 + jyorei_16_17["和暦年"]

jyorei_16_17["jyorei_year"] = 1988 + jyorei_16_17["和暦年"]

jyorei_16_17["jyorei_nendo"].unique()
jyorei_16_17[jyorei_16_17["jyorei_nendo"] == 2018] #北海道砂川市,1件だけ2018年度→分析対象外なのでomit
jyorei_16_17 = jyorei_16_17[jyorei_16_17["jyorei_nendo"] != 2018]

jyorei_16_17["time_pm"] = jyorei_16_17["都道府県名"] + jyorei_16_17["市町村名"]
jyorei_16_17["time_pm"]
jyorei_16_17 = jyorei_16_17.reset_index(drop=True)
jyorei_16_17

jyorei_year_16_17 = jyorei_16_17.groupby(["time_pm","jyorei_nendo"]).count()["市町村名"]

jyorei_year_16_17

#sum_16_17 →　151団体 190件 185件 5件 (砂川市1件;修正可決　を抜く前)

jyorei_l = pd.read_csv("jyorei_teian_pdfs/jyorei_list_12_15.csv",index_col=0)
n_jyorei = pd.read_csv("jyorei_teian_pdfs/num_jyorei_12_15.csv",index_col=0)

jyorei_l = pd.concat([jyorei_l,jyorei_16_17],axis=0).reset_index(drop=True)
n_jyorei = pd.concat([n_jyorei,jyorei_year_16_17.reset_index()],axis=0).reset_index(drop=True)

jyorei_l
n_jyorei

#ダブりの確認
jyorei_l.groupby("条例名").count()["市町村名"] [(jyorei_l.groupby("条例名").count()["市町村名"] > 1)]
jyorei_l[jyorei_l["条例名"] == "取手市政治倫理条例の一部を改正する条例（改\n正）"]
jyorei_l[jyorei_l["条例名"] == "名古屋市児童を虐待から守る条例"] # 福島県金山町, ?
jyorei_l[jyorei_l["条例名"] == "名古屋市歯と口腔の健康づくり推進条例"] # 福島県金山町,?
jyorei_l[jyorei_l["条例名"] == "大阪戦略調整会議の設置に関する条例"]
jyorei_l[jyorei_l["条例名"] == "大阪戦略調整会議の設置に関する条例の一部を改\n正する条例"]
jyorei_l[jyorei_l["条例名"] == "村長等の給与及び旅費に関する条例（改正）"]
jyorei_l[jyorei_l["条例名"] == "江差追分会館条例の一部を改正する条例"]
jyorei_l[jyorei_l["条例名"] == "甲良町特別職の職員の給与に関する条例の一部を\n改正する条例"]
jyorei_l[jyorei_l["条例名"] == "町長の専決処分事項の指定に関する条例"]
jyorei_l[jyorei_l["条例名"] == "那賀町公の施設における指定管理者の指定の手続\n等に関する条例の一部改正"]
jyorei_l[jyorei_l["条例名"] == "飯塚市中小企業振興基本条例（改正）"] #同日、福岡県飯塚市
#条例名のタイポである可能性も考慮しいじらないことにする

(n_jyorei.groupby(["time_pm","jyorei_nendo"]).count() != 1).sum() #データ（シート）を跨ぐダブりはなさそう(2012-2017)


#2009-2011

jyorei_09_12 = pd.read_excel("jyorei_teian_pdfs/09_11_jyorei_formated.xlsx")

jyorei_09_12.columns = jyorei_09_12.iloc[0]
jyorei_09_12 = jyorei_09_12.iloc[2:]

jyorei_09_12["議決年月日"].str.split(expand=True).isnull().sum() # str.split で年月日を分割できるみたい
jyorei_09_12["和暦年"] = jyorei_09_12["議決年月日"].str.split(expand=True)[0]
jyorei_09_12["和暦月"] = jyorei_09_12["議決年月日"].str.split(expand=True)[1]

jyorei_09_12["和暦年"].unique()
jyorei_09_12["和暦月"].unique()

sum_09_12 = jyorei_09_12.iloc[-1]
jyorei_09_12 = jyorei_09_12.iloc[:-1]

sum_09_12
#市町村名 129団体,条例 162件,原案可決 140件,修正可決 22件(後述の3件を抜く前)

jyorei_09_12["和暦年"] = jyorei_09_12["和暦年"].astype("int64")
jyorei_09_12["和暦月"] = jyorei_09_12["和暦月"].astype("int64")

jyorei_09_12.loc[jyorei_09_12["和暦月"] < 4, "jyorei_nendo"] = 1988 + jyorei_09_12["和暦年"] - 1
jyorei_09_12.loc[jyorei_09_12["和暦月"] >= 4, "jyorei_nendo"] = 1988 + jyorei_09_12["和暦年"]

jyorei_09_12["jyorei_year"] = 1988 + jyorei_09_12["和暦年"]

jyorei_09_12["jyorei_nendo"].unique()
jyorei_09_12["jyorei_year"].unique()

jyorei_09_12[jyorei_09_12["jyorei_nendo"]==2008] #北海道芽室市,京都府久御山町の2件だけ2008年度→分析対象外なのでomit
jyorei_09_12 = jyorei_09_12[jyorei_09_12["jyorei_nendo"]!=2008]
jyorei_09_12[jyorei_09_12["jyorei_nendo"]==2012] 
#青森県青森市1件→もともとの2012年度のデータにも同じものが存在していてダブりになるためやっぱり除外
jyorei_09_12 = jyorei_09_12[jyorei_09_12["jyorei_nendo"]!=2012] 

jyorei_09_12["time_pm"] = jyorei_09_12["都道府県名"]+jyorei_09_12["市町村名"]

jyorei_l
jyorei_09_12.columns = jyorei_l.columns

jyorei_09_12["time_pm"].str.replace(" ","").unique()
jyorei_09_12["time_pm"] = jyorei_09_12["time_pm"].str.replace(" ","")

new_jyorei_l = pd.concat([jyorei_l,jyorei_09_12],axis=0)
new_jyorei_l

jyorei_year_09 = jyorei_09_12.groupby(["time_pm","jyorei_nendo"]).count()["市町村名"]

n_jyorei
jyorei_year_09 = jyorei_year_09.reset_index()
new_n_jyorei = pd.concat([n_jyorei,jyorei_year_09],axis=0)
new_n_jyorei.hist()

(new_n_jyorei.groupby(["time_pm","jyorei_nendo"]).count() != 1).sum() #データ（シート）を跨ぐダブりはなさそう(2009-2017)

new_jyorei_l.to_csv("jyorei_teian_pdfs/jyorei_list_09_17.csv")
new_n_jyorei.to_csv("jyorei_teian_pdfs/num_jyorei_09_17.csv")


#合併の確認
gappei_l = pd.read_excel("gappei_list.xls",index_col=0)

g_09 = gappei_l[gappei_l["合併期日"] > pd.to_datetime("20090331",format="%Y%m%d")]

#salary にくっつける

sala = pd.read_csv("salaries_all.csv",index_col=0)
sala = sala[sala["nendo"] > 2008]

new_n_jyorei.columns = ["pref_muni","nendo","n_jyorei"]
check = pd.merge(new_n_jyorei,sala,how="left",on=["pref_muni","nendo"])
check[check["name_1"].isnull()]

#mergeできてないところ
sala[sala["pref_muni"]=="千葉県鎌ヶ谷市"]　#鎌ケ谷は鎌ヶ谷に
sala[sala["pref_muni"]=="兵庫県宝塚市"]　#兵庫県宝塚市 →　宝塚市
sala[sala["pref_muni"]=="兵庫県丹波篠山市"] #兵庫県篠山市 →　丹波篠山市
sala[sala["pref_muni"]=="埼玉県川口市"] #埼玉県川ロ市 →　川口市
sala[sala["pref_muni"]=="宮城県白石市"] #宮城県自石市 →　白石市
sala[sala["pref_muni"].str.contains("山口県下関市")] #山ロ県 →　山口県
sala[sala["pref_muni"]== "石川県羽咋市"] #石川県羽昨市 → 石川県羽咋市

bef = ["千葉県鎌ケ谷市","兵庫県宝塚市","兵庫県篠山市","埼玉県川ロ市","宮城県自石市","山ロ県","石川県羽昨市"]
aft = ["千葉県鎌ヶ谷市","兵庫県宝塚市","兵庫県丹波篠山市","埼玉県川口市","宮城県白石市","山口県","石川県羽咋市"]

for i in range(len(bef)):
    new_n_jyorei["pref_muni"] = new_n_jyorei["pref_muni"].str.replace(bef[i],aft[i])

check = pd.merge(new_n_jyorei,sala,how="left",on=["pref_muni","nendo"])
check[check["name_1"].isnull()] #山口県山口市

new_n_jyorei["pref_muni"] = new_n_jyorei["pref_muni"].str.replace("山ロ市","山口市")

check = pd.merge(new_n_jyorei,sala,how="left",on=["pref_muni","nendo"])
check[check["name_1"].isnull()] #ok

kari_j = pd.merge(sala,new_n_jyorei,how="left",on=["pref_muni","nendo"])

#条例数が欠損 →　条例が無いことを意味するので、0にする
kari_j["n_jyorei"] = kari_j["n_jyorei"].fillna(0)

kari_j["n_jyorei"].hist()
kari_j["n_jyorei"].var()

#ポアソン分布かな？
from scipy.stats import poisson
import matplotlib.pyplot as plt

xs = list(range(6))
ys = [poisson.pmf(i,0.04)*21000 for i in xs]
plt.bar(xs,ys) #→　似てますね

#消滅した市町村、年度途中で誕生した市町村を除く

kari_j[kari_j["pref_muni"]=="埼玉県鳩ヶ谷市"]

##編入
hennyu = g_09[g_09["合併\nの\n方式"]=="編入"]
hennyu = pd.concat([hennyu.iloc[:,:3],hennyu["関係市町村"].str.split("、",expand=True)],axis=1)
hennyu.iloc[:,4] = hennyu.iloc[:,4].str.split("郡",expand=True)[1].fillna("鳩ヶ谷市")
hennyu.iloc[:,5] = hennyu.iloc[:,5].str.split("郡",expand=True)[1]
hennyu.iloc[:,6] = hennyu.iloc[:,6].str.split("郡",expand=True)[1]
hennyu.iloc[:,7] = hennyu.iloc[:,7].str.split("郡",expand=True)[1]
hennyu.iloc[:,8] = hennyu.iloc[:,8].str.split("郡",expand=True)[1]
hennyu.iloc[:,9] = hennyu.iloc[:,9].str.split("郡",expand=True)[1]

for i in range(1,7):
    hennyu[i] = hennyu["都道府県"] + hennyu[i]

disa_l = hennyu.iloc[:,4:].values.flatten()
(pd.Series(disa_l).isnull() == False).sum()

disa_ln = [x for x in list(disa_l) if pd.isnull(x) == False]
len(disa_ln)
disa_ln

#条例数リストに消滅した市町村はあるか　→　ない、条例0か記録なし　→　不明なのでデータから落としましょう
new_n_jyorei["pref_muni"].isin(disa_ln).sum()

a = 0
for pm in disa_ln:
    print(pm)
    print(kari_j[kari_j["pref_muni"]==pm].shape[0])
    a += kari_j[kari_j["pref_muni"]==pm].shape[0]
    #print(kari_j[kari_j["pref_muni"]==pm]["n_jyorei"].to_list())

kari_j.shape[0] - a #20910

kari_j_2 = kari_j
for pm in disa_ln:
    kari_j_2 = kari_j_2[kari_j_2["pref_muni"] != pm]

kari_j_2 #20910

##消滅した市町村・新設
sinsetsu = g_09[g_09["合併\nの\n方式"]=="新設"]
#新設前と名前が同一かで場合分け
##新設市町村（名前が同一）
doitsu_l = ["湧別町","近江八幡市","久喜市","加須市","栃木市"]
doitsu = sinsetsu[sinsetsu["名称"].isin(doitsu_l)]


kari_j_2[kari_j_2["name_1"].isin(doitsu_l)][["name_1","nendo","n_jyorei"]]
#ちなみに同一の市町村に関して、合併年度は条例数はゼロ（あるいは記録なし）
# →　名前が同一でも合併年度までのデータは全て落としてしまう

doitsu = pd.concat([doitsu.iloc[:,:3],doitsu["関係市町村"].str.split("、",expand=True)],axis=1)
doitsu.iloc[:,3] = [x[-1] for x in doitsu.iloc[:,3].str.split("郡").to_list()]
doitsu.iloc[:,4] = doitsu.iloc[:,4].str.split("郡",expand=True)[1]
doitsu.iloc[:,5] = doitsu.iloc[:,5].str.split("郡",expand=True)[1]
doitsu.iloc[:,6] = doitsu.iloc[:,6].str.split("郡",expand=True)[1]

for i in range(3,7):
    doitsu.iloc[:,i] = doitsu["都道府県"] + doitsu.iloc[:,i]

##吸収された側
disa_ln_s  =[x for x in [doitsu.iloc[0,3]] + list(doitsu.iloc[1:,4:].values.flatten()) if pd.isnull(x) == False]
disa_ln_s
kari_j_2
kari_j_2 = kari_j_2.drop(kari_j_2[(kari_j_2["pref_muni"].isin(disa_ln_s))].index,axis=0)
kari_j_2

#吸収した側の元市町村(合併年度つまり2009年度のみ削除)
ori_s = [doitsu.iloc[0,4]] + doitsu.iloc[1:,3].to_list()

kari_j_2 = kari_j_2.drop(kari_j_2[(kari_j_2["pref_muni"].isin(ori_s))&(kari_j_2["nendo"] == 2009)].index,axis=0)

kari_j_2.to_csv("kari_jyoreis.csv")


##1118
kari_j_2 = pd.read_csv("kari_jyoreis.csv",index_col=0)

##新設市町村（名前も同一でない）　→　新自治体は新設年度のみ削除、元自治体は全て削除
sinsetsu = g_09[g_09["合併\nの\n方式"]=="新設"]
doitsu_l = ["湧別町","近江八幡市","久喜市","加須市","栃木市"]
not_doitsu = sinsetsu[~sinsetsu["名称"].isin(doitsu_l)]
not_doitsu

not_doitsu = pd.concat([not_doitsu.iloc[:,:3],not_doitsu["関係市町村"].str.split("、",expand=True)],axis=1)
not_doitsu.iloc[:,3] = [x[-1] for x in not_doitsu.iloc[:,3].str.split("郡").to_list()]
not_doitsu.iloc[:,4] = not_doitsu.iloc[:,4].str.split("郡",expand=True)[1]
not_doitsu.iloc[:,5] = not_doitsu.iloc[:,5].str.split("郡",expand=True)[1]

for i in range(3,6):
    not_doitsu.iloc[:,i] = not_doitsu["都道府県"] + not_doitsu.iloc[:,i]

###元自治体

disa_l_s = [x for x in list(not_doitsu.iloc[:,3:].values.flatten()) if pd.isnull(x) == False]
kari_j_2[(kari_j_2["pref_muni"].isin(disa_l_s))] #2009のみ
kari_j_2 = kari_j_2.drop(kari_j_2[(kari_j_2["pref_muni"].isin(disa_l_s))].index,axis=0)
kari_j_2

##新自治体
new_l_s = (not_doitsu["都道府県"] + not_doitsu["名称"]).to_list()
new_l_s
kari_j_2[(kari_j_2["pref_muni"].isin(disa_l_s))&(kari_j_2["nendo"] == 2009)] #無し　→　よって削除対象なし

import matplotlib.pyplot as plt

plt.scatter(kari_j_2["salary_assembly_member"],kari_j_2["n_jyorei"])

kari_j_2.to_csv("kari_jyoreis.csv")

##merge with jinko, 

jinko = pd.read_csv("jinko_all.csv",index_col=0)
jinko

kari_j_2["time_pm"] = kari_j_2["pref_muni"]
kari_j_2.loc[(kari_j_2["time_pm"] == "兵庫県丹波篠山市")&(kari_j_2["nendo"] < 2020)]
kari_j_2.loc[(kari_j_2["time_pm"] == "兵庫県丹波篠山市")&(kari_j_2["nendo"] < 2020),"time_pm"] = "兵庫県篠山市"

kari_j_2[kari_j_2["time_pm"] == "兵庫県篠山市"]
kari_j_2["jinko_year"] = kari_j_2["nendo"]

kari_m = pd.merge(kari_j_2,jinko,how="left",on=["time_pm","jinko_year"])

kari_m[kari_m["population"].isnull()] #宮城県富谷町(2016まで)、福岡県那珂川町(2019)

kari_j_2.loc[(kari_j_2["time_pm"] == "宮城県富谷市")&(kari_j_2["nendo"] <2017),"time_pm"] = "宮城県富谷町"
kari_j_2[kari_j_2["time_pm"] == "宮城県富谷町"]

kari_m = pd.merge(kari_j_2,jinko,how="left",on=["time_pm","jinko_year"])
kari_m[kari_m["population"].isnull()]

#合併市町村の合併年度に関しては合併前のデータということになる(編入合併のみ残っている)

##2018年以降は全て落とす(忘れていた)
kari_m = kari_m[kari_m["nendo"] < 2018]
kari_j_2 = kari_j_2[kari_j_2["nendo"] < 2018]

kari_j_2.to_csv("kari_jyoreis.csv")
kari_m.to_csv("jyorei_master_datas/jm_0917_1119v1.csv")

## Merge with income

income = pd.read_csv("income_all.csv",index_col=0)

income
master = pd.read_csv("kari_jyoreis.csv",index_col=0)

master

income[income["pres_pm"] == "宮城県富谷市"]] #pres_pm
master["pres_pm"] = master["pref_muni"]
master["income_nendo"] = master["nendo"] + 1
kari_m = pd.merge(master,income,how="left",on=["pres_pm","income_nendo"])

kari_m[kari_m["income_per_syotokuwari"].isnull()].sort_values("nendo")

master.loc[master["pref_muni"]=="福岡県那珂川町","pres_pm"] = "福岡県那珂川市"
master.loc[(master["pref_muni"]=="岩手県滝沢村"),"pres_pm"] = "岩手県滝沢市"
master.loc[(master["pref_muni"]=="千葉県大網白里町"),"pres_pm"] = "千葉県大網白里市"
master.loc[(master["pref_muni"]=="埼玉県白岡町"),"pres_pm"] = "埼玉県白岡市"
master.loc[(master["pref_muni"]=="石川県野々市町"),"pres_pm"] = "石川県野々市市"
master.loc[(master["pref_muni"]=="愛知県長久手町"),"pres_pm"] = "愛知県長久手市"
master.loc[(master["pref_muni"]=="愛知県三好町"),"pres_pm"] = "愛知県みよし市"

kari_m = pd.merge(master,income,how="left",on=["pres_pm","income_nendo"])
kari_m[kari_m["income_per_syotokuwari"].isnull()].sort_values("nendo")
master = kari_m

# Merge with area
area = pd.read_csv("area_all.csv",index_col=0)
area
master["area_nendo"] = master["nendo"]

kari_m = pd.merge(master,area,how="left",on=["time_pm","area_nendo"])
kari_m[kari_m["area_name"].isnull()]

area[area["area_name"].str.contains("白岡")] #2012年、市に改称済み、またそもそも白岡町時代のデータなし
area[area["area_name"].str.contains("みよし")] #2009年度、みよし市に改称済み
area[area["area_name"].str.contains("大網白里")] #2012年度、市に改称済み
area[area["area_name"].str.contains("滝沢")] #2013年度、市に改称済み
area[area["area_name"].str.contains("富谷")] #2016年度、市に改称済み

master.loc[(master["pref_muni"]=="埼玉県白岡町")&(master["nendo"] == 2012),"time_pm"] = "埼玉県白岡市"
master.loc[(master["pref_muni"]=="愛知県三好町")&(master["nendo"] == 2009),"time_pm"] = "愛知県みよし市"
master.loc[(master["pref_muni"]=="千葉県大網白里町")&(master["nendo"] == 2012),"time_pm"] = "千葉県大網白里市"
master.loc[(master["pref_muni"]=="岩手県滝沢村")&(master["nendo"] == 2013),"time_pm"] = "岩手県滝沢市"
master.loc[(master["pref_muni"]=="宮城県富谷市")&(master["nendo"] == 2016),"time_pm"] = "宮城県富谷市"


master.loc[(master["pref_muni"]=="宮城県富谷市")]


kari_m = pd.merge(master,area,how="left",on=["time_pm","area_nendo"])
kari_m[kari_m["area_name"].isnull()]

master["ln_salary_am"] = np.log(master["salary_assembly_member"])
master.plot(kind="scatter",x="salary_assembly_member",y="n_jyorei")
master.plot(kind="scatter",x="ln_salary_am",y="n_jyorei")
kari_m.to_csv("jyorei_master_datas/jm_0917_1120.csv")







