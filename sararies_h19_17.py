import pandas as pd
import numpy as np
import tkinter
import camelot
import tabula

dfs = tabula.read_pdf('salaries_pdfs/h17_kyuuyo_1_05.pdf', stream=True, pages = '4-89',multiple_tables=True)
dfs[2].shape

#1シート目、政令指定都市以外
n_c = 0
for i in range(2,len(dfs)):
    if i % 2 == 0:
        print(i)
        the_df = dfs[i]
        the_df = the_df[the_df.iloc[:,-1].isnull() == False]
        print(the_df.shape)
        d = 29 - the_df.shape[1]
        print(the_df.iloc[0,0:3-d].fillna("").sum().replace(" ",""))
        print(the_df.iloc[0,[3-d,4-d,5-d,14-d,16-d,17-d,18-d,27-d]])
        n_c += the_df.shape[0]
        
#2シート目、政令指定都市以外
n_c = 0
for i in range(2,len(dfs)):
    if i % 2 == 1:
        print(i)
        the_df = dfs[i].iloc[8:]
        the_df = the_df[the_df.iloc[:,3].isnull() == False]
        print(the_df.shape)
        print("".join(the_df.iloc[0,0].split()[:-2]))
        p_2 = pd.concat([the_df.iloc[:,k].str.split(expand=True) for k in range(1,the_df.shape[1])],axis=1)
        print(p_2.shape[1])
        print(p_2.iloc[0])
        n_c += the_df.shape[0]
        #print(the_df.iloc[4:10])
n_c

["".join(the_df.iloc[k,0].split()[:-2]) for k in range(the_df.shape[0])]

dfs[3].iloc[8:]

the_df = dfs[35].iloc[8:]
the_df = the_df[the_df.iloc[:,-1].isnull() == False]
"".join(the_df.iloc[,0].split()[:-2])
p_2 = pd.concat([the_df.iloc[:,k].str.split(expand=True) for k in range(1,the_df.shape[1])],axis=1)
p_2.shape[1]
any(var_2.isnull())

#1シート目、政令指定都市

the_df = dfs[0]
name_1 = the_df.iloc[:,0:3].fillna("").sum(axis=1).str.replace(" ","")
var_1 = the_df.iloc[:,[3,4,5,14,16,17,18,27]]

#2シート目、政令指定都市

the_df = dfs[1]
dfs[1].iloc[4:10]
the_df = the_df.iloc[7:]
the_df = the_df[the_df != ""].T.dropna(how="all").T
name_2 = (the_df.iloc[:,0] + the_df.iloc[:,1]).str.replace(" ","")
var_2 = pd.concat([the_df.iloc[:,k].str.split(expand=True) for k in range(2,the_df.shape[1])],axis=1)

def make_pref_list(place,ymd):
    
    n_city = pd.read_csv(place,encoding="cp932")
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
    n_city_r.to_csv("n_manucipality_list_"+ymd+".csv")

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
    seirei_first.to_csv("prefs_seirei_first_from_"+ymd+".csv")
    
    return seirei_first


