#
# sigor=function(df1,df2){
#   gg=na.omit(unique(lk$X2))
#   OR=vector()
# for (i in 1:length(gg)){
#                         ff=lk[lk$X2==gg[i],1]
#                         ff=as.vector(na.omit(ff))
#                         xx1=length(unique(df1[df1$Phenotype %in% ff,1 ]))
#                          xx2=length(unique(df1$PATIENT_NUM))-xx1
#                          xy1=length(unique(df2[df2$Phenotype %in% ff,1 ] ))
#                                            xy2=length(unique(df2$PATIENT_NUM))-xy1
#                                            OR[i]=(xx1*xy2)/(xx2*xy1)
# }
#   return(OR)}
#
#
# OR=sigor(xd1,xd2)
#
# # E is defined in barplot while showing the prevalence of different GI symptoms
#
# GIgor=function(df1,df2)
# {
#   OR=vector()
#  ff=unique(E$Phenotype)
# for (i in 1:length(ff)){
# xx1=length(unique(df1[df1$Phenotype %in% ff[i],1 ]))
# xx2=length(unique(df1$PATIENT_NUM))-xx1
# xy1=length(unique(df2[df2$Phenotype %in% ff[i],1 ] ))
# xy2=length(unique(df2$PATIENT_NUM))-xy1
# OR[i]=(xx1*xy2)/(xx2*xy1)
#
# }
# return(OR)}
# OR=GIgor(xd1,xd2)
