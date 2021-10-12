import pandas as pd
import numpy as np
import datetime

master = pd.read_csv("master_datas/master_2005_1002_fin.csv",index_col=0)
master = master.drop(["Unnamed: 0.1"],axis=1)


master = master.rename({"Unnamed: 0.1.1":"ori_No","Unnamed: 0.1.1.1":"ele_ID"},axis=1)
master = master.sort_values("kokuji_ymd")


#非連続の紐づけ
master["pres_pm"] = master["pref_muni"]
master.loc[master["pref_muni"]=="福岡県那珂川町","pres_pm"] = "福岡県那珂川市"
master.loc[master["pref_muni"]=="千葉県大網白里町","pres_pm"] = "千葉県大網白里市"
master.loc[master["pref_muni"]=="岩手県滝沢村","pres_pm"] = "岩手県滝沢市"
master.loc[master["pref_muni"].str.contains("白岡"),"pres_pm"]
master.loc[master["pref_muni"]=="愛知県長久手町","pres_pm"] = "愛知県長久手市"
master.loc[master["pref_muni"]=="石川県野々市町","pres_pm"] = "石川県野々市市"

master["time_pm"] = master["pref_muni"]
master.loc[master["pref_muni"]=="宮城県富谷市","time_pm"] = ["宮城県富谷町"]*3+["宮城県富谷市"]
master.loc[master["pref_muni"]=="兵庫県丹波篠山市","time_pm"] = ["兵庫県篠山市"]*3+["兵庫県丹波篠山市"]

master = master.reset_index(drop=True)
master.loc[master["pref_muni"]=="兵庫県丹波篠山市"]

master = master[master["nendo"] != 2021] #報酬のデータが存在しない2021を除外
n_ele = master.groupby("pres_pm").count()["ele_ID"]
n_ele.unique()
n_ele[n_ele==5]

#選挙が5回
master[master["pres_pm"] == "北海道新得町"]
master = master.drop(3512,axis=0) #新得町2013
master[master["pres_pm"] == "奈良県宇陀市"] #解散(2020)
master[master["pres_pm"] == "宮城県気仙沼市"] #おそらく合併時の再選挙(2006)
master[master["pres_pm"] == "宮城県石巻市"] #同上
master[master["pres_pm"] == "山口県美祢市"] #同上(2008)
master[master["pres_pm"] == "山梨県西桂町"]["reason"] #何らかの理由(2012)
master[master["pres_pm"] == "岡山県赤磐市"] #2005年4月,2021年3月に開催
master[master["pres_pm"] == "岡山県鏡野町"] #同上
master[master["pres_pm"] == "岩手県田野畑村"] #2005年の補欠選挙っぽいのがカウント
master = master.drop(81,axis=0) #田野畑村2005
master[master["pres_pm"] == "広島県三原市"] #2005年4月,2021年3月に開催
master[master["pres_pm"] == "新潟県村上市"] #おそらく合併時の再選挙(2008)
master[master["pres_pm"] == "沖縄県那覇市"] #2014年の補欠選挙っぽいのがカウント
master = master.drop(3911,axis=0) #那覇市2014
master[master["pres_pm"] == "福島県双葉町"] #解散(2013)
master[master["pres_pm"] == "群馬県みなかみ町"] #解散(2018)
master[master["pres_pm"] == "群馬県南牧村"] #2010年の補欠選挙っぽいのがカウント
master = master.drop(2049,axis=0) #南牧村2010
master[master["pres_pm"] == "長崎県諫早市"] #2005年4月,2021年3月に開催
master[master["pres_pm"] == "青森県藤崎町"]["reason"] #解散(2011)
master[master["pres_pm"] == "高知県四万十市"] #2019年は四万十町の選挙、分類の誤り
simanto_e = master.loc[5694] #修正用
master[master["pres_pm"] == "鹿児島県阿久根市"] #解散(2009,2011)
master.loc[4163,"reason"] = "任期満了" #誤り修正

