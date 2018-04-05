# library(ggplot2)
# Acom=function(inputref,var,n){
#   x1=which(colnames(inputref)== var)
#   x2=which(colnames(inputref)=="PATIENT_NUM")
#   unic=unique(inputref[,c(x1,x2)])
#   unic=plyr::count(unic[,var])
#   unic$ratio=(unic$freq*100)/length(unique(inputref[,x2]))
#   unic=unic[unic$ratio>=n,]
#   names(unic)[1]="code"
#   names(unic)[2]="freq"
#   names(unic)[3]="Prevalence"
#   unic=unic[order(unic$freq,decreasing=TRUE),]
#   return(unic)}
#
#
# K=Acom(rbind(GIAut,noAutGI),"code",5)
#
# K=lapply(L,function(x) Acom(x,"Phenotype",5))
#
# lapply(K,function(x) nrow(x))
