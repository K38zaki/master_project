import pandas as pd

url = 'https://info.finance.yahoo.co.jp/ranking/?kd=4'
dfs = pd.read_html(url)

print(len(dfs))

dfs[0]

url = "https://seijiyama.jp/area/card/3624/Ckovig/M?S=lcqdt0lasgq0k"
dfs = pd.read_html(url,encoding='utf-8')
len(dfs)
dfs[1].dropna(how="all")
dfs[0].iloc[1,0].replace('\xa0', ' ')[-2:]
dfs[0]
