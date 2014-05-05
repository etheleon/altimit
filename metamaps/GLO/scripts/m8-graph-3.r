#!/usr/bin/env Rscript
library(dplyr)

args<-commandArgs(T)
#args=c('example/outputs/m8-graph-2_output')

data=read.table(args[1], sep="\t",comment.char="",h=T)
data=data[complete.cases(data),]
data=tbl_df(data)

summary2=tbl_df(data %.%
group_by(READ) %.% 
group_by(DESIRED_RANKID) %.% 
summarise(n=n()))

summary3=ddply(summary2, "READ", function(x) setNames(melt(table(x$n)), c("glo.appearance", "count")))

data2=setNames(ddply(data, "READ", function(x) { 
data.frame(paste(sort(unique(as.integer(x$DESIRED_RANKID))), collapse="_"),length(unique(as.integer(x$DESIRED_RANKID))))
}), c("READ", "GLO","NUM"))

write.table(data2, file=args[2], quote=F, row.names=F)