#四万十町
simanto_e[["municipality_x","pref_muni","pres_pm","time_pm"]] = ["四万十町"]+["高知県四万十町"]*3
simanto_e[["municipality_x","pref_muni","pres_pm","time_pm"]]
salaries = pd.read_csv("salaries_all.csv",index_col=0)
salaries[salaries["pref_muni"] == "高知県四万十町"]
sima_2018 = salaries.loc[25111] #2018年度
key_l = list(sima_2018.keys())
simanto_e.keys()[2375:]
key_l[1] = "prefecture_y"
key_l[-1] = "municipality_y"
simanto_e[key_l] = sima_2018.values
simanto_e[key_l]
simanto_e[['salary_am_kokuji', 'salary_am_ymd','salary_ch_kokuji','salary_ch_ymd','salary_vc_kokuji','salary_vc_ymd', 'salary_mayor_kokuji', 'salary_mayor_ymd','salary_vice_mayor_kokuji', 'salary_vice_mayor_ymd']] = simanto_e[['salary_assembly_member','assembly_sala_apply_ymd','salary_chair','assembly_sala_apply_ymd','salary_vice_chair','assembly_sala_apply_ymd','salary_mayor','mayor_sala_apply_ymd','salary_vice_mayor','mayor_sala_apply_ymd']].values
simanto_e[['salary_am_kokuji', 'salary_am_ymd','salary_ch_kokuji','salary_ch_ymd','salary_vc_kokuji','salary_vc_ymd', 'salary_mayor_kokuji', 'salary_mayor_ymd','salary_vice_mayor_kokuji', 'salary_vice_mayor_ymd']]
simanto_e.iloc[2375:]
master.loc[5694] = simanto_e
master.loc[5694]

#選挙1,2,3回
n_ele[n_ele==1]
master[master["municipality_x"] == "日高町"]
old = pd.read_csv("elec_unit_data/pref_1_gikai_elections.csv")
old[old["municipality"] == "日高町"]
oc = pd.read_csv("original_candidates_data/gikai_pref_1.csv")
oc[oc["municipality"] == "日高町"] #そもそも収集できてない　→　選挙区レベルでの開催にもかかわらず「区」の文字が無かった

master[master["pref_muni"] == "岩手県藤沢町"] #元サイトに2008年以降の情報が無い  →　2011年消滅
master[master["ele_ID"].str.contains("藤沢")]
master[master["pref_muni"] == "島根県東出雲町"]　#元サイトに2008年以降の情報が無い　→　2011年消滅（残ってるデータもある！）
master[master["pref_muni"] == "愛知県一色町"]　#2011年消滅
master[master["pref_muni"] == "愛知県吉良町"]　#2011年消滅
master[master["pref_muni"] == "愛知県幡豆町"]　#2011年消滅
master[master["pref_muni"] == "栃木県西方町"]　#2011年消滅

n_ele[n_ele==2]
master[master["pref_muni"] == "埼玉県鳩ヶ谷市"] #2011年消滅
master[master["pref_muni"] == "島根県斐川町"]　#2011年消滅
master[master["pref_muni"] == "栃木県岩舟町"] #2014年消滅

#→ 2011年以降に消滅した自治体は残ってる

n_ele[n_ele==3]
master[master["pref_muni"] == "三重県木曽岬町"]
list(n_ele[n_ele==3].keys())


#報酬の欠損埋め(基本は翌年度4月1日時点、変更が選挙日以降であることが明らかな場合（南三陸町05、飯綱町05、日置市05、広野町11、大熊町11）を除き)
sala_miss = master.sort_values(["nendo","prefecture_x"])[master.sort_values(["nendo","prefecture_x"])["salary_am_kokuji"].isnull()][["ele_ID","kokuji_ymd","pref_muni"]]
sala_miss.to_csv("salary_missing_list.csv")

salaries[salaries["pref_muni"] == "岩手県陸前高田市"]
salaries[salaries["pref_muni"] == "福島県葛尾村"]
salaries[salaries["pref_muni"] == "福島県広野町"]
salaries[salaries["pref_muni"] == "福島県川内村"]
salaries[salaries["pref_muni"] == "宮城県南三陸町"]

