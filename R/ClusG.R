#
#
# ClusG=function(lk,L){
#   Group=as.vector(na.omit(unique(lk$X2)))
#   ClusterP=data.frame()
#   D=list()
#   Pp=vector()
#   for (i in 1:length(Group))
#   {
#     # ClusterP[i,1]=Group[i]
#     c=as.vector(na.omit(lk[lk$X2==Group[i],1]))
#     # names(ClusterP)[1]="Group"
#     name=paste0("Subgroup",1:length(L))
#
#     D[[i]]=lapply(L, function(x) length(unique(x[x$Phenotype %in% c, 1]))*100/length(unique(x$PATIENT_NUM)))
#     R1=lapply(L, function(x) length(unique(x[x$Phenotype %in% c, 1])))
#     R2=lapply(L, function(x) length(unique(x$PATIENT_NUM))-length(unique(x[x$Phenotype %in% c, 1])))
#
#     Pp[i]=chisq.test(cbind(unlist(R1),unlist(R2)))[3]
#
#   }
#   D=do.call(rbind.data.frame, D)
#   Pp=do.call(rbind.data.frame,Pp)
#   names(D)=name
#   names(Pp)="Pval"
#   ClusterP=cbind(Group,D)
#   ClusterP=cbind(ClusterP,Pp)
#   alfa=0.05/nrow(ClusterP)
#   P=1-(1-0.05)^alfa
#   Nsg=ClusterP[ClusterP$Pval>P,1]
#
#   return(list(ClusterP,Nsg))}
