
import numpy as np
from numpy.core.numeric import Inf
import pandas as pd 
import warnings
warnings.simplefilter('ignore')


# 現職得票の再定義

def initial_setting(pref_num):
    if pref_num != "hidaka":
        pref_1 = pd.read_csv("original_candidates_data/gikai_pref_"+str(pref_num)+".csv")
    else:
        #日高町モード
        pref_1 = pd.read_csv("original_candidates_data/gikai_hidakacho.csv")
    
    print(pref_1.isnull().sum()[["age","status","n_votes","d_seats_target","d_voting_rate"]])
    print((pref_1[["age","status","n_votes","d_seats_target","d_voting_rate"]] == 0).sum())
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

    #選挙ごとの立候補者数に占める現職・新人・元職人数・割合
    if nan_bools["status"] == False:
        status_ncand = target_df.groupby("status").size()
        statuses = sum(status_ncand)
        status_kind_l = list(target_df.groupby("status").groups.keys())
        
        if "現職" in status_kind_l:
            ncand_k_inc = status_ncand.loc["現職"]
            ratio_k_inc_cand_true = status_ncand.loc["現職"]/statuses
        else:
            ncand_k_inc = 0
            ratio_k_inc_cand_true = 0

        if "前職" in status_kind_l:
            ncand_pre = status_ncand.loc["前職"]
            ratio_pre_cand = status_ncand.loc["前職"]/statuses
        else:
            ncand_pre = 0
            ratio_pre_cand = 0

        ncand_inc = ncand_k_inc + ncand_pre
        ratio_inc_cand = ratio_k_inc_cand_true + ratio_pre_cand # 現職と前職の合計が「現職」
        
        if "新人" in status_kind_l:
            ncand_new = status_ncand.loc["新人"]
            ratio_new_cand = status_ncand.loc["新人"]/statuses
        else:
            ncand_new = 0
            ratio_new_cand = 0
     
        if "元職" in status_kind_l:
            ncand_form = status_ncand.loc["元職"]
            ratio_form_cand = status_ncand.loc["元職"]/statuses
        else:
            ncand_form = 0
            ratio_form_cand = 0 

    else:
        ncand_inc = np.nan
        ratio_inc_cand = np.nan
        ncand_new = np.nan
        ratio_new_cand = np.nan
        ncand_form = np.nan
        ratio_form_cand = np.nan    

    #選挙ごとの当選者数に占める現職・新人・元職割合
    if nan_bools_win["status"] == False:
        status_nwins = target_df.groupby("status").sum()["win"]
        sta_wins = sum(status_nwins)
        status_w_kind_l = list(target_df[target_df["win"] == True].groupby("status").groups.keys())
                                     
        if "現職" in status_w_kind_l:
            nwins_k_inc = status_nwins.loc["現職"]
            ratio_k_inc_wins_true = status_nwins.loc["現職"]/sta_wins
        else:
            nwins_k_inc = 0
            ratio_k_inc_wins_true = 0

        if "前職" in status_w_kind_l:
            nwins_pre = status_nwins.loc["前職"]
            ratio_pre_wins = status_nwins.loc["前職"]/sta_wins
        else:
            nwins_pre = 0
            ratio_pre_wins = 0

        nwins_inc = nwins_k_inc + nwins_pre
        ratio_inc_wins = ratio_k_inc_wins_true + ratio_pre_wins # 現職と前職の合計が「現職」

        if "新人" in status_w_kind_l:
            nwins_new = status_nwins.loc["新人"]
            ratio_new_wins = status_nwins.loc["新人"]/sta_wins
        else:
            nwins_new = 0
            ratio_new_wins = 0
        
        if "元職" in status_w_kind_l:
            nwins_form = status_nwins.loc["元職"]
            ratio_form_wins = status_nwins.loc["元職"]/sta_wins
        else:
            nwins_form = 0
            ratio_form_wins = 0
    else:
        nwins_inc = np.nan
        ratio_inc_wins = np.nan
        nwins_new = np.nan
        ratio_new_wins = np.nan
        nwins_form = np.nan
        ratio_form_wins = np.nan 
        
    
    #選挙ごとの現職・前職・新人・元職得票率
    #選挙ごとの現職・前職・新人・元職の(無投票当選候補を除く)候補1人当たり平均得票率
    ## 選挙戦がどこかの選挙区で発生し,かつ得票数に欠損値が無く,かつステータス情報に欠損値が無い場合のみ計算、それ以外はnan
    if (no_voting_ratio_districts != 1)&(nan_bools_votes == False)&(nan_bools["status"] == False):
        status_votes = target_df.groupby("status").sum()["n_votes"]
        sta_votes = sum(status_votes)
        status_no_voting = target_df[target_df["no_vote"] == 1].groupby("status").size()
        status_nv_kind_l = list(status_no_voting.keys())
                                     
        if "現職" in status_kind_l:
            n_k_inc_votes_true = status_votes.loc["現職"]
            if "現職" not in status_nv_kind_l:
                n_b_k_inc_cand_true = status_ncand.loc["現職"] #選挙戦を戦った現職候補の数
            else:
                n_b_k_inc_cand_true = status_ncand.loc["現職"] - status_no_voting.loc["現職"] #選挙戦を戦った現職候補の数 
        else:
            n_k_inc_votes_true = 0
            n_b_k_inc_cand_true = 0

        if "前職" in status_kind_l:
            n_pre_votes_true = status_votes.loc["前職"]
            if "前職" not in status_nv_kind_l:
                n_b_pre_cand_true = status_ncand.loc["前職"] #選挙戦を戦った前職候補の数
            else:
                n_b_pre_cand_true = status_ncand.loc["前職"] - status_no_voting.loc["前職"] #選挙戦を戦った前職候補の数
        else:
            n_pre_votes_true = 0
            n_b_pre_cand_true = 0

        n_inc_votes_true = n_k_inc_votes_true + n_pre_votes_true
        n_b_inc_cand_true = n_b_k_inc_cand_true + n_b_pre_cand_true
        

        # 現職・前職で選挙戦を戦った人が存在する場合に合計値で得票率・候補1人当たり平均得票率を計算
        if n_b_inc_cand_true != 0:
            ratio_inc_votes = n_inc_votes_true / sta_votes
            ratio_inc_votes_percand = ratio_inc_votes / n_b_inc_cand_true
        else:
            ratio_inc_votes = np.nan
            ratio_inc_votes_percand = np.nan
                                     
        if "新人" in status_kind_l:
            n_new_votes_true = status_votes.loc["新人"]   
            ratio_new_votes = n_new_votes_true / sta_votes
            if "新人" not in status_nv_kind_l:                    
                n_b_new_cand_true = status_ncand.loc["新人"]
            else:
                n_b_new_cand_true = status_ncand.loc["新人"] - status_no_voting.loc["新人"]
            ratio_new_votes_percand = ratio_new_votes / n_b_new_cand_true
        else:
            n_new_votes_true = 0
            n_b_new_cand_true = 0
            ratio_new_votes = np.nan
            ratio_new_votes_percand = np.nan
    
        if "元職" in status_kind_l:
            n_form_votes_true = status_votes.loc["元職"]    
            ratio_form_votes = n_form_votes_true / sta_votes
            if "元職" not in status_nv_kind_l:                    
                n_b_form_cand_true = status_ncand.loc["元職"]
            else:
                n_b_form_cand_true = status_ncand.loc["元職"] - status_no_voting.loc["元職"]
            ratio_form_votes_percand = ratio_form_votes / n_b_form_cand_true
        else:
            n_form_votes_true = 0
            n_b_form_cand_true = 0
            ratio_form_votes = np.nan
            ratio_form_votes_percand = np.nan

        n_notinc_votes_true = n_new_votes_true + n_form_votes_true
        n_b_notinc_cand_true = n_b_new_cand_true + n_b_form_cand_true

        # 新人・元職で選挙戦を戦った人が存在する場合に合計値で得票率・候補1人当たり平均得票率を計算
        if n_b_notinc_cand_true != 0:
            ratio_notinc_votes = n_notinc_votes_true / sta_votes
            ratio_notinc_votes_percand = ratio_notinc_votes / n_b_notinc_cand_true
        else:
            ratio_notinc_votes = np.nan
            ratio_notinc_votes_percand = np.nan


    else:
        if no_voting_ratio_districts == 1:
            n_b_inc_cand_true = 0
            n_b_new_cand_true = 0
            n_b_form_cand_true = 0
            n_b_notinc_cand_true = 0
        else:
            n_b_inc_cand_true = np.nan
            n_b_new_cand_true = np.nan
            n_b_form_cand_true = np.nan
            n_b_notinc_cand_true = np.nan

        n_inc_votes_true = np.nan
        ratio_inc_votes = np.nan
        ratio_inc_votes_percand = np.nan

        n_new_votes_true = np.nan
        ratio_new_votes = np.nan
        ratio_new_votes_percand = np.nan

        n_form_votes_true = np.nan
        ratio_form_votes = np.nan
        ratio_form_votes_percand = np.nan

        n_notinc_votes_true = np.nan
        ratio_notinc_votes = np.nan
        ratio_notinc_votes_percand = np.nan
    

    if (no_voting_ratio_districts != 1)&(nan_bools_votes == False):

        #選挙の総有効得票数
        all_votes = target_df["n_votes"].sum()

        #選挙区ごとの総有効得票数
        district_votes = target_df.groupby("district").sum()["n_votes"]

        #選挙区ごとの定数
        district_seats = target_df.groupby("district").first()["d_seats_target"]
        
        #欠損が無い、かつ、定数が0になっていない
        if (district_seats.isnull().any() == False)&((district_seats == 0).any() == False):

            #選挙区ごとの供託金没収ライン
            district_kyoubotsu = ((district_votes/district_seats)/10).reset_index()
            district_kyoubotsu.columns = ["district","kyoubotsu_line"]

            #各候補者にこの情報を追加
            new_tdf = pd.merge(target_df,district_kyoubotsu,how="left",on="district")

            #無投票当選者を除外
            new_tdf = new_tdf[new_tdf["no_vote"] == 0]
            n_battle = new_tdf.shape[0]

            #選挙戦を戦った人の内。供託金没収ラインに満たない人及びその割合
            n_kyo_botsu = (new_tdf["n_votes"] < new_tdf["kyoubotsu_line"]).sum()
            ratio_kyo_botsu = n_kyo_botsu / n_battle
            
        else:
            ratio_kyo_botsu = np.nan
            n_kyo_botsu = np.nan
            n_battle = target_df[target_df["no_vote"] == 0].shape[0]

    elif no_voting_ratio_districts == 1:
        all_votes = np.nan
        ratio_kyo_botsu = np.nan
        n_kyo_botsu = np.nan
        n_battle = 0

    else:
        all_votes = np.nan
        ratio_kyo_botsu = np.nan
        n_kyo_botsu = np.nan
        n_battle = target_df[target_df["no_vote"] == 0].shape[0]

    #ここまでの変数をリスト化
    calculates_l = [prefecture,ele_ymd,
        ncand_inc,ncand_new,ncand_form,ratio_inc_cand,ratio_new_cand,ratio_form_cand,
        nwins_inc,nwins_new,nwins_form,ratio_inc_wins,ratio_new_wins,ratio_form_wins,
        n_b_inc_cand_true,n_b_new_cand_true,n_b_form_cand_true,n_b_notinc_cand_true,
        n_inc_votes_true, n_new_votes_true, n_form_votes_true, n_notinc_votes_true,
        ratio_inc_votes,ratio_new_votes,ratio_form_votes,ratio_notinc_votes,
        ratio_inc_votes_percand,ratio_new_votes_percand,ratio_form_votes_percand,ratio_notinc_votes_percand,
        all_votes,n_battle,n_kyo_botsu,ratio_kyo_botsu]

    return calculates_l

