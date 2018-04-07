#' #'Data Subgroups definition
#' #' @param input Main Data frame containing the disease and comorbidity
#' #' @param ICD_Disease   vector of ICD-9 codes (character) for selecting the disease
#' #' @param ICD_Comorbidity ICD-9 codes for selecting the comorbidity
#' #' @param varnoInterest ICD-9 categorical codes
#' #' @return A list of Data frames containing the Disease data, Comorbidity data and Disease+comorbidity data
#' #' @examples
#' #'
#' #' example1 <- data_subset(
#' #'               input              = MasterData,
#' #'               ICD_Disease        =c("299.0","299.8","299.9"),
#' #'               ICD_Comorbidity    =c(530,580,787,788)
#' #'               varnoInterest      = c("V","E"),
#' #'
#' #'               )
#' #' @export list(diseaseData,comorbidityData,DiseaseComoData)
#'
#' data_subset=function(input,ICD_Disease,ICD_Comorbidity,varnoInterest){
#'   library(knitr)
#'   library(plyr)
#'
#'   diseaseData=input[grep(paste(ICD_Disease,collapse = "|"),input$code),]
#'   diseaseData=input[input$PATIENT_NUM %in% diseaseData$PATIENT_NUM,]
#'   noInterestCode=input[grep(paste(varnoInterest,collapse = "|"),input$code,ignore.case=TRUE),]
#'   filterData=input[!input$code %in% noInterestCode$code,]
#'   filrerData$code <- as.numeric(as.character(filterData$code))
#'   comorbidityData=filterData[filterData$code>=ICD_Comorbidity[1] & filterData$code<ICD_Comorbidity[2] | filterData$code>=ICD_Comorbidity[3] & filterData$code<ICD_Comorbidity[4],]
#'   comorbidityData=unique(comorbidityData)
#'   comorbidityData=unique(input[input$Phenotype %in% comorbidityData$Phenotype,])
#'   DiseaseComoData=diseaseData[diseaseData$PATIENT_NUM %in% comorbidityData$PATIENT_NUM, ]
#'
#'   return(list(diseaseData,comorbidityData,DiseaseComoData))
#' }
#'
#'
#'
#'
#'
#'
