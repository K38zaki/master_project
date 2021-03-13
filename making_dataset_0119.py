import pandas as pd
import tabula
import numpy as np
import xarray as xr

#市議会
dfs = tabula.read_pdf("salary_data/H26_housyu_city.pdf", lattice=True, pages = '9-31')
dfs
dfs = dfs.drop(dfs.columns[[3, 7]],axis=1)
dfs.loc[33:45,:]
dfs.columns = ["都道府県","市区名","人口","議長報酬","副議長報酬","議員報酬","期末_3月","期末_6月","期末_12月","期末_計","期末_加算率"]
dfs
dfs = dfs.dropna()
dfs
dfs_h26 = dfs

#町村議会
dfc = pd.read_excel("salary_data/H26_housyu_town.xlsx") 
dfc
dfc[3:7]
dfc.columns = ["都道府県","市区町村名","人口","議長報酬","副議長報酬","議員報酬"]
dfc = dfc.iloc[5:]
dfc
dfc = dfc.reset_index(drop=True)
dfc
dfc["人口"] = np.nan
dfc["市制ダミー"] = 0
dfc[dfc["市区町村名"] == "矢祭町"] #矢祭町は日額制
dfc.loc[275,["議長報酬","副議長報酬","議員報酬"]] = [82500,82500,82500]
#日額30000円*年間33日/12月=82500, https://www.soumu.go.jp/main_content/000518381.pdfに基づく
dfc_h26 = dfc

#to csv
dfs_l = [dfs_h26,dfs_h27,dfs_h28,dfs_h29,dfs_h30,dfs_r1]
namel = ["h"+str(i)+"_sala_city" for i in range(26,32)] 
for j in range(len(dfs_l)):
    dfs_l[j].to_csv(namel[j])

dfc_l = [dfc_h26,dfc_h27,dfc_h28,dfc_h29,dfc_h30,dfc_r1]
namel = ["h"+str(i)+"_sala_town" for i in range(26,32)] 
for j in range(len(dfc_l)):
    dfc_l[j].to_csv(namel[j])

#call csv
import xarray as xr
import pandas as pd
import numpy as np

cities = []
for i in range(26,32):
    cities.append(pd.read_csv("salary_csv/"+"h"+str(i)+"_sala_city",index_col=0))
cities[3]

towns = []
for i in range(26,32):
    towns.append(pd.read_csv("salary_csv/"+"h"+str(i)+"_sala_town",index_col=0))
towns[3] 

#str to float
c0 = cities[0].replace("-","0")
c0 = c0.replace(",","", regex = True) #部分一致
c0.astype({"人口":float,"議長報酬":float,"副議長報酬":float,"議員報酬":float,"期末_6月":float,"期末_12月":float,"期末_計":float,"期末_加算率":float})
new_cities = []
for i in range(len(cities)):
    ci = cities[i].replace("-",0)
    ci = ci.replace(",","", regex = True) 
    ci = ci.astype({"人口": float,"議長報酬": float,"副議長報酬":float,"議員報酬":float,"期末_3月":float,"期末_6月":float,"期末_12月":float,"期末_計":float,"期末_加算率":float})
    ci.columns = ["都道府県","市区町村名","人口","議長報酬","副議長報酬","議員報酬","期末_3月","期末_6月","期末_12月","期末_計","期末_加算率"]
    ci = ci.reset_index(drop=True)
    new_cities.append(ci)


print([len(i) for i in new_cities])
new_cities[5][new_cities[5]["市区町村名"]=="富谷市"]
new_cities[5][new_cities[5]["市区町村名"]=="那珂川市"]
x_14 = list(range(0,72))+list(range(73,724))+list(range(725,815))
x_16 = list(range(0,724))+list(range(725,815))
x_18 = list(range(0,815))
ccol = ["prefecture","city","population","salary_chairperson","salary_vicec","salary_council","kimatsu_3gatsu","kimatsu_6gatsu","kimatsu_12gatsu","kimatsu_sum","kimatsu_kasanritsu"]

# to xarray.Dataset 
# city large data
c_14 = xr.DataArray(new_cities[0], dims=['city','variables'], coords={'city':x_14, 'variables':ccol}, name=2014)
c_15 = xr.DataArray(new_cities[1], dims=['city','variables'], coords={'city':x_14, 'variables':ccol}, name=2015)
c_16 = xr.DataArray(new_cities[2], dims=['city','variables'], coords={'city':x_16, 'variables':ccol}, name=2016)
c_17 = xr.DataArray(new_cities[3], dims=['city','variables'], coords={'city':x_16, 'variables':ccol}, name=2017)
c_18 = xr.DataArray(new_cities[4], dims=['city','variables'], coords={'city':x_18, 'variables':ccol}, name=2018)
c_19 = xr.DataArray(new_cities[5], dims=['city','variables'], coords={'city':x_18, 'variables':ccol}, name=2019)
ds = xr.Dataset({2014:c_14,2015:c_15,2016:c_16,2017:c_17,2018:c_18,2019:c_19})
ds
import pickle
with open('city_largedata.pkl', 'wb') as f:
    pickle.dump(ds, f)
with open('city_largedata.pkl', 'rb') as f:
    ds = pickle.load(f)
f.close()
    
del ds, c_14, c_15, c_16, c_17, c_18, c_19
import gc
gc.collect()

