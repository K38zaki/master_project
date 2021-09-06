import numpy as np
import pandas as pd

def initial_setting(pref_num):
    pref_1 = pd.read_csv("elec_data/gikai_pref_"+str(pref_num)+".csv")
    pref_1["id"] = pref_1.index
    ele_ymd_l = pref_1["ele_ymd"].unique()
    return pref_1, ele_ymd_l

def basic_variables(pref_1, ele_ymd_l):
    for i in range(len(ele_ymd_l)):
        
    