def process_page_H1918(dfs,first_page):
    
    df_l = []
    
    for i in range(first_page,len(dfs)):
        if i % 2 == 0:
            #1シート目
            the_df = dfs[i]
            the_df = the_df[the_df.iloc[:,-1].isnull() == False]
            d = 29 - the_df.shape[1]
            name_1 = the_df.iloc[:,0:3-d].fillna("").sum(axis=1).str.replace(" ","")
            var_1 = the_df.iloc[:,[3-d,4-d,5-d,14-d,16-d,17-d,18-d,27-d]]
            df_1 = pd.concat([name_1,var_1],axis=1)
            df_1.columns = ["name_1" ,"n_staff_all","ave_age_staff_all","salary_staff_all","kimatsu_staff_all","n_staff_gyosei","ave_age_staff_gyosei","salary_staff_gyosei","kimatsu_staff_gyosei"]
            df_1 = df_1.reset_index(drop=True)
            
            #2シート目
            the_df = dfs[i+1].iloc[8:]
            the_df = the_df[the_df.iloc[:,-1].isnull() == False]
            name_2 = ["".join(the_df.iloc[k,0].split()[:-2]) for k in range(the_df.shape[0])]
            daisotsu = [the_df.iloc[k,0].split()[-2] for k in range(the_df.shape[0])]
            tandaisotsu = [the_df.iloc[k,0].split()[-1] for k in range(the_df.shape[0])]
            p_2 = pd.concat([the_df.iloc[:,k].str.split(expand=True) for k in range(1,the_df.shape[1])],axis=1).reset_index(drop=True)
            if p_2.shape[1] == 15: 
                p_2 = pd.DataFrame([[np.nan]*14]*the_df.shape[0])
                print("Error:",str(i),"Inconsitent: the page of ",name_2[0])
            else:
                pass
            p_1 = pd.DataFrame([name_2,daisotsu,tandaisotsu]).T
            df_2 = pd.concat([p_1,p_2],axis=1)
            df_2.columns = ["name_2","daisotsu","tandaisotsu","kousotsu","n_newcomer","n_retire","salary_mayor","salary_vice_mayor","syu","salary_chair","salary_vice_chair","salary_assembly_member","salary_education","mayor_sala_apply_ymd","assembly_sala_apply_ymd","education_sala_apply_ymd","ruiji_dantai"]
            df_2 = df_2.drop(columns="syu")
            
            print(str(i),"length:",df_1.shape[0] == df_2.shape[0],"names",all(df_1["name_1"] == df_2["name_2"]))
            all_df = pd.concat([df_1,df_2],axis=1)
            
            df_l.append(all_df)
            
    return df_l
            

def seirei_page_H191817(dfs,page_num=0):
    
    #1シート目
    the_df = dfs[page_num]
    name_1 = the_df.iloc[:,0:3].fillna("").sum(axis=1).str.replace(" ","")
    var_1 = the_df.iloc[:,[3,4,5,14,16,17,18,27]]
    df_1 = pd.concat([name_1,var_1],axis=1)
    df_1.columns = ["name_1" ,"n_staff_all","ave_age_staff_all","salary_staff_all","kimatsu_staff_all","n_staff_gyosei","ave_age_staff_gyosei","salary_staff_gyosei","kimatsu_staff_gyosei"]
    df_1 = df_1.reset_index(drop=True)
    
    #2シート目
    the_df = dfs[page_num+1]
    the_df = the_df.iloc[7:]
    the_df = the_df[the_df != ""].T.dropna(how="all").T
    name_2 = (the_df.iloc[:,0] + the_df.iloc[:,1]).str.replace(" ","")
    var_2 = pd.concat([the_df.iloc[:,k].str.split(expand=True) for k in range(2,the_df.shape[1])],axis=1)
    df_2 = pd.concat([name_2,var_2],axis=1)
    df_2.columns = ["name_2","daisotsu","tandaisotsu","kousotsu","n_newcomer","n_retire","salary_mayor","salary_vice_mayor","syu","salary_chair","salary_vice_chair","salary_assembly_member","salary_education","mayor_sala_apply_ymd","assembly_sala_apply_ymd","education_sala_apply_ymd"]
    df_2 = df_2.drop(columns="syu")
    df_2 = df_2.reset_index(drop=True)
    
    #結合など
    print(str(page_num),"length:",df_1.shape[0] == df_2.shape[0],"names",all(df_1["name_1"] == df_2["name_2"]))
    all_df = pd.concat([df_1,df_2],axis=1)
    
    pref_df = all_df.iloc[:47,:]
    seirei_df = all_df.iloc[47:,:]
    
    pref_df["ruiji_dantai"] = "都道府県"
    seirei_df["ruiji_dantai"] = "政令指定都市"
    
    return pref_df, seirei_df
    