miss = master[master["salary_am_kokuji"].isnull()][["ele_ID","kokuji_dt","nendo","time_pm"]]
miss["nendo"] += 1
miss["pref_muni"] = miss["time_pm"]
s_p = salaries[["nendo","pref_muni","salary_assembly_member","assembly_sala_apply_ymd"]]
miss_m = pd.merge(miss,s_p,how="left",on=["nendo","pref_muni"])
miss_m["kokuji_dt"] = pd.to_datetime(miss_m["kokuji_dt"])
miss_m

def to_seireki_dt(x):
    dotp_1 = x.find(".")
    dotp_2 = x.rfind(".")
    y = int(x[:dotp_1])+1988 if int(x[:dotp_1]) > 2 else int(x[:dotp_1])+2018
    m = int(x[dotp_1+1:dotp_2])
    d = int(x[dotp_2+1:])
    return datetime.datetime(year=y,month=m,day=d)

miss_m["assembly_sala_apply_ymd"] = miss_m["assembly_sala_apply_ymd"].apply(lambda x: to_seireki_dt(x))

#翌年度を使うタイプの欠損埋め
can_fill = miss_m[miss_m["kokuji_dt"] > miss_m["assembly_sala_apply_ymd"]]
master.loc[master["ele_ID"].isin(list(can_fill["ele_ID"])),["salary_am_kokuji","salary_am_ymd"]] = can_fill[["salary_assembly_member","assembly_sala_apply_ymd"]].values

master.loc[master["ele_ID"].isin(list(can_fill["ele_ID"])),["salary_am_kokuji","salary_am_ymd"]]

#前年度を使うタイプの欠損埋め
not_fill = miss_m[miss_m["kokuji_dt"] < miss_m["assembly_sala_apply_ymd"]]
not_fill = not_fill.iloc[:,:5]
not_fill["nendo"] += -2
not_fill = pd.merge(not_fill,s_p,how="left",on=["nendo","pref_muni"])
master.loc[master["ele_ID"].isin(list(not_fill["ele_ID"])),["salary_am_kokuji","salary_am_ymd"]] = not_fill[["salary_assembly_member","assembly_sala_apply_ymd"]].values

master.loc[master["ele_ID"].isin(list(not_fill["ele_ID"]))]

master.to_csv("master_datas/master_0520_1004.csv")

#日高町修正

master.columns[2375:]
hidaka = pd.read_csv("elec_unit_data/hidakacho_gikai_elections.csv")

hidaka = hidaka.loc[[1,2,3]]
hidaka["pref_muni"] = hidaka["prefecture"] + hidaka["municipality"]
hidaka["kokuji_dt"] = pd.to_datetime(hidaka["kokuji_ymd"],format='%Y%m%d')
hidaka["nendo"] = np.nan
hidaka.loc[hidaka['kokuji_dt'].dt.month >= 4, 'nendo'] = hidaka['kokuji_dt'].dt.year
hidaka.loc[hidaka['kokuji_dt'].dt.month < 4, 'nendo'] = hidaka['kokuji_dt'].dt.year - 1
hidaka = pd.merge(hidaka,salaries,how="left",on=["nendo","pref_muni"])
salaries[salaries["pref_muni"]=="北海道日高町"]
hidaka = hidaka.rename({"Unnamed: 0":"ele_ID"},axis=1)
hidaka.index = [7018,7019,7020]
master = pd.concat([master,hidaka],axis=0)
master.loc[[7018,7019,7020],['salary_am_kokuji','salary_am_ymd','salary_ch_kokuji','salary_ch_ymd','salary_vc_kokuji','salary_vc_ymd','salary_mayor_kokuji','salary_mayor_ymd','salary_vice_mayor_kokuji','salary_vice_mayor_ymd']] = hidaka[['salary_assembly_member','assembly_sala_apply_ymd','salary_chair','assembly_sala_apply_ymd','salary_vice_chair','assembly_sala_apply_ymd','salary_mayor','mayor_sala_apply_ymd','salary_vice_mayor','mayor_sala_apply_ymd']].values

