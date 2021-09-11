import numpy as np
import pandas as pd
import warnings
warnings.simplefilter('ignore')

def initial_setting(pref_num):
    pref_1 = pd.read_csv("original_candidates_data/gikai_pref_"+str(pref_num)+".csv")
    pref_1["id"] = pref_1.index
    #ele_ymd_l = pref_1["ele_ymd"].unique()
    #circle_base = pd.DataFrame(pref_1["circle"].unique(),columns=["circle"])
    return pref_1 #ele_ymd_l, circle_base

def asitis_all_eles(pref_1):
    ## as it is (元csvからそのまま使える変数)　→　groupby().first()で取得してしまう

    #そのまま使う変数のリスト
    asitis_l = ['election', 'prefecture', 'municipality','voting_ymd', 'year', 'month', 'day', 'kokuji_ymd','e_voting_rate','e_seats_target','e_n_candidates','e_competitive_ratio','e_all_voter', 'e_male_all_voter','e_female_all_voter','e_change_all_voter', 'e_reason', 'e_pre_v_rate','e_pre_seats_t', 'e_pre_n_cand', 'e_pre_compe_rate']
    
    #各選挙の一人目の候補者の行から、その選挙に関するデータを取得
    asitis_df = pref_1.groupby("ele_ymd").first()[asitis_l]
    
    #変数名変更
    columns_name = ['election','prefecture','municipality','ymd','year','month','day', 'kokuji_ymd','voting_rate','n_seats_display','n_cand_display','compe_ratio_display','n_voters_inlaw', 'male_voters_inlaw','female_voters_inlaw','change_voters_inlaw', 'reason', 'pre_voting_rate','pre_seats_display', 'pre_n_cand_display', 'pre_compe_rate_display']
    asitis_df.columns = columns_name
    
    ele_ymd_l = list(asitis_df.index)
    
    return asitis_df, ele_ymd_l
    

