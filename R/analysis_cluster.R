#' Clustering patients based on the disease
#'@param input  the dataframe having patientd ID and phenotype information
#'@param clusterSubject A vector of phenotypes or ICD-9 codes of disease of interest that is used to cluster the patients
#'@param clustermax Maximum threshold of number of clusters that is defined for mode-based cluster function
#'@param itermax Maximum number of iteration to analysis
#'@param mc number of cores for cluster Analysis
#'@param Model What Cluster model you are selecting!For example Model=Patients will cluster the patients based on different phenotypes
#'@examples
#' example1 <- analysis_cluster (
#'                     input                =ASDGI patients,
#'                     clusterSubject       =Gastrointestinal phenotypes,
#'                     clustermax            =5,
#'                     itermax              =200,
#'                     mc                   =2,
#'                     Model                =Phenotype)
#'
#' @export analysis_cluster



analysis_cluster=function(input,clusterSubject,Model,clustermax,itermax,mc){

  library(reshape2)
  library(fpc)

  L=list()
  selectInput=unique(input[,c("PATIENT_NUM","Phenotype")])
  V=names(selectInput)

  selectInput=selectInput[selectInput$Phenotype %in% clusterSubject,]
  MatrixInput=dcast(selectInput,Model~V[!V%in% Model])
  MatrixInput[is.na(MatrixInput)]=0
  ClusterObject=apply(MatrixInput[,2:ncol(MatrixInput)], c(1,2), function(x) ifelse(x!=0, 1, 0 ))
  ClusterObject=apply( ClusterObject, 2,as.numeric)
  ClusterObject= ClusterObject[,-1]
  CSR2=HDclassif::hddc( ClusterObject, K = 1:clustermax, model =c("akjbkqkdk"), threshold = 0.2,
                       criterion = "bic", com_dim = ncol( ClusterObject), itermax = itermax, eps = 0.05,
                       algo = "SEM", d_select = "Cattell", init = "mini-em", init.vector,
                       show = FALSE, mini.nb = c(5, 10), scaling = FALSE, min.individuals = 2,
                       noise.ctrl = 1e-08, mc.cores = mc, nb.rep = 1, keepAllRes = TRUE,
                       kmeans.control = list(), d_max =nrow( ClusterObject))


 clusterClass=data.frame(CSR2$class)
 clusterClass=cbind(clusterClass,MatrixInput[,1])
  names(clusterClass)[2]="V2"
  for(i in 1:length(unique(clusterClass$CSR2.class))){name=paste0("Class",i)
   x=clusterClass[clusterClass$CSR2.class==i,]
   x=input[input$PATIENT_NUM %in% x$V2,]
   assign(name,x)
   L[[i]]=x}

  return(L)
}