master
#欠損は欠損バージョン
master.loc[[7018,7019,7020],"n_seats_isna"] = master.loc[[7018,7019,7020],"n_seats_display"]
master.loc[7018,"n_seats_isna"] = np.nan

master.loc[[7018,7019,7020],"compe_ratio_isna"] = master["n_cand_display"]/master["n_seats_isna"]

#欠損は勝者数で埋めるバージョン
master.loc[[7018,7019,7020],"n_seats_fillna"] = master.loc[[7018,7019,7020],"n_seats_display"]
master.loc[7018,"n_seats_fillna"] = master.loc[7018,"n_wins_data"]
master.loc[[7018,7019,7020],"compe_ratio_fillna"] = master["n_cand_display"]/master["n_seats_fillna"]

master.loc[[7018,7019,7020],["pres_pm","time_pm"]] = master.loc[[7018,7019,7020],"pref_muni"]
master.loc[[7018,7019,7020],"ori_No"] = [7018,7019,7020]


#ラグ作成
master = master.sort_values("ymd")
master = master.reset_index(drop=True)
lag1 = master.groupby("pres_pm").shift(1)[["kokuji_ymd","salary_am_kokuji","time_pm"]]
lag1.columns = ["kokuji_ymd_pre","salary_am_pre","pre_pm"]
master = pd.concat([master,lag1],axis=1)
master["change_salary_am"] = master["salary_am_kokuji"] - master["salary_am_pre"]
master["abs_change_salary_am"] = master["change_salary_am"].apply(lambda x: abs(x)) 


master["dummy_up_salary_am"] = np.nan
master.loc[master["change_salary_am"] <= 0,"dummy_up_salary_am"] = 0
master.loc[master["change_salary_am"] > 0,"dummy_up_salary_am"] = 1
(master["dummy_up_salary_am"]==1).sum()

master["dummy_down_salary_am"] = np.nan
master.loc[master["change_salary_am"] >= 0,"dummy_down_salary_am"] = 0
master.loc[master["change_salary_am"] < 0,"dummy_down_salary_am"] = 1
(master["dummy_down_salary_am"]==1).sum()

master["dummy_change_salary_am"] = np.nan
master.loc[master["abs_change_salary_am"] == 0,"dummy_change_salary_am"] = 0
master.loc[master["abs_change_salary_am"] > 0,"dummy_change_salary_am"] = 1
master["dummy_change_salary_am"]
(master["dummy_change_salary_am"]==1).sum()

master.to_csv("master_datas/master_0520_1004_v2.csv")

##merge_with_covariats

### 人口
jinko = pd.read_csv("jinko_all.csv",index_col=0)
jinko["time_pm"] = jinko["prefecture"].astype("str") + jinko["municipality"].astype("str")
jinko["time_pm"] = jinko["time_pm"].str.replace("\u3000","").str.replace(" ","")
jinko["time_pm"].values

master = pd.read_csv("master_datas/master_0520_1004_v2.csv",index_col=0)
master["year"] = master["year"].astype("int64")
master = pd.merge(master,jinko,how="left",on=["time_pm","year"])

master[master["population"].isnull()][["year","time_pm"]].values
jinko[jinko["time_pm"].str.contains("須恵町")]

#ヶとケ
jinko["time_pm"] = jinko["time_pm"].str.replace("ケ","ヶ")
jinko["time_pm"] = jinko["time_pm"].str.replace("金ヶ崎","金ケ崎").str.replace("龍ヶ崎","龍ケ崎")

#須恵町
jinko["time_pm"] = jinko["time_pm"].str.replace("須惠町","須恵町")

#梼原町
jinko["time_pm"] = jinko["time_pm"].str.replace("檮原町","梼原町")

#三宅島,八丈島
jinko["time_pm"] = jinko["time_pm"].str.replace("三宅島","")
jinko["time_pm"] = jinko["time_pm"].str.replace("三宅支庁","")
jinko["time_pm"] = jinko["time_pm"].str.replace("八丈島","")
jinko["time_pm"] = jinko["time_pm"].str.replace("八丈支庁","")

