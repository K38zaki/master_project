import pandas as pd
import numpy as np
import datetime

#各データの取得時点の確認（合併前か後か）
master = pd.read_csv("master_datas/master_0520_1014_v1.csv",index_col=0)
master[master["pres_pm"] == "宮城県石巻市"]["population"]
master[master["pres_pm"] == "和歌山県田辺市"]["population"]
#population →　あかんそう　（合併年の選挙で合併前データが使われてる（その年の3月31日時点だから））

#income　→　7月1日（前年の所得金額でつまり額は合併前ということになるが、集計自体は合併後の市町村だから問題ないのかも）
master[master["pres_pm"] == "宮城県石巻市"][""]
master.columns[2425:]

#area　→　データはその年度の3月31日（全て合併後）

#menseki　→　データは10月1日

#zaisei　→　年度間（の年度の3月31日、全て合併後）


#合併期日の確認
gappei = pd.read_excel("gappei_list.xls",index_col=0)
gappei
gappei["関係市町村"].str.split("、",expand=True)
gappei_05 = gappei[gappei["合併期日"] > pd.datetime(year=2005,month=1,day=1)]

gappei_05.loc[136,"名称"] in gappei_05.loc[136,"関係市町村"]

for i in gappei_05.index:
    judge = gappei_05.loc[i,"名称"] in gappei_05.loc[i,"関係市町村"]
    gappei_05.loc[i,"継続"] = judge

gappei_kei = gappei_05[gappei_05["継続"] == True]
gappei_kei["pm"] = gappei_kei["都道府県"] + gappei_kei["名称"]
gappei_kei["合併期日"].dt.year

for i in gappei_kei.index:
    if gappei_kei.loc[i,"合併期日"].month > 3:
        gappei_kei.loc[i,"nendo"] = gappei_kei.loc[i,"合併期日"].year
    else:
        gappei_kei.loc[i,"nendo"] = gappei_kei.loc[i,"合併期日"].year - 1

gappei_kei

kei_mas = pd.concat([master[(master["time_pm"] == i[0])&(master["nendo"] == i[1])] for i in gappei_kei[["pm","nendo"]].values],axis=0)

kei_ymd = gappei_kei[["合併期日","pm","nendo"]]
kei_ymd = kei_ymd.rename({"合併期日":"gappei_ymd","pm":"time_pm"},axis=1)

kei_mas = pd.merge(kei_mas,kei_ymd,how="left",on=["time_pm","nendo"])
kei_mas[kei_mas["gappei_ymd"].isnull()]

before_gappei = kei_mas[kei_mas["gappei_ymd"] > pd.to_datetime(kei_mas["kokuji_ymd"],format='%Y%m%d')]
after_gappei = kei_mas[kei_mas["gappei_ymd"] <= pd.to_datetime(kei_mas["kokuji_ymd"],format='%Y%m%d')]

#population →　after_gappei「選挙が年内(4/1 - 12/31)」を修正, before_gappei「選挙が年明け(1/1 - 3/31)」
#income →　after_gappei「合併が7月1日以降」を修正、before_gappei「合併が7月1日以前」を修正
#zaisei →　before_gappei「全て」修正
#area →　before_gappei「全て」修正
#menseki →　after_gappei「合併が10月1日以降」を修正、before_gappei「合併が10月1日以前」を修正

jin_st = before_gappei.columns.tolist().index("jinko_year")
inc_st = before_gappei.columns.tolist().index("income_nendo") 
zai_st = before_gappei.columns.tolist().index("zaisei_nendo")
are_st = before_gappei.columns.tolist().index("area_nendo")
men_st = before_gappei.columns.tolist().index("menseki_nendo")
after_gappei.columns[men_st:]

#jinko
jinko_all = pd.read_csv("jinko_all.csv",index_col=0)
#before_gappei（選挙が年明け） →　なし
before_gappei[pd.to_datetime(before_gappei["kokuji_dt"]).dt.month.isin([1,2,3])]
#after_gappei（選挙が年内）
fix_df = after_gappei[pd.to_datetime(after_gappei["kokuji_dt"]).dt.month.isin(list(range(4,13)))]
fix_df["jinko_year"] = fix_df["jinko_year"] + 1 #選挙時は合併済み　→　翌年のデータを使う
pd.merge(fix_df,jinko_all,how="left",on=["jinko_year","time_pm"]).iloc[:,after_gappei.shape[1]:] #修正後の値DF

