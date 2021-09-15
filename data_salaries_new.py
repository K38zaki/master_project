import pandas as pd
import numpy as np
import tabula

# H31用
def seirei_sitei_page(dfs,page_num):
    #1シート目
    s_id = page_num
    
    print(s_id)
    
    name_1 = list(dfs[s_id].iloc[5:,0][dfs[s_id].iloc[5:,1].isnull() == False].str.replace(" ",""))
                
    n_staff_all = [list(dfs[s_id].iloc[5:,1].dropna().str.replace(",","").str.split())[i][0] for i in range(dfs[s_id].iloc[5:,1].dropna().shape[0])]
                
    ave_age_staff_all = [list(dfs[s_id].iloc[5:,1].dropna().str.split())[i][1] for i in range(dfs[s_id].iloc[5:,1].dropna().shape[0])]
                
    salary_staff_all = [list(dfs[s_id].iloc[5:,2].dropna().str.replace(",","").str.split())[i][0] for i in range(dfs[s_id].iloc[5:,2].dropna().shape[0])]
                
    kimatsu_staff_all = [list(dfs[s_id].iloc[5:,5].dropna().str.replace(",","").str.split())[i][0] for i in range(dfs[s_id].iloc[5:,5].dropna().shape[0])]
                
    n_staff_gyosei = [list(dfs[s_id].iloc[5:,6].dropna().str.replace(",","").str.split())[i][0] for i in range(dfs[s_id].iloc[5:,6].dropna().shape[0])]
    
    ave_age_staff_gyosei = [list(dfs[s_id].iloc[5:,6].dropna().str.split())[i][1] for i in range(dfs[s_id].iloc[5:,6].dropna().shape[0])]
                
    salary_staff_gyosei = list(dfs[s_id].iloc[5:,7].dropna().str.replace(",",""))
    
    kimatsu_staff_gyosei = [list(dfs[s_id].iloc[5:,-1].dropna().str.replace(",","").str.split())[i][0] for i in range(dfs[s_id].iloc[5:,-1].dropna().shape[0])]
            
    fi_df = pd.DataFrame([name_1 ,n_staff_all,ave_age_staff_all,salary_staff_all,kimatsu_staff_all,n_staff_gyosei,ave_age_staff_gyosei,salary_staff_gyosei,kimatsu_staff_gyosei]).T
            
    fi_df.columns = ["name_1" ,"n_staff_all","ave_age_staff_all","salary_staff_all","kimatsu_staff_all","n_staff_gyosei","ave_age_staff_gyosei","salary_staff_gyosei","kimatsu_staff_gyosei"]
    
    # 2シート目
    this_df = dfs[s_id+1]
    
    name_2 = list(this_df.iloc[:,0].str.replace(" ",""))
    
    var_df = this_df.iloc[:,1:]
    
    var_df.insert(0,"name_2",name_2)
    var_df = var_df.reset_index(drop=True)
    
    var_df.columns = ["name_2","daisotsu","tandaisotsu","kousotsu","n_newcomer","n_retire","salary_mayor","salary_vice_mayor","salary_chair","salary_vice_chair","salary_assembly_member","salary_education","mayor_sala_apply_ymd","assembly_sala_apply_ymd","education_sala_apply_ymd"]
    
    var_df["ruiji_dantai"] = "政令指定都市"
    
    all_df = pd.concat([fi_df,var_df],axis=1)
    
    print(all(all_df["name_2"] == all_df["name_1"]))

    return all_df
    
    
