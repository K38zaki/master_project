from selenium import webdriver

from selenium.common.exceptions import NoSuchElementException
from selenium.webdriver.support.ui import Select
from bs4 import BeautifulSoup
import pandas as pd
import numpy as np
import csv
import time

driver = webdriver.Chrome(executable_path="C:\Program Files\chromedriver")

def move_page(url_str):
    driver.get(url_str)
    #element = driver.find_element_by_class_name("m_senkyo_local_list_right")
    html = driver.page_source.encode('utf-8')
    soup = BeautifulSoup(html, 'html.parser')
    return soup

def str_find(str_all,str_pati):
    if str_all.find(str_pati) == -1:
        print("Error!",str_all,"にお探しの文字",str_pati,"は見つかりませんよ")
        return np.nan
    else:
        return str_all.find(str_pati)

    
## 一層目

### make variables list and write csv

variables_list = ["ele_ymd","election","prefecture","municipality","district","name_kanji","name_kana","age","gen","status","job","circle","win","n_votes","voting_ymd","year","month","day","voting_rate","seats_target","n_candidates","competitive_ratio","kokuji_ymd","all_voter","male_all_voter","female_all_voter","change_all_voter","reason","pre_v_rate","pre_seats_t","pre_n_cand","pre_compe_rate"]

with open('test_by_otaru.csv', 'w', newline='') as file:
    writer = csv.writer(file,delimiter=',')
    writer.writerow(variables_list)

soup = move_page('https://go2senkyo.com/local/prefecture/1')

# found = soup.find('span', class_='m_senkyo_local_list_right') 
# found_url = soup.find_all('span', class_='m_senkyo_local_list_right')

found_url = soup.select('.m_senkyo_local_list_right') #class で抜き出す部分を指定,url
found_url[2].contents[2].get('href') #確認

found_name = soup.select('.m_senkyo_local_list_left') # classで抜き出す部分を指定,市町村名
#found_name[1].text.replace('\n','') # テキストを取得, '\n' を抜く
found_name[1].contents[1].text #テキストを取得, 漢字のみ
print("consistent name url:",len(found_url) == len(found_name)) #URLの数と市町村名の数の一致を確認

url_l = []
for muni_id in range(len(found_url)):
    #found_urlの各要素の「子要素」(urlが入ってる部分)を抜き出し、urlをstrとして取得
    name = found_name[muni_id].contents[1].text
    head_url = found_url[muni_id].contents[1].get('href')
    gikai_url = found_url[muni_id].contents[2].get('href')
    url_l.append([name,head_url,gikai_url])
    
url_l

#if prefecture

#elif seirei-sitei-toshi or multiple_races

#else

### set information about district
district = "無し"
## 2層目

current_muni = url_l[3]
soup = move_page(current_muni[2])
found_url = soup.find_all("td", {"class": "left"}) #classで抜き出す部分を指定,url
url_muni = [found_url[i].contents[0].get('href') for i in range(len(found_url))]

## 3層目

start = time.time()

soup = move_page(url_muni[1])


### the name of election, prefecture, municipality (base information)

ele_name_ymd = soup.find("h1",{"class":"p_local_senkyo_ttl column_ttl"}).text.replace("\n","").replace(" ","")
ele_name = ele_name_ymd[:str_find(ele_name_ymd,"挙")+1]
pref_name = soup.find("p",{"class":"column_ttl_small"}).text
muni_name = current_muni[0]
base_inf_l = [ele_name_ymd, ele_name, pref_name, muni_name,]



### find candidate data

cand_names = soup.find_all("h2",{"class":"m_senkyo_result_data_ttl"})
job_l = soup.find_all("p",{"class":"m_senkyo_result_data_para small"})
age_gen_inc_l = list(filter(lambda x: x not in job_l,soup.find_all("p",{"class":"m_senkyo_result_data_para"})))
win_nvote_l = soup.find_all("td",{"class":"left"})
circle_l = [i.text for i in soup.find_all("p",{"class":"m_senkyo_result_data_circle"})]



### find and make election_level data

election_data = [i.text for i in soup.select("table.m_senkyo_data > tbody > tr > td")]  
election_data = [i.replace("\n","").replace(" ","").replace(",","").replace("千円","000") for i in election_data]

#### 選挙レベルデータの description(変数名) 
election_des = [i.text.replace("\n","").replace(" ","") for i in soup.select("table.m_senkyo_data > tbody > tr > th")]

#### components of ele_lv_data
##### y_m_d
y_m_d = election_data[election_des.index("投票日")]
year = int(y_m_d[:str_find(y_m_d,"年")])
month = int(y_m_d[str_find(y_m_d,"年")+1:str_find(y_m_d,"月")])
day = int(y_m_d[str_find(y_m_d,"月")+1:str_find(y_m_d,"日")])
vote_ymd = y_m_d.replace("年","").replace("月","").replace("日","")

##### n_cand, n_seet
seat_cand = election_data[election_des.index("定数/候補者数")]
n_seat = int(seat_cand[:str_find(seat_cand,"/")])
n_cand = int(seat_cand[str_find(seat_cand,"/")+1:])
compe_rate = n_cand/n_seat

##### kokuji_date
kokuji = election_data[election_des.index("告示日")]
kokuji = kokuji.replace("年","").replace("月","").replace("日","")

