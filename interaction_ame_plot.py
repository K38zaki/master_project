import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns


d_a= np.array([[ 0.029, -0.108,  0.167],
       [ 0.036, -0.102,  0.175],
       [ 0.044, -0.095,  0.183],
       [ 0.053, -0.087,  0.192],
       [ 0.063, -0.077,  0.203],
       [ 0.074, -0.067,  0.214],
       [ 0.086, -0.055,  0.227],
       [ 0.1  , -0.041,  0.241],
       [ 0.115, -0.026,  0.256],
       [ 0.132, -0.008,  0.273],
       [ 0.151,  0.011,  0.292],
       [ 0.173,  0.032,  0.313],
       [ 0.197,  0.055,  0.339],
       [ 0.224,  0.077,  0.37 ],
       [ 0.253,  0.098,  0.408],
       [ 0.287,  0.116,  0.458],
       [ 0.324,  0.126,  0.522],
       [ 0.365,  0.128,  0.603],
       [ 0.412,  0.117,  0.707],
       [ 0.464,  0.092,  0.835],
       [ 0.522,  0.049,  0.994]])


#sns.relplot(x=np.arange(5, 15.5, 0.5), y=data[:,0],kind="line",marker="o")
len(d_a[:,0])

d_a = d_a.astype('float64')
sns.set(font="MS Gothic")
sns.set_style("whitegrid", {'grid.linestyle': '--'})
sns.set_context("poster", rc={"font.size":30,"axes.titlesize":30,"axes.labelsize":30}) 
plt.rcParams["font.family"] = "MS Gothic"   # 使用するフォント
plt.rcParams["font.size"] = 30
 

plt.figure(figsize=(16, 9))
sns.lineplot(np.arange(5, 15.5, 0.5), d_a[:,0],marker="o").set_title("被説明変数:1議席あたり立候補人数")
#plt.plot(np.arange(5, 15.5, 0.5), d_a[:,0],marker="o",)
plt.fill_between(np.arange(5, 15.5, 0.5),d_a[:,1], d_a[:,2], color='gray', alpha=.25)
plt.xlabel("対数人口")
plt.ylabel("対数議員報酬額の平均限界効果")
plt.savefig("compe_popu_ame.png",dpi=400)

d_b = np.loadtxt("women_2sri_int_ames.csv",delimiter=",")

plt.figure(figsize=(16, 9))
sns.lineplot(np.arange(5, 15.5, 0.5), d_b[:,0],marker="o").set_title("被説明変数:立候補者女性割合")
#plt.plot(np.arange(5, 15.5, 0.5), d_a[:,0],marker="o",)
plt.fill_between(np.arange(5, 15.5, 0.5),d_b[:,1], d_b[:,2], color='gray', alpha=.25)
plt.xlabel("対数人口")
plt.ylabel("対数議員報酬額の平均限界効果")
plt.savefig("women_popu_ame.png",dpi=400)

d_c = np.loadtxt("age_2sri_int_ames.csv",delimiter=",")

plt.figure(figsize=(16, 9))
sns.lineplot(np.arange(5, 15.5, 0.5), d_c[:,0],marker="o").set_title("被説明変数:立候補者平均年齢")
#plt.plot(np.arange(5, 15.5, 0.5), d_a[:,0],marker="o",)
plt.fill_between(np.arange(5, 15.5, 0.5),d_c[:,1], d_c[:,2], color='gray', alpha=.25)
plt.xlabel("対数人口")
plt.ylabel("対数議員報酬額の平均限界効果")
plt.savefig("age_popu_ame.png",dpi=400)