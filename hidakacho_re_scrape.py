from urllib import request
from bs4 import BeautifulSoup
import pandas as pd
import numpy as np
import csv
import time


def initial_set(csv_name):
    
    #global driver
    global inconsistent_l
    
    inconsistent_l = []
    #driver = webdriver.Chrome(executable_path="C:\Program Files\chromedriver")
    
    variables_list = ["ele_ymd","election","prefecture","municipality","district","name_kanji","name_kana","age","gen","status","job","circle","win","n_votes","voting_ymd","year","month","day","kokuji_ymd","e_voting_rate","e_seats_target","e_n_candidates","e_competitive_ratio","e_all_voter","e_male_all_voter","e_female_all_voter","e_change_all_voter","e_reason","e_pre_v_rate","e_pre_seats_t","e_pre_n_cand","e_pre_compe_rate","d_voting_rate","d_seats_target","d_n_candidates","d_competitive_ratio","d_all_voter","d_male_all_voter","d_female_all_voter","d_change_all_voter","d_reason","d_pre_v_rate","d_pre_seats_t","d_pre_n_cand","d_pre_compe_rate"]
    
    write_csv_firstrow(csv_name,variables_list)
    

def move_page(url_str):
    #driver.get(url_str)
    #element = driver.find_element_by_class_name("m_senkyo_local_list_right")
    #html = driver.page_source.encode('utf-8')
    #soup = BeautifulSoup(html, 'html.parser')
    response = request.urlopen(url_str)
    soup = BeautifulSoup(response)
    response.close()
    return soup


def str_find(str_all,str_pati):
    if str_all.find(str_pati) == -1:
        print("Error!",str_all,"にお探しの文字",str_pati,"は見つかりませんよ")
        return np.nan
    else:
        return str_all.find(str_pati)
    

def write_csv_firstrow(csv_name,data_l):
    with open(csv_name, 'w', newline='',encoding='UTF-8') as file:
        writer = csv.writer(file,delimiter=',')
        writer.writerow(data_l)
        
def write_csv_rows(csv_name,data_l_l):
    with open(csv_name, 'a', newline='',encoding='UTF-8') as file:
        writer = csv.writer(file,delimiter=',')
        writer.writerows(data_l_l)
    

def get_elections():
    print("elections of :","日高町")
    
    global soup
    soup = move_page("https://go2senkyo.com/local/jichitai/200/gikai") 
        
    found_url = soup.find_all("td", {"class": "left"}) #classで抜き出す部分を指定,url
    url_muni_l = [found_url[i].contents[0].get('href') for i in range(len(found_url))]
    return url_muni_l
    

def collect_basic_info():
    ele_name_ymd = soup.find("h1",{"class":"p_local_senkyo_ttl column_ttl"}).text.replace("\n","").replace(" ","")
    try:
        ele_name = ele_name_ymd[:str_find(ele_name_ymd,"挙")+1]
    except:
        ele_name = ele_name_ymd
    pref_name = soup.find("p",{"class":"column_ttl_small"}).text
    muni_name = "日高町"
    base_inf_l = [ele_name_ymd, ele_name, pref_name, muni_name]
    return base_inf_l