#salary_data city and town 
towns[0] = towns[0].astype({"人口":float,"議長報酬":float,"副議長報酬":float,"議員報酬":float})
for i in range(1,6):
    towns[i] = towns[i].astype({"人口":float,"議長報酬":float,"副議長報酬":float,"議員報酬":float})

print([len(i) for i in towns]
for i in range(0,6):
    cities[i] = new_cities[i].iloc[:,0:6]
for i in range(0,6):
    cities[i]["市制ダミー"] = 1
cities[5]
[3+1,3+1,3+2,2+2,2+3,1+3]
cities[2][cities[2]["市区町村名"]=="富谷市"]
towns[2][towns[2]["市区町村名"]=="富谷町"]
cities[4][cities[4]["市区町村名"]=="那珂川市"]
towns[4][towns[4]["市区町村名"]=="那珂川町"]
#各年1231時点のデータに成形　→　h26の富谷,h28の福岡・那珂川はどちらも市にして、町データは落とす。位置も市の位置に
      
def insert_df_middle_row(idx, df_original, df_insert):
    return pd.concat([df_original[:idx], df_insert, df_original[idx:]]).reset_index(drop=True)

#h26_調整
tomiya_h26 = towns[0][towns[0]["市区町村名"]=="富谷町"]
nakagawa_h26 = towns[0][towns[0]["都道府県"]=="福岡県"][towns[0]["市区町村名"]=="那珂川町"]
cities[0] = insert_df_middle_row(72,cities[0],tomiya_h26)
cities[0] = insert_df_middle_row(724,cities[0],nakagawa_h26)
towns[0] = towns[0].drop(207,axis=0)
towns[0] = towns[0].reset_index(drop=True)
towns[0] = towns[0].drop(771,axis=0)
towns[0] = towns[0].reset_index(drop=True)
h26_all = pd.concat([cities[0],towns[0]],axis=0)
h26_all = h26_all.reset_index(drop=True) 

#h27_調整
tomiya_h27 =towns[1][towns[1]["市区町村名"]=="富谷町"]
nakagawa_h27 = towns[1][towns[1]["都道府県"]=="福岡県"][towns[1]["市区町村名"]=="那珂川町"]
cities[1] = insert_df_middle_row(72,cities[1],tomiya_h27) 
cities[1] = insert_df_middle_row(724,cities[1],nakagawa_h27)
towns[1] = towns[1].drop([207,772],axis=0).reset_index(drop=True)
h27_all = pd.concat([cities[1],towns[1]],axis=0).reset_index(drop=True) 
len(h27_all)

#h28_調整
towns[2][towns[2]["市区町村名"]=="富谷町"]
nakagawa_h28 = towns[2][towns[2]["都道府県"]=="福岡県"][towns[2]["市区町村名"]=="那珂川町"]
cities[2] = insert_df_middle_row(724,cities[2],nakagawa_h28)
towns[2] = towns[2].drop([207,772],axis=0).reset_index(drop=True)
h28_all = pd.concat([cities[2],towns[2]],axis=0).reset_index(drop=True) 
len(h28_all)

#h29_調整
nakagawa_h29 = towns[3][towns[3]["都道府県"]=="福岡県"][towns[3]["市区町村名"]=="那珂川町"]
cities[3] = insert_df_middle_row(724,cities[3],nakagawa_h29)
towns[3] = towns[3].drop(771,axis=0).reset_index(drop=True)
h29_all = pd.concat([cities[3],towns[3]],axis=0).reset_index(drop=True) 
len(h29_all)

#h30_調整
towns[4][towns[4]["都道府県"]=="福岡県"][towns[4]["市区町村名"]=="那珂川町"]
towns[4] = towns[4].drop(771,axis=0).reset_index(drop=True)
h30_all = pd.concat([cities[4],towns[4]],axis=0).reset_index(drop=True) 
len(h30_all)

#r1_調整
r1_all = pd.concat([cities[5],towns[5]],axis=0).reset_index(drop=True) 
len(r1_all)

acol = ["prefecture","city","population","salary_chairperson","salary_vicec","salary_council","city_dummy"]
#to xarray
a_14 = xr.DataArray(h26_all, dims=['municipality','variables'], coords={'municipality':h26_all.index, 'variables':acol}, name=2014)
a_15 = xr.DataArray(h27_all, dims=['municipality','variables'], coords={'municipality':h26_all.index, 'variables':acol}, name=2015)
a_16 = xr.DataArray(h28_all, dims=['municipality','variables'], coords={'municipality':h26_all.index, 'variables':acol}, name=2016)
a_17 = xr.DataArray(h29_all, dims=['municipality','variables'], coords={'municipality':h26_all.index, 'variables':acol}, name=2017)
a_18 = xr.DataArray(h30_all, dims=['municipality','variables'], coords={'municipality':h26_all.index, 'variables':acol}, name=2018)
a_19 = xr.DataArray(r1_all, dims=['municipality','variables'], coords={'municipality':h26_all.index, 'variables':acol}, name=2019)
ds = xr.Dataset({2014:a_14,2015:a_15,2016:a_16,2017:a_17,2018:a_18,2019:a_19})
ds
with open('municipality_counsil_salary.pkl', 'wb') as f:
    pickle.dump(ds, f)
f.close()
with open('municipality_counsil_salary.pkl', 'rb') as f:
    ds = pickle.load(f)
f.close()

ds
      

