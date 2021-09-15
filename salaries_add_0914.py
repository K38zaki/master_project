import pandas as pd
import numpy as np
import tabula


dfs = tabula.read_pdf("salaries_pdfs/R2_kyuyo_1_05.pdf", stream=True, pages = '2-65',multiple_tables=True)
dfs[0]
dfs[1].iloc[0,0].replace(" ","")

# 何行目から情報が載っているか、それが各シートで統一されているかチェック
for i in range(0,64):
    if i % 2 == 0:
        print(dfs[i].iloc[4:7,0])
    else:
        pass
## → True

#1シート目(偶数ページ)

#自治体名
#2列名がnanになっている自治体＝都道府県は削除
l_1 =list(dfs[4].iloc[5:,0][dfs[4].iloc[5:,2].isnull() == False].str.replace(" ",""))

#変数
dfs[4].iloc[5:,1:]
dfs[4].iloc[5:,2].dropna().str.split()

#全職種・職員数、職員平均年齢
l_2 = [int(list(dfs[4].iloc[5:,2].dropna().str.replace(",","").str.split())[i][0]) for i in range(dfs[4].iloc[5:,2].dropna().shape[0])]
l_3 = [float(list(dfs[4].iloc[5:,2].dropna().str.split())[i][1]) for i in range(dfs[4].iloc[5:,2].dropna().shape[0])]

#1個目が全職種・月額給与
l_4 = [list(dfs[4].iloc[5:,3].dropna().str.replace(",","").str.split())[i][0] for i in range(dfs[4].iloc[5:,3].dropna().shape[0])]

#1個目が全職種・期末手当
l_5 = [list(dfs[4].iloc[5:,6].dropna().str.replace(",","").str.split())[i][0] for i in range(dfs[4].iloc[5:,6].dropna().shape[0])]

#一般行政職・職員数、職員平均年齢
l_6 = [list(dfs[4].iloc[5:,7].dropna().str.replace(",","").str.split())[i][0] for i in range(dfs[4].iloc[5:,7].dropna().shape[0])]
l_7 = [list(dfs[4].iloc[5:,7].dropna().str.split())[i][1] for i in range(dfs[4].iloc[5:,2].dropna().shape[0])]
dfs[4].iloc[5:-2,7].str.split()

#1個目が一般行政職・月額給与
l_8 = [list(dfs[4].iloc[5:,9].dropna().str.replace(",","").str.split())[i][0] for i in range(dfs[4].iloc[5:,9].dropna().shape[0])]

#1個目が一般行政職・期末手当
l_9 = [list(dfs[4].iloc[5:-2,-1].dropna().str.replace(",","").str.split())[i][0] for i in range(dfs[4].iloc[5:,-1].dropna().shape[0])]

fi_df = pd.DataFrame([l_1,l_2,l_3,l_4,l_5,l_6,l_7,l_8,l_9]).T

#1シート目の列数が各ページで統一されているか確認
dfs[2].iloc[5:,:].shape[1]
dfs[4].iloc[5:,:]
dfs[4].iloc[5:-2,:].shape[1]
dfs[6].iloc[5:,:].shape[1]
dfs[8].iloc[5:,:].shape[1]
dfs[10].iloc[5:,:].shape[1]
dfs[12].iloc[5:,:].shape[1]

## →　False

#一般行政職・期末手当　以外
for i in range(2,64):
    if i % 2 == 0:
        print(dfs[i].iloc[5:,:].shape[1],dfs[i].iloc[7,0].replace(" ",""))
        if dfs[i].iloc[5:,:].shape[1] == 18:
            print(dfs[i].iloc[7,2:4].str.split())
            print(dfs[i].iloc[7,6:10].str.split())
        else:
            print(dfs[i].iloc[7,1:3].str.split())
            print(dfs[i].iloc[7,5:9].str.split())
    else:
        pass
    
# →　18列と17列のページで関数を変更

#一般行政職・期末手当
for i in range(2,64):
    if i % 2 == 0:
        print(dfs[i].iloc[7,-1])
    else:
        pass

## →　OK

#2シート目(奇数ページ)
dfs[5]

#自治体名
#列数18
this_df = dfs[5][dfs[5].iloc[:,3].isnull() == False]
name_2 = [(str(this_df.iloc[i,0])+str(this_df.iloc[i,1])).replace("nan","").replace(" ","") for i in range(this_df.shape[0])]
#列数16
this_df = dfs[7][dfs[7].iloc[:,1].isnull() == False]
name_2 = list(this_df.iloc[:,0].str.replace(" ",""))

#変数
#列数18
var_df = this_df.iloc[:,3:]
 #or
#列数16
var_df = this_df.iloc[:,1:]

var_df.insert(0,"name_2",name_2)
var_df = var_df.reset_index(drop=True)

all_df = pd.concat([fi_df,var_df],axis=1)
all(all_df["name_2"] == all_df[0])

# 列数確認
for i in range(2,64):
    if i % 2 == 1:
        print(dfs[i].shape[1],dfs[i].iloc[2,0].replace(" ",""))
        if dfs[i].shape[1] == 16:
            print(any(dfs[i].iloc[2,1:].isnull()))
        else:
            print(any(dfs[i].iloc[2,3:].isnull()))
    else:
        pass
    
pd.read_csv("prefs_seirei_first_from_20140405.csv",index_col=0)
