import numpy as np
import pandas as pd
import datetime

pd.read_csv("elec_unit_data/pref_1_gikai_elections.csv")

eles = pd.concat([pd.read_csv("elec_unit_data/pref_"+str(k)+"_gikai_elections.csv") for k in range(1,48)],axis=0).reset_index(drop=True)
eles = eles[eles["Unnamed: 0"] != "政党名"]

full_eles = eles[eles["Unnamed: 0"].str.contains("補欠") == False]
full_eles = full_eles[full_eles["Unnamed: 0"].str.contains("再選挙") == False]
full_eles = full_eles[full_eles["Unnamed: 0"].str.contains("増員") == False]
full_eles[full_eles["municipality"] == "泊村"]
full_eles["pref_muni"] = full_eles["prefecture"] + full_eles["municipality"]
full_eles["pref_muni"]
full_eles.groupby(["pref_muni","year"]).count()[full_eles.groupby(["pref_muni","year"]).count()["ele_ymd"]>1] # ダブり問題現状OK


full_eles[(full_eles["year"] ==2013) & (full_eles["month"] ==4)]["kokuji_ymd"].unique()
full_eles.loc[full_eles["kokuji_ymd"].isnull(),:]　#告示日欠損


full_eles["kokuji_df"] = pd.to_datetime(full_eles["kokuji_ymd"],format='%Y%m%d')
full_eles["kokuji_df"] 

#告示日欠損の場合は便宜上、投票日の7日前を告示日とする
full_eles.loc[full_eles["kokuji_df"].isnull(),"kokuji_df"] = pd.to_datetime(full_eles["ymd"],format='%Y%m%d') 
full_eles.loc[full_eles["kokuji_ymd"].isnull(),"kokuji_df"] = full_eles["kokuji_df"] - datetime.timedelta(days=7)

full_eles = full_eles.rename({"kokuji_df":"kokuji_dt"},axis=1)

#告示日に基づく年度変数を作成
full_eles["nendo"] = np.nan
full_eles.loc[full_eles['kokuji_dt'].dt.month >= 4, 'nendo'] = full_eles['kokuji_dt'].dt.year
full_eles.loc[full_eles['kokuji_dt'].dt.month < 4, 'nendo'] = full_eles['kokuji_dt'].dt.year - 1

full_eles["nendo"].unique()
full_eles[full_eles["nendo"] == 1909]
full_eles.loc[3576,"kokuji_ymd"] = float(20101212) #告示日欠損の場合は便宜上、投票日の7日前を告示日とする
full_eles.loc[3576,"kokuji_dt"] = datetime.datetime(year=2010, month=12, day=12)
full_eles.loc[3576,"nendo"] = full_eles.loc[3576,'kokuji_dt'].year

since2005 = full_eles[full_eles["nendo"] >= 2005]

since2005[since2005["municipality"] == "香取市"]
since2005[since2005["municipality"] == "川口市"]
since2005[since2005["municipality"] == "泊村"]
since2005.groupby(["pref_muni"]).count()["ele_ymd"][since2005.groupby(["pref_muni"]).count()["ele_ymd"] == 3]

since2005[since2005["pref_muni"].isnull()]

since2005.to_csv("since_2005_full_eles.csv")

#マージ
salaries = pd.concat([pd.read_csv("salaries_new/" + f'{num:02}' + "_salaries.csv",index_col=0) for num in range(5,21)],axis=0).reset_index(drop=True)
salaries["nendo"] = pd.to_datetime(salaries["data_year"],format="%Y").dt.year

salaries[salaries["name_1"].isnull()]
salaries.loc[23658,["name_1","name_2"]] = ["堺市"]*2
salaries["pref_muni"] = salaries["prefecture"] + salaries["name_1"]
salaries["pref_muni"].unique()

#dypes 変更
salaries.loc[:,"n_staff_all":"kimatsu_staff_gyosei"] = salaries.loc[:,"n_staff_all":"kimatsu_staff_gyosei"].replace("-",np.nan).replace('−',np.nan).astype("float64")

salaries.iloc[:,14]
salaries.iloc[:,24]
for n in range(14,25):
    salaries.iloc[:,n] = salaries.iloc[:,n].astype("str").str.replace(",","")
    