after_gappei.loc[pd.to_datetime(after_gappei["kokuji_dt"]).dt.month.isin(list(range(4,13))),after_gappei.columns[jin_st+1:inc_st]] = pd.merge(fix_df,jinko_all,how="left",on=["jinko_year","time_pm"]).iloc[:,after_gappei.shape[1]:].values

after_gappei.loc[pd.to_datetime(after_gappei["kokuji_dt"]).dt.month.isin(list(range(4,13))),after_gappei.columns[jin_st+1:inc_st]] 

after_gappei.loc[pd.to_datetime(after_gappei["kokuji_dt"]).dt.month.isin(list(range(4,13))),"jinko_year"] = after_gappei.loc[pd.to_datetime(after_gappei["kokuji_dt"]).dt.month.isin(list(range(4,13))),"jinko_year"] + 1

after_gappei.loc[pd.to_datetime(after_gappei["kokuji_dt"]).dt.month.isin(list(range(4,13))),"jinko_year"]
del jinko_all

#income　
income_all = pd.read_csv("income_all.csv",index_col=0)
income_all["income_nendo"].unique()
#before_gappei「合併が7月1日以前」を修正 →　なし
before_gappei[before_gappei["gappei_ymd"].dt.month.isin([4,5,6])]
before_gappei
#after_gappei「合併が7月1日以降」を修正 →　所得は年による変動が大きいので欠損にしちゃうか
fix_df = after_gappei[pd.to_datetime(after_gappei["kokuji_dt"]).dt.month.isin([1,2,3,7,8,9,10,11,12])]
#そもそも、各年度の値は「前年の所得」なのでいったん保留

del income_all

#zaisei
#before_gappei「全て」修正 　→　前年度の数値で置き換えるのは性質上妥当じゃないので欠損に
before_gappei.loc[:,before_gappei.columns[zai_st]] = before_gappei.loc[:,before_gappei.columns[zai_st]] - 1
before_gappei.loc[:,before_gappei.columns[zai_st+1:are_st]] = np.nan
before_gappei.loc[:,before_gappei.columns[zai_st+1:are_st]]

#area
area_all = pd.read_csv("area_all.csv",index_col=0)
#before_gappei「全て」修正 →　前年度で置き換え
before_gappei["area_nendo"] = before_gappei["area_nendo"] - 1
pd.merge(before_gappei,area_all,how="left",on=["area_nendo","time_pm"]).iloc[:,after_gappei.shape[1]:] #修正後の値DF
before_gappei.loc[:,before_gappei.columns[are_st+1:are_st+12]] = pd.merge(before_gappei,area_all,how="left",on=["area_nendo","time_pm"]).iloc[:,after_gappei.shape[1]:].values
before_gappei.loc[:,before_gappei.columns[are_st+1:are_st+12]] = before_gappei.loc[:,before_gappei.columns[are_st+1:are_st+12]].replace(np.nan,0)
before_gappei.loc[:,before_gappei.columns[are_st+1:are_st+12]]

del area_all

#menseki
menseki_all = pd.read_csv("menseki_all.csv",index_col=0)
menseki_all
#before_gappei「合併が10月1日以前」を修正 →　あり,前年度で
fix_df = before_gappei[(before_gappei["gappei_ymd"].dt.month.isin([4,5,6,7,8,9]))|((before_gappei["gappei_ymd"].dt.month == 10)&(before_gappei["gappei_ymd"].dt.day == 1))]
fix_df["menseki_nendo"] = fix_df["menseki_nendo"] - 1
pd.merge(fix_df,menseki_all,how="left",on=["menseki_nendo","time_pm"]).iloc[:,before_gappei.shape[1]:] #修正後の値DF

before_gappei.loc[((before_gappei["gappei_ymd"].dt.month == 10)&(before_gappei["gappei_ymd"].dt.day == 1)),before_gappei.columns[men_st+1:men_st+7]] = pd.merge(fix_df,menseki_all,how="left",on=["menseki_nendo","time_pm"]).iloc[:,before_gappei.shape[1]:].values

