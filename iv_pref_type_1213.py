import pandas as pd
import numpy as np
import datetime
import matplotlib.pyplot as plt
from dateutil.relativedelta import relativedelta
from pandas.core.reshape.merge import merge

md
md = pd.read_stata("1130_data.dta")
md = md.iloc[:6707]
del md

ori_a = pd.read_csv("for_analysis/for_analysis_1128.csv",index_col=0)

omitted = ori_a[ori_a["ele_ID"] == "香川県坂出市議会議員選挙（2019年04月21日投票）"]
omitted = omitted.rename({"ele_ID":"ele_id"},axis=1)
omitted["reason"]

pd.concat([md,omitted],axis=0).columns
ori_a.loc[ori_a["ele_ID"] == "香川県坂出市議会議員選挙（2019年04月21日投票）","reason"] = "任期満了/定数20名のところ、240票を獲得した、たたらまさし氏は法定得票数に満たず落選"

ori_a['time_muni_kind']
ori_a['prefecture']

sala = pd.read_csv("salaries_all.csv",index_col=0)

sala
ori_a[ori_a["nendo"] > 2005].index

kind = ori_a.loc[517,'time_muni_kind']
pref = ori_a.loc[518,'prefecture']
nendo = ori_a.loc[517,'nendo']
p_pm = ori_a.loc[517,"pres_pm"]

sala[(sala['time_muni_kind'] == kind)&(sala["prefecture"] == pref)&(sala["nendo"] == nendo-1)&(sala["pres_pm"] != p_pm)]["salary_assembly_member"].mean()



ori_a["mean_sala_preftype_1yago"] = np.nan
ori_a["pref_type"] = np.nan

for idx in ori_a[ori_a["nendo"] > 2005].index:
    kind = ori_a.loc[idx,'time_muni_kind']
    pref = ori_a.loc[idx,'prefecture']
    nendo = ori_a.loc[idx,'nendo']
    p_pm = ori_a.loc[idx,"pres_pm"]

    ori_a.loc[idx,"pref_type"] = pref + "_" + kind
    ori_a.loc[idx,"mean_sala_preftype_1yago"] = sala[(sala['time_muni_kind'] == kind)&(sala["prefecture"] == pref)&(sala["nendo"] == nendo-1)&(sala["pres_pm"] != p_pm)]["salary_assembly_member"].mean()

ori_a.loc[(ori_a["nendo"] > 2005)&(ori_a["pref_type"].isnull())]
ori_a.loc[(ori_a["nendo"] > 2005),["ele_ID","pref_type"]]

ori_a.loc[(ori_a["nendo"] > 2005)&(ori_a["mean_sala_preftype_1yago"].isnull())]["ele_ID"]
#同一県内に村が1つしかない　→　町村で統合版も

ori_a["mean_sala_preftype_1yago"] = np.nan
ori_a.loc[518,"ele_ID"]
kind = ori_a.loc[518,'time_muni_kind']
if ((kind == "村") | (kind == "町")) :
    print(sala[((sala['time_muni_kind'] == "町")|(sala['time_muni_kind'] == "村"))&(sala["prefecture"] == pref)&(sala["nendo"] == nendo-1)&(sala["pres_pm"] != p_pm)]["salary_assembly_member"].mean())
else:
    print("miss")


ori_a["mean_sala_prefbigtype_1yago"] = np.nan
ori_a["mean_sala_pref_1yago"] = np.nan

for idx in ori_a[ori_a["nendo"] > 2005].index:
    pref = ori_a.loc[idx,'prefecture']
    nendo = ori_a.loc[idx,'nendo']
    p_pm = ori_a.loc[idx,"pres_pm"]
    kind = ori_a.loc[idx,'time_muni_kind']

    ori_a.loc[idx,"mean_sala_pref_1yago"] = sala[(sala["prefecture"] == pref)&(sala["nendo"] == nendo-1)&(sala["pres_pm"] != p_pm)]["salary_assembly_member"].mean()

    if ((kind == "村") | (kind == "町")) :
        ori_a.loc[idx,"mean_sala_prefbigtype_1yago"] = sala[((sala['time_muni_kind'] == "町")|(sala['time_muni_kind'] == "村"))&(sala["prefecture"] == pref)&(sala["nendo"] == nendo-1)&(sala["pres_pm"] != p_pm)]["salary_assembly_member"].mean()
    else:
        ori_a.loc[idx,"mean_sala_prefbigtype_1yago"] = sala[(sala['time_muni_kind'] == kind)&(sala["prefecture"] == pref)&(sala["nendo"] == nendo-1)&(sala["pres_pm"] != p_pm)]["salary_assembly_member"].mean()

