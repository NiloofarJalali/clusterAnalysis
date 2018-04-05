# paircomorbidity=function(group,inputref){
#   p=vector()
#   OR=vector()
#   L=list()
#
#  for (i in 1:length(group)){
#
#    j=1
#    while(i+j<=length(group)){
#    com1=as.vector(na.omit(lk[lk$X2==group[i],1]))
#    com2=as.vector(na.omit(lk[lk$X2==group[i+j],1]))
#    GA1=inputref[inputref$Phenotype %in% com1,]
#    GA2=inputref[inputref$Phenotype %in% com2,]
#    a=length(unique(GA1[GA1$PATIENT_NUM %in% GA2$PATIENT_NUM,1 ]))
#    b=length(unique(GA1[!GA1$PATIENT_NUM %in% GA2$PATIENT_NUM,1 ]))
#    c=length(unique(GA2[!GA2$PATIENT_NUM %in% GA1$PATIENT_NUM,1 ]))
#    d=length(unique(inputref[!inputref$PATIENT_NUM %in% c(GA1$PATIENT_NUM,GA2$PATIENT_NUM),1]))
#    p[j]=chisq.test(matrix(c(a,c,b,d),nrow=2,ncol=2))[3]
#    OR[j]=(a*d)/(b*c)
#    j=j+1
#    }
#    # L[[i]]=cbind(unlist(p),OR)
#    L[[i]]=cbind(group[-i],OR)
#  }
# # L=lapply(L,function(x) cbind(group[-i],x[,2]))
# #L=Reduce(function(dtf1, dtf2) merge(dtf1, dtf2, by = "group", all = TRUE), L)
# return(L)
# }
#
#
#
#
# inputref=rbind(GIAut,noAutGI)
# group=unique(as.vector(na.omit(lk$X2)))
# H=paircomorbidity(group,inputref)
