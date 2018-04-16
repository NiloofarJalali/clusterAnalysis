#' Gplot
#' @param input_data  The dataframe used to the prevalence of data
#' @param clusterSubject  vector of disease symptoms that are used fro clustering
#' @param n the minimum prevalence threshold

#' @examples
#' example1 <- Gplot(
#'                      input_data    =GIAut,
#'                       clusterSubject  =clusterSubject,
#'                       n               =5
#'                     )
#'
#'  @export Gplot




Gplot=function(input_data,clusterSubject,n){
  diseaseData=input_data[input_data$Phenotype %in% clusterSubject,]
  diseaseData=unique( diseaseData[,c("PATIENT_NUM","Phenotype")])
  phenotype_count=plyr::count( diseaseData$Phenotype)
  phenotype_count$pre=round(phenotype_count$freq*100/length(unique(diseaseData$PATIENT_NUM)))
  phenotype_count=phenotype_count[phenotype_count$pre>=n,]
  names(phenotype_count)[1]="Phenotype"
  names(phenotype_count)[3]="Prevalence"
  return(phenotype_count)}