ori_a.loc[(ori_a["nendo"] > 2005)&(ori_a["mean_sala_prefbigtype_1yago"].isnull())]["ele_ID"]
ori_a.loc[(ori_a["nendo"] > 2005)&(ori_a["mean_sala_pref_1yago"].isnull())]["ele_ID"]

ori_a.to_csv("for_analysis/for_analysis_1213.csv")

ori_a = ori_a.drop("level_0",axis=1)

ori_a["mean_sala_pref_1yago"].hist()
ori_a["mean_sala_prefbigtype_1yago"].hist()
ori_a["mean_sala_preftype_1yago"].hist()

ori_a.plot(kind="scatter",x="ln_popu",y="mean_sala_prefbigtype_1yago")

##周りの増額・減額 
##告示年度4月1日までの4年間の減額割合、増額割合

md = pd.read_stata("1213_data.dta")
sala = pd.read_csv("salaries_all.csv",index_col=0)

md.loc[[0,1],["nendo"]]

md.loc[md["ele_t"] == 2,["kokuji_ymd_pre","nendo"]]
md.columns.values

kind = md.loc[1,'time_muni_kind']
pref = md.loc[1,'prefecture']
nendo = md.loc[1,'nendo']
p_pm = md.loc[1,"pres_pm"]

now = sala[(sala['time_muni_kind'] == kind)&(sala["prefecture"] == pref)&(sala["nendo"] == nendo)&(sala["pres_pm"] != p_pm)][["pres_pm","salary_assembly_member"]]
past = sala[(sala['time_muni_kind'] == kind)&(sala["prefecture"] == pref)&(sala["nendo"] == nendo -4)&(sala["pres_pm"] != p_pm)][["pres_pm","salary_assembly_member"]]
merged = pd.merge(now,past,how="left",on="pres_pm")

zougen = merged.apply(lambda s: np.sign(s.salary_assembly_member_x - s.salary_assembly_member_y), axis=1)
up_ratio = (zougen == 1).mean()
down_ratio = (zougen == -1).mean()

md["up_ratio_sala_prefbigtype_4ys"] = np.nan
md["down_ratio_sala_prefbigtype_4ys"] = np.nan

for idx in md[(md["ele_t"] > 1)&(md["nendo"] > 2008)].index:
    pref = md.loc[idx,'prefecture']
    nendo = md.loc[idx,'nendo']
    p_pm = md.loc[idx,"pres_pm"]
    kind = md.loc[idx,'time_muni_kind']

    if ((kind == "村") | (kind == "町")):
        now = sala[((sala['time_muni_kind'] == "町")|(sala['time_muni_kind'] == "村"))&(sala["prefecture"] == pref)&(sala["nendo"] == nendo)&(sala["pres_pm"] != p_pm)][["pres_pm","salary_assembly_member"]]
        past = sala[((sala['time_muni_kind'] == "町")|(sala['time_muni_kind'] == "村"))&(sala["nendo"] == nendo-4)&(sala["pres_pm"] != p_pm)][["pres_pm","salary_assembly_member"]]
    else:
        now = sala[(sala['time_muni_kind'] == kind)&(sala["prefecture"] == pref)&(sala["nendo"] == nendo)&(sala["pres_pm"] != p_pm)][["pres_pm","salary_assembly_member"]]
        past = sala[(sala['time_muni_kind'] == kind)&(sala["prefecture"] == pref)&(sala["nendo"] == nendo-4)&(sala["pres_pm"] != p_pm)][["pres_pm","salary_assembly_member"]]
    
    merged = pd.merge(now,past,how="left",on="pres_pm")
    zougen = merged.apply(lambda s: np.sign(s.salary_assembly_member_x - s.salary_assembly_member_y), axis=1)
    md.loc[idx,"up_ratio_sala_prefbigtype_4ys"] = (zougen == 1).mean()
    md.loc[idx,"down_ratio_sala_prefbigtype_4ys"] = (zougen == -1).mean()


md[(md["ele_t"] > 1)&(md["nendo"] > 2008)&(md["up_ratio_sala_prefbigtype_4ys"].isnull())]
md[(md["ele_t"] > 1)&(md["nendo"] > 2008)&(md["down_ratio_sala_prefbigtype_4ys"].isnull())]

md[(md["ele_t"] > 1)&(md["nendo"] > 2008)]["up_ratio_sala_prefbigtype_4ys"].hist()
md[(md["ele_t"] > 1)&(md["nendo"] > 2008)]["up_ratio_sala_prefbigtype_4ys"].describe()

md[(md["ele_t"] > 1)&(md["nendo"] > 2008)]["down_ratio_sala_prefbigtype_4ys"].hist()
md[(md["ele_t"] > 1)&(md["nendo"] > 2008)]["down_ratio_sala_prefbigtype_4ys"].describe()

