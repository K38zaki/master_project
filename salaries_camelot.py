import pandas as pd
import numpy as np
import tkinter
import camelot

tables = camelot.read_pdf('salaries_pdfs/h20_kyuuyo_1_08.pdf',pages="2-67",flavor='stream')
#tables_2 = camelot.read_pdf('salaries_pdfs/h28_kyuyo_1_05.pdf',pages="7-66",flavor='stream')

len(tables)
tables[62].df

for i in range(len(tables)):
    if i % 2 == 0:
        print(i)
        the_df = tables[i].df.iloc[4:,:]
        print(the_df[the_df != ""].T.dropna(how="all").shape[0])

for i in range(len(tables)):
        print(i)
        print(tables[i].df.iloc[-3,:])
        
tables[54].df
tables[55].df

tables[54].df.shape
tables[55].df.shape

the_df = tables[6].df.iloc[4:,:]
the_df[the_df != ""].T.dropna(how="all").T


dfs = [tables[i].df for i in range(len(tables)) if i != 55]
dfs = [tables[i].df for i in range(len(tables))]
len(dfs)

#1ページ目
n_c = 0
for i in range(2,len(dfs)):
    if i % 2 == 0:
        print(i)
        the_df = dfs[i][(dfs[i].iloc[:,0:3] != "").sum(axis=1) != 0]
        the_df = the_df[the_df != ""].T.dropna(how="all").T
        the_df = the_df[the_df.iloc[:,3].isnull() == False]
        print(the_df.shape)
        the_df.columns = list(range(len(the_df.columns)))
        print(the_df.iloc[0,0:3][the_df.iloc[0,0:3].isnull() == False].sum().replace(" ",""))
        print(the_df.iloc[0,[3,4,5,14,16,17,18,27]])
        n_c += the_df.shape[0]
n_c

## →　ok(政令指定都市も県も)

dfs[0][(dfs[0].iloc[:,0:3] != "").sum(axis=1) != 0]

i = -2
the_df = dfs[i][(dfs[i].iloc[:,0:3] != "").sum(axis=1) != 0]
the_df = the_df[the_df != ""].T.dropna(how="all").T
the_df = the_df[the_df.iloc[:,3].isnull() == False]
the_df.shape

the_df.columns = list(range(len(the_df.columns)))
name_1 = the_df.iloc[:,0:3].fillna("").sum(axis=1).str.replace(" ","")
var_1 = the_df.iloc[:,[3,4,5,14,16,17,18,27]]

name_1 = the_df.iloc[:,0:4].fillna("").sum(axis=1).str.replace(" ","")
var_1 = the_df.iloc[:,[4,5,6,15,17,18,19,28]]

name_1 = the_df.iloc[:,0].str.replace(" ","").str.replace("\n","")
var_1 = the_df.iloc[:,[1,2,3,12,14,15,16,25]]

the_df.iloc[:,4].str.replace(",","")


#2ページ目
dfs[3]

n_c = 0
for i in range(2,len(dfs)):
    if i % 2 == 1:
        print(i)
        the_df = dfs[i][(dfs[i].iloc[:,0:2] != "").sum(axis=1) != 0]
        the_df = the_df[the_df != ""].T.dropna(how="all").T
        the_df = the_df[the_df.iloc[:,3].isnull() == False]
        print(the_df.shape[1])
        n_c += the_df.shape[0]
n_c
## →　ok(政令指定都市以外)

i = -5
the_df = dfs[i][(dfs[i].iloc[:,0:3] != "").sum(axis=1) != 0]
the_df = the_df[the_df != ""].T.dropna(how="all").T
the_df = the_df[the_df.iloc[:,3].isnull() == False]
the_df.shape

i = -1
the_df = dfs[i].iloc[3:]
the_df = the_df[the_df != ""].T.dropna(how="all").T
the_df.shape

#政令指定都市/県 
#1シート目
the_df = dfs[0]
the_df = the_df[(the_df.iloc[:,0:3] != "").sum(axis=1) != 0]
the_df = the_df[the_df != ""].T.dropna(how="all").T
the_df = the_df[the_df.iloc[:,4].isnull() == False]
name_1 = the_df.iloc[:,0:2].fillna("").sum(axis=1).str.replace(" ","").str.replace("\n","")
#(the_df.iloc[:,0] + the_df.iloc[:,1]).str.replace("\n","")
the_df.iloc[:,[2,3,4,13,15,16,17,26]]

#2シート目
the_df = dfs[1]
the_df = the_df[(the_df.iloc[:,0:2] != "").sum(axis=1) != 0]
the_df = the_df[the_df != ""].T.dropna(how="all").T
the_df = the_df[the_df.iloc[:,3].isnull() == False]
name_2 = the_df.iloc[:,0:2].fillna("").sum(axis=1).str.replace(" ","").str.replace("\n","")
the_df.iloc[:,3:].shape

i = 1
the_df = dfs[i].iloc[4:]
the_df = the_df[(the_df.iloc[:,0:2] != "").sum(axis=1) != 0]
the_df = the_df[the_df != ""].T.dropna(how="all").T
the_df = the_df[the_df.iloc[:,3].isnull() == False]
the_df.columns = list(range(len(the_df.columns)))
name_2 = the_df.iloc[:,0:3].fillna("").sum(axis=1).str.replace(" ","").str.replace("\n","")
var_2 = the_df.iloc[:,3:]


#name_2 = (the_df.iloc[:,0] + the_df.iloc[:,1]).str.replace("\n","")
name_2.iloc[47:] += "市"
the_df.iloc[:,2:]

