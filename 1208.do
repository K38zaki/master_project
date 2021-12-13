webuse abdata

regress n nL1 nL2 w wL1 k kL1 kL2 ys ysL1 ysL2 yr*

ivregress 2sls D.n (D.nL1= nL2) D.(nL2 w wL1 k kL1 kL2 ys ysL1 ysL2 yr1979 yr1980 yr1981 yr1982 yr1983)

xtabond2 n L.n L2.n w L.w L(0/2).(k ys) yr*, gmm(L.n) iv(w L.w L(0/2).(k ys) yr*) nolevel twostep small

margins, dydx(w) at(w = (2 (.5) 4)) 
margins,  at(w = (2 (.5) 4))

drop n_fit
predict n_fit, xb

margins

scatter n_fit n

hist n_fit