for n in range(14,25):
    print(n)
    print(salaries.iloc[:,n].count())
    print(salaries.iloc[:,n].astype("str").str.replace(",","").count())

#intを含む　Series でstr.replace やると Nan になる

salaries.loc[:,"daisotsu":"salary_education"] = salaries.loc[:,"daisotsu":"salary_education"].replace("-",np.nan).replace('−',np.nan).astype("float64")

salaries

master_2005 = pd.merge(since2005,salaries,how="left",on=["pref_muni","nendo"])
master_2005[master_2005["municipality"] == "泊村"]
master_2005[master_2005["salary_assembly_member"].isnull()]["nendo"].unique()
master_2005[(master_2005["salary_assembly_member"].isnull()) & (master_2005["nendo"] == 2017)]["pref_muni"]

master_2005[master_2005["pref_muni"].str.contains("ケ")]["pref_muni"].unique()
master_2005[master_2005["pref_muni"].str.contains("ヶ")]["pref_muni"].unique()

for i in range(2005,2021):
    print(i,master_2005[(master_2005["salary_assembly_member"].isnull()) & (master_2005["nendo"] == i)]["pref_muni"].values)

salaries[(salaries["name_1"].str.contains("原村"))]

salaries.to_csv("salaries_all.csv")

## マッチ失敗箇所の理由

# 2005年・4月1日時点でまだその市町村が存在しない　→　'岩手県奥州市'(2006年2月20日), '宮城県南三陸町'(2005年10月1日） '宮城県美里町'(2006年1月1日) '福島県会津美里町'(2005年10月1日） '埼玉県ときがわ町'(2006年2月1日) '東京都青ヶ島村' '富山県射水市'(2005年11月1日)、'山梨県甲州市'(2005年11月1日)  '長野県安曇野市' '長野県木曽町' '長野県筑北村' '長野県長和町' '長野県飯綱町' '静岡県川根本町'(2005年9月20日) '静岡県牧之原市'(2005年10月11日) '滋賀県愛荘町'(2006年2月13日 ) '京都府京丹波町' '京都府南丹市' '兵庫県多可町' '兵庫県新温泉町' '和歌山県有田川町''和歌山県紀の川市' '鳥取県北栄町' '島根県吉賀町' '香川県三豊市' '高知県仁淀川町' '福岡県宮若市' '佐賀県嬉野市' '長崎県雲仙市' '熊本県氷川町' '大分県由布市'  '宮崎県美郷町' '鹿児島県いちき串木野市' '鹿児島県南さつま市' '鹿児島県志布志市' '鹿児島県日置市' '鹿児島県霧島市' '沖縄県宮古島市'

#2005年・漢字が原因　→　'長野県天龍村','宮崎県五ヶ瀬町'

# ケとヶが未統一
# 丹波篠山市　→　masterでは丹波篠山市だが、salariesでは2019まで篠山市
# 矢祭町 →　報酬日額制
# 天龍村(2005) →　salariesが「天竜村」
# 塩竃市(2007) →　salariesが「塩市」
# 檜枝岐村(2007) →salariesが桧枝岐村
# 檜原村(2007) →　salariesが桧原村
# 梼原町(2007) →　salariesが檮原町
# 聖籠町(2007) →　salariesが聖篭町
# 飛騨市(2007) →　salariesが「飛驒市」,「飛市」
# 南九州市(2007)　→　2007年12月1日誕生
# 富谷市(2007,2011) →　salariesが富谷町
# 伊佐市(2008) →　2008年11月1日誕生
# 糸島市(2009) →　新設合併、2009年4月16日誕生
# 2011 →　震災の影響で salariesが欠損

master = pd.read_csv("since_2005_full_eles.csv",index_col=0)
salaries = pd.read_csv("salaries_all.csv",index_col=0)

#ヶとヶ
master[master["pref_muni"].str.contains("ケ")]["pref_muni"].unique()
master[master["pref_muni"].str.contains("ヶ")]["pref_muni"].unique()

salaries["municipality"] = salaries["name_1"]
salaries["municipality"] = salaries["municipality"].str.replace("ケ","ヶ")
salaries["municipality"] = salaries["municipality"].str.replace("金ヶ崎","金ケ崎").str.replace("龍ヶ崎","龍ケ崎")

