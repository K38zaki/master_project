#from selenium import webdriver

#from selenium.common.exceptions import NoSuchElementException
#from selenium.webdriver.support.ui import Select
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
    
    
def get_municipalities(pref_num):
    global soup
    soup = move_page('https://go2senkyo.com/local/prefecture/' + str(pref_num))
    found_url = soup.select('.m_senkyo_local_list_right') #class で抜き出す部分を指定,url
    found_name = soup.select('.m_senkyo_local_list_left') # classで抜き出す部分を指定,市町村名
    print("consistent name url:",len(found_url) == len(found_name)) #URLの数と市町村名の数の一致を確認

    url_l = []
    for muni_id in range(len(found_url)):
        #found_urlの各要素の「子要素」(urlが入ってる部分)を抜き出し、urlをstrとして取得
        name = found_name[muni_id].contents[1].text
        head_url = found_url[muni_id].contents[1].get('href')
        gikai_url = found_url[muni_id].contents[2].get('href')
        url_l.append([name,head_url,gikai_url])
    return url_l

def get_elections(muni_l,muni_num,elec_type):
    global current_muni
    current_muni = muni_l[muni_num]
    print("elections of :",current_muni[0])
    
    global soup
    if elec_type == "gikai":
        soup = move_page(current_muni[2]) 
    elif elec_type == "head":
        soup = move_page(current_muni[1])
    else:
        print("Error! please set elec_type 'gikai' or 'head'")
        
    found_url = soup.find_all("td", {"class": "left"}) #classで抜き出す部分を指定,url
    url_muni_l = [found_url[i].contents[0].get('href') for i in range(len(found_url))]
    return url_muni_l
    

def collect_basic_info():
    ele_name_ymd = soup.find("h1",{"class":"p_local_senkyo_ttl column_ttl"}).text.replace("\n","").replace(" ","")
    ele_name = ele_name_ymd[:str_find(ele_name_ymd,"挙")+1]
    pref_name = soup.find("p",{"class":"column_ttl_small"}).text
    muni_name = current_muni[0]
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
                kanji = cand_names[cand_id].contents[1].contents[0].replace("\n","").replace("\t","")
                kana = cand_names[cand_id].contents[1].contents[1].text

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
                kanji = cand_names[cand_id].contents[1].contents[0].replace("\n","").replace("\t","")
                kana = cand_names[cand_id].contents[1].contents[1].text

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
            kanji = cand_names[cand_id].contents[1].contents[0].replace("\n","").replace("\t","")
            kana = cand_names[cand_id].contents[1].contents[1].text
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
        senkyoku_test = ["区" in i for i in senkyoku_name]

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
                district = senkyoku_name[i]
                dist_data_l = collect_ele_or_dist_lv(lv_type="district")
                id_lv_data_l_l = collect_cand_lv(base_inf_l,district,elec_data_l,dist_data_l)

                ##### csvに貯めこむ
                write_csv_rows(csv_name,data_l_l=id_lv_data_l_l)    

        ## 単一選挙区  
        else:
            print(base_inf_l[0],"single districts")

            district = current_muni[0] #選挙区名は市町村名
            dist_data_l = elec_data_l[5:] #選挙区レベルデータは選挙レベルと同一
            id_lv_data_l_l = collect_cand_lv(base_inf_l,district,elec_data_l,dist_data_l)

            ##### csvに貯めこむ
            write_csv_rows(csv_name,data_l_l=id_lv_data_l_l)
    
    #### 選挙は未実施　→　データ収集を実行しない
    else:
        pass  
    
    
### 市町村ごとの全選挙のデータ作成       
def make_data_for_muni(muni_l,muni_num,elec_type,csv_name):
    url_muni_l = get_elections(muni_l,muni_num,elec_type)
    for url_ele in url_muni_l:
        global soup
        soup = move_page(url_ele)
        make_data_for_ele(csv_name)

### 県ごと市町村議会のデータ作成
def make_data_for_pref(pref_num,elec_type):
    start = time.time()
    initial_set("data/"+str(elec_type)+"_pref_"+str(pref_num)+".csv")
    url_pref_l = get_municipalities(pref_num)
    for i in range(1,len(url_pref_l)):
        print(time.time() - start)
        make_data_for_muni(url_pref_l,i,elec_type,"data/"+str(elec_type)+"_pref_"+str(pref_num)+".csv")
    global inconsistent_l
    write_csv_rows("omitted_lists/omitted_l_p"+str(pref_num)+".csv",inconsistent_l)
    print("Complete!:pref",)
  