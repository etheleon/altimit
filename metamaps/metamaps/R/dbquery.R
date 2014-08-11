dbquery<-function(
query = "START ko=node:koid('ko:\"ko:K00020\"') return ko.ko,ko.definition",
params = F, 
cypherurl = "metamaps.scelse.nus.edu.sg:7474/db/data/cypher"
){
if(is.list(params)){
post = toJSON(list(query = query, params = params))
}else{
post = toJSON(list(query = query))
}
result = fromJSON(getURL(cypherurl, customrequest = "POST", httpheader = c(`Content-Type` = "application/json"), postfields = post))
result_df = do.call(rbind,lapply(result$data, function(x) { data.frame(matrix(x,nrow=1)) }))
}



