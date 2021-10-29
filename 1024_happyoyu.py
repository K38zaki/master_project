import numpy as np 
import pandas as pd
import datetime

%cd theses_codes
master = pd.read_csv("master_datas/master_0520_1021_v2.csv",index_col=0)
master
master.groupby("ele_ID").count()["ori_No"][master.groupby("ele_ID").count()["ori_No"] > 1] ##重複しているele_ID
master[master["gappei_ymd"].isnull()==False]["ele_ID"] #合併で修正した「ele_ID」は重複なかったのでOK

#重複を避ける新indexの作成
master = master.rename({"ele_ID":"city_ele"},axis=1)
new_id = master["prefecture_x"] + master["city_ele"]
master.insert(0,"ele_ID",new_id)
master

#政党情報
#無所属議員の特定
col_wins_df = pd.DataFrame([list(master.columns),["当選者数" in i for i in master.columns],["所属" in i for i in master.columns]]).T
col_cand_df = pd.DataFrame([list(master.columns),["立候補者数" in i for i in master.columns],["所属" in i for i in master.columns]]).T

musyozoku_p = list(col_cand_df[(col_cand_df[1])&(col_cand_df[2])][0].values)


#「無所属」の定義: 上記の3所属「無所属」「無所属の会」「純粋無所属全国ネット」]
master

#候補者に占める無所属議員の割合
cand_party = master[["ele_ID"]+list(col_cand_df[(col_cand_df[1])][0].values)]
cand_p_nan = cand_party[(cand_party.isnull() == False).iloc[:,1:].sum(axis=1) == 0]
cand_p_ari = cand_party[(cand_party.isnull() == False).iloc[:,1:].sum(axis=1) != 0]

cand_p_ari = cand_p_ari[cand_p_ari['立候補者数_\u3000'].isnull()] #政党名「\u3000」が存在する選挙を除外

cand_p_ari[cand_p_ari.sum(axis=1).isnull()]
cand_p_ari[cand_p_ari.sum(axis=1) == 0] #合計候補者数、0及びnanはなし
cand_p_ari["ncand_party_sum"] = cand_p_ari.sum(axis=1)

cand_p_ari[cand_p_ari[musyozoku_p].sum(axis=1).isnull()]
cand_p_ari[cand_p_ari[musyozoku_p].sum(axis=1) == 0] #無所属候補者数、0及びnanはなし
cand_p_ari["ncand_musyozoku_sum"] = cand_p_ari[musyozoku_p].sum(axis=1)

cand_p_ari["cand_ratio_musyozoku"] = cand_p_ari["ncand_musyozoku_sum"]/cand_p_ari["ncand_party_sum"]
cand_p_ari["cand_ratio_musyozoku"]

master.groupby("ele_ID").count()["ori_No"][master.groupby("ele_ID").count()["ori_No"] > 1] #重複indexは無し
master

master.loc[master["ele_ID"].isin(cand_p_ari["ele_ID"].to_list()),"cand_ratio_musyozoku"] = cand_p_ari["cand_ratio_musyozoku"].values
master.loc[master["ele_ID"].isin(cand_p_ari["ele_ID"].to_list()),"ncand_musyozoku_sum"] = cand_p_ari["ncand_musyozoku_sum"].values
master.loc[master["ele_ID"].isin(cand_p_ari["ele_ID"].to_list()),"ncand_party_sum"] = cand_p_ari["ncand_party_sum"].values

#当選者に占める無所属議員の割合
musyozoku_p = col_wins_df[(col_wins_df[1])&(col_wins_df[2])][0].values
win_party = master[["ele_ID"]+list(col_wins_df[(col_wins_df[1])][0].values)]
win_p_nan = win_party[(win_party.isnull() == False).iloc[:,1:].sum(axis=1) == 0]
win_p_ari = win_party[(win_party.isnull() == False).iloc[:,1:].sum(axis=1) != 0]

win_p_ari = win_p_ari[win_p_ari['当選者数_\u3000'].isnull()] #政党名「\u3000」が存在する選挙を除外

win_p_ari

win_p_ari[win_p_ari.sum(axis=1).isnull()]
win_p_ari[win_p_ari.sum(axis=1) == 0] #合計当選者数nanはなし,0は3つあり
win_p_ari["win_party_sum"] = win_p_ari.sum(axis=1)

