import pandas as pd
import numpy as np


#0924
## 主体i のインデックス（県名＋市町村名を取得）
master = pd.read_csv("master_datas/master_2005_0924.csv")
master["pref_muni"] = master["prefecture"] + master["municipality"]
master.to_csv("master_datas/master_2005_0924.csv")


#0925

master = pd.read_csv("master_datas/master_2005_0924.csv")

## {(県名+市町村名),(年)}がダブっているところ
daburi_id = master.groupby(["pref_muni","year"]).count()[master.groupby(["pref_muni","year"]).count()["ele_ymd"] > 1].index

pref_1 = pd.read_csv("original_candidates_data/gikai_pref_11.csv")
pref_1[(pref_1.municipality == "川口市")]
del pref_1

len(master[master.prefecture=="北海道"]["municipality"].unique())

master[master["pref_muni"] == "北海道泊村"]　#謎のダブり　→　elec_unit_data は問題ないので繋げたときの問題
master[master["pref_muni"] == "和歌山県串本町"] #合併に伴う年2回目の選挙

master[master["pref_muni"] == "埼玉県川口市"]　#増員が原因、しかしそもそも選挙の数が足りない問題　→　elec_unit_data は問題ないので繋げたときの問題

gered = pd.read_csv("elec_unit_data/pref_11_gikai_elections.csv")
gered[gered.municipality=="川口市"]
del gered

master[master["pref_muni"] == "奈良県奈良市"] #増員選挙　
master[master["pref_muni"] == "滋賀県長浜市"] #増員選挙　
master[master["pref_muni"] == "群馬県みなかみ町"]["reason"] #解散に伴う年2回目の選挙
master[master["pref_muni"] == "群馬県前橋市"] #増員選挙
master[master["pref_muni"] == "長野県飯田市"] #増員選挙

## 原因は大体増員選挙　→　

