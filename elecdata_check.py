import numpy as np
import pandas as pd

pref_1 = pd.read_csv("elec_data/gikai_pref_1.csv")
len(pref_1["ele_ymd"].unique())
pref_1["ele_ymd"].unique()
pref_1["gen"]
pref_1.columns
pref_1["id"] = pref_1.index

## as it is (元csvからそのまま使える変数)　→　groupby().first()で取得してしまう

#各選挙の一人目の候補者の情報
pref_1.groupby("ele_ymd").first()

#そのまま使う変数のリスト
asitis_l = ['election', 'prefecture', 'municipality','voting_ymd', 'year', 'month', 'day', 'kokuji_ymd','e_voting_rate','e_seats_target','e_n_candidates','e_competitive_ratio', 'e_all_voter', 'e_male_all_voter','e_female_all_voter','e_change_all_voter', 'e_reason', 'e_pre_v_rate','e_pre_seats_t', 'e_pre_n_cand', 'e_pre_compe_rate']

asitis_df = pref_1.groupby("ele_ymd").first()[asitis_l].reset_index()


## 選挙リストで for loop 
#選挙リスト
ele_ymd_l = pref_1["ele_ymd"].unique()

target_df = pref_1[pref_1["ele_ymd"] == ele_ymd_l[0]]

#選挙名＋年月日
ele_ymd_l[0]

#選挙名
pref_1[pref_1["ele_ymd"] == ele_ymd_l[0]]["election"][0]

#欠損値判定
pref_1[pref_1["ele_ymd"] == ele_ymd_l[0]].isnull().any()

#都道府県
pref_1[pref_1["ele_ymd"] == ele_ymd_l[0]]["prefecture"][0]

#市町村
pref_1[pref_1["ele_ymd"] == ele_ymd_l[0]]["municipality"][0]

#年月日
pref_1[pref_1["ele_ymd"] == ele_ymd_l[0]]["voting_ymd"][0]

#年
pref_1[pref_1["ele_ymd"] == ele_ymd_l[0]]["year"][0]

#月
pref_1[pref_1["ele_ymd"] == ele_ymd_l[0]]["month"][0]

#日
pref_1[pref_1["ele_ymd"] == ele_ymd_l[0]]["day"][0]

#告示年月日
int(pref_1[pref_1["ele_ymd"] == ele_ymd_l[0]]["kokuji_ymd"][0])

#選挙区数
pref_1[pref_1["ele_ymd"] == ele_ymd_l[0]].groupby("district").size().size

#選挙ごとの立候補者数
pref_1[pref_1["ele_ymd"] == ele_ymd_l[0]].count()["id"]
pref_1[pref_1["ele_ymd"] == ele_ymd_l[0]]["e_n_candidates"][0]

#選挙ごとの定数
pref_1[pref_1["ele_ymd"] == ele_ymd_l[0]]["e_seats_target"][0]

#選挙ごとの当選者数
pref_1[pref_1["ele_ymd"] == ele_ymd_l[0]].sum()["win"]

#選挙ごとの競争率
pref_1[pref_1["ele_ymd"] == ele_ymd_l[0]]["e_competitive_ratio"][0]
pref_1[pref_1["ele_ymd"] == ele_ymd_l[0]].count()["id"]/pref_1[pref_1["ele_ymd"] == ele_ymd_l[0]].sum()["win"]

#選挙ごとの立候補者平均年齢
pref_1[pref_1["ele_ymd"] == ele_ymd_l[0]]["age"].mean()

#選挙ごとの当選者平均年齢
pref_1[pref_1["ele_ymd"] == ele_ymd_l[0]][pref_1["win"] == True]["age"].mean()

#選挙ごとの立候補者に占める女性割合
(pref_1[pref_1["ele_ymd"] == ele_ymd_l[0]]["gen"] == "女").mean()

#選挙ごとの当選者に占める女性割合
(pref_1[pref_1["ele_ymd"] == ele_ymd_l[0]][pref_1["win"] == True]["gen"] == "女").mean()

