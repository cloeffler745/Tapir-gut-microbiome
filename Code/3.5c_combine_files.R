#list.of.packages <- c("vroom", "plyr", "stringr", "dpylr")
#new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
#print(new.packages)
#if(length(new.packages)) install.packages(new.packages,repos='http //cran.us.r-project.org')
suppressMessages(suppressWarnings(require(vroom)))
suppressMessages(suppressWarnings(require(plyr)))
suppressMessages(suppressWarnings(require(stringr)))
suppressMessages(suppressWarnings(require(dplyr)))
args <- commandArgs(trailingOnly = TRUE)
listOfFiles=list.files(pattern="_braken_report")
tableExists=FALSE
counter=1
for(x in listOfFiles){
  fileName=str_remove_all(x,"_braken_report")
  thisAbundance=read.delim(x,skip=0)
  row.names(thisAbundance)=thisAbundance[,1]
  thisAbundance=as.data.frame(thisAbundance[,6], row.names=row.names(thisAbundance))
  colnames(thisAbundance)="Final.Best.Hit.Read.Numbers"
  if(tableExists){
    combinedTable=full_join(tibble::rownames_to_column(combinedTable),
                            tibble::rownames_to_column(thisAbundance),
                            by = "rowname")
    combinedTable=as.data.frame(combinedTable[,2:(counter+1)],
                                row.names=combinedTable$rowname)
    colnames(combinedTable)[counter]=fileName
  }else{
    combinedTable=as.data.frame(thisAbundance$Final.Best.Hit.Read.Numbers, row.names = row.names(thisAbundance))
    colnames(combinedTable)=fileName
    tableExists=TRUE
  }
  counter=counter+1
}
combinedTable[is.na(combinedTable)]=0
write.table(combinedTable,file="CombinedTableAllSamples_new.txt",sep='\t',quote=FALSE,row.names = TRUE)