def compose_data_for_H191817(dfs,seirei_num=0,start_p=2):
    df_pref, df_seirei = seirei_page_H191817(dfs,seirei_num)
    df_l = process_page_H17(dfs,start_p)
    c_df = pd.concat([df_seirei]+df_l,axis=0)
    
    c_df = c_df.reset_index(drop=True)
    df_pref = df_pref.reset_index(drop=True)
    
    for c in list(c_df.columns):
        c_df[c] = c_df[c].str.replace(",","")
        df_pref[c] = df_pref[c].str.replace(",","")
    
    #都道府県情報の列追加
    pref = make_pref_list("n_cities/citycount_20050401.csv","20050401")
    pref = pref.reset_index(drop=True)
    c_df.insert(1,"prefecture",pref["都道府県名"])
    c_df.insert(2,"pref_id",pref["都道府県番号"])
    
    df_pref.insert(1,"prefecture",pref["都道府県名"].iloc[21:].unique())
    df_pref.insert(2,"pref_id",df_pref.index+1)

    #年情報の列追加
    c_df.insert(3,"data_ymd","20050401")
    c_df.insert(3,"data_year",2005)
    
    df_pref.insert(3,"data_ymd","20050401")
    df_pref.insert(3,"data_year",2005)
    
    c_df.to_csv("05_salaries.csv")
    df_pref.to_csv("05_pref_salaries.csv")
    
    return c_df

def process_page_H17(dfs,first_page):
    
    df_l = []
    
    for i in range(first_page,len(dfs)):
        if i % 2 == 0:
            #1シート目
            the_df = dfs[i]
            the_df = the_df[the_df.iloc[:,-1].isnull() == False]
            d = 29 - the_df.shape[1]
            name_1 = the_df.iloc[:,0:3-d].fillna("").sum(axis=1).str.replace(" ","")
            var_1 = the_df.iloc[:,[3-d,4-d,5-d,14-d,16-d,17-d,18-d,27-d]]
            df_1 = pd.concat([name_1,var_1],axis=1)
            df_1.columns = ["name_1" ,"n_staff_all","ave_age_staff_all","salary_staff_all","kimatsu_staff_all","n_staff_gyosei","ave_age_staff_gyosei","salary_staff_gyosei","kimatsu_staff_gyosei"]
            df_1 = df_1.reset_index(drop=True)
            
            #2シート目
            the_df = dfs[i+1].iloc[8:]
            the_df = the_df[the_df.iloc[:,3].isnull() == False]
            name_2 = ["".join(the_df.iloc[k,0].split()[:-2]) for k in range(the_df.shape[0])]
            daisotsu = [the_df.iloc[k,0].split()[-2] for k in range(the_df.shape[0])]
            tandaisotsu = [the_df.iloc[k,0].split()[-1] for k in range(the_df.shape[0])]
            p_2 = pd.concat([the_df.iloc[:,k].str.split(expand=True) for k in range(1,the_df.shape[1])],axis=1).reset_index(drop=True)
            if p_2.shape[1] != 14: 
                p_2 = pd.DataFrame([[np.nan]*14]*the_df.shape[0])
                print("Error:",i,p_2.shape[1],"Inconsitent: the page of ",name_2[0],)
            else:
                pass
            p_1 = pd.DataFrame([name_2,daisotsu,tandaisotsu]).T
            df_2 = pd.concat([p_1,p_2],axis=1)
            df_2.columns = ["name_2","daisotsu","tandaisotsu","kousotsu","n_newcomer","n_retire","salary_mayor","salary_vice_mayor","syu","salary_chair","salary_vice_chair","salary_assembly_member","salary_education","mayor_sala_apply_ymd","assembly_sala_apply_ymd","education_sala_apply_ymd","ruiji_dantai"]
            df_2 = df_2.drop(columns="syu")
            
            print(str(i),"length:",df_1.shape[0] == df_2.shape[0],"names",all(df_1["name_1"] == df_2["name_2"]))
            all_df = pd.concat([df_1,df_2],axis=1)
            
            df_l.append(all_df)
            
    return df_l
        
c_df = compose_data_for_H191817(dfs,seirei_num=0,start_p=2)

#H17 修正
#さいたま市 name_2
c_df.loc[2,"name_2"] = c_df.loc[2,"name_1"]
c_df.loc[2,"name_2"]
#p35（野沢温泉村から） 修正
c_df[c_df["name_1"] == "野沢温泉村"]
the_df = dfs[35].iloc[8:]
the_df = the_df[the_df.iloc[:,-1].isnull() == False]
n_t = the_df.shape[0]
c_df.loc[943:943+n_t-1,:]
c_df.loc[943:943+n_t-1,"kousotsu":] #修正対象

