#'Data Subgroups definition
#'@description  This function is used to define the subsets of disease and comorbidity and disease+comorbidity
#' @param input Main Data frame containing the disease and comorbidity
#' @param ICD_Disease   vector of ICD-9 codes (character) for selecting the disease
#' @param ICD_Comorbidity ICD-9 codes used for defining the comorbidity interval
#' @return A list of Data frames containing the Disease data, comorbidity data and Disease+comorbidity data
#' @examples
#'
#' example1 <- data_subset(
#'               input              = MasterData,
#'               ICD_Disease        =c(299.0,299.8,299.9),
#'               ICD_Comorbidity    =c(530,580,787,788)
#'
#'
#'               )
#' output is list of 4 elements
#' output[[1]]= dataset of Disease
#' output[[2]]= clusterSubjects
#' output[[3]]=dataset of comorbidity
#' output[[4]]=dataset of Disease+comorbidity
#'
#'
#' @export data_subset

data_subset=function(input,ICD_Disease,ICD_Comorbidity){
  library(knitr)
  library(plyr)

  diseaseData=input[grep(paste(as.character(ICD_Disease),collapse = "|"),input$code),]
  diseaseData=input[input$PATIENT_NUM %in% diseaseData$PATIENT_NUM,]
  noInterestCode=input[grep(paste(c("V","E"),collapse = "|"),input$code,ignore.case=TRUE),]
  filterData=input[!input$code %in% noInterestCode$code,]
  filterData$code <- as.numeric(as.character(filterData$code))
  clusterSubject=filterData[filterData$code>=ICD_Comorbidity[1] & filterData$code<ICD_Comorbidity[2] | filterData$code>=ICD_Comorbidity[3] & filterData$code<ICD_Comorbidity[4],]
  clusterSubject=unique(clusterSubject)
  clusterSubject=unique(input[input$Phenotype %in% clusterSubject$Phenotype,])
  comorbidityData=input[input$PATIENT_NUM %in% clusterSubject$PATIENT_NUM,]
  clusterSubject=unique(clusterSubject$Phenotype)
  DiseaseComoData=diseaseData[diseaseData$PATIENT_NUM %in% comorbidityData$PATIENT_NUM, ]

  return(list(diseaseData,clusterSubject,comorbidityData,DiseaseComoData))
}






