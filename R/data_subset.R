#'Data Subgroups definition
#'@description  This function is used to define the subsets of disease and comorbidity and disease+comorbidity
#' @param input Main Data frame containing the disease and comorbidity
#' @param ICD_Disease   vector of ICD-9 codes (character) for selecting the disease
#' @param ICD_Comorbidity ICD-9 codes used for defining the comorbidity interval
#' @param varnoInterest ICD-9 categorical codes
#' @return A list of Data frames containing the Disease data, comorbidity data and Disease+comorbidity data
#' @examples
#'
#' example1 <- data_subset(
#'               input              = MasterData,
#'               ICD_Disease        =c(299.0,299.8,299.9),
#'               ICD_Comorbidity    =c(530,580,787,788)
#'               varnoInterest      = c("V","E"),
#'
#'               )
#' output is list of 3 elements
#' output[[1]]= dataset of Disease
#' output[[2]]=dataset of comorbidity
#' output[[3]]=dataset of Disease+comorbidity
#'
#'
#' @export data_subset

data_subset=function(input,ICD_Disease,ICD_Comorbidity,varnoInterest){
  library(knitr)
  library(plyr)

  diseaseData=input[grep(paste(as.character(ICD_Disease),collapse = "|"),input$code),]
  diseaseData=input[input$PATIENT_NUM %in% diseaseData$PATIENT_NUM,]
  noInterestCode=input[grep(paste(varnoInterest,collapse = "|"),input$code,ignore.case=TRUE),]
  filterData=input[!input$code %in% noInterestCode$code,]
  filterData$code <- as.numeric(as.character(filterData$code))
  comorbiditySubject=filterData[filterData$code>=ICD_Comorbidity[1] & filterData$code<ICD_Comorbidity[2] | filterData$code>=ICD_Comorbidity[3] & filterData$code<ICD_Comorbidity[4],]
  comorbiditySubject=unique(comorbiditySubject)
  comorbiditySubject=unique(input[input$Phenotype %in% comorbiditySubject$Phenotype,])
  comorbidityData=input[input$PATIENT_NUM %in% comorbiditySubject$PATIENT_NUM,]
  comorbiditySubject=unique(comorbiditySubject$Phenotype)
  DiseaseComoData=diseaseData[diseaseData$PATIENT_NUM %in% comorbidityData$PATIENT_NUM, ]

  return(list(diseaseData,comorbiditySubject,comorbidityData,DiseaseComoData))
}