#それ以外（合併による新設）は翌年度のデータ

miss_v = master[master["population"].isnull()][["year","time_pm"]].values
pd.concat([jinko[(jinko["year"] == miss_v[i][0]+1)&(jinko["time_pm"] == miss_v[i][1])] for i in range(len(miss_v))],axis=0)["year"]
len(miss_v)

miss_ele = master[master["population"].isnull()][["ele_ID"]].values
miss_ele = [miss_ele[i][0] for i in range(len(miss_ele))]

#上記を基に修正
master = pd.read_csv("master_datas/master_0520_1004_v2.csv",index_col=0)
master["year"] = master["year"].astype("int64")
master["jinko_year"] = master["year"]
master.loc[master["ele_ID"].isin(miss_ele),"jinko_year"] += 1
jinko = jinko.rename({"year":"jinko_year","pres_pm":"jinko_name"},axis=1)
new_mas = pd.merge(master,jinko,how="left",on=["time_pm","jinko_year"])
new_mas[new_mas["population"].isnull()]

jinko.to_csv("jinko_all.csv")
new_mas.to_csv("master_datas/master_0520_1004_v3.csv")

#所得
income = pd.read_csv("income_all.csv",index_col=0)
master = pd.read_csv("master_datas/master_0520_1004_v3.csv",index_col=0)

master["income_nendo"] = master["nendo"]
income = income.rename({"year":"income_nendo","地域":"income_name"},axis=1)
income["time_pm"] = income["income_name"].str.replace(" ","")
income["time_pm"] = income["time_pm"].str.replace("ケ","ヶ")
income["time_pm"] = income["time_pm"].str.replace("金ヶ崎","金ケ崎").str.replace("龍ヶ崎","龍ケ崎")
income.columns
income.loc[0,"taxed_income"]
income = income.iloc[:,1:]

a_20 = pd.read_excel("demographic_data/income_20_a.xlsx")
b_20 = pd.read_excel("demographic_data/income_20_b.xlsx")
tokyo = pd.read_csv("demographic_data/income_23ku.csv",encoding="cp932")

tokyo.columns = tokyo.iloc[0]
tokyo = tokyo.iloc[1:]
tokyo = tokyo.drop(["調査年 コード","/項目"],axis=1)
tokyo["nendo"] = tokyo["調査年"].str.replace("年度","").astype("int64")
tokyo = pd.concat([tokyo,tokyo["地域"].str.split(expand=True)],axis=1)
tokyo = tokyo.drop(["地域 コード","調査年"],axis=1)
tokyo.columns = income.columns[:7]
tokyo["taxed_income"] = tokyo["taxed_income"].astype("float64")
tokyo["taxed_popu_syotoku"] = tokyo["taxed_popu_syotoku"].astype("float64")
tokyo["taxed_popu_kinto"] = tokyo["taxed_popu_kinto"].replace("***",np.nan)
tokyo["taxed_popu_kinto"] = tokyo["taxed_popu_kinto"].astype("float64")

tokyo["income_per_syotokuwari"] = tokyo["taxed_income"]/tokyo["taxed_popu_syotoku"]
tokyo["time_pm"] = tokyo["prefecture"] + tokyo["municipality"]

income["taxed_popu_kinto"] = income["taxed_popu_kinto"].replace("***",np.nan).astype("float64")

income_l = pd.concat([income,tokyo],axis=0)

b_20 = b_20[b_20["表側"] == "市町村民税"]
a_20 = a_20[a_20["所得者区分"] == "計"]

b_20 = b_20[["都道府県名","団体名","課税対象所得"]]
a_20 = a_20[["都道府県名","団体名","均等割と所得割を納める者_納税義務者数","合計_均等割を納める者_納税義務者数"]]
i_20 = pd.merge(b_20,a_20,how="left",on=["都道府県名","団体名"])