the_df = dfs[i][(dfs[i].iloc[:,0:2] != "").sum(axis=1) != 0]
the_df = the_df[the_df != ""].T.dropna(how="all").T
the_df = the_df[the_df.iloc[:,3].isnull() == False]
the_df.columns = list(range(len(the_df.columns)))
name_2 = the_df.iloc[:,0:3].fillna("").sum(axis=1).str.replace(" ","").str.replace("\n","")
var_2 = the_df.iloc[:,3:]
df_2 = pd.concat([name_2,var_2],axis=1)

#H30,H29,H28,H27,H26
def process_page(dfs,start_num,end_num):
    df_l = []
    for i in range(start_num,end_num):
        if i % 2 == 0:
            #1シート目
            the_df = dfs[i][(dfs[i].iloc[:,0:3] != "").sum(axis=1) != 0]
            the_df = the_df[the_df != ""].T.dropna(how="all").T
            the_df = the_df[the_df.iloc[:,3].isnull() == False]
            the_df.columns = list(range(len(the_df.columns)))
            name_1 = the_df.iloc[:,0:3].fillna("").sum(axis=1).str.replace(" ","").str.replace("\n","")
            var_1 = the_df.iloc[:,[3,4,5,14,16,17,18,27]]
            df_1 = pd.concat([name_1,var_1],axis=1)
            df_1.columns = ["name_1" ,"n_staff_all","ave_age_staff_all","salary_staff_all","kimatsu_staff_all","n_staff_gyosei","ave_age_staff_gyosei","salary_staff_gyosei","kimatsu_staff_gyosei"]
            df_1 = df_1.reset_index(drop=True)
            
            #2シート目
            i += 1
            the_df = dfs[i][(dfs[i].iloc[:,0:2] != "").sum(axis=1) != 0]
            the_df = the_df[the_df != ""].T.dropna(how="all").T
            the_df = the_df[the_df.iloc[:,3].isnull() == False]
            the_df.columns = list(range(len(the_df.columns)))
            name_2 = the_df.iloc[:,0:3].fillna("").sum(axis=1).str.replace(" ","").str.replace("\n","")
            var_2 = the_df.iloc[:,3:]
            df_2 = pd.concat([name_2,var_2],axis=1)
            df_2.columns = ["name_2","daisotsu","tandaisotsu","kousotsu","n_newcomer","n_retire","salary_mayor","salary_vice_mayor","salary_chair","salary_vice_chair","salary_assembly_member","salary_education","mayor_sala_apply_ymd","assembly_sala_apply_ymd","education_sala_apply_ymd","ruiji_dantai"]
            df_2 = df_2.reset_index(drop=True)
            
            #結合
            all_df = pd.concat([df_1,df_2],axis=1)
            print(all(all_df["name_2"] == all_df["name_1"]))
            
            df_l.append(all_df)
            
    return df_l

#H30
def pref_seirei_page(dfs,page_num):
    
    #1シート目
    the_df = dfs[page_num]
    the_df = the_df.iloc[6:-1]
    the_df = the_df[the_df != ""].T.dropna(how="all").T
    name_1 = (the_df.iloc[:,0] + the_df.iloc[:,1]).str.replace("\n","")
    name_1.iloc[47:] += "市"
    var_1 = the_df.iloc[:,[2,3,4,13,15,16,17,26]]
    
    df_1 = pd.concat([name_1,var_1],axis=1)
    df_1.columns = ["name_1" ,"n_staff_all","ave_age_staff_all","salary_staff_all","kimatsu_staff_all","n_staff_gyosei","ave_age_staff_gyosei","salary_staff_gyosei","kimatsu_staff_gyosei"]
    df_1 = df_1.reset_index(drop=True)
    
    #2シート目
    the_df = dfs[1]
    the_df = the_df.iloc[4:]
    the_df = the_df[the_df != ""].T.dropna(how="all").T
    name_2 = (the_df.iloc[:,0] + the_df.iloc[:,1]).str.replace("\n","")
    name_2.iloc[47:] += "市"
    var_2 = the_df.iloc[:,2:]
    
    df_2 = pd.concat([name_2,var_2],axis=1)
    df_2.columns = ["name_2","daisotsu","tandaisotsu","kousotsu","n_newcomer","n_retire","salary_mayor","salary_vice_mayor","salary_chair","salary_vice_chair","salary_assembly_member","salary_education","mayor_sala_apply_ymd","assembly_sala_apply_ymd","education_sala_apply_ymd"]
    df_2 = df_2.reset_index(drop=True)
    
    #結合など
    all_df = pd.concat([df_1,df_2],axis=1)
    print(all(all_df["name_2"] == all_df["name_1"]))
    
    pref_df = all_df.iloc[:47,:]
    seirei_df = all_df.iloc[47:,:]
    
    pref_df["ruiji_dantai"] = "都道府県"
    seirei_df["ruiji_dantai"] = "政令指定都市"
    
    return pref_df, seirei_df


def compose_data_for_H30_year(dfs,seirei_num,start_p,end_p):
    df_pref, df_seirei = pref_seirei_page(dfs,seirei_num)
    df_l = process_page(dfs,start_p,end_p)
    c_df = pd.concat([df_seirei]+df_l,axis=0)
    
    c_df = c_df.reset_index(drop=True)
    df_pref = df_pref.reset_index(drop=True)
    
    for c in list(c_df.columns):
        c_df[c] = c_df[c].str.replace(",","")
        df_pref[c] = df_pref[c].str.replace(",","")
    
    #都道府県情報の列追加
    pref = pd.read_csv("prefs_seirei_first_from_20140405.csv",index_col=0)
    c_df.insert(1,"prefecture",pref["都道府県名"])
    c_df.insert(2,"pref_id",pref["都道府県番号"])
    
    df_pref.insert(1,"prefecture",pref["都道府県名"].iloc[21:].unique())
    df_pref.insert(2,"pref_id",df_pref.index+1)

    #年情報の列追加
    c_df.insert(3,"data_ymd","20180401")
    c_df.insert(3,"data_year",2018)
    
    df_pref.insert(3,"data_ymd","20180401")
    df_pref.insert(3,"data_year",2018)
    
    c_df.to_csv("18_salaries.csv")
    df_pref.to_csv("18_pref_salaries.csv")
    
    return c_df

