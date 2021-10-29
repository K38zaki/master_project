print("vscode hello")

import numpy as np
import pandas as pd
import camelot
import tabula

dfs = tabula.read_pdf("jyorei_teian_pdfs/09_11_jyorei.pdf", pages='all', multiple_tables=True, encoding="shift-jis")
len(dfs)
dfs.df

#2012,13
dfs = camelot.read_pdf("jyorei_teian_pdfs/12_13_jyorei.pdf", pages='1-end', split_text=True, encoding="shift-jis")

jyorei_12_13 = pd.concat([dfs[i].df for i in range(10,18)],axis=0)
jyorei_12_13.columns = jyorei_12_13.iloc[0]
jyorei_12_13 = jyorei_12_13.iloc[1:]
jyorei_12_13.sort_values("議決年月日").iloc[:-7]

jyorei_12_13 = jyorei_12_13[jyorei_12_13["議決年月日"] != "議決年月日"]
jyorei_12_13.議決年月日
jyorei_12_13 = jyorei_12_13.reset_index(drop=True)

#議決年月日の年のみを取り出し、columnとして追加
jyorei_12_13["和暦年"] = [jyorei_12_13.loc[i, "議決年月日"][:jyorei_12_13.loc[i, "議決年月日"].find(".")] for i in jyorei_12_13.index]
jyorei_12_13["和暦月"] = [jyorei_12_13.loc[i, "議決年月日"][jyorei_12_13.loc[i, "議決年月日"].find(".")+1:jyorei_12_13.loc[i, "議決年月日"].rfind(".")] for i in jyorei_12_13.index]

#合計だけ切り出し
sum_12_13 = jyorei_12_13.iloc[-1]
jyorei_12_13 = jyorei_12_13.iloc[:-1]

jyorei_12_13["和暦年"] = jyorei_12_13["和暦年"].astype("int64")
jyorei_12_13["和暦月"] = jyorei_12_13["和暦月"].astype("int64")
jyorei_12_13

#「jyorei_nendo」を作成; 西暦
jyorei_12_13.loc[jyorei_12_13["和暦月"] < 4, "jyorei_nendo"] = 1988 + jyorei_12_13["和暦年"] - 1
jyorei_12_13.loc[jyorei_12_13["和暦月"] >= 4, "jyorei_nendo"] = 1988 + jyorei_12_13["和暦年"]

# 「jyorei_year」を作成; 西暦
jyorei_12_13["jyorei_year"] = 1988 + jyorei_12_13["和暦年"]

jyorei_12_13["jyorei_year"].unique()

#time_pm
jyorei_12_13["time_pm"] = jyorei_12_13["都道府県名"] + jyorei_12_13["市町村名"]
jyorei_12_13["time_pm"]

#group_by(time_pm,nendo)
jyorei_year_12_13 = jyorei_12_13.groupby(["time_pm","jyorei_nendo"]).count()["市町村名"]

#2014,15
dfs = camelot.read_pdf("jyorei_teian_pdfs/14_15_jyorei.pdf", pages='1-end', split_text=True, encoding="shift-jis")

jyorei_14_15 = pd.concat([dfs[i].df for i in range(9,15)],axis=0)
jyorei_14_15.columns = jyorei_14_15.iloc[0]
jyorei_14_15 = jyorei_14_15.iloc[1:]
jyorei_14_15.sort_values("議決年月日")

jyorei_14_15 = jyorei_14_15[jyorei_14_15["議決年月日"] != "議決年月日"]
jyorei_14_15 = jyorei_14_15.reset_index(drop=True)
jyorei_14_15

sum_14_15 = jyorei_14_15.iloc[-1]
jyorei_14_15 = jyorei_14_15.iloc[:-1]

jyorei_14_15["和暦年"] = [jyorei_14_15.loc[i, "議決年月日"][1:jyorei_14_15.loc[i, "議決年月日"].find(".")] for i in jyorei_14_15.index]
jyorei_14_15["和暦月"] = [jyorei_14_15.loc[i, "議決年月日"][jyorei_14_15.loc[i, "議決年月日"].find(".")+1:jyorei_14_15.loc[i, "議決年月日"].rfind(".")] for i in jyorei_14_15.index]

jyorei_12_13["和暦月"].unique()
jyorei_14_15["和暦年"] = jyorei_14_15["和暦年"].astype("int64")
jyorei_14_15["和暦月"] = jyorei_14_15["和暦月"].astype("int64")

jyorei_14_15.loc[jyorei_14_15["和暦月"] < 4, "jyorei_nendo"] = 1988 + jyorei_14_15["和暦年"] - 1
jyorei_14_15.loc[jyorei_14_15["和暦月"] >= 4, "jyorei_nendo"] = 1988 + jyorei_14_15["和暦年"]