def need_calculates_one_ele(pref_1,ele_ymd_l,ele_num):
    #選挙名+ymd
    ele_ymd = ele_ymd_l[ele_num]
    
    #対象選挙のみのdfを設定
    target_df = pref_1[pref_1["ele_ymd"] == ele_ymd_l[ele_num]]
    
    #欠損値判定
    #基本変数
    needed_variables_l = ["district","id","win","age","gen","status","circle"]
    #候補者の基本変数に欠損があるかどうか
    nan_bools = target_df[needed_variables_l].isnull().any()
    #当選者の基本変数に欠損があるかどうか
    nan_bools_win = target_df[target_df["win"] == True][needed_variables_l].isnull().any()
    
    #選挙区数
    if nan_bools["district"] == False:
        n_districts = target_df.groupby("district").size().size
    else:
        n_districts = np.nan

    #選挙ごとの立候補者数
    n_cand_data = target_df.count()["id"]

    #選挙ごとの当選者数
    if nan_bools["win"] == False:
        n_wins_data = target_df.sum()["win"]
    else:
        n_win_data = np.nan

    #選挙ごとの競争率
    compe_rate_data = n_cand_data/n_wins_data
    
    #taeget_df に無投票情報の情報を追加　
    target_df["no_vote"] = 0
    target_df["minasi_no_vote"] = 0
    
    target_df.loc[target_df["d_voting_rate"]=="無投票","no_vote"] = 1 
    
    #無投票の場合情報が載っているはずの変数 "d_voting_rate" が欠損になっている可能性も考慮
    if target_df["d_voting_rate"].isnull().any() :
        dvr_nans = target_df[target_df["d_voting_rate"].isnull()] #"d_voting_rate"が欠損値になっている候補者
        compe_d = target_df.groupby("district").apply(lambda d: d.id.count()/d.win.sum()) #候補者データに基づく各選挙区の競争率
        minasi_nv_d_l = list(compe_d[compe_d <= 1].keys()) #無投票の選挙区リスト
        target_df.loc[dvr_nans[dvr_nans["district"].isin(minasi_nv_d_l)].index,"no_vote"] = 1 # d_voting_rate"が欠損かつ無投票選挙区の場合無投票に
        target_df.loc[dvr_nans[dvr_nans["district"].isin(minasi_nv_d_l)].index,"minasi_no_vote"] = 1 #「みなし無投票」としておく
    
    else:
        pass
    
    
    #選挙ごとの無投票変数
    #無投票当選者数の割合                        
    no_voting_ratio_win = target_df["no_vote"].mean()
    #無投票で決定の選挙区の割合
    no_voting_ratio_districts = (target_df.groupby("district").first()["no_vote"] == 1).mean()
    #「みなし無投票」の選挙区の割合
    minasi_nv_ratio_districts = (target_df.groupby("district").first()["minasi_no_vote"] == 1).mean()
    
    #選挙ごとの年齢の summary stats
    #項目は 'mean', 'std', 'min', '25%', '50%', '75%', 'max'
    if nan_bools["age"] == False:
        #選挙ごとの立候補者年齢
        age_stats_cand = list(target_df["age"].describe())[1:]
        age_stats_cand[1] = target_df["age"].std(ddof=0) #標準偏差を不偏→標本に変更
        #選挙ごとの当選者年齢
        age_stats_wins = list(target_df[target_df["win"] == True]["age"].describe())[1:]
        age_stats_wins[1] = target_df[target_df["win"] == True]["age"].std(ddof=0)  
        
    elif nan_bools_win["age"] == False:
        #選挙ごとの立候補者平均年齢
        age_stats_cand = [np.nan]*7
        #選挙ごとの当選者平均年齢
        age_stats_wins = list(target_df[target_df["win"] == True]["age"].describe())[1:]
        age_stats_wins[1] = target_df[target_df["win"] == True]["age"].std(ddof=0)
        
    else:
        age_stats_cand = [np.nan]*7
        age_stats_wins = [np.nan]*7
        
    
    #選挙ごとの女性割合
    if nan_bools["gen"] == False:
        #選挙ごとの立候補者に占める女性割合
        if "女" in list(target_df["gen"].values):
            ratio_women_cand = (target_df["gen"] == "女").mean()
        else:
            ratio_women_cand = 0
        
        #選挙ごとの当選者に占める女性割合
        if "女" in list(target_df[target_df["win"] == True]["gen"].values):
            ratio_women_wins = (target_df[target_df["win"] == True]["gen"] == "女").mean()
        else:
            ratio_women_wins = 0   
                             
    elif nan_bools_win["gen"] == False:
        ratio_women_cand = np.nan
        if "女" in list(target_df[target_df["win"] == True]["gen"].values):
            ratio_women_wins = (target_df[target_df["win"] == True]["gen"] == "女").mean()
        else:
            ratio_women_wins = 0
    
    else:
        ratio_women_cand = np.nan
        ratio_women_wins = np.nan 
    
    #無投票当選者以外の得票数に欠損があるかどうかの判定
    nan_bools_votes = target_df[target_df["no_vote"] == 0]["n_votes"].isnull().any()
    
    #選挙ごとの男女別得票率
    #選挙ごとの男女別の(無投票当選候補を除く)候補1人当たり平均得票率
    if (no_voting_ratio_districts != 1)&(nan_bools_votes == False)&(nan_bools["gen"] == False):
        ratio_women_votes = target_df[target_df["gen"] == "女"]["n_votes"].sum()/target_df["n_votes"].sum()
        ratio_women_votes_percand = ratio_women_votes/(target_df[target_df["gen"] == "女"]["n_votes"].isnull() == False).sum() # 無投票当選者（票数が欠損）を除く人数で割る
        ratio_men_votes = target_df[target_df["gen"] == "男"]["n_votes"].sum()/target_df["n_votes"].sum()
        ratio_men_votes_percand = ratio_men_votes/(target_df[target_df["gen"] == "男"]["n_votes"].isnull() == False).sum()
        
    else:
        ratio_women_votes = np.nan
        ratio_women_votes_percand = np.nan
        ratio_men_votes = np.nan
        atio_men_votes_percand = np.nan
    
    #選挙ごとの立候補者数に占める現職・新人・元職割合
    if nan_bools["status"] == False:
        status_ncand = target_df.groupby("status").size()
        statuses = sum(status_ncand)
        status_kind_l = list(target_df.groupby("status").groups.keys())
        
        if "現職" in status_kind_l:
            ratio_inc_cand = status_ncand.loc["現職"]/statuses
        else:
            ratio_inc_cand = 0
        if "新人" in status_kind_l:
            ratio_new_cand = status_ncand.loc["新人"]/statuses
        else:
            ratio_new_cand = 0 
        if "元職" in status_kind_l:
            ratio_form_cand = status_ncand.loc["元職"]/statuses
        else:
            ratio_form_cand = 0 
    else:
        ratio_inc_cand = np.nan
        ratio_new_cand = np.nan
        ratio_form_cand = np.nan    

    #選挙ごとの当選者数に占める現職・新人・元職割合
    if nan_bools_win["status"] == False:
        status_nwins = target_df.groupby("status").sum()["win"]
        sta_wins = sum(status_nwins)
        status_w_kind_l = list(target_df[target_df["win"] == True].groupby("status").groups.keys())
                                     
        if "現職" in status_w_kind_l:
            ratio_inc_wins = status_nwins.loc["現職"]/sta_wins
        else:
            ratio_inc_wins = 0
        if "新人" in status_w_kind_l:
            ratio_new_wins = status_nwins.loc["新人"]/sta_wins
        else:
            ratio_new_wins = 0
        if "元職" in status_w_kind_l:
            ratio_form_wins = status_nwins.loc["元職"]/sta_wins
        else:
            ratio_form_wins = 0
    else:
        ratio_inc_wins = np.nan
        ratio_new_wins = np.nan
        ratio_form_wins = np.nan 
        
    
    #選挙ごとの現職・新人・元職得票率
    #選挙ごとの現職・新人・元職の(無投票当選候補を除く)候補1人当たり平均得票率
    ## 選挙戦がどこかの選挙区で発生し,かつ得票数に欠損値が無く,かつ政党情報に欠損値が無い場合のみ計算、それ以外はnan
    if (no_voting_ratio_districts != 1)&(nan_bools_votes == False)&(nan_bools["status"] == False):
        status_votes = target_df.groupby("status").sum()["n_votes"]
        sta_votes = sum(status_votes)
        status_no_voting = target_df[target_df["no_vote"] == 1].groupby("status").size()
        status_nv_kind_l = list(status_no_voting.keys())
                                     
        if "現職" in status_kind_l:
            ratio_inc_votes = status_votes.loc["現職"]/sta_votes
            if "現職" not in status_nv_kind_l:                    
                ratio_inc_votes_percand = ratio_inc_votes/status_ncand.loc["現職"]
            else:
                ratio_inc_votes_percand = ratio_inc_votes/(status_ncand.loc["現職"] - status_no_voting.loc["現職"])
        else:
            ratio_inc_votes = np.nan
            ratio_inc_votes_percand = np.nan
                                     
        if "新人" in status_kind_l:    
            ratio_new_votes = status_votes.loc["新人"]/sta_votes
            if "新人" not in status_nv_kind_l:                    
                ratio_new_votes_percand = ratio_new_votes/status_ncand.loc["新人"]
            else:
                ratio_new_votes_percand = ratio_new_votes/(status_ncand.loc["新人"] - status_no_voting.loc["新人"])
        else:
            ratio_new_votes = np.nan
            ratio_new_votes_percand = np.nan
    
        if "元職" in status_kind_l:    
            ratio_form_votes = status_votes.loc["元職"]/sta_votes
            if "元職" not in status_nv_kind_l:                    
                ratio_form_votes_percand = ratio_form_votes/status_ncand.loc["元職"]
            else:
                ratio_form_votes_percand = ratio_form_votes/(status_ncand.loc["元職"] - status_no_voting.loc["元職"])
        else:
            ratio_form_votes = np.nan
            ratio_form_votes_percand = np.nan
    else:
        ratio_inc_votes = np.nan
        ratio_inc_votes_percand = np.nan
        ratio_new_votes = np.nan
        ratio_new_votes_percand = np.nan
        ratio_form_votes = np.nan
        ratio_form_votes_percand = np.nan
    

    #選挙ごとの総有効得票数
    all_votes = target_df["n_votes"].sum()


    #選挙ごとの政党数
    n_circles = target_df.groupby("circle").size().size
                
    #ここまでの変数をリスト化
    calculates_l = [ele_ymd,n_districts,n_cand_data,int(n_wins_data),compe_rate_data,no_voting_ratio_win,no_voting_ratio_districts,minasi_nv_ratio_districts,ratio_women_cand,ratio_women_wins,ratio_inc_cand,ratio_new_cand,ratio_form_cand,ratio_inc_wins,ratio_new_wins,ratio_form_wins,ratio_inc_votes,ratio_new_votes,ratio_form_votes,ratio_inc_votes_percand,ratio_new_votes_percand,ratio_form_votes_percand,all_votes,n_circles] + age_stats_cand + age_stats_wins

    return calculates_l