#c_df = compose_data_for_H30_year(dfs,0,2,62)

#H29,H28,H27,H26,H24,H23
def pref_seirei_page_H29(dfs,pref_page):
    df_l = []
    for i in range(pref_page,pref_page+4):
        if i % 2 == 0:
            the_df = dfs[i][(dfs[i].iloc[:,0:3] != "").sum(axis=1) != 0]
            the_df = the_df[the_df != ""].T.dropna(how="all").T
            the_df = the_df[the_df.iloc[:,4].isnull() == False]
            the_df.columns = list(range(len(the_df.columns)))
            name_1 = the_df.iloc[:,0:3].fillna("").sum(axis=1).str.replace(" ","").str.replace("\n","")
            var_1 = the_df.iloc[:,[3,4,5,14,16,17,18,27]]
            df_1 = pd.concat([name_1,var_1],axis=1)
            df_1.columns = ["name_1" ,"n_staff_all","ave_age_staff_all","salary_staff_all","kimatsu_staff_all","n_staff_gyosei","ave_age_staff_gyosei","salary_staff_gyosei","kimatsu_staff_gyosei"]
            
            df_1 = df_1.reset_index(drop=True)
            
            #2シート目
            i += 1
            the_df = dfs[i][(dfs[i].iloc[:,0:2] != "").sum(axis=1) != 0]
            the_df = the_df[the_df != ""].T.dropna(how="all").T
            the_df = the_df[the_df.iloc[:,3].isnull() == False]
            the_df.columns = list(range(len(the_df.columns)))
            name_2 = the_df.iloc[:,0:3].fillna("").sum(axis=1).str.replace(" ","").str.replace("\n","")
            var_2 = the_df.iloc[:,3:]
            df_2 = pd.concat([name_2,var_2],axis=1)

            df_2.columns = ["name_2","daisotsu","tandaisotsu","kousotsu","n_newcomer","n_retire","salary_mayor","salary_vice_mayor","salary_chair","salary_vice_chair","salary_assembly_member","salary_education","mayor_sala_apply_ymd","assembly_sala_apply_ymd","education_sala_apply_ymd"]
            df_2 = df_2.reset_index(drop=True)
            df_2["ruiji_dantai"] = "都道府県" if i == pref_page+1 else "政令指定都市"  
            
            #結合
            all_df = pd.concat([df_1,df_2],axis=1)
            print(all(all_df["name_2"] == all_df["name_1"]))
            
            df_l.append(all_df)
    
    return df_l
            
#H29
def compose_data_for_H29_year(dfs,pref_num,start_p,end_p):
    df_ps_l = pref_seirei_page_H29(dfs,pref_num)
    df_l = process_page(dfs,start_p,end_p)
    c_df = pd.concat([df_ps_l[1]]+df_l,axis=0)
    
    c_df = c_df.reset_index(drop=True)
    df_pref = df_ps_l[0].reset_index(drop=True)
    
    for c in list(c_df.columns):
        c_df[c] = c_df[c].str.replace(",","")
        df_pref[c] = df_pref[c].str.replace(",","")
    
    #都道府県情報の列追加
    pref = pd.read_csv("prefs_seirei_first_from_20140405.csv",index_col=0)
    c_df.insert(1,"prefecture",pref["都道府県名"])
    c_df.insert(2,"pref_id",pref["都道府県番号"])
    
    df_pref.insert(1,"prefecture",pref["都道府県名"].iloc[21:].unique())
    df_pref.insert(2,"pref_id",df_pref.index+1)

    #年情報の列追加
    c_df.insert(3,"data_ymd","20170401")
    c_df.insert(3,"data_year",2017)
    
    df_pref.insert(3,"data_ymd","20170401")
    df_pref.insert(3,"data_year",2017)
    
    c_df.to_csv("17_salaries.csv")
    df_pref.to_csv("17_pref_salaries.csv")
    
    return c_df

#c_df = compose_data_for_H29_year(dfs,0,4,len(dfs))

#H28,H27
def compose_data_for_H27_year(dfs,pref_num,start_p,end_p):
    df_ps_l = pref_seirei_page_H29(dfs,pref_num)
    df_l = process_page(dfs,start_p,end_p)
    c_df = pd.concat([df_ps_l[1]]+df_l,axis=0)
    
    c_df = c_df.reset_index(drop=True)
    df_pref = df_ps_l[0].reset_index(drop=True)
    
    for c in list(c_df.columns):
        c_df[c] = c_df[c].str.replace(",","")
        df_pref[c] = df_pref[c].str.replace(",","")
    
    #都道府県情報の列追加
    pref = pd.read_csv("prefs_seirei_first_from_20140405.csv",index_col=0)
    c_df.insert(1,"prefecture",pref["都道府県名"])
    c_df.insert(2,"pref_id",pref["都道府県番号"])
    
    df_pref.insert(1,"prefecture",pref["都道府県名"].iloc[21:].unique())
    df_pref.insert(2,"pref_id",df_pref.index+1)

    #年情報の列追加
    c_df.insert(3,"data_ymd","20150401")
    c_df.insert(3,"data_year",2015)
    
    df_pref.insert(3,"data_ymd","20150401")
    df_pref.insert(3,"data_year",2015)
    
    c_df.to_csv("15_salaries.csv")
    df_pref.to_csv("15_pref_salaries.csv")
    
    return c_df

