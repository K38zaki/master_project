from cycler import concat
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns
from seaborn.utils import despine

#被説明変数の記述統計量
master = pd.read_stata("1219_data.dta")
master[master["age_mean_cand"] < 50]["age_mean_cand"]
master[master["voting_rate_p"] > 0.95]["voting_rate_p"]



deps = ["compe_rate_adopt","no_voting_ratio_win","ratio_women_cand_adopt","age_mean_cand","dummy_forfeit_deposit","teian_jyorei_4y",
         "adjusted_ave_voteshare_inc","voting_rate_p"]
samples = ["sample_compe","sample_novote","sample_women","sample_age","sample_depo","sample_teian",
         "sample_inc_ols","sample_voting_ols"]
depdata = master[deps+samples+["lnsalary_am_kokuji","dummy_up_salary_am","dummy_down_salary_am"]]
depdata

depdata.loc[depdata[samples[0]] == 1,deps[0]].describe()

des_s = []
for vid in range(len(samples)):
    des_s.append(depdata.loc[depdata[samples[vid]] == 1,deps[vid]].describe()) 

des_deps = pd.concat(des_s,axis=1).round(3)
des_deps = des_deps.T
des_deps["count"] = des_deps["count"].astype("int64")
des_deps.loc["age_mean_cand","mean":"max"] = des_deps.loc["age_mean_cand","mean":"max"].round(2)
des_deps
des_deps.index = ["1議席あたり立候補人数","無投票当選割合","立候補者女性割合","立候補者平均年齢",
                 "供託金没収ライン未到達者の発生","議員提案条例可決数(任期中)","調整済み現職1人あたり得票率","投票率"]
des_deps.columns = ["観測数","平均値","標準偏差","最小値","第一四分位数","中央値","第三四分位数","最大値"]

des_deps

print(des_deps.to_latex())


sns.set_style(style="darkgrid")
sns.set(font="MS Gothic")
sns.set_context("poster", rc={"font.size":20,"axes.titlesize":8,"axes.labelsize":25})  

#hist
fig = plt.figure(figsize=(15,25))
plt.subplots_adjust(wspace=0.2, hspace=0.4)

axes = fig.add_subplot(4, 2, 1)
sns.distplot(depdata.loc[depdata[samples[0]] == 1,deps[0]],kde=False,rug=False,bins=list(np.arange(0.4,2,0.1)),axlabel="1議席あたり立候補人数")
axes = fig.add_subplot(4, 2, 2)
sns.distplot(depdata.loc[depdata[samples[1]] == 1,deps[1]],kde=False,rug=False,bins=list(np.arange(0,1.2,0.1)),axlabel="無投票当選割合")
axes = fig.add_subplot(4, 2, 3)
sns.distplot(depdata.loc[depdata[samples[2]] == 1,deps[2]],kde=False,rug=False,bins=list(np.arange(0,1.2,0.1)),axlabel="立候補者女性割合")
axes = fig.add_subplot(4, 2, 4)
sns.distplot(depdata.loc[depdata[samples[3]] == 1,deps[3]],kde=False,rug=False,bins=list(np.arange(45,80,5)),axlabel="立候補者平均年齢")
axes = fig.add_subplot(4, 2, 5)
sns.distplot(depdata.loc[depdata[samples[5]] == 1,deps[5]],kde=False,rug=False,bins=list(np.arange(0,13,1)),axlabel="議員提案条例可決数(任期中)")
axes = fig.add_subplot(4, 2, 6)
sns.distplot(depdata.loc[depdata[samples[6]] == 1,deps[6]],kde=False,rug=False,bins=list(np.arange(0,1.1,0.1)),axlabel="調整済み現職1人当たり得票率")
axes = fig.add_subplot(4, 2, 7)
sns.distplot(depdata.loc[depdata[samples[7]] == 1,deps[7]],kde=False,rug=False,bins=list(np.arange(0,1.1,0.1)),axlabel="投票率")

plt.savefig("histgram_dep_0101.png",dpi=400)

## hist for revised ver (20220203)

fig = plt.figure(figsize=(15,25))
plt.subplots_adjust(wspace=0.2, hspace=0.4)