i_20[i_20.isnull().any(axis=1)]
i_20.columns = ["prefecture","municipality","taxed_income","taxed_popu_syotoku","taxed_popu_kinto"]
i_20["taxed_income"] = i_20["taxed_income"].astype("float64")
i_20["taxed_popu_syotoku"] = i_20["taxed_popu_syotoku"].astype("float64")
i_20["taxed_popu_kinto"] = i_20["taxed_popu_kinto"].astype("float64")

i_20["income_per_syotokuwari"] = i_20["taxed_income"]/i_20["taxed_popu_syotoku"]
i_20["time_pm"] = i_20["prefecture"] + i_20["municipality"]
i_20["income_name"] = i_20["time_pm"]
i_20["income_nendo"] = 2020

income_l = pd.concat([income_l,i_20],axis=0)

income_l.to_csv("income_all.csv")

#1006
income_l = pd.read_csv("income_all.csv")
master = pd.read_csv("master_datas/master_0520_1004_v3.csv",index_col=0)
master["income_nendo"] = master["nendo"]
kari_m = pd.merge(master,income_l,how="left",on=["time_pm","income_nendo"])
kari_m[kari_m["taxed_income"].isnull()]["ele_ID"].values
income_l[income_l["time_pm"] == "高知県檮原町"] #漢字が原因
income_l[income_l["time_pm"] == "岩手県滝沢市"] #income_lは現在の市町村名に

income_l = income_l.rename({"time_pm":"pres_pm"},axis=1)
income_l["pres_pm"] = income_l["pres_pm"].str.replace("檮原町","梼原町")
income_l["pres_pm"] = income_l["pres_pm"].str.replace("袖ケ浦市","袖ヶ浦市")

income_l.to_csv("income_all.csv")

kari_m = pd.merge(master,income_l,how="left",on=["pres_pm","income_nendo"])
kari_m[kari_m["taxed_income"].isnull()]["ele_ID"].values
kari_m[kari_m["taxed_income"].isnull()]["pres_pm"].unique() #現在存在しない市町村　→　新たにデータが必要

kari_m[kari_m["taxed_income"].isnull()][["ele_ymd","pres_pm"]].to_csv("disappear_muni_l.csv")
master["disappear_dummy"] = 0
master.loc[kari_m["taxed_income"].isnull(),"disappear_dummy"] = 1
master.loc[kari_m["taxed_income"].isnull()]
master.to_csv("master_datas/master_0520_1007_v1.csv")

#1007
income_l = pd.read_csv("income_all.csv",index_col=0).iloc[:,1:]
master = pd.read_csv("master_datas/master_0520_1007_v1.csv",index_col=0)

income_d = pd.read_csv("demographic_data/demo_disa/income_disa.csv",encoding="cp932")
income_d.columns = income_d.iloc[0]
income_d = income_d.iloc[1:]
income_d = income_d.drop(["調査年 コード","地域 コード","/項目"],axis=1)
income_d["income_nendo"] = income_d["調査年"].str.replace("年度","").astype("int64")
income_d = income_d.drop("調査年",axis=1)
income_d = pd.concat([income_d,income_d["income_name"].str.split(expand=True)],axis=1)
income_d.columns = income_l.columns[:7]
income_d["prefecture"] = income_d["prefecture"].str.replace("（旧）","")
income_d["taxed_popu_kinto"] = income_d["taxed_popu_kinto"].replace("***",np.nan).astype("float64")
income_d = income_d.astype({"taxed_income":"float64","taxed_popu_syotoku":"float64"})
income_d["income_per_syotokuwari"] = income_d["taxed_income"]/income_d["taxed_popu_syotoku"]
income_d["pres_pm"] = income_d["prefecture"] + income_d["municipality"]

income_l = pd.concat([income_l,income_d],axis=0)
income_l.to_csv("income_all.csv")

kari_m = pd.merge(master,income_l,how="left",on=["pres_pm","income_nendo"])
kari_m[kari_m["taxed_income"].isnull()]["ele_ID"].values
master = kari_m
master.to_csv("master_datas/master_0520_1007_v1.csv")