def collect_ele_or_dist_lv(lv_type):
    ### find and make election_level data
    election_data = [i.text for i in soup.select("table.m_senkyo_data > tbody > tr > td")]  
    election_data = [i.replace("\n","").replace(" ","").replace(",","").replace("千円","000") for i in election_data]
    #### 選挙レベルデータの description(変数名) 
    election_des = [i.text.replace("\n","").replace(" ","") for i in soup.select("table.m_senkyo_data > tbody > tr > th")]

    #### components of ele_lv_data and dist_lv_data
    ##### n_cand, n_seet
    if "定数/候補者数" in election_des:
        seat_cand = election_data[election_des.index("定数/候補者数")]
        try:
            n_seat = int(seat_cand[:str_find(seat_cand,"/")])
        except:
            n_seat = np.nan
        try:
            n_cand = int(seat_cand[str_find(seat_cand,"/")+1:])
        except:
            n_cand = np.nan
        try:
            compe_rate = n_cand/n_seat
        except:
            compe_rate = np.nan
    else:
        n_seat = np.nan
        n_cand = np.nan
        compe_rate = np.nan
        
    ##### about number of voters
    if "有権者数" in election_des:
        voters = election_data[election_des.index("有権者数")]
        try:
            n_yukensya = int(voters[:str_find(voters,"人")])
        except:
            n_yukensya = np.nan
        try:
            d_yukensya = int(voters[str_find(voters,"り")+1:str_find(voters,"男")-1]) if "前回" in voters else np.nan
        except:
            d_yukensya = np.nan
        try:
            male_yukensya = int(voters[str_find(voters,"男")+2:str_find(voters,"女")-1])
        except:
            male_yukensya = np.nan
        try:
            fema_yukensya = int(voters[str_find(voters,"女")+2:-1])
        except:
            fema_yukensya = np.nan
        male_yukensya = np.nan if male_yukensya == 0 else male_yukensya
        fema_yukensya = np.nan if fema_yukensya == 0 else fema_yukensya
    else:
        n_yukensya = np.nan
        d_yukensya = np.nan
        male_yukensya = np.nan
        fema_yukensya = np.nan
    
    ##### vote_rate
    if "投票率" in election_des:
        vote_rate = election_data[election_des.index("投票率")]
        if "%" in vote_rate:
            vote_rate = vote_rate[:str_find(vote_rate,"%")]
            try:
                vote_rate = np.nan if vote_rate == "-" else float(vote_rate)
            except:
                vote_rate = np.nan
        elif "％" in vote_rate:
            vote_rate = vote_rate[:str_find(vote_rate,"％")]
            try:
                vote_rate = np.nan if vote_rate == "-" else float(vote_rate)
            except:
                vote_rate = np.nan
        else:
            pass

    else:
        vote_rate = np.nan
        
    ##### reason
    if "事由・ポイント" in election_des:
        reason = election_data[election_des.index("事由・ポイント")]
    else:
        reason = np.nan

    ##### about previous election
    if "前回投票率" in election_des:
        vote_rate_pre = election_data[election_des.index("前回投票率")]
        if "%" in vote_rate_pre:
            vote_rate_pre = vote_rate_pre[:str_find(vote_rate_pre,"%")]
            vote_rate_pre = np.nan if vote_rate_pre == "-" else float(vote_rate_pre)
        elif "％" in vote_rate_pre:
            vote_rate_pre = vote_rate_pre[:str_find(vote_rate_pre,"％")]
            vote_rate_pre = np.nan if vote_rate_pre == "-" else float(vote_rate_pre)
        else:
            pass 
    else:
        vote_rate_pre = np.nan

    if "前回の候補者数/定数" in election_des:
        pre_seat_cand = election_data[election_des.index("前回の候補者数/定数")]
        try:
            n_seat_pre = int(pre_seat_cand[:str_find(pre_seat_cand,"/")])
        except:
            n_seat_pre = np.nan
        try:
            n_cand_pre = int(pre_seat_cand[str_find(pre_seat_cand,"/")+1:])
        except:
            n_cand_pre = np.nan
    else:
        n_seat_pre = np.nan
        n_cand_pre = np.nan

    if "前回倍率" in election_des:
        pre_compe_rate = election_data[election_des.index("前回倍率")]
        if "％" in pre_compe_rate:
            try:
                pre_compe_rate = float(pre_compe_rate[:str_find(pre_compe_rate,"％")])
            except:
                pre_compe_rate = np.nan
        elif "%" in pre_compe_rate:
            try:
                pre_compe_rate = float(pre_compe_rate[:str_find(pre_compe_rate,"%")])
            except:
                pre_compe_rate = np.nan
        else:
            try:
                pre_compe_rate = float(pre_compe_rate)
            except:
                pre_compe_rate = np.nan     
    else:
        pre_compe_rate = np.nan
    
    print("level:",lv_type)
    
    #### components of only ele_lv
    if lv_type == "election":
        ##### y_m_d
        if "投票日" in election_des:
            y_m_d = election_data[election_des.index("投票日")]
            try:
                year = int(y_m_d[:str_find(y_m_d,"年")])
            except:
                year = np.nan
            try:
                month = int(y_m_d[str_find(y_m_d,"年")+1:str_find(y_m_d,"月")])
            except:
                month = np.nan
            try:
                day = int(y_m_d[str_find(y_m_d,"月")+1:str_find(y_m_d,"日")])
            except:
                day = np.nan
            try:
                vote_ymd = y_m_d.replace("年","").replace("月","").replace("日","")
            except:
                vote_ymd = y_m_d
        else:
            year = np.nan
            month = np.nan
            day = np.nan
            vote_ymd = np.nan

        ##### kokuji_date
        if "告示日" in election_des:
            kokuji = election_data[election_des.index("告示日")]
            try:
                kokuji = kokuji.replace("年","").replace("月","").replace("日","")
            except:
                pass
        else:
            kokuji = np.nan
        
        elec_data_l = [vote_ymd,year,month,day,kokuji,vote_rate,n_seat,n_cand,compe_rate,n_yukensya,male_yukensya,fema_yukensya,d_yukensya,reason,vote_rate_pre,n_seat_pre,n_cand_pre,pre_compe_rate]
        return elec_data_l
    
    elif lv_type == "district":
        dist_data_l = [vote_rate,n_seat,n_cand,compe_rate,n_yukensya,male_yukensya,fema_yukensya,d_yukensya,reason,vote_rate_pre,n_seat_pre,n_cand_pre,pre_compe_rate]
        return dist_data_l
    
    else:
        print("Error! please set lv_type 'election' or 'district'")
        return None
    