def built_elec_unit_for_pref(pref_num):
    pref_1, ele_ymd_l = initial_setting(pref_num)
    eles = len(ele_ymd_l)
    calculates_des = ["prefecture","ele_ymd",
        "ncand_inc","ncand_new","ncand_form","ratio_inc_cand","ratio_new_cand","ratio_form_cand",
        "nwins_inc","nwins_new","nwins_form","ratio_inc_wins","ratio_new_wins","ratio_form_wins",
        "n_b_inc_cand","n_b_new_cand","n_b_form_cand","n_b_notinc_cand",
        "n_inc_votes","n_new_votes","n_form_votes","n_notinc_votes",
        "ratio_inc_votes","ratio_new_votes","ratio_form_votes","ratio_notinc_votes",
        "ratio_inc_votes_percand","ratio_new_votes_percand","ratio_form_votes_percand","ratio_notinc_votes_percand",
        "all_votes","n_battle","n_forfeit_deposit","ratio_forfeit_deposit"]
    cal_l_l = []
    for i in range(eles):
        cal_l = need_calculates_one_ele(pref_1,ele_ymd_l,i)
        cal_l_l.append(cal_l)
    cal_df = pd.DataFrame(cal_l_l,columns=calculates_des)
    cal_df.index = cal_df["ele_ymd"]
    if pref_num != "hidaka":
        cal_df.to_csv("incumbent_recorrect_and_kyobotsu/pref_"+str(pref_num)+"_gikai_inc_kyobotsu.csv")
    else:
        cal_df.to_csv("incumbent_recorrect_and_kyobotsu/hidakacho_gikai_inc_kyobotsu.csv")


