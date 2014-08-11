dbquery<-structure(function(#Function for querying NEO4J DB
###Takes query which gives table type output
query,	##<< Cypher Query, rmbr to escape double quotes if any 
params = FALSE, ##<< a list object. If no parameters, let params = False.
cypherurl ## The address of the graph database eg. metamaps.scelse.nus.edu.sg:7474
){

#Checks if the params is given
	if(is.list(params)){
	post = toJSON(list(query = query, params = params))
	}else{
	post = toJSON(list(query = query))
	}
	result = fromJSON(getURL(cypherurl, customrequest = "POST", httpheader = c(`Content-Type` = "application/json"), postfields = post))
	result_df = do.call(rbind,lapply(result$data, function(x) { data.frame(matrix(x,nrow=1)) }))
	}, ex=function(x){ 

output.df <- dbquery(
    query = "START ko=node:koid('ko:\"ko:K00020\"') return ko.ko,ko.definition",
    params = FALSE, 
    cypherurl = "metamaps.scelse.nus.edu.sg:7474/db/data/cypher")
})
