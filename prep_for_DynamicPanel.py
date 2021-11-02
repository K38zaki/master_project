import numpy as np
import pandas as pd
import datetime
import matplotlib.pyplot as plt
plt.rcParams['font.family'] = 'MS Gothic'

master = pd.read_csv("master_datas/master_0520_1025_v1.csv",index_col=0)

#time-index を新たに作成 (分析期間における何回目の選挙か)
master["ele_t"] = np.nan
master.groupby("pres_pm").nth(0)["ele_ID"]
master.loc[master["ele_ID"].isin(master.groupby("pres_pm").nth(0)["ele_ID"].to_list()),"ele_t"] = 1
master[master["ele_t"].isnull() == False]
master.groupby("pres_pm").nth(1)["ele_ID"]
master.loc[master["ele_ID"].isin(master.groupby("pres_pm").nth(1)["ele_ID"].to_list()),"ele_t"] = 2
master.loc[master["ele_ID"].isin(master.groupby("pres_pm").nth(2)["ele_ID"].to_list()),"ele_t"] = 3
master.loc[master["ele_ID"].isin(master.groupby("pres_pm").nth(3)["ele_ID"].to_list()),"ele_t"] = 4
master.loc[master["ele_ID"].isin(master.groupby("pres_pm").nth(4)["ele_ID"].to_list()),"ele_t"] = 5
master[master["ele_t"].isnull()] # ok

master[master["nendo"] != 2020].groupby("pres_pm").count()["ele_ID"].hist()
master[(master["nendo"] != 2020)&(master["target_heisei_gappei"]==0)].groupby("pres_pm").count()["ele_ID"].describe()

#投票率が100を超えているところの修正
master[(master["voting_rate_isna"] > 100)]["voting_rate_isna"]
master.loc[(master["voting_rate_isna"] > 100),"voting_rate_isna"] = np.nan

#無投票の選挙区とそうでない選挙区がある選挙の投票率がどの程度記録されているか　→　ある程度は(29/54がデータ有)
master[(master["no_voting_ratio_win"] > 0)&(master["no_voting_ratio_win"] < 1)]["voting_rate_isna"].describe()

master.to_csv("master_datas/master_0520_1029.csv")


#分析用切り出し

first = master.iloc[:,:63]
second = master.iloc[:,2375:]
anal = pd.concat([first,second],axis=1)
anal[anal["compe_rate_adopt"].isnull()]
anal = anal[(anal["compe_rate_adopt"].isnull()==False)&(anal["nendo"] != 2020)]

anal.groupby("pres_pm").count()["ele_ID"].hist()
anal[(anal["target_heisei_gappei"]==0)].groupby("pres_pm").count()["ele_ID"].hist()

anal.groupby("pres_pm").count()["ele_ID"].hist()
plt.title("自治体別の観測数(全て)")
plt.savefig("../OneDrive/Documents/theses_documents/資料_1025/obs_all_1029.png")

anal[(anal["target_heisei_gappei"]==0)].groupby("pres_pm").count()["ele_ID"].hist()
plt.title("自治体別の観測数(合併無し)")
plt.savefig("../OneDrive/Documents/theses_documents/資料_1025/obs_nogappei_1029.png")

anal.shape[0]

anal.to_csv("for_analysis_1029.csv")