before_gappei.loc[((before_gappei["gappei_ymd"].dt.month == 10)&(before_gappei["gappei_ymd"].dt.day == 1)),before_gappei.columns[men_st+1:men_st+7]]
before_gappei.loc[((before_gappei["gappei_ymd"].dt.month == 10)&(before_gappei["gappei_ymd"].dt.day == 1)),"menseki_nendo"] = 2004

before_gappei.loc[((before_gappei["gappei_ymd"].dt.month == 10)&(before_gappei["gappei_ymd"].dt.day == 1)),"menseki_nendo"]
#after_gappei「合併が10月2日以降」を修正 →　翌年度のデータ
fix_df = after_gappei[((after_gappei["gappei_ymd"].dt.month.isin([1,2,3,11,12]))|((after_gappei["gappei_ymd"].dt.month == 10)&(after_gappei["gappei_ymd"].dt.day != 1)))]
fix_df["menseki_nendo"] = fix_df["menseki_nendo"] + 1
pd.merge(fix_df,menseki_all,how="left",on=["menseki_nendo","time_pm"]).iloc[:,after_gappei.shape[1]:] #修正後の値DF

after_gappei.loc[((after_gappei["gappei_ymd"].dt.month.isin([1,2,3,11,12]))|((after_gappei["gappei_ymd"].dt.month == 10)&(after_gappei["gappei_ymd"].dt.day != 1))),after_gappei.columns[men_st+1:men_st+7]] = pd.merge(fix_df,menseki_all,how="left",on=["menseki_nendo","time_pm"]).iloc[:,before_gappei.shape[1]:].values

after_gappei.loc[((after_gappei["gappei_ymd"].dt.month.isin([1,2,3,11,12]))|((after_gappei["gappei_ymd"].dt.month == 10)&(after_gappei["gappei_ymd"].dt.day != 1))),after_gappei.columns[men_st+1:men_st+7]]
after_gappei.loc[((after_gappei["gappei_ymd"].dt.month.isin([1,2,3,11,12]))|((after_gappei["gappei_ymd"].dt.month == 10)&(after_gappei["gappei_ymd"].dt.day != 1))),"menseki_nendo"] = fix_df["menseki_nendo"].values

after_gappei.loc[((after_gappei["gappei_ymd"].dt.month.isin([1,2,3,11,12]))|((after_gappei["gappei_ymd"].dt.month == 10)&(after_gappei["gappei_ymd"].dt.day != 1))),"menseki_nendo"]

#mensekiとarea両方使うやつ
before_gappei["sigaika_ratio_area"] = before_gappei["sigaika_area"]/before_gappei["all_menseki"]
after_gappei["sigaika_ratio_area"] = after_gappei["sigaika_area"]/after_gappei["all_menseki"]

before_gappei["industrial_ratio_area"] = (before_gappei["industrial"] + before_gappei["industrial_only"])/before_gappei["all_menseki"]
after_gappei["industrial_ratio_area"] = (after_gappei["industrial"] + after_gappei["industrial_only"])/after_gappei["all_menseki"]

before_gappei["commerce_ratio_area"] = before_gappei["commerce"]/before_gappei["all_menseki"] 
after_gappei["commerce_ratio_area"] = after_gappei["commerce"]/after_gappei["all_menseki"] 

#masterに置き換え
master.loc[master["ele_ID"].isin(before_gappei["ele_ID"].to_list()),master.columns[jin_st:]] = before_gappei.loc[:,master.columns[jin_st:]].values

master.loc[master["ele_ID"].isin(after_gappei["ele_ID"].to_list()),master.columns[jin_st:]] = after_gappei.loc[:,master.columns[jin_st:]].values

master.loc[master["ele_ID"].isin(before_gappei["ele_ID"].to_list()),"gappei_ymd"] = before_gappei.loc[:,"gappei_ymd"].values
master.loc[master["ele_ID"].isin(after_gappei["ele_ID"].to_list()),"gappei_ymd"] = after_gappei.loc[:,"gappei_ymd"].values

master.to_csv("master_datas/master_0520_1020.csv")