jyorei_14_15["jyorei_year"] = 1988 + jyorei_14_15["和暦年"]

jyorei_14_15["jyorei_nendo"].unique()
jyorei_14_15[jyorei_14_15["jyorei_nendo"] == 2013] #長崎県小値賀町,1件だけ前年度

jyorei_14_15["time_pm"] = jyorei_14_15["都道府県名"] + jyorei_14_15["市町村名"]
jyorei_14_15["time_pm"]

jyorei_year_14_15 = jyorei_14_15.groupby(["time_pm","jyorei_nendo"]).count()["市町村名"]

#concatnate
jyorei_year_12_15 = pd.concat([jyorei_year_12_13,jyorei_year_14_15],axis=0).reset_index()
jyorei_year_12_15[jyorei_year_12_15["time_pm"]=="長崎県小値賀町"] #長崎県小値賀町,普通にくっつけて問題なし

jyorei_12_15 = pd.concat([jyorei_12_13,jyorei_14_15],axis=0).reset_index(drop=True)

#sum_12_13 166団体 208件 原案\n可決 193件 修正\n可決 15件
#sum_14_15 141団体 214件 原案\n可決 207件 修正\n可決  7件

jyorei_12_15.to_csv("jyorei_teian_pdfs/jyorei_list_12_15.csv")
jyorei_year_12_15.to_csv("jyorei_teian_pdfs/num_jyorei_12_15.csv")

#2016,17
dfs = camelot.read_pdf("jyorei_teian_pdfs/16_17.pdf", pages='1-end', split_text=True, encoding="shift-jis")
dfs[10].df
type(dfs[10])
len(dfs)

jyorei_16_17 = pd.concat([dfs[i].df for i in range(10,16)],axis=0)
jyorei_16_17.columns = jyorei_16_17.iloc[0]
jyorei_16_17 = jyorei_16_17.iloc[1:]
jyorei_16_17.sort_values("議決年月日")

jyorei_16_17 = jyorei_16_17[jyorei_16_17["議決年月日"] != "議決年月日"]
jyorei_16_17 = jyorei_16_17.reset_index(drop=True)
jyorei_16_17

sum_16_17 = jyorei_16_17.iloc[-1]
jyorei_16_17 = jyorei_16_17.iloc[:-1]

jyorei_16_17["和暦年"] = [jyorei_16_17.loc[i, "議決年月日"][1:jyorei_16_17.loc[i, "議決年月日"].find(".")] for i in jyorei_16_17.index]
jyorei_16_17["和暦月"] = [jyorei_16_17.loc[i, "議決年月日"][jyorei_16_17.loc[i, "議決年月日"].find(".")+1:jyorei_16_17.loc[i, "議決年月日"].rfind(".")] for i in jyorei_16_17.index]

jyorei_16_17["和暦年"].unique()
jyorei_16_17["和暦月"].unique()

jyorei_16_17["和暦年"] = jyorei_16_17["和暦年"].astype("int64")
jyorei_16_17["和暦月"] = jyorei_16_17["和暦月"].astype("int64")

jyorei_16_17.loc[jyorei_16_17["和暦月"] < 4, "jyorei_nendo"] = 1988 + jyorei_16_17["和暦年"] - 1
jyorei_16_17.loc[jyorei_16_17["和暦月"] >= 4, "jyorei_nendo"] = 1988 + jyorei_16_17["和暦年"]

jyorei_16_17["jyorei_year"] = 1988 + jyorei_16_17["和暦年"]

jyorei_16_17["jyorei_nendo"].unique()
jyorei_16_17[jyorei_16_17["jyorei_nendo"] == 2018] #北海道砂川市,1件だけ2018年度→分析対象外なのでomit
jyorei_16_17 = jyorei_16_17[jyorei_16_17["jyorei_nendo"] != 2018]

jyorei_16_17["time_pm"] = jyorei_16_17["都道府県名"] + jyorei_16_17["市町村名"]
jyorei_16_17["time_pm"]
jyorei_16_17 = jyorei_16_17.reset_index(drop=True)
jyorei_16_17

jyorei_year_16_17 = jyorei_16_17.groupby(["time_pm","jyorei_nendo"]).count()["市町村名"]

jyorei_year_16_17

#sum_16_17 →　151団体 190件 185件 5件 (砂川市1件;修正可決　を抜く前)

jyorei_l = pd.read_csv("jyorei_teian_pdfs/jyorei_list_12_15.csv",index_col=0)
n_jyorei = pd.read_csv("jyorei_teian_pdfs/num_jyorei_12_15.csv",index_col=0)

jyorei_l = pd.concat([jyorei_l,jyorei_16_17],axis=0).reset_index(drop=True)
n_jyorei = pd.concat([n_jyorei,jyorei_year_16_17.reset_index()],axis=0).reset_index(drop=True)


