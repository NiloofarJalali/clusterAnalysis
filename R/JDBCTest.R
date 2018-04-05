#
# bchQuery <- function( driverClss, classPth, usr, psw, outputPath, verbose = FALSE ){
#
#   drv <- RJDBC::JDBC(driverClass = driverClss , classPath = classPth )
#   conn <- RJDBC::dbConnect(drv, "jdbc:oracle:thin:@localhost:51524:ORCL", usr, psw )
#   # demog= RJDBC::dbGetQuery(conn,"SELECT * from ASD_GI.A00026337_OBSERVATION_FACT WHERE CONCEPT_CD LIKE 'ICD9:%'")
#   # demog=RJDBC::dbGetQuery(conn,"select * from ASD_GI.A00026337_PATIENT_DIM")
#      demog=RJDBC::dbGetQuery(conn,"select * from ASD_GI.CONCEPT_DIMENSION")
#
#   if( verbose == TRUE ){
#     message("The concept data.frame contains", nrow(demog ))
#   }
#
#  # where ROWNUM < 100000"
#   return(demog)
# }
#
# #options(java.parameters='-Xmx2g')
# options(java.parameters = "-Xmx8048m")
# # library(RJDBC)
# # bchData <- bchQuery(
# #   driverClss  = "oracle.jdbc.driver.OracleDriver",
# #   classPth    = "/Users/niloofar/Documents/db_drivers/ojdbc6.jar",
# #   usr         =  "NJ67",
# #   psw         =  "changeme",
# #   outputPath  = "/tmp"
# # )
#
#
# ConsAsdGi <- bchQuery(
#   driverClss  = "oracle.jdbc.driver.OracleDriver",
#   classPth    = "/Users/niloofar/Documents/db_drivers/ojdbc6.jar",
#   usr         =  "NJ67",
#   psw         =  "changeme",
#   outputPath  = "/tmp"
# )
# save(ConsAsdGi,file="/BCH/bchAnalysis/Data/inst/extdata/ConsAsdGi.Rdata")
# save(AgePhnAsdGi,file="/BCH/bchAnalysis/Data/inst/extdata/AgePhnAsdGi.Rdata")