#青森県鰺ヶ沢町
salaries[salaries["municipality"] == "鰺ヶ沢町"]
master[master["municipality"] == "鰺ヶ沢町"]
salaries[salaries["name_1"] == "鯵ヶ沢町"]
salaries.loc[salaries["name_1"] == "鯵ヶ沢町","municipality"] = "鰺ヶ沢町"


#兵庫県丹波篠山市
salaries[salaries["name_1"] == "篠山市"]
master[master["municipality"] == "丹波篠山市"]

salaries.loc[salaries["name_1"] == "篠山市","municipality"] = "丹波篠山市"

#長野県天龍村
salaries[salaries["name_1"] == "天竜村"]
salaries.loc[salaries["name_1"] == "天竜村","municipality"] = "天龍村"

salaries[salaries["municipality"] == "天龍村"]

#宮城県塩竃市
salaries[salaries["name_1"] == "塩竈市"]
master[master["municipality"] == "塩竈市"]
salaries.loc[salaries["name_1"] == "塩市","municipality"] = "塩竈市"

salaries[salaries["municipality"] == "塩竈市"]

#福島県檜枝岐村
salaries[salaries["name_1"] == "桧枝岐村"]
master[master["municipality"] == "檜枝岐村"]
salaries.loc[salaries["name_1"] == "桧枝岐村","municipality"] = "檜枝岐村"

salaries[salaries["municipality"] == "檜枝岐村"]

#東京都檜原村
salaries[salaries["name_1"] == "桧原村"]
master[master["municipality"] == "檜原村"]
salaries.loc[salaries["name_1"] == "桧原村","municipality"] = "檜原村"

salaries[salaries["municipality"] == "檜原村"]

#高知県梼原町
salaries[salaries["name_1"] == "檮原町"]
master[master["municipality"] == "梼原町"]
salaries.loc[salaries["name_1"] == "檮原町","municipality"] = "梼原町"

salaries[salaries["municipality"] == "梼原町"]

#新潟県聖籠町
salaries[salaries["name_1"] == "聖篭町"]
master[master["municipality"] == "聖籠町"]
salaries.loc[salaries["name_1"] == "聖篭町","municipality"] = "聖籠町"

salaries[salaries["municipality"] == "聖籠町"]

#岐阜県飛騨市
salaries[salaries["name_1"] == "飛驒市"]
master[master["municipality"] == "飛騨市"]
salaries.loc[salaries["name_1"] == "飛驒市","municipality"] = "飛騨市"
salaries.loc[salaries["name_1"] == "飛市","municipality"] = "飛騨市"

salaries[salaries["municipality"] == "飛騨市"]

#富谷市
salaries[salaries["name_1"] == "富谷町"]
master[master["municipality"] == "富谷市"]
salaries.loc[salaries["name_1"] == "富谷町","municipality"] = "富谷市"

salaries[salaries["municipality"] == "富谷市"]

#pref_muni修正と再マージ
salaries["pref_muni"] = salaries["prefecture"] + salaries["municipality"]
salaries["pref_muni"].unique()
salaries[salaries["pref_muni"] == "新潟県聖籠町"]

master_2005 = pd.merge(master,salaries,how="left",on=["pref_muni","nendo"])
master_2005

for i in range(2005,2021):
    print(i,master_2005[(master_2005["salary_assembly_member"].isnull()) & (master_2005["nendo"] == i)]["pref_muni"].values)
    
master_2005.to_csv("master_datas/master_2005_0927.csv")

salaries.to_csv("salaries_all.csv")




master = pd.read_csv("master_datas/master_2005_0927.csv",index_col=0)

salaries = pd.read_csv("salaries_all.csv",index_col=0)

#以下、変更日に基づく修正を行う
# pd.to_datetime(salaries["assembly_sala_apply_ymd"],format="%y.%m.%d")
# salaries["assembly_sala_apply_ymd"].str.find(".")
# salaries["assembly_sala_apply_ymd"].str.rfind(".")

# salaries["assembly_sala_apply_ymd"][salaries["assembly_sala_apply_ymd"].map(type) != type("str")]
# salaries["assembly_sala_apply_ymd"][salaries["assembly_sala_apply_ymd"].map(type) != type("str")].map(type)
# salaries["assembly_sala_apply_ymd"].unique()

