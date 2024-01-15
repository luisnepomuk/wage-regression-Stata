use "C:\wage.dta" 
ssc install estout

* regressions
reg lsalary pubindx totpge yearphd
estimates store test1
reg lsalary pubindx totpge yearphd female osu iowa indiana msu minn mich wisc illinois
estimates store test2
reg lsalary pubindx totpge yearphd female osu iowa indiana msu minn mich wisc illinois prof exper year
estimates store test3
esttab test* using salaryreg.rtf, star(* .1 ** .05 *** .01) r2 nogap
reg lsalary pubindx totpge yearphd female osu iowa indiana msu minn mich wisc illinois prof exper year
predict uhat, r
predict yhat, xb
gen uhatsq=uhat*uhat
gen yhatsq=yhat*yhat
reg uhatsq pubindx totpge yearphd female osu iowa indiana msu minn mich wisc illinois prof exper year
estimates store bptest
esttab testbp using bptest.rtf
reg uhatsq yhat yhatsq
estimates store whitetest
esttab testbp using whitetest.rtf
reg lsalary pubindx totpge yearphd female osu iowa indiana msu minn mich wisc illinois prof exper year
hettest
reg lsalary pubindx totpge yearphd, robust
estimates store rtest1
reg lsalary pubindx totpge yearphd female osu iowa indiana purdue msu minn mich wisc illinois, robust
estimates store rtest2
reg lsalary pubindx totpge yearphd female osu iowa indiana msu minn mich wisc illinois, robust
estimates store rtest2
reg lsalary pubindx totpge yearphd female osu iowa indiana msu minn mich wisc illinois prof exper year, robust
estimates store rtest3
esttab rtest* using rsalaryreg.rtf, star(* .1 ** .05 *** .01) r2 nogap

* chow test
reg lsalary year pubindx totpge if female==0
estimates store fem1
reg lsalary year pubindx totpge if female==1
estimates store fem2
esttab fem* using chowtest.rtf, star(* .1 ** .05 *** .01) r2 nogap
reg lsalary i.female##c.year i.female##c.pubindx i.female##c.totpge
contrast female i.female#c.year i.female#c.pubindx i.female#c.totpge, overall

* proxy variable regression
reg lwage educ exper tenure hours age
estimates store noproxytest
reg lwage educ exper tenure hours age IQ KWW
estimates store proxytest
esttab noproxytest proxytest using wage2reg.rtf, star(* .1 ** .05 *** .01) r2 nogap
