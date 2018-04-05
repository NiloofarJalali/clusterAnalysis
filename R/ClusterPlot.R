ClusterPlot=function(L,refgroup,n){
  library(ggplot2)
   Gplot=function(inputref,inputg,n){
    gautdata=inputref[inputref$Phenotype %in% inputg$Phenotype,]
    gautdata=unique(gautdata[,c(1,28)])
    d=plyr::count(gautdata$Phenotype)
    d$pre=round(d$freq*100/length(unique(gautdata$PATIENT_NUM)))
    d=d[d$pre>=n,]
    names(d)[1]="Phenotype"
    names(d)[3]="Prevalence"
    return(d)}
   
  xdG=lapply(L,function(x) Gplot(x,refgroup,n))
  
  for (i in 1:length(xdG)){ 
    b=xdG[[i]]
    name=paste0("p(Dx|Subgroup",i,")")
    b$condition=rep(name,nrow(b))
    name2=paste0("T",i)
    assign(name2,b)
  }
  
  E=Reduce("rbind", mget(paste0("T", 1:length(L))))
  E=E[,c(1,3,4)]
  p=ggplot(E, aes(fill=condition, y=Prevalence, x=Phenotype))+geom_bar(position= position_dodge(preserve ="single"),stat="identity",width = 0.9) +geom_text(size=4,aes(label=Prevalence), position = position_dodge(width = 0.5),vjust =-0.5, size = 1.5 ,hjust=0.8, inherit.aes = TRUE)
  p+  theme_bw()+theme(axis.text.x = element_text(size=12,angle = 75, hjust = 1),axis.title = element_text(size=12,face="bold"),legend.text = element_text(size=12)) + scale_fill_manual(values=c("#00BFFF","#DAA520", "#ADFF2F","#2F4F4F","#EEE0E5"))
  
}