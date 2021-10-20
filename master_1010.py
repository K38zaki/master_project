import pandas as pd
import numpy as np
import datetime
from dateutil.relativedelta import relativedelta

#都市化計画区域のデータ（area）
master = pd.read_csv("master_datas/master_0520_1007_v2.csv",index_col=0)
master

area = pd.read_csv("demographic_data/area_variables_alls.csv",encoding="cp932")
area_20 = pd.read_excel("demographic_data/area_2020.xls",encoding="cp932")
area_19 = pd.read_excel("demographic_data/area_2019.xls",encoding="cp932")
area_19 #都市化計画区域0の地域はデータなし（行なし）
area_20
area.columns = area.iloc[0]
area = area.iloc[1:]

area["地域"].str.split(expand=True)[area["地域"].str.split(expand=True).isnull()==False].unique()
pm = area["地域"].str.split(expand=True)
pm.columns = ["prefecture","municipality"]
area = pd.concat([area,pm],axis=1)
area_18 = area[(area["調査年"] == "2018年度") & (area["district"].isnull())]
area_18

#2019
area_19[area_19["Unnamed: 0"] == "青森県"]
area_19.iloc[17:133]["Unnamed: 2"].unique()
list(area_18[area_18["prefecture"]=="北海道"]["municipality"].values)

judge = [True if i in list(area_19.iloc[17:133]["Unnamed: 2"].unique()) else False for i in list(area_18[area_18["prefecture"]=="北海道"]["municipality"].values)]

j_df = pd.DataFrame([list(area_18[area_18["prefecture"]=="北海道"]["municipality"].values),judge]).T
j_df[j_df[1] == False]

area_19[area_19["Unnamed: 2"].isnull() == False]

#都道府県ラベルの追加
area_19[area_19["Unnamed: 2"] == "計"]
id_p = list(area_19[area_19["Unnamed: 2"] == "計"].index)
name_p = list(area_19[area_19["Unnamed: 2"] == "計"]["Unnamed: 0"].values)
area_19.insert(1,"prefecture",np.nan)

for i in range(len(id_p) - 1):
    area_19.loc[id_p[i]:id_p[i+1]-1,"prefecture"] = name_p[i]
area_19.loc[id_p[46]:,"prefecture"] = name_p[46]

area_19[area_19["prefecture"] == "石川県"]
area_19_c = area_19[(area_19["Unnamed: 2"].isnull() == False) & (area_19["Unnamed: 2"] != "計")]
area_19_c.columns = area_19_c.iloc[0]
area_19_c = area_19_c.iloc[1:]
area_19_c.columns

area = area.drop(["調査年 コード","地域 コード","/項目"],axis=1)
area.columns = ["area_nendo","area_name","toshi_keikaku_area","sigaika_chousei_area","sigaika_area","jyukyo_only","jyukyo","industrial_only","commerce","industrial","prefecture","municipality"] 

area["area_nendo"] = area["area_nendo"].str.replace("年度","").astype("int64")
area.loc[:,"toshi_keikaku_area":"industrial"] = area.loc[:,"toshi_keikaku_area":"industrial"].replace("***",np.nan).replace('-',np.nan).astype("float64")
area.columns

area_19_c.columns
area_19_cp = area_19_c.iloc[:,[1,3,10,15,20]+list(range(24,36))]
area_19_cp = area_19_cp.fillna(0)
area_19_cp.iloc[:,2:] = area_19_cp.iloc[:,2:].astype("float64")
area_19_cp.columns

area_19_new = pd.DataFrame([[2019]*area_19_cp.shape[0],area_19_cp.iloc[:,0:2].sum(axis=1),area_19_cp.iloc[:,2],area_19_cp.iloc[:,4],area_19_cp.iloc[:,3],
                           area_19_cp.iloc[:,5:9].sum(axis=1),area_19_cp.iloc[:,9:12].sum(axis=1),area_19_cp.iloc[:,16],area_19_cp.iloc[:,12:14].sum(axis=1),
                           area_19_cp.iloc[:,14:16].sum(axis=1),area_19_cp.iloc[:,0],area_19_cp.iloc[:,1]]).T