# salaries[salaries["assembly_sala_apply_ymd"].apply(lambda x: str(x)[:2]) == "1."]
# salaries[salaries["municipality"] == "米沢市"]



sala_p = salaries[['salary_mayor','salary_vice_mayor', 'salary_chair', 'salary_vice_chair','salary_assembly_member', 'salary_education', 'mayor_sala_apply_ymd','assembly_sala_apply_ymd', 'education_sala_apply_ymd','nendo','pref_muni']]

sala_p.groupby("pref_muni").groups.keys()

sala_p["nendo"][(sala_p.groupby("pref_muni")["nendo"].shift(-1) - sala_p.groupby("pref_muni")["nendo"].shift(0) != 1) & (sala_p.groupby("pref_muni")["nendo"].shift(-1) - sala_p.groupby("pref_muni")["nendo"].shift(0).isnull() == False)]## sala_p.groupby("pref_muni")["nendo"].shift(-1)でOK

## 'salary_assembly_member'
shift_m1 = sala_p.groupby("pref_muni")[['salary_assembly_member','assembly_sala_apply_ymd','nendo']].shift(-1)
shift_m1.columns = ['salary_assembly_member_L1','assembly_sala_apply_ymd_L1','nendo_L1']

sala_addl = pd.concat([sala_p[['pref_muni','salary_assembly_member','nendo']],shift_m1],axis=1)

#2020以外
# sala_ad_19 = sala_addl[sala_addl["nendo"] != 2020]
# sala_ad_19[sala_ad_19["salary_assembly_member_L1"].isnull()]["pref_muni"].unique()
# sala_ad_19[sala_ad_19["salary_assembly_member"].isnull()]["pref_muni"].unique()

sala_changes = sala_addl[(sala_addl["salary_assembly_member"] - sala_addl["salary_assembly_member_L1"] != 0) & ((sala_addl["salary_assembly_member"] - sala_addl["salary_assembly_member_L1"]).isnull() == False)]

sala_changes["assembly_sala_apply_ymd_L1"].unique()

sala_c_ele = pd.merge(master,sala_changes[["pref_muni","nendo","salary_assembly_member_L1","assembly_sala_apply_ymd_L1","nendo_L1"]],how="inner",on=["pref_muni","nendo"])

sala_c_ele[sala_c_ele["assembly_sala_apply_ymd_L1"] != sala_c_ele["assembly_sala_apply_ymd"]]["assembly_sala_apply_ymd_L1"].unique()

sala_ed = sala_c_ele[sala_c_ele["assembly_sala_apply_ymd_L1"] != sala_c_ele["assembly_sala_apply_ymd"]]


def to_seireki_dt(x):
    dotp_1 = x.find(".")
    dotp_2 = x.rfind(".")
    y = int(x[:dotp_1])+1988 if int(x[:dotp_1]) > 2 else int(x[:dotp_1])+2018
    m = int(x[dotp_1+1:dotp_2])
    d = int(x[dotp_2+1:])
    return datetime.datetime(year=y,month=m,day=d)
    
sala_ed["assembly_sala_apply_ymd_L1_dt"] = sala_ed["assembly_sala_apply_ymd_L1"].apply(lambda x: to_seireki_dt(x))

sala_ed["kokuji_dt"] = pd.to_datetime(sala_ed["kokuji_dt"])


sala_ed["nendo_start"] = sala_ed["nendo"].astype("int64").agg(lambda x: datetime.datetime(year=x,month=4,day=1))

sala_ed[(sala_ed["assembly_sala_apply_ymd_L1_dt"] < sala_ed["kokuji_dt"])&(sala_ed["assembly_sala_apply_ymd_L1_dt"] > sala_ed["nendo_start"])][["assembly_sala_apply_ymd_L1_dt","kokuji_dt"]].values

sala_c_within = sala_ed[(sala_ed["assembly_sala_apply_ymd_L1_dt"] < sala_ed["kokuji_dt"])&(sala_ed["assembly_sala_apply_ymd_L1_dt"] > sala_ed["nendo_start"])][["Unnamed: 0.1","salary_assembly_member","salary_assembly_member_L1","assembly_sala_apply_ymd_L1_dt"]]

