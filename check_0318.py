import numpy as np
import pickle
import xarray as xr
import pandas as pd
import matplotlib.pyplot as plt

with open('municipality_counsil_salary.pkl', 'rb') as f:
    ds = pickle.load(f)
f.close()

# within variation と bitween variation (salary)
#within
ave_l = (ds[2018].sel(variables="salary_council").values + ds[2014].sel(variables="salary_council").values)/2
d_18 = ds[2018].sel(variables="salary_council").values
d_14 = ds[2014].sel(variables="salary_council").values
s_18 = sum((d_18 - ave_l)**2)
s_14 = sum((d_14 - ave_l)**2)
within = (s_18+s_14)/(2*len(d_18)-1)
within
#betweem
a_ave = np.mean(ave_l) 
between = sum((ave_l - a_ave)**2)/len(ave_l)
print(within,between)