# if __name__ == "__main__":
#     built_elec_unit_for_pref(1)
#     for pref_id in range(2,48):
#         print("done:pref",pref_id)
#         built_elec_unit_for_pref(pref_id)

#     built_elec_unit_for_pref("hidaka")

#     for pref_id in range(1,48):
#         print("pref",pref_id)
#         pref_1 = pd.read_csv("original_candidates_data/gikai_pref_"+str(pref_id)+".csv")
#         print((pref_1["n_votes"] == 0).sum())
#         print((pref_1["n_votes"].isnull()).sum())

#     for pref_id in range(1,48):
#         print("pref",pref_id)
#         pref_1 = pd.read_csv("original_candidates_data/gikai_pref_"+str(pref_id)+".csv")
#         print((pref_1["d_seats_target"] == 0).sum())
#         print((pref_1["d_seats_target"].isnull()).sum())

#     for pref_id in range(1,48):
#         print("pref",pref_id)
#         pref_1 = pd.read_csv("original_candidates_data/gikai_pref_"+str(pref_id)+".csv")
#         print((pref_1["age"] == 0).sum())
#         print((pref_1["age"].isnull()).sum())


## マージ
master = pd.read_csv("master_datas/master_0520_1101.csv",index_col=0)

corrects = pd.concat([pd.read_csv("incumbent_recorrect_and_kyobotsu/pref_"+str(i)+"_gikai_inc_kyobotsu.csv") for i in range(1,48)],axis=0)
corrects
hidaka = pd.read_csv("incumbent_recorrect_and_kyobotsu/hidakacho_gikai_inc_kyobotsu.csv")
hidaka