master["salary_am_kokuji"] = master["salary_assembly_member"]
master.loc[master["Unnamed: 0.1"].isin(list(sala_c_within["Unnamed: 0.1"])),"salary_am_kokuji"] = list(sala_c_within["salary_assembly_member_L1"])
master.loc[master["Unnamed: 0.1"].isin(list(sala_c_within["Unnamed: 0.1"]))]

master["salary_am_ymd"] = master["nendo"].astype("int64").agg(lambda x: datetime.datetime(year=x,month=4,day=1))
master.loc[master["Unnamed: 0.1"].isin(list(sala_c_within["Unnamed: 0.1"])),"salary_am_ymd"] = sala_c_within["assembly_sala_apply_ymd_L1_dt"].values

#非連続的市町村（合併を伴わない改称、市制施行をしてデータに連続性がない市町村）の確認 → ok
master[master["pref_muni"]== "茨城県神栖市"]
salaries[salaries["pref_muni"]=="石川県野々市市"]

master[(master["salary_assembly_member"] != master["salary_am_kokuji"])&(master["salary_am_kokuji"].isnull()==False)] #OK

master[(master["nendo"] != 2021)&(master["salary_am_kokuji"].isnull())][["nendo","pref_muni"]]

master.to_csv("master_2005_1002.csv")

## 'salary_chair'
master = pd.read_csv("master_2005_1002.csv")

shift_m1 = sala_p.groupby("pref_muni")[['salary_chair','assembly_sala_apply_ymd','nendo']].shift(-1)
shift_m1.columns = ['salary_chair_L1','assembly_sala_apply_ymd_L1','nendo_L1']

sala_addl = pd.concat([sala_p[['pref_muni','salary_chair','nendo']],shift_m1],axis=1)

sala_changes = sala_addl[(sala_addl["salary_chair"] - sala_addl["salary_chair_L1"] != 0) & ((sala_addl["salary_chair"] - sala_addl["salary_chair_L1"]).isnull() == False)]

sala_c_ele = pd.merge(master,sala_changes[["pref_muni","nendo","salary_chair_L1","assembly_sala_apply_ymd_L1","nendo_L1"]],how="inner",on=["pref_muni","nendo"])

sala_c_ele[sala_c_ele["assembly_sala_apply_ymd_L1"] != sala_c_ele["assembly_sala_apply_ymd"]]["assembly_sala_apply_ymd_L1"].unique()

sala_ed = sala_c_ele[sala_c_ele["assembly_sala_apply_ymd_L1"] != sala_c_ele["assembly_sala_apply_ymd"]]

sala_ed["assembly_sala_apply_ymd_L1_dt"] = sala_ed["assembly_sala_apply_ymd_L1"].apply(lambda x: to_seireki_dt(x))

sala_ed["kokuji_dt"] = pd.to_datetime(sala_ed["kokuji_dt"])

sala_ed["nendo_start"] = sala_ed["nendo"].astype("int64").agg(lambda x: datetime.datetime(year=x,month=4,day=1))

sala_ed[(sala_ed["assembly_sala_apply_ymd_L1_dt"] < sala_ed["kokuji_dt"])&(sala_ed["assembly_sala_apply_ymd_L1_dt"] > sala_ed["nendo_start"])][["assembly_sala_apply_ymd_L1_dt","kokuji_dt"]].values

sala_c_within = sala_ed[(sala_ed["assembly_sala_apply_ymd_L1_dt"] < sala_ed["kokuji_dt"])&(sala_ed["assembly_sala_apply_ymd_L1_dt"] > sala_ed["nendo_start"])][["Unnamed: 0.1","salary_chair","salary_chair_L1","assembly_sala_apply_ymd_L1_dt"]]

master["salary_ch_kokuji"] = master["salary_chair"]
master.loc[master["Unnamed: 0.1"].isin(list(sala_c_within["Unnamed: 0.1"])),"salary_ch_kokuji"] = sala_c_within["salary_chair_L1"].values
master.loc[master["Unnamed: 0.1"].isin(list(sala_c_within["Unnamed: 0.1"]))]