def circle_info_all_eles(pref_1,asitis_df):
    
    #ele_ymd_l = asitis_df["ele_ymd"].values
    #target_df = pref_1[pref_1["ele_ymd"] == ele_ymd_l[ele_num]]
    
    #政党情報に欠損値が1つでもある選挙は除外
    no_nan = pref_1.groupby("ele_ymd").apply(lambda x:x.circle.isnull().any()==False)
    no_nan = no_nan[no_nan == True]
    pref_1 = pref_1[pref_1["ele_ymd"].isin(list(no_nan.keys()))] #欠損無し選挙名リストに入っていない選挙の候補者を除外
    
    #選挙ごとの政党別得票数
    grouped = pref_1.groupby(["ele_ymd","circle"])["n_votes"].apply(pd.Series.sum,skipna=False) #選挙別、政党別得票数の Series
    rowele_df = grouped.unstack(level=1) #各政党を列にした選挙別の df
    rowele_df["sum_v"] = rowele_df.sum(axis=1) #合計得票数
    
    #選挙ごとの政党別得票率
    voteshare_df = rowele_df.apply(lambda x:x/x.sum_v,axis=1)
    
    #選挙ごとの政党別立候補者数
    n_cand_df = pref_1.groupby(["ele_ymd","circle"])["id"].count().unstack(level=1)
    
    
    #選挙ごとの政党別候補1人当たり平均得票率
    voteshare_ave_df = voteshare_df.iloc[:,:-1]/n_cand_df
    
    #選挙ごとの政党別当選者数
    n_wins_df = pref_1.groupby(["ele_ymd","circle"])["win"].sum().unstack(level=1) 
    n_wins_df = n_cand_df - (n_cand_df.fillna(0) - n_wins_df.fillna(0)) #全員落選時にnanではなく0と表示されるように工夫
    
    #変数名変更
    rowele_df.loc["政党名"] = rowele_df.columns
    voteshare_df.loc["政党名"] = voteshare_df.columns
    voteshare_ave_df.loc["政党名"] = voteshare_ave_df.columns
    n_cand_df.loc["政党名"] = n_cand_df.columns
    n_wins_df.loc["政党名"] = n_wins_df.columns
    
    rowele_df.columns = ["得票数_" + i for i in list(rowele_df.columns)]
    voteshare_df.columns = ["得票率_" + i for i in list(voteshare_df.columns)]
    voteshare_ave_df.columns = ["一人あたり得票率_" + i for i in list(voteshare_ave_df.columns)]
    n_cand_df.columns = ["立候補者数_" + i for i in list(n_cand_df.columns)]
    n_wins_df.columns = ["当選者数_" + i for i in list(n_wins_df.columns)]
    
    #concate
    result_df = pd.concat([rowele_df,voteshare_df,voteshare_ave_df,n_cand_df,n_wins_df],axis=1)
    
    return result_df

