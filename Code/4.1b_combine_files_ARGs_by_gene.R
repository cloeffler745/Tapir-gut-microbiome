#list.of.packages <- c("vroom", "plyr", "stringr", "dpylr")
#new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
#print(new.packages)
#if(length(new.packages)) install.packages(new.packages,repos='http //cran.us.r-project.org')
suppressMessages(suppressWarnings(require(vroom)))
suppressMessages(suppressWarnings(require(plyr)))
suppressMessages(suppressWarnings(require(stringr)))
suppressMessages(suppressWarnings(require(dplyr)))
args <- commandArgs(trailingOnly = TRUE)
listOfFiles=list.files(pattern="ResFinder_results_tab.txt",full.names=TRUE,recursive=TRUE,include.dirs=TRUE)
tableExists=FALSE
counter=1
for(x in listOfFiles){
  fileName=str_remove_all(x,"/ResFinder_results_tab.txt")
  thisAbundance=read.delim(x, sep = "\t") %>%
	  group_by(!!sym("Resistance.gene")) %>%
	  summarise(Identity = max(Identity,na.rm=TRUE)) %>%
	  ungroup() %>% 
	  as.data.frame()
  row.names(thisAbundance)=thisAbundance$`Resistance.gene`
  print(row.names(thisAbundance))
  thisAbundance=as.data.frame(thisAbundance[,2], row.names=row.names(thisAbundance))
  colnames(thisAbundance)="Identity"
  if(tableExists){
    combinedTable=full_join(tibble::rownames_to_column(combinedTable),
                            tibble::rownames_to_column(thisAbundance),
                            by = "rowname")
    combinedTable=as.data.frame(combinedTable[,2:(counter+1)],
                                row.names=combinedTable$rowname)
    colnames(combinedTable)[counter]=fileName
  }else{
    combinedTable=as.data.frame(thisAbundance$Identity, row.names = row.names(thisAbundance))
    colnames(combinedTable)=fileName
    tableExists=TRUE
  }
  counter=counter+1
}
combinedTable[is.na(combinedTable)]=0
write.table(combinedTable,file="CombinedTableAllARGs_by_gene.txt",sep='\t',quote=FALSE,row.names = TRUE)
warnings()
