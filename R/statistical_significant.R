#'Statistical Significant test
#'@description This function is used to test significance of comorbidities between two subsets of data.
#'@param DiseaseData1  The primary data frame for defining its associated comorbidities (PAITNET_ID and Phenotype is used)
#'@param DiseaseData2  The secondary data frame for comparing the association with primary data frame
#'@param pval          The original p-value before bonferroni multiple testing correction
#'@param ORmin         The minimum acceptable value for Odd Ratio
#'@param countmin      The minimum acceptable count of patients from both groups having the same comorbidity
#'@example
#'Finding the significant comorbidities associated to ASD patients having GI (Gastrointestinal disease)
#'    example1 <- ClusterAnalysis(
#'                     DiseaseData1                =GIASD,
#'                     DiseaseData2                =noGIASD,
#'                     pval                        =0.05
#'                     ORmin                       =1.9
#'                     countmin                    =10
#'                         )
#'
#'
#'@export statistical_significant







statistical_significant=function(DiseaseData1,DiseaseData2,pval,ORmin,countmin){

  diseaseCount1=plyr::count(unique(DiseaseData1[,c("PATIENT_NUM","Phenotype")])[,2])
  diseaseCount1= diseaseCount1[order(diseaseCount1$freq,decreasing=TRUE),]

  diseaseCount2=plyr::count(unique(DiseaseData2[,c("PATIENT_NUM","Phenotype")])[,2])
  diseaseCount2= diseaseCount2[order( diseaseCount2$freq,decreasing= TRUE),]


  statResult=merge(diseaseCount1,diseaseCount2,by="x")

  for(i in 1:nrow(statResult)){statResult[i,4]=length(unique(DiseaseData1$PATIENT_NUM))-statResult[i,2]
  statResult[i,5]=length(unique(DiseaseData2$PATIENT_NUM))-statResult[i,3]

  Q=matrix(c(statResult[i,2],statResult[i,3],statResult[i,4],statResult[i,5]),nrow=2,ncol=2)
  statResult[i,6]=chisq.test(Q)[3]
  statResult[i,7]=(statResult[i,2]*statResult[i,5])/(statResult[i,3]*statResult[i,4])
  statResult[i,8]=exp(log(exp(statResult[i,7]))-1.96*sqrt(statResult[i,2]^-1+statResult[i,3]^-1+statResult[i,4]^-1+statResult[i,5]^-1))
  statResult[i,9]=exp(log(exp(statResult[i,7]))+1.96*sqrt(statResult[i,2]^-1+statResult[i,3]^-1+statResult[i,4]^-1+statResult[i,5]^-1))

  }
  statResult=statResult[order(statResult[,2],decreasing=TRUE),]
  names(statResult)[1]="Phenotype"
  names(statResult)[2]="D1+D2+"
  names(statResult)[3]="D1-D2+"
  names(statResult)[4]="D1+D2-"
  names(statResult)[5]="D1-D2-"
  names(statResult)[7]="OR"
  names(statResult)[8]="CI-"
  names(statResult)[9]="CI+"
  statResult=na.omit(statResult)
  ###FDA multiple testing
  alfa=nrow(statResult)
  P=pval/alfa
  # beta=pval/alfa
  # P=1-(1-beta)^alfa
  statResult=statResult[statResult$p.value<=P,]
  statResult=statResult[statResult[,2]>=countmin,]
  statResult=statResult[statResult$OR>=ORmin,]

  for (i in 2:ncol(statResult)){statResult[,i]=sign(statResult[,i]) * ceiling(abs(statResult[,i]) * 100) / 100}
   for (i in 1:ncol(statResult)){statResult[,i]=prettyNum(statResult[,i],big.mark=",",scientific=FALSE)}

  return(statResult)
}