def built_elec_unit_for_pref(pref_num):
    pref_1 = initial_setting(pref_num)
    asitis_df, ele_ymd_l = asitis_all_eles(pref_1)
    eles = asitis_df.shape[0]
    circle_info_df = circle_info_all_eles(pref_1,asitis_df)
    calculates_des = ["ele_ymd","n_districts","n_cand_data","n_wins_data","compe_rate_data","no_voting_ratio_win","no_voting_ratio_districts","minasi_nv_ratio_districts","ratio_women_cand","ratio_women_wins","ratio_inc_cand","ratio_new_cand","ratio_form_cand","ratio_inc_wins","ratio_new_wins","ratio_form_wins","ratio_inc_votes","ratio_new_votes","ratio_form_votes","ratio_inc_votes_percand","ratio_new_votes_percand","ratio_form_votes_percand","all_votes","n_circles","age_mean_cand","age_std_cand","age_min_cand","age_1q_cand","age_median_cand","age_3q_cand","age_max_cand","age_mean_wins","age_std_wins","age_min_wins","age_1q_wins","age_median_wins","age_3q_wins","age_max_wins"]
    cal_l_l = []
    for i in range(eles):
        cal_l = need_calculates_one_ele(pref_1,ele_ymd_l,i)
        cal_l_l.append(cal_l)
    cal_df = pd.DataFrame(cal_l_l,columns=calculates_des)
    cal_df.index = cal_df["ele_ymd"]
    elec_df = pd.concat([asitis_df,cal_df,circle_info_df],axis=1)
    elec_df.to_csv("elec_unit_data/pref_"+str(pref_num)+"_gikai_elections.csv")
    
if __name__ == '__main__':
    for pref_id in range(1,48):
        built_elec_unit_for_pref(pref_id)