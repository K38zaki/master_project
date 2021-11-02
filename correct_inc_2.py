import numpy as np
import pandas as pd
import datetime

master = pd.read_csv("master_datas/master_0520_1029.csv",index_col=0)

corrects = pd.concat([pd.read_csv("correct_incumbent/pref_"+str(i)+"_gikai_correct_inc.csv") for i in range(1,48)],axis=0)

hidaka = pd.read_csv("correct_incumbent/hidakacho_gikai_correct_inc.csv")
hidaka

corrects.insert(0,"ele_ID",corrects["prefecture"]+corrects["ele_ymd"])
hidaka.insert(0,"ele_ID",hidaka["prefecture"]+hidaka["ele_ymd"])
corrects = corrects.reset_index()
hidaka = hidaka.reset_index()

hidaka
corrects.loc[corrects["ele_ID"].isin(hidaka["ele_ID"].to_list()),:]
corrects[corrects["ele_ID"].str.contains("北海道日高町")]

corrects = pd.concat([corrects,hidaka.iloc[:3,:]],axis=0)
corrects[corrects["ele_ID"].str.contains("北海道日高町")]

master.loc[:,"ratio_inc_cand":"ratio_form_votes_percand"]
corrects.loc[:,"ratio_inc_cand":"ratio_form_votes_percand"]

revised = pd.merge(master,corrects,how="left",on="ele_ID").iloc[:,master.shape[1]+4:-1] #マージ後の新規追加部分
revised.values.shape
master.loc[:,"ratio_inc_cand":"ratio_form_votes_percand"] = revised.values

master.loc[:,"ratio_inc_cand":"ratio_form_votes_percand"]
master[(master[["ratio_inc_cand","ratio_new_cand","ratio_form_cand"]].sum(axis=1) < 0.999)&(master[["ratio_inc_cand","ratio_new_cand","ratio_form_cand"]].isnull().sum(axis=1) != 3)]
#ステータス別候補者数が欠損でないかつ合計割合が１でないが存在しなくなったので、修正完了

#調整済み現職1人当たり得票率
master["adjusted_ave_voteshere_inc"] = master["ratio_inc_votes_percand"] / (master["ratio_inc_votes_percand"] + master["ratio_new_votes_percand"] + master["ratio_new_votes_percand"])

master.loc[(master["compe_rate_adopt"].isnull())&(master["adjusted_ave_voteshere_inc"].isnull()==False)] 
master.loc[(master["compe_rate_adopt"].isnull())&(master["adjusted_ave_voteshere_inc"].isnull()==False),"adjusted_ave_voteshere_inc"] = np.nan #151 cases

master.loc[(master[["ratio_inc_cand","ratio_new_cand","ratio_form_cand"]].sum(axis=1) < 0.999)&(master["adjusted_ave_voteshere_inc"].isnull()==False)]
master.loc[(master[["ratio_inc_cand","ratio_new_cand","ratio_form_cand"]].sum(axis=1) < 0.999)&(master["adjusted_ave_voteshere_inc"].isnull()==False),"adjusted_ave_voteshere_inc"] = np.nan #0 cases

master[master["adjusted_ave_voteshere_inc"].isnull()==False]

master.to_csv("master_datas/master_0520_1101.csv")

#分析用切り出し
first = master.iloc[:,:63]
second = master.iloc[:,2375:]
anal = pd.concat([first,second],axis=1)
anal = anal[(anal["compe_rate_adopt"].isnull()==False)&(anal["nendo"] != 2020)]

anal.to_csv("for_analysis_1101.csv")



