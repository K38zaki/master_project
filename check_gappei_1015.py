import pandas as pd
import numpy as np
import datetime

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


pd.concat([master[(master["time_pm"] == i[0])&(master["nendo"] == i[1])] for i in gappei_kei[["pm","nendo"]].values],axis=0)

master = pd.read_csv("master_datas/master_0520_1014_v1.csv",index_col=0)
master[master["pres_pm"] == "宮城県石巻市"]["population"]
master[master["pres_pm"] == "和歌山県田辺市"]["population"]
#population →　あかんそう　（合併年の選挙で合併前データが使われてる（その年の3月31日時点だから））

#income
master[master["pres_pm"] == "宮城県石巻市"][""]
master.columns[2425:]

#area　→　データはその年度の3月31日（全て合併後）

#menseki　→　データは10月1日

#zaisei　→　年度間

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


