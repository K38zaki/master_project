import numpy as np
import pandas as pd
import warnings
warnings.simplefilter('ignore')

def initial_setting(pref_num):
    pref_1 = pd.read_csv("original_candidates_data/gikai_pref_"+str(pref_num)+".csv")
    #pref_1 = pd.read_csv("original_candidates_data/gikai_hidakacho.csv")
    pref_1["id"] = pref_1.index
    ele_ymd_l = pref_1["ele_ymd"].unique()
    #circle_base = pd.DataFrame(pref_1["circle"].unique(),columns=["circle"])
    return pref_1,ele_ymd_l #,circle_base

def need_calculates_one_ele(pref_1,ele_ymd_l,ele_num):
    #選挙名+ymd
    ele_ymd = ele_ymd_l[ele_num]
    
    #対象選挙のみのdfを設定
    target_df = pref_1[pref_1["ele_ymd"] == ele_ymd_l[ele_num]]

    #都道府県名
    prefecture = target_df.iloc[0]["prefecture"]

    #欠損値判定
    #基本変数
    needed_variables_l = ["district","id","win","age","gen","status","circle"]
    #候補者の基本変数に欠損があるかどうか
    nan_bools = target_df[needed_variables_l].isnull().any()
    #当選者の基本変数に欠損があるかどうか
    nan_bools_win = target_df[target_df["win"] == True][needed_variables_l].isnull().any()
    
    
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
    #無投票で決定の選挙区の割合
    no_voting_ratio_districts = (target_df.groupby("district").first()["no_vote"] == 1).mean()
    
    #無投票当選者以外の得票数に欠損があるかどうかの判定
    nan_bools_votes = target_df[target_df["no_vote"] == 0]["n_votes"].isnull().any()

    #選挙ごとの立候補者数に占める現職・新人・元職割合
    if nan_bools["status"] == False:
        status_ncand = target_df.groupby("status").size()
        statuses = sum(status_ncand)
        status_kind_l = list(target_df.groupby("status").groups.keys())
        
        if "現職" in status_kind_l:
            ratio_inc_cand_true = status_ncand.loc["現職"]/statuses
        else:
            ratio_inc_cand_true = 0

        if "前職" in status_kind_l:
            ratio_pre_cand = status_ncand.loc["前職"]/statuses
        else:
            ratio_pre_cand = 0

        ratio_inc_cand = ratio_inc_cand_true + ratio_pre_cand # 現職と前職の合計が「現職」
        
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
            ratio_inc_wins_true = status_nwins.loc["現職"]/sta_wins
        else:
            ratio_inc_wins_true = 0

        if "前職" in status_w_kind_l:
            ratio_pre_wins = status_nwins.loc["前職"]/sta_wins
        else:
            ratio_pre_wins = 0

        ratio_inc_wins = ratio_inc_wins_true + ratio_pre_wins # 現職と前職の合計が「現職」

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
        
    
    #選挙ごとの現職・前職・新人・元職得票率
    #選挙ごとの現職・前職・新人・元職の(無投票当選候補を除く)候補1人当たり平均得票率
    ## 選挙戦がどこかの選挙区で発生し,かつ得票数に欠損値が無く,かつ政党情報に欠損値が無い場合のみ計算、それ以外はnan
    if (no_voting_ratio_districts != 1)&(nan_bools_votes == False)&(nan_bools["status"] == False):
        status_votes = target_df.groupby("status").sum()["n_votes"]
        sta_votes = sum(status_votes)
        status_no_voting = target_df[target_df["no_vote"] == 1].groupby("status").size()
        status_nv_kind_l = list(status_no_voting.keys())
                                     
        if "現職" in status_kind_l:
            n_inc_votes_true = status_votes.loc["現職"]
            if "現職" not in status_nv_kind_l:
                n_b_inc_cand_true = status_votes.loc["現職"] #選挙戦を戦った現職候補の数
            else:
                n_b_inc_cand_true = status_ncand.loc["現職"] - status_no_voting.loc["現職"] #選挙戦を戦った現職候補の数
        else:
            n_inc_votes_true = 0
            n_b_inc_cand_true = 0

        if "前職" in status_kind_l:
            n_pre_votes_true = status_votes.loc["前職"]
            if "前職" not in status_nv_kind_l:
                n_b_pre_cand_true = status_votes.loc["前職"] #選挙戦を戦った前職候補の数
            else:
                n_b_pre_cand_true = status_ncand.loc["前職"] - status_no_voting.loc["前職"] #選挙戦を戦った前職候補の数
        else:
            n_pre_votes_true = 0
            n_b_pre_cand_true = 0

        # 現職・前職で選挙戦を戦った人が存在する場合に合計値で得票率・候補1人当たり平均得票率を計算
        if (n_b_inc_cand_true + n_b_pre_cand_true) != 0:
            ratio_inc_votes = (n_inc_votes_true + n_pre_votes_true) / sta_votes
            ratio_inc_votes_percand = ratio_inc_votes / (n_b_inc_cand_true + n_b_pre_cand_true)
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

                
    #ここまでの変数をリスト化
    calculates_l = [prefecture,ele_ymd,ratio_inc_cand,ratio_new_cand,ratio_form_cand,ratio_inc_wins,ratio_new_wins,ratio_form_wins,\
        ratio_inc_votes,ratio_new_votes,ratio_form_votes,ratio_inc_votes_percand,ratio_new_votes_percand,ratio_form_votes_percand,all_votes]

    return calculates_l

def built_elec_unit_for_pref(pref_num):
    pref_1, ele_ymd_l = initial_setting(pref_num)
    eles = len(ele_ymd_l)
    calculates_des = ["prefecture","ele_ymd","ratio_inc_cand","ratio_new_cand","ratio_form_cand","ratio_inc_wins","ratio_new_wins","ratio_form_wins","ratio_inc_votes","ratio_new_votes","ratio_form_votes","ratio_inc_votes_percand","ratio_new_votes_percand","ratio_form_votes_percand","all_votes"]
    cal_l_l = []
    for i in range(eles):
        cal_l = need_calculates_one_ele(pref_1,ele_ymd_l,i)
        cal_l_l.append(cal_l)
    cal_df = pd.DataFrame(cal_l_l,columns=calculates_des)
    cal_df.index = cal_df["ele_ymd"]
    cal_df.to_csv("correct_incumbent/pref_"+str(pref_num)+"_gikai_correct_inc.csv")
    #cal_df.to_csv("correct_incumbent/hidakacho_gikai_correct_inc.csv")

built_elec_unit_for_pref(1)

for pref_id in range(2,48):
    built_elec_unit_for_pref(pref_id)

built_elec_unit_for_pref()