master["salary_ch_ymd"] = master["nendo"].astype("int64").agg(lambda x: datetime.datetime(year=x,month=4,day=1))
master.loc[master["Unnamed: 0.1"].isin(list(sala_c_within["Unnamed: 0.1"])),"salary_ch_ymd"] = sala_c_within["assembly_sala_apply_ymd_L1_dt"].values

master[(master["salary_chair"] != master["salary_ch_kokuji"])&(master["salary_ch_kokuji"].isnull()==False)]

## 'salary_vice_chair'

shift_m1 = sala_p.groupby("pref_muni")[['salary_vice_chair','assembly_sala_apply_ymd','nendo']].shift(-1)
shift_m1.columns = ['salary_vice_chair_L1','assembly_sala_apply_ymd_L1','nendo_L1']

sala_addl = pd.concat([sala_p[['pref_muni','salary_vice_chair','nendo']],shift_m1],axis=1)

sala_changes = sala_addl[(sala_addl["salary_vice_chair"] - sala_addl["salary_vice_chair_L1"] != 0) & ((sala_addl["salary_vice_chair"] - sala_addl["salary_vice_chair_L1"]).isnull() == False)]

sala_c_ele = pd.merge(master,sala_changes[["pref_muni","nendo","salary_vice_chair_L1","assembly_sala_apply_ymd_L1","nendo_L1"]],how="inner",on=["pref_muni","nendo"])

sala_c_ele[sala_c_ele["assembly_sala_apply_ymd_L1"] != sala_c_ele["assembly_sala_apply_ymd"]]["assembly_sala_apply_ymd_L1"].unique()

sala_ed = sala_c_ele[sala_c_ele["assembly_sala_apply_ymd_L1"] != sala_c_ele["assembly_sala_apply_ymd"]]

sala_ed["assembly_sala_apply_ymd_L1_dt"] = sala_ed["assembly_sala_apply_ymd_L1"].apply(lambda x: to_seireki_dt(x))

sala_ed["kokuji_dt"] = pd.to_datetime(sala_ed["kokuji_dt"])

sala_ed["nendo_start"] = sala_ed["nendo"].astype("int64").agg(lambda x: datetime.datetime(year=x,month=4,day=1))

sala_ed[(sala_ed["assembly_sala_apply_ymd_L1_dt"] < sala_ed["kokuji_dt"])&(sala_ed["assembly_sala_apply_ymd_L1_dt"] > sala_ed["nendo_start"])][["assembly_sala_apply_ymd_L1_dt","kokuji_dt"]].values

sala_c_within = sala_ed[(sala_ed["assembly_sala_apply_ymd_L1_dt"] < sala_ed["kokuji_dt"])&(sala_ed["assembly_sala_apply_ymd_L1_dt"] > sala_ed["nendo_start"])][["Unnamed: 0.1","salary_vice_chair","salary_vice_chair_L1","assembly_sala_apply_ymd_L1_dt"]]

master["salary_vc_kokuji"] = master["salary_vice_chair"]
master.loc[master["Unnamed: 0.1"].isin(list(sala_c_within["Unnamed: 0.1"])),"salary_vc_kokuji"] = sala_c_within["salary_vice_chair_L1"].values
master.loc[master["Unnamed: 0.1"].isin(list(sala_c_within["Unnamed: 0.1"]))]

master["salary_vc_ymd"] = master["nendo"].astype("int64").agg(lambda x: datetime.datetime(year=x,month=4,day=1))
master.loc[master["Unnamed: 0.1"].isin(list(sala_c_within["Unnamed: 0.1"])),"salary_vc_ymd"] = sala_c_within["assembly_sala_apply_ymd_L1_dt"].values

master[(master["salary_vice_chair"] != master["salary_vc_kokuji"])&(master["salary_vc_kokuji"].isnull()==False)]

## 'salary_mayor'
master["mayor_sala_apply_ymd"]

shift_m1 = sala_p.groupby("pref_muni")[['salary_mayor','mayor_sala_apply_ymd','nendo']].shift(-1)
shift_m1.columns = ['salary_mayor_L1','mayor_sala_apply_ymd_L1','nendo_L1']

sala_addl = pd.concat([sala_p[['pref_muni','salary_mayor','nendo']],shift_m1],axis=1)

