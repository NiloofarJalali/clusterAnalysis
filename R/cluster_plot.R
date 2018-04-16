#' Plot of clusters
#' @param clusterList  The list of different clusters
#' @param clusterSubject  vector of disease symptoms that are used fro clustering
#' @param n the minimum prevalence threshold

#' @examples
#' example1 <- cluster_plot(
#'                       clusterList     =clusterList,
#'                       clusterSubject  =clusterSubject,
#'                       n               =5
#'                     )
#'
#'  @export cluster_plot

cluster_plot=function(clusterList,clusterSubject,n){

   library(ggplot2)

  xdG=lapply(clusterList,function(x) Gplot(x,clusterSubject,n))

  for (i in 1:length(xdG)){
    b=xdG[[i]]
    name=paste0("p(Dx|Subgroup",i,")")
    b$condition=rep(name,nrow(b))
    name2=paste0("T",i)
    assign(name2,b)
  }

  E=Reduce("rbind", mget(paste0("T", 1:length(clusterList))))
  E=E[,c(1,3,4)]
  p=ggplot(E, aes(fill=condition, y=Prevalence, x=Phenotype))+geom_col(position= "dodge")+scale_fill_discrete(drop=FALSE) +geom_text(size=4,aes(label=Prevalence), position = position_dodge(width = 0.5),vjust =-0.5, size = 1.5 ,hjust=0.8, inherit.aes = TRUE)
  p+  theme_bw()+theme(axis.text.x = element_text(size=12,angle = 75, hjust = 1),axis.title = element_text(size=12,face="bold"),legend.text = element_text(size=12)) + scale_fill_manual(values=c("#00BFFF","#DAA520", "#ADFF2F","#2F4F4F","#EEE0E5"))

}
