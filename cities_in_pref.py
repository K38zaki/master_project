import pandas as pd

# 都道府県名を追加したい
n_city = pd.read_csv("n_cities/citycount.csv",encoding="cp932")
n_city = n_city.reset_index() 
n_city.columns = n_city.iloc[2,:]
n_city = n_city.iloc[3:,]
n_city["政令以外"] = n_city["市町村計"].astype("int") + n_city["特別区"].astype("int") - n_city.iloc[:,1].astype("int") 
n_city = n_city.reset_index()
n_city = n_city.drop("index",axis=1)
n_city["pref_name"] = [list(n_city["都道府県名"].str.split())[i][1] for i in range(n_city.shape[0])]
n_city.loc[0,"政令以外"] = n_city.loc[0,"政令以外"] - 6 #北方四島の6村を除外

n_city_r = pd.concat([n_city["pref_name"],n_city.iloc[:,1:-1].astype("int")],axis=1)
n_city_r.columns = ["都道府県名","政令市","市","特別区","区","支庁・振興局等","郡","町","村","市町村計","政令以外"]
n_city_r["都道府県番号"] = list(n_city_r.index+1)

#都道府県情報の列のみをcsvとして保存(再利用のため)
#北海道;北方四島の市町村(6村)を除外
n_city_r.loc[0,"村"] = n_city_r.loc[0,"村"] - 6
n_city_r.loc[0,"市町村計"] = n_city_r.loc[0,"市町村計"] - 6
#東京都;特別区を“市町村計”に加える
n_city_r.loc[12,"市町村計"] = n_city_r.loc[12,"市町村計"] + n_city_r.loc[12,"特別区"]
n_city_r.to_csv("n_manucipality_list.csv")

b_city_l = list(n_city["政令以外"]) #政令以外の市町村数リスト
b_city_l = [20] + b_city_l #先頭に政令市町村数を追加

#都道府県の番号と都道府県名を各都道府県の市町村数だけリストにappend
prefs_l = []
prefs_id_l = []
for i in range(1,len(b_city_l)):
    prefs_id_l = prefs_id_l + [i]*b_city_l[i]
    prefs_l = prefs_l + [n_city.loc[i-1,"pref_name"]]*b_city_l[i]


seirei_pref = n_city_r[n_city_r["政令市"] != 0]
seirei_pref

#都道府県の番号と都道府県名を各都道府県の政令市数だけリストにappend
seirei_l = []
seirei_id_l = []
for i in list(seirei_pref.index):
    seirei_id_l = seirei_id_l + [seirei_pref.loc[i,"都道府県番号"]]*seirei_pref.loc[i,"政令市"]
    seirei_l = seirei_l + [seirei_pref.loc[i,"都道府県名"]]*seirei_pref.loc[i,"政令市"]

pref_ids = seirei_id_l + prefs_id_l
prefs = seirei_l + prefs_l


#今回使った政令指定都市が最初に来る場合の市町村別の都道府県名リスト
seirei_first = pd.DataFrame([prefs,pref_ids]).T
seirei_first.columns = ["都道府県名","都道府県番号"]
seirei_first.to_csv("prefs_seirei_first_from_20140405.csv")


#pref_from201204
prefs = pd.read_csv("prefs_seirei_first_from_20140405.csv",index_col=0)
prefs[prefs["都道府県名"] == "栃木県"].index
prefs[prefs["都道府県名"] == "栃木県"].shape
pref_T = prefs.T
pref_T.insert(468,4675,["栃木県",9])
pref_new = pref_T.T
pref_new[pref_new["都道府県名"] == "栃木県"]
pref_new.to_csv("prefs_seirei_first_from_20120401.csv")


#2011年4月1日用
#2010年4月1日用
#2009年4月1日用
#2008年4月1日用

n_city = pd.read_csv("n_cities/citycount_20080401.csv",encoding="cp932")
n_city = n_city.reset_index() 
n_city.columns = n_city.iloc[2,:]
n_city = n_city.iloc[3:,]
n_city["政令以外"] = n_city["市町村計"].astype("int") + n_city["特別区"].astype("int") - n_city.iloc[:,1].astype("int") 
n_city = n_city.reset_index()
n_city = n_city.drop("index",axis=1)
n_city["pref_name"] = [list(n_city["都道府県名"].str.split())[i][1] for i in range(n_city.shape[0])]
n_city.loc[0,"政令以外"] = n_city.loc[0,"政令以外"] - 6 #北方四島の6村を除外

n_city_r = pd.concat([n_city["pref_name"],n_city.iloc[:,1:-1].astype("int")],axis=1)
n_city_r.columns = ["都道府県名","政令市","市","特別区","区","支庁・振興局等","郡","町","村","市町村計","政令以外"]
n_city_r["都道府県番号"] = list(n_city_r.index+1)

#都道府県情報の列のみをcsvとして保存(再利用のため)
#北海道;北方四島の市町村(6村)を除外
n_city_r.loc[0,"村"] = n_city_r.loc[0,"村"] - 6
n_city_r.loc[0,"市町村計"] = n_city_r.loc[0,"市町村計"] - 6
#東京都;特別区を“市町村計”に加える
n_city_r.loc[12,"市町村計"] = n_city_r.loc[12,"市町村計"] + n_city_r.loc[12,"特別区"]
n_city_r.to_csv("n_manucipality_list_20080401.csv")

#都道府県の番号と都道府県名を各都道府県の市町村数だけリストにappend
prefs_l = []
prefs_id_l = []

for i in list(n_city_r.index):
    prefs_id_l = prefs_id_l + [n_city_r.loc[i,"都道府県番号"]]*n_city_r.loc[i,"政令以外"]
    prefs_l = prefs_l + [n_city_r.loc[i,"都道府県名"]]*n_city_r.loc[i,"政令以外"]


seirei_pref = n_city_r[n_city_r["政令市"] != 0]
seirei_pref

#都道府県の番号と都道府県名を各都道府県の政令市数だけリストにappend
seirei_l = []
seirei_id_l = []
for i in list(seirei_pref.index):
    seirei_id_l = seirei_id_l + [seirei_pref.loc[i,"都道府県番号"]]*seirei_pref.loc[i,"政令市"]
    seirei_l = seirei_l + [seirei_pref.loc[i,"都道府県名"]]*seirei_pref.loc[i,"政令市"]

pref_ids = seirei_id_l + prefs_id_l
prefs = seirei_l + prefs_l


#今回使った政令指定都市が最初に来る場合の市町村別の都道府県名リスト
seirei_first = pd.DataFrame([prefs,pref_ids]).T
seirei_first.columns = ["都道府県名","都道府県番号"]
seirei_first.to_csv("prefs_seirei_first_from_20080401.csv")
len(seirei_first)