#1021
master = pd.read_csv("master_datas/master_0520_1020.csv",index_col=0)
gappei = master[master["gappei_ymd"].isnull()==False]
before_gappei = gappei[pd.to_datetime(gappei["gappei_ymd"]) > pd.to_datetime(gappei["kokuji_ymd"],format='%Y%m%d')]
after_gappei = gappei[pd.to_datetime(gappei["gappei_ymd"]) <= pd.to_datetime(gappei["kokuji_ymd"],format='%Y%m%d')]
before_gappei
after_gappei
before_gappei["gappei_ymd"] = pd.to_datetime(before_gappei["gappei_ymd"])
after_gappei["gappei_ymd"] = pd.to_datetime(after_gappei["gappei_ymd"])
after_gappei["gappei_ymd"]
inc_st = after_gappei.columns.tolist().index("income_nendo") 
zai_st = after_gappei.columns.tolist().index("zaisei_nendo")

#income →　その年度と前年の両方を変数として追加しよう
#「その年度」の修正
income_all = pd.read_csv("income_all.csv",index_col=0)
income_all["income_nendo"].unique()
#before_gappei「合併が7月1日以前」を修正 →　なし
before_gappei[before_gappei["gappei_ymd"].dt.month.isin([4,5,6])|((after_gappei["gappei_ymd"].dt.month == 7)&(after_gappei["gappei_ymd"].dt.day != 1))]
before_gappei
#after_gappei「合併が7月2日以降」を修正 →　所得は年による変動が大きいので欠損にする
after_gappei[((after_gappei["gappei_ymd"].dt.month.isin([1,2,3,8,9,10,11,12]))|((after_gappei["gappei_ymd"].dt.month == 7)&(after_gappei["gappei_ymd"].dt.day != 1)))]
after_gappei.loc[((after_gappei["gappei_ymd"].dt.month.isin([1,2,3,8,9,10,11,12]))|((after_gappei["gappei_ymd"].dt.month == 7)&(after_gappei["gappei_ymd"].dt.day != 1))),"income_nendo"] = after_gappei.loc[((after_gappei["gappei_ymd"].dt.month.isin([1,2,3,8,9,10,11,12]))|((after_gappei["gappei_ymd"].dt.month == 7)&(after_gappei["gappei_ymd"].dt.day != 1))),"income_nendo"] + 1
after_gappei.loc[((after_gappei["gappei_ymd"].dt.month.isin([1,2,3,8,9,10,11,12]))|((after_gappei["gappei_ymd"].dt.month == 7)&(after_gappei["gappei_ymd"].dt.day != 1))),after_gappei.columns[inc_st+3:inc_st+6]] = np.nan
after_gappei.loc[((after_gappei["gappei_ymd"].dt.month.isin([1,2,3,8,9,10,11,12]))|((after_gappei["gappei_ymd"].dt.month == 7)&(after_gappei["gappei_ymd"].dt.day != 1))),after_gappei.columns[inc_st+8]] = np.nan
after_gappei.loc[:,after_gappei.columns[inc_st:zai_st]]

#masterに置き換え
master.loc[master["ele_ID"].isin(after_gappei["ele_ID"].to_list()),master.columns[inc_st:zai_st]]
master.loc[master["ele_ID"].isin(after_gappei["ele_ID"].to_list()),master.columns[inc_st:zai_st]] = after_gappei.loc[:,master.columns[inc_st:zai_st]].values

master.to_csv("master_datas/master_0520_1021_v1.csv")

#「前年」の追加
income_all["income_pre_year"] = income_all["income_nendo"] - 1
income_all["pres_pm"] = income_all["pres_pm"].str.replace("ケ","ヶ").str.replace("金ヶ崎","金ケ崎").str.replace("龍ヶ崎","龍ケ崎")
income_p = income_all.drop(["income_name","prefecture","municipality"],axis=1)
income_p.columns = ["taxed_income_time","taxed_popu_syotoku_time","taxed_popu_kinto","income_nendo","income_per_syotokuwari_time","pres_pm","income_time_year"]

master["income_time_year"] = master["year"]
kari_m = pd.merge(master,income_p,how="left",on=["pres_pm","income_time_year"])
kari_m[(kari_m["taxed_income_time"].isnull())&(kari_m["year"] < 2020)]
master = kari_m
master[(master["taxed_income_time"].isnull())&(master["year"] < 2020)]

#合併期日の確認(年バージョンの合併イヤーのマッチング)

gappei = pd.read_excel("gappei_list.xls",index_col=0)
gappei
gappei["関係市町村"].str.split("、",expand=True)
gappei_05 = gappei[gappei["合併期日"] > pd.datetime(year=2005,month=1,day=1)]