#財政変数
zaisei = pd.read_csv("zaisei_all.csv",index_col=0)
zaisei.year.unique()
zaisei[zaisei["municipality"]=="篠山市"]
zaisei.iloc[:,2:7].dtypes

#()を抜く
import re
zaisei["keijyo_syusi_ratio"].loc[zaisei["keijyo_syusi_ratio"].str.match(r'\(|\)')] = zaisei["keijyo_syusi_ratio"][zaisei["keijyo_syusi_ratio"].str.match(r'\(|\)')].agg(lambda x:re.sub("\(|\)", "", x))
zaisei["zaiseiryoku_index"].loc[zaisei["zaiseiryoku_index"].str.match(r'\(|\)')] = zaisei["zaiseiryoku_index"][zaisei["zaiseiryoku_index"].str.match(r'\(|\)')].agg(lambda x:re.sub("\(|\)", "", x))
zaisei[zaisei["municipality"]=="千代田区"]

zaisei.iloc[:,2:7] = zaisei.iloc[:,2:7].replace('－',np.nan).replace('-',np.nan).astype("float64")
zaisei["syorai_hutan_ratio"] = zaisei["syorai_hutan_ratio"].replace('－',np.nan).replace('-',np.nan).astype("float64")
zaisei.dtypes

zaisei["time_pm"] = zaisei["prefecture"] + zaisei["municipality"]
zaisei["time_pm"] = zaisei["time_pm"].str.replace("ケ","ヶ")
zaisei["time_pm"] = zaisei["time_pm"].str.replace("金ヶ崎","金ケ崎").str.replace("龍ヶ崎","龍ケ崎")

zaisei = zaisei.rename({"year":"zaisei_nendo"},axis=1)
zaisei[zaisei["zaiseiryoku_index"].isnull()]
master["zaisei_nendo"] = master["nendo"]
kari_m = pd.merge(master,zaisei.iloc[:,2:],how="left",on=["zaisei_nendo","time_pm"])

kari_m[(kari_m["zaiseiryoku_index"].isnull()) & (kari_m["zaisei_nendo"] < 2020)]

zaisei[zaisei["time_pm"] == "東京都桧原村"]
zaisei[zaisei["time_pm"] == "長野県天竜村"]
zaisei[zaisei["time_pm"] == "愛知県長久手市"] #2011は長久手町に
zaisei[zaisei["time_pm"] == "島根県斐川町"]　#2011は欠損に
zaisei[zaisei["time_pm"] == "石川県野々市市"] #2011は野々市市に
zaisei["time_pm"] = zaisei["time_pm"].str.replace("桧原村","檜原村").str.replace("天竜村","天龍村")
zaisei.loc[(zaisei["time_pm"] == "愛知県長久手市")&(zaisei["zaisei_nendo"] == 2011),"time_pm"] = "愛知県長久手町"
zaisei.loc[(zaisei["time_pm"] == "石川県野々市市")&(zaisei["zaisei_nendo"] == 2011),"time_pm"] = "石川県野々市町"



demo_z =pd.read_csv("demographic_data/zaisei_variables_1.csv",encoding="cp932")
demo_z[demo_z["Unnamed: 3"] == "福岡県 福岡市"]

kari_m = pd.merge(master,zaisei.iloc[:,2:],how="left",on=["zaisei_nendo","time_pm"])

kari_m[(kari_m["zaiseiryoku_index"].isnull()) & (kari_m["zaisei_nendo"] < 2020)] #2011年島根県斐川町のみ欠損

#特別区は経常収支比率と財政力指数の計算方法が他と異なるので注意
master = kari_m
master.to_csv("master_datas/master_0520_1007_v2.csv")
zaisei.to_csv("zaisei_all.csv")




#分析用切り出し
first_half = master[master.columns[:61]]
second_half = master[master.columns[2373:]]
for_analy = pd.concat([first_half,second_half],axis=1)
for_analy["kokuji_ym"] = pd.to_datetime(for_analy["kokuji_dt"]).dt.strftime("%Y-%m")
for_analy.to_csv("master_datas/analysis_1004.csv")
