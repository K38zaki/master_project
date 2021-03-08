import numpy as np
import pandas as pd
import xarray as xr

al_l = ["a","b","c","d","e","f","g","h","i","j"]
data_d = {}

for n in al_l:
    da = pd.read_excel("demograph_data/2019/2019-"+str(n)+".xls")
    data_d[n] = da

data_d["a"] = data_d["a"].iloc[4:,7:]
data_d["a"].columns = data_d["a"].iloc[1,:]
data_d["a"]
cl = list(data_d["a"].iloc[1,:])
cl[0] = "municipality_id"
cl[1] = "municipality"
cl[2] = "munici_English"
cl
data_d["a"].columns = cl
data_d["a"] = data_d["a"].drop(columns=np.nan,index=5)
data_d["a"] = data_d["a"].reset_index()
il = ["JP_var","var_no","unit","year"] + list(range(0,1964))
data_d["a"].index = il
data_d["a"] = data_d["a"].drop(columns="index")
data_d["a"].iloc[0,0] = "自治体ID"
data_d["a"]

data_d["b"] = data_d["b"].iloc[4:,7:-1]
data_d["b"] = data_d["b"].iloc[:,[0,3,4]]
cl = list(data_d["b"].iloc[1,:])
cl[0] = "municipality_id"
data_d["b"].columns = cl
data_d["b"] = data_d["b"].drop(index=5)
il = ["JP_var","var_no","unit","year"] + list(range(0,1964))
data_d["b"].index = il
data_d["b"].iloc[:4,0] = ["JP","No","unit","year"]
data_d["b"]

data_d["c"] = data_d["c"].iloc[4:-1,7:-1]
data_d["c"] = data_d["c"].drop(columns=data_d["c"].columns[[1, 2]])
cl = data_d["c"].iloc[1,:]
cl[0] = "municipality_id"
data_d["c"].columns = cl
data_d["c"] = data_d["c"].drop(index=5)
il = ["JP_var","var_no","unit","year"] + list(range(0,1964))
data_d["c"].index = il
data_d["c"].iloc[:4,0] = ["JP","No","unit","year"]
data_d["c"]

data_d["d"]
data_d["d"] = data_d["d"].iloc[4:,7:-1]
data_d["d"] = data_d["d"].drop(columns=data_d["d"].columns[[1, 2]])
cl = data_d["d"].iloc[1,:]
cl[0] = "municipality_id"
data_d["d"].columns = cl
data_d["d"] = data_d["d"].drop(index=5)
il = ["JP_var","var_no","unit","year"] + list(range(0,1964))
data_d["d"].index = il
data_d["d"].iloc[:4,0] = ["JP","No","unit","year"]
data_d["d"]

data_d["e"].iloc[4:-1,7:-1]
data_d["e"] = data_d["e"].iloc[4:-1,7:-1]
data_d["e"] = data_d["e"].drop(columns=data_d["e"].columns[[1, 2]])
cl = data_d["e"].iloc[1,:]
cl[0] = "municipality_id"
data_d["e"].columns = cl
data_d["e"] = data_d["e"].drop(index=5)
il = ["JP_var","var_no","unit","year"] + list(range(0,1964))
data_d["e"].index = il
data_d["e"].iloc[:4,0] = ["JP","No","unit","year"]
data_d["e"]

data_d["f"].iloc[4:,7:-1]
data_d["f"] = data_d["f"].iloc[4:,7:-1]
data_d["f"] = data_d["f"].drop(columns=data_d["f"].columns[[1, 2]])
cl = data_d["f"].iloc[1,:]
cl[0] = "municipality_id"
data_d["f"].columns = cl
data_d["f"] = data_d["f"].drop(index=5)
il = ["JP_var","var_no","unit","year"] + list(range(0,1964))
data_d["f"].index = il
data_d["f"].iloc[:4,0] = ["JP","No","unit","year"]
data_d["f"]

data_d["g"].iloc[4:,7:-1]
data_d["g"] = data_d["g"].iloc[4:,7:-1]
data_d["g"] = data_d["g"].drop(columns=data_d["g"].columns[[1, 2]])
cl = data_d["g"].iloc[1,:]
cl[0] = "municipality_id"
data_d["g"].columns = cl
data_d["g"] = data_d["g"].drop(index=5)
il = ["JP_var","var_no","unit","year"] + list(range(0,1964))
data_d["g"].index = il
data_d["g"].iloc[:4,0] = ["JP","No","unit","year"]
data_d["g"]

data_d["h"].iloc[4:-1,7:-1]
data_d["h"] = data_d["h"].iloc[4:-1,7:-1]
data_d["h"] = data_d["h"].drop(columns=data_d["h"].columns[[1, 2]])
cl = data_d["h"].iloc[1,:]
cl[0] = "municipality_id"
data_d["h"].columns = cl
data_d["h"] = data_d["h"].drop(index=5)
il = ["JP_var","var_no","unit","year"] + list(range(0,1964))
data_d["h"].index = il
data_d["h"].iloc[:4,0] = ["JP","No","unit","year"]
data_d["h"]

data_d["i"].iloc[4:,7:-1]
data_d["i"] = data_d["i"].iloc[4:,7:-1]
data_d["i"] = data_d["i"].drop(columns=data_d["i"].columns[[1, 2]])
cl = data_d["i"].iloc[1,:]
cl[0] = "municipality_id"
data_d["i"].columns = cl
data_d["i"] = data_d["i"].drop(index=5)
il = ["JP_var","var_no","unit","year"] + list(range(0,1964))
data_d["i"].index = il
data_d["i"].iloc[:4,0] = ["JP","No","unit","year"]
data_d["i"]

data_d["j"].iloc[4:,7:-1]
data_d["j"] = data_d["j"].iloc[4:,7:-1]
data_d["j"] = data_d["j"].drop(columns=data_d["j"].columns[[1, 2]])
cl = data_d["j"].iloc[1,:]
cl[0] = "municipality_id"
data_d["j"].columns = cl
data_d["j"] = data_d["j"].drop(index=5)
il = ["JP_var","var_no","unit","year"] + list(range(0,1964))
data_d["j"].index = il
data_d["j"].iloc[:4,0] = ["JP","No","unit","year"]
data_d["j"]

data_d["a"].iloc[:4,0] = ["JP","No","unit","year"]
data_d["j"]
large = pd.concat([data_d["a"]]+[data_d[n].iloc[:,1:] for n in al_l[1:]],axis=1)
large.to_csv("demographic_data_2015.csv")
