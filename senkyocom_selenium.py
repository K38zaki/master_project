from selenium import webdriver

from selenium.common.exceptions import NoSuchElementException
from selenium.webdriver.support.ui import Select
from bs4 import BeautifulSoup

driver = webdriver.Chrome(executable_path="C:\Program Files\chromedriver")

def move_page(url_str):
    driver.get(url_str)
    #element = driver.find_element_by_class_name("m_senkyo_local_list_right")
    html = driver.page_source.encode('utf-8')
    soup = BeautifulSoup(html, 'html.parser')
    return soup

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

#elif seirei-sitei-toshi

#else
##2層目
soup = move_page(url_l[2][2])
found_url = soup.find_all("td", {"class": "left"}) #classで抜き出す部分を指定,url
url_muni = [found_url[i].contents[0].get('href') for i in range(len(found_url))]

##3層目
soup = move_page(url_muni[0])
cand_names = soup.find_all("h2",{"class":"m_senkyo_result_data_ttl"})
cand_names_l = []
for cand in cand_names:
    kanji = cand.contents[1].contents[0].replace("\n","").replace("\t","")
    kana = cand.contents[1].contents[1].text
    cand_names_l.append([kanji,kana])
    
job_l = soup.find_all("p",{"class":"m_senkyo_result_data_para small"})
age_gen_inc_l = list(filter(lambda x: x not in job_l,soup.find_all("p",{"class":"m_senkyo_result_data_para"})))
len(job_l)
len(age_gen_inc_l)

age_gen_inc_l[0].text[age_gen_inc_l[0].text.find("(")+3:].replace(" ","")
job_l[0].text

cand_info_l = []
for cand_id in range(len(age_gen_inc_l)):
    age_gen_inc = age_gen_inc_l[cand_id].text
    age = int(age_gen_inc[:age_gen_inc.find("(")].replace("歳",""))
    gen = age_gen_inc[age_gen_inc.find("(")+1]
    inc = age_gen_inc[age_gen_inc.find("(")+3:].replace(" ","")
    job = job_l[cand_id].text
    cand_info_l.append([age,gen,inc,job])
    
circle_l = [[i.text] for i in soup.find_all("p",{"class":"m_senkyo_result_data_circle"})]

win_vote_l = []
for cand_id in range(len(soup.find_all("td",{"class":"left"}))):
    win = "red" in str(soup.find_all("td",{"class":"left"})[cand_id])
    vote = int(soup.find_all("td",{"class":"right"})
               [0].text.replace("\n","").replace("票","").replace(",",""))
    win_vote_l.append([win,vote])


len(win_vote_l)
len(circle_l)
len(cand_info_l)
len(cand_names_l)
import pandas as pd

