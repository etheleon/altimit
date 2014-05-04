#!/usr/bin/env Rscript
library(dplyr)

args<-commandArgs(T)
read.table(args[1], sep="\t",comment.char="")