sala_changes = sala_addl[(sala_addl["salary_mayor"] - sala_addl["salary_mayor_L1"] != 0) & ((sala_addl["salary_mayor"] - sala_addl["salary_mayor_L1"]).isnull() == False)]

sala_c_ele = pd.merge(master,sala_changes[["pref_muni","nendo","salary_mayor_L1","mayor_sala_apply_ymd_L1","nendo_L1"]],how="inner",on=["pref_muni","nendo"])

sala_c_ele[sala_c_ele["mayor_sala_apply_ymd_L1"] != sala_c_ele["mayor_sala_apply_ymd"]]["mayor_sala_apply_ymd_L1"].unique()

sala_ed = sala_c_ele[sala_c_ele["mayor_sala_apply_ymd_L1"] != sala_c_ele["mayor_sala_apply_ymd"]]

sala_ed["mayor_sala_apply_ymd_L1_dt"] = sala_ed["mayor_sala_apply_ymd_L1"].apply(lambda x: to_seireki_dt(x))

sala_ed["kokuji_dt"] = pd.to_datetime(sala_ed["kokuji_dt"])

sala_ed["nendo_start"] = sala_ed["nendo"].astype("int64").agg(lambda x: datetime.datetime(year=x,month=4,day=1))

sala_ed[(sala_ed["mayor_sala_apply_ymd_L1_dt"] < sala_ed["kokuji_dt"])&(sala_ed["mayor_sala_apply_ymd_L1_dt"] > sala_ed["nendo_start"])][["mayor_sala_apply_ymd_L1_dt","kokuji_dt"]].values

sala_c_within = sala_ed[(sala_ed["mayor_sala_apply_ymd_L1_dt"] < sala_ed["kokuji_dt"])&(sala_ed["mayor_sala_apply_ymd_L1_dt"] > sala_ed["nendo_start"])][["Unnamed: 0.1","salary_mayor","salary_mayor_L1","mayor_sala_apply_ymd_L1_dt"]]

master["salary_mayor_kokuji"] = master["salary_mayor"]
master.loc[master["Unnamed: 0.1"].isin(list(sala_c_within["Unnamed: 0.1"])),"salary_mayor_kokuji"] = sala_c_within["salary_mayor_L1"].values
master.loc[master["Unnamed: 0.1"].isin(list(sala_c_within["Unnamed: 0.1"]))]

master["salary_mayor_ymd"] = master["nendo"].astype("int64").agg(lambda x: datetime.datetime(year=x,month=4,day=1))
master.loc[master["Unnamed: 0.1"].isin(list(sala_c_within["Unnamed: 0.1"])),"salary_mayor_ymd"] = sala_c_within["mayor_sala_apply_ymd_L1_dt"].values

master[(master["salary_mayor"] != master["salary_mayor_kokuji"])&(master["salary_mayor_kokuji"].isnull()==False)]

## 'salary_vice_mayor'
master["mayor_sala_apply_ymd"]

shift_m1 = sala_p.groupby("pref_muni")[['salary_vice_mayor','mayor_sala_apply_ymd','nendo']].shift(-1)
shift_m1.columns = ['salary_vice_mayor_L1','mayor_sala_apply_ymd_L1','nendo_L1']

sala_addl = pd.concat([sala_p[['pref_muni','salary_vice_mayor','nendo']],shift_m1],axis=1)

sala_changes = sala_addl[(sala_addl["salary_vice_mayor"] - sala_addl["salary_vice_mayor_L1"] != 0) & ((sala_addl["salary_vice_mayor"] - sala_addl["salary_vice_mayor_L1"]).isnull() == False)]

sala_c_ele = pd.merge(master,sala_changes[["pref_muni","nendo","salary_vice_mayor_L1","mayor_sala_apply_ymd_L1","nendo_L1"]],how="inner",on=["pref_muni","nendo"])

sala_c_ele[sala_c_ele["mayor_sala_apply_ymd_L1"] != sala_c_ele["mayor_sala_apply_ymd"]]["mayor_sala_apply_ymd_L1"].unique()

sala_ed = sala_c_ele[sala_c_ele["mayor_sala_apply_ymd_L1"] != sala_c_ele["mayor_sala_apply_ymd"]]