p_2 = pd.concat([the_df.iloc[:,k].str.split(expand=True) for k in range(1,the_df.shape[1])],axis=1)
p_2.columns = list(range(p_2.shape[1]))
p_2
news = p_2.loc[38,[10,11,12]]
p_2.loc[38,9] = news.iloc[0]
p_2.loc[38,10] = news.iloc[1]
p_2.loc[38,11] = news.iloc[2]
p_2 = p_2.drop(columns=12)
p_2 = p_2.drop(columns=5)
p_2.columns = c_df.columns[-13:]

c_df.loc[943:943+n_t-1,"kousotsu":] = p_2.values
c_df.loc[943:943+n_t-1,:]
c_df.to_csv("07_salaries.csv")

#H18 修正
#さいたま市 name_2
c_df.loc[2,"name_2"] = c_df.loc[2,"name_1"]
c_df.loc[2,"name_2"]
#p35（長野県池田町から） 修正
c_df[c_df["name_1"] == "池田町"]
the_df = dfs[35].iloc[8:]
the_df = the_df[the_df.iloc[:,-1].isnull() == False]
n_t = the_df.shape[0]
c_df.loc[941:941+n_t-1,:]
c_df.loc[941:941+n_t-1,"kousotsu":] #修正対象

p_2 = pd.concat([the_df.iloc[:,k].str.split(expand=True) for k in range(1,the_df.shape[1])],axis=1)
p_2.columns = list(range(p_2.shape[1]))
p_2
news = p_2.loc[47,[10,11,12]]
p_2.loc[47,9] = news.iloc[0]
p_2.loc[47,10] = news.iloc[1]
p_2.loc[47,11] = news.iloc[2]
p_2 = p_2.drop(columns=12)
p_2 = p_2.drop(columns=5)
p_2.columns = c_df.columns[-13:]

c_df.loc[941:941+n_t-1,"kousotsu":] = p_2.values
c_df.loc[941:941+n_t-1,:]
c_df.to_csv("06_salaries.csv")

#H17 修正
#さいたま市 name_2
c_df.loc[2,"name_2"] = c_df.loc[2,"name_1"]
c_df.loc[2,"name_2"]

#p44（美濃加茂市から） 修正
c_df[c_df["name_1"] == "美濃加茂市"]
the_df = dfs[45].iloc[8:]
the_df = the_df[the_df.iloc[:,3].isnull() == False]
n_t = the_df.shape[0]
c_df.loc[1231:1231+n_t-1,:]
c_df.loc[1231:1231+n_t-1,"kousotsu":] #修正対象

p_2 = pd.concat([the_df.iloc[:,k].str.split(expand=True) for k in range(1,the_df.shape[1])],axis=1)
p_2.columns = list(range(p_2.shape[1]))
p_2
news_1 = p_2.loc[20,[10,11,12]]
news_2 = p_2.loc[21,[10,11,12]]
p_2.loc[20,[9,10,11]] = news_1.values
p_2.loc[21,[9,10,11]] = news_2.values
p_2 = p_2.drop(columns=12)
p_2 = p_2.drop(columns=5)
p_2.columns = c_df.columns[-13:]

c_df.loc[1231:1231+n_t-1,"kousotsu":] = p_2.values
c_df.loc[1231:1231+n_t-1,:]

#p57（養父市から） 修正

c_df[c_df["name_1"] == "養父市"]
the_df = dfs[57].iloc[8:]
the_df = the_df[the_df.iloc[:,3].isnull() == False]
n_t = the_df.shape[0]
c_df.loc[1577:1577+n_t-1,:]
c_df.loc[1577:1577+n_t-1,"kousotsu":] #修正対象

p_2 = pd.concat([the_df.iloc[:,k].str.split(expand=True) for k in range(1,the_df.shape[1])],axis=1)
p_2.columns = list(range(p_2.shape[1]))
p_2
news_1 = p_2.loc[[17,18],[10,11,12]]
news_2 = p_2.loc[[38,39,40],[10,11,12]]
p_2.loc[[17,18],[9,10,11]] = news_1.values
p_2.loc[[38,39,40],[9,10,11]] = news_2.values
p_2 = p_2.drop(columns=12)
p_2 = p_2.drop(columns=5)
p_2.columns = c_df.columns[-13:]

