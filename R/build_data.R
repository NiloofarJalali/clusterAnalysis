#' A function in order to create the data set for the analysis
#' @param input Data frame containing clinical data file for analysis
#' @param codeRef XXXX
#' @param RefTable YYYY
#' @param minimumAge The minimum age for patients to be included in the analysis.
#' By default it is set to 0.
#' @param maximumAge The maximum age for patients to be included in the analysis.
#' By default it is set to 18.
#' @param refPath Contains the path and name of the phenotype mapping file
#' @export build_data

build_data<- function(input,codeRef,RefTable,refPath, minimumAge = 0, maximumAge = 18)
{
  pheWASMappingData=read.delim(refPath, header=FALSE, sep= ",",colClasses = "character")
  names(pheWASMappingData)[1]="ICD9"
  names(pheWASMappingData)[2]="ICD9String"
  names(pheWASMappingData)[3]="Phecode"
  names(pheWASMappingData)[4]="Phenotype"
  names(pheWASMappingData)[5]="ExclPhecodes"
  names(pheWASMappingData)[6]="Exclphenotypes"
  pheWASMappingData=pheWASMappingData[-1,]


  input=merge(input,codeRef[,c(2,3)],by="CONCEPT_CD")
  input=unique(input)
  Age=merge(RefTable[,c(1,3)], input, by="PATIENT_NUM")
  Age$BIRTH_DATE=sapply(strsplit(as.character(Age$BIRTH_DATE)," "), '[',1)
  Age$START_DATE=sapply(strsplit(as.character(Age$START_DATE)," "), '[',1)
  Age$age=floor(as.numeric(as.Date(Age$START_DATE) - as.Date(Age$BIRTH_DATE)) / 365)
  Age=unique(Age)

  AgeSelection= Age[ Age$age<= maximumAge & Age$age >= minimumAge, ]
  AgeSelection$code=sapply(strsplit(as.character(AgeSelection$CONCEPT_CD),":"), '[',2)

  output=merge(AgeSelection,pheWASMappingData[,c(1,4)],by.x="code",by.y="ICD9")

  return( output)
}