#選挙ごとの立候補者数に占める現職・新人・元職割合
#現職
pref_1[pref_1["ele_ymd"] == ele_ymd_l[0]].groupby("status").size().loc["現職"]/sum(pref_1[pref_1["ele_ymd"] == ele_ymd_l[0]].groupby("status").size())
#新人
pref_1[pref_1["ele_ymd"] == ele_ymd_l[0]].groupby("status").size().loc["新人"]/sum(pref_1[pref_1["ele_ymd"] == ele_ymd_l[0]].groupby("status").size())
#元職
pref_1[pref_1["ele_ymd"] == ele_ymd_l[0]].groupby("status").size().loc["元職"]/sum(pref_1[pref_1["ele_ymd"] == ele_ymd_l[0]].groupby("status").size())


#選挙ごとの当選者数に占める現職・新人・元職割合
#現職
pref_1[pref_1["ele_ymd"] == ele_ymd_l[0]].groupby("status").sum()["win"].loc["現職"]/sum(pref_1[pref_1["ele_ymd"] == ele_ymd_l[0]].groupby("status").sum()["win"])
#新人
pref_1[pref_1["ele_ymd"] == ele_ymd_l[0]].groupby("status").sum()["win"].loc["新人"]/sum(pref_1[pref_1["ele_ymd"] == ele_ymd_l[0]].groupby("status").sum()["win"])
#元職
pref_1[pref_1["ele_ymd"] == ele_ymd_l[0]].groupby("status").sum()["win"].loc["元職"]/sum(pref_1[pref_1["ele_ymd"] == ele_ymd_l[0]].groupby("status").sum()["win"])

#選挙ごとの現職・新人・元職得票率
#現職
pref_1[pref_1["ele_ymd"] == ele_ymd_l[0]].groupby("status").sum()["n_votes"].loc["現職"]/sum(pref_1[pref_1["ele_ymd"] == ele_ymd_l[0]].groupby("status").sum()["n_votes"])
#新人
pref_1[pref_1["ele_ymd"] == ele_ymd_l[0]].groupby("status").sum()["n_votes"].loc["新人"]/sum(pref_1[pref_1["ele_ymd"] == ele_ymd_l[0]].groupby("status").sum()["n_votes"])
#元職
pref_1[pref_1["ele_ymd"] == ele_ymd_l[0]].groupby("status").sum()["n_votes"].loc["元職"]/sum(pref_1[pref_1["ele_ymd"] == ele_ymd_l[0]].groupby("status").sum()["n_votes"])

#選挙ごとの現職・新人・元職の候補1人当たり平均得票率
#現職
(pref_1[pref_1["ele_ymd"] == ele_ymd_l[0]].groupby("status").sum()["n_votes"].loc["現職"]/sum(pref_1[pref_1["ele_ymd"] == ele_ymd_l[0]].groupby("status").sum()["n_votes"]))/pref_1[pref_1["ele_ymd"] == ele_ymd_l[0]][pref_1["win"] == True].groupby("status").size().loc["現職"]
#新人
(pref_1[pref_1["ele_ymd"] == ele_ymd_l[0]].groupby("status").sum()["n_votes"].loc["新人"]/sum(pref_1[pref_1["ele_ymd"] == ele_ymd_l[0]].groupby("status").sum()["n_votes"]))/pref_1[pref_1["ele_ymd"] == ele_ymd_l[0]][pref_1["win"] == True].groupby("status").size().loc["新人"]
#元職
(pref_1[pref_1["ele_ymd"] == ele_ymd_l[0]].groupby("status").sum()["n_votes"].loc["元職"]/sum(pref_1[pref_1["ele_ymd"] == ele_ymd_l[0]].groupby("status").sum()["n_votes"]))/pref_1[pref_1["ele_ymd"] == ele_ymd_l[0]][pref_1["win"] == True].groupby("status").size().loc["元職"]

#選挙ごとの総有効得票数
pref_1[pref_1["ele_ymd"] == ele_ymd_l[0]]["n_votes"].sum()


#選挙ごとの政党数
pref_1[pref_1["ele_ymd"] == ele_ymd_l[0]].groupby("circle").size().size

#選挙ごとの選挙理由
pref_1[pref_1["ele_ymd"] == ele_ymd_l[0]]["e_reason"][0]

