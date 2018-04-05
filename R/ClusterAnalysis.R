#'@param input  the Subset of data that need to be clustered (The patientd ID and phenotype are used)
#'@param refgroup the disease group that the cluster ( the table having ICD9 and phenotype of selected disease)
#'
#' example1 <- ClusterAnalysis( GIAut, Gdata)
#'
#' @export GiSelection




#
#
# ClusterAnalysis=function(input,refgroup){
#   library(reshape2)
#   library(fpc)
#   L=list()
#   S1=unique(GI[,c("PATIENT_NUM","Phenotype")])
#   S1=S1[S1$Phenotype %in% refgroup$Phenotype,]
#   A12=dcast(S1,PATIENT_NUM~Phenotype)
#   A12[is.na(A12)]=0
#   A23=apply(A12[,2:ncol(A12)], c(1,2), function(x) if (x!=0) x=1 else(x=0))
#   A23=apply(A23, 2,as.numeric)
#   A23=A23[,-1]
#   CSR2=HDclassif::hddc(A23, K = 1:5, model =c("akjbkqkdk"), threshold = 0.2,
#                        criterion = "bic", com_dim = ncol(A23), itermax = 150, eps = 0.05,
#                        algo = "SEM", d_select = "Cattell", init = "mini-em", init.vector,
#                        show = FALSE, mini.nb = c(5, 10), scaling = FALSE, min.individuals = 2,
#                        noise.ctrl = 1e-08, mc.cores = 1, nb.rep = 1, keepAllRes = TRUE,
#                        kmeans.control = list(), d_max =nrow(A23))
#
#
#   xd=data.frame(CSR2$class)
#   xd=cbind(xd,A12[,1])
#   names(xd)[2]="V2"
#   for(i in 1:length(unique(xd$CSR2.class))){name=paste0("xd",i)
#    x=xd[xd$CSR2.class==i,]
#    x=input[input$PATIENT_NUM %in% x$V2,]
#    assign(name,x)
#    L[[i]]=x}
#
#   return(L)
# }