corrects.insert(0,"ele_ID",corrects["prefecture"]+corrects["ele_ymd"])
hidaka.insert(0,"ele_ID",hidaka["prefecture"]+hidaka["ele_ymd"])

corrects = corrects.reset_index()

hidaka = hidaka.reset_index()

corrects.loc[corrects["ele_ID"].isin(hidaka["ele_ID"].to_list()),:]
corrects[corrects["ele_ID"].str.contains("北海道日高町")]
hidaka
hidaka.iloc[:3,:]
corrects = pd.concat([corrects,hidaka.iloc[:3,:]],axis=0)
corrects[corrects["ele_ID"].str.contains("北海道日高町")]

master
master.loc[:,"ratio_inc_cand":"ratio_form_votes_percand"]
colist = list(master.columns)
colist.index("ratio_inc_cand")
colist.index("ratio_form_votes_percand")
colist[colist.index("ratio_inc_cand"):colist.index("ratio_form_votes_percand")+1]
master = master.drop(colist[colist.index("ratio_inc_cand"):colist.index("ratio_form_votes_percand")+1],axis=1) #元データを除外

corrects = corrects.drop(["index","ele_ymd.1"],axis=1)
corrects[corrects["n_battle"].isnull()]

kari_m = pd.merge(master,corrects,how="left",on="ele_ID")
kari_m[kari_m["n_battle"].isnull()]

kari_m[(kari_m[["ratio_inc_cand","ratio_new_cand","ratio_form_cand"]].sum(axis=1) < 0.999)&(kari_m[["ratio_inc_cand","ratio_new_cand","ratio_form_cand"]].isnull().sum(axis=1) != 3)]
#ステータス別候補者数が欠損でないかつ合計割合が１でないが存在しなくなったので、修正完了