#H26
def compose_data_for_H26_year(dfs,pref_num,start_p,end_p):
    df_ps_l = pref_seirei_page_H29(dfs,pref_num)
    df_l = process_page(dfs,start_p,end_p)
    c_df = pd.concat([df_ps_l[1]]+df_l,axis=0)
    
    c_df = c_df.reset_index(drop=True)
    df_pref = df_ps_l[0].reset_index(drop=True)
    
    for c in list(c_df.columns):
        c_df[c] = c_df[c].str.replace(",","")
        df_pref[c] = df_pref[c].str.replace(",","")
    
    #都道府県情報の列追加
    pref = pd.read_csv("prefs_seirei_first_from_20120401.csv",index_col=0)
    pref = pref.reset_index(drop=True)
    c_df.insert(1,"prefecture",pref["都道府県名"])
    c_df.insert(2,"pref_id",pref["都道府県番号"])
    
    df_pref.insert(1,"prefecture",pref["都道府県名"].iloc[21:].unique())
    df_pref.insert(2,"pref_id",df_pref.index+1)

    #年情報の列追加
    c_df.insert(3,"data_ymd","20140401")
    c_df.insert(3,"data_year",2014)
    
    df_pref.insert(3,"data_ymd","20140401")
    df_pref.insert(3,"data_year",2014)
    
    c_df.to_csv("14_salaries.csv")
    df_pref.to_csv("14_pref_salaries.csv")
    
    return c_df

#H25
def pref_seirei_page_H25(dfs,page_num):
    
    #1シート目
    the_df = dfs[page_num]
    the_df = the_df[(the_df.iloc[:,0:3] != "").sum(axis=1) != 0]
    the_df = the_df[the_df != ""].T.dropna(how="all").T
    the_df = the_df[the_df.iloc[:,4].isnull() == False]
    name_1 = the_df.iloc[:,0:2].fillna("").sum(axis=1).str.replace(" ","").str.replace("\n","")
    name_1.iloc[47:] += "市"
    var_1 = the_df.iloc[:,[2,3,4,13,15,16,17,26]]
    
    df_1 = pd.concat([name_1,var_1],axis=1)
    df_1.columns = ["name_1" ,"n_staff_all","ave_age_staff_all","salary_staff_all","kimatsu_staff_all","n_staff_gyosei","ave_age_staff_gyosei","salary_staff_gyosei","kimatsu_staff_gyosei"]
    df_1 = df_1.reset_index(drop=True)
    
    #2シート目
    the_df = dfs[page_num+1]
    the_df = the_df[(the_df.iloc[:,0:2] != "").sum(axis=1) != 0]
    the_df = the_df[the_df != ""].T.dropna(how="all").T
    the_df = the_df[the_df.iloc[:,3].isnull() == False]
    name_2 = the_df.iloc[:,0:2].fillna("").sum(axis=1).str.replace(" ","").str.replace("\n","")
    name_2.iloc[47:] += "市"
    var_2 = the_df.iloc[:,2:]
    
    df_2 = pd.concat([name_2,var_2],axis=1)
    df_2.columns = ["name_2","daisotsu","tandaisotsu","kousotsu","n_newcomer","n_retire","salary_mayor","salary_vice_mayor","salary_chair","salary_vice_chair","salary_assembly_member","salary_education","mayor_sala_apply_ymd","assembly_sala_apply_ymd","education_sala_apply_ymd"]
    df_2 = df_2.reset_index(drop=True)
    
    #結合など
    all_df = pd.concat([df_1,df_2],axis=1)
    print(all(all_df["name_2"] == all_df["name_1"]))
    
    pref_df = all_df.iloc[:47,:]
    seirei_df = all_df.iloc[47:,:]
    
    pref_df["ruiji_dantai"] = "都道府県"
    seirei_df["ruiji_dantai"] = "政令指定都市"
    
    return pref_df, seirei_df

def compose_data_for_H25_year(dfs,seirei_num,start_p,end_p):
    df_pref, df_seirei = pref_seirei_page_H25(dfs,seirei_num)
    df_l = process_page(dfs,start_p,end_p)
    c_df = pd.concat([df_seirei]+df_l,axis=0)
    
    c_df = c_df.reset_index(drop=True)
    df_pref = df_pref.reset_index(drop=True)
    
    for c in list(c_df.columns):
        c_df[c] = c_df[c].str.replace(",","")
        df_pref[c] = df_pref[c].str.replace(",","")
    
    #都道府県情報の列追加
    pref = pd.read_csv("prefs_seirei_first_from_20140405.csv",index_col=0)
    pref = pref.reset_index(drop=True)
    c_df.insert(1,"prefecture",pref["都道府県名"])
    c_df.insert(2,"pref_id",pref["都道府県番号"])
    
    df_pref.insert(1,"prefecture",pref["都道府県名"].iloc[21:].unique())
    df_pref.insert(2,"pref_id",df_pref.index+1)

    #年情報の列追加
    c_df.insert(3,"data_ymd","20130401")
    c_df.insert(3,"data_year",2013)
    
    df_pref.insert(3,"data_ymd","20130401")
    df_pref.insert(3,"data_year",2013)
    
    c_df.to_csv("13_salaries.csv")
    df_pref.to_csv("13_pref_salaries.csv")
    
    return c_df

