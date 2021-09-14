import pandas as pd
import numpy as np
import tabula

def process_page(dfs,start_p,end_p):
    
    df_l = []
    
    for s_id in range(start_p,end_p+1):
        
        if s_id % 2 == 0:
            print(dfs[s_id].iloc[5:,:].shape[1],s_id)
            
            if dfs[s_id].iloc[5:,:].shape[1] == 18:
                d = 0
            else:
                d = -1
            
            #　1ページ目
            name_1 = list(dfs[s_id].iloc[5:,0][dfs[4].iloc[5:,2+d].isnull() == False].str.replace(" ",""))
                
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
            if dfs[s_id+1].shape[i] == 18:
                #列数18
                this_df = dfs[s_id+1][dfs[s_id+1].iloc[:,3].isnull() == False]
                name_2 = [(str(this_df.iloc[i,0])+str(this_df.iloc[i,1])).replace("nan","").replace(" ","") for i in range(this_df.shape[0])]
                var_df = this_df.iloc[:,3:]
                
            else:
                #列数16
                this_df = dfs[s_id+1]
                name_2 = list(this_df.iloc[:,0].str.replace(" ",""))
                var_df = this_df.iloc[:,1:]
                
            var_df.insert(0,"name_2",name_2)
            var_df = var_df.reset_index(drop=True)
            var_df.columns = ["name_2","daisotsu","tandaisotsu","kousotsu","n_newcomer","n_retire","salary_mayor","salary_vice_mayor","salary_chair","salary_vice_chair","salary_assembly_member","salary_education","mayor_sala_apply_ymd","assembly_sala_apply_ymd","education_sala_apply_ymd","ruiji_dantai"]
            
            all_df = pd.concat([fi_df,var_df],axis=1)
            print(all(all_df["name_2"] == all_df[0])
                  
            df_l.append(all_df)
                  
        else:
            pass
    
    return df_l


def compose_data_for_one_year(file_name,ymd,start_p,end_p):
    dfs = tabula.read_pdf("salaries_pdfs/h31_kyuyo_1_05.pdf", stream=True, pages = '2-65',multiple_tables=True)
    df_l = process_page(dfs,start_p,end_p)
    c_df = pd.concat(df_l,axis=0)
    
    return c_df
    
　　#都道府県名を追加したい

