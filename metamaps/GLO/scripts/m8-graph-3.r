#!/usr/bin/env Rscript
library(dplyr)

args<-commandArgs(T)
#args=c('example/outputs/m8-graph-2_output')

data=read.table(args[1], sep="\t",comment.char="",h=T)
data=data[complete.cases(data),]
data=tbl_df(data)

data %.%
group_by(READ) %.% 

data2=setNames(ddply(data, "READ", function(x) { 
GLO=paste(sort(unique(as.integer(x$DESIRED_RANKID))), collapse="_")
}), c("READ", "GLO"))

write.table(data2, file=args[2], quote=F, row.names=F)