#H31,R2
def process_page(dfs,start_p,end_p):
    
    df_l = []
    
    for s_id in range(start_p,end_p+1):
        
        if s_id % 2 == 0:
            print(dfs[s_id].iloc[5:,:].shape[1],s_id)
            
            if dfs[s_id].iloc[5:,:].shape[1] == 18:
                d = 0
            elif dfs[s_id].iloc[5:,:].shape[1] == 17:
                d = -1
            else:
                pass
            
            #　1ページ目
            name_1 = list(dfs[s_id].iloc[5:,0][dfs[s_id].iloc[5:,2+d].isnull() == False].str.replace(" ",""))
                
            n_staff_all = [list(dfs[s_id].iloc[5:,2+d].dropna().str.replace(",","").str.split())[i][0] for i in range(dfs[s_id].iloc[5:,2+d].dropna().shape[0])]
                
            ave_age_staff_all = [list(dfs[s_id].iloc[5:,2+d].dropna().str.split())[i][1] for i in range(dfs[s_id].iloc[5:,2+d].dropna().shape[0])]
                
            salary_staff_all = [list(dfs[s_id].iloc[5:,3+d].dropna().str.replace(",","").str.split())[i][0] for i in range(dfs[s_id].iloc[5:,3+d].dropna().shape[0])]
                
            kimatsu_staff_all = [list(dfs[s_id].iloc[5:,6+d].dropna().str.replace(",","").str.split())[i][0] for i in range(dfs[s_id].iloc[5:,6+d].dropna().shape[0])]
                
            n_staff_gyosei = [list(dfs[s_id].iloc[5:,7+d].dropna().str.replace(",","").str.split())[i][0] for i in range(dfs[s_id].iloc[5:,7+d].dropna().shape[0])]
                
            ave_age_staff_gyosei = [list(dfs[s_id].iloc[5:,7+d].dropna().str.split())[i][1] for i in range(dfs[s_id].iloc[5:,7+d].dropna().shape[0])]
                
            salary_staff_gyosei = [list(dfs[s_id].iloc[5:,9+d].dropna().str.replace(",","").str.split())[i][0] for i in range(dfs[s_id].iloc[5:,9+d].dropna().shape[0])]

            kimatsu_staff_gyosei = [list(dfs[s_id].iloc[5:,-1].dropna().str.replace(",","").str.split())[i][0] for i in range(dfs[s_id].iloc[5:,-1].dropna().shape[0])]
            
            fi_df = pd.DataFrame([name_1 ,n_staff_all,ave_age_staff_all,salary_staff_all,kimatsu_staff_all,n_staff_gyosei,ave_age_staff_gyosei,salary_staff_gyosei,kimatsu_staff_gyosei]).T
            
            fi_df.columns = ["name_1" ,"n_staff_all","ave_age_staff_all","salary_staff_all","kimatsu_staff_all","n_staff_gyosei","ave_age_staff_gyosei","salary_staff_gyosei","kimatsu_staff_gyosei"]
            
            # 2ページ目
            #自治体名
            if dfs[s_id+1].shape[1] == 18:
                #列数18
                this_df = dfs[s_id+1][dfs[s_id+1].iloc[:,3].isnull() == False]
                name_2 = [(str(this_df.iloc[i,0])+str(this_df.iloc[i,1])).replace("nan","").replace(" ","") for i in range(this_df.shape[0])]
                var_df = this_df.iloc[:,3:]
                
            else:
                #列数16
                this_df = dfs[s_id+1][dfs[s_id+1].iloc[:,1].isnull() == False]
                name_2 = list(this_df.iloc[:,0].str.replace(" ",""))
                var_df = this_df.iloc[:,1:]
                
            var_df.insert(0,"name_2",name_2)
            var_df = var_df.reset_index(drop=True)
            var_df.columns = ["name_2","daisotsu","tandaisotsu","kousotsu","n_newcomer","n_retire","salary_mayor","salary_vice_mayor","salary_chair","salary_vice_chair","salary_assembly_member","salary_education","mayor_sala_apply_ymd","assembly_sala_apply_ymd","education_sala_apply_ymd","ruiji_dantai"]
            
            all_df = pd.concat([fi_df,var_df],axis=1)
            print(all(all_df["name_2"] == all_df["name_1"]))
                  
            df_l.append(all_df)
                  
        else:
            pass
    
    return df_l


def compose_data_for_one_year(file_name,seirei_num,start_p,end_p):
    dfs = tabula.read_pdf(file_name, stream=True, pages = '2-65',multiple_tables=True)
    df_seirei = seirei_sitei_page(dfs,seirei_num)
    df_l = process_page(dfs,start_p,end_p)
    c_df = pd.concat([df_seirei]+df_l,axis=0)
    c_df = c_df.reset_index(drop=True)
    return c_df

