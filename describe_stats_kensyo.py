
from cycler import concat
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns
from seaborn.utils import despine
from matplotlib import rc


master = pd.read_stata("1219_data.dta")
master[master["age_mean_cand"] < 50]["age_mean_cand"]
master[master["voting_rate_p"] > 0.95]



deps = ["compe_rate_adopt","no_voting_ratio_win","ratio_women_cand_adopt","age_mean_cand","dummy_forfeit_deposit","teian_jyorei_4y",
         "adjusted_ave_voteshare_inc","voting_rate_p"]
samples = ["sample_compe","sample_novote","sample_women","sample_age","sample_depo","sample_teian",
         "sample_inc_ols","sample_voting_ols"]

depdata = master[deps+samples+["lnsalary_am_kokuji","dummy_up_salary_am","dummy_down_salary_am"]]

sns.set_style(style="darkgrid")
sns.set(font="MS Gothic")
sns.set_context("poster", rc={"font.size":20,"axes.titlesize":8,"axes.labelsize":25})  
rc('font',**{'family':'serif','serif':['MS Gothic']})
plt.rcParams['pdf.fonttype'] = 42 

fig = plt.figure(figsize=(25,15))
plt.subplots_adjust(wspace=0.2, hspace=0.4)
axes = fig.add_subplot(2, 3, 1)
sns.distplot(depdata.loc[depdata[samples[0]] == 1,deps[0]],kde=False,rug=False,bins=list(np.arange(0.4,2,0.1)),axlabel="1議席あたり立候補人数",color="black")
axes = fig.add_subplot(2, 3, 2)
sns.distplot(depdata.loc[depdata[samples[2]] == 1,deps[2]],kde=False,rug=False,bins=list(np.arange(0,1.2,0.1)),axlabel="立候補者女性割合",color="black")
axes = fig.add_subplot(2, 3, 3)
sns.distplot(depdata.loc[depdata[samples[3]] == 1,deps[3]],kde=False,rug=False,bins=list(np.arange(45,80,5)),axlabel="立候補者平均年齢",color="black")
axes = fig.add_subplot(2, 3, 4)
sns.distplot(depdata.loc[depdata[samples[5]] == 1,deps[5]],kde=False,rug=False,bins=list(np.arange(0,13,1)),axlabel="議員提案条例可決数(任期中)",color="black")
axes = fig.add_subplot(2, 3, 5)
sns.distplot(depdata.loc[depdata[samples[6]] == 1,deps[6]],kde=False,rug=False,bins=list(np.arange(0,1.1,0.1)),axlabel="調整済み現職1人あたり得票率",color="black")
axes = fig.add_subplot(2, 3, 6)
sns.distplot(depdata.loc[depdata[samples[7]] == 1,deps[7]],kde=False,rug=False,bins=list(np.arange(0,1.1,0.1)),axlabel="投票率",color="black")
plt.savefig("histgram_dep_0605.pdf",dpi=400)
#plt.savefig("histgram_dep_kensyo.png",dpi=400)