#H24
def compose_data_for_H24_year(dfs,pref_num,start_p,end_p):
    df_ps_l = pref_seirei_page_H29(dfs,pref_num)
    df_l = process_page(dfs,start_p,end_p)
    c_df = pd.concat([df_ps_l[1]]+df_l,axis=0)
    
    c_df = c_df.reset_index(drop=True)
    df_pref = df_ps_l[0].reset_index(drop=True)
    
    for c in list(c_df.columns):
        c_df[c] = c_df[c].str.replace(",","")
        df_pref[c] = df_pref[c].str.replace(",","")
    
    #都道府県情報の列追加
    pref = pd.read_csv("prefs_seirei_first_from_20120401.csv",index_col=0)
    pref = pref.reset_index(drop=True)
    c_df.insert(1,"prefecture",pref["都道府県名"])
    c_df.insert(2,"pref_id",pref["都道府県番号"])
    
    df_pref.insert(1,"prefecture",pref["都道府県名"].iloc[21:].unique())
    df_pref.insert(2,"pref_id",df_pref.index+1)

    #年情報の列追加
    c_df.insert(3,"data_ymd","20120401")
    c_df.insert(3,"data_year",2014)
    
    df_pref.insert(3,"data_ymd","20120401")
    df_pref.insert(3,"data_year",2014)
    
    c_df.to_csv("12_salaries.csv")
    df_pref.to_csv("12_pref_salaries.csv")
    
    return c_df

#H24
def compose_data_for_H23_year(dfs,pref_num,start_p,end_p):
    df_ps_l = pref_seirei_page_H29(dfs,pref_num)
    df_l = process_page(dfs,start_p,end_p)
    c_df = pd.concat([df_ps_l[1]]+df_l,axis=0)
    
    c_df = c_df.reset_index(drop=True)
    df_pref = df_ps_l[0].reset_index(drop=True)
    
    for c in list(c_df.columns):
        c_df[c] = c_df[c].str.replace(",","")
        df_pref[c] = df_pref[c].str.replace(",","")
    
    #都道府県情報の列追加
    pref = pd.read_csv("prefs_seirei_first_from_20120401.csv",index_col=0)
    pref = pref.reset_index(drop=True)
    c_df.insert(1,"prefecture",pref["都道府県名"])
    c_df.insert(2,"pref_id",pref["都道府県番号"])
    
    df_pref.insert(1,"prefecture",pref["都道府県名"].iloc[21:].unique())
    df_pref.insert(2,"pref_id",df_pref.index+1)

    #年情報の列追加
    c_df.insert(3,"data_ymd","20110401")
    c_df.insert(3,"data_year",2011)
    
    df_pref.insert(3,"data_ymd","20110401")
    df_pref.insert(3,"data_year",2011)
    
    c_df.to_csv("11_salaries.csv")
    df_pref.to_csv("11_pref_salaries.csv")
    
    return c_df


#H22,H21
def process_page_H22(dfs,start_num,end_num):
    df_l = []
    for i in range(start_num,end_num):
        if i % 2 == 0:
            #1シート目
            the_df = dfs[i][(dfs[i].iloc[:,0:3] != "").sum(axis=1) != 0]
            the_df = the_df[the_df != ""].T.dropna(how="all").T
            the_df = the_df[the_df.iloc[:,3].isnull() == False]
            the_df.columns = list(range(len(the_df.columns)))
            if the_df.shape[1] == 29:
                name_1 = the_df.iloc[:,0:3].fillna("").sum(axis=1).str.replace(" ","").str.replace("\n","")
                var_1 = the_df.iloc[:,[3,4,5,14,16,17,18,27]]
            else:
                name_1 = the_df.iloc[:,0:4].fillna("").sum(axis=1).str.replace(" ","")
                var_1 = the_df.iloc[:,[4,5,6,15,17,18,19,28]]
            df_1 = pd.concat([name_1,var_1],axis=1)
            df_1.columns = ["name_1" ,"n_staff_all","ave_age_staff_all","salary_staff_all","kimatsu_staff_all","n_staff_gyosei","ave_age_staff_gyosei","salary_staff_gyosei","kimatsu_staff_gyosei"]
            df_1 = df_1.reset_index(drop=True)
            
            #2シート目
            i += 1
            the_df = dfs[i][(dfs[i].iloc[:,0:2] != "").sum(axis=1) != 0]
            the_df = the_df[the_df != ""].T.dropna(how="all").T
            the_df = the_df[the_df.iloc[:,3].isnull() == False]
            the_df.columns = list(range(len(the_df.columns)))
            if the_df.shape[1] == 19:
                name_2 = the_df.iloc[:,0:3].fillna("").sum(axis=1).str.replace(" ","").str.replace("\n","")
                var_2 = the_df.iloc[:,3:]
            else:
                name_2 = the_df.iloc[:,0:4].fillna("").sum(axis=1).str.replace(" ","").str.replace("\n","")
                var_2 = the_df.iloc[:,4:]
            var_2 = var_2.drop(columns=var_2.columns[7])
            df_2 = pd.concat([name_2,var_2],axis=1)
            df_2.columns = ["name_2","daisotsu","tandaisotsu","kousotsu","n_newcomer","n_retire","salary_mayor","salary_vice_mayor","salary_chair","salary_vice_chair","salary_assembly_member","salary_education","mayor_sala_apply_ymd","assembly_sala_apply_ymd","education_sala_apply_ymd","ruiji_dantai"]
            df_2 = df_2.reset_index(drop=True)
            
            #結合
            all_df = pd.concat([df_1,df_2],axis=1)
            print(all(all_df["name_2"] == all_df["name_1"]))
            
            df_l.append(all_df)
            
    return df_l