axes = fig.add_subplot(4, 2, 1)
sns.distplot(depdata.loc[depdata[samples[0]] == 1,deps[0]],kde=False,rug=False,bins=list(np.arange(0.4,2,0.1)),axlabel="1議席あたり立候補人数")
axes = fig.add_subplot(4, 2, 2)
sns.distplot(depdata.loc[depdata[samples[1]] == 1,deps[1]],kde=False,rug=False,bins=list(np.arange(0,1.2,0.1)),axlabel="無投票当選割合")
axes = fig.add_subplot(4, 2, 3)
sns.distplot(depdata.loc[depdata[samples[2]] == 1,deps[2]],kde=False,rug=False,bins=list(np.arange(0,1.2,0.1)),axlabel="立候補者女性割合")
axes = fig.add_subplot(4, 2, 4)
sns.distplot(depdata.loc[depdata[samples[3]] == 1,deps[3]],kde=False,rug=False,bins=list(np.arange(45,80,5)),axlabel="立候補者平均年齢")
axes = fig.add_subplot(4, 2, 5)
sns.distplot(depdata.loc[depdata[samples[5]] == 1,deps[5]],kde=False,rug=False,bins=list(np.arange(0,13,1)),axlabel="議員提案条例可決数(任期中)")
axes = fig.add_subplot(4, 2, 6)
sns.distplot(depdata.loc[depdata[samples[6]] == 1,deps[6]],kde=False,rug=False,bins=list(np.arange(0,1.1,0.1)),axlabel="調整済み現職1人あたり得票率")
axes = fig.add_subplot(4, 2, 7)
sns.distplot(depdata.loc[depdata[samples[7]] == 1,deps[7]],kde=False,rug=False,bins=list(np.arange(0,1.1,0.1)),axlabel="投票率")

plt.savefig("histgram_dep_0203.png",dpi=400)


salas = master[["salary_am_kokuji","lnsalary_am_kokuji","dummy_up_salary_am","dummy_down_salary_am","sample_novote","pref_id","ele_id","nendo"]]

salas.loc[(salas["sample_novote"] == 1)&(salas["dummy_up_salary_am"].isnull())]

sala_des = salas[salas["sample_novote"] == 1].describe()[["salary_am_kokuji","lnsalary_am_kokuji","dummy_up_salary_am","dummy_down_salary_am"]].round(3)

sala_des = sala_des.T
sala_des["count"] = sala_des["count"].astype("int64")
sala_des
sala_des.columns = ["観測数","平均値","標準偏差","最小値","第一四分位数","中央値","第三四分位数","最大値"]
sala_des.index = ["議員報酬額","対数議員報酬額","議員報酬増額ダミー","議員報酬減額ダミー"]

print(sala_des.to_latex())



sns.distplot(salas.loc[salas["sample_novote"] == 1,"salary_am_kokuji"],kde=False,rug=False,bins=list(np.arange(0,10000,500)))

sns.set(font='MS Gothic')
sns.set_style(style="darkgrid")
sns.set_context("poster", rc={"font.size":20,"axes.titlesize":8,"axes.labelsize":25})  

#hist
plt.figure(figsize=(16,9))
sns.distplot(salas.loc[salas["sample_novote"] == 1,"salary_am_kokuji"],kde=False,rug=False,bins=list(np.arange(0,10000,500)),color="black",axlabel="議員報酬額 (単位:百円)")
plt.savefig("hist_sala_0101.png",dpi=400)

salas.loc[salas["sample_novote"] == 1].groupby("nendo")["salary_am_kokuji"].mean()
salas.loc[salas["sample_novote"] == 1].groupby("pref_id")["salary_am_kokuji"].mean().plot()


salas.loc[salas["sample_novote"] == 1]["salary_am_kokuji"]

#scatter
fig = plt.figure(figsize=(15,20))
plt.subplots_adjust(wspace=0.5, hspace=0.5)
axes = fig.add_subplot(3, 2, 1)
sns.regplot(x="lnsalary_am_kokuji", y=deps[0], data=depdata[depdata[samples[0]] == 1], ci=95,scatter_kws={'color':'black','alpha':0.3},line_kws={'color': 'orange'})
plt.xlabel("対数議員報酬額",size=20)
plt.ylabel("1議席あたり立候補人数",size=20)
axes = fig.add_subplot(3, 2, 2)
sns.regplot(x="lnsalary_am_kokuji", y=deps[1], data=depdata[depdata[samples[1]] == 1], ci=95,scatter_kws={'color':'black','alpha':0.3},line_kws={'color': 'orange'})
plt.xlabel("対数議員報酬額",size=20)
plt.ylabel("無投票当選割合",size=20)
axes = fig.add_subplot(3, 2, 3)
sns.regplot(x="lnsalary_am_kokuji", y=deps[2], data=depdata[depdata[samples[2]] == 1], ci=95,scatter_kws={'color':'black','alpha':0.3},line_kws={'color': 'orange'})
plt.xlabel("対数議員報酬額",size=20)
plt.ylabel("立候補者女性割合",size=20)
axes = fig.add_subplot(3, 2, 4)
sns.regplot(x="lnsalary_am_kokuji", y=deps[3], data=depdata[depdata[samples[3]] == 1], ci=95,scatter_kws={'color':'black','alpha':0.3},line_kws={'color': 'orange'})
plt.xlabel("対数議員報酬額",size=20)
plt.ylabel("立候補者平均年齢",size=20)
axes = fig.add_subplot(3, 2, 5)
sns.regplot(x="lnsalary_am_kokuji", y=deps[4], data=depdata[depdata[samples[4]] == 1], ci=95,scatter_kws={'color':'black','alpha':0.3},line_kws={'color': 'orange'})
plt.xlabel("対数議員報酬額",size=20)
plt.ylabel("供託金没収ライン未到達者の発生",size=20)
axes = fig.add_subplot(3, 2, 6)
sns.regplot(x="lnsalary_am_kokuji", y=deps[5], data=depdata[depdata[samples[5]] == 1], ci=95,scatter_kws={'color':'black','alpha':0.3},line_kws={'color': 'orange'})
plt.xlabel("対数議員報酬額",size=20)
plt.ylabel("議員提案条例可決数(任期中)",size=20)