win_p_ari[win_p_ari[musyozoku_p].sum(axis=1).isnull()]
win_p_ari[win_p_ari[musyozoku_p].sum(axis=1) == 0] #無所属当選者数nanはなし、0は7つあり
win_p_ari["win_musyozoku_sum"] = win_p_ari[musyozoku_p].sum(axis=1)

win_p_ari["win_ratio_musyozoku"] = win_p_ari["win_musyozoku_sum"]/win_p_ari["win_party_sum"]


win_p_ari[win_p_ari.sum(axis=1) == 0] #0/0はnanに

master.loc[master["ele_ID"].isin(win_p_ari["ele_ID"].to_list()),"win_ratio_musyozoku"] = win_p_ari["win_ratio_musyozoku"].values
master.loc[master["ele_ID"].isin(win_p_ari["ele_ID"].to_list()),"win_musyozoku_sum"] = win_p_ari["win_musyozoku_sum"].values
master.loc[master["ele_ID"].isin(win_p_ari["ele_ID"].to_list()),"win_party_sum"] = win_p_ari["win_party_sum"].values

#候補者数が一致しない →　compe_ratio を修正し compe_rate_adopt に（一部欠損に）
master[(master["ncand_party_sum"].isnull() == False)&(master["n_cand_display"] !=  master["ncand_party_sum"])][["n_cand_display","ncand_party_sum"]]

master["n_cand_adopt"] = master["n_cand_display"]
master["n_seats_adopt"] = master["n_seats_isna"]

master.loc[(master["n_cand_data"] != master["n_cand_display"]),"n_cand_adopt"] = np.nan #n_cand_dataとn_cand_displayの不一致 22 cases
master.loc[(master["voting_rate"] != "無投票") & (master["n_wins_data"] != master["n_seats_display"]) & (master["n_seats_isna"].isnull() == False),"n_seats_adopt"] = np.nan  #n_wins_dataとn_seats_displayの不一致(定数割れ除く),68 cases
master[(master["voting_rate"] != "無投票") & (master["n_seats_isna"].isnull() == False) & (master["n_wins_data"] != master["n_seats_display"])& (master["n_cand_data"] != master["n_cand_display"])] # 2cases

#無投票なのに立候補者数人数と当選者人数が一致していないところも信用できないので、欠損に
master.loc[(master["voting_rate"] == "無投票") & ((master["n_cand_data"] != master["n_wins_data"])|(master["n_cand_display"] != master["n_wins_data"])),["n_cand_adopt","n_seats_adopt"]] = np.nan #15 cases

master["compe_rate_adopt"] = master["n_cand_adopt"]/master["n_seats_adopt"]

master[master["compe_rate_adopt"].isnull() == False]
master[master["compe_rate_adopt"] < 0.5]

#政党別立候補者・当選者合計人数と全体の立候補者・当選者数が一致していない選挙の無所属割合は信用できないので、それぞれ欠損に
master.loc[(master["ncand_party_sum"].isnull() == False)&(master["n_cand_adopt"] != master["ncand_party_sum"]),"ncand_musyozoku_sum"] = np.nan #27 cases
master.loc[(master["ncand_party_sum"].isnull() == False)&(master["n_cand_adopt"] != master["ncand_party_sum"]),"cand_ratio_musyozoku"] = np.nan

master.loc[(master["voting_rate"] != "無投票")&(master["win_party_sum"].isnull() == False)&(master["n_wins_data"] != master["win_party_sum"])] #0 cases
master.loc[(master["voting_rate"] == "無投票")&(master["win_party_sum"].isnull() == False)&(master["n_wins_data"] != master["win_party_sum"])] #0 cases


#"compe_rate_adopt"が欠損のデータの候補者・当選者数も信用できないので、それぞれの無所属割合は欠損にする
master.loc[(master["ncand_musyozoku_sum"].isnull() == False) & (master["compe_rate_adopt"].isnull()),"ncand_musyozoku_sum"] = np.nan #192 cases
master.loc[(master["cand_ratio_musyozoku"].isnull() == False) & (master["compe_rate_adopt"].isnull()),"cand_ratio_musyozoku"] = np.nan #192 cases

master.loc[(master["win_musyozoku_sum"].isnull() == False) & (master["compe_rate_adopt"].isnull()),"win_musyozoku_sum"] = np.nan #219 cases
master.loc[(master["win_ratio_musyozoku"].isnull() == False) & (master["compe_rate_adopt"].isnull()),"win_ratio_musyozoku"] = np.nan #216 cases