def collect_cand_lv(base_inf_l,district,elec_data_l,dist_data_l):
    global inconsistent_l
    
    cand_names = soup.find_all("h2",{"class":"m_senkyo_result_data_ttl"})
    job_l = soup.find_all("p",{"class":"m_senkyo_result_data_para small"})
    age_gen_inc_l = list(filter(lambda x: x not in job_l,soup.find_all("p",{"class":"m_senkyo_result_data_para"})))
    win_nvote_l = soup.find_all("td",{"class":"left"})
    circle_l = [i.text for i in soup.find_all("p",{"class":"m_senkyo_result_data_circle"})]

    ### make candidate data
    if (len(cand_names) == len(job_l) == len(age_gen_inc_l) == len(win_nvote_l) == len(win_nvote_l)) == True:
        
        if (len(circle_l) == len(cand_names)) == True:
            print(district,"columns of cand data: consistent")
            
            id_lv_data_l_l = []
            
            for cand_id in range(len(cand_names)):
                ##### names
                try:
                    kanji = cand_names[cand_id].contents[1].contents[0].replace("\n","").replace("\t","")
                except:
                    kanji = np.nan
                try:
                    kana = cand_names[cand_id].contents[1].contents[1].text
                except:
                    kana = np.nan

                ##### age, gen, inc
                age_gen_inc = age_gen_inc_l[cand_id].text
                try:
                    age = int(age_gen_inc[:str_find(age_gen_inc,"(")].replace("歳",""))
                except:
                    age = np.nan
                try:
                    gen = age_gen_inc[str_find(age_gen_inc,"(")+1]
                except:
                    gen = np.nan
                try:
                    inc = age_gen_inc[str_find(age_gen_inc,"(")+3:].replace(" ","")
                except:
                    inc = np.nan
                job = job_l[cand_id].text

                #### win, number of votes
                win = "red" in str(soup.find_all("td",{"class":"left"})[cand_id])
                try:
                    vote = float(soup.find_all("td",{"class":"right"})
                        [cand_id].text.replace("\n","").replace("票","").replace(",",""))
                except: 
                    vote = np.nan
                circle = circle_l[cand_id]
                
                #### append to over_all_list
                id_lv_data_l = base_inf_l + [district] + [kanji,kana,age,gen,inc,job,circle,win,vote] + elec_data_l + dist_data_l
                
                id_lv_data_l_l.append(id_lv_data_l)
                
            return id_lv_data_l_l
        
        else:
            print(district,"cols of cand data: inconsistent for circle",len(cand_names),len(job_l),len(age_gen_inc_l),len(win_nvote_l),len(win_nvote_l),len(circle_l))
               
            inconsistent_l.append([base_inf_l[0],district,[len(cand_names),len(job_l),len(age_gen_inc_l),len(win_nvote_l),len(win_nvote_l),len(circle_l)]])
            
            id_lv_data_l_l = []
            
            for cand_id in range(len(cand_names)):
                ##### names
                try:
                    kanji = cand_names[cand_id].contents[1].contents[0].replace("\n","").replace("\t","")
                except:
                    kanji = np.nan
                try:
                    kana = cand_names[cand_id].contents[1].contents[1].text
                except:
                    kana = np.nan

                ##### age, gen, inc
                age_gen_inc = age_gen_inc_l[cand_id].text
                try:
                    age = int(age_gen_inc[:str_find(age_gen_inc,"(")].replace("歳",""))
                except:
                    age = np.nan
                try:
                    gen = age_gen_inc[str_find(age_gen_inc,"(")+1]
                except:
                    gen = np.nan
                try:
                    inc = age_gen_inc[str_find(age_gen_inc,"(")+3:].replace(" ","")
                except:
                    inc = np.nan
                job = job_l[cand_id].text

                #### win, number of votes
                win = "red" in str(soup.find_all("td",{"class":"left"})[cand_id])
                try:
                    vote = float(soup.find_all("td",{"class":"right"})
                        [cand_id].text.replace("\n","").replace("票","").replace(",",""))
                except: 
                    vote = np.nan
                    
                circle = np.nan
                
                id_lv_data_l = base_inf_l + [district] + [kanji,kana,age,gen,inc,job,circle,win,vote] + elec_data_l + dist_data_l
                
                id_lv_data_l_l.append(id_lv_data_l)
                
            return id_lv_data_l_l
    
    else:
        
        print(district,"cols of cand data: inconsistent for all",len(cand_names),len(job_l),len(age_gen_inc_l),len(win_nvote_l),len(win_nvote_l),len(circle_l))
        
        inconsistent_l.append([base_inf_l[0],district,[len(cand_names),len(job_l),len(age_gen_inc_l),len(win_nvote_l),len(win_nvote_l),len(circle_l)]])
        
        id_lv_data_l_l = []
        
        for cand_id in range(len(cand_names)):
            ##### names
            try:
                kanji = cand_names[cand_id].contents[1].contents[0].replace("\n","").replace("\t","")
            except:
                kanji = np.nan
            try:
                kana = cand_names[cand_id].contents[1].contents[1].text
            except:
                kana = np.nan
                
            id_lv_data_l = base_inf_l + [district] + [kanji,kana] +[np.nan]*7 + elec_data_l + dist_data_l
            id_lv_data_l_l.append(id_lv_data_l)
        
        return id_lv_data_l_l

    

