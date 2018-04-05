#
#
# SSA=function(inputF,inputR){
#
#   var1="PATIENT_NUM"
#   var2="Phenotype"
#   x2=which( colnames(inputF)==var2 )
#   x1=which( colnames(inputF)==var1 )
#
#   x4=which( colnames(inputR)==var2 )
#   x3=which( colnames(inputR)==var1 )
#
#   A=plyr::count(unique(inputF[,c(x1,x2)])[,2])
#   A=A[order(A$freq,decreasing= TRUE),]
#
#
#
#   W=plyr::count(unique(inputR[,c(x3,x4)])[,2])
#   W=W[order(W$freq,decreasing=TRUE),]
#
#
#   W=merge(W,A,by="x")
#   alfa=nrow(W)
#
#   for(i in 1:nrow(W)){W[i,4]=length(unique(inputR$PATIENT_NUM))-W[i,2]
#   W[i,5]=length(unique(inputF$PATIENT_NUM))-W[i,3]
#
#   Q=matrix(c(W[i,2],W[i,3],W[i,4],W[i,5]),nrow=2,ncol=2)
#   W[i,6]=chisq.test(Q)[3]
#   W[i,7]=(W[i,2]*W[i,5])/(W[i,3]*W[i,4])
#   W[i,8]=exp(log(exp(W[i,7]))-1.96*sqrt(W[i,2]^-1+W[i,3]^-1+W[i,4]^-1+W[i,5]^-1))
#   W[i,9]=exp(log(exp(W[i,7]))+1.96*sqrt(W[i,2]^-1+W[i,3]^-1+W[i,4]^-1+W[i,5]^-1))
#
#   }
#   W=W[order(W[,2],decreasing=TRUE),]
#   names(W)[1]="Phenotype"
#   names(W)[2]="D1+D2+"
#   names(W)[3]="D1-D2+"
#   names(W)[4]="D1+D2-"
#   names(W)[5]="D1-D2-"
#   names(W)[7]="OR"
#   names(W)[8]="CI-"
#   names(W)[9]="CI+"
#   W=na.omit(W)
#   ###FDA multiple testing
#   beta=0.05/alfa
#   P=1-(1-beta)^alfa
#   W=W[W$p.value<=P,]
#   W=W[W[,2]>=10,]
#   W=W[W$OR>=1.9,]
#   # W[,2]=sapply(W[,2],function(x) as.numeric(x))
#
#   for (i in 2:ncol(W)){W[,i]=sign(W[,i]) * ceiling(abs(W[,i]) * 100) / 100}
#  # for ( i in 2:ncol(W)){W[,i]=format(round(W[,i], 2), nsmall = 2)}
#    for (i in 1:ncol(W)){W[,i]=prettyNum(W[,i],big.mark=",",scientific=FALSE)}
#
#   return(W)
# }