def pref_seirei_page_H22(dfs,pref_page):
    df_l = []
    for i in range(pref_page,pref_page+4):
        if i % 2 == 0:
            the_df = dfs[i].iloc[4:]
            the_df = the_df[(the_df.iloc[:,0:3] != "").sum(axis=1) != 0]
            the_df = the_df[the_df != ""].T.dropna(how="all").T
            the_df = the_df[the_df.iloc[:,4].isnull() == False]
            the_df.columns = list(range(len(the_df.columns)))
            name_1 = the_df.iloc[:,0:3].fillna("").sum(axis=1).str.replace(" ","").str.replace("\n","")
            var_1 = the_df.iloc[:,[3,4,5,14,16,17,18,27]]
            df_1 = pd.concat([name_1,var_1],axis=1)
            df_1.columns = ["name_1" ,"n_staff_all","ave_age_staff_all","salary_staff_all","kimatsu_staff_all","n_staff_gyosei","ave_age_staff_gyosei","salary_staff_gyosei","kimatsu_staff_gyosei"]
            
            df_1 = df_1.reset_index(drop=True)
            
            #2シート目
            i += 1
            the_df = dfs[i].iloc[4:]
            the_df = the_df[(the_df.iloc[:,0:2] != "").sum(axis=1) != 0]
            the_df = the_df[the_df != ""].T.dropna(how="all").T
            the_df = the_df[the_df.iloc[:,3].isnull() == False]
            the_df.columns = list(range(len(the_df.columns)))
            name_2 = the_df.iloc[:,0:3].fillna("").sum(axis=1).str.replace(" ","").str.replace("\n","")
            var_2 = the_df.iloc[:,3:]
            var_2 = var_2.drop(columns=var_2.columns[7])
            df_2 = pd.concat([name_2,var_2],axis=1)

            df_2.columns = ["name_2","daisotsu","tandaisotsu","kousotsu","n_newcomer","n_retire","salary_mayor","salary_vice_mayor","salary_chair","salary_vice_chair","salary_assembly_member","salary_education","mayor_sala_apply_ymd","assembly_sala_apply_ymd","education_sala_apply_ymd"]
            df_2 = df_2.reset_index(drop=True)
            df_2["ruiji_dantai"] = "都道府県" if i == pref_page+1 else "政令指定都市"  
            
            #結合
            all_df = pd.concat([df_1,df_2],axis=1)
            print(all(all_df["name_2"] == all_df["name_1"]))
            
            df_l.append(all_df)
    
    return df_l


def compose_data_for_H22_year(dfs,pref_num,start_p,end_p):
    df_ps_l = pref_seirei_page_H22(dfs,pref_num)
    df_l = process_page_H22(dfs,start_p,end_p)
    c_df = pd.concat([df_ps_l[1]]+df_l,axis=0)
    
    c_df = c_df.reset_index(drop=True)
    df_pref = df_ps_l[0].reset_index(drop=True)
    
    for c in list(c_df.columns):
        c_df[c] = c_df[c].str.replace(",","")
        df_pref[c] = df_pref[c].str.replace(",","")
    
    #都道府県情報の列追加
    pref = pd.read_csv("prefs_seirei_first_from_20100401.csv",index_col=0)
    c_df.insert(1,"prefecture",pref["都道府県名"])
    c_df.insert(2,"pref_id",pref["都道府県番号"])
    
    df_pref.insert(1,"prefecture",pref["都道府県名"].iloc[21:].unique())
    df_pref.insert(2,"pref_id",df_pref.index+1)

    #年情報の列追加
    c_df.insert(3,"data_ymd","20100401")
    c_df.insert(3,"data_year",2010)
    
    df_pref.insert(3,"data_ymd","20100401")
    df_pref.insert(3,"data_year",2010)
    
    c_df.to_csv("10_salaries.csv")
    df_pref.to_csv("10_pref_salaries.csv")
    
    return c_df

def pref_seirei_page_H21(dfs,page_num):
    
    #1シート目
    the_df = dfs[page_num]
    the_df = the_df[(the_df.iloc[:,0:3] != "").sum(axis=1) != 0]
    the_df = the_df[the_df != ""].T.dropna(how="all").T
    the_df = the_df[the_df.iloc[:,4].isnull() == False]
    name_1 = the_df.iloc[:,0:3].fillna("").sum(axis=1).str.replace(" ","").str.replace("\n","")
    var_1 = the_df.iloc[:,[3,4,5,14,16,17,18,27]]
    
    df_1 = pd.concat([name_1,var_1],axis=1)
    df_1.columns = ["name_1" ,"n_staff_all","ave_age_staff_all","salary_staff_all","kimatsu_staff_all","n_staff_gyosei","ave_age_staff_gyosei","salary_staff_gyosei","kimatsu_staff_gyosei"]
    df_1 = df_1.reset_index(drop=True)
    
    #2シート目
    the_df = dfs[page_num+1]
    the_df = the_df[(the_df.iloc[:,0:2] != "").sum(axis=1) != 0]
    the_df = the_df[the_df != ""].T.dropna(how="all").T
    the_df = the_df[the_df.iloc[:,3].isnull() == False]
    name_2 = the_df.iloc[:,0:3].fillna("").sum(axis=1).str.replace(" ","").str.replace("\n","")
    var_2 = the_df.iloc[:,3:]
    var_2 = var_2.drop(columns=var_2.columns[7])
    
    df_2 = pd.concat([name_2,var_2],axis=1)
    df_2.columns = ["name_2","daisotsu","tandaisotsu","kousotsu","n_newcomer","n_retire","salary_mayor","salary_vice_mayor","salary_chair","salary_vice_chair","salary_assembly_member","salary_education","mayor_sala_apply_ymd","assembly_sala_apply_ymd","education_sala_apply_ymd"]
    df_2 = df_2.reset_index(drop=True)
    
    #結合など
    all_df = pd.concat([df_1,df_2],axis=1)
    print(all(all_df["name_2"] == all_df["name_1"]))
    
    pref_df = all_df.iloc[:47,:]
    seirei_df = all_df.iloc[47:,:]
    
    pref_df["ruiji_dantai"] = "都道府県"
    seirei_df["ruiji_dantai"] = "政令指定都市"
    
    return pref_df, seirei_df