master[master["cand_ratio_musyozoku"].isnull() == False]
master[master["win_ratio_musyozoku"].isnull() == False]

#ラグ（前回選挙の無所属比率）
master["cand_ratio_musyozoku_pre"] = master.groupby("pres_pm").shift(1)["cand_ratio_musyozoku"]
master["win_ratio_musyozoku_pre"] = master.groupby("pres_pm").shift(1)["win_ratio_musyozoku"]

master[master["pres_pm"] == "山口県岩国市"][["cand_ratio_musyozoku_pre","cand_ratio_musyozoku"]] #大丈夫そう

#投票率
for i in master.index:
    if (master.loc[i,"voting_rate"] != "無投票"):
        master.loc[i,"voting_rate_isna"] = master.loc[i,"voting_rate"]
    else:
        master.loc[i,"voting_rate_isna"] = np.nan

master["voting_rate_isna"]


#調整済み現職1人当たり得票率

master["adjusted_ave_voteshere_inc"] = master["ratio_inc_votes_percand"] / (master["ratio_inc_votes_percand"] + master["ratio_new_votes_percand"] + master["ratio_new_votes_percand"])

master[(master[["ratio_inc_cand","ratio_new_cand","ratio_form_cand"]].isnull().sum(axis=1) == 3)] #立候補者数のステータス欠損

master.loc[(master["ratio_inc_cand"] == 0)&(master["adjusted_ave_voteshere_inc"].isnull() == False)] #当然欠損かつ現職立候補者数0人は存在しない

master.loc[(master["ratio_inc_cand"] == 0)] #現職立候補せずは 199 cases
master[master["ratio_inc_cand"] == 0][["ele_ID","n_cand_display","ratio_inc_cand","ratio_new_cand","ratio_form_cand"]]

master[(master[["ratio_inc_cand","ratio_new_cand","ratio_form_cand"]].sum(axis=1) < 0.999)&(master[["ratio_inc_cand","ratio_new_cand","ratio_form_cand"]].isnull().sum(axis=1) != 3)][["ratio_inc_cand","ratio_new_cand","ratio_form_cand"]] #立候補者数のステータスは存在するが合計が1にならない

master[(master[["ratio_inc_cand","ratio_new_cand","ratio_form_cand"]].sum(axis=1) < 0.999)]
#321 cases もある. 原因はおそらく「前職」の存在、解散の場合を考慮していなかった！

#とりあえず暫定的な変数を作っておく（compe_rateが欠損の場合、ステータス別得票率が１にならない場合暫定的に欠損にする）
master.loc[(master["compe_rate_adopt"].isnull())&(master["adjusted_ave_voteshere_inc"].isnull()==False),"adjusted_ave_voteshere_inc"] = np.nan #149 cases

master.loc[(master[["ratio_inc_cand","ratio_new_cand","ratio_form_cand"]].sum(axis=1) < 0.999)&(master["adjusted_ave_voteshere_inc"].isnull()==False),"adjusted_ave_voteshere_inc"] = np.nan #49 cases

master[master["adjusted_ave_voteshere_inc"].isnull()==False]

#任期満了ダミー
(master["reason"].str.contains("任期満了") == True).sum()
(master["reason"] == "任期満了").sum()

master["expired_dummy"] = 0
master.loc[master["reason"].str.contains("任期満了") == True,"expired_dummy"] = 1

#統一地方選月ダミー
master["touitsu_ele_dummy"] = 0
master.loc[(master["year"] == 2007)&(master["month"] == 4),"touitsu_ele_dummy"] = 1
master.loc[(master["year"] == 2011)&(master["month"] == 4),"touitsu_ele_dummy"] = 1
master.loc[(master["year"] == 2015)&(master["month"] == 4),"touitsu_ele_dummy"] = 1
master.loc[(master["year"] == 2019)&(master["month"] == 4),"touitsu_ele_dummy"] = 1

#平成の大合併ダミー
gappei = pd.read_excel("gappei_list.xls",index_col=0) 
gappei = gappei.iloc[2:]
gappei["time_pm"] = gappei["都道府県"] + gappei["名称"]