area_19_new.columns = area.columns
area_19_nn = area_19_new.groupby("area_name").sum().iloc[:,1:-2].reset_index()
area_19_id = area_19_new[["area_name","area_nendo","prefecture","municipality"]].groupby("area_name").first().reset_index()
area_19_nn = pd.merge(area_19_nn,area_19_id,how="left",on="area_name")
area_19_nn

area_all = pd.concat([area_19_nn,area],axis=0)
area_all

#2020
area_20.columns = area_20.iloc[1]
area_20 = area_20.iloc[3:]
area_20_c = area_20[area_20.iloc[:,3].isnull() == False]
area_20_c.columns
area_20_cp = area_20_c.iloc[:,[0,3,10,15,20]+list(range(24,37))]
area_20_cp = area_20_cp.fillna(0)
area_20_cp.iloc[:,2:] = area_20_cp.iloc[:,2:].astype("float64")
area_20_cp.columns

area.columns

area_20_new = pd.DataFrame([[2020]*area_20_cp.shape[0],area_20_cp.iloc[:,0:2].sum(axis=1),area_20_cp.iloc[:,2],area_20_cp.iloc[:,4],area_20_cp.iloc[:,3],
                           area_20_cp.iloc[:,5:9].sum(axis=1),area_20_cp.iloc[:,9:12].sum(axis=1),area_20_cp.iloc[:,17],area_20_cp.iloc[:,13:15].sum(axis=1),
                           area_20_cp.iloc[:,15:17].sum(axis=1),area_20_cp.iloc[:,0],area_20_cp.iloc[:,1]]).T #2020年のみ存在の田園住居地域は除いた

area_20_new.columns = area.columns
area_20_nn = area_20_new.groupby("area_name").sum().iloc[:,1:-2].reset_index()
area_20_id = area_20_new[["area_name","area_nendo","prefecture","municipality"]].groupby("area_name").first().reset_index()
area_20_nn = pd.merge(area_20_nn,area_20_id,how="left",on="area_name")
area_20_nn

area_all = pd.concat([area_20_nn,area_all],axis=0)
area_all[area_all["municipality"] == "富谷町"] # 非連続市町村がない！

#非連続市町村
area_disc = pd.read_csv("demographic_data/area_discont.csv",encoding="cp932")

area_disc.columns = area_disc.iloc[0]
area_disc = area_disc.iloc[1:]
area_disc = area_disc.drop(["調査年 コード","地域 コード","/項目"],axis=1)
pm = area_disc["地域"].str.split(expand=True)
area_disc = pd.concat([area_disc,pm],axis=1) 
area_disc.columns = ["area_nendo","area_name","toshi_keikaku_area","sigaika_chousei_area","sigaika_area","jyukyo_only","jyukyo","industrial_only","commerce","industrial","prefecture","municipality"]
area_disc["prefecture"] = area_disc["prefecture"].str.replace("（旧）","")

area_disc["area_nendo"] = area_disc["area_nendo"].str.replace("年度","").astype("int64")
area_disc.loc[:,"toshi_keikaku_area":"industrial"] = area_disc.loc[:,"toshi_keikaku_area":"industrial"].replace("***",np.nan).replace('-',np.nan).astype("float64")