#選挙ごとの投票率
try:
    float(pref_1[pref_1["ele_ymd"] == ele_ymd_l[0]]["e_voting_rate"][0])
except:
    pref_1[pref_1["ele_ymd"] == ele_ymd_l[0]]["e_voting_rate"][0]
    
#選挙ごとの無投票変数
#無投票ダミー
#no_voting = 1 if pref_1[pref_1["ele_ymd"] == ele_ymd_l[0]]["e_voting_rate"][0] == "無投票" else 0
#無投票当選者の割合
no_voting_ratio_win = pref_1[pref_1["ele_ymd"] == ele_ymd_l[0]][pref_1["d_voting_rate"]=="無投票"].shape[0]/pref_1[pref_1["ele_ymd"] == ele_ymd_l[0]].count()["id"]
#無投票で決定の選挙区の割合
no_voting_ratio_districs = (pref_1[pref_1["ele_ymd"] == ele_ymd_l[0]].groupby("district").first()["d_voting_rate"] == "無投票").mean()


#選挙ごとの有権者数
pref_1[pref_1["ele_ymd"] == ele_ymd_l[0]]["e_all_voter"][0]

#選挙ごとの男性有権者数
pref_1[pref_1["ele_ymd"] == ele_ymd_l[0]]["e_male_all_voter"][0]

#選挙ごとの女性有権者数
pref_1[pref_1["ele_ymd"] == ele_ymd_l[0]]["e_female_all_voter"][0]

#選挙ごとの有権者数増分
pref_1[pref_1["ele_ymd"] == ele_ymd_l[0]]["e_change_all_voter"][0]

#選挙ごとの前回投票率
pref_1[pref_1["ele_ymd"] == ele_ymd_l[0]]["e_pre_v_rate"][0]

#選挙ごとの前回定数
pref_1[pref_1["ele_ymd"] == ele_ymd_l[0]]["e_pre_seats_t"][0]

#選挙ごとの前回立候補者数
pref_1[pref_1["ele_ymd"] == ele_ymd_l[0]]["e_pre_n_cand"][0]

#選挙ごとの前回競争率
pref_1[pref_1["ele_ymd"] == ele_ymd_l[0]]["e_pre_compe_rate"][0]


##政党別
#全政党リスト
pref_1["circle"].unique()

base = pd.DataFrame(pref_1["circle"].unique(),columns=["circle"])


#選挙ごとの政党別得票率
tokuhyo_cir = pref_1[pref_1["ele_ymd"] == ele_ymd_l[0]].groupby("circle").sum()["n_votes"]/sum(pref_1[pref_1["ele_ymd"] == ele_ymd_l[0]].groupby("circle").sum()["n_votes"])
tokuhyo_cir = tokuhyo_cir.rename(ele_ymd_l[0])

pd.merge(base,tokuhyo_cir,on="circle",how="outer")

#選挙ごとの政党別立候補者数
ncand_cir = pref_1[pref_1["ele_ymd"] == ele_ymd_l[0]].groupby("circle").size()
ncand_cir = ncand_cir.rename(ele_ymd_l[0])

pd.merge(base,ncand_cir,on="circle",how="outer")

#選挙ごとの政党別候補1人当たり平均得票率
avehyo_cir = (pref_1[pref_1["ele_ymd"] == ele_ymd_l[0]].groupby("circle").sum()["n_votes"]/sum(pref_1[pref_1["ele_ymd"] == ele_ymd_l[0]].groupby("circle").sum()["n_votes"]))/(pref_1[pref_1["ele_ymd"] == ele_ymd_l[0]].groupby("circle").size())
avehyo_cir = avehyo_cir.rename(ele_ymd_l[0])

pd.merge(base,avehyo_cir,on="circle",how="outer")

#選挙ごとの政党別当選者数
nwin_cir = pref_1[pref_1["ele_ymd"] == ele_ymd_l[0]].groupby("circle").sum()["win"]
nwin_cir = nwin_cir.rename(ele_ymd_l[0])

pd.merge(base,nwin_cir,on="circle",how="outer")