gappei[gappei["time_pm"].str.contains("ヶ") == True]
gappei[gappei["time_pm"].str.contains("檮原町") == True]
#問題なし
gappei[gappei["time_pm"].str.contains("福岡県那珂川市") == True]
#市制施行、名称

master["target_heisei_gappei"] = 0
master.loc[master["time_pm"].isin(gappei["time_pm"].to_list()),"target_heisei_gappei"] = 1
master.loc[master["disappear_dummy"] == 1,"target_heisei_gappei"] = 1
master.loc[master["time_pm"] == "兵庫県丹波篠山市","target_heisei_gappei"] = 1
master.loc[master["time_pm"] == "岐阜県中津川市","target_heisei_gappei"] = 1

gappei["time_pm"] = gappei["time_pm"].replace('岐阜県（、長野県）中津川市','岐阜県中津川市')
gappei["time_pm"].to_list()


#合併後ダミー

gappei_fd = gappei.groupby("time_pm")["合併期日"].first()
pd.to_datetime(master["kokuji_dt"]) > gappei_fd.loc["新潟県新潟市"]

master["after_gappei"] = 0

for i in list(gappei_fd.index):
    master.loc[(master["time_pm"] == i) & (pd.to_datetime(master["kokuji_dt"]) > gappei_fd.loc[i]),"after_gappei"] = 1
    
master[master["time_pm"] == "栃木県栃木市"]
master.loc[master["time_pm"] == "兵庫県丹波篠山市","after_gappei"] = 1

#合併直後　→　1999から2005の選挙の情報が無いので特定不能
#後日

gappei.
gappei.groupby("time_pm")[["合併期日"]].first

gappei.groupby("time_pm")["合併期日"].nth(1)[gappei.groupby("time_pm")["合併期日"].count() == 2]

#女性割合
master.columns[:65]

master["ratio_women_cand_adopt"] = master["ratio_women_cand"]
master["ratio_women_wins_adopt"] = master["ratio_women_wins"]
master.loc[(master["compe_rate_adopt"].isnull())&(master["ratio_women_cand_adopt"].isnull()==False),"ratio_women_cand_adopt"] = np.nan #252 cases
master.loc[(master["compe_rate_adopt"].isnull())&(master["ratio_women_wins_adopt"].isnull()==False),"ratio_women_wins_adopt"] = np.nan #252 cases

#平均年齢
master["age_mean_cand_adopt"] = master["age_mean_cand"]
master["age_mean_wins_adopt"] = master["age_mean_wins"]
master.loc[(master["compe_rate_adopt"].isnull())&(master["age_mean_cand_adopt"].isnull()==False),"age_mean_cand_adopt"] = np.nan #235 cases
master.loc[(master["compe_rate_adopt"].isnull())&(master["age_mean_wins_adopt"].isnull()==False),"age_mean_wins_adopt"] = np.nan #235 cases


master.to_csv("master_datas/master_0520_1025_v1.csv")

#分析用切り出し

first = master.iloc[:,:63]
second = master.iloc[:,2375:]
anal = pd.concat([first,second],axis=1)
anal = anal[(anal["change_salary_am"].isnull()==False)&(anal["compe_rate_adopt"].isnull()==False)&(anal["nendo"] != 2020)]

anal.groupby("pres_pm").count()["ele_ID"].hist()
plt.title("自治体別の観測数")
plt.savefig("../OneDrive/Documents/theses_documents/資料_1025/obs.png")

anal.shape[0]

anal.to_csv("for_analysis_1025.csv")

plt.scatter(anal["salary_am_kokuji"],anal["compe_rate_adopt"])
np.corrcoef(anal["salary_am_kokuji"],anal["compe_rate_adopt"])

plt.title("報酬と競争倍率")
plt.savefig("../OneDrive/Documents/theses_documents/資料_1025/scatter_1.png")

plt.scatter(anal["change_salary_am"],anal["compe_rate_adopt"])

#多数会派"
win_p_ari["majority"] = win_p_ari.iloc[:,1:-3].idxmax(axis=1)

import matplotlib.pyplot as plt
plt.rcParams['font.family'] = 'MS Gothic'

win_p_ari["majority"] = win_p_ari["majority"].str.replace("当選者数_","")
win_p_ari.groupby("majority").count()["ele_ID"].plot(kind="bar")
plt.xticks(rotation=25)
plt.title("最多当選会派")
plt.savefig("img.png")