c_df.loc[1577:1577+n_t-1,"kousotsu":] = p_2.values
c_df.loc[1577:1577+n_t-1,:]

#p63（海士町から） 修正

c_df[c_df["name_1"] == "海士町"]
the_df = dfs[63].iloc[8:]
the_df = the_df[the_df.iloc[:,3].isnull() == False]
n_t = the_df.shape[0]
c_df.loc[1751:1751+n_t-1,:]
c_df.loc[1751:1751+n_t-1,"kousotsu":] #修正対象

p_2 = pd.concat([the_df.iloc[:,k].str.split(expand=True) for k in range(1,the_df.shape[1])],axis=1)
p_2.columns = list(range(p_2.shape[1]))
p_2
news_1 = p_2.loc[29,[10,11,12]]
p_2.loc[29,[9,10,11]] = news_1.values
p_2 = p_2.drop(columns=12)
p_2 = p_2.drop(columns=5)
p_2.columns = c_df.columns[-13:]

c_df.loc[1751:1751+n_t-1,"kousotsu":] = p_2.values
c_df.loc[1751:1751+n_t-1,:]

#類似団体の欠損値　→　特別区
c_df[c_df.ruiji_dantai.isnull() == True]
c_df.loc[862:884,"ruiji_dantai"] = "特別区"

c_df.isnull().sum()
c_df.to_csv("05_salaries.csv")

# tables = camelot.read_pdf('salaries_pdfs/h19_kyuuyo_1_05.pdf',pages="2-67",flavor='stream')
# len(tables)
# dfs = [tables[i].df for i in range(len(tables))]
# len(dfs)

# #政令指定都市以外、1シート目
# n_c = 0
# for i in range(2,len(dfs)):
#     if i % 2 == 0:
#         print(i)
#         the_df = dfs[i][(dfs[i].iloc[:,0:3] != "").sum(axis=1) != 0]
#         the_df = the_df[the_df != ""].T.dropna(how="all").T
#         the_df = the_df[the_df.iloc[:,3].isnull() == False]
#         print(the_df.shape)
#         the_df.columns = list(range(len(the_df.columns)))
#         print(the_df.iloc[0,0:3][the_df.iloc[0,0:3].isnull() == False].sum().replace(" ",""))
#         print(the_df.iloc[0,[3,4,5,14,16,17,18,27]])
#         n_c += the_df.shape[0]
# n_c

# #最終ページ
# i = -2
# the_df = dfs[i]
# the_df = dfs[i].iloc[5:,:]
# the_df = the_df[the_df != ""].T.dropna(how="all").T
# the_df = the_df[the_df.iloc[:,3].isnull() == False]
# the_df.shape

# name_1 = the_df.iloc[:,0:2].sum(axis=1).str.replace(" ","").str.replace("\n","").str.replace("(cid:7765)","那").str.replace("(cid:12168)","").str.replace("67","").str.replace("(","").str.replace(")","").str.replace("\n","")
# var_1 = the_df.iloc[:,[2,3,4,13,15,16,17,26]]
# name_1.shape
# var_1.shape

# #2シート目
# n_c = 0
# for i in range(2,len(dfs)):
#     if i % 2 == 1:
       
#         the_df = dfs[i][(dfs[i].iloc[:,0:2] != "").sum(axis=1) != 0]
#         the_df = the_df[the_df != ""].T.dropna(how="all").T
#         the_df = the_df[the_df.iloc[:,3].isnull() == False]
#         print(dfs[i].iloc[0:3])
#         print(the_df.shape[1])
#         n_c += the_df.shape[0]
# n_c

# i=7
# the_df = dfs[i][(dfs[i].iloc[:,0:2] != "").sum(axis=1) != 0]
# the_df = the_df[the_df != ""].T.dropna(how="all").T
# the_df = the_df[the_df.iloc[:,3].isnull() == False]
# the_df