# 実行
c_df = compose_data_for_one_year("salaries_pdfs/h31_kyuyo_1_05.pdf",2,4,63)
c_df.to_csv("19_salaries.csv")

# 都道府県名を追加したい
n_city = pd.read_csv("citycount.csv",encoding="cp932")
n_city = n_city.reset_index() 
n_city.columns = n_city.iloc[2,:]
n_city = n_city.iloc[3:,]
n_city["政令以外"] = n_city["市町村計"].astype("int") + n_city["特別区"].astype("int") - n_city.iloc[:,1].astype("int") 
n_city = n_city.reset_index()
n_city = n_city.drop("index",axis=1)
n_city["pref_name"] = [list(n_city["都道府県名"].str.split())[i][1] for i in range(n_city.shape[0])]
n_city.loc[0,"政令以外"] = n_city.loc[0,"政令以外"] - 6 #北方四島の6村を除外
b_city_l = list(n_city["政令以外"])　#政令以外の市町村数リスト
b_city_l = [20] + b_city_l #先頭に政令市町村数を追加

#都道府県の番号と都道府県名を各都道府県の市町村数だけリストにappend
prefs_l = []
prefs_id_l = []
for i in range(1,len(b_city_l)):
    prefs_id_l = prefs_id_l + [i]*b_city_l[i]
    prefs_l = prefs_l + [n_city.loc[i-1,"pref_name"]]*b_city_l[i]

n_city_r = pd.concat([n_city["pref_name"],n_city.iloc[:,1:-1].astype("int")],axis=1)
n_city_r.columns = ["都道府県名","政令市","市","特別区","区","支庁・振興局等","郡","町","村","市町村計","政令以外"]
n_city_r["都道府県番号"] = list(n_city_r.index+1)
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

#都道府県情報の列追加
len(pref_ids)
len(prefs)
c_df.insert(1,"prefecture",prefs)
c_df.insert(2,"pref_id",pref_ids)

#年情報の列追加
c_df.insert(3,"data_ymd","20190401")
c_df.insert(3,"data_year",2019)
c_df.to_csv("19_salaries.csv")

#都道府県情報の列のみをcsvとして保存(再利用のため)
#北海道;北方四島の市町村(6村)を除外
n_city_r.loc[0,"村"] = n_city_r.loc[0,"村"] - 6
n_city_r.loc[0,"市町村計"] = n_city_r.loc[0,"市町村計"] - 6
#東京都;特別区を“市町村計”に加える
n_city_r.loc[12,"市町村計"] = n_city_r.loc[12,"市町村計"] + n_city_r.loc[12,"特別区"]
n_city_r.to_csv("n_manucipality_list.csv")

#今回使った政令指定都市が最初に来る場合の市町村別の都道府県名リスト
seirei_first = pd.DataFrame([prefs,pref_ids]).T
seirei_first.columns = ["都道府県名","都道府県番号"]
seirei_first.to_csv("prefs_seirei_first_from_20140405.csv")

#政令指定都市が他と同様に扱われる場合の市町村別の都道府県名リスト
o_l = []
o_id_l = []
for i in list(n_city_r.index):
    o_id_l = o_id_l + [n_city_r.loc[i,"都道府県番号"]]*n_city_r.loc[i,"市町村計"]
    o_l = o_l + [n_city_r.loc[i,"都道府県名"]]*n_city_r.loc[i,"市町村計"]
    
len(o_id_l)
ordinary = pd.DataFrame([o_l,o_id_l]).T
ordinary.columns = ["都道府県名","都道府県番号"]
ordinary.to_csv("prefs_ordinary_from_20140405.csv")

