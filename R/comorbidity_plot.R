#' Comorbidity plot of clusters
#' @param clusterList  The list of different clusters
#' @param pval the selected pvalue for defining the significant of each comorbidity

#' @examples
#' example1 <- comorbidity_plot(
#'                       clusterList   =clusterList
#'                       pval= 0.05
#'                     )
#'
#'  @export comorbidity_plot

comorbidity_plot=function(clusterList,pval){
 library(ggplot2)
 comorbidity_group=read.delim(paste0(system.file("extdata", package = "clusterAnalysis"), "/Aggregated_comorbidity.csv"), header=FALSE, sep= ",",colClasses = "character")
 names(comorbidity_group)=comorbidity_group[1,]
 comorbidity_group=comorbidity_group[-1,]
 Phenotype=as.vector(na.omit(unique(comorbidity_group$Phenotype)))
 comorbidity_subgroup=data.frame()
  prevalence=list()
  Probability=vector()
  for (i in 1:length(Phenotype))
  {
     subgroup=as.vector(na.omit(comorbidity_group[comorbidity_group$Phenotype==Phenotype[i],1]))
     name=paste0("Subgroup",1:length(clusterList))
     prevalence[[i]]=lapply(clusterList, function(x) length(unique(x[x$Phenotype %in% subgroup, 1]))*100/length(unique(x$PATIENT_NUM)))
     R1=lapply(clusterList, function(x) length(unique(x[x$Phenotype %in% subgroup, 1])))
     R2=lapply(clusterList, function(x) length(unique(x$PATIENT_NUM))-length(unique(x[x$Phenotype %in% subgroup, 1])))
     Probability[i]=chisq.test(cbind(unlist(R1),unlist(R2)))[3]

   }
   prevalence=do.call(rbind.data.frame, prevalence)
   Probability=do.call(rbind.data.frame,Probability)
   names(prevalence)=name
   names(Probability)="Pval"
   comorbidity_subgroup=cbind(prevalence,Probability)
   rcomorbidity_subgroup=sapply(comorbidity_subgroup,function(x) round(x))
   comorbidity_subgroup=cbind(Phenotype,rcomorbidity_subgroup)
   comorbidity_plot=comorbidity_subgroup[,1:ncol(comorbidity_subgroup)-1]
   comorbidity_plot=reshape2::melt(comorbidity_plot)
   comorbidity_plot[,3]=round(comorbidity_plot[,3])
   names(comorbidity_plot)[2]="condition"
   names(comorbidity_plot)[3]="Prevalence"

   p=ggplot(comorbidity_plot, aes(fill=condition, y=Prevalence, x=Phenotype))+geom_col(position= "dodge")+scale_fill_discrete(drop=FALSE) +geom_text(size=4,aes(label=Prevalence), position = position_dodge(width = 0.5),vjust =-0.5, size = 1.5 ,hjust=1, inherit.aes = TRUE)
   p+  theme_bw()+theme(axis.text.x = element_text(size=14,angle = 75, hjust = 1),axis.title = element_text(size=14,face="bold"),legend.text = element_text(size=15)) + scale_fill_manual(values=c("#00BFFF","#DAA520", "#ADFF2F","#2F4F4F","#EEE0E5"))
   return(comorbidity_subgroup)
}

#
#
#