area_all = pd.concat([area_all,area_disc],axis=0)
area_all["time_pm"] = area_all["prefecture"] + area_all["municipality"]
area_all["time_pm"] = area_all["time_pm"].str.replace("兵庫県丹波篠山市","兵庫県篠山市")
area_all.loc[(area_all["time_pm"] == "兵庫県篠山市")&(area_all["area_nendo"] == 2020),"time_pm"] = "兵庫県丹波篠山市"
area_all[area_all["time_pm"] == "兵庫県篠山市

area_all["time_pm"] = area_all["time_pm"].str.replace("ケ","ヶ")
area_all["time_pm"] = area_all["time_pm"].str.replace("金ヶ崎","金ケ崎").str.replace("龍ヶ崎","龍ケ崎")

area_all.to_csv("area_all.csv") #2019年及び2020年は、都市計画区域の指定がある市町村のみ

#マージ＆2019年以降の欠損を埋める

master = pd.read_csv("master_datas/master_0520_1007_v2.csv",index_col=0)
area_all = pd.read_csv("area_all.csv",index_col=0)

area_all["time_pm"] = area_all["time_pm"].str.replace("（旧）","")
area_all["prefecture"] = area_all["prefecture"].str.replace("（旧）","") 
         
master["area_nendo"] = master["nendo"]
kari_m = pd.merge(master,area_all,how="left",on=["area_nendo","time_pm"])
kari_m[(kari_m["toshi_keikaku_area"].isnull())&(kari_m["area_nendo"] != 2019)&(kari_m["area_nendo"] != 2020)]["ele_ID"].values

area_all[area_all["time_pm"] == "北海道幌延町"]
area_all[area_all["time_pm"] == "北海道幌加内町"]　#上記2つなぜか2010年以前が欠損　→　おそらく2010年管轄振興局の変更によるもの
area_all[area_all["time_pm"] == "高知県檮原町"]　　#檮原町に
area_all[area_all["time_pm"] == "愛知県長久手市"]　#2011年も長久手市に
area_all[area_all["time_pm"] == "石川県野々市市"]  #2011年も野々市市に     
#新潟市、浜松市、熊本市、相模原市　→　新設前の旧自治体のデータが無いので追加
         
#新潟市、浜松市、熊本市、相模原市の旧自治体分データ
area_disc = pd.read_csv("demographic_data/area_bigdisa.csv",encoding="cp932")

area_disc.columns = area_disc.iloc[0]
area_disc = area_disc.iloc[1:]
area_disc = area_disc.drop(["調査年 コード","地域 コード","/項目"],axis=1)
pm = area_disc["地域"].str.split(expand=True)
area_disc = pd.concat([area_disc,pm],axis=1) 
area_disc.columns = ["area_nendo","area_name","toshi_keikaku_area","sigaika_chousei_area","sigaika_area","jyukyo_only","jyukyo","industrial_only","commerce","industrial","prefecture","municipality"]
area_disc["prefecture"] = area_disc["prefecture"].str.replace("（旧）","")

area_disc["area_nendo"] = area_disc["area_nendo"].str.replace("年度","").astype("int64")
area_disc.loc[:,"toshi_keikaku_area":"industrial"] = area_disc.loc[:,"toshi_keikaku_area":"industrial"].replace("***",np.nan).replace('-',np.nan).astype("float64")
area_disc["time_pm"] = area_disc["prefecture"] + area_disc["municipality"]

area_all = pd.concat([area_all,area_disc],axis=0)
area_all
         
#幌加内町、幌延町
area_disc = pd.read_csv("demographic_data/area_hokkai_change.csv",encoding="cp932")

area_disc.columns = area_disc.iloc[0]
area_disc = area_disc.iloc[1:]
area_disc = area_disc.drop(["調査年 コード","地域 コード","/項目"],axis=1)
pm = area_disc["地域"].str.split(expand=True)
area_disc = pd.concat([area_disc,pm],axis=1) 
area_disc.columns = ["area_nendo","area_name","toshi_keikaku_area","sigaika_chousei_area","sigaika_area","jyukyo_only","jyukyo","industrial_only","commerce","industrial","prefecture","municipality"]
area_disc["prefecture"] = area_disc["prefecture"].str.replace("（旧）","")

area_disc["area_nendo"] = area_disc["area_nendo"].str.replace("年度","").astype("int64")
area_disc.loc[:,"toshi_keikaku_area":"industrial"] = area_disc.loc[:,"toshi_keikaku_area":"industrial"].replace("***",np.nan).replace('-',np.nan).astype("float64")
area_disc["time_pm"] = area_disc["prefecture"] + area_disc["municipality"]

area_all = pd.concat([area_all,area_disc],axis=0)
area_all

#2011年の野々市市、長久手市をそれぞれ町に
area_all.loc[(area_all["time_pm"] == "愛知県長久手市")&(area_all["area_nendo"] == 2011),"time_pm"] = "愛知県長久手町"
area_all.loc[(area_all["time_pm"] == "石川県野々市市")&(area_all["area_nendo"] == 2011),"time_pm"] = "石川県野々市町"
area_all.loc[(area_all["time_pm"] == "石川県野々市市")]

#檮原町を梼原町に
area_all["time_pm"] = area_all["time_pm"].str.replace("高知県檮原町","高知県梼原町")
area_all.loc[(area_all["time_pm"] == "高知県梼原町")]
         
#島根県斐川町の2011年のみ前年度の情報に
master.loc[(master["time_pm"] == "島根県斐川町")&(master["nendo"] == 2011),"area_nendo"] = 2010
master.loc[(master["time_pm"] == "島根県斐川町")]

#再マージ
kari_m = pd.merge(master,area_all,how="left",on=["area_nendo","time_pm"])
kari_m[(kari_m["toshi_keikaku_area"].isnull())&(kari_m["area_nendo"] != 2019)&(kari_m["area_nendo"] != 2020)]["ele_ID"].values #ok

#19年20年の欠損うめ
kari_m.columns[-12:]
kari_m.loc[(kari_m["toshi_keikaku_area"].isnull())&(kari_m["area_nendo"] == 2019),'toshi_keikaku_area':'industrial'] = 0
kari_m.loc[(kari_m["toshi_keikaku_area"].isnull())&(kari_m["area_nendo"] == 2020),'toshi_keikaku_area':'industrial'] = 0

kari_m.loc[(kari_m["toshi_keikaku_area"].isnull())] ##ok

master = kari_m
area_all.to_csv("area_all.csv")
master.to_csv("master_datas/master_0520_1011_v1.csv")

##時間インデックスを作成　→　2005年4月からの経過月数とする
master["kokuji_ym"] = pd.to_datetime(master["kokuji_dt"]).dt.strftime("%Y-%m")
master

months_old = pd.DataFrame([[(datetime.datetime(year=2005,month=4,day=1)+relativedelta(months=i-1)).strftime("%Y-%m"),i] for i in range(1,16*12+1)],columns=["kokuji_ym","months_old"])

kari_m = pd.merge(master,months_old,how="left",on="kokuji_ym")
kari_m[kari_m["months_old"].isnull()]
master = kari_m
master.to_csv("master_datas/master_0520_1012_v1.csv")

##クロスセクションインデックスを作成　→　「2021年時点の」市町村コード
master = pd.read_csv("master_datas/master_0520_1012_v1.csv",index_col=0)
master
codes = pd.read_excel("municipalities_code_2021.xlsx")
codes[codes["市区町村名\n（漢字）"].isnull()==False]
codes[codes["市区町村名\n（漢字）"]=="色丹村"]
# →　北方四島の6村を含むので　1941+6 = 1947行 

codes = codes[codes["市区町村名\n（漢字）"].isnull()==False]
codes["pres_pm"] = codes["都道府県名\n（漢字）"] + codes["市区町村名\n（漢字）"]
codes["pres_pm"] = codes["pres_pm"].str.replace("ケ","ヶ")
codes["pres_pm"] = codes["pres_pm"].str.replace("金ヶ崎","金ケ崎").str.replace("龍ヶ崎","龍ケ崎")

codes_p = codes.iloc[:,[0,3,4,5]]
codes_p.columns = ["pres_pm_codes","pref_kana","muni_kana","pres_pm"]

codes_disa = pd.DataFrame([[93670,"トチギケン","イワフネマチ","栃木県岩舟町"],[112267,"サイタマケン","ハトガヤシ","埼玉県鳩ヶ谷市"],[93211,"トチギケン","ニシカタマチ","栃木県西方町"],[324019,"シマネケン","ヒカワチョウ","島根県斐川町"],[34223,"イワテケン","フジサワチョウ","岩手県藤沢町"],[323047,"シマネケン","ヒガシイズモチョウ","島根県東出雲町"],[234818,"アイチケン","イッシキチョウ","愛知県一色町"],[234826,"アイチケン","キラチョウ","愛知県吉良町"],[234834,"アイチケン","ハズチョウ","愛知県幡豆町"]],columns=codes_p.columns)

codes_p = pd.concat([codes_p,codes_disa],axis=0).reset_index()
kari_m["pres_pm_codes"].dtypes

kari_m = pd.merge(master,codes_p,how="left",on="pres_pm")
kari_m[kari_m["pres_pm_codes"].isnull()]
master = kari_m
master.to_csv("master_datas/master_0520_1012_v1.csv")
         
master.groupby(["pres_pm_codes","months_old"]).count()["ele_ID"][master.groupby(["pres_pm_codes","months_old"]).count()["ele_ID"] > 1]
master[master["pres_pm"] == "北海道泊村"]

codes_p[codes_p["muni_kana"] == "ﾄﾏﾘﾑﾗ"]
#北海道泊村が２つある　→国後郡泊村の存在
master.groupby("pres_pm").count()["ele_ID"].unique()

#原因の特定
pd.read_csv("master_datas/master_0520_1004_v2.csv",index_col=0).groupby("pres_pm").count()["ele_ID"].unique()

jinko = pd.read_csv("jinko_all.csv",index_col=0)
jinko[jinko["time_pm"] == "北海道泊村"]
income = pd.read_csv("income_all.csv",index_col=0)
income[income["pres_pm"] == "北海道泊村"]     
zaisei = pd.read_csv("zaisei_all.csv",index_col=0)
zaisei[zaisei["time_pm"] == "北海道泊村"]
area = pd.read_csv("area_all.csv",index_col=0)
area[area["time_pm"] == "北海道泊村"] 
#悪さをしていたのは、jinko及びcodes(つまり、データに国後郡泊村が含まれており、その分masterdataが拡張した)
jinko
omit1 = master[(master["pres_pm"] == "北海道泊村")&(master["population_woman_ratio"].isnull())].index
omit2 = master[(master["pres_pm"] == "北海道泊村")&(master["population_woman_ratio"].isnull() == False)&(master["pres_pm_codes"] == 16969)].index     

master
master = master.drop(list(omit1)+list(omit2),axis=0)
master = master.reset_index()

master[master["pres_pm"] == "北海道泊村"].iloc[:,2373:].values
master.groupby("pres_pm").count()["ele_ID"][master.groupby("pres_pm").count()["ele_ID"] == 1]
         
master.to_csv("master_datas/master_0520_1012_v2.csv")
         
#menseki
master = pd.read_csv("master_datas/master_0520_1012_v2.csv",index_col=0)

master

menseki = pd.read_csv("demographic_data/menseki_variables_alls.csv",index_col=0,encoding="cp932")
menseki.columns = menseki.iloc[0]
menseki = menseki.iloc[1:]
menseki = menseki.reset_index(drop=True)
menseki[menseki["地域"] == "島根県 出雲市"]
master[master["municipality"] == "出雲市"]
master[master["municipality"] == "松本市"]["population"]
         
menseki = menseki.drop(["地域 コード","/項目"],axis=1)
menseki = pd.concat([menseki,menseki["地域"].str.split(expand=True)],axis=1)
menseki.columns = ["menseki_nendo","menseki_name","all_menseki","canlive_menseki","prefecture","municipality"]
menseki["prefecture"] = menseki["prefecture"].str.replace("（旧）","")
menseki["municipality"] = menseki["municipality"].replace("丹波篠山市","篠山市")
menseki["time_pm"] = menseki["prefecture"] + menseki["municipality"]
menseki[menseki["time_pm"] == "長野県長野市"]
menseki["menseki_nendo"] = menseki["menseki_nendo"].str.replace("年度","").astype("int64")
menseki.loc[:,"all_menseki":"canlive_menseki"] = menseki.loc[:,"all_menseki":"canlive_menseki"].replace('***',np.nan).replace('-',np.nan).astype("float64")
menseki["canlive_ratio_menseki"] = menseki["canlive_menseki"]/menseki["all_menseki"]
menseki[menseki["canlive_ratio_menseki"].isnull()]
master["meseki_nendo"] = master["nendo"]
master = master.rename({"meseki_nendo":"menseki_nendo"},axis=1)
master.loc[master["nendo"] == 2020,"menseki_nendo"] = 2019 #2020の面積・可住地は2019年のものを用いた

menseki["time_pm"] = menseki["time_pm"].str.replace("ケ","ヶ").str.replace("金ヶ崎","金ケ崎").str.replace("龍ヶ崎","龍ケ崎")

kari_m = pd.merge(master,menseki,how="left",on=["menseki_nendo","time_pm"])
         
kari_m[kari_m["all_menseki"].isnull()]         
menseki[menseki["time_pm"] == "島根県斐川町"]
         
menseki_n = pd.read_csv("demographic_data/menseki_nakagawa.csv",encoding="cp932")
menseki_n.columns = menseki_n.iloc[0]
menseki_n = menseki_n.iloc[1:]
menseki_n = menseki_n.drop(["調査年 コード","地域 コード","/項目"],axis=1)
menseki_n = pd.concat([menseki_n,menseki_n["地域"].str.split(expand=True)],axis=1)
menseki_n.columns = menseki.columns[:-2]
menseki_n["menseki_nendo"] = menseki_n["menseki_nendo"].str.replace("年度","").astype("int64")
menseki_n["prefecture"] = menseki_n["prefecture"].str.replace("（旧）","")
menseki_n.loc[:,"all_menseki":"canlive_menseki"] = menseki_n.loc[:,"all_menseki":"canlive_menseki"].astype("float64")
menseki_n["time_pm"] = menseki_n["prefecture"] + menseki_n["municipality"]
menseki_n["canlive_ratio_menseki"] = menseki_n["canlive_menseki"]/menseki_n["all_menseki"]
menseki_n
         
menseki = pd.concat([menseki,menseki_n],axis=0)
menseki["time_pm"] = menseki["time_pm"].str.replace("檮原町","梼原町")
kari_m = pd.merge(master,menseki,how="left",on=["menseki_nendo","time_pm"])
kari_m[kari_m["all_menseki"].isnull()] #だいたい合併直後の市町村　→　よって翌年のデータを与える
sasayama19 = menseki[(menseki["time_pm"] == "兵庫県篠山市")&(menseki["menseki_nendo"] == 2019)]
sasayama19.loc[:,"time_pm"] = "兵庫県丹波篠山市"
sasayama19.loc[:,"menseki_nendo"] = 2020       
sasayama19
master
menseki = menseki.append(sasayama19)          
master.loc[kari_m["all_menseki"].isnull(),"menseki_nendo"] = master.loc[kari_m["all_menseki"].isnull(),"menseki_nendo"]+1
#基本、欠損の場合翌年度のデータということにする
kari_m = pd.merge(master,menseki,how="left",on=["menseki_nendo","time_pm"])
kari_m[kari_m["all_menseki"].isnull()]       
master.loc[kari_m["all_menseki"].isnull(),"menseki_nendo"] = master.loc[kari_m["all_menseki"].isnull(),"menseki_nendo"]-2   #島根県斐川町の2011年の欠損のみ前年度のデータということにする   
kari_m = pd.merge(master,menseki,how="left",on=["menseki_nendo","time_pm"])
kari_m[kari_m["all_menseki"].isnull()] 
master = kari_m
master["sigaika_ratio_area"] = master["sigaika_area"]/master["all_menseki"]
master["industrial_ratio_area"] = (master["industrial"] + master["industrial_only"])/master["all_menseki"]
master["commerce_ratio_area"] = master["commerce"]/master["all_menseki"] 
master[master["time_pm"] == "北海道泊村"]

master.to_csv("master_datas/master_0520_1014_v1.csv")
#合併年と選挙年が同時の場合、調査のタイミング次第で変数がズレているかもしれない問題
#分析用切り出し
master = pd.read_csv("master_datas/master_0520_1011_v1.csv",index_col=0)
master.columns[:61]
master.columns[2372:]

first_half = master[master.columns[:61]]
second_half = master[master.columns[2373:]]
for_analy = pd.concat([first_half,second_half],axis=1)
for_analy.to_csv("master_datas/analysis_1012.csv")