def compose_data_for_H21_year(dfs,seirei_num,start_p,end_p):
    df_pref, df_seirei = pref_seirei_page_H21(dfs,seirei_num)
    df_l = process_page_H22(dfs,start_p,end_p)
    c_df = pd.concat([df_seirei]+df_l,axis=0)
    
    c_df = c_df.reset_index(drop=True)
    df_pref = df_pref.reset_index(drop=True)
    
    for c in list(c_df.columns):
        c_df[c] = c_df[c].str.replace(",","")
        df_pref[c] = df_pref[c].str.replace(",","")
    
    #都道府県情報の列追加
    pref = pd.read_csv("prefs_seirei_first_from_20090401.csv",index_col=0)
    pref = pref.reset_index(drop=True)
    c_df.insert(1,"prefecture",pref["都道府県名"])
    c_df.insert(2,"pref_id",pref["都道府県番号"])
    
    df_pref.insert(1,"prefecture",pref["都道府県名"].iloc[21:].unique())
    df_pref.insert(2,"pref_id",df_pref.index+1)

    #年情報の列追加
    c_df.insert(3,"data_ymd","20090401")
    c_df.insert(3,"data_year",2009)
    
    df_pref.insert(3,"data_ymd","20090401")
    df_pref.insert(3,"data_year",2009)
    
    c_df.to_csv("09_salaries.csv")
    df_pref.to_csv("09_pref_salaries.csv")
    
    return c_df

#c_df = compose_data_for_H21_year(dfs,0,2,len(dfs))

#H20
def process_page_H20(dfs,start_num,end_num):
    df_l = []
    for i in range(start_num,end_num):
        if i % 2 == 0:
            #1シート目
            the_df = dfs[i][(dfs[i].iloc[:,0:3] != "").sum(axis=1) != 0]
            the_df = the_df[the_df != ""].T.dropna(how="all").T
            the_df = the_df[the_df.iloc[:,3].isnull() == False]
            the_df.columns = list(range(len(the_df.columns)))
            if the_df.shape[1] == 29:
                name_1 = the_df.iloc[:,0:3].fillna("").sum(axis=1).str.replace(" ","").str.replace("\n","")
                var_1 = the_df.iloc[:,[3,4,5,14,16,17,18,27]]
            else:
                name_1 = the_df.iloc[:,0].str.replace(" ","").str.replace("\n","")
                var_1 = the_df.iloc[:,[1,2,3,12,14,15,16,25]]
            df_1 = pd.concat([name_1,var_1],axis=1)
            df_1.columns = ["name_1" ,"n_staff_all","ave_age_staff_all","salary_staff_all","kimatsu_staff_all","n_staff_gyosei","ave_age_staff_gyosei","salary_staff_gyosei","kimatsu_staff_gyosei"]
            df_1 = df_1.reset_index(drop=True)
            
            #2シート目
            i += 1
            if i != end_num-1:
                the_df = dfs[i][(dfs[i].iloc[:,0:2] != "").sum(axis=1) != 0]
                the_df = the_df[the_df != ""].T.dropna(how="all").T
                the_df = the_df[the_df.iloc[:,3].isnull() == False]
                the_df.columns = list(range(len(the_df.columns)))
                name_2 = the_df.iloc[:,0:3].fillna("").sum(axis=1).str.replace(" ","").str.replace("\n","")
                var_2 = the_df.iloc[:,3:]
            else:
                the_df = dfs[i].iloc[3:]
                the_df = the_df[the_df != ""].T.dropna(how="all").T
                name_2 = the_df.iloc[:,0].str.replace(" ","").str.replace("\n","")
                var_2 = the_df.iloc[:,1:]
            var_2 = var_2.drop(columns=var_2.columns[7])
            df_2 = pd.concat([name_2,var_2],axis=1)
            df_2.columns = ["name_2","daisotsu","tandaisotsu","kousotsu","n_newcomer","n_retire","salary_mayor","salary_vice_mayor","salary_chair","salary_vice_chair","salary_assembly_member","salary_education","mayor_sala_apply_ymd","assembly_sala_apply_ymd","education_sala_apply_ymd","ruiji_dantai"]
            df_2 = df_2.reset_index(drop=True)
            
            #結合
            all_df = pd.concat([df_1,df_2],axis=1)
            print(all(all_df["name_2"] == all_df["name_1"]))
            
            df_l.append(all_df)
            
    return df_l

