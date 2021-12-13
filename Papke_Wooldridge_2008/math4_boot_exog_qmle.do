capture program drop math4_boot

program math4_boot, rclass

glm math4 lavgrexp alavgrexp lunch alunch lenroll alenroll y96-y01 if year>1994, fa(bin) link(probit) cluster(distid)

predict x1b1hat, xb
gen scale=normalden(x1b1hat)
gen pe1=scale*_b[lavgrexp]
summarize pe1
return scalar ape1=r(mean)
gen pe2=scale*_b[lunch]
summarize pe2
return scalar ape2=r(mean)
gen pe3=scale*_b[lenroll]
summarize pe3
return scalar ape3=r(mean)

drop x1b1hat scale pe1 pe2 pe3
end


*Bootstrapped SE within districts
bootstrap r(ape1) r(ape2) r(ape3), reps(500) seed(123) cluster(distid) idcluster(newid): math4_boot

program drop math4_boot



