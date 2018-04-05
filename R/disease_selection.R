#' A function to select a subset of patients  diagnosed with a specific disease
#' @param input  Clincial records with Diagnosis
#' @param varnoInterest The subset of codes that are not used to define the disease of interest
#' @param varInterest The subset of codes that are used to define the disease of interest
#' @param verbose By default \code{FALSE}. Change it to \code{TRUE} to get a
#' on-time log from the function.
#' @return An object of class \code{data.frame} with the query output.
#' @export disease_selection


disease_selection <-function(input, varInterest,varnoInterest)
{
  input=input[,c(1,2,5,7,27,28)]

  patientExcluded1 = input[grep(varnoInterest[1],input$code,ignore.case=TRUE),]
  patientExcluded2 = input[grep(varnoInterest[2],input$code,ignore.case=TRUE),]

  allpatientsExcluded = rbind(patientExcluded1, patientExcluded2)

  dataFiltered = input[!input$code %in% allpatientsExcluded$code,]
  dataFiltered$code <- as.numeric(as.character( dataFiltered$code))

  dataSelection1 = dataFiltered[dataFiltered$code>=varInterest[1] & dataFiltered$code<varInterest[2],]
  dataSelection2 = dataFiltered[dataFiltered$code>=varInterest[3] & dataFiltered$code<varInterest[4],]

  Gdata=rbind(dataSelection1,dataSelection2)
  Gdata=unique(Gdata)
  Gdata=unique(input[input$Phenotype %in% Gdata$Phenotype,])

  NoG=input[!input$PATIENT_NUM %in% Gdata$PATIENT_NUM,]
  GIAut=input[input$PATIENT_NUM %in% Gdata$PATIENT_NUM,]

  return(list(Gdata,GIAut,NoG) )

}