##### about number of voters
voters = election_data[election_des.index("有権者数")]
n_yukensya = int(voters[:str_find(voters,"人")])
d_yukensya = int(voters[str_find(voters,"り")+1:str_find(voters,"男")-1]) if "前回" in voters else np.nan
male_yukensya = int(voters[str_find(voters,"男")+2:str_find(voters,"女")-1])
fema_yukensya = int(voters[str_find(voters,"女")+2:-1])
male_yukensya = np.nan if male_yukensya == 0 else male_yukensya
fema_yukensya = np.nan if fema_yukensya == 0 else fele_yukensya


##### vote_rate
vote_rate = election_data[election_des.index("投票率")]
try:
    vote_rate = vote_rate[:str_find(vote_rate,"%")]
except:
    vote_rate = vote_rate[:str_find(vote_rate,"％")]
vote_rate = np.nan if vote_rate == "-" else float(vote_rate)


##### reason
reason = election_data[election_des.index("事由・ポイント")]

##### about previous election
vote_rate_pre = election_data[election_des.index("前回投票率")]
try:
    vote_rate_pre = vote_rate_pre[:str_find(vote_rate_pre,"%")]
except:
    vote_rate_pre = vote_rate_pre[:str_find(vote_rate_pre,"％")]
vote_rate_pre = np.nan if vote_rate_pre == "-" else float(vote_rate_pre)

if "前回の候補者数/定数" in election_des:
    pre_seat_cand = election_data[election_des.index("前回の候補者数/定数")]
    n_seat_pre = int(pre_seat_cand[:str_find(pre_seat_cand,"/")])
    n_cand_pre = int(pre_seat_cand[str_find(pre_seat_cand,"/")+1:])
else:
    n_seat_pre = np.nan
    n_cand_pre = np.nan

if "前回倍率" in election_des:
    pre_compe_rate = election_data[election_des.index("前回倍率")]
    try:
        pre_compe_rate = float(pre_compe_rate[:str_find(pre_compe_rate,"％")])
    except:
        pre_compe_rate = float(pre_compe_rate[:str_find(pre_compe_rate,"%")])
else:
    pre_compe_rate = np.nan

elec_data_l = [vote_ymd,year,month,day,vote_rate,n_seat,n_cand,compe_rate,kokuji,n_yukensya,male_yukensya,fema_yukensya,d_yukensya,reason,vote_rate_pre,n_seat_pre,n_cand_pre,pre_compe_rate]





### make candidate data
if (len(cand_names) == len(job_l) == len(age_gen_inc_l) == len(win_nvote_l) == len(win_nvote_l) == len(circle_l)) == True:
    print(ele_name_ymd,"columns of cand data: consistent")
    
    
    id_lv_data_l = []
    
    for cand_id in range(len(cand_names)):
        
        ##### names
        kanji = cand_names[cand_id].contents[1].contents[0].replace("\n","").replace("\t","")
        kana = cand_names[cand_id].contents[1].contents[1].text
        
        ##### age, gen, inc
        age_gen_inc = age_gen_inc_l[cand_id].text
        age = int(age_gen_inc[:str_find(age_gen_inc,"(")].replace("歳",""))
        gen = age_gen_inc[str_find(age_gen_inc,"(")+1]
        inc = age_gen_inc[str_find(age_gen_inc,"(")+3:].replace(" ","")
        job = job_l[cand_id].text
        
        #### circle
        circle = circle_l[cand_id]
        
        #### win, number of votes
        win = "red" in str(soup.find_all("td",{"class":"left"})[cand_id])
        vote = float(soup.find_all("td",{"class":"right"})
                   [cand_id].text.replace("\n","").replace("票","").replace(",",""))
        
        #### append to over_all_list
        id_lv_data = base_inf_l + [district] + [kanji,kana,age,gen,inc,job,circle,win,vote] + elec_data_l
        id_lv_data_l.append(id_lv_data)
        
    ### make data
    with open('test_by_otaru.csv', 'a', newline='') as file:
        writer = csv.writer(file,delimiter=',')
        writer.writerows(id_lv_data_l)
    
else:
    print(ele_name_ymd,"inconsistent cols of cand data",
          len(cand_names),len(job_l),len(age_gen_inc_l),len(win_nvote_l),len(win_nvote_l),len(circle_l))
    pass


    


### municipalty level data, if any

# muni_data = election_data
# muni_des = election_des
# remove_lst = [election_des.index("投票日"),election_des.index("投票率"),election_des.index("定数/候補者数"),election_des.index("告示日"),election_des.index("前回投票率"),election_des.index("有権者数"),election_des.index("事由・ポイント")]
# for i in sorted(remove_lst, reverse=True):
#     muni_data.pop(i)
#     muni_des.pop(i)

# if "前回の候補者数/定数" in muni_des:
#     muni_data.pop(muni_des.index("前回の候補者数/定数"))
#     muni_des.pop(muni_des.index("前回の候補者数/定数"))
# else:
#     pass

# if "前回倍率" in muni_des:
#     muni_data.pop(muni_des.index("前回倍率"))
#     muni_des.pop(muni_des.index("前回倍率"))
# else:
#     pass

# muni_data = [int(i.replace("人","")) for i in muni_data]
# muni_des = [i+str(21) for i in muni_des]

# soup.select("#contents > div.p_local_top > div > div.p_local_senkyo.column2_left > div.m_bottomlist_wrapp > div.m_senkyo_data_outer > area_data")
# soup.select("th.middle")
# soup.find_all("div", class_="m_senkyo_data_outer")
# soup




elapsed_time = time.time() - start
print(ele_name_ymd,":",elapsed_time)
    

df = pd.read_csv("test_by_otaru.csv",encoding="shift-jis")
df.loc[:21,"n_votes"]
df["n_votes"]
