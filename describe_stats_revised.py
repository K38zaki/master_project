import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns

#データの確認
master = pd.read_stata("1229_data.dta")
master[master["age_mean_cand"] < 50]["age_mean_cand"]
master[master["voting_rate_p"] > 0.95]["voting_rate_p"]

samples = ["sample_compe","sample_novote","sample_women","sample_age","sample_depo","sample_teian","sample_inc_ols","sample_voting_ols"]
vars = ["dummy_up_salary_am","dummy_down_salary_am","salary_am_kokuji","change_salary_am","increase_salary","decrease_salary"]

data = master[samples+vars]

#説明変数・要約統計量の修正
controls = ["ln_salary_am_kokuji","dummy_up_salary_am","ln_income_per","ln_population","n_seats_adopt","population_elderly75_ratio","population_child15_ratio","ln_all_menseki","canlive_ratio_menseki","sigaika_ratio_area","ln_zaiseiryoku","win_ratio_musyozoku_pre","expired_dummy","touitsu_2011","touitsu_2015","touitsu_2019","ln_staff_all","ln_salary_staff_all","age_mean_wins","ratio_women_wins_adopt","win_ratio_musyozoku"]

des_cont = master.loc[master["sample_compe"] == 1,controls].describe().round(3).T

des_cont["count"] = des_cont["count"].astype("int64")
des_cont.loc["age_mean_wins","mean":"max"] = des_cont.loc["age_mean_wins","mean":"max"].round(2)

des_cont.columns = ["観測数","平均値","標準偏差","最小値","第一四分位数","中央値","第三四分位数","最大値"]
des_cont.index = ["対数議員報酬額","議員報酬増額ダミー","対数1人あたり課税対象所得","対数人口","議席数","75歳以上人口割合",
                  "15歳未満人口割合","対数面積","可住地面積割合","市街化区域面積割合",
                  "対数財政力指数","前回当選者無所属割合","任期満了ダミー",
                  "2011年統一選ダミー","2015年統一選ダミー","2019年統一選ダミー","対数自治体職員数","対数職員平均給与",
                  "当選者平均年齢","当選者女性割合","当選者無所属割合"]

des_cont.to_latex("sam_stat_indvars_0604.tex")

#histgram of 議員報酬額
sns.set_style(style="darkgrid")
sns.set(font="MS Gothic")
sns.set_context("poster", rc={"font.size":20,"axes.titlesize":8,"axes.labelsize":25}) 
from matplotlib import rc
rc('font',**{'family':'serif','serif':['MS Gothic']})
plt.rcParams['pdf.fonttype'] = 42 

fig = plt.figure(figsize=(16,9))
axes = fig.add_subplot(1, 1, 1)
axes.yaxis.set_label_coords(-0.03,1)
sns.distplot(data.loc[data["sample_compe"] == 1,"salary_am_kokuji"],kde=False,rug=False,bins=list(np.arange(0,10000,500)),color="black",axlabel="議員報酬額 (単位:百円)")
plt.ylabel("(頻度)",rotation=0,fontsize=18)
plt.savefig("hist_sala_0604.pdf",dpi=400)

#議員報酬額関連変数：要約統計量

salas = ["salary_am_kokuji","dummy_up_salary_am","dummy_down_salary_am"]
des_salas = master.loc[master["sample_compe"] == 1,salas].describe().round(3).T

des_salas.columns = ["観測数","平均値","標準偏差","最小値","第一四分位数","中央値","第三四分位数","最大値"]
des_salas.index = ["議員報酬額","議員報酬増額ダミー","議員報酬減額ダミー"]
des_salas.to_latex("sumstat_sala_0604.tex")

#議員報酬変動額：要約統計量とヒストグラム
changes= ["increase_salary","decrease_salary"]
des_changes = master.loc[master["sample_compe"] == 1,changes].describe().round(3).T
data.loc[data["increase_salary"]!=0,"increase_salary"].describe().T
#これはただの増額幅、増額割合を出したい

#増額パーセント
master["increase_percent"] = master["increase_salary"]/master["salary_am_pre"]
sum_up = master.loc[(master["sample_compe"] == 1)&(master["increase_percent"]!=0),"increase_percent"].describe().T
sum_up

#減額パーセント
master["decrease_percent"] = master["decrease_salary"]/master["salary_am_pre"]
sum_down = master.loc[(master["sample_compe"] == 1)&(master["decrease_percent"]!=0),"decrease_percent"].describe().T
sum_down
 
sum_change = pd.DataFrame([sum_up,sum_down])
sum_change.columns = ["観測数","平均値","標準偏差","最小値","第一四分位数","中央値","第三四分位数","最大値"]
sum_change.index = ["議員報酬額増額率","議員報酬額減額率"]
sum_change = sum_change.round(3)
sum_change.to_latex("sumstat_change_0604.tex")



##ヒストグラム
fig = plt.figure(figsize=(16,18)) 
plt.subplots_adjust(wspace=0.2)

axes = fig.add_subplot(2, 1, 1)
axes.yaxis.set_label_coords(-0.03,1)
sns.distplot(master.loc[(master["sample_compe"] == 1)&(master["increase_percent"]!=0),"increase_percent"],kde=False,rug=False,bins=list(np.arange(0,1.1,0.05)),color="black",axlabel="議員報酬額増額率 (1任期)")
plt.ylim(0,320)
plt.ylabel("(頻度)",rotation=0,fontsize=18)

axes = fig.add_subplot(2, 1, 2)
axes.yaxis.set_label_coords(-0.03,1)
sns.distplot(master.loc[(master["sample_compe"] == 1)&(master["decrease_percent"]!=0),"decrease_percent"],kde=False,rug=False,bins=list(np.arange(0,1.1,0.05)),color="black",axlabel="議員報酬額減額率 (1任期)") 
plt.ylim(0,320)
plt.ylabel("(頻度)",rotation=0,fontsize=18)

plt.savefig("hist_change_0605.pdf",dpi=400)