master = kari_m

## 調整済み1人当たり現職得票率　と　1人当たり得票率の比(現職/非現職)の作成

master["adjusted_ave_voteshare_inc"] = master["ratio_inc_votes_percand"] / (master["ratio_inc_votes_percand"] + master["ratio_notinc_votes_percand"])
master["adjusted_ave_voteshare_inc"].hist()

master["ratio_ave_voteshare_inc_notinc"] = master["ratio_inc_votes_percand"] / master["ratio_notinc_votes_percand"]
master[master["ratio_ave_voteshare_inc_notinc"] > 100].loc[:,"ncand_inc":]
master[master["ratio_ave_voteshare_inc_notinc"] > 100].loc[:,'ratio_inc_votes':'ratio_form_votes']
master[master["ratio_ave_voteshare_inc_notinc"] > 50]

master[(master[["ratio_new_votes_percand","ratio_form_votes_percand"]].isnull().sum(axis=1) == 2)&(master["ratio_notinc_votes_percand"].isnull()==False)]
#newとformがnanなのにnotincがnanじゃない　→　1 case
master.loc[(master[["ratio_new_votes_percand","ratio_form_votes_percand"]].isnull().sum(axis=1) == 2)&(master["ratio_notinc_votes_percand"].isnull()==False),["adjusted_ave_voteshare_inc","ratio_ave_voteshare_inc_notinc"]] = np.nan

#得票数が人口を上回っているところ　→　2007年以降は全て得票数のミスみたいなので、nanに
master.loc[(master["all_votes_y"] > master["population"])&(master["year"] > 2006),'ratio_inc_votes':] = np.nan

master.loc[(master["all_votes_x"] > master["population"])&(master["year"] > 2006)]

master["adjusted_ave_voteshare_inc"].hist()
master["ratio_ave_voteshare_inc_notinc"].hist()
#adjuster_ave_voteshare_incの方が扱いやすそう(正規分布っぽい)

#そもそも"compe_rate_adopt"が信用出来ないところ(欠損)は立候補者人数など怪しいので欠損に
master.loc[(master["compe_rate_adopt"].isnull())&(master["n_forfeit_deposit"].isnull()==False)] # 88cases
master.loc[(master["compe_rate_adopt"].isnull())&(master["n_forfeit_deposit"].isnull()==False),"n_forfeit_deposit"] = np.nan

master.loc[(master["compe_rate_adopt"].isnull())&(master["ratio_forfeit_deposit"].isnull()==False)] # 88cases
master.loc[(master["compe_rate_adopt"].isnull())&(master["ratio_forfeit_deposit"].isnull()==False),"ratio_forfeit_deposit"] = np.nan

master.loc[(master["compe_rate_adopt"].isnull())&(master["adjusted_ave_voteshare_inc"].isnull()==False),"adjusted_ave_voteshare_inc"] = np.nan # 152cases

master.loc[(master["compe_rate_adopt"].isnull())&(master["ratio_ave_voteshare_inc_notinc"].isnull()==False),"ratio_ave_voteshare_inc_notinc"] = np.nan # 152cases

master.to_csv("master_datas/master_0520_1115.csv")

pd.read_stata("1111_chuukan.dta")
#stataで上手く読み込めなかったところを修正
master.loc[master["ele_ID"]=="神奈川県横浜市議会議員選挙（2019年04月07日投票）","reason"] = "任期満了"
master.loc[master["ele_ID"]=="神奈川県横浜市議会議員選挙（2019年04月07日投票）","reason"]
master.loc[master["ele_ID"]=="広島県安芸高田市議会議員選挙（2016年11月13日投票）","reason"] = "任期満了"
master.loc[master["ele_ID"]=="広島県安芸高田市議会議員選挙（2016年11月13日投票）","reason"]

master.to_csv("master_datas/master_0520_1115.csv")

#分析用切り出し
first = master.iloc[:,:51]
second = master.iloc[:,2363:]
anal = pd.concat([first,second],axis=1)
anal = anal[(anal["compe_rate_adopt"].isnull()==False)&(anal["nendo"] != 2020)]

anal.to_csv("for_analysis/for_analysis_1115.csv")

