import numpy as np
import pandas as pd

pref_1 = pd.read_csv("elec_data/gikai_pref_1.csv")
len(pref_1["ele_ymd"].unique())
pref_1["ele_ymd"].unique()
pref_1["gen"]
pref_1.columns

## groupby()
#選挙ごとの立候補者数
pref_1.groupby("ele_ymd").size()

#選挙ごとの当選者数
pref_1.groupby("ele_ymd").sum()["win"]

#選挙ごとの投票率
pref_1.groupby("ele_ymd").mean()["e_voting_rate"] # →ダメ

pref_1["id"] = pref_1.index

## 選挙リストで for loop 
#選挙リスト
ele_ymd_l = pref_1["ele_ymd"].unique()

#選挙ごとの立候補者数
pref_1[pref_1["ele_ymd"] == ele_ymd_l[0]].count()["name_kanji"]
pref_1[pref_1["ele_ymd"] == ele_ymd_l[0]]["e_n_candidates"][0]

#選挙ごとの当選者数
pref_1[pref_1["ele_ymd"] == ele_ymd_l[0]].sum()["win"]
pref_1[pref_1["ele_ymd"] == ele_ymd_l[0]]["e_seats_target"][0]

#選挙ごとの競争率
pref_1[pref_1["ele_ymd"] == ele_ymd_l[0]]["e_competitive_ratio"][0]

#選挙ごとの投票率
pref_1[pref_1["ele_ymd"] == ele_ymd_l[0]]["e_voting_rate"][0]

#選挙ごとの立候補者平均年齢
pref_1[pref_1["ele_ymd"] == ele_ymd_l[0]]["age"].mean()

#選挙ごとの当選者平均年齢
pref_1[pref_1["ele_ymd"] == ele_ymd_l[0]][pref_1["win"] == True]["age"].mean()

#選挙ごとの立候補者に占める女性割合
(pref_1[pref_1["ele_ymd"] == ele_ymd_l[0]]["gen"] == "女").mean()

#選挙ごとの当選者に占める女性割合
(pref_1[pref_1["ele_ymd"] == ele_ymd_l[0]][pref_1["win"] == True]["gen"] == "女").mean()


#選挙ごとの政党別得票数
pref_1[pref_1["ele_ymd"] == ele_ymd_l[0]].groupby("circle").sum()["n_votes"]