plt.savefig("scatter_ln_0101.png",dpi=400)

for i in range(0,7):
    print(np.corrcoef(depdata.loc[depdata[samples[i]] == 1,"lnsalary_am_kokuji"],depdata.loc[depdata[samples[i]] == 1,deps[i]]))

for i in range(0,7):
    print(np.corrcoef(depdata.loc[depdata[samples[i]] == 1,"lnsalary_am_kokuji"],depdata.loc[depdata[samples[i]] == 1,deps[i]]))

#barplot →　没
fig = plt.figure(figsize=(15,15))
plt.subplots_adjust(wspace=0.2, hspace=0.2)
axes = fig.add_subplot(2, 2, 1)
sns.barplot(x="dummy_up_salary_am", y=deps[6], data=depdata[depdata[samples[6]] == 1], ci=95,color="blue")
axes = fig.add_subplot(2, 2, 2)
sns.barplot(x="dummy_up_salary_am", y=deps[7], data=depdata[depdata[samples[7]] == 1], ci=95,color="blue")
axes = fig.add_subplot(2, 2, 3)
sns.barplot(x="dummy_down_salary_am", y=deps[6], data=depdata[depdata[samples[6]] == 1], ci=95,color="blue")
axes = fig.add_subplot(2, 2, 4)
sns.barplot(x="dummy_down_salary_am", y=deps[7], data=depdata[depdata[samples[7]] == 1], ci=95,color="blue")

plt.savefig("barplot_updown_1229.png",dpi=300)

depdata[depdata[samples[6]] == 1].groupby("dummy_up_salary_am").mean()[deps[6]]
depdata[depdata[samples[6]] == 1].groupby("dummy_down_salary_am").mean()[deps[6]]
depdata[depdata[samples[7]] == 1].groupby("dummy_up_salary_am").mean()[deps[7]]
depdata[depdata[samples[7]] == 1].groupby("dummy_down_salary_am").mean()[deps[7]]

##コントロール変数
controls = ["ln_income_per","ln_population","n_seats_adopt","population_elderly75_ratio","population_child15_ratio","ln_all_menseki","canlive_ratio_menseki","sigaika_ratio_area","ln_zaiseiryoku","win_ratio_musyozoku_pre","expired_dummy","touitsu_2011","touitsu_2015","touitsu_2019","ln_staff_all","ln_salary_staff_all","age_mean_wins","ratio_women_wins_adopt","win_ratio_musyozoku"]

des_cont = master.loc[master["sample_novote"] == 1,controls].describe().round(3).T

des_cont["count"] = des_cont["count"].astype("int64")
des_cont.loc["age_mean_wins","mean":"max"] = des_cont.loc["age_mean_wins","mean":"max"].round(2)

des_cont.columns = ["観測数","平均値","標準偏差","最小値","第一四分位数","中央値","第三四分位数","最大値"]
des_cont.index = ["対数1人あたり課税対象所得","対数人口","議席数","75歳以上人口割合",
                  "15歳未満人口割合","対数面積","可住地面積割合","市街化区域面積割合",
                  "対数財政力指数","前回当選者無所属割合","任期満了ダミー",
                  "2011年統一選ダミー","2015年統一選ダミー","2019年統一選ダミー","対数自治体職員数","対数職員平均給与",
                  "当選者平均年齢","当選者女性割合","当選者無所属割合"]

print(des_cont.to_latex())

#自治体数・自治体別観測数
master.loc[master["sample_novote"] == 1,"pres_pm_codes"].value_counts().describe()