def make_data_for_ele(csv_name):
    
    ### 基本データの収集
    global soup
    base_inf_l = collect_basic_info()
    
    ### 判定(実施済み選挙 or 未実施)
    #### 選挙はすでに実施された　→　データ収集を実行
    if (("予想" not in base_inf_l[0]) and ("任期満了" not in base_inf_l[0])) == True:
        
        ##### 選挙レベルデータの収集
        elec_data_l = collect_ele_or_dist_lv(lv_type="election")
    
        ### 判定(単一 or 複数選挙区)
        senkyokus = soup.find_all("div",{"class":"m_senkyo_local_link_left"})
        senkyoku_name = [i.text for i in senkyokus]
        senkyoku_test = [True for i in senkyoku_name] ## 変更点（日高町）

        ### 選挙区レベルデータと候補者レベルデータの収集
        #### 複数選挙区
        if (True in senkyoku_test) == True:
            print(base_inf_l[0],"multiple districts")

            ##### 選挙区ごとの URL を取得
            senkyoku_urls = [i.parent.get("href") for i in senkyokus]
            print(senkyoku_name)

            ##### 選挙区ごとループしてデータ収集 
            for i in range(len(senkyoku_name)):
                soup = move_page(senkyoku_urls[i])
                district = senkyoku_name[i] + str(i+1)
                dist_data_l = collect_ele_or_dist_lv(lv_type="district")
                id_lv_data_l_l = collect_cand_lv(base_inf_l,district,elec_data_l,dist_data_l)

                ##### csvに貯めこむ
                write_csv_rows(csv_name,data_l_l=id_lv_data_l_l)    

        ## 単一選挙区  
        else:
            print(base_inf_l[0],"single districts")

            district = "日高町" #選挙区名は市町村名
            dist_data_l = elec_data_l[5:] #選挙区レベルデータは選挙レベルと同一
            id_lv_data_l_l = collect_cand_lv(base_inf_l,district,elec_data_l,dist_data_l)

            ##### csvに貯めこむ
            write_csv_rows(csv_name,data_l_l=id_lv_data_l_l)
    
    #### 選挙は未実施　→　データ収集を実行しない
    else:
        pass  
    
    
### 市町村ごとの全選挙のデータ作成       
def make_data_for_muni(csv_name):
    url_muni_l = get_elections()
    for url_ele in url_muni_l:
        global soup
        soup = move_page(url_ele)
        make_data_for_ele(csv_name)

### データ作成
def make_data():
    start = time.time()
    initial_set("gikai_hidakacho.csv")
    make_data_for_muni("gikai_hidakacho.csv")
    global inconsistent_l
    write_csv_rows("omitted_l_hidaka.csv",inconsistent_l)
    print("Complete!:hidaka")
    

#選挙レベルへの変換

import warnings
warnings.simplefilter('ignore')

def initial_setting():
    pref_1 = pd.read_csv("gikai_hidakacho.csv")
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

def built_elec_unit_for_pref():
    pref_1 = initial_setting()
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
    elec_df.to_csv("hidakacho_gikai_elections.csv")
    
built_elec_unit_for_pref()