#R2用
def seirei_sitei_page_R2(dfs,page_num):
    #1シート目
    s_id = page_num
    
    print(s_id)
    
    name_1 = list(dfs[s_id].iloc[5:,0][dfs[s_id].iloc[5:,1].isnull() == False].str.replace(" ",""))
                
    n_staff_all = [list(dfs[s_id].iloc[5:,1].dropna().str.replace(",","").str.split())[i][0] for i in range(dfs[s_id].iloc[5:,1].dropna().shape[0])]
                
    ave_age_staff_all = [list(dfs[s_id].iloc[5:,1].dropna().str.split())[i][1] for i in range(dfs[s_id].iloc[5:,1].dropna().shape[0])]
                
    salary_staff_all = [list(dfs[s_id].iloc[5:,2].dropna().str.replace(",","").str.split())[i][0] for i in range(dfs[s_id].iloc[5:,2].dropna().shape[0])]
                
    kimatsu_staff_all = [list(dfs[s_id].iloc[5:,6].dropna().str.replace(",","").str.split())[i][0] for i in range(dfs[s_id].iloc[5:,6].dropna().shape[0])]
                
    n_staff_gyosei = [list(dfs[s_id].iloc[5:,7].dropna().str.replace(",","").str.split())[i][0] for i in range(dfs[s_id].iloc[5:,7].dropna().shape[0])]
    
    ave_age_staff_gyosei = [list(dfs[s_id].iloc[5:,7].dropna().str.split())[i][1] for i in range(dfs[s_id].iloc[5:,7].dropna().shape[0])]
                
    salary_staff_gyosei = list(dfs[s_id].iloc[5:,8].dropna().str.replace(",",""))
    
    kimatsu_staff_gyosei = [list(dfs[s_id].iloc[5:,-1].dropna().str.replace(",","").str.split())[i][1] for i in range(dfs[s_id].iloc[5:,-1].dropna().shape[0])]
            
    fi_df = pd.DataFrame([name_1 ,n_staff_all,ave_age_staff_all,salary_staff_all,kimatsu_staff_all,n_staff_gyosei,ave_age_staff_gyosei,salary_staff_gyosei,kimatsu_staff_gyosei]).T
            
    fi_df.columns = ["name_1" ,"n_staff_all","ave_age_staff_all","salary_staff_all","kimatsu_staff_all","n_staff_gyosei","ave_age_staff_gyosei","salary_staff_gyosei","kimatsu_staff_gyosei"]
    
    # 2シート目
    this_df = dfs[s_id+1]
    
    name_2 = list(this_df.iloc[:,0].str.replace(" ",""))
    
    var_df = this_df.iloc[:,1:]
    
    var_df.insert(0,"name_2",name_2)
    var_df = var_df.reset_index(drop=True)
    
    var_df.columns = ["name_2","daisotsu","tandaisotsu","kousotsu","n_newcomer","n_retire","salary_mayor","salary_vice_mayor","salary_chair","salary_vice_chair","salary_assembly_member","salary_education","mayor_sala_apply_ymd","assembly_sala_apply_ymd","education_sala_apply_ymd"]
    
    var_df["ruiji_dantai"] = "政令指定都市"
    
    all_df = pd.concat([fi_df,var_df],axis=1)
    
    print(all(all_df["name_2"] == all_df["name_1"]))

    return all_df

def compose_data_for_R2_year(file_name,seirei_num,start_p,end_p):
    dfs = tabula.read_pdf(file_name, stream=True, pages = '2-65',multiple_tables=True)
    df_seirei = seirei_sitei_page_R2(dfs,seirei_num)
    df_l = process_page(dfs,start_p,end_p)
    c_df = pd.concat([df_seirei]+df_l,axis=0)
    c_df = c_df.reset_index(drop=True)
    
    #都道府県情報の列追加
    pref = pd.read_csv("prefs_seirei_first_from_20140405.csv",index_col=0)
    c_df.insert(1,"prefecture",pref["都道府県名"])
    c_df.insert(2,"pref_id",pref["都道府県番号"])

    #年情報の列追加
    c_df.insert(3,"data_ymd","20200401")
    c_df.insert(3,"data_year",2020)
    c_df.to_csv("20_salaries.csv")
    
    return c_df

#R2 実行
c_df = compose_data_for_R2_year("salaries_pdfs/R2_kyuyo_1_05.pdf",2,4,63)
