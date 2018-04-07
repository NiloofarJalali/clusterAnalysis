# #
# #
# # comorbidity_plot=function(L,pval){
#   comorbidity_group=read.delim(paste0(system.file("extdata", package = "clusterAnalysis"), "/Aggregated_comorbidity.csv"), header=FALSE, sep= ",",colClasses = "character")
#   names(comorbidity_group)[3]="Phenotype" 
#   Phenotype=as.vector(na.omit(unique(comorbidity_group$Phenotype)))
#   comorbidity_subgroup=data.frame()
#    prevalence=list()
#    Probability=vector()
#    for (i in 1:length(Phenotype))
#    {
#      subgroup=as.vector(na.omit(comorbidity_group[comorbidity_group$Phenotype==Phenotype[i],1]))
#      name=paste0("Subgroup",1:length(L))
#      prevalence[[i]]=lapply(L, function(x) length(unique(x[x$Phenotype %in% subgroup, 1]))*100/length(unique(x$PATIENT_NUM)))
#      R1=lapply(L, function(x) length(unique(x[x$Phenotype %in% subgroup, 1])))
#      R2=lapply(L, function(x) length(unique(x$PATIENT_NUM))-length(unique(x[x$Phenotype %in% subgroup, 1])))
#      Probability[i]=chisq.test(cbind(unlist(R1),unlist(R2)))[3]
# 
#    }
#    prevalence=do.call(rbind.data.frame, prevalence)
#    Probability=do.call(rbind.data.frame,Probability)
#    names(prevalence)=name
#    names(Probability)="Pval"
#    comorbidity_subgroup=cbind(Phenotype,prevalence)
#    comorbidity_subgroup=cbind(comorbidity_subgroup,Probability)
#    comorbidity_plot=comorbidity_subgroup[,1:ncol(comorbidity_subgroup)-1]
#    comorbidity_plot=reshape2::melt(comorbidity_plot)
#    comorbidity_plot[,3]=round(comorbidity_plot[,3])
#    names(comorbidity_plot)[2]="condition"
#    names(comorbidity_plot)[3]="Prevalence"
# 
#    p=ggplot(comorbidity_plot, aes(fill=condition, y=Prevalence, x=Group))+geom_bar(position= position_dodge(preserve ="single"),stat="identity",width = 0.9) +geom_text(size=4,aes(label=Prevalence), position = position_dodge(width = 0.5),vjust =-0.5, size = 1.5 ,hjust=1, inherit.aes = TRUE)
#    p+  theme_bw()+theme(axis.text.x = element_text(size=14,angle = 75, hjust = 1),axis.title = element_text(size=14,face="bold"),legend.text = element_text(size=15)) + scale_fill_manual(values=c("#00BFFF","#DAA520", "#ADFF2F","#2F4F4F","#EEE0E5"))
# 
# # }
# #
# #
# #