sala_ed["mayor_sala_apply_ymd_L1_dt"] = sala_ed["mayor_sala_apply_ymd_L1"].apply(lambda x: to_seireki_dt(x))

sala_ed["kokuji_dt"] = pd.to_datetime(sala_ed["kokuji_dt"])

sala_ed["nendo_start"] = sala_ed["nendo"].astype("int64").agg(lambda x: datetime.datetime(year=x,month=4,day=1))

sala_ed[(sala_ed["mayor_sala_apply_ymd_L1_dt"] < sala_ed["kokuji_dt"])&(sala_ed["mayor_sala_apply_ymd_L1_dt"] > sala_ed["nendo_start"])][["mayor_sala_apply_ymd_L1_dt","kokuji_dt"]].values

sala_c_within = sala_ed[(sala_ed["mayor_sala_apply_ymd_L1_dt"] < sala_ed["kokuji_dt"])&(sala_ed["mayor_sala_apply_ymd_L1_dt"] > sala_ed["nendo_start"])][["Unnamed: 0.1","salary_vice_mayor","salary_vice_mayor_L1","mayor_sala_apply_ymd_L1_dt"]]

master["salary_vice_mayor_kokuji"] = master["salary_vice_mayor"]
master.loc[master["Unnamed: 0.1"].isin(list(sala_c_within["Unnamed: 0.1"])),"salary_vice_mayor_kokuji"] = sala_c_within["salary_vice_mayor_L1"].values
master.loc[master["Unnamed: 0.1"].isin(list(sala_c_within["Unnamed: 0.1"]))]

master["salary_vice_mayor_ymd"] = master["nendo"].astype("int64").agg(lambda x: datetime.datetime(year=x,month=4,day=1))
master.loc[master["Unnamed: 0.1"].isin(list(sala_c_within["Unnamed: 0.1"])),"salary_vice_mayor_ymd"] = sala_c_within["mayor_sala_apply_ymd_L1_dt"].values

master[(master["salary_vice_mayor"] != master["salary_vice_mayor_kokuji"])&(master["salary_vice_mayor_kokuji"].isnull()==False)]

master.to_csv("master_2005_1002.csv")

master = pd.read_csv("master_2005_1002.csv")
#競争率の欠損除外バージョン・欠損埋めバージョン
master.loc[np.isinf(master["compe_rate_data"]),"n_wins_data"]

master[(master["n_wins_data"] != master["n_seats_display"])&(master["n_seats_display"].isnull() == False)&(master["n_seats_display"] != 0)][["ele_ymd","n_seats_display","n_wins_data"]].values

master[(master["n_seats_display"].isnull())|(master["n_seats_display"] == 0)|(master["n_seats_display"] == 1)|(master["n_seats_display"] == 2)][["ele_ymd","n_seats_display","n_wins_data"]].values

master[(master["n_cand_display"].isnull())|(master["n_cand_display"] == 0)|(master["n_cand_display"] == 1)|(master["n_cand_display"] == 2)][["ele_ymd","n_cand_display","n_cand_data"]].values #n_candは問題ない

#欠損は欠損バージョン
master["n_seats_isna"] = master["n_seats_display"]
master.loc[(master["n_seats_display"].isnull())|(master["n_seats_display"] == 0)|(master["n_seats_display"] == 1),"n_seats_isna"] = np.nan

master["compe_ratio_isna"] = master["n_cand_display"]/master["n_seats_isna"]

#欠損は勝者数で埋めるバージョン
master["n_seats_fillna"] = master["n_seats_display"]
master.loc[(master["n_seats_display"].isnull())|(master["n_seats_display"] == 0)|(master["n_seats_display"] == 1),"n_seats_fillna"] = master["n_wins_data"]

master[master["n_seats_fillna"] == 0]
master.loc[3769,"n_seats_fillna"] = 14 #"石井町議会議員選挙（2019年04月21日投票）"
master.loc[5592 ,"n_seats_fillna"] = 10 #"神戸町議会議員選挙（2019年04月21日投票）"

master["compe_ratio_fillna"] = master["n_cand_display"]/master["n_seats_fillna"]

master.to_csv("master_datas/master_2005_1002_fin.csv")
#


pd.read_excel("gappei_list.xls")