gappei_05.loc[136,"名称"] in gappei_05.loc[136,"関係市町村"]

for i in gappei_05.index:
    judge = gappei_05.loc[i,"名称"] in gappei_05.loc[i,"関係市町村"]
    gappei_05.loc[i,"継続"] = judge

gappei_kei = gappei_05[gappei_05["継続"] == True]
gappei_kei["pm"] = gappei_kei["都道府県"] + gappei_kei["名称"]
gappei_kei["year"] = gappei_kei["合併期日"].dt.year
gappei_kei["pm"].unique()

master[master["time_pm"] == "岐阜県中津川市"]
gappei_kei[gappei_kei["pm"].str.contains("中津川市")]

#選挙年に合併
kei_mas = pd.concat([master[(master["time_pm"] == i[0])&(master["year"] == i[1])] for i in gappei_kei[["pm","year"]].values],axis=0)
kei_ymd = gappei_kei[["合併期日","pm","year"]]
kei_ymd = kei_ymd.rename({"合併期日":"gappei_ymd","pm":"time_pm"},axis=1)
kei_mas = pd.merge(kei_mas,kei_ymd,how="left",on=["time_pm","year"])
kei_mas
before_gappei = kei_mas[kei_mas["gappei_ymd_y"] > pd.to_datetime(kei_mas["kokuji_ymd"],format='%Y%m%d')]

#選挙年の翌年の7月1日までに合併
master["next_year"] = master["year"] + 1
kei_mas = pd.concat([master[(master["time_pm"] == i[0])&(master["next_year"] == i[1])] for i in gappei_kei[["pm","year"]].values],axis=0)
kei_ymd = gappei_kei[["合併期日","pm","year"]]
kei_ymd = kei_ymd.rename({"合併期日":"next_gappei_ymd","pm":"time_pm"},axis=1)
kei_mas = pd.merge(kei_mas,kei_ymd,how="left",left_on=["time_pm","next_year"],right_on=["time_pm","year"])
next_gappei = kei_mas[kei_mas["next_gappei_ymd"].dt.month.isin([1,2,3,4,5,6])|((kei_mas["next_gappei_ymd"].dt.month == 7)&(kei_mas["next_gappei_ymd"].dt.day == 1))]
next_gappei

#income「前年」
#before_gappeiに関してはすべて修正（欠損に）
before_gappei.loc[:,"income_time_year"] = before_gappei.loc[:,"income_time_year"] - 1
before_gappei.loc[:,before_gappei.columns[-6:-1]] = np.nan
before_gappei
#next_gappeiに関してはすべて修正（欠損に）
next_gappei.loc[:,"income_time_year"] = next_gappei.loc[:,"income_time_year"] - 1
next_gappei.loc[:,next_gappei.columns[-8:-3]] = np.nan

#masterに置き換え
master.loc[master["ele_ID"].isin(before_gappei["ele_ID"].to_list()),master.columns[-6:-1]]
master.loc[master["ele_ID"].isin(before_gappei["ele_ID"].to_list()),master.columns[-6:-1]] = before_gappei.loc[:,master.columns[-6:-1]].values
master.loc[master["ele_ID"].isin(next_gappei["ele_ID"].to_list()),master.columns[-6:-1]] = next_gappei.loc[:,master.columns[-8:-3]].values

master.loc[master["ele_ID"].isin(next_gappei["ele_ID"].to_list()),master.columns[-6:-1]]

master = master.rename({"taxed_popu_kinto_y":"taxed_popu_kinto_time","income_nendo_x":"income_nendo"},axis=1)
master = master.drop("income_nendo_y",axis=1)

master.to_csv("master_datas/master_0520_1021_v2.csv")

#投票率
for i in master.index:
    if (master.loc[i,"voting_rate"] != "無投票"):
        master.loc[i,"voting_rate_isna"] = master.loc[i,"voting_rate"]
    else:
        master.loc[i,"voting_rate_isna"] = np.nan

master["voting_rate_isna"]

#分析用切り出し
master.columns[2374:]
first_half = master[master.columns[:61]]
second_half = master[master.columns[2374:]]
for_analy = pd.concat([first_half,second_half],axis=1)
for_analy.to_csv("master_datas/analysis_1018.csv")