md[(md["ele_t"] > 1)&(md["nendo"] > 2008)].plot(kind="scatter",x="up_ratio_sala_prefbigtype_4ys",y="dummy_up_salary_am")

md[(md["ele_t"] > 1)&(md["nendo"] > 2008)].plot(kind="scatter",x="down_ratio_sala_prefbigtype_4ys",y="dummy_down_salary_am")
md[(md["ele_t"] > 1)&(md["nendo"] > 2008)][["down_ratio_sala_prefbigtype_4ys","dummy_down_salary_am"]].corr()
md[(md["ele_t"] > 1)&(md["nendo"] > 2008)][["up_ratio_sala_prefbigtype_4ys","dummy_up_salary_am"]].corr()
##相関あるっちゃある

##前回選挙時点での周辺との報酬の乖離
###前回告示時点とその年度4月1日時点での周りの自治体の平均
md.columns.values
kind = md.loc[1,'time_muni_kind']
sala_pre = md.loc[1,'salary_am_pre']
pref = md.loc[1,'prefecture']
nendo = md.loc[1,'nendo']
p_pm = md.loc[1,"pres_pm"]
e_t = md.loc[1,"ele_t"]
nendo_l1 = md.loc[(md["ele_t"] == e_t-1)&(md["pres_pm"] == p_pm),"nendo"].iloc[0]
sala[((sala['time_muni_kind'] == "町")|(sala['time_muni_kind'] == "村"))&(sala["prefecture"] == pref)&(sala["nendo"] == nendo-1)&(sala["pres_pm"] != p_pm)]["salary_assembly_member"].mean()

mean_l1_apr1 = sala[(sala['time_muni_kind'] == kind)&(sala["prefecture"] == pref)&(sala["nendo"] == nendo_l1)&(sala["pres_pm"] != p_pm)]["salary_assembly_member"].mean()
sala_l1_apr1 = sala[(sala["nendo"] == nendo_l1)&(sala["pres_pm"] == p_pm)]["salary_assembly_member"].iloc[0]
mean_l1_apr1 - sala_l1_apr1


md.loc[(md["ele_t"] == 5)&(md["pres_pm"] == "長野県長野市"),"nendo"].shape[0]

md["mean_prefbigtype_pre_apr1"] = np.nan
md["salary_pre_apr1"] = np.nan
md["deviation_pre_apr1"] = np.nan
for idx in md[(md["ele_t"] > 1)].index:
    kind = md.loc[idx,'time_muni_kind']
    pref = md.loc[idx,'prefecture']
    nendo = md.loc[idx,'nendo']
    p_pm = md.loc[idx,"pres_pm"]
    e_t = md.loc[idx,"ele_t"]
    nendo_l1_se = md.loc[(md["ele_t"] == e_t-1)&(md["pres_pm"] == p_pm),"nendo"]
    if nendo_l1_se.shape[0] == 0:
        print(p_pm,e_t)
        continue
    else:
        nendo_l1 = nendo_l1_se.iloc[0]
        if ((kind == "村") | (kind == "町")):
            md.loc[idx,"mean_prefbigtype_pre_apr1"] = sala[((sala['time_muni_kind'] == "町")|(sala['time_muni_kind'] == "村"))&(sala["prefecture"] == pref)&(sala["nendo"] == nendo_l1)&(sala["pres_pm"] != p_pm)]["salary_assembly_member"].mean()
        else:
            md.loc[idx,"mean_prefbigtype_pre_apr1"] = sala[(sala['time_muni_kind'] == kind)&(sala["prefecture"] == pref)&(sala["nendo"] == nendo_l1)&(sala["pres_pm"] != p_pm)]["salary_assembly_member"].mean()
        md.loc[idx,"deviation_pre_apr1"] = md.loc[idx,"salary_am_pre"] - md.loc[idx,"mean_prefbigtype_pre_apr1"] 

md[(md["ele_t"] > 1)&(md["deviation_pre_apr1"].isnull())]
## "salary_am_pre" が欠損
md[(md["ele_t"] > 1)&(md["mean_prefbigtype_pre_apr1"].isnull())]

md[(md["ele_t"] > 1)&(md["mean_prefbigtype_pre_apr1"].isnull() == False)]["mean_prefbigtype_pre_apr1"].hist()

md[(md["ele_t"] > 1)&(md["deviation_pre_apr1"].isnull() == False)]["deviation_pre_apr1"].hist()
md[(md["ele_t"] > 1)&(md["deviation_pre_apr1"].isnull() == False)][["deviation_pre_apr1","dummy_up_salary_am"]].corr()
md[(md["ele_t"] > 1)&(md["deviation_pre_apr1"].isnull() == False)][["deviation_pre_apr1","dummy_down_salary_am"]].corr()
## 相関あるけど弱い

md.to_csv("for_analysis/for_analysis_1213_v2.csv")
