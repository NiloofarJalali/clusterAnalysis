#' Data preparation function
#' @param observationData Data frame containing Observation data file
#' @param conceptData  Data frame containing Concept data file
#' @param demogData Data frame containing Demogeraphic data file
#' @param minimumAge The minimum age for patients to be included in the analysis.
#' By default it is set to 0.
#' @param maximumAge The maximum age for patients to be included in the analysis.
#' By default it is set to 18.
#' @export build_data

build_data<- function(observationData,conceptData,demogData, minimumAge = 0, maximumAge = 18)
{
  pheWASMappingData=read.delim(paste0(system.file("extdata", package = "clusterAnalysis"), "/phecode_icd9_rolled.csv"), header=FALSE, sep= ",",colClasses = "character")
  names(pheWASMappingData)[1]="ICD9"
  names(pheWASMappingData)[2]="ICD9String"
  names(pheWASMappingData)[3]="Phecode"
  names(pheWASMappingData)[4]="Phenotype"
  names(pheWASMappingData)[5]="ExclPhecodes"
  names(pheWASMappingData)[6]="Exclphenotypes"
  pheWASMappingData=pheWASMappingData[-1,]


  observationData=merge(observationData,conceptData[,c("CONCEPT_CD","NAME_CHAR")],by="CONCEPT_CD")
  observationData=unique(observationData)
  Age=merge(demogData[,c("PATIENT_NUM","BIRTH_DATE")], observationData, by="PATIENT_NUM")
  Age$BIRTH_DATE=sapply(strsplit(as.character(Age$BIRTH_DATE)," "), '[',1)
  Age$START_DATE=sapply(strsplit(as.character(Age$START_DATE)," "), '[',1)
  Age$age=floor(as.numeric(as.Date(Age$START_DATE) - as.Date(Age$BIRTH_DATE)) / 365)
  Age=unique(Age)

  AgeSelection= Age[ Age$age<= maximumAge & Age$age >= minimumAge, ]
  AgeSelection$code=sapply(strsplit(as.character(AgeSelection$CONCEPT_CD),":"), '[',2)

  output=merge(AgeSelection,pheWASMappingData[,c(1,4)],by.x="code",by.y="ICD9")

  return( output)
}