def pref_seirei_page_H20(dfs,page_num):
    
    #1シート目
    the_df = dfs[page_num]
    the_df = the_df[(the_df.iloc[:,0:3] != "").sum(axis=1) != 0]
    the_df = the_df[the_df != ""].T.dropna(how="all").T
    the_df = the_df[the_df.iloc[:,4].isnull() == False]
    name_1 = the_df.iloc[:,0:2].fillna("").sum(axis=1).str.replace(" ","").str.replace("\n","")
    name_1.iloc[47:] += "市"
    var_1 = the_df.iloc[:,[2,3,4,13,15,16,17,26]]
    
    df_1 = pd.concat([name_1,var_1],axis=1)
    df_1.columns = ["name_1" ,"n_staff_all","ave_age_staff_all","salary_staff_all","kimatsu_staff_all","n_staff_gyosei","ave_age_staff_gyosei","salary_staff_gyosei","kimatsu_staff_gyosei"]
    df_1 = df_1.reset_index(drop=True)
    
    #2シート目
    the_df = dfs[page_num+1]
    the_df = the_df[(the_df.iloc[:,0:2] != "").sum(axis=1) != 0]
    the_df = the_df[the_df != ""].T.dropna(how="all").T
    the_df = the_df[the_df.iloc[:,3].isnull() == False]
    name_2 = the_df.iloc[:,0:2].fillna("").sum(axis=1).str.replace(" ","").str.replace("\n","")
    name_2.iloc[47:] += "市"
    var_2 = the_df.iloc[:,2:]
    var_2 = var_2.drop(columns=var_2.columns[7])
    
    df_2 = pd.concat([name_2,var_2],axis=1)
    df_2.columns = ["name_2","daisotsu","tandaisotsu","kousotsu","n_newcomer","n_retire","salary_mayor","salary_vice_mayor","salary_chair","salary_vice_chair","salary_assembly_member","salary_education","mayor_sala_apply_ymd","assembly_sala_apply_ymd","education_sala_apply_ymd"]
    df_2 = df_2.reset_index(drop=True)
    
    #結合など
    all_df = pd.concat([df_1,df_2],axis=1)
    print(all(all_df["name_2"] == all_df["name_1"]))
    
    pref_df = all_df.iloc[:47,:]
    seirei_df = all_df.iloc[47:,:]
    
    pref_df["ruiji_dantai"] = "都道府県"
    seirei_df["ruiji_dantai"] = "政令指定都市"
    
    return pref_df, seirei_df

def compose_data_for_H20_year(dfs,seirei_num,start_p,end_p):
    df_pref, df_seirei = pref_seirei_page_H20(dfs,seirei_num)
    df_l = process_page_H20(dfs,start_p,end_p)
    c_df = pd.concat([df_seirei]+df_l,axis=0)
    
    c_df = c_df.reset_index(drop=True)
    df_pref = df_pref.reset_index(drop=True)
    
    for c in list(c_df.columns):
        c_df[c] = c_df[c].str.replace(",","")
        df_pref[c] = df_pref[c].str.replace(",","")
    
    #都道府県情報の列追加
    pref = pd.read_csv("prefs_seirei_first_from_20080401.csv",index_col=0)
    pref = pref.reset_index(drop=True)
    c_df.insert(1,"prefecture",pref["都道府県名"])
    c_df.insert(2,"pref_id",pref["都道府県番号"])
    
    df_pref.insert(1,"prefecture",pref["都道府県名"].iloc[21:].unique())
    df_pref.insert(2,"pref_id",df_pref.index+1)

    #年情報の列追加
    c_df.insert(3,"data_ymd","20080401")
    c_df.insert(3,"data_year",2008)
    
    df_pref.insert(3,"data_ymd","20080401")
    df_pref.insert(3,"data_year",2008)
    
    c_df.to_csv("08_salaries.csv")
    df_pref.to_csv("08_pref_salaries.csv")
    
    return c_df

c_df = compose_data_for_H20_year(dfs,0,2,len(dfs))

#H25 prefecture 修正
h25 = pd.read_csv("13_salaries.csv")
pref = pd.read_csv("prefs_seirei_first_from_20120401.csv",index_col=0)
pref = pref.reset_index(drop=True)
h25.loc[:,"prefecture"] = pref["都道府県名"]
h25.loc[:,"pref_id"] = pref["都道府県番号"]
h25 = h25.iloc[:,1:]
#h25.to_csv("13_salaries.csv")

#H24 year 修正
h24 = pd.read_csv("12_salaries.csv",index_col=0)
h24_pref = pd.read_csv("12_pref_salaries.csv",index_col=0)
h24.loc[:,"data_year"] = 2012
h24_pref.loc[:,"data_year"] = 2012
#h24.to_csv("12_salaries.csv")
#h24_pref.to_csv("12_pref_salaries.csv")


#H23 欠損　特定
h23_name = list(c_df["name_1"].values)
h24_name = list(h24["name_1"].values)

m_l = []
for i in h23_name:
    if (i in h24_name) == False:
        print(i)
        m_l.append(i)
        
r_l = []
for i in h24_name:
    if (i in h23_name) == False:
        print(i)
        r_l.append(i)

len(r_l) - len(m_l)　#整合的,原因は震災


# 上記に基づき、欠損値となっている自治体をnanとしてデータに追加
# prefectureも修正

pref = pd.read_csv("prefs_seirei_first_from_20110401.csv",index_col=0)
pref
omits = r_l[:-2] #震災が原因で今回欠損値となったと思われる市町村
h23 = c_df
omit_df = pd.DataFrame([[omits[i]] + [np.nan]*(h23_t.shape[0]-1) for i in range(len(omits))],columns=h23.columns)
h23[h23["prefecture"]=="岩手県"]
h23.iloc[:269]
h23[h23["prefecture"]=="福島県"]
h23.iloc[269:414]
omit_df.iloc[2:]
new_h23 = pd.concat([h23.iloc[:269],omit_df.iloc[:2],h23.iloc[269:414],omit_df.iloc[2:],h23.iloc[414:]],axis=0)
new_h23 = new_h23.reset_index(drop=True)

new_h23.loc[:,"prefecture"] = pref["都道府県名"]
new_h23.loc[:,"pref_id"] = pref["都道府県番号"]

new_h23.loc[:,"data_year"] = 2011
new_h23.loc[:,"data_ymd"] = "20110401"

#new_h23.to_csv("11_salaries